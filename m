Return-Path: <linux-kernel+bounces-121399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6ACA88E770
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89F891F31C90
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E101422CE;
	Wed, 27 Mar 2024 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZydgAPJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BCB130AD1;
	Wed, 27 Mar 2024 14:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711548030; cv=none; b=qCB/jORB++LSxOUFMuWIHC9zFG1rbHuDnnLgLrABItB1CIswfyeAIO3mBQJoA4BHQyBSa+dReoRpuDf5Pg7BMhb5dH2xHV/T8EDqKDY+WunwLaZ5L8VvFMxc8yM0CMpnZyA9VWeNZY4iczivaQgpDNzp+BrlLgpiyagWc+xxBFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711548030; c=relaxed/simple;
	bh=Tll+aW5UzZK8YuZZkR7WzGfMayybv0KNwJ35XBtg264=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OZBtTuos5UMwenz/2TOQ32UkHea8eARszwlypEGVy8n4KbNyi5wvzy5XsJM3pby+4h0fsaH/IN4zk9aeqj/fFryEszMVXtAzG9p2eDA3oyvPysfQ3CDyQN1QhWu3/gAHuGBOSrix5x2CAUBeT3sUPiWYbEUdUbhMxveca7RBuuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZydgAPJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A32DEC43399;
	Wed, 27 Mar 2024 14:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711548029;
	bh=Tll+aW5UzZK8YuZZkR7WzGfMayybv0KNwJ35XBtg264=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iZydgAPJiAxrATGtcqgLHPbZOX6sT0pFQmn0g7mCn4hqM10pueEU7b2S2taaIm3CH
	 YSFJkpMB34qGgjVQ7l5nFqE0YAThCVWE0upVMd4HJhX2jXLYIH90qe+jigXCRAcPQt
	 VeL8cqclWL2glzQJSY0wNf2kIAuRKpAJc+xIRsdoxhX/g0fmWrY6nmcsFwiMDolP9s
	 rEPiUPY71B+P6kfDrSDO3R+ghvaMeN8sP3HMWCAI+yx5amyEMqrbX3XhjVsBjEpZH8
	 +XDzjj2zP6iRwhsuu6zZbY+YWNoU//UOEhcIyrcjY1NV3PbsVy1eMbrm+lmhTOn22+
	 t3Y1RPIZsIBvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 944D3D95070;
	Wed, 27 Mar 2024 14:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Mark __se_sys_* functions __used
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171154802960.9827.16527899722264043993.git-patchwork-notify@kernel.org>
Date: Wed, 27 Mar 2024 14:00:29 +0000
References: <20240326153712.1839482-2-samitolvanen@google.com>
In-Reply-To: <20240326153712.1839482-2-samitolvanen@google.com>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, keescook@chromium.org,
 llvm@lists.linux.dev, linux-kernel@vger.kernel.org, lkft@linaro.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 26 Mar 2024 15:37:13 +0000 you wrote:
> Clang doesn't think ___se_sys_* functions used even though they are
> aliased to __se_sys_*, resulting in -Wunused-function warnings when
> building rv32. For example:
> 
>    mm/oom_kill.c:1195:1: warning: unused function '___se_sys_process_mrelease' [-Wunused-function]
>     1195 | SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/syscalls.h:221:36: note: expanded from macro 'SYSCALL_DEFINE2'
>      221 | #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
>          |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/syscalls.h:231:2: note: expanded from macro 'SYSCALL_DEFINEx'
>      231 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/riscv/include/asm/syscall_wrapper.h:81:2: note: expanded from macro '__SYSCALL_DEFINEx'
>       81 |         __SYSCALL_SE_DEFINEx(x, sys, name, __VA_ARGS__)                         \
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/riscv/include/asm/syscall_wrapper.h:40:14: note: expanded from macro '__SYSCALL_SE_DEFINEx'
>       40 |         static long ___se_##prefix##name(__MAP(x,__SC_LONG,__VA_ARGS__))
>          |                     ^~~~~~~~~~~~~~~~~~~~
>    <scratch space>:30:1: note: expanded from here
>       30 | ___se_sys_process_mrelease
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~~
>    1 warning generated.
> 
> [...]

Here is the summary with links:
  - riscv: Mark __se_sys_* functions __used
    https://git.kernel.org/riscv/c/653650c468be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



