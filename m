Return-Path: <linux-kernel+bounces-161587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 554F88B4E5F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 00:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E92B41F20F0A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 22:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E7B10958;
	Sun, 28 Apr 2024 22:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H26tfuoj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376F2B66C;
	Sun, 28 Apr 2024 22:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714341635; cv=none; b=OJ+DOXjrHyee4PGqW9UcDXfq8JplaRLYL6q8hqNvwNHv+nDkuboqAREqlco4qofBI4NLBXL9uLtV5HjuB1/KoSkk1Rkm/XUusqO2WHNeg65URKofNaqwkq1hge5sC+9D2Cga592m6DjKj95bqJrZ89w6sNLBUSFuvTvudTiC/P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714341635; c=relaxed/simple;
	bh=9Zs3qLqdKozykHa9V75JS3GRduTLPrPINfUtjXZ9lBM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iMnP1Ex/bEfmLE1SLjoIskjmxeOH4wi9y8h108qOP1UhC38H/f8R7r8y62nrxbQfPkz+Us15219eIS/26261RdThCGe34iFVQ0owX1AZMvhT+iHrN+nfbbsetagak2h7PO5w31RU9byP1U0Mn3G4+XPBu/TwhhITzgkNE2gWfiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H26tfuoj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C06B4C113CC;
	Sun, 28 Apr 2024 22:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714341634;
	bh=9Zs3qLqdKozykHa9V75JS3GRduTLPrPINfUtjXZ9lBM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H26tfuojMbEhe+aZECwDU+ED3T57TnYoE/Oa+tN65hwAONVJCWsXAhrS4a8xlV8WS
	 AzlrzY0ue4clDNz2ht2J0Xn/NSF5vU5h/kBH+VRGYF/qLdDVHGtQk5OYEh4xG8QZMa
	 AI0QNnmzv47L4oTpMhoBEPUq6TALpXn3RPLcxM+hgZXJHtlLNHybiwtvmNz6/fpFGM
	 PgZTX9izxRSAxdv0zZh4RnPFP11kbNFWsHxEWrwUI1y9HnB2fv3jAK2F+WXp5mV3sJ
	 h/S/o+uBvJayQOLvhwjr2zsNP2ltb3c5aAuAv6dP6tY1oLexG8DqQVGX9kJTrLyzms
	 IM1weeXXc6FcQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AFF72C43614;
	Sun, 28 Apr 2024 22:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] cpuidle: riscv-sbi: Add cluster_pm_enter()/exit()
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171434163471.22130.9333013244228014885.git-patchwork-notify@kernel.org>
Date: Sun, 28 Apr 2024 22:00:34 +0000
References: <20240226065113.1690534-1-nick.hu@sifive.com>
In-Reply-To: <20240226065113.1690534-1-nick.hu@sifive.com>
To: Nick Hu <nick.hu@sifive.com>
Cc: linux-riscv@lists.infradead.org, anup@brainfault.org, rafael@kernel.org,
 daniel.lezcano@linaro.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, zong.li@sifive.com

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 26 Feb 2024 14:51:13 +0800 you wrote:
> When the cpus in the same cluster are all in the idle state, the kernel
> might put the cluster into a deeper low power state. Call the
> cluster_pm_enter() before entering the low power state and call the
> cluster_pm_exit() after the cluster woken up.
> 
> Signed-off-by: Nick Hu <nick.hu@sifive.com>
> 
> [...]

Here is the summary with links:
  - cpuidle: riscv-sbi: Add cluster_pm_enter()/exit()
    https://git.kernel.org/riscv/c/3fd665f2854d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



