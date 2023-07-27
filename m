Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D934B7644D1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 06:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjG0EU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 00:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjG0EUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 00:20:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EA02704
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 21:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BDF861D1B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 04:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5D59C433C9;
        Thu, 27 Jul 2023 04:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690431621;
        bh=kmrgbL02FaDClyznM2zA9yizf4QNB2ZDh1YoZC6S9DQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=uiQ+UM2GmXOg1rTuUUhJiTLYmqvrXJDRZ2cy+2G93UhlZzy6d50DTbmF9RvYD3ejC
         7TosOtS92a5aOjA2DQjGnDGlLvZ88tnz10fRDvk9tOu9cPurtARlLmRMQ1rsTflbf+
         R5k8aDNQmEk3KH7Njr6FsHLaXAi//sM/ug5PbFYTh1eYxNphV8OrtIHv7qhfJqz1T5
         6mguYo+NYI1MduL5IRyINA9QR+zrCgBoO1YL2yTC+3mgJeGooA5wYmj/FUXf2s1kEJ
         du/cOb/PFIqz63/IfrSIcmoa6iWrKvV0temfIdEVPNuvCIigMRDutojvObtig1EqnD
         ffzszGV4PFjWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CCA30C41672;
        Thu, 27 Jul 2023 04:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: fec: tx processing does not call XDP APIs if budget
 is 0
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169043162083.26911.10210581447548929941.git-patchwork-notify@kernel.org>
Date:   Thu, 27 Jul 2023 04:20:20 +0000
References: <20230725074148.2936402-1-wei.fang@nxp.com>
In-Reply-To: <20230725074148.2936402-1-wei.fang@nxp.com>
To:     Wei Fang <wei.fang@nxp.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        shenwei.wang@nxp.com, xiaoning.wang@nxp.com, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Jul 2023 15:41:48 +0800 you wrote:
> According to the clarification [1] in the latest napi.rst, the tx
> processing cannot call any XDP (or page pool) APIs if the "budget"
> is 0. Because NAPI is called with the budget of 0 (such as netpoll)
> indicates we may be in an IRQ context, however, we cannot use the
> page pool from IRQ context.
> 
> [1] https://lore.kernel.org/all/20230720161323.2025379-1-kuba@kernel.org/
> 
> [...]

Here is the summary with links:
  - [net] net: fec: tx processing does not call XDP APIs if budget is 0
    https://git.kernel.org/netdev/net/c/15cec633fc7b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


