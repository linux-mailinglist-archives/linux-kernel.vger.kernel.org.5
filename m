Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F0D7933DC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 04:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240595AbjIFCuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 22:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236712AbjIFCue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 22:50:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CFDCEF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 19:50:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A95FDC433CC;
        Wed,  6 Sep 2023 02:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693968627;
        bh=ILSvwMruJUXo2rVVy7tXKVYMGbWXBmCSzIYmdJYWvVM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=E4kmgfxza+9BtJJ894gdA6dh04H5baGcytpaFT8cftFVz9dSAYkyfh1A2AJ+JXhAe
         CnrRuDFFHGydGwc5JqeZBmgOlyaNaMTIIlw858GCMC8aaApsgDJQZdE2SL5eSVkile
         wqCXurAPNs1t/LPXby0pGCUktG0+BQRpCaO81jACJecvVTgrZvDD/gSk92WrL7YTA5
         cMzHOfZvDx8AY7IYLm9XERIxAeDgV1LJi5Wiw28/zoqGW11W9ENKdpshT74k0tNQXf
         m8KU5VxmMFL5POkupU4qOnIZcOf9VZdXPqgCNbnBE9oWfL6+7BJKIYP7adz4nihLBL
         dkVzsKJmqtUFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8D667C64457;
        Wed,  6 Sep 2023 02:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Kconfig: Select DMA_DIRECT_REMAP only if MMU is
 enabled
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169396862757.1987.12974306304797774698.git-patchwork-notify@kernel.org>
Date:   Wed, 06 Sep 2023 02:50:27 +0000
References: <20230901105111.311200-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230901105111.311200-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        conor.dooley@microchip.com, geert+renesas@glider.be,
        linux-kernel@vger.kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com
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

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri,  1 Sep 2023 11:51:11 +0100 you wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> kernel/dma/mapping.c has its use of pgprot_dmacoherent() inside
> an #ifdef CONFIG_MMU block. kernel/dma/pool.c has its use of
> pgprot_dmacoherent() inside an #ifdef CONFIG_DMA_DIRECT_REMAP block.
> So select DMA_DIRECT_REMAP only if MMU is enabled for RISCV_DMA_NONCOHERENT
> config.
> 
> [...]

Here is the summary with links:
  - riscv: Kconfig: Select DMA_DIRECT_REMAP only if MMU is enabled
    https://git.kernel.org/riscv/c/5bf68a586ff4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


