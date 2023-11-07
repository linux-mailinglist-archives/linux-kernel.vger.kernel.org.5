Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37177E355E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 07:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbjKGGuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 01:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjKGGue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 01:50:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691D211D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 22:50:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC18DC433CB;
        Tue,  7 Nov 2023 06:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699339827;
        bh=qbNyvpCu834BElj57LNyccltMncgWk9IvDmnQ9vJRjA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=shl5AXMxRxwe5t1DNYT7WfQcfWTp5KXYl8lVkW14F07S/gYNH/2CKdgrecwJ5Ubce
         T442EIVmb7yPMI2N5NuWUX/vqUZPdERJ9THQS6pQDDw7eT1Lp8bFqMoPOxnNdB/P4U
         zOlRRTkE7WyE1eCkgBPLRSqc50K8KsFAmRNiL9+YWNM9Ee6pKf9f8YDBTmnFiC5G6N
         mU++k62dTUiOKWDbzidfpie3V1bk4VkGFj8rLfEIiJuqMeCcHEOysn8gROq8ZoICEg
         n5kMpGZQKLF9dxmu96ON3yGEmxpDXXelk/6/MxS4y7nfjyfEQ+1TcEJnok4uNXZHuw
         Xh1oEWun9T2dg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1506E00096;
        Tue,  7 Nov 2023 06:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 0/4] riscv: tlb flush improvements
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169933982685.6233.4393621260958877500.git-patchwork-notify@kernel.org>
Date:   Tue, 07 Nov 2023 06:50:26 +0000
References: <20231030133027.19542-1-alexghiti@rivosinc.com>
In-Reply-To: <20231030133027.19542-1-alexghiti@rivosinc.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, will@kernel.org,
        aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org,
        npiggin@gmail.com, peterz@infradead.org, mchitale@ventanamicro.com,
        vincent.chen@sifive.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, samuel@sholland.org,
        prabhakar.csengg@gmail.com
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

On Mon, 30 Oct 2023 14:30:24 +0100 you wrote:
> This series optimizes the tlb flushes on riscv which used to simply
> flush the whole tlb whatever the size of the range to flush or the size
> of the stride.
> 
> Patch 3 introduces a threshold that is microarchitecture specific and
> will very likely be modified by vendors, not sure though which mechanism
> we'll use to do that (dt? alternatives? vendor initialization code?).
> 
> [...]

Here is the summary with links:
  - [v6,1/4] riscv: Improve tlb_flush()
    https://git.kernel.org/riscv/c/c5e9b2c2ae82
  - [v6,2/4] riscv: Improve flush_tlb_range() for hugetlb pages
    https://git.kernel.org/riscv/c/c962a6e74639
  - [v6,3/4] riscv: Make __flush_tlb_range() loop over pte instead of flushing the whole tlb
    https://git.kernel.org/riscv/c/9d4e8d5fa7db
  - [v6,4/4] riscv: Improve flush_tlb_kernel_range()
    https://git.kernel.org/riscv/c/5e22bfd520ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


