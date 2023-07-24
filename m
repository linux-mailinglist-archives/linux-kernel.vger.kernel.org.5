Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C909D75EF46
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 11:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjGXJk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 05:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjGXJkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 05:40:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7E5E41;
        Mon, 24 Jul 2023 02:40:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D6CC6100B;
        Mon, 24 Jul 2023 09:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86463C43391;
        Mon, 24 Jul 2023 09:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690191622;
        bh=aCk3Kiy2QCtNYRS+NGG0CWQ85CV4s0YcclLSlSiBxAA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cKgs6IdjIl6fCfKMxEVhZ6czA0HE225jI06xbuiUTCN5N6KoDyK6sosXXDiJ2UP8s
         Lo1EEWUjrD4aYHqNKWvKixq3wUcqNwpi7RgaVCF0ylucH3AZNPfbO4K/BM9D6oJcwS
         BXk1DWnMYUUVWUZtgaupBO6+mpBKG/Xb4QgjRIPp6wiA/MIVPXmDRfeaPN94lbM1DG
         rpoRRK6q5MkTNW0GAxRz9robddCKaw6cRIHPr0XRR1smDLwHv/xbBlReB/t3dU8ebT
         LLtBAV+ii2VJw7SOfaSDzG0wS4/IkNl0o7apBNzGYztmnQd1jIRWLShapZMJSFstnn
         EskO9OxnG6riQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 70FEDE1F658;
        Mon, 24 Jul 2023 09:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 0/2] Add motorcomm phy pad-driver-strength-cfg support
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169019162245.19399.3902145269811670300.git-patchwork-notify@kernel.org>
Date:   Mon, 24 Jul 2023 09:40:22 +0000
References: <20230720111509.21843-1-samin.guo@starfivetech.com>
In-Reply-To: <20230720111509.21843-1-samin.guo@starfivetech.com>
To:     Guo Samin <samin.guo@starfivetech.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, pgwipeout@gmail.com,
        Frank.Sae@motor-comm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        conor@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        yanhong.wang@starfivetech.com
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

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 20 Jul 2023 19:15:07 +0800 you wrote:
> The motorcomm phy (YT8531) supports the ability to adjust the drive
> strength of the rx_clk/rx_data, and the default strength may not be
> suitable for all boards. So add configurable options to better match
> the boards.(e.g. StarFive VisionFive 2)
> 
> The first patch adds a description of dt-bingding, and the second patch adds
> YT8531's parsing and settings for pad-driver-strength-cfg.
> 
> [...]

Here is the summary with links:
  - [v5,1/2] dt-bindings: net: motorcomm: Add pad driver strength cfg
    (no matching commit)
  - [v5,2/2] net: phy: motorcomm: Add pad drive strength cfg support
    https://git.kernel.org/netdev/net-next/c/7a561e9351ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


