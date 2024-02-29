Return-Path: <linux-kernel+bounces-87619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 583C386D69A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A4331F241B4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B4974C03;
	Thu, 29 Feb 2024 22:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/ULrF8O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC886D537
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 22:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709244635; cv=none; b=aCVxBwggM9QUteooCjjwQniNgdxCX5un2XT5g4kQWHnZftbapMpJB6QHgfjkkgEzy4hyy59HRPZo6ZbqHVjBWV7hxhX1lUV/oZG8pDhUussz1a8Y4wYgpcto+uYnT8vsaK1ygTIdIVixJB5GD1gF99NCNaR4VcHaIYKCIATLuGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709244635; c=relaxed/simple;
	bh=mEa78pmFlx7uzj88hY9fhULP5AYaPKAw9Rly9cHD/m0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SKwFEaY/Q4qBoYSDPVu4h+fAq9YSFxPTyM4yfhxcpxfBoaRp4pdoxpQuJqkmNYlXpJBGJzWFLAuXMigi37ONM888A8YvZZ6okntC3kQlLIN5yM/B48Qekk6dF5SuEj4Pe8Ly/6hoq56V8jDmk7C7ttU4hQtgY9GcspxMguvA2UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/ULrF8O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4F0BC433C7;
	Thu, 29 Feb 2024 22:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709244634;
	bh=mEa78pmFlx7uzj88hY9fhULP5AYaPKAw9Rly9cHD/m0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J/ULrF8OdiLCmDlhOBTOVOmM8b2JDA1SNaYcKe/CZcp8T66VhPsiuW6uQGW4xH++L
	 usg+oQyTP6a5Ko2IoLDhy0LAr3Eahou/LrbJ6qG4qZYlKmGGu85yq+z6Z5Z3Ak8Dsx
	 JX/TaoBn/3g5vZ43hR60HSoQ3PrkwTbwlifZOGD5MMpx4ArB8zNx+gCVqHJy+6+NuI
	 zdzAARExjKYlOKyOJNDp9EZENAo89igAyZpKDEh1wrvtsU76JHR5PNez10JfTwo5wX
	 wxyd2zSrCvkCpD/g8mYhPJN34l9gIeYMvrtzefRPb3Pl72HqJ8G+U5jMCwCBYnySjn
	 lzvPipjaD8FgA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8FD33C595C4;
	Thu, 29 Feb 2024 22:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -fixes 0/2] NAPOT Fixes
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170924463458.14902.8377993668813531698.git-patchwork-notify@kernel.org>
Date: Thu, 29 Feb 2024 22:10:34 +0000
References: <20240227205016.121901-1-alexghiti@rivosinc.com>
In-Reply-To: <20240227205016.121901-1-alexghiti@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, ajones@ventanamicro.com,
 conor.dooley@microchip.com, panqinglin2020@iscas.ac.cn,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 27 Feb 2024 21:50:14 +0100 you wrote:
> This contains 2 fixes for NAPOT: patch 1 disables the use of NAPOT
> mapping for vmalloc/vmap and patch 2 implements pte_leaf_size() to
> report NAPOT size.
> 
> Alexandre Ghiti (2):
>   Revert "riscv: mm: support Svnapot in huge vmap"
>   riscv: Fix pte_leaf_size() for NAPOT
> 
> [...]

Here is the summary with links:
  - [-fixes,1/2] Revert "riscv: mm: support Svnapot in huge vmap"
    https://git.kernel.org/riscv/c/16ab4646c905
  - [-fixes,2/2] riscv: Fix pte_leaf_size() for NAPOT
    https://git.kernel.org/riscv/c/e0fe5ab4192c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



