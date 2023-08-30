Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7EDD78DA75
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbjH3SgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244554AbjH3NUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:20:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186601AE
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:20:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5ED9961C3A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:20:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2C51C433CA;
        Wed, 30 Aug 2023 13:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693401634;
        bh=CJBJ2HCdIV23BWEwO+d38KcZ6JefgcQDI6BR3xU4VoU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=T3ICMT9Or6XLc2djfkBLwb8a8KothXh8yCKem9PNWTvsVBHojItKJXqGS7RT/vhJH
         YJ1LQNAYtqeOoQDg5wo7dvLHFArDvh3cCikEd/tYHiIm1HPrLZSYXiYO7Ygp6uIxBc
         xYo53fzyvqs9zYfoOxoLXnNdmRwDIEmJPbDcEKrLzijFwdzwisoUvoROT87ytHIH2y
         mxyg6kS/BVLMES/D0gbmY+/93QYFU4/1JOJm4CKtOhHW2ql89T6E9Ogpvyl8Y2U0OZ
         ZEACKVKN0rv/otxJw2C7DpXIfZX37nQMTur6yazgtukoYukst4l5DqW7dF/2GMw5zY
         vgKReZJ90DbyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 88292E29F3D;
        Wed, 30 Aug 2023 13:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/6] riscv: KCFI support
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169340163454.19859.5631159121933404323.git-patchwork-notify@kernel.org>
Date:   Wed, 30 Aug 2023 13:20:34 +0000
References: <20230710183544.999540-8-samitolvanen@google.com>
In-Reply-To: <20230710183544.999540-8-samitolvanen@google.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, keescook@chromium.org,
        nathan@kernel.org, ndesaulniers@google.com,
        conor.dooley@microchip.com, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 10 Jul 2023 18:35:45 +0000 you wrote:
> This series adds KCFI support for RISC-V. KCFI is a fine-grained
> forward-edge control-flow integrity scheme supported in Clang >=16,
> which ensures indirect calls in instrumented code can only branch to
> functions whose type matches the function pointer type, thus making
> code reuse attacks more difficult.
> 
> Patch 1 implements a pt_regs based syscall wrapper to address
> function pointer type mismatches in syscall handling. Patches 2 and 3
> annotate indirectly called assembly functions with CFI types. Patch 4
> implements error handling for indirect call checks. Patch 5 disables
> CFI for arch/riscv/purgatory. Patch 6 finally allows CONFIG_CFI_CLANG
> to be enabled for RISC-V.
> 
> [...]

Here is the summary with links:
  - [v2,1/6] riscv: Implement syscall wrappers
    https://git.kernel.org/riscv/c/08d0ce30e0e4
  - [v2,2/6] riscv: Add types to indirectly called assembly functions
    https://git.kernel.org/riscv/c/5f59c6855bad
  - [v2,3/6] riscv: Add ftrace_stub_graph
    https://git.kernel.org/riscv/c/f3a0c23f2539
  - [v2,4/6] riscv: Add CFI error handling
    https://git.kernel.org/riscv/c/af0ead42f693
  - [v2,5/6] riscv/purgatory: Disable CFI
    https://git.kernel.org/riscv/c/a72ab0361110
  - [v2,6/6] riscv: Allow CONFIG_CFI_CLANG to be selected
    https://git.kernel.org/riscv/c/74f8fc31feb4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


