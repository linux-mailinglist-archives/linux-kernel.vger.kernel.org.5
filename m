Return-Path: <linux-kernel+bounces-138742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E514B89F9C6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2272A1C217F8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA9615FA68;
	Wed, 10 Apr 2024 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8vc0L8S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C228215EFD3;
	Wed, 10 Apr 2024 14:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712758833; cv=none; b=rbgmjldMgkkwtiQcNL5XFRbJzk1H2bqdn5daz7wzenJDKyaJk5Erkp8JvssF2o1NYmy3VUMPXHvNx36KWF4xKdQql+OKx4HGjywOqSoWd+Zrs7grBsLbkoPfCOXIZ1kRe9M0hAsh10aN+/PFgYKmNT/6hILpXommYHR1hWd+88A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712758833; c=relaxed/simple;
	bh=96EroGBucN/XgCKG058lK4TrE/wjf9osJZ/hchKA2Qc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S6Hhv6S3XBGFzQMG2ENRphWWAhohSixc9sChKIS05PJdBobyzj+pP2gxyTzhu+OG4hcr+ft9vXfb9orboajlPzK838fTXQQAAEf/kpjtTLcGWuUlXFexCPotHqRuKuq+fqhk6l0U9B7ckgAWoS4xCkifKhRbITRv16DVpOio2dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8vc0L8S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69078C43394;
	Wed, 10 Apr 2024 14:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712758833;
	bh=96EroGBucN/XgCKG058lK4TrE/wjf9osJZ/hchKA2Qc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q8vc0L8SS+ED/SjnwXPSCTK/WjTR5+3x7tIMpmnNdvBupgN/Lc/A7g2ygw7978BME
	 miUzhSbeVbmDcWBMp1ZA9Dnf1PWEU4hklH0n1CJJ7ytWmLcoWow0ptvKXloPkIOiT1
	 Nl3QJ/MXEcttk4CsgHCiVJoN95uTi2g1s/VYhyIt8ExwomIk5xQPa72ls1vF8SV5Ab
	 MV0FoVmc0YTIfDcL8x8Ms/hfsLGG0CJ8mlCY2+aSU1470yOkK/C04J3U/n4TkQlwfM
	 K9usfAt75uDvCBr7H0FyG1R+P2hiXESDbTenHwZiiT5oQLYCZdEsTOF/Pztoe+Otpn
	 hNDYfBKwNLAUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5ACFDC395F8;
	Wed, 10 Apr 2024 14:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/1] RISC-V: enable rust
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171275883336.18495.14519035632596668351.git-patchwork-notify@kernel.org>
Date: Wed, 10 Apr 2024 14:20:33 +0000
References: <20240409-unsaddle-skittle-c93eb77732bb@spud>
In-Reply-To: <20240409-unsaddle-skittle-c93eb77732bb@spud>
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org, conor.dooley@microchip.com,
 ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 corbet@lwn.net, paul.walmsley@sifive.com, palmer@dabbelt.com,
 nathan@kernel.org, ndesaulniers@google.com, rust-for-linux@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue,  9 Apr 2024 18:25:15 +0100 you wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> I've intentionally not turned on the gcc support, as discussed on
> v1. I've also switched over to using the target, but it is a bit heavier
> than the one arm64 seems to be using. RISC-V has fewer targets available
> and this was the closest. I preserved the redzone disabling, just moved
> into the Makefile. Any comment from Gary or the LLVM lads on the target
> would be great I think:
> https://github.com/rust-lang/rust/blob/master/compiler/rustc_target/src/spec/targets/riscv64imac_unknown_none_elf.rs
> arm64 is using:
> https://github.com/rust-lang/rust/blob/master/compiler/rustc_target/src/spec/targets/aarch64_unknown_none.rs
> 
> [...]

Here is the summary with links:
  - [v3,1/1] RISC-V: enable building 64-bit kernels with rust support
    https://git.kernel.org/riscv/c/81889e8523e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



