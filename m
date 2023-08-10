Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F252D7781D1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236510AbjHJTuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234953AbjHJTuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DDC2738
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE3E7632CA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 19:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4BBA0C433C7;
        Thu, 10 Aug 2023 19:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691697022;
        bh=UHSK7sHWgdPvk4SUg9SCRlEo0k3DQS+f65ypDdcUiB8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ecFPGxpvw5VBd6ljqYdAWZl91LycZCnhaz/VRT0VaAZef2xwFL/eaqHWymREqRgJo
         +/ABD8PGOLst53forLvl9d2vC5+TagRcmhibi4eRRcGC5rErr+yjRKGCFsjDnB1lxo
         vR8sI/WhU0M+rXGGsyEUhf6+nwOuWoWoKFpYyzNhkUhGRiCh0fFzGP3TSWHhEm/uSF
         8ZKrdQtqgSqdoYRASpeRLkec1G5jt5RySfkuq00xWwH2fnoLXaIh08n4ELicxCfqhp
         AG5LRi9el5qZt69rXHmNY+8/8oxTg7qH97fyshzQx4g0HnmAkt24VTmTlNLVF5vAFf
         sVsMTV+19OvCQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2CB71E1CF31;
        Thu, 10 Aug 2023 19:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -fixes] riscv: Do not allow vmap pud mappings for 3-level page
 table
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169169702217.10459.13892718151102132616.git-patchwork-notify@kernel.org>
Date:   Thu, 10 Aug 2023 19:50:22 +0000
References: <20230808130709.1502614-1-alexghiti@rivosinc.com>
In-Reply-To: <20230808130709.1502614-1-alexghiti@rivosinc.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, bjorn@rivosinc.com,
        linux-kernel@vger.kernel.org
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

On Tue,  8 Aug 2023 15:07:09 +0200 you wrote:
> The vmalloc_fault() path was removed and to avoid syncing the vmalloc PGD
> mappings, they are now preallocated. But if the kernel can use a PUD
> mapping (which in sv39 is actually a PGD mapping) for large vmalloc
> allocation, it will free the current unused preallocated PGD mapping and
> install a new leaf one. Since there is no sync anymore, some page tables
> lack this new mapping and that triggers a panic.
> 
> [...]

Here is the summary with links:
  - [-fixes] riscv: Do not allow vmap pud mappings for 3-level page table
    https://git.kernel.org/riscv/c/d566bea4a638

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


