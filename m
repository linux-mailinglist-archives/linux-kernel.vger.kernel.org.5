Return-Path: <linux-kernel+bounces-39317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 593FF83CEA9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBB3D1F28C09
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B6913AA51;
	Thu, 25 Jan 2024 21:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJN1C2EG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E850413A26E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 21:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706218230; cv=none; b=Hlk7k2r22RYexW6o0yGK2zHze5LBFM7Y1smJc2xJxaFt8ILUcT6JDpnAbjFoFOXGSUMz0It3nJlsSaElQwsiCMC+D/2PRtO7ogKxwAL0uJAv1NnAv8kVG+7yWBUZAKluKJllAzvQWCLbyfp6N7xw2PTsy5FZ7g+whciOoy/sc6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706218230; c=relaxed/simple;
	bh=0c77Px4FgFzSMDDopX9HQK54i0DhuO6fgk/RYUZ7kto=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eGmBkElYbjDXnzzDIp4vxFfjR9FHU6lhcojoZvTMmbARJxKnL/GSkY9E5IbodhtqzNg9qTC6YREfGNI5dwtgaR5MFoMNvuw10hDVMqb6/ESLJIbND+8/Y9UE3C9bktRGl00Nmw3nOQus46cffBeTG5IBp7ii05veKIH1ZivozaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJN1C2EG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D5FDC433B2;
	Thu, 25 Jan 2024 21:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706218229;
	bh=0c77Px4FgFzSMDDopX9HQK54i0DhuO6fgk/RYUZ7kto=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YJN1C2EGISR9CofRVEJLO5WTqYVsqTyEafbuz9HXFhB3nO2Gc6cxsX/dqnSrHR+BB
	 YcKwRlaicZji+pTptYuomsuowAbnnqda0H4m9w8VNUel1kJhla6qY7Iuk+vmzxlZ6x
	 65phPPiHu0hEvEBYKvD0Bb4Y8xpD14K/FUuvKsZNWACe+2jsnyGFeRn2IFnkntr+qi
	 Usw2/ivEMl0B8dV/us4zHDcur/RKpa/4zJux37NvwrFtbH0oEOS0moVLPwGauzaeuZ
	 UDKbDiWGbdpD3WFPdILH28kl25+H0hsyOpxAIOukVQMM0ChCxbQUmJUg4h2pmhQLoh
	 9sQ95lHHpmHFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 52E22DC99E0;
	Thu, 25 Jan 2024 21:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next] RISC-V: Remove duplicated include in smpboot.c
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170621822933.6239.12409482420137215453.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jan 2024 21:30:29 +0000
References: <20231031004018.45074-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20231031004018.45074-1-yang.lee@linux.alibaba.com>
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
 abaci@linux.alibaba.com

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 31 Oct 2023 08:40:18 +0800 you wrote:
> ./arch/riscv/kernel/smpboot.c: asm/cpufeature.h is included more than once.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7086
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  arch/riscv/kernel/smpboot.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [-next] RISC-V: Remove duplicated include in smpboot.c
    https://git.kernel.org/riscv/c/dded618c07fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



