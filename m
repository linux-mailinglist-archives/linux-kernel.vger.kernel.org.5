Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AC97933DD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 04:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241988AbjIFCul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 22:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237811AbjIFCue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 22:50:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B6BCE6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 19:50:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9780FC433C9;
        Wed,  6 Sep 2023 02:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693968627;
        bh=1XHRzrMMV+lnj21rzfdeP3GG0PRTjver90SOcRj/7lU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BAIb/X/DXGtOFlpd1x6e0Qzzu2aVOKBTPtMLhoNTMB7DIjx+0pW9n3bv0cZ2XxptF
         eaQmGkg5IPQip7grskE3exmjRkjPtCEr6b9c5uMWkyUnHy2iFio7vK62guHCWD+7bU
         0t/F24LPo/hjXhKczCSfKk/Vi7MtPKyu9p1GSfUXckoXgQAytIbXiPxJFRWjEstpZc
         ROCqugKdxoGDJ6+l0UnlvprmtDorlXAwb4pYEd9jSjeE6CyFSRwIu/ebdJPj7Zlv1O
         Oul6pcuvvDj5Wc1ROD+ruafEeZMlimKzMSL+mtnuF2qF56aAj3CS75kKLNF3tyiXfn
         fISCpKN+Mi9mQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 79492C595C5;
        Wed,  6 Sep 2023 02:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/4] bpf,
 riscv: use BPF prog pack allocator in BPF JIT
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169396862749.1987.4994366714692856707.git-patchwork-notify@kernel.org>
Date:   Wed, 06 Sep 2023 02:50:27 +0000
References: <20230831131229.497941-1-puranjay12@gmail.com>
In-Reply-To: <20230831131229.497941-1-puranjay12@gmail.com>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, pulehui@huawei.com,
        conor.dooley@microchip.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, bjorn@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
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

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 31 Aug 2023 13:12:25 +0000 you wrote:
> Changes in v3 -> v4:
> 1. Add Acked-by:, Tested-by:, etc.
> 2. Add the core BPF patch[3] which was earlier sent with ARM64 series to
>    this series so it can go with this.
> 
> Changes in v2 -> v3:
> 1. Fix maximum width of code in patches from 80 to 100. [All patches]
> 2. Add checks for ctx->ro_insns == NULL. [Patch 3]
> 3. Fix check for edge condition where amount of text to set > 2 * pagesize
>    [Patch 1 and 2]
> 4. Add reviewed-by in patches.
> 5. Adding results of selftest here:
>    Using the command: ./test_progs on qemu
>    Without the series: Summary: 336/3162 PASSED, 56 SKIPPED, 90 FAILED
>    With this series: Summary: 336/3162 PASSED, 56 SKIPPED, 90 FAILED
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/4] bpf: make bpf_prog_pack allocator portable
    https://git.kernel.org/riscv/c/063119d90a06
  - [bpf-next,v4,2/4] riscv: extend patch_text_nosync() for multiple pages
    https://git.kernel.org/riscv/c/fb81d562ed1f
  - [bpf-next,v4,3/4] riscv: implement a memset like function for text
    https://git.kernel.org/riscv/c/f071fe652d73
  - [bpf-next,v4,4/4] bpf, riscv: use prog pack allocator in the BPF JIT
    https://git.kernel.org/riscv/c/19ea9d201008

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


