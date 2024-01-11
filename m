Return-Path: <linux-kernel+bounces-23738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9B082B103
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 687ED1F25307
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109A451034;
	Thu, 11 Jan 2024 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRPkfA0l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9494B5C9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 14:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16038C32778;
	Thu, 11 Jan 2024 14:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704984638;
	bh=sxh40JJQMoRZqXunjJmrdXyyxH+F75rmhC8LiUGqhE0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kRPkfA0lip75TvmCFQUcSzqgumSiQtZ+YPmRhQRBD/E10A8e4L30WM/Mm70ctz+uM
	 nJ5Aq2dEBNBVVPwuxppzz6EXd1lLlPGhwV4s32x/P+SeOfpwOY/SSK23ArBxSOh5Mr
	 TL5sWbLVYLboYp1J1fnVCLjyDKOl2noLagjJuAX3Xvhkmn7yWvuZUWtLoaTpVVXYHm
	 74iIsYZIVhlJ/w6rO6xe1IKghnmsbgk+fmmZZpGFZXHGe9O+REHc8/M/5s5/mih030
	 MEP1KsEo8LHPYIZvaoMJzLSPewDrsnBlfmkqCp2bY4G+E6kl0mXNjGQIg33UqoP5/a
	 sMI0u3IaBOkNQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0222AD8C96C;
	Thu, 11 Jan 2024 14:50:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: fix __user annotation in traps_misaligned.c
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170498463800.20080.16588164711212512128.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jan 2024 14:50:38 +0000
References: <20231123141617.259591-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20231123141617.259591-1-ben.dooks@codethink.co.uk>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 23 Nov 2023 14:16:17 +0000 you wrote:
> The instruction reading code can read from either user or kernel addresses
> and thus the use of __user on pointers to instructions depends on which
> context. Fix a few sparse warnings by using __user for user-accesses and
> remove it when not.
> 
> Fixes:
> 
> [...]

Here is the summary with links:
  - riscv: fix __user annotation in traps_misaligned.c
    https://git.kernel.org/riscv/c/ca0e433b41a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



