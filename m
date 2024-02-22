Return-Path: <linux-kernel+bounces-77308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B0A860397
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEF121F27013
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792186E605;
	Thu, 22 Feb 2024 20:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExdEeTc0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C9D14B832;
	Thu, 22 Feb 2024 20:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708633231; cv=none; b=ANkUcJKwPh89C+/W2k2TDPm8apE2pYHnffOkzhsZUmutTg4Z8gFfQxBH8fgxusFN8VuxoxCHbMct0ouU2IEBOzvUOH5u1qwR3WFx2khNarT1hqlbauSnjnK0hEW2cNoLI+xyNlC5q3ssiwVoaAOzmG64cxQ7y/zhkrUSihWoWFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708633231; c=relaxed/simple;
	bh=0P5C2465GuFA4aUaMuXI5r/adEpiwFiW6ygPXKIJTSo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h5ZBguoasUAOFqXDUialnvnSOV6ECq5Zio+9oxZCBMPxyXTFt+isoOFJiSKHXHFt97uGPGbdYdrQGgm60DamThFnmqMJis/6n5LTC/DEJJWOOU5bImnWf17BcyQ7G69nLyeLMtjcR8cwVWQAktxQ1m+16lC42SyXAcPs+vniVAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExdEeTc0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B95EC433F1;
	Thu, 22 Feb 2024 20:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708633231;
	bh=0P5C2465GuFA4aUaMuXI5r/adEpiwFiW6ygPXKIJTSo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ExdEeTc077MQc+GV14zKSMiI5T6093L979lgyGHZj4DIWKwSiENlqeh5VjurZ6QK6
	 gytN4yh6hm+WwTtI8LpstgqC7qVP1bPzdzkXH1NeHXXLNGl6Dmv4CGLpgcSyoURbiO
	 havvpA8hYC9xEOhnczjnoIpNqmTd2qbWFu5khxELC+1JBy9dnverTLdtqGhTl5eeWS
	 WLCNBN1peQXmiioFAVzFsfX8dosB1HSqg38MkEdqnj0UBnvR+fNYTuo+Qy+EEZIZdl
	 b0Uu0tLcjfJ+SXUAQJBRKtLidwR8dSHQmgNOR4x04yqCsGrX/6lR1MQnZ7CNqcTG6u
	 aCpPdZ/vr+Lsw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2AAE0C395F1;
	Thu, 22 Feb 2024 20:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/4] membarrier: riscv: Core serializing command
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170863323116.27873.1775668437490163810.git-patchwork-notify@kernel.org>
Date: Thu, 22 Feb 2024 20:20:31 +0000
References: <20240131144936.29190-1-parri.andrea@gmail.com>
In-Reply-To: <20240131144936.29190-1-parri.andrea@gmail.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, mathieu.desnoyers@efficios.com,
 paulmck@kernel.org, corbet@lwn.net, mmaas@google.com, hboehm@google.com,
 striker@us.ibm.com, charlie@rivosinc.com, rehn@rivosinc.com,
 rdunlap@infradead.org, sorear@fastmail.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 31 Jan 2024 15:49:32 +0100 you wrote:
> Changes since v3 ([1]):
>   - amend documentation
> 
> Changes since v2 ([2]):
>   - amend inline comments
>   - drop ARCH_HAS_MEMBARRIER, create membarrrier.rst
> 
> [...]

Here is the summary with links:
  - [v4,1/4] membarrier: riscv: Add full memory barrier in switch_mm()
    https://git.kernel.org/riscv/c/d6cfd1770f20
  - [v4,2/4] membarrier: Create Documentation/scheduler/membarrier.rst
    https://git.kernel.org/riscv/c/a14d11a0f5f4
  - [v4,3/4] locking: Introduce prepare_sync_core_cmd()
    https://git.kernel.org/riscv/c/4ff4c745a16c
  - [v4,4/4] membarrier: riscv: Provide core serializing command
    https://git.kernel.org/riscv/c/cd9b29014dc6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



