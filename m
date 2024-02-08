Return-Path: <linux-kernel+bounces-57368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2E184D78F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 02:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8510B1C228C2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8701E898;
	Thu,  8 Feb 2024 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ry4PZHKt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09981CF9A
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 01:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707355829; cv=none; b=CAcvTL53Wlqf7YH+ycCpvATbcqPeoimBPs+VVAPNpLKcEVhbWGVK/epmDqrwhclRiyxiCs7XIF+4oYMr6+K/LnPSCbA5i3l3jLZk3KUMaqFKrblRHE0gOIX/Bf4RbsxoGi7ZeYVVWpexNTsUzjYS89iZ2J/3+IbRpSq6OHIvSoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707355829; c=relaxed/simple;
	bh=jYYwLLD0cwfcrSOXqzB93y66pQoLtdRRtkWOuQY4Tcs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cocEqm/AfkEeoPiVa72QYY+H+pqt43HhZ45yfD/hKrKU5n2oI6y7kcNv1FCZVo6a7c/lPGT3C2HyyExUrvgqnLAaKPAdcAKjDHzlY3E6pu2vo7Chvtt1ZKopOg4bCZjF9MRfhkBHpAiJ1tdfxUGhIBJOGWXFdHR82JjBe2NkLlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ry4PZHKt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4CBE5C43394;
	Thu,  8 Feb 2024 01:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707355829;
	bh=jYYwLLD0cwfcrSOXqzB93y66pQoLtdRRtkWOuQY4Tcs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ry4PZHKt2T4QCiOzmtdUe9xa5hmTVZOPPqR7Entrs1kU5kxZEvLVtszf3Xx6fWRki
	 tWOfoshV8pMS3HS9cDp9uiLNiU19prV4RCn8HmYOvVRC9KKX2zYIhLgMfUT6pZUpNr
	 uQJzkgt4vhIb1TYQg30lDwcznon7vq7hU1FEseNx9JsqQZcqf+yXXRFPjTjjG7VCPk
	 xIZKeEbyVco4h441qqP7BfCB55CTNzetH3lResw3DS5H8tSsuVHRVtnTjUnvU8e4rP
	 jvHA3//nLw9IP7kICjl4Hyz5/KnKZ9Zz771ydifwh0TcVYW7Ypa0b8SkDFYeUqodSq
	 LH9m//dRHfgJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 266D0D8C97D;
	Thu,  8 Feb 2024 01:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -fixes] riscv: Fix arch_hugetlb_migration_supported() for
 NAPOT
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170735582915.12826.16835732930725743994.git-patchwork-notify@kernel.org>
Date: Thu, 08 Feb 2024 01:30:29 +0000
References: <20240130120114.106003-1-alexghiti@rivosinc.com>
In-Reply-To: <20240130120114.106003-1-alexghiti@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, ajones@ventanamicro.com,
 panqinglin2020@iscas.ac.cn, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 30 Jan 2024 13:01:14 +0100 you wrote:
> arch_hugetlb_migration_supported() must be reimplemented to add support
> for NAPOT hugepages, which is done here.
> 
> Fixes: 82a1a1f3bfb6 ("riscv: mm: support Svnapot in hugetlb page")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/include/asm/hugetlb.h |  3 +++
>  arch/riscv/mm/hugetlbpage.c      | 16 +++++++++++++---
>  2 files changed, 16 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [-fixes] riscv: Fix arch_hugetlb_migration_supported() for NAPOT
    https://git.kernel.org/riscv/c/ce68c035457b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



