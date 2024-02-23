Return-Path: <linux-kernel+bounces-77760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 049008609DC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9C5C1F27036
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBB111706;
	Fri, 23 Feb 2024 04:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9jKyKrN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8B511198
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 04:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708662631; cv=none; b=g2dWqBhXq6H4qvmLaugbwk7oWLR9l7xIPZsVnUNgAP4hytImP8sWZ+rADnso2LPLn4Cp5Ugt+9Wtw0iFUtc1M5dOCrrbXH1F7bGlNgVl84vONUMbRJhD4J2G4qfXZZhguBCYH92ghlw0aQyoQVfNbYrIEqBN/rIaxFQWwdSpUt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708662631; c=relaxed/simple;
	bh=a+Qn10BEQCsB42uL0fA+2chMWeK3dzruYaHmn+6Xb4Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hbv4Sr2zPNz0028kTws7FXKU7I7tGQOFnTMUTJ6tcFcTOqgEqncRPLNhUQkgjt3ETHVALEeSW3U2GEIaAMVOhYS6dKMRgY3sV4c98ObrMC8hirue2GgBTCCWQakPCPk80SRpMN8sV+aWTH/9uTaOT0Ou6XynsloJT5ly5sx2X8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9jKyKrN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DF53C43399;
	Fri, 23 Feb 2024 04:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708662631;
	bh=a+Qn10BEQCsB42uL0fA+2chMWeK3dzruYaHmn+6Xb4Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O9jKyKrNBYPQMl/i3z6bIP1hYXB1f2lLEVjJoSgE6gMedZwMZagumZRL6KNUNDpHR
	 RG2e5z95RquAT4GoN6qMZSFtCXDAgLPtLDg+Vq6QGov1H6dSuoXJ8NkP7mpV6ZTvX6
	 RFpgnDSScGu3zGtFpMIAiEUuVdOUGxvLkSRogWolVEohQ+JLM1cUgTJ3htnk/BjVJ1
	 m8bdX4lgR6OqweHy8/l6xuFqEh0HKYMWaKMRocgWHXgmOch1iKtFiq2rrIbS5e8394
	 NwGQbo+hgdRo93sBZSXNvJLdPGHm5lBvfu27nAg5eH+LiPvzmXPVmo+For3I7jQNga
	 Q5YsXuB5AxzBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 124C5D84BB9;
	Fri, 23 Feb 2024 04:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] riscv: add CALLER_ADDRx support
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170866263006.22939.204004953353760152.git-patchwork-notify@kernel.org>
Date: Fri, 23 Feb 2024 04:30:30 +0000
References: <20240202015102.26251-1-zong.li@sifive.com>
In-Reply-To: <20240202015102.26251-1-zong.li@sifive.com>
To: Zong Li <zong.li@sifive.com>
Cc: linux-riscv@lists.infradead.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, alex@ghiti.fr, conor.dooley@microchip.com,
 aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri,  2 Feb 2024 01:51:02 +0000 you wrote:
> CALLER_ADDRx returns caller's address at specified level, they are used
> for several tracers. These macros eventually use
> __builtin_return_address(n) to get the caller's address if arch doesn't
> define their own implementation.
> 
> In RISC-V, __builtin_return_address(n) only works when n == 0, we need
> to walk the stack frame to get the caller's address at specified level.
> 
> [...]

Here is the summary with links:
  - [v2] riscv: add CALLER_ADDRx support
    https://git.kernel.org/riscv/c/680341382da5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



