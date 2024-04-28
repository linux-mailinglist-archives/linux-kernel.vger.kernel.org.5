Return-Path: <linux-kernel+bounces-161591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC058B4E64
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 00:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 819B41F20FED
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 22:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DD82E405;
	Sun, 28 Apr 2024 22:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="du89f0oH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C20BA39
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 22:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714341635; cv=none; b=NfD8y6iucqkt4Ac4poeGdKQjagmK8iDzqLWJX8kqPpiJsnxBrLrU5DSe7BDf014+0PpGg4OycKtKtWcUZPjlGFZT0tpcil6snKT5ITaze5SuTvU82SLs6btpuu/vwkDDYoV8Gkqf0wPrSihirq81y/fMw1jnTWThM01V27a3olU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714341635; c=relaxed/simple;
	bh=mpGXIGseswkwy/X0HaEjG1xZ79rl/VqE1STWpXX45A0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EHfo2WXbSpeg9lzRL8EcWnKCeZ9nHzde6kh7dlJG1eGK6mhWnw79XYOf+9pqwH6IlkZjzx+td1nwE/iDUaIvwVbEb+mRI7tCNW+P1ivbjLwsOrKWXFA7YddnWgRicmZgHFGHog0XNKafmx8hEIzQG1L3w5gWWpMesmY6+/h3ezU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=du89f0oH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 173C8C4AF52;
	Sun, 28 Apr 2024 22:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714341635;
	bh=mpGXIGseswkwy/X0HaEjG1xZ79rl/VqE1STWpXX45A0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=du89f0oHiq3nXGlnpyBAUwBEJ2qOsDYuLqcQNeQQEK5UkBu7x3Pbal5O6wvgPNPJs
	 RwcMLzMWK7c7RDcgNj7nE+U+DF6ztXp7Xxc4wR93DpTiIdaNHorNagM9QE27S5Hi86
	 7V9Xjl7LwSH1v2Mlbw42SoFLe6ako4A6b1hakrZ6Hv1q70BDxWuqSpa4C782hHoNNU
	 Mjp0Ussy1rSq+PpgoKN+JGojN18yS2p1t8D318GI9Bl0V6+LABLupZYC9oDP4leX5L
	 vSSoJ6RPBBRblAjBRwDX2XOiBAtU8ZU1DU5PSMPnceu1+SUSgp8tXR+QIDv6w1TjyF
	 +SieVbD/j0+6A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D1C6C43638;
	Sun, 28 Apr 2024 22:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] riscv: misaligned: remove CONFIG_RISCV_M_MODE specific
 code
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171434163504.22130.15555293049692650403.git-patchwork-notify@kernel.org>
Date: Sun, 28 Apr 2024 22:00:35 +0000
References: <20240206154104.896809-1-cleger@rivosinc.com>
In-Reply-To: <20240206154104.896809-1-cleger@rivosinc.com>
To: =?utf-8?b?Q2zDqW1lbnQgTMOpZ2VyIDxjbGVnZXJAcml2b3NpbmMuY29tPg==?=@codeaurora.org
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
 ben.dooks@codethink.co.uk, David.Laight@ACULAB.COM, charlie@rivosinc.com

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue,  6 Feb 2024 16:40:59 +0100 you wrote:
> While reworking code to fix sparse errors, it appears that the
> RISCV_M_MODE specific could actually be removed and use the one for
> normal mode. Even though RISCV_M_MODE can do direct user memory access,
> using the user uaccess helpers is also going to work. Since there is no
> need anymore for specific accessors (load_u8()/store_u8()), we can
> directly use memcpy()/copy_{to/from}_user() and get rid of the copy
> loop entirely. __read_insn() is also fixed to use an unsigned long
> instead of a pointer which was cast in __user address space. The
> insn_addr parameter is now cast from unsigned lnog to the correct
> address space directly.
> 
> [...]

Here is the summary with links:
  - [v2] riscv: misaligned: remove CONFIG_RISCV_M_MODE specific code
    https://git.kernel.org/riscv/c/441381506ba7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



