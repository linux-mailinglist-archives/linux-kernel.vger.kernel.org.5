Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7CE78DF14
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243676AbjH3TNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244557AbjH3NUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:20:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35422CD8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:20:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3C4A6203B
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:20:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C087DC433B7;
        Wed, 30 Aug 2023 13:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693401634;
        bh=jyXLnnkKGtU6HGmUDvmShKZCmlIr+YiiY/SO+Sj/GkQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=F32oMYF7Po0Au1jKdGvNtv8ROFh7kL9uPK3LKeNtXffQik+RqQpbnWC9rrp4htNwK
         ptPlvrwUFUEdJR74NHL537Q/2yGJBYhcGnQ63f/VNSLIyVM29sWEXS8nCaJ3Or6bpm
         5s0dS4VwNJMDRpKppjYE8qf77BQdX+V4jo5glKH+Qhmq6b9Y0fnlgUTYVs/PATXS/5
         P4f6LwKoUkp7P4N4n48jfhOxsDLXT8DZDQNUkPiQn4bcFk34sRhtSkCufZ18hOo3zI
         Lqf7ZbB3N4GQoWlWcUagrZMMBBQASnjbsDbNUTlldqVbVBuqeJx8p0UKUgGrBX4tSd
         4jD3ZeJmTvmew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A76EBE26D49;
        Wed, 30 Aug 2023 13:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] riscv: Mark KASAN tmp* page tables variables as static
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169340163468.19859.6513000378615706534.git-patchwork-notify@kernel.org>
Date:   Wed, 30 Aug 2023 13:20:34 +0000
References: <20230704074357.233982-1-alexghiti@rivosinc.com>
In-Reply-To: <20230704074357.233982-1-alexghiti@rivosinc.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, ryabinin.a.a@gmail.com,
        glider@google.com, andreyknvl@gmail.com, dvyukov@google.com,
        vincenzo.frascino@arm.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, bjorn@rivosinc.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        lkp@intel.com
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

On Tue,  4 Jul 2023 09:43:56 +0200 you wrote:
> tmp_pg_dir, tmp_p4d and tmp_pud are only used in kasan_init.c so they
> should be declared as static.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202306282202.bODptiGE-lkp@intel.com/
> Fixes: 96f9d4daf745 ("riscv: Rework kasan population functions")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> 
> [...]

Here is the summary with links:
  - [1/2] riscv: Mark KASAN tmp* page tables variables as static
    https://git.kernel.org/riscv/c/56e1803d9de0
  - [2/2] riscv: Move create_tmp_mapping() to init sections
    https://git.kernel.org/riscv/c/d616fce3f100

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


