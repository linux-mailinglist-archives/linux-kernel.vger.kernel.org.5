Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1631C76EDA9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236926AbjHCPKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236879AbjHCPK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:10:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8F310C7
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 08:10:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B774E61DF5
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 15:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 142EDC433C9;
        Thu,  3 Aug 2023 15:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691075423;
        bh=orfhoYZ+x7W/5dil2GMBX2jxw/cc0/lVW+WjnHi6yn4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=e9+0UqFR7QUmGvyWYrSJRYXSHdry8oXN4wY7ivMBfdrGKTY8TlsDzZBdNz19wEpZW
         +I7Q82Q1JlJj9xJFxwQT1F8s+JqGgEIZgPW3OYYUkbvXFepNRLppurRqEd8+BruswS
         CwMZLNiYGQfSyBQmQjB8hYYrJPnGOiky3pMrozZm1h6eyhOIPLamhx1I2m6f+6LTG8
         GlToWDMqaYU2CvWz/M+Z/n8YUnIBWTDDkN5DdPPaU2Lol0bbEC3tiJ5bR54uuZCrqY
         uc8pI/MpaHIieFY1y98/df2ynf9OWkL/ocCUwK3IfIJSXTUKKz4f59oOfIntt4rtOB
         8oOOl6loj8iLg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E9DCCC595C2;
        Thu,  3 Aug 2023 15:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/3] RISC-V: Fix a few kexec_file_load(2) failures
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169107542294.19238.10753003765050685366.git-patchwork-notify@kernel.org>
Date:   Thu, 03 Aug 2023 15:10:22 +0000
References: <cover.1690365011.git.petr.tesarik.ext@huawei.com>
In-Reply-To: <cover.1690365011.git.petr.tesarik.ext@huawei.com>
To:     Petr Tesarik <petrtesarik@huaweicloud.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        conor.dooley@microchip.com, lihuafei1@huawei.com,
        liaochang1@huawei.com, masahiroy@kernel.org, keescook@chromium.org,
        akpm@linux-foundation.org, heiko@sntech.de, ribalda@chromium.org,
        hi@alyssa.is, lizhengyu3@huawei.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, duwe@suse.de,
        roberto.sassu@huaweicloud.com, petr@tesarici.cz
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 26 Jul 2023 11:53:58 +0200 you wrote:
> From: Petr Tesarik <petr.tesarik.ext@huawei.com>
> 
> The kexec_file_load(2) syscall does not work at least in some kernel
> builds. For details see the relevant section in this blog post:
> 
> https://sigillatum.tesarici.cz/2023-07-21-state-of-riscv64-kdump.html
> 
> [...]

Here is the summary with links:
  - [v2,1/3] riscv/kexec: handle R_RISCV_CALL_PLT relocation type
    https://git.kernel.org/riscv/c/1be0b05b3a80
  - [v2,2/3] riscv/purgatory: do not link with string.o and its dependencies
    (no matching commit)
  - [v2,3/3] riscv/kexec: load initrd high in available memory
    https://git.kernel.org/riscv/c/0ccd2e803745

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


