Return-Path: <linux-kernel+bounces-39314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A38D683CEA4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1B491C21BED
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA2213AA44;
	Thu, 25 Jan 2024 21:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tz3bvmLE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEF15B1E8;
	Thu, 25 Jan 2024 21:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706218229; cv=none; b=B0OQYks+Gti+vrv7Dg5MkgLeEm0y8K4sFQW5mpVmvbfW0FdrNbjtEOonqOpPvEhl5Brr422jYpUjG0AJcnIa31nhVNKKR4gwIv37LtU1sHFO9qGgezYIw3Hkzo4ZqEec4wDEab6k+4VQfnKpGQJ95uJYsCbDz6edj52wVfIJ/vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706218229; c=relaxed/simple;
	bh=hNYJSDfuV3N344eeLzn2sV0t/R5y/+t3qenvX0+jyEM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AB5qDbr54JkPbXjqM5JC9hmfUi1YMqoBN3zyvaIur2v0KZocH80gLMplrCdVcB/TcAqNEtoKDNcjGz7IQo88srsRhc4NpmnMsw8jvoTHJXC2imIVqwdTfRa8A0haKWddyi2skhI/5HQOXWfKAdAGQ+v7wCuLcIOcDxDcN3Ja5Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tz3bvmLE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E478C43399;
	Thu, 25 Jan 2024 21:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706218229;
	bh=hNYJSDfuV3N344eeLzn2sV0t/R5y/+t3qenvX0+jyEM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Tz3bvmLE/rmxmgL8u96UNpX4fNSF3kFV+WFn+GcM5qHSq+1ufb9bbd4244z9/OWH4
	 T2Br5S5wvOZ3Q4M3LifqmzIwTczMXf2aR/8CjdKBDO6F5oCg9/FSO6bWxUV6rdT685
	 4/sMPFu4ucEqpVghNR8TLFjtLqWy7SGWn14zAoGGdbbQEZQ2glBqX5W+yDPzKFrtfG
	 vzdKjyKssqrtSLrHX8PV20HkaCG8WbIjxwLGc1wpsp2jT/o624kj3Q68mpvOp1baFS
	 ZQ/e8HQU5256jE2KRGV3P/FXcR79a0Io2TaGIll69k6bhGa9KhFQQ1KrqIZMTZ9xgb
	 J8foOQUjMZa5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 48EAADC9A05;
	Thu, 25 Jan 2024 21:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] riscv: Increase mmap_rnd_bits_max on Sv48/57
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170621822929.6239.356777907601716533.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jan 2024 21:30:29 +0000
References: <20230929211155.3910949-4-samitolvanen@google.com>
In-Reply-To: <20230929211155.3910949-4-samitolvanen@google.com>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, akpm@linux-foundation.org,
 keescook@chromium.org, linux-mm@kvack.org, llvm@lists.linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri, 29 Sep 2023 21:11:56 +0000 you wrote:
> Hi all,
> 
> We noticed that 64-bit RISC-V kernels limit mmap_rnd_bits to 24
> even if the hardware supports a larger virtual address space size
> [1]. These two patches allow mmap_rnd_bits_max to be changed during
> init, and bumps up the maximum randomness if we end up setting up
> 4/5-level paging at boot.
> 
> [...]

Here is the summary with links:
  - [1/2] mm: Change mmap_rnd_bits_max to __ro_after_init
    https://git.kernel.org/riscv/c/71a5849aedaa
  - [2/2] riscv: mm: Update mmap_rnd_bits_max
    https://git.kernel.org/riscv/c/7df1ff5a5cd6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



