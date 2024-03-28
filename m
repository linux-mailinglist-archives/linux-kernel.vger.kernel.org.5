Return-Path: <linux-kernel+bounces-123142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2733D8902E1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F67A1C2A37E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD2712D74F;
	Thu, 28 Mar 2024 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbTZ9kTs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163FE80630
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711639229; cv=none; b=MhULSEqSBwhbRstPN8byczHIUcAbDhmbINtXd5uTyzXGDHqrE5dri7DupZh9VNSURJNMsfeipzLKQyyg6BnyZCQqznhW/Kiw6wnWjAFlM3WUnm9JyTNvvhpIIOlxJclvG+PcZ1GWw896xvRYOrVM2VhSNBpPmAVgwKzDxvjgQXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711639229; c=relaxed/simple;
	bh=jTAzDTiUZK9YosY1rfWt3V+wutEmog7rEf70mVoUnPQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F8Iu95XG4dKtmPeQbagGBmS+LN/RC0kw2onLnbkeKe+Z3ghZWhcxkEJe4iT5WvyOcxGvYslUs7ZIrH0/D3xUz1VUj/1D7yGkUMTcFlPPyLCb9mueJ01PYH1WNq648VNsq/UZfFmGIkJdqf8ZaEgf/NqxagOvmdlaN9X+oyTtz/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbTZ9kTs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7BF6FC433F1;
	Thu, 28 Mar 2024 15:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711639228;
	bh=jTAzDTiUZK9YosY1rfWt3V+wutEmog7rEf70mVoUnPQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VbTZ9kTsOT4a0gug/069OrFubPXyX5RXEarFN6Mg/DhRqR5szDvhx/GdOQs7TBVHT
	 AB/QAl/bG3FaBDzam9KDnkeNAZf1CiSI0rA7jr9VF6c0TU3mNau8DkPL1ZnK4eJYEj
	 0gPhkuWG802nmLovc7YN2UAi40/tPfKGU36edXu1DuUTy6nDB4tqkA5kuTB3AtlksB
	 94qsKUn4xapAusHi5NnGdydeKqAG/99U9g4Y3aQHSUPpNfSX/dHNhKA/Rq3G6tX/uD
	 GV7jat7K0MQgBga5i1NanNZD38r/Iu9B7WmNuYWa5oAHM3HgLbf7GZkKCfN7/twAvG
	 GbuUo6kUDGx1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6994CC43168;
	Thu, 28 Mar 2024 15:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: compat_vdso: align VDSOAS build log
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171163922842.29744.11808016865919276594.git-patchwork-notify@kernel.org>
Date: Thu, 28 Mar 2024 15:20:28 +0000
References: <20231117125843.1058553-1-masahiroy@kernel.org>
In-Reply-To: <20231117125843.1058553-1-masahiroy@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri, 17 Nov 2023 21:58:43 +0900 you wrote:
> Add one more space after "VDSOAS" for better alignment in the build log.
> 
> [Before]
> 
>   LDS     arch/riscv/kernel/compat_vdso/compat_vdso.lds
>   VDSOAS arch/riscv/kernel/compat_vdso/rt_sigreturn.o
>   VDSOAS arch/riscv/kernel/compat_vdso/getcpu.o
>   VDSOAS arch/riscv/kernel/compat_vdso/flush_icache.o
>   VDSOAS arch/riscv/kernel/compat_vdso/note.o
>   VDSOLD  arch/riscv/kernel/compat_vdso/compat_vdso.so.dbg
>   VDSOSYM include/generated/compat_vdso-offsets.h
> 
> [...]

Here is the summary with links:
  - riscv: compat_vdso: align VDSOAS build log
    https://git.kernel.org/riscv/c/7115ff4a8bfe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



