Return-Path: <linux-kernel+bounces-23740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBA382B102
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D857928758C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2958351C26;
	Thu, 11 Jan 2024 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDDG1Idg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C214B5DD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 14:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CEFDCC43330;
	Thu, 11 Jan 2024 14:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704984637;
	bh=9FCkSsWMxgSl2xN45f2zMDQn+WFyj8ygw9+oME9RILw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kDDG1Idg184euvVFC9dvpy+WY3Dbc5IuDz1ZOQAtAh7ZQo+fCVzD69aJEOXx4Kma/
	 TXOoG+hLZVttYmgEWGPbG6IZG2t2Ox6NroG9sT5ccnIdMCs5JJW5IsevZE5oS/3qko
	 1IRyAGcL2un6j0C4GYzbQzJ/3DYk+aRhYOX/z8ayXTyQhjh7UXHgZrvsD3lpDjS3a4
	 SKkxtURMJBNVu+1NCb/G0fmxpSfJ3jplaSq0iOkSewlI8wkUUTsvQAWh4dOC2czXWj
	 N8byp1bKmhW2OtAvovnOIPkjBxUBgX6pwfuJD2LpWvJzbWbV52qoruXPX9y5DwDcgj
	 J9zSBwq0yZtMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BAE18D8C976;
	Thu, 11 Jan 2024 14:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/2] riscv: enable EFFICIENT_UNALIGNED_ACCESS and
 DCACHE_WORD_ACCESS
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170498463776.20080.6132478533788411387.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jan 2024 14:50:37 +0000
References: <20231225044207.3821-1-jszhang@kernel.org>
In-Reply-To: <20231225044207.3821-1-jszhang@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
 ebiggers@kernel.org, conor.dooley@microchip.com, dqfext@gmail.com

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 25 Dec 2023 12:42:05 +0800 you wrote:
> Some riscv implementations such as T-HEAD's C906, C908, C910 and C920
> support efficient unaligned access, for performance reason we want
> to enable HAVE_EFFICIENT_UNALIGNED_ACCESS on these platforms. To
> avoid performance regressions on non efficient unaligned access
> platforms, HAVE_EFFICIENT_UNALIGNED_ACCESS can't be globally selected.
> 
> To solve this problem, runtime code patching based on the detected
> speed is a good solution. But that's not easy, it involves lots of
> work to modify vairous subsystems such as net, mm, lib and so on.
> This can be done step by step.
> 
> [...]

Here is the summary with links:
  - [v4,1/2] riscv: introduce RISCV_EFFICIENT_UNALIGNED_ACCESS
    https://git.kernel.org/riscv/c/b6da6cbe13eb
  - [v4,2/2] riscv: select DCACHE_WORD_ACCESS for efficient unaligned access HW
    https://git.kernel.org/riscv/c/d0fdc20b0429

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



