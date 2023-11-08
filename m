Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBFC7E5C46
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 18:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjKHRU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 12:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjKHRU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 12:20:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E2F1BC3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 09:20:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D62EDC433C9;
        Wed,  8 Nov 2023 17:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699464024;
        bh=prYzLaZu06WtQmNg4/UT6PWTH9U6sgDBvBDcv1Ulv/8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=JvZes0SyVw4VZJlD4zFojOe2NBOedMICGWUUbV7VYo4k58CokiZWkkcipReuSdsNn
         VKlEcNHWaR+GOLRUs3gGoFR3tmk7uhJACdbJHYkKvKs17gnNNkBAhm88MjiFJzvZed
         kF1jaHgGTAqgRHWq71DYq8Ougef2P5sR/Wcd2mi6m+Y7NkQLZDPQIoSTN9DggqhQ3z
         PunUnQuLe+KIozqk1SvZQsioWbgX3LoVNI/hbXmNJMJhj2EGfCI2Tu3EazDtQRBI6F
         PbYUuPW+3uwX8Wr2Q6N+Ov2TOIlyOC0uD3nakVfFff5T12qDGt09EJyAn4MXwO6IIM
         oOuA3gSJxuLHA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BBA39E00086;
        Wed,  8 Nov 2023 17:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND v2 0/2] riscv: Fix set_memory_XX() and
 set_direct_map_XX()
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169946402476.8523.11934307334970092099.git-patchwork-notify@kernel.org>
Date:   Wed, 08 Nov 2023 17:20:24 +0000
References: <20231108075930.7157-1-alexghiti@rivosinc.com>
In-Reply-To: <20231108075930.7157-1-alexghiti@rivosinc.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, rppt@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed,  8 Nov 2023 08:59:28 +0100 you wrote:
> Those 2 patches fix the set_memory_XX() and set_direct_map_XX() APIs, which
> in turn fix STRICT_KERNEL_RWX and memfd_secret(). Those were broken since the
> permission changes were not applied to the linear mapping because the linear
> mapping is mapped using hugepages and walk_page_range_novma() does not split
> such mappings.
> 
> To fix that, patch 1 disables PGD mappings in the linear mapping as it is
> hard to propagate changes at this level in *all* the page tables, this has the
> downside of disabling PMD mapping for sv32 and PUD (1GB) mapping for sv39 in
> the linear mapping (for specific kernels, we could add a Kconfig to enable
> ARCH_HAS_SET_DIRECT_MAP and STRICT_KERNEL_RWX if needed, I'm pretty sure we'll
> discuss that).
> 
> [...]

Here is the summary with links:
  - [RESEND,v2,1/2] riscv: Don't use PGD entries for the linear mapping
    https://git.kernel.org/riscv/c/629db01c64ff
  - [RESEND,v2,2/2] riscv: Fix set_memory_XX() and set_direct_map_XX() by splitting huge linear mappings
    https://git.kernel.org/riscv/c/311cd2f6e253

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


