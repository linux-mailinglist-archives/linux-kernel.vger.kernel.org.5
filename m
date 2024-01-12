Return-Path: <linux-kernel+bounces-24337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E3982BB49
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 07:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A93F1C24F50
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 06:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309AD5C912;
	Fri, 12 Jan 2024 06:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjp5Iuwg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7051632C62
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 06:30:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03F5CC433A6;
	Fri, 12 Jan 2024 06:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705041031;
	bh=FVagVAk5TngLIrDGYy7HtZKzmrE0BZg0s0H39wCDl8Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hjp5IuwgOjWll0g+JFA7E3RCQ9fxjxrJlNMOWYFGDHjt4q+TUgkz82/mhCmQdLy+H
	 epiqlJ6tfolqvlKKB020lsM317NTebnGFkWx1W+d1VlgnjlMzoDr1ROICe6Nnu6zZk
	 fa8FdA067kw4UzrDfc8BcUey3uDSsCva25PnFnMOXB4hRauEzGKEPx2gkkQ83iMIzK
	 uD2LAmh8JM8Oe+EW/J7sGSy1RzdU9aV7eTDqphGvuNsyU2Ssow+ySoXwAc/H4EpqbQ
	 lTQRN09sp2q/w37GJXyQcfHfeSfDfpfDkPeYdzRsgF89IjVFIfGs0NIVzV/iHCP9g4
	 rjDzfWowt+UHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DFFC3D8C9A1;
	Fri, 12 Jan 2024 06:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Use hugepage mappings for vmemmap
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170504103091.17535.12850336367037808522.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jan 2024 06:30:30 +0000
References: <20231214132935.212864-1-alexghiti@rivosinc.com>
In-Reply-To: <20231214132935.212864-1-alexghiti@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 14 Dec 2023 14:29:35 +0100 you wrote:
> This will allow better TLB utilization and then should be more performant.
> 
> Before:
> 
> ---[ vmemmap start ]---
> 0xffff8d8002000000-0xffff8d8012000000    0x000000046ec00000       256M PTE .   ..     ..   D A G . . W R V
> 
> [...]

Here is the summary with links:
  - riscv: Use hugepage mappings for vmemmap
    https://git.kernel.org/riscv/c/ff172d4818ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



