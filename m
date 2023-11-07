Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721077E355F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 07:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbjKGGum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 01:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjKGGue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 01:50:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6911011C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 22:50:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1B84C433CA;
        Tue,  7 Nov 2023 06:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699339827;
        bh=XYdFuNDBExD8UovptnoGzsnJmhjZb5HPyGAlNA7VRFs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=RM/Y3x2uDPkwGkbiEr/Z5tP/zDbfQNPEM4x8GHdHCm7jHiAS65pJs9yvvsaMjdC0c
         YNk/TW2EQXD/6LPMXg3JWfU0XF9p5LAPuLqVgGUOqY9DFuvhpbshutSLKkApFYWEYM
         UaC4UiX9dtkKk7QFUYbTVOFcFVZ0l0TQ+Y9Vqip5FORKR3P0HHKxKi0w2N23W6DyAV
         u+lOkIDk1+v+z5w2l20/tL/7/M/JHx1zvlITikmxPF8+Y/JHHsATBsXI3AFYWkBmQz
         hfGstvuwYufviRNhQ/Tx4xEMhlB3D7HrnQGRHzzqhzXONPlNPVqf4YTLLo2O84hIvA
         fz+LwQFxHiqaA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C0C8BE00094;
        Tue,  7 Nov 2023 06:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: boot: Fix creation of loader.bin
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169933982678.6233.916131299923687483.git-patchwork-notify@kernel.org>
Date:   Tue, 07 Nov 2023 06:50:26 +0000
References: <1086025809583809538dfecaa899892218f44e7e.1698159066.git.geert+renesas@glider.be>
In-Reply-To: <1086025809583809538dfecaa899892218f44e7e.1698159066.git.geert+renesas@glider.be>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, jszhang@kernel.org,
        alexghiti@rivosinc.com, dlemoal@kernel.org,
        songshuaishuai@tinylab.org, linux-kernel@vger.kernel.org
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

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 24 Oct 2023 16:53:18 +0200 you wrote:
> When flashing loader.bin for K210 using kflash:
> 
>     [ERROR] This is an ELF file and cannot be programmed to flash directly: arch/riscv/boot/loader.bin
> 
> Before, loader.bin relied on "OBJCOPYFLAGS := -O binary" in the main
> RISC-V Makefile to create a boot image with the right format.  With this
> removed, the image is now created in the wrong (ELF) format.
> 
> [...]

Here is the summary with links:
  - riscv: boot: Fix creation of loader.bin
    https://git.kernel.org/riscv/c/57a4542cb7c9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


