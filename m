Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A010F7E59B8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjKHPK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbjKHPK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:10:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534401BFA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 07:10:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3EDDC433CB;
        Wed,  8 Nov 2023 15:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699456224;
        bh=C/DziRIHGly0hzyXBjvR83dpdc5msI2/7d6N6DBgPFM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=u45mpJzUveoEKJRCvgNvyEs4l8ENyIuLOplGFiEcX1K07VGWlpm2yPp9p4eg/nrX0
         CYi5FMX7MRM7zF8s+rDsWLGcaBDVtUZB0YM5EW+Js+5qpoVmuUv4K5E3yPAt2tTuXW
         FEgG3+UAqgLT80O2RJXZf8EwUs6kTWKfyL4coCdLjKxfpLQ20sdmzDBmL9asOfrXOq
         ZX72v9eanVnxVQgdhhu3xqnL4o/PiNVTuPtaoayPesmX5DPmJEGZ2lGbEbuVnmENvT
         O8d/Uj4KPI6jlZgvlup51XfiFijGK1+a7reeiKYWfU7yu3slIT4t2uLHdh/dLlbgQO
         qkX0MK5zTU0Ug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DAB7FE00084;
        Wed,  8 Nov 2023 15:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] RISC-V: Remove __init on unaligned_emulation_finish()
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169945622388.21527.8406137134389161734.git-patchwork-notify@kernel.org>
Date:   Wed, 08 Nov 2023 15:10:23 +0000
References: <20231106231105.3141413-1-evan@rivosinc.com>
In-Reply-To: <20231106231105.3141413-1-evan@rivosinc.com>
To:     Evan Green <evan@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, palmer@rivosinc.com,
        cleger@rivosinc.com, aou@eecs.berkeley.edu, bjorn@rivosinc.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon,  6 Nov 2023 15:11:05 -0800 you wrote:
> This function shouldn't be __init, since it's called during hotplug. The
> warning says it well enough:
> 
> WARNING: modpost: vmlinux: section mismatch in reference:
> check_unaligned_access_all_cpus+0x13a (section: .text) ->
> unaligned_emulation_finish (section: .init.text)
> 
> [...]

Here is the summary with links:
  - RISC-V: Remove __init on unaligned_emulation_finish()
    https://git.kernel.org/riscv/c/6eb7a6445b76

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


