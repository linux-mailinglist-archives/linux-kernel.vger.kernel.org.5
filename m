Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA387E59BA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbjKHPKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbjKHPK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:10:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8067D1FC3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 07:10:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16A09C433CD;
        Wed,  8 Nov 2023 15:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699456224;
        bh=+q4CMZEtGo5T8fEL2Av92WTVOokwQQBXyhymHf9umrE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=b41UNZmy2S7levto+O8FCd4Vh4U9Si2Z+0j8DASbN+bcz8POhFLkSfzokKmapNm9T
         F6WR2Ul5h9V/Z6gWuSjycEMgV4yTGBwMJPcUVkhPBdKveZ6qUcgcAIqS/K8oE74gJT
         vj0xIU/AypRqUyL8A7C02fJoJ0Lq/sWgwYrlCW42qb5s1zTRamqmkrPeXAxOXOU0jI
         paSVhtpEvmhLA5Wlp0nhizR5i5X7ZdCa8GtVsrncz7D/nTcyLgvUjjc0eI4RrXYmk5
         9XsjxRt+RR9K+5SCzt5T1sRj6numRQKNmdOJAa4vFLNX893xBIUx4PgV9ZocL86usm
         Fow7lHkx2Qvew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E8903E00088;
        Wed,  8 Nov 2023 15:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] RISC-V: Probe misaligned access speed in parallel
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169945622394.21527.3124390235718223224.git-patchwork-notify@kernel.org>
Date:   Wed, 08 Nov 2023 15:10:23 +0000
References: <20231106225855.3121724-1-evan@rivosinc.com>
In-Reply-To: <20231106225855.3121724-1-evan@rivosinc.com>
To:     Evan Green <evan@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, palmer@rivosinc.com,
        apatel@ventanamicro.com, aou@eecs.berkeley.edu, heiko@sntech.de,
        leyfoon.tan@starfivetech.com, maz@kernel.org,
        bigeasy@linutronix.de, paul.walmsley@sifive.com,
        linux-kernel@vger.kernel.org, conor.dooley@microchip.com,
        David.Laight@aculab.com, palmer@dabbelt.com, jszhang@kernel.org,
        greentime.hu@sifive.com, cleger@rivosinc.com,
        ajones@ventanamicro.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon,  6 Nov 2023 14:58:55 -0800 you wrote:
> Probing for misaligned access speed takes about 0.06 seconds. On a
> system with 64 cores, doing this in smp_callin() means it's done
> serially, extending boot time by 3.8 seconds. That's a lot of boot time.
> 
> Instead of measuring each CPU serially, let's do the measurements on
> all CPUs in parallel. If we disable preemption on all CPUs, the
> jiffies stop ticking, so we can do this in stages of 1) everybody
> except core 0, then 2) core 0. The allocations are all done outside of
> on_each_cpu() to avoid calling alloc_pages() with interrupts disabled.
> 
> [...]

Here is the summary with links:
  - [v3] RISC-V: Probe misaligned access speed in parallel
    https://git.kernel.org/riscv/c/55e0bf49a0d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


