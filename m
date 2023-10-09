Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF447BD45A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 09:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345406AbjJIHcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 03:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345374AbjJIHcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 03:32:09 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13880AB
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 00:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=aiMNjsVcGqhrNnfDi/djcbfbRpTfabEPyQg6HFOpBK8=;
        t=1696836725; x=1698046325; b=LFGjMaDWY58A8JXCiiISIS5bm+7cWWbTGPhEUpfHzI0tFmr
        r5TWdGlmJWaRS13a38GSOyoe/1LU1UyMI39mKvkEraigiiS7TYfHbRL0yvlXQi+UexaAnjo/JgE0d
        WGdC+5ZztOSBXFiSfQi/wFDkkQ78n3FYDjhLVu/Pz+HofLJgUhYR3YRT6tnJZ82rKHnLOIX9l9LNq
        xLdommuTTtQ+ALSCMVZN9R+GBTUXU6V5tS1o+Fwn1ThEO1lD8k6JWCl9e7UBDc1S+ySFz95Sb6nmc
        WwwANMkjdojV9bNlJtVSXsGadAWLK4fnoBmDCBdXODm2jYdvPv0p4iZuk3qzzG/A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC0)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qpkk6-0000000F6yQ-20cA;
        Mon, 09 Oct 2023 09:31:54 +0200
Message-ID: <ff46c71a7eb6c43c9e06e99d30bdcb1f8152ee7e.camel@sipsolutions.net>
Subject: Re: [PATCH] um: vector: fix return value check in vector_mmsg_rx
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ma Ke <make_ruc2021@163.com>, richard@nod.at,
        anton.ivanov@cambridgegreys.com, xiangyang3@huawei.com
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 09 Oct 2023 09:31:53 +0200
In-Reply-To: <20231007005104.3994678-1-make_ruc2021@163.com>
References: <20231007005104.3994678-1-make_ruc2021@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-10-07 at 08:51 +0800, Ma Ke wrote:
> In vector_mmsg_rx, to avoid an unexpected result returned by
> pskb_trim, we should check the return value of pskb_trim().

And how exactly do you propose pskb_trim() will return anything but 0 in
this scenario?

Please. If you have a static checker, _think_ about it's output before
blindly sending patches.

johannes

