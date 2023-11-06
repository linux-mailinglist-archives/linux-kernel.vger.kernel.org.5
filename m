Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742B57E27FA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjKFPA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbjKFPAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:00:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EDD112
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 07:00:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 587C3C433AB;
        Mon,  6 Nov 2023 15:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699282829;
        bh=ECVz3lGtxGBADvHCPjD3ljOMk1SrC44aHNctP69FqWA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Ve0HWqsYZ7iBWx1g4i9SnchJy7OTfFLp4Q+idNXNM6rEFU9GScI8crupJ6pg61cGY
         rx3MKzC+p0hXHS4POrC45Ywjlx4mRdUxKcwNqOG4jbMi26LR+Vd/oEKaQg9X5YEaHH
         bFnJdDYqDKL60+9RECyLH4Hnopwio4tTRSX5lfTXib9P4ORNUhV/8zQFP6vT2xX1BG
         sNflCSWy2/VoNneUMpcJ1FL3a25Ptq/5RJoiEOVTRtxwWVXqo+MzgG76yvY3VVQkHX
         wLRGGhiJVp+rBBCtu4LkkuP1evMYodX9As2jk3pEXuKjn368w12BXvBx5w7/S3ens2
         lP2qltjeez4Aw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A455E0009D;
        Mon,  6 Nov 2023 15:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] riscv: provide riscv-specific is_trap_insn()
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169928282923.16503.13448855296252108096.git-patchwork-notify@kernel.org>
Date:   Mon, 06 Nov 2023 15:00:29 +0000
References: <20230829083614.117748-1-namcaov@gmail.com>
In-Reply-To: <20230829083614.117748-1-namcaov@gmail.com>
To:     Nam Cao <namcaov@gmail.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, bjorn@kernel.org, guoren@kernel.org,
        conor.dooley@microchip.com, bjorn@rivosinc.com
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

On Tue, 29 Aug 2023 10:36:15 +0200 you wrote:
> uprobes expects is_trap_insn() to return true for any trap instructions,
> not just the one used for installing uprobe. The current default
> implementation only returns true for 16-bit c.ebreak if C extension is
> enabled. This can confuse uprobes if a 32-bit ebreak generates a trap
> exception from userspace: uprobes asks is_trap_insn() who says there is no
> trap, so uprobes assume a probe was there before but has been removed, and
> return to the trap instruction. This causes an infinite loop of entering
> and exiting trap handler.
> 
> [...]

Here is the summary with links:
  - [v2] riscv: provide riscv-specific is_trap_insn()
    https://git.kernel.org/riscv/c/b701f9e726f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


