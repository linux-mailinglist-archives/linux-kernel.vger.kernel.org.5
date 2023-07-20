Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87BB75A4F0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 06:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjGTEA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 00:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjGTEAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 00:00:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAF21FFE
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 21:00:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDBE861349
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 04:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 285EFC433C8;
        Thu, 20 Jul 2023 04:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689825622;
        bh=WW61fEJn5ley9K1VeZE4qAk6gC7/D9WN6n2QMTISo2g=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KTGTYZoyh9kkafvx22Qw427otTcIOaectoEDbiZ2/mYm0sPOlXxJG5vANVMpoqr8s
         Z/UjtLwfkJskzJy6gy1OWJzgRZmdp4PT+hVkkuRAja1HAxiuc1Tm0BNNYKU3WVzHOo
         aNf4MalOznHSDao2pNIYBCUuXHOseG5YvbFPiHH7ADowczq3U1UyzmLdTdNSWTV45G
         ZKybTABsCKsYcSLjE5M25ra3D+tLZHmCKXT+8GJdHvZpxyb1/blb7ZS4/5uNNJwj5Z
         JkAOmG62hmAwhQDGhLw0qUIa7CKB94kJR8/eIn7dlvK/spCDJMj2ZL8HRTO77IfvKE
         4ncWc1uPV2LIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 025C2E22AE2;
        Thu, 20 Jul 2023 04:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/2] net: stmmac: improve driver statistics
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168982562200.4243.13225573648147427598.git-patchwork-notify@kernel.org>
Date:   Thu, 20 Jul 2023 04:00:22 +0000
References: <20230717160630.1892-1-jszhang@kernel.org>
In-Reply-To: <20230717160630.1892-1-jszhang@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
        wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Jul 2023 00:06:28 +0800 you wrote:
> improve the stmmac driver statistics:
> 
> 1. don't clear network driver statistics in .ndo_close() and
> .ndo_open() cycle
> 2. avoid some network driver statistics overflow on 32 bit platforms
> 3. use per-queue statistics where necessary to remove frequent
> cacheline ping pongs.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/2] net: stmmac: don't clear network statistics in .ndo_open()
    https://git.kernel.org/netdev/net-next/c/2eb85b750512
  - [net-next,v5,2/2] net: stmmac: use per-queue 64 bit statistics where necessary
    https://git.kernel.org/netdev/net-next/c/133466c3bbe1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


