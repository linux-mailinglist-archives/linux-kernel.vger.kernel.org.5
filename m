Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52B57E7472
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 23:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345311AbjKIWka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 17:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjKIWk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 17:40:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E26B4206
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 14:40:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F10CC433C7;
        Thu,  9 Nov 2023 22:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699569625;
        bh=I9vnYUT5EwbBj4gKZfskPZcdeePW/vcdMZ/ipcSe6bg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OkmpxAfV/vkOZ43LqBK8zWZzCgZrjZljMxcjl4bBz2TMFbozmCFllXFXKb4fJ70d7
         wpIEWxVUTtKFF7IMmN8KtkguoU3Sp/WiJOlpxhfBNHZKdnc7+KnbK0ovs1hLWE1nIx
         2IEA4OdHIstSME9/iqrl+AOhQ1hOkN0B/7LP4H7X8CX4qW1JzdoerLynO3NkGFUOUE
         F9bYpHiXxRrKLS4IpZjnALTy4NqpWqeesRopGxKh3m4SRnVbfUZDerR60Z9CTsBmt3
         1aO6xsmrLAkEMiUC0mhWGI/YvrK2OjwCHo36ajHaRnzODdAkz7U+p+lOIVziLuSS68
         xKECwTYCWaNdg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F01F9C3274C;
        Thu,  9 Nov 2023 22:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 0/2] riscv: Optimize bitops with Zbb extension
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169956962496.25145.13807826919853509041.git-patchwork-notify@kernel.org>
Date:   Thu, 09 Nov 2023 22:40:24 +0000
References: <20231031064553.2319688-1-xiao.w.wang@intel.com>
In-Reply-To: <20231031064553.2319688-1-xiao.w.wang@intel.com>
To:     Wang@ci.codeaurora.org, Xiao W <xiao.w.wang@intel.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, ardb@kernel.org,
        anup@brainfault.org, haicheng.li@intel.com,
        ajones@ventanamicro.com, yujie.liu@intel.com, charlie@rivosinc.com,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 31 Oct 2023 14:45:51 +0800 you wrote:
> Bitops optimization with specialized instructions is common practice in
> popular ISAs, this patch set uses RISC-V Zbb extension to optimize four
> bitops: __ffs, __fls, ffs and fls.
> 
> The first patch rearranges the content in hwcap.h and cpufeature.h, it helps
> to avoid a cyclic header including issue for patch 2.
> 
> [...]

Here is the summary with links:
  - [v5,1/2] riscv: Rearrange hwcap.h and cpufeature.h
    https://git.kernel.org/riscv/c/e72c4333d2f2
  - [v5,2/2] riscv: Optimize bitops with Zbb extension
    https://git.kernel.org/riscv/c/457926b25320

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


