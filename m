Return-Path: <linux-kernel+bounces-116517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3730D88A04D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C98941F39E34
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5A913E41A;
	Mon, 25 Mar 2024 07:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZ/b0NE+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF311C2576;
	Mon, 25 Mar 2024 04:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711341755; cv=none; b=GcfYOtFPHZuiEN0TjCQMJWN/8wd+TPUOCtJyGCZPDZoYo/Wt/0KMmSaCrq6JT6KiQYXur+YRcZIlhOpJ/4jIXypKWAEKJnVeT0C6ZBeS4MgzWJhlbBLIkcU7cIcCG67iqXqz6ng30/0wxYZQRXY06588GHzIwgK67MczfdJz8Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711341755; c=relaxed/simple;
	bh=duVRPOkUwtqb9I+6o5VQiYAgtSlpWGf+X+0yQv8TjAs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MWMKsXohZxFE3o8hOmpsPaH6/T+4BT8WFE0HdxtN//tN69grlx1Kwts9UlgyljFJCyAiKvFfWY4c/ho5oS67yhXvaenweWYbeuF80XOX8ELdAvLJrOp+EQfgdfgAzd3otFXyGo+npsE0MoHJWdHOSlm+cRRHLVmsoig5ErdjeMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZ/b0NE+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5273C43399;
	Mon, 25 Mar 2024 04:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711341754;
	bh=duVRPOkUwtqb9I+6o5VQiYAgtSlpWGf+X+0yQv8TjAs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iZ/b0NE+i7+do8pgZkg46x1uBB/MQJfp/c/XhpH71z/wGKatNJQnfFVi4TsSrJUcx
	 p9B9v3m0m2h+2n352ZneEdcJs25ZuYmCkptcEJJi14CEjUg6fZRWGQjsnzSbTTqpuQ
	 jBLNyyJKgrClKH6Ar2Sk8/u0rVBaZT96gqSwdlSHBYKiJ8LneSrMklScm8Ww85dTEe
	 eja5sWn2jN4CV4FDoeaf5TOJPL86Efy9rTKDI0W7hc3GLlwluHdA9GYm7yTBbMYg6F
	 MrrxjzojsaA/BYbk4OYMb2sE8+b4REldcJ8JhTboSwFB0wiYQTm1AKpQdnuWO2wot9
	 CNckLCoG3Oykg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F5E8D95071;
	Mon, 25 Mar 2024 04:42:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 00/11] Bump the minimum supported version of LLVM to 13.0.1
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171134175464.18749.18342004135343709281.git-patchwork-notify@kernel.org>
Date: Mon, 25 Mar 2024 04:42:34 +0000
References: <20240125-bump-min-llvm-ver-to-13-0-1-v1-0-f5ff9bda41c5@kernel.org>
In-Reply-To: <20240125-bump-min-llvm-ver-to-13-0-1-v1-0-f5ff9bda41c5@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-riscv@lists.infradead.org, akpm@linux-foundation.org,
 masahiroy@kernel.org, nicolas@fjasle.eu, linux-kbuild@vger.kernel.org,
 llvm@lists.linux.dev, patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, linux@armlinux.org.uk,
 ardb@kernel.org, linux-arm-kernel@lists.infradead.org,
 catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, aneesh.kumar@kernel.org,
 naveen.n.rao@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 conor@kernel.org, keescook@chromium.org, linux-hardening@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Thu, 25 Jan 2024 15:55:06 -0700 you wrote:
> Hi all,
> 
> This series bumps the minimum supported version of LLVM for building the
> kernel to 13.0.1. The first patch does the bump and all subsequent
> patches clean up all the various workarounds and checks for earlier
> versions.
> 
> [...]

Here is the summary with links:
  - [07/11] riscv: Remove MCOUNT_NAME workaround
    https://git.kernel.org/riscv/c/de5f3984664e
  - [08/11] riscv: Kconfig: Remove version dependency from CONFIG_CLANG_SUPPORTS_DYNAMIC_FTRACE
    https://git.kernel.org/riscv/c/a38d97181271

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



