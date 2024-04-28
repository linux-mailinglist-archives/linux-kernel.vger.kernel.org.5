Return-Path: <linux-kernel+bounces-161593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 181D48B4E67
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 00:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 309061C208CE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 22:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3682E417;
	Sun, 28 Apr 2024 22:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFeghbzq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8047FC133
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 22:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714341635; cv=none; b=Eg0CX1LjCVVPURjuQa2NPfoXK9Fhfy0QIjmETrVE1E7XMdjNJcSDFnr0IgfamJOYiIgVsDcNmqLUn4qz1WvAjS9bew0/PKv970X480FE8VpvETXbi2i1lpp29izLiL+1SnbJXsP6jCJ0MsX2oi2Mcaw9hdtjMF6KUrdO/6HsAEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714341635; c=relaxed/simple;
	bh=1qKdoG5YY3wg6nGACjGnyUqKx/CBlKjdroaK1d6lOZE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uZ8RQMm2vwNBrCwGrlJBrb6OQtLM6tckk62Sxgwf0JUmtxR8WRE1juflUBxWnU7RMUVl1bfoRTqBoKkOAJAvXbEMKeF+LgBkoHWIwGps9R+D8LTjfA1p8q2oDi9iWLceFUuc/O0bslhO8huD9BytKn4neZ0jJuWjcz2c3LKBzy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFeghbzq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0068BC4AF48;
	Sun, 28 Apr 2024 22:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714341635;
	bh=1qKdoG5YY3wg6nGACjGnyUqKx/CBlKjdroaK1d6lOZE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HFeghbzql4bMYzZIZzMwrY/cJxzzroAHUTYm8CZrt629PrXpzWfsQFdoaiF8c0PpR
	 6/RdkuKiAXl1ef0bLNgzstq9S74gLksVVtkwPo33McWWm0G9Bbc7Y94RRXRlAiwrqn
	 uQsLRe2guNwISkkorZQxrVDj+fvfzS4dchrRTiO9dE+aB0AWACZXtSP56A/lxxa/Py
	 V42r4wUV0X0pKboZ676asOQrXEJ2AWnCdqesyMTkYuLxB0gT7HbG4B00607la6dAyX
	 gGrTgErXblfTh5BCiu169CpnY09FRGI5ZDgPagZC0l3i1Jeg/B/ldBdzbo46GaHAor
	 2cgJ0FCRa5ylA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E8913C4361B;
	Sun, 28 Apr 2024 22:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 RESEND 0/2] riscv: enable lockless lockref implementation
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171434163494.22130.17509097464954916168.git-patchwork-notify@kernel.org>
Date: Sun, 28 Apr 2024 22:00:34 +0000
References: <20240325111038.1700-1-jszhang@kernel.org>
In-Reply-To: <20240325111038.1700-1-jszhang@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 25 Mar 2024 19:10:36 +0800 you wrote:
> This series selects ARCH_USE_CMPXCHG_LOCKREF to enable the
> cmpxchg-based lockless lockref implementation for riscv. Then,
> implement arch_cmpxchg64_{relaxed|acquire|release}.
> 
> After patch1:
> Using Linus' test case[1] on TH1520 platform, I see a 11.2% improvement.
> On JH7110 platform, I see 12.0% improvement.
> 
> [...]

Here is the summary with links:
  - [v3,RESEND,1/2] riscv: select ARCH_USE_CMPXCHG_LOCKREF
    https://git.kernel.org/riscv/c/eb1e50372946
  - [v3,RESEND,2/2] riscv: cmpxchg: implement arch_cmpxchg64_{relaxed|acquire|release}
    https://git.kernel.org/riscv/c/79d6e4eae966

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



