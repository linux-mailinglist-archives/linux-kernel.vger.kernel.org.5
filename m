Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4E380FA64
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 23:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377769AbjLLWU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 17:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377700AbjLLWUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 17:20:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE099C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 14:20:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0FC50C433C9;
        Tue, 12 Dec 2023 22:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702419629;
        bh=tRQTTgbl7FgoXWnczF+Nu4dcXEMjiXldZt7YykkAb7c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ELbS/ZBchr9V1OUApYbsPxVfC3QhK6gRdEtyEwYCxImEAmzDbWjyqHJWD7AKHqx7X
         1+4RfdahigCRl5Jw/P1jtwgOqsSBAhrILUK1xrDmeBifpFfMhi/LmhZ6sBJfpA+LJD
         CzKdS2nDzPg4mZ3cn+9QPo2uYPUE5o09G91tCT3En/TaWVP37X2hnq6fwH03czEUmS
         W8nyC/NInZCNDO7/bQvA1MaZLXKS1upyxidzgSVopOC+5TgrYONnszIomeNY9Z0wn2
         nBdGCcJVcyVbnwWYYIGEY0Lv4g3fl/G3p5VSmbNux35T5zQrM2qefYGD4C8QkGkjCH
         +Qh/vJAsKuHmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E9729DD4EFE;
        Tue, 12 Dec 2023 22:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 00/20] riscv: report more ISA extensions through hwprobe
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <170241962895.7374.4064539637441634071.git-patchwork-notify@kernel.org>
Date:   Tue, 12 Dec 2023 22:20:28 +0000
References: <20231114141256.126749-1-cleger@rivosinc.com>
In-Reply-To: <20231114141256.126749-1-cleger@rivosinc.com>
To:     =?utf-8?b?Q2zDqW1lbnQgTMOpZ2VyIDxjbGVnZXJAcml2b3NpbmMuY29tPg==?=@ci.codeaurora.org
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        palmer@rivosinc.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, aou@eecs.berkeley.edu,
        corbet@lwn.net, ajones@ventanamicro.com, evan@rivosinc.com,
        conor@kernel.org, sameo@rivosinc.com, jerry.shih@sifive.com
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

On Tue, 14 Nov 2023 09:12:36 -0500 you wrote:
> In order to be able to gather more information about the supported ISA
> extensions from userspace using the hwprobe syscall, add more ISA
> extensions report. This series adds the following ISA extensions parsing
> support:
> 
> - Zfh[min]
> - Zvfh[min]
> - Zihintntl
> - Zbc
> - Zvbb
> - Zvbc
> - Zvkb
> - Zvkg
> - Zvkned
> - Zvknh[ab]
> - Zvksed
> - Zvksh
> - Zvkn
> - Zvknc
> - Zvkng
> - Zvks
> - Zvksc
> - Zvksg
> - Zvkt
> - Zfa
> - Zbkb
> - Zbkc
> - Zbkx
> - Zknd
> - Zkne
> - Zknh
> - Zkr
> - Zksed
> - Zksh
> - Zkt
> 
> [...]

Here is the summary with links:
  - [v4,01/20] riscv: add ISA extension parsing for Zbc
    https://git.kernel.org/riscv/c/88e752f0986f
  - [v4,02/20] riscv: hwprobe: export missing Zbc ISA extension
    https://git.kernel.org/riscv/c/2ae2b9097b2e
  - [v4,03/20] riscv: add ISA extension parsing for scalar crypto
    https://git.kernel.org/riscv/c/5ee88a915d4b
  - [v4,04/20] riscv: hwprobe: add support for scalar crypto ISA extensions
    https://git.kernel.org/riscv/c/18883cef7e64
  - [v4,05/20] dt-bindings: riscv: add scalar crypto ISA extensions description
    https://git.kernel.org/riscv/c/ffd19e815367
  - [v4,06/20] riscv: add ISA extension parsing for vector crypto
    https://git.kernel.org/riscv/c/4fa9e167b63b
  - [v4,07/20] riscv: hwprobe: export vector crypto ISA extensions
    https://git.kernel.org/riscv/c/d06b89615a9e
  - [v4,08/20] dt-bindings: riscv: add vector crypto ISA extensions description
    https://git.kernel.org/riscv/c/eb8c82b7a8c4
  - [v4,09/20] riscv: add ISA extension parsing for Zfh/Zfh[min]
    https://git.kernel.org/riscv/c/68bddb2748ac
  - [v4,10/20] riscv: hwprobe: export Zfh[min] ISA extensions
    https://git.kernel.org/riscv/c/5cb9bea00d12
  - [v4,11/20] dt-bindings: riscv: add Zfh[min] ISA extensions description
    https://git.kernel.org/riscv/c/6853ab83405c
  - [v4,12/20] riscv: add ISA extension parsing for Zihintntl
    https://git.kernel.org/riscv/c/8ab84bf68d2b
  - [v4,13/20] riscv: hwprobe: export Zhintntl ISA extension
    https://git.kernel.org/riscv/c/814d9823088a
  - [v4,14/20] dt-bindings: riscv: add Zihintntl ISA extension description
    https://git.kernel.org/riscv/c/4bd2e33d1613
  - [v4,15/20] riscv: add ISA extension parsing for Zvfh[min]
    https://git.kernel.org/riscv/c/c7fa1ef17e6f
  - [v4,16/20] riscv: hwprobe: export Zvfh[min] ISA extensions
    https://git.kernel.org/riscv/c/9a42ab69b658
  - [v4,17/20] dt-bindings: riscv: add Zvfh[min] ISA extension description
    https://git.kernel.org/riscv/c/1f532a7d898e
  - [v4,18/20] riscv: add ISA extension parsing for Zfa
    https://git.kernel.org/riscv/c/4758aec519ae
  - [v4,19/20] riscv: hwprobe: export Zfa ISA extension
    https://git.kernel.org/riscv/c/f838a77a4881
  - [v4,20/20] dt-bindings: riscv: add Zfa ISA extension description
    https://git.kernel.org/riscv/c/e810a257576f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


