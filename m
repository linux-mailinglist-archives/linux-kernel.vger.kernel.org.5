Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7D47C819B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjJMJMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjJMJME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:12:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759741FC6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 02:10:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E656CC433C7;
        Fri, 13 Oct 2023 09:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697188231;
        bh=B8lYkA1kPamuqAf5eh8eQ0KJkd4Qj0W/oYKqHpLM10Q=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bHv9mnG3XUJr463BvJ1+jdjLVK2KXDQKvB0jw9VicIhuPc0BJOmJLt5pSO6YvgCpR
         G5oouGWKurnNaZmQTd4wke7jMEDpETGR/io383U4XeydOGjj/xVERft15H9whGPwl9
         Ml2ibLnKTarUPMMK92uXu9IIblZkzQJVp07uLE5SLR76s+7Lk7ownFt/8O3dxWiiw7
         pHPiLjIQytfayvkTJYMS0h9hOx6ZMQncuu2M29zV8fOlgRzL3sNwA7GQrylh/oP799
         TzvUXZ5Bz7SRERoF7xC0TrN3DU2iJuxPXHecAUP9/TTYQAeuTQ7dym+Fn3XoUKPdnk
         G5X8QetVbl5wA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CA988E1F66B;
        Fri, 13 Oct 2023 09:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: dwmac-stm32: refactor clock config
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169718823082.32613.17417632202490226710.git-patchwork-notify@kernel.org>
Date:   Fri, 13 Oct 2023 09:10:30 +0000
References: <20231009145904.3776703-1-ben.wolsieffer@hefring.com>
In-Reply-To: <20231009145904.3776703-1-ben.wolsieffer@hefring.com>
To:     Ben Wolsieffer <ben.wolsieffer@hefring.com>
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
        christophe.roullier@st.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  9 Oct 2023 10:59:04 -0400 you wrote:
> Currently, clock configuration is spread throughout the driver and
> partially duplicated for the STM32MP1 and STM32 MCU variants. This makes
> it difficult to keep track of which clocks need to be enabled or disabled
> in various scenarios.
> 
> This patch adds symmetric stm32_dwmac_clk_enable/disable() functions
> that handle all clock configuration, including quirks required while
> suspending or resuming. syscfg_clk and clk_eth_ck are not present on
> STM32 MCUs, but it is fine to try to configure them anyway since NULL
> clocks are ignored.
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: dwmac-stm32: refactor clock config
    https://git.kernel.org/netdev/net-next/c/4d177f499665

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


