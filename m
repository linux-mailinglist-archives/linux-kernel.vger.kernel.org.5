Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CAD7E8DC6
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 01:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjKLAz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 19:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjKLAzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 19:55:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F56324A
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 16:55:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E392C433CC;
        Sun, 12 Nov 2023 00:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699750546;
        bh=BudbliKklZT1nMXLsYFQyB+Pk18EUouJG6KZUqc8uyA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qgpBSE+z2PM5zIUQ4ZiQ42U4qfNh/mK+G0UjLlwezYzovO7Hv0r3U4c2k0cyQdJYu
         2tpvqEdQc/11Ql3RizpG4raIDOskXMIAUvBKTtjTHuZBVqO64Ai4BwQvtxiuGP7GE0
         CQmDP5c7hXu//cf4WJPIWVVxlHFlXjFtikp2paYREnbtSZEzC4aaPYEiSS3SYENmbA
         8Um9rkkzACTUm8CXhr7u/rIYQ204eiVoJlZZJPnezsmOLIDxlNAQc1kpIVDVmquMV2
         HIxQgf86TrDBy4GYf8wHAQCmg3P0oq4N21BCiACjV24ts57a55XSwDkPCJQzoigyop
         H7y/eALJS/dlA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4CE26E0008B;
        Sun, 12 Nov 2023 00:55:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/6] KVM RISC-V Conditional Operations
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169975054631.11360.10958982747975281844.git-patchwork-notify@kernel.org>
Date:   Sun, 12 Nov 2023 00:55:46 +0000
References: <20231003035226.1945725-1-apatel@ventanamicro.com>
In-Reply-To: <20231003035226.1945725-1-apatel@ventanamicro.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, pbonzini@redhat.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, conor@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shuah@kernel.org,
        ajones@ventanamicro.com, mchitale@ventanamicro.com,
        devicetree@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Anup Patel <anup@brainfault.org>:

On Tue,  3 Oct 2023 09:22:20 +0530 you wrote:
> This series extends KVM RISC-V to allow Guest/VM discover and use
> conditional operations related ISA extensions (namely XVentanaCondOps
> and Zicond).
> 
> To try these patches, use KVMTOOL from riscv_zbx_zicntr_smstateen_condops_v1
> branch at: https://github.com/avpatel/kvmtool.git
> 
> [...]

Here is the summary with links:
  - [v3,1/6] dt-bindings: riscv: Add Zicond extension entry
    https://git.kernel.org/riscv/c/00c6f39c8247
  - [v3,2/6] RISC-V: Detect Zicond from ISA string
    https://git.kernel.org/riscv/c/662a601aa355
  - [v3,3/6] RISC-V: KVM: Allow Zicond extension for Guest/VM
    https://git.kernel.org/riscv/c/df68f4d8cb49
  - [v3,4/6] KVM: riscv: selftests: Add senvcfg register to get-reg-list test
    https://git.kernel.org/riscv/c/4d554e0226e6
  - [v3,5/6] KVM: riscv: selftests: Add smstateen registers to get-reg-list test
    https://git.kernel.org/riscv/c/e1a8db0c9a0e
  - [v3,6/6] KVM: riscv: selftests: Add condops extensions to get-reg-list test
    https://git.kernel.org/riscv/c/2b3f2b78ec93

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


