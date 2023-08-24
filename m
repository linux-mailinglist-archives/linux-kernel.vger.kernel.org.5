Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A199A78791F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 22:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243424AbjHXUK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 16:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243422AbjHXUKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 16:10:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72536CE;
        Thu, 24 Aug 2023 13:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F385F66B90;
        Thu, 24 Aug 2023 20:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48A83C433C7;
        Thu, 24 Aug 2023 20:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692907822;
        bh=qT/JbWrkOTT0b8z8DYIP7cA63D810/8ETsf+/hqaq8U=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=NHcNTdq+6kQqgQNG4+6nbr5bvmyMDnA7WSPRQvFgkRvocYz/gItS5JW6OZKmNXu3K
         Mf+kB+Do3xeLqoTGrxmBj1dcsh5mflX/rDOt0z/HH5zAHy0VTM0h6VU7+kDcldEKVN
         +bN0jqnxouPsKqLPFZHzV/ZX5UhCE95HgCk9ONTJTNPd0Q2uWZjJSPj931jozNTNi1
         JOCWZXZm/2Rl7Q9C66GAVAsr4ouKDuWhjyZnRhM/aPDcSYJEEE6oftOw6r72exSKan
         QhcnOr8yAmKs7qmf3/TjTVSZpX2jXWHj17TreeGyeQvpmEeFEuu5VLhFdaKtXFt/D6
         X/u2erUCkzHdw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 29A74E33093;
        Thu, 24 Aug 2023 20:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Fix build errors using binutils2.37 toolchains
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169290782216.11381.9335896608253523695.git-patchwork-notify@kernel.org>
Date:   Thu, 24 Aug 2023 20:10:22 +0000
References: <20230824190852.45470-1-xingmingzheng@iscas.ac.cn>
In-Reply-To: <20230824190852.45470-1-xingmingzheng@iscas.ac.cn>
To:     Mingzheng Xing <xingmingzheng@iscas.ac.cn>
Cc:     linux-riscv@lists.infradead.org, conor@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, nathan@kernel.org, ndesaulniers@google.com,
        trix@redhat.com, bmeng@tinylab.org, guoren@kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        stable@vger.kernel.org, conor.dooley@microchip.com
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

On Fri, 25 Aug 2023 03:08:52 +0800 you wrote:
> When building the kernel with binutils 2.37 and GCC-11.1.0/GCC-11.2.0,
> the following error occurs:
> 
>   Assembler messages:
>   Error: cannot find default versions of the ISA extension `zicsr'
>   Error: cannot find default versions of the ISA extension `zifencei'
> 
> [...]

Here is the summary with links:
  - riscv: Fix build errors using binutils2.37 toolchains
    https://git.kernel.org/riscv/c/ef21fa7c198e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


