Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28227C77FB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 22:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442798AbjJLUkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 16:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344160AbjJLUkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 16:40:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D02CF
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 13:40:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2979DC433C9;
        Thu, 12 Oct 2023 20:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697143225;
        bh=Fauph9JoaEidptKpc+WMZmrBs887AnYOmzORE7FONmU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=pyRZmD9ryji+iaTLJKK9DSKujCHuv7xdFnJEiv62kt1C8/qUq+96w3IzZ487U8BBU
         vzOcEmd/wm2QYW7jRUUxjMpjeWrefBJ7JcvD2kTq3y0NZXQr6zIC9NLs5lGcOj0C/C
         ziLlwQllZ9LiulhOPo2v/Sd6OM3AzBjqxJm1a7IEeRyD9PfHUhQAwLIae8s9WBCwu6
         l3oyx4rNGkU14UHdP3Cgr325sFUC1s2hNiM3T2z8iHyYzm1aLq8f7CrzVCv10RKkPF
         QVwx8ds9MtD1RAk0Vnv7voBiEAlwUAZ4p0iFXc3QvqbY1B+GtlirYbPzjZ+jXYb/TS
         4cXSa0f34fR6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0B6E2E21EC0;
        Thu, 12 Oct 2023 20:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -fixes] riscv: Fix ftrace syscall handling which are now
 prefixed with __riscv_
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169714322504.23371.7333099870836142544.git-patchwork-notify@kernel.org>
Date:   Thu, 12 Oct 2023 20:40:25 +0000
References: <20231003182407.32198-1-alexghiti@rivosinc.com>
In-Reply-To: <20231003182407.32198-1-alexghiti@rivosinc.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mark.rutland@arm.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, samitolvanen@google.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
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

On Tue,  3 Oct 2023 20:24:07 +0200 you wrote:
> ftrace creates entries for each syscall in the tracefs but has failed
> since commit 08d0ce30e0e4 ("riscv: Implement syscall wrappers") which
> prefixes all riscv syscalls with __riscv_.
> 
> So fix this by implementing arch_syscall_match_sym_name() which allows us
> to ignore this prefix.
> 
> [...]

Here is the summary with links:
  - [-fixes] riscv: Fix ftrace syscall handling which are now prefixed with __riscv_
    https://git.kernel.org/riscv/c/a87e7d3e8832

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


