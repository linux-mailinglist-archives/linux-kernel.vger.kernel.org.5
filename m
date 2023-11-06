Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C64E7E27F6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjKFPAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjKFPAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:00:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F51134
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 07:00:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 527F7C43397;
        Mon,  6 Nov 2023 15:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699282829;
        bh=YFVybbzYNtADnD7EN41/e4YtU6Oeh/3FbWJwT1GX5OM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MSulK/ZnMKO8w5IDzRsJ4GAkqFH8+9Z1yTj35fU9fQv+DO2RbO0BakiRQcOY1ET+i
         8TlZsU3ACLLt5ICONLUMQINAN+/U5fkHJykYL0Gr9GHa0V7ptKDeUCLwgEehP3hFfB
         iy/M0dSQWUQ3XRwt4q404PNVn/OBfoN9/QucdK0+3YY6tlnWQGziuei9USrbQBwflg
         1PuNgnR1DhAF/gyw5Bt/RZbVYttN72GtkYnH6CUwHXlHbsCsSsgWzkEsVP8kZ9gIGa
         hsn9LWFuNlj0IhzljyPCoP3DsfnQn1QGQgfxt8MZuFebUr3o/1klL8Cd8CX+CDcZo8
         syoP3l3d0xcvQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B44BC00446;
        Mon,  6 Nov 2023 15:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: signal: handle syscall restart before get_signal
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169928282917.16503.10982051973529578442.git-patchwork-notify@kernel.org>
Date:   Mon, 06 Nov 2023 15:00:29 +0000
References: <20230803224458.4156006-1-ancientmodern4@gmail.com>
In-Reply-To: <20230803224458.4156006-1-ancientmodern4@gmail.com>
To:     Haorong Lu <ancientmodern4@gmail.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        conor.dooley@microchip.com, andy.chiu@sifive.com, heiko@sntech.de,
        guoren@kernel.org, viro@zeniv.linux.org.uk,
        mathis.salmen@matsal.de, abrestic@rivosinc.com,
        greentime.hu@sifive.com, vincent.chen@sifive.com,
        linux-kernel@vger.kernel.org
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

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu,  3 Aug 2023 15:44:54 -0700 you wrote:
> In the current riscv implementation, blocking syscalls like read() may
> not correctly restart after being interrupted by ptrace. This problem
> arises when the syscall restart process in arch_do_signal_or_restart()
> is bypassed due to changes to the regs->cause register, such as an
> ebreak instruction.
> 
> Steps to reproduce:
> 1. Interrupt the tracee process with PTRACE_SEIZE & PTRACE_INTERRUPT.
> 2. Backup original registers and instruction at new_pc.
> 3. Change pc to new_pc, and inject an instruction (like ebreak) to this
>    address.
> 4. Resume with PTRACE_CONT and wait for the process to stop again after
>    executing ebreak.
> 5. Restore original registers and instructions, and detach from the
>    tracee process.
> 6. Now the read() syscall in tracee will return -1 with errno set to
>    ERESTARTSYS.
> 
> [...]

Here is the summary with links:
  - riscv: signal: handle syscall restart before get_signal
    https://git.kernel.org/riscv/c/ce4f78f1b53d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


