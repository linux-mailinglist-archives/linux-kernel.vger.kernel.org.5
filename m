Return-Path: <linux-kernel+bounces-57366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAAD84D791
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 02:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9570C1F2385A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F89B1E89A;
	Thu,  8 Feb 2024 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nh4izxvv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C090B1CD2E
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 01:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707355829; cv=none; b=NQtOCYug1+6AUCxTbb0EYIGi22xPoDF0ggreumQDVuhbcxMJgxA2xciqmU/Th50fDttPopUCiRc2N5MqVQb1mRY1KXipElnZBLOXiqr1IO6E5cd6PuVpgzakshkWjGJkDrL5/D+aGzqGscGMY26z30hBCgbhfumDjI57weUxy2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707355829; c=relaxed/simple;
	bh=J3zyaMpO6Yajzz/cHVlPUFGg7dudckSRxCcFJRXqZ+E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SUIewJF2ZP1K3EwE6ZsVps5CCC32vNm2zn2ejYC4sJCbsF1fzF0yAlw8HhjE7QCNBIysXAvPxiLzyR0dOFcfdmAlWcm8M/DXPOc3jUKZkV5ivF4B2cnG73acltkhdOxMflBMpMZO2+uNDl+WfFXz2TwSJHhqWP3EatndNWLyukw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nh4izxvv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B63BC433A6;
	Thu,  8 Feb 2024 01:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707355829;
	bh=J3zyaMpO6Yajzz/cHVlPUFGg7dudckSRxCcFJRXqZ+E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nh4izxvvNvT+KDqNgaWRhC7BmcIYgB8gmpFSdFKqY7WKSuGCsqcWkwS/qa3fEJTG6
	 kG/Aa8+ryx3mxXUEZiQIIRY86YZM5ThWJzuAl0v5q91IZ1CE17uz/VtWTtdauTjQez
	 Torqgz3KvjJ6Iubzr0c7nmkjRCjGQrczfPxV68zKG7Dbr7pyLsMGatCz9HDG02m4L3
	 ock9BI6ZvwCaNFpayxsB6vyGl2pOBLD9r5KXfiuXuWENlAFNfJt9h1YObP3nOSXZYz
	 dSu72ySE79DlBI5A+9R2lAkEwRBbATorKwAsJ046tnZCvavw8Z/5wm8YStHEIXM3g4
	 ruY5YPNZCcNrg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3140BD8C96F;
	Thu,  8 Feb 2024 01:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -fixes] riscv: Fix arch_tlbbatch_flush() by clearing the batch
 cpumask
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170735582919.12826.5541680034564428573.git-patchwork-notify@kernel.org>
Date: Thu, 08 Feb 2024 01:30:29 +0000
References: <20240130115508.105386-1-alexghiti@rivosinc.com>
In-Reply-To: <20240130115508.105386-1-alexghiti@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, jszhang@kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 30 Jan 2024 12:55:08 +0100 you wrote:
> We must clear the cpumask once we have flushed the batch, otherwise cpus
> get accumulated and we end sending IPIs to more cpus than needed.
> 
> Fixes: 54d7431af73e ("riscv: Add support for BATCHED_UNMAP_TLB_FLUSH")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/mm/tlbflush.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [-fixes] riscv: Fix arch_tlbbatch_flush() by clearing the batch cpumask
    https://git.kernel.org/riscv/c/3951f6add519

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



