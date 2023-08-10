Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3FD7781D2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbjHJTu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbjHJTuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436262733
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEEA1630B9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 19:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D3DCC433C9;
        Thu, 10 Aug 2023 19:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691697022;
        bh=lZaL7F4p8juWuK24qniHzORDsGN+Q0e7boON0KwAsk4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qTKSWcipncLtZiwmk68OVLAVvo8tcnY+faD7r+SCkDW78hTVeG7Bv+4ZHYGYyY5zA
         uLzffvV5fj7NNsZ9lzg6v1sNR2ZZCAor+aFqulU3+4Eveze0X9X8GDz6BGCInFk2TL
         sXUtH0y4p6OwG9Sq4MK4Y0nL5g6sEvXr1kcRs6dkrUPXDQ3LY/S3cdop34EJ4FOhcr
         Hk8sX5hWJL7NrgDScxRf8eulYh6VIxU5lsZT5TbMQ0iqRyo7yz5eYltWOgjfmog2cd
         EIFsSZb5uKO7fn/mfw9dNQ7Jvl99nIporVKJqnB8sACnBbpN3baHD2TF77o56QnZCU
         O6VDuwhOIdB4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2204CC595C2;
        Thu, 10 Aug 2023 19:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -fixes] riscv: Implement flush_cache_vmap()
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169169702213.10459.2982861934492504882.git-patchwork-notify@kernel.org>
Date:   Thu, 10 Aug 2023 19:50:22 +0000
References: <20230725132246.817726-1-alexghiti@rivosinc.com>
In-Reply-To: <20230725132246.817726-1-alexghiti@rivosinc.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, bjorn@rivosinc.com,
        guoren@kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 25 Jul 2023 15:22:46 +0200 you wrote:
> The RISC-V kernel needs a sfence.vma after a page table modification: we
> used to rely on the vmalloc fault handling to emit an sfence.vma, but
> commit 7d3332be011e ("riscv: mm: Pre-allocate PGD entries for
> vmalloc/modules area") got rid of this path for 64-bit kernels, so now we
> need to explicitly emit a sfence.vma in flush_cache_vmap().
> 
> Note that we don't need to implement flush_cache_vunmap() as the generic
> code should emit a flush tlb after unmapping a vmalloc region.
> 
> [...]

Here is the summary with links:
  - [-fixes] riscv: Implement flush_cache_vmap()
    https://git.kernel.org/riscv/c/7e3811521dc3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


