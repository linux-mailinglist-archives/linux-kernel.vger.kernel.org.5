Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387FA7E3560
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 07:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbjKGGup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 01:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbjKGGue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 01:50:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6900E11A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 22:50:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E211FC433CC;
        Tue,  7 Nov 2023 06:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699339826;
        bh=+cTlWJxTAf872aDvdexyZnpvcYSn14wI9GuK2A/2+GQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=byAIYpNEkPlqwWpI6oNdRkOvONsD7yqV9Y5qKdaH5gDE3bmkwyqoMUkO5B+FWJOYG
         o/Yk1nwq0gqWymAaXcIeqQFcg1/R9dr1OsCqXJWouRMSGm0ZZIC9PPD67RU8DJgS7S
         ZQHmp5a4PVg2kkZjGlD5btd9Cd1C7PonHGPOKczkuagSOqKZ45erDm1VhZRtNGXRoI
         2qK/SVM8g7TDIOXm9OxtP8bY1R6d+SRXoRnZRJQFCjHSqKiAGu4KMxcpUJQUOlpiqV
         5lgFYIOezQ3s08/P7Sqs7bkUbYrke4CZnezo944UxXoRbHMIo5TZeYfBe/H+0y3NLu
         ySaaLBRYFCcGQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CA204E00089;
        Tue,  7 Nov 2023 06:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 00/11] riscv: ASID-related and UP-related TLB flush
 enhancements
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169933982682.6233.11600132793189977124.git-patchwork-notify@kernel.org>
Date:   Tue, 07 Nov 2023 06:50:26 +0000
References: <20231028231339.3116618-1-samuel.holland@sifive.com>
In-Reply-To: <20231028231339.3116618-1-samuel.holland@sifive.com>
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        alexghiti@rivosinc.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
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

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sat, 28 Oct 2023 16:11:58 -0700 you wrote:
> While reviewing Alexandre Ghiti's "riscv: tlb flush improvements"
> series[1], I noticed that most TLB flush functions end up as a call to
> local_flush_tlb_all() when SMP is disabled. This series resolves that.
> Along the way, I realized that we should be using single-ASID flushes
> wherever possible, so I implemented that as well.
> 
> [1]: https://lore.kernel.org/linux-riscv/20231019140151.21629-1-alexghiti@rivosinc.com/
> 
> [...]

Here is the summary with links:
  - [v2,01/11] riscv: Improve tlb_flush()
    https://git.kernel.org/riscv/c/c5e9b2c2ae82
  - [v2,02/11] riscv: Improve flush_tlb_range() for hugetlb pages
    https://git.kernel.org/riscv/c/c962a6e74639
  - [v2,03/11] riscv: Make __flush_tlb_range() loop over pte instead of flushing the whole tlb
    https://git.kernel.org/riscv/c/9d4e8d5fa7db
  - [v2,04/11] riscv: Improve flush_tlb_kernel_range()
    https://git.kernel.org/riscv/c/5e22bfd520ea
  - [v2,05/11] riscv: mm: Combine the SMP and UP TLB flush code
    (no matching commit)
  - [v2,06/11] riscv: Apply SiFive CIP-1200 workaround to single-ASID sfence.vma
    (no matching commit)
  - [v2,07/11] riscv: mm: Introduce cntx2asid/cntx2version helper macros
    (no matching commit)
  - [v2,08/11] riscv: mm: Use a fixed layout for the MM context ID
    (no matching commit)
  - [v2,09/11] riscv: mm: Make asid_bits a local variable
    (no matching commit)
  - [v2,10/11] riscv: mm: Preserve global TLB entries when switching contexts
    (no matching commit)
  - [v2,11/11] riscv: mm: Always use ASID to flush MM contexts
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


