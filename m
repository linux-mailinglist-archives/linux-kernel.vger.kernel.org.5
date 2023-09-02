Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA48C790491
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 02:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351458AbjIBA5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 20:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240134AbjIBA5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 20:57:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7A5E7E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 17:57:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73C7761A15
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 00:57:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859CEC433C7;
        Sat,  2 Sep 2023 00:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693616235;
        bh=1xCsTHQgCtxwTmVpSfoTaVc70IJpszkoKVnt2d+dZgk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QS/Kn2C2UGjoX0KyDnbGKRnuQZKuAta6+Jybnv1pYRaP6MMbESi6aIlUc/d6vyQws
         DjTVTCCw0RwW30COkODW4OseV9BACnRX1M0rO1RXTPdWq9cN7WeHILL8zQPBl6qe85
         eo3hLFJKAa39MfmyrPelFQr3getUQDPrVICCeXIUOoKmUaF4UV6cZ+vRWeMzWvSau9
         2z+4X2pfyCMfV+tQawgTAcfi3FQlCs0Mon/cijWhWJ7QwwCUQHo8wUSm157zPQ4lPp
         mkn5CpXstH7xkwt0p26jdbTcX44DmudNVheYJekOz1sPSquPM3deSgpdIyZmURD6st
         uKgxcNVJjMLsg==
Date:   Fri, 1 Sep 2023 17:57:14 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Li zeming <zeming@nfschina.com>
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/socket: Remove unnecessary =?UTF-8?B?4oCYMOKAmQ==?=
 values from used
Message-ID: <20230901175714.1f2826bb@kernel.org>
In-Reply-To: <20230902182228.3124-1-zeming@nfschina.com>
References: <20230902182228.3124-1-zeming@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  3 Sep 2023 02:22:28 +0800 Li zeming wrote:
> used is assigned first, so it does not need to initialize the
> assignment.

It's a perfectly legitimate code pattern.
Please do not post any such patches to networking.

Please make sure you have read this:
https://docs.kernel.org/process/researcher-guidelines.html
-- 
pw-bot: reject
