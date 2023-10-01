Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0067B4781
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 15:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234980AbjJANAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 09:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234976AbjJANAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 09:00:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA59AC
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 06:00:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62141C433C7;
        Sun,  1 Oct 2023 13:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696165229;
        bh=jxexDSoTCPqVD3y64QYOzbtN9SFeMaNafBFS+DFMyR4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hTtAeYBMG75O7yoDp9uzzFy4Elz+a6DzvMvLPXDljd7z7VDHFXsGOZRQfZ2vnANdj
         8hbJUbZTiwXDd4i2HxfBxaF6OotbFkjZF7YaudXVmhGdeY2pRdsviZdd25fc7zq4yM
         KI0gZwJo2X5Ls9nQRBZMR4N0Q1PPvU0Q1gg1cUbURQveFKaFCOCSR0B6M0EYrIEVaA
         HnWXhm001ECd/AuVRQNYhrUZlQUTs/50t2pW3w9tYzRvUIgfAi9+7TIG++FnB7DNSa
         EN+HV8ijbCZls8DiNrGwMR/VusbX/Q2Wx1sIKBDcbt4HbJeLFbii2r0Y6aZXBc8zh0
         NjRL9Dp90GPPQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4BE96C691EF;
        Sun,  1 Oct 2023 13:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: atl1c: switch to napi_consume_skb()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169616522930.29918.9573037295555946176.git-patchwork-notify@kernel.org>
Date:   Sun, 01 Oct 2023 13:00:29 +0000
References: <20230921005623.3768-1-liew.s.piaw@gmail.com>
In-Reply-To: <20230921005623.3768-1-liew.s.piaw@gmail.com>
To:     Sieng-Piaw Liew <liew.s.piaw@gmail.com>
Cc:     chris.snook@gmail.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 21 Sep 2023 08:56:23 +0800 you wrote:
> Switch to napi_consume_skb() to take advantage of bulk free, and skb
> reuse through skb cache in conjunction with napi_build_skb().
> 
> When parameter 'budget' = 0, indicating non-NAPI context,
> dev_consume_skb_any() is called internally.
> 
> Signed-off-by: Sieng-Piaw Liew <liew.s.piaw@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: atl1c: switch to napi_consume_skb()
    https://git.kernel.org/netdev/net-next/c/d87c59f2b00d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


