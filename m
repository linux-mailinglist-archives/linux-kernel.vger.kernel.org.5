Return-Path: <linux-kernel+bounces-85243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDE486B2CD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 213111F287BC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E7C15B995;
	Wed, 28 Feb 2024 15:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4goeIk4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E8715B992
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709133031; cv=none; b=lOtD8PaVx6wIrUp3W6PE15WVPbN8wQ3iaJiZdZ4JTwPQHT6VTegMxsYGp7bnZhAZj92Y3A6K811L+ee40LhFuxlAO9U4JJXzNskDWu9lcR6nXits7aPPK1w0trmw+Dl+Cag2sVeprAoLhVqVabI9KLT/9eIoSUIbCfmtaMHS6CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709133031; c=relaxed/simple;
	bh=6FVRBR8jkQw+3lkUXhMUDt/EFHO2AhiOr7rXMH2y+q0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Yww5Jdkz5LhZ0Ydn3Dwoa2aQAq8OZVIyMrbs8tcCJwnJpxGu0E7OfFj2D5M2ESEEMMBbpqc+1RkWmwFXusHgAHLaomvRiCfaMABo9LgrJbx/lBXbUDZgItoEli7syyR4kA+JNfjYAHYPKx9VHw2Wil2s4H8qQEC37G/H8wOqjB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4goeIk4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9EBFC43390;
	Wed, 28 Feb 2024 15:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709133029;
	bh=6FVRBR8jkQw+3lkUXhMUDt/EFHO2AhiOr7rXMH2y+q0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h4goeIk4xtRGMH9+CnkQf3kPkBQ6mVhd9S+c+XK5JUvJFXiZMfsao3tRz9b46/1kx
	 5QM98/OMMTR1+RZyk+RN3usJqM89sJdQu4iBLgvFp0gzHBoq1ikkYwNbPIDCWxE8aF
	 y/suAQzsWnq64U/75VPvPOhNAM/wYBnEE9IfSeoJ8yULkudB9Iu1OpE6GFEdJXnxTr
	 8K1ZeSSqs+TKMX5Hfrki4PPSqa/A6KhrZak8xDeLNlDQSFbTxOrBOVKrvjBjPiZHBM
	 QVKikH5b3jFDVfzxnrrYHD33fzBi+znAy53P+gm6v8dO66FLQzBvNN8nvRmtsytklJ
	 X9sk/Nyjs4u6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BA96CD88FB1;
	Wed, 28 Feb 2024 15:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2,RESEND 0/2] drivers: perf: fix crash with the legacy riscv
 driver
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170913302975.9913.9405105778490456621.git-patchwork-notify@kernel.org>
Date: Wed, 28 Feb 2024 15:10:29 +0000
References: <20240227170002.188671-1-vadim.shakirov@syntacore.com>
In-Reply-To: <20240227170002.188671-1-vadim.shakirov@syntacore.com>
To: Vadim Shakirov <vadim.shakirov@syntacore.com>
Cc: linux-riscv@lists.infradead.org, atishp@atishpatra.org,
 anup@brainfault.org, will@kernel.org, mark.rutland@arm.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 27 Feb 2024 20:00:00 +0300 you wrote:
> This series fix crash with the legacy riscv driver when configs:
> CONFIG_RISCV_PMU_LEGACY=y and CONFIG_RISCV_PMU_SBI=n and you try
> to perf record
> 
> Vadim Shakirov (2):
>   drivers: perf: added capabilities for legacy PMU
>   drivers: perf: ctr_get_width function for legacy is not defined
> 
> [...]

Here is the summary with links:
  - [v2,RESEND,1/2] drivers: perf: added capabilities for legacy PMU
    https://git.kernel.org/riscv/c/65730fe8f4fb
  - [v2,RESEND,2/2] drivers: perf: ctr_get_width function for legacy is not defined
    https://git.kernel.org/riscv/c/682dc133f83e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



