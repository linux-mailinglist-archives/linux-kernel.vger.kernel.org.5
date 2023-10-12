Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9E97C77FD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 22:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442831AbjJLUko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 16:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344224AbjJLUkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 16:40:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A4CD7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 13:40:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40712C433CB;
        Thu, 12 Oct 2023 20:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697143225;
        bh=sie1ll0Ma6WQdPMXUvgh0Kq88rf1sQq3F2RccRPRanM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DBCrBYGwYrIBSeJI/gKXdf0gz418ojPV52K5rTvSVAbvqTe4nEwY2/wus2Iu6gZEF
         TFsc/tDdqvxAB2kfE7YjUDZnkmxBJtwladLSVMXFtC7rOoEGqOs1TB0f8buAexQu3o
         hf7kavhvJYGfGFcK+hlirhYNDUsdBRHIftONpIMAVA/rCHGHhj19DdzgEF8Vt2oSL5
         oi0wxkLaLO+gapmvsvpvYZg+z7B1DXUjg1E0HbAzcXdoEFmZzvNyl/NqB6PWxPEIxv
         f8puKsZxlCyxEd9fnPaD6uuYt5iJEv+G8rEOJYuz/0q4rkF9ZruZwMMyJZ8b0Zp5L0
         htJdJypZOQTww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 20AC7E21EC3;
        Thu, 12 Oct 2023 20:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] RISC-V: Fix wrong use of CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169714322512.23371.9964258021648462397.git-patchwork-notify@kernel.org>
Date:   Thu, 12 Oct 2023 20:40:25 +0000
References: <20230913052940.374686-1-wangjiexun@tinylab.org>
In-Reply-To: <20230913052940.374686-1-wangjiexun@tinylab.org>
To:     Jiexun Wang <wangjiexun@tinylab.org>
Cc:     linux-riscv@lists.infradead.org, samuel@sholland.org,
        conor@kernel.org, guoren@kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, falcon@tinylab.org,
        jszhang@kernel.org, tglx@linutronix.de
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

On Wed, 13 Sep 2023 13:29:40 +0800 you wrote:
> If configuration options SOFTIRQ_ON_OWN_STACK and PREEMPT_RT
> are enabled simultaneously under RISC-V architecture,
> it will result in a compilation failure:
> 
> arch/riscv/kernel/irq.c:64:6: error: redefinition of 'do_softirq_own_stack'
>    64 | void do_softirq_own_stack(void)
>       |      ^~~~~~~~~~~~~~~~~~~~
> In file included from ./arch/riscv/include/generated/asm/softirq_stack.h:1,
>                  from arch/riscv/kernel/irq.c:15:
> ./include/asm-generic/softirq_stack.h:8:20: note: previous definition of 'do_softirq_own_stack' was here
>     8 | static inline void do_softirq_own_stack(void)
>       |                    ^~~~~~~~~~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - [v3] RISC-V: Fix wrong use of CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK
    https://git.kernel.org/riscv/c/07a27665754b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


