Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3A4801E59
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 20:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjLBTaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 14:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLBTaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 14:30:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C15F11A
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 11:30:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0B97C433C9;
        Sat,  2 Dec 2023 19:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701545423;
        bh=7oFK4ed8T89dSsjywyHK5bLa86wuR3jqGdVIRyazGRM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OByKiWl8mrA9qDMq2PnkK3QXm7Zf0APYeujzi39JI+0XvTsnJUMUdZV05U3GHlpfM
         8OLPuk0nNkacJ/0eeL9vJIwugxN5Fc0Y4e6Dn6peCyAsQMWtD2uy/9haQWTzUvFep5
         6z21zwbdifl11u4Uf81TC6iQP9NpJyKjwv2mZTeMRRoh1JVtKZsc8Uk62T6KgzNPdX
         xSFRgJLKbwBQkHFujUTi0jaVnyBsGYxTHpEzJjAoq96Ya7VA15L0qXSaqHfM+wRSWk
         Pg6F8qPG/DLJaL64DXarnqxoDdYx2/NkDeqFfC/MAdgnopznJGjLC4vBviWdn73B4U
         iiGA4fR1EJsuA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7FD73C59A4C;
        Sat,  2 Dec 2023 19:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] r8169: fix rtl8125b PAUSE frames blasting when
 suspended
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170154542352.15478.16376698686118479482.git-patchwork-notify@kernel.org>
Date:   Sat, 02 Dec 2023 19:30:23 +0000
References: <20231129155350.5843-1-hau@realtek.com>
In-Reply-To: <20231129155350.5843-1-hau@realtek.com>
To:     ChunHao Lin <hau@realtek.com>
Cc:     hkallweit1@gmail.com, nic_swsd@realtek.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        grundler@chromium.org, stable@vger.kernel.org
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

On Wed, 29 Nov 2023 23:53:50 +0800 you wrote:
> When FIFO reaches near full state, device will issue pause frame.
> If pause slot is enabled(set to 1), in this time, device will issue
> pause frame only once. But if pause slot is disabled(set to 0), device
> will keep sending pause frames until FIFO reaches near empty state.
> 
> When pause slot is disabled, if there is no one to handle receive
> packets, device FIFO will reach near full state and keep sending
> pause frames. That will impact entire local area network.
> 
> [...]

Here is the summary with links:
  - [net,v2] r8169: fix rtl8125b PAUSE frames blasting when suspended
    https://git.kernel.org/netdev/net/c/4b0768b6556a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


