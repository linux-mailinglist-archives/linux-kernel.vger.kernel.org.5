Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B469B75334D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 09:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbjGNHke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 03:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234831AbjGNHkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 03:40:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C72B2D77
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 00:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A819961C41
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 07:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0BCEBC433CA;
        Fri, 14 Jul 2023 07:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689320421;
        bh=f2yLQE1A0dXJnk7tOIQ7vV4LGA9H6uo+c2tN/Z6XpX8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=pikbRO9E07MhSIi+CZyFrECYQ0BZbmiyZTwxq6+ajXwe6RQSc/aaalIIA3F5X90pM
         DGhxWlS5h8qkABYnTWhlrsFop/w5ZPtSz+NWTtabU3gcmXZTLgQzFnyh79AIQe3aq/
         Vo1lNC5GosfhP/wiBUvhGR9I8YmhDjLzbSo5eOXyLfQbcVBz45NLNegdysswEuk5cd
         saDF9/A75/cgHSWHnxkguFrC/gQN9E+lTwsAVHPXxjQ5iHl4uGh4WN6HBgsNDuBYlP
         tVtrVy5s6KMEnE6MRWs6pVYa8Wa/fKN5j/CfGRTD5xExBv9wPQYFCMK7zOrM/WwQcv
         d994PuFeNmZbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DD13FF83709;
        Fri, 14 Jul 2023 07:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ethernet: ti: cpsw_ale: Fix
 cpsw_ale_get_field()/cpsw_ale_set_field()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168932042089.7517.7146356446111190841.git-patchwork-notify@kernel.org>
Date:   Fri, 14 Jul 2023 07:40:20 +0000
References: <20230712110657.1282499-1-s-vadapalli@ti.com>
In-Reply-To: <20230712110657.1282499-1-s-vadapalli@ti.com>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, rogerq@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srk@ti.com
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

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 12 Jul 2023 16:36:57 +0530 you wrote:
> From: Tanmay Patil <t-patil@ti.com>
> 
> CPSW ALE has 75 bit ALE entries which are stored within three 32 bit words.
> The cpsw_ale_get_field() and cpsw_ale_set_field() functions assume that the
> field will be strictly contained within one word. However, this is not
> guaranteed to be the case and it is possible for ALE field entries to span
> across up to two words at the most.
> 
> [...]

Here is the summary with links:
  - [net] net: ethernet: ti: cpsw_ale: Fix cpsw_ale_get_field()/cpsw_ale_set_field()
    https://git.kernel.org/netdev/net/c/b685f1a58956

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


