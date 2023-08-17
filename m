Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED84977FAA0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353161AbjHQPUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353156AbjHQPU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:20:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BE530E5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 08:20:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87585642F0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 15:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E27D7C433CB;
        Thu, 17 Aug 2023 15:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692285624;
        bh=DB0OhACvo8fkRgRhb62F5ThJJF48oRue24Z1cHKFom8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=e7mr0TARpLL1dqFKwLjPCjuA6zvFD4sIuqk6uQguLrIfP33B+9Ljwq+BbPRlfv4/v
         rFFDpGQUUDBFKQllHAFuMGjmdKFZkWDzvVAQK10RDEmmfZoQFQUq1jU+/nQedBP4FS
         g34UXmgEw7ux6SiGJTpvcnlivwV9tLwZ8BnWcuzLv3gtlJveEbDl+Oqpx3/DOMoCha
         FlzgDFwDa++8U7xLHyQRdMx2o7jRlvRVSsrlVsDUOopy2+pT/ISgAo31KAcdH1Zj37
         lEPM+HiDWGAvO+aS4krHf7eK4R0PdPwj5l1Y7sw3DBcvZQuD8E4N5botAnOlUes/If
         yVR0mwrlsfzJg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C714DE26D37;
        Thu, 17 Aug 2023 15:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: correct riscv_insn_is_c_jr() and
 riscv_insn_is_c_jalr()
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169228562481.20811.1913626229577446367.git-patchwork-notify@kernel.org>
Date:   Thu, 17 Aug 2023 15:20:24 +0000
References: <20230731183925.152145-1-namcaov@gmail.com>
In-Reply-To: <20230731183925.152145-1-namcaov@gmail.com>
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

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 31 Jul 2023 20:39:25 +0200 you wrote:
> The instructions c.jr and c.jalr must have rs1 != 0, but
> riscv_insn_is_c_jr() and riscv_insn_is_c_jalr() do not check for this. So,
> riscv_insn_is_c_jr() can match a reserved encoding, while
> riscv_insn_is_c_jalr() can match the c.ebreak instruction.
> 
> Rewrite them with check for rs1 != 0.
> 
> [...]

Here is the summary with links:
  - riscv: correct riscv_insn_is_c_jr() and riscv_insn_is_c_jalr()
    https://git.kernel.org/riscv/c/79bc3f85c51f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


