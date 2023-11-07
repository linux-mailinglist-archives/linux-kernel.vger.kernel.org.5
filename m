Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E857E355C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 07:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbjKGGug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 01:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjKGGud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 01:50:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682BC119
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 22:50:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC07CC433C9;
        Tue,  7 Nov 2023 06:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699339826;
        bh=cHbIfxGacqWBpCzOzghDzS7RRPAFPkidFECXn4+18cw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=O1Us4YLU/3AmrFt3w0GvHCF05NxtYEvKMSfZPzcYbJXzygIDTuPpgicU9FPgakbdF
         sBn6EmDp2BorJ0zjTQnzsE7ZVwHvKxE6n5bf029nz2xO2iGXbqCkgRitbkCqNpHv02
         n5m+IJ/4EoX8aEz2twQWrkk9jP/lWRS2heBJNabhed5uejm63DUULWfcpT0pLOUu5u
         vshPsS63PW+cZKPzDGRLxjWGjebSHhG62XWTFKU6kTgyPI40HK5yja9TL7Sqtha8NB
         pMvQN8oBF3OOyusucd6bhlf7ooBQdABinpib08uGmTENOd5E+CXwilXnYD6YKb+yHZ
         +muFZukI1AlkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AC77FE00087;
        Tue,  7 Nov 2023 06:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/5] riscv: cleanup assembly usage of ENTRY()/END() and use
 local labels
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169933982669.6233.10371170118616950256.git-patchwork-notify@kernel.org>
Date:   Tue, 07 Nov 2023 06:50:26 +0000
References: <20231024132655.730417-1-cleger@rivosinc.com>
In-Reply-To: <20231024132655.730417-1-cleger@rivosinc.com>
To:     =?utf-8?b?Q2zDqW1lbnQgTMOpZ2VyIDxjbGVnZXJAcml2b3NpbmMuY29tPg==?=@ci.codeaurora.org
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        atishp@atishpatra.org, ajones@ventanamicro.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org
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

On Tue, 24 Oct 2023 15:26:50 +0200 you wrote:
> This series does a cleanup of all ENTRY()/END() macros that are used in
> arch/riscv/ as well as use of local labels. This allows to remove the
> use of the now deprecated ENTRY()/END()/WEAK() macros as well as using
> the new SYM_*() ones which provide a better understanding of what is
> meant to be annotated. Some wrong usage of SYM_FUNC_START() are also
> fixed in this series by using the correct annotations. Finally a few
> labels that were meant to be local have been renamed to use the .L
> suffix and thus not to be emitted as visible symbols.
> 
> [...]

Here is the summary with links:
  - [v2,1/5] riscv: use ".L" local labels in assembly when applicable
    https://git.kernel.org/riscv/c/b18f7296fbfd
  - [v2,2/5] riscv: Use SYM_*() assembly macros instead of deprecated ones
    https://git.kernel.org/riscv/c/76329c693924
  - [v2,3/5] riscv: kernel: Use correct SYM_DATA_*() macro for data
    https://git.kernel.org/riscv/c/4cc0d8a3f109
  - [v2,4/5] riscv: kvm: Use SYM_*() assembly macros instead of deprecated ones
    (no matching commit)
  - [v2,5/5] riscv: kvm: use ".L" local labels in assembly when applicable
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


