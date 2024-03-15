Return-Path: <linux-kernel+bounces-104696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E7E87D27A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBECA1C2232B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76054CB23;
	Fri, 15 Mar 2024 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONxLMrvp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025EC4CDFB;
	Fri, 15 Mar 2024 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710522630; cv=none; b=c/aiaC/vFg3CUZPh0hrQsH0cJ8C4lJZzuLNLi6GB5yY8le6DGCYpgJEAf5ZYKCzg/OeA5e5yV2izLy1N4tS69g9F4FDeIQ7fyok1Gb01278lwfLCd8GbhRa3mOYVzlXOP2YyhbcGqjHahZSbVHcQ1Q924/Kb6SFLpbLLlwLFMV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710522630; c=relaxed/simple;
	bh=IcN0xBYoNPMuv5kaV1A3idubvfeUPGuxppadM5+B6x8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CdeWp8mfLajVKW1y8gQ1K0Scli/kRbTQfWFIYRCk3Q4+TDj10XZbJcsD4o6BAMnze8Oi517AtEZmDqpAUACWQiFcRXmhBxdRD94uzDone9mAwBhGdDjm/asai92YxZJp/gezY7Ajtf9n8OVOdBPwNnczT/ffs0MczUmXDBUnskI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONxLMrvp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96D2FC43394;
	Fri, 15 Mar 2024 17:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710522629;
	bh=IcN0xBYoNPMuv5kaV1A3idubvfeUPGuxppadM5+B6x8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ONxLMrvpedR+S5leND6Vlc5GR6gkvaZAJalaSuPV8/RkUkzDL4Svuu+LhmTc/dQ8+
	 nZuSa1ioQpQuse0AErwI+XEK4tVMMcQbq/j6/0fNULHBIRsRqKd8BIlsqE0JG2LlIi
	 4QyGOqzfFIztNb9ieh7JQyV/brRkFPQhPzh41xlSfAChQpf4Be0QGJc/UJBmgYnNqg
	 raUEjhE+rOOn5Gj+9HTXaVxbwMf87CYtUnxOBqgA40yw/r4RkAeR1bfKAtA8UwoeRI
	 Afe+ORMlx6WrqVM00P1EyRAxzcHyw/KDKmiW2NtTLlezedmfk05Odh/e0ej1+r2f9y
	 CX9xXvNSQnjpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 87CE4D95053;
	Fri, 15 Mar 2024 17:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Fix compilation error with FAST_GUP and rv32
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171052262955.24036.17671900983651280481.git-patchwork-notify@kernel.org>
Date: Fri, 15 Mar 2024 17:10:29 +0000
References: <20240304080247.387710-1-alexghiti@rivosinc.com>
In-Reply-To: <20240304080247.387710-1-alexghiti@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, rdunlap@infradead.org,
 sfr@canb.auug.org.au, linux-next@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon,  4 Mar 2024 09:02:47 +0100 you wrote:
> By surrounding the definition of pte_leaf_size() with a ifdef napot as
> it should have been.
> 
> Fixes: e0fe5ab4192c ("riscv: Fix pte_leaf_size() for NAPOT")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/include/asm/pgtable.h | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - riscv: Fix compilation error with FAST_GUP and rv32
    https://git.kernel.org/riscv/c/2bb7e0c49302

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



