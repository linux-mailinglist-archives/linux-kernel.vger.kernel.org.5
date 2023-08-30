Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B71678E392
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 01:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344572AbjH3X62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 19:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjH3X61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 19:58:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D601B0;
        Wed, 30 Aug 2023 16:58:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC515B8208F;
        Wed, 30 Aug 2023 20:30:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89475C433C8;
        Wed, 30 Aug 2023 20:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693427428;
        bh=eaCfLnmA3JpQc8qy3IH4/JNwVM/ECKPd09zxvvRnje4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=r51f7mGIpgqDbBddHpKMqNotvCSAJsKBMa7QJPxcbOGiQvbKxAWe7Rj3T13B3mR4b
         a8Gkzgru/hUJJgRQzw2ZKbWjTseJ3EJiBf/Lh1/R44DOkLSXVXyjyTZAqfqZfs7Bwg
         ybM6vRUHMljQNkPbejOGv+qBKM5PaBnDHlON6F3mJ30Ttb85R53vVLcSX5B1E1e9Wq
         t+oxO7qygLjXyqrW2cqqLpQLjfBEwCYsd2L1iFkleihOFw0YsCOrhifMJPWycRexWh
         aChSNgRxV1CARDxi7v+P1Do35l1v8gdU5JT6Rnsni9HQRhJimmFgkLRKXxekQ9Pg8S
         6q5J/QMo6TS/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D7A7E26D49;
        Wed, 30 Aug 2023 20:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v12 0/6] Add non-coherent DMA support for AX45MP
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169342742844.1913.17058276691232129949.git-patchwork-notify@kernel.org>
Date:   Wed, 30 Aug 2023 20:30:28 +0000
References: <20230818135723.80612-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230818135723.80612-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     linux-riscv@lists.infradead.org, arnd@arndb.de,
        conor.dooley@microchip.com, geert+renesas@glider.be,
        guoren@kernel.org, ajones@ventanamicro.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, samuel@sholland.org, hch@infradead.org,
        emil.renner.berthing@canonical.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri, 18 Aug 2023 14:57:17 +0100 you wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Hi All,
> 
> non-coherent DMA support for AX45MP
> ====================================
> 
> [...]

Here is the summary with links:
  - [v12,1/6] riscv: asm: vendorid_list: Add Andes Technology to the vendors list
    https://git.kernel.org/riscv/c/93e0e2419b65
  - [v12,2/6] riscv: errata: Add Andes alternative ports
    https://git.kernel.org/riscv/c/f2863f30d1b0
  - [v12,3/6] riscv: mm: dma-noncoherent: nonstandard cache operations support
    https://git.kernel.org/riscv/c/30bc090f40f8
  - [v12,4/6] dt-bindings: cache: andestech,ax45mp-cache: Add DT binding documentation for L2 cache controller
    https://git.kernel.org/riscv/c/555dd72bc06e
  - [v12,5/6] cache: Add L2 cache management for Andes AX45MP RISC-V core
    https://git.kernel.org/riscv/c/f508b0175578
  - [v12,6/6] soc: renesas: Kconfig: Select the required configs for RZ/Five SoC
    https://git.kernel.org/riscv/c/ed1a8872ff83

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


