Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AD578E241
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236715AbjH3WVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343818AbjH3WVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:21:16 -0400
X-Greylist: delayed 3553 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Aug 2023 15:20:55 PDT
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD4BD7;
        Wed, 30 Aug 2023 15:20:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4B58B8201F;
        Wed, 30 Aug 2023 20:30:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D765C433CA;
        Wed, 30 Aug 2023 20:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693427428;
        bh=naBzhvIky8R5V5XX3mGlkvV2k61SZTHNrCvojqQlDeU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=otw5gKsqhj7UlV+5SrWtGY4wxTV4EN0qiJQNgtrYTLUtrVL6FT+2KE0l9FBygwE3d
         pXd9euQ9iheFeLxPUKAy0JMLBqm94Rfha6YW6pwGXTXCoX22Q6PqzIfUdD9oIBT0go
         St2lEdowpUMBLc+yx2FsHho7GB2AaBdywuEJwg2eyeGcviOFPgmSFOzYYnhW8r/tmY
         MlPJEZ+zg4O89EzFIeZwqt5iKkHCOK2U2ugEzoEYg9t+eZ0/XGPCrXl6fvetrNKvjh
         C3GCPbZmekJtm/AbTaB+xUHCFhaoW/kxu2twdBu/qisRAr6fP5J6zwZQQeD20CiMgG
         L3GZbLgKTpmNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 76D63E4509F;
        Wed, 30 Aug 2023 20:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/3] riscv: dma-mapping: unify support for cache flushes
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169342742848.1913.1099836362504771690.git-patchwork-notify@kernel.org>
Date:   Wed, 30 Aug 2023 20:30:28 +0000
References: <20230816232336.164413-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230816232336.164413-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     linux-riscv@lists.infradead.org, arnd@arndb.de, hch@lst.de,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, conor.dooley@microchip.com,
        apatel@ventanamicro.com, ajones@ventanamicro.com,
        jszhang@kernel.org, linux-kernel@vger.kernel.org,
        geert+renesas@glider.be, samuel@sholland.org,
        linux-renesas-soc@vger.kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 17 Aug 2023 00:23:33 +0100 you wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> This patch series is a subset from Arnd's original series [0]. Ive just
> picked up the bits required for RISC-V unification of cache flushing.
> Remaining patches from the series [0] will be taken care by Arnd soon.
> 
> Cheers,
> Prabhakar
> 
> [...]

Here is the summary with links:
  - [v3,1/3] riscv: dma-mapping: only invalidate after DMA, not flush
    https://git.kernel.org/riscv/c/fbfc740ced8f
  - [v3,2/3] riscv: dma-mapping: skip invalidation before bidirectional DMA
    https://git.kernel.org/riscv/c/14be7c16d420
  - [v3,3/3] riscv: dma-mapping: switch over to generic implementation
    https://git.kernel.org/riscv/c/eb76e5111881

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


