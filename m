Return-Path: <linux-kernel+bounces-35816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 874BC8396E8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 327A51F25430
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0429081AA2;
	Tue, 23 Jan 2024 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txpf10q3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4318D811EF;
	Tue, 23 Jan 2024 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706032230; cv=none; b=iz3i0Wwijyflc3yjZAe0nL6NohPet2StYWOke9HukTsN1eKvwBuK9+47Mut/4DriwiAWe379R2vgnSF6W20nPDW9xEb8f+09xuy+yPokM4M/kaLhTAB4twmzm1ehd4MF4BBkSBnJOIk+O1QStbyxJceuBhrqr2ChnkB+S9EzDrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706032230; c=relaxed/simple;
	bh=Fg0kjr4p02yeL0dd3zpR20S3rY7QojmBvz5b3eZjGMY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t/7X9rPUn6/iVl8xleW6DJQ+hECArk7h3xkZ5hR9RSFYri9UlK9ey//CgkMCi6FLRD9xBqeb+RXBxKIK7qrb3ispd7KqacF1A9UkRx3tmg6cTmvkXxzL+QysyLRi7MraPLLAODRJOQk9upWDnCq0Gj5Wcj8qCsjKO712sXl6O6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txpf10q3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EBB36C433C7;
	Tue, 23 Jan 2024 17:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706032230;
	bh=Fg0kjr4p02yeL0dd3zpR20S3rY7QojmBvz5b3eZjGMY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=txpf10q3NNT5p/ZbgP37oRGugwd240cA5vlkhPPYdaRJzCLdrHhvFpUFCPEMJvdAD
	 xHdEDErc2MfD1gyre6Yn+ca6xxFLR7yr+85zx0RdnnL1BCGGswRkJAsvES7qddTc1d
	 jXwQsyD0oj1QSTgwEO6jGiRAiOhSdWqr5z9gsN/UngCkaXRVzgkj/LJaQuHuds8K8n
	 iMR4tJaYy4qu9h+/Y9z2w6Gk+HhYN1ICqFGRoUhk8bLLes+8SCbMZLCV39Zd4Ndqs6
	 83fxqyG93y/qRDVzoRnByqO4vwlsEz+ZMRxeV8YOyxJO6VIvepdfJuTlcVfjkUmvu7
	 K32Es2dZEBglQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1D0CDFF762;
	Tue, 23 Jan 2024 17:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 00/10] RISC-V crypto with reworked asm files
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170603222985.30461.5962076100762100573.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jan 2024 17:50:29 +0000
References: <20240122002024.27477-1-ebiggers@kernel.org>
In-Reply-To: <20240122002024.27477-1-ebiggers@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu, andy.chiu@sifive.com,
 ardb@kernel.org, christoph.muellner@vrull.eu, heiko@sntech.de,
 jerry.shih@sifive.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
 phoebe.chen@sifive.com, hongrong.hsu@sifive.com

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sun, 21 Jan 2024 16:19:11 -0800 you wrote:
> This patchset, which applies to v6.8-rc1, adds cryptographic algorithm
> implementations accelerated using the RISC-V vector crypto extensions
> (https://github.com/riscv/riscv-crypto/releases/download/v1.0.0/riscv-crypto-spec-vector.pdf)
> and RISC-V vector extension
> (https://github.com/riscv/riscv-v-spec/releases/download/v1.0/riscv-v-spec-1.0.pdf).
> The following algorithms are included: AES in ECB, CBC, CTR, and XTS modes;
> ChaCha20; GHASH; SHA-2; SM3; and SM4.
> 
> [...]

Here is the summary with links:
  - [v3,01/10] RISC-V: add helper function to read the vector VLEN
    (no matching commit)
  - [v3,02/10] RISC-V: add TOOLCHAIN_HAS_VECTOR_CRYPTO
    https://git.kernel.org/riscv/c/34ca4ec628de
  - [v3,03/10] RISC-V: hook new crypto subdir into build-system
    https://git.kernel.org/riscv/c/178f3856436c
  - [v3,04/10] crypto: riscv - add vector crypto accelerated AES-{ECB,CBC,CTR,XTS}
    https://git.kernel.org/riscv/c/eb24af5d7a05
  - [v3,05/10] crypto: riscv - add vector crypto accelerated ChaCha20
    https://git.kernel.org/riscv/c/bb54668837a0
  - [v3,06/10] crypto: riscv - add vector crypto accelerated GHASH
    https://git.kernel.org/riscv/c/600a3853dfa0
  - [v3,07/10] crypto: riscv - add vector crypto accelerated SHA-{256,224}
    https://git.kernel.org/riscv/c/8c8e40470ffe
  - [v3,08/10] crypto: riscv - add vector crypto accelerated SHA-{512,384}
    https://git.kernel.org/riscv/c/b3415925a08b
  - [v3,09/10] crypto: riscv - add vector crypto accelerated SM3
    https://git.kernel.org/riscv/c/563a5255afa2
  - [v3,10/10] crypto: riscv - add vector crypto accelerated SM4
    https://git.kernel.org/riscv/c/b8d06352bbf3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



