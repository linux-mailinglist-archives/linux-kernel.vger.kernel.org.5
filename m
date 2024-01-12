Return-Path: <linux-kernel+bounces-24338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3349382BB4A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 07:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D76EA1F25707
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 06:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399565C916;
	Fri, 12 Jan 2024 06:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZoKOZ9Iu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7054A42049
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 06:30:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F3B4C433B2;
	Fri, 12 Jan 2024 06:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705041031;
	bh=jekUb0FSVZPvWCqMLLEnDhCHnUsUC5IyzrcXtmJkoMQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZoKOZ9IuihzHcwrt/9jW7znjgqOmpCDPTWVGhMBu0568Xac3cCsUNuuX8bVv2JwUd
	 xzb1otYyIhe3EtzEe4kPVfjeqXy51k6sJSGXTnuIJogGmya4bW2JUn3MLIc7OO9TvF
	 BrS8tcj1RJfZrvpcriWUGrdxKBWH9b/oWYJVyPIHNyWrtz+42/nfCW9VBtz9UVIf8a
	 oxLTDHk4EVyakeEZ/C025+5Q1HGsOUJYQkl+OMjJgJd1UpNBtRA3qBezowVSQjoy9Y
	 shZv2Kw1qPkckk9gyNznM+MzacDcN16R+IPb6SpkQAAhzl7aLsMR8fPwGoBGG9HqzN
	 clSGzXxLo2zBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E8B73DFC697;
	Fri, 12 Jan 2024 06:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V3 0/4] riscv: mm: Fixup & Optimize COMPAT code
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170504103094.17535.18254228443220727646.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jan 2024 06:30:30 +0000
References: <20231222115703.2404036-1-guoren@kernel.org>
In-Reply-To: <20231222115703.2404036-1-guoren@kernel.org>
To: Guo Ren <guoren@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, alexghiti@rivosinc.com,
 charlie@rivosinc.com, xiao.w.wang@intel.com, david@redhat.com,
 panqinglin2020@iscas.ac.cn, rick.p.edgecombe@intel.com, willy@infradead.org,
 bjorn@rivosinc.com, conor.dooley@microchip.com, cleger@rivosinc.com,
 leobras@redhat.com, guoren@linux.alibaba.com

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri, 22 Dec 2023 06:56:59 -0500 you wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> When the task is in COMPAT mode, the TASK_SIZE should be 2GB, so
> STACK_TOP_MAX and arch_get_mmap_end must be limited to 2 GB. This series
> fixes the problem made by commit: add2cc6b6515 ("RISC-V: mm: Restrict
> address space for sv39,sv48,sv57") and optimizes the related coding
> convention of TASK_SIZE.
> 
> [...]

Here is the summary with links:
  - [V3,1/4] riscv: mm: Fixup compat mode boot failure
    https://git.kernel.org/riscv/c/5f449e245e5b
  - [V3,2/4] riscv: mm: Fixup compat arch_get_mmap_end
    https://git.kernel.org/riscv/c/97b7ac69be2e
  - [V3,3/4] riscv: mm: Remove unused TASK_SIZE_MIN
    (no matching commit)
  - [V3,4/4] riscv: mm: Optimize TASK_SIZE definition
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



