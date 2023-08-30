Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B1E78DD78
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244305AbjH3Sus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244550AbjH3NUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:20:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73111A4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:20:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C3B56106D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:20:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86FDAC433CB;
        Wed, 30 Aug 2023 13:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693401634;
        bh=mI4H49OCWKGQOotvEaAIfhMsmRpR+4hUEBUlcGXvv+I=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PaQ8Vtmr9xFNm6nKLd/vOFTD1/MeECYKjeULxAN4hsy5cnRBGn7f/TQnLhmXiIW6h
         +2gRyPGlXUJl9cwKIC19MknG8CogVJRIxD/UWU+De5x1b/OEcGkOiW1hCrpdLndnZO
         eZDwDY2TW0GCcSM//EroqS21aDggtt9LCyFscH7vEC5VbhiYwSMeLfBSOgRXPfHk5A
         RNC3GVfmd9U1d/7pKNdUH/5X2l5tTcnQxVAQkd2EFCBPaNUFygmYgVvc+bAJWI5vqH
         fmBVc+TpKMugK37VSivIA32tEENg1nuFNvVePiU0klc5mBIneGN6lS7QhaNzfaJ45q
         nkMVb1L6oEhrw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6C4C2E29F3B;
        Wed, 30 Aug 2023 13:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/3] riscv: kprobes: simulate some instructions
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169340163444.19859.10873904583580797287.git-patchwork-notify@kernel.org>
Date:   Wed, 30 Aug 2023 13:20:34 +0000
References: <cover.1690704360.git.namcaov@gmail.com>
In-Reply-To: <cover.1690704360.git.namcaov@gmail.com>
To:     Nam Cao <namcaov@gmail.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org
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

On Sun, 30 Jul 2023 10:27:06 +0200 you wrote:
> Simulate some currently rejected instructions. Still to be simulated are:
>     - c.jal
>     - c.ebreak
> 
> Nam Cao (3):
>   riscv: kprobes: simulate c.j instruction
>   riscv: kprobes: simulate c.jr and c.jalr instructions
>   riscv: kprobes: simulate c.beqz and c.bnez
> 
> [...]

Here is the summary with links:
  - [1/3] riscv: kprobes: simulate c.j instruction
    https://git.kernel.org/riscv/c/a93892974f2e
  - [2/3] riscv: kprobes: simulate c.jr and c.jalr instructions
    https://git.kernel.org/riscv/c/b18256d9b744
  - [3/3] riscv: kprobes: simulate c.beqz and c.bnez
    https://git.kernel.org/riscv/c/d943705fba3a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


