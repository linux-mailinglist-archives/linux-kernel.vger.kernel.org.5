Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E13776242
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbjHIOUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbjHIOU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:20:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8892B1FCC;
        Wed,  9 Aug 2023 07:20:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2295B6176B;
        Wed,  9 Aug 2023 14:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71D47C433C8;
        Wed,  9 Aug 2023 14:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691590823;
        bh=GYLw4R5ZP8Asgcy8c4U/E68U/BEFVITI0t4kAXKKJyg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=iKoG6qTXz/QDY3IA7SBUrPMHv1yumYmq9dr1nWznwbiiUREaEEODsonj0tKjJtG26
         oUeDXJMsUhldhBBOu0tA7hyL014NQKCVk7Xa/bnz9nNKndCybta98L7ERaut4PuRqB
         A01zbT8H/DzlpnfsRiHWvRI5x+4PAsRy2KpPtHmnRTm9GoRsNIz5DiaaibAgeNcGjO
         FoFFVnZW7gSHV0XVOcKP93ubOR0+zb3zucOlktFTKqoKa3BpWRHauTWK72xuJU+0T7
         rxlv8S+oX1TkqUQjk48Iw7aL2bB8UZ989sSs3DRpKiP9EKgwaCzXkZAMuX35Lf3Z3y
         lG/5t5F0mqEJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 576A0E3308F;
        Wed,  9 Aug 2023 14:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 00/11] RISC-V: Probe DT extension support using
 riscv,isa-extensions & riscv,isa-base
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169159082335.5601.13810785902879648545.git-patchwork-notify@kernel.org>
Date:   Wed, 09 Aug 2023 14:20:23 +0000
References: <20230713-target-much-8ac624e90df8@wendy>
In-Reply-To: <20230713-target-much-8ac624e90df8@wendy>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        conor@kernel.org, robh+dt@kernel.org, evan@rivosinc.com,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        heiko.stuebner@vrull.eu, ajones@ventanamicro.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 13 Jul 2023 13:10:58 +0100 you wrote:
> Hey,
> 
> Based on my latest iteration of deprecating riscv,isa [1], here's an
> implementation of the new properties for Linux. The first few patches,
> up to "RISC-V: split riscv_fill_hwcap() in 3", are all prep work that
> further tames some of the extension related code, on top of my already
> applied series that cleans up the ISA string parser.
> Perhaps "RISC-V: shunt isa_ext_arr to cpufeature.c" is a bit gratuitous,
> but I figured a bit of coalescing of extension related data structures
> would be a good idea. Note that riscv,isa will still be used in the
> absence of the new properties. Palmer suggested adding a Kconfig option
> to turn off the fallback for DT, which I have gone and done. It's locked
> behind the NONPORTABLE option for good reason.
> 
> [...]

Here is the summary with links:
  - [v5,01/11] RISC-V: Provide a more helpful error message on invalid ISA strings
    https://git.kernel.org/riscv/c/230598939678
  - [v5,02/11] RISC-V: don't parse dt/acpi isa string to get rv32/rv64
    https://git.kernel.org/riscv/c/67270fb388fe
  - [v5,03/11] RISC-V: drop a needless check in print_isa_ext()
    https://git.kernel.org/riscv/c/131033689da2
  - [v5,04/11] RISC-V: shunt isa_ext_arr to cpufeature.c
    https://git.kernel.org/riscv/c/8135ade32c0d
  - [v5,05/11] RISC-V: repurpose riscv_isa_ext array in riscv_fill_hwcap()
    https://git.kernel.org/riscv/c/37f988dcec05
  - [v5,06/11] RISC-V: add missing single letter extension definitions
    https://git.kernel.org/riscv/c/c30556e318cc
  - [v5,07/11] RISC-V: add single letter extensions to riscv_isa_ext
    https://git.kernel.org/riscv/c/effc122ad176
  - [v5,08/11] RISC-V: split riscv_fill_hwcap() in 3
    https://git.kernel.org/riscv/c/4265b0ec5ee7
  - [v5,09/11] RISC-V: enable extension detection from dedicated properties
    https://git.kernel.org/riscv/c/90700a4fbfaf
  - [v5,10/11] RISC-V: try new extension properties in of_early_processor_hartid()
    https://git.kernel.org/riscv/c/c98f136aedbd
  - [v5,11/11] RISC-V: provide Kconfig & commandline options to control parsing "riscv,isa"
    https://git.kernel.org/riscv/c/496ea826d1e1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


