Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F512807411
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379416AbjLFPze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442573AbjLFPzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:55:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A375D41
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 07:55:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF43C433C8;
        Wed,  6 Dec 2023 15:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701878131;
        bh=r2YsCivF9Cppc6KHcqLTRG8cjx3g+qvqtil1NCQPhe0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sA6PY1R4681rZkqWfjHhdZMPOuaiWPF6f/HLgLGjwLeQz0L5N/LbBO43INJJZf5fc
         5IZLRnhfCTWKeD9DfWDyaJxx5y28Az6yuJADfKoinB1Z+3mxbsdFwr/ztyACUMjQV9
         NwGA2FOBpB6lBQsORWZWyunUhxbOkLnO/hqC15BkU2vR/FJY5j2p9oBiMlFU1w3l8P
         ITmidrFnBHENjrNCb+gexXwcwFadXG+Vc0pSFAgDuIcOiBNQslRmUxxxKOwMwbOM7r
         jSQ9LdSQv177zffhkv9wfpSzuY0JDIVaYXtD/alQIXIwydtxPMlUfMKkNglDS6P+rc
         fgrWXGoAaz8BQ==
Date:   Wed, 6 Dec 2023 07:55:29 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Huw Davies <huw@codeweavers.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH net v2] calipso: Fix memory leak in
 netlbl_calipso_add_pass()
Message-ID: <20231206075529.769270f2@kernel.org>
In-Reply-To: <CAHC9VhTEREuTymgMW8zmQcRZCOpW8M0MZPcKto17ve5Aw1_2gg@mail.gmail.com>
References: <20231123092314.91299-1-Ilia.Gavrilov@infotecs.ru>
        <CAHC9VhQGX_22WTdZG4+K8WYQK-G21j8NM9Wy0TodgPAZk57TCQ@mail.gmail.com>
        <CAHC9VhTEREuTymgMW8zmQcRZCOpW8M0MZPcKto17ve5Aw1_2gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2023 16:31:20 -0500 Paul Moore wrote:
> A quick follow-up to see if this patch was picked up by the networking
> folks?  I didn't get a patchwork notification, and I don't see it in
> Linus' tree, but perhaps I missed something?

Oops. Feel free to take it via your tree.
