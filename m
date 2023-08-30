Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3158878DE51
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239971AbjH3TBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244562AbjH3NUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:20:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E14CDD
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:20:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E68386210D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:20:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE567C43215;
        Wed, 30 Aug 2023 13:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693401635;
        bh=zW83V15pttqQqoyclpx9Yc+p0D/cxwhn1//298m9yXM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MtprTzxLhEQg6X4K0qLXHGM67s0Zh4eOVAGDnSwhopvup8gGJ8o2c1qi/HMyv1Q2z
         /C2I2awv8OrFCeVCcrzXPljm1ymynSfwmffoN4SIOkGQijUlnbnPfOWrDGMLmHGLSZ
         Lm5uINVnRe7zSueEE39AZtGjuA/6Wv+5fdHIbng949u/PsjUurd1LB1ikS61cncyqN
         iIpm8YGPB0rNsE88cX7MdEb7IYQ8bYHnprmOoR+GMgAokhzovOq3wpWlU0HKcIjue5
         URAI6kMA+3LgHA+xMBciEvUOvnh3NB33r2eWnxGoUJRY0WEe7BN5T2ZCzyqxntlaM4
         sp0u5dll8eubQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D9C94E26D49;
        Wed, 30 Aug 2023 13:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] riscv: support ELF format binaries in nommu mode
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169340163488.19859.4409393808859164434.git-patchwork-notify@kernel.org>
Date:   Wed, 30 Aug 2023 13:20:34 +0000
References: <20230711130754.481209-1-gerg@kernel.org>
In-Reply-To: <20230711130754.481209-1-gerg@kernel.org>
To:     Greg Ungerer <gerg@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, palmer@dabbelt.com,
        viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        keescook@chromium.org, brauner@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 11 Jul 2023 23:07:52 +1000 you wrote:
> The following changes add the ability to run ELF format binaries when
> running RISC-V in nommu mode. That support is actually part of the
> ELF-FDPIC loader, so these changes are all about making that work on
> RISC-V.
> 
> The first issue to deal with is making the ELF-FDPIC loader capable of
> handling 64-bit ELF files. As coded right now it only supports 32-bit
> ELF files.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] binfmt_elf_fdpic: support 64-bit systems
    https://git.kernel.org/riscv/c/b922bf04d2c1
  - [v2,2/2] riscv: support the elf-fdpic binfmt loader
    https://git.kernel.org/riscv/c/9549fb354ef1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


