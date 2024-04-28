Return-Path: <linux-kernel+bounces-161592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 776EE8B4E66
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 00:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A341F1C20A90
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 22:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E362E40E;
	Sun, 28 Apr 2024 22:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKACEZM1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C50BA41;
	Sun, 28 Apr 2024 22:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714341635; cv=none; b=QT5/vGjd1oG6EqH+asuUH9TgkbOPcojxEzmTvEC+0ipySmsoNTTRmt81X3TBkeSH0SiAMIyS13t3AWQQpvFn9Uu7BruwgNRD6KmRQs3yPBIoGy1iEx0jfnIN9dnUqo5F48gcnB0Q+H//jBxR6yD8vr3yGCNZPfraJGfUC5pXXmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714341635; c=relaxed/simple;
	bh=G75BxI2Ke585cbRErrGMj5F7qdvtnyl04UrjmqS8Nts=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ws6Q6y1tkS/L0FZ7uA8fjXRMTnQWiQEJohiGOnNQgxnQRFm/i2bXl9F8cJqX/2wk7mh7DNrWoZ8Vs5o45qbTjl7CECG/lBU3HUIGtJnY0daUvgPmbv46bDx1rxnaTVh+BvdCU4WaiMs2fyD5zABZLFVdg7Twb0m68rs8tIUGl38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKACEZM1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED6E9C4AF1C;
	Sun, 28 Apr 2024 22:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714341635;
	bh=G75BxI2Ke585cbRErrGMj5F7qdvtnyl04UrjmqS8Nts=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RKACEZM19RbQbpO/Z7PdjBdvoZePPUTDthdMmu1niB0ZKljcxQGfiXDP13BhPqRqx
	 9EYEwdZM6CFTMX05tFuV5jZVJgoDCKrQiFYqYfg5lARUxSgVhmWnScukiB80GPDKMu
	 qQJby5ChjLvbSwreZZD5Md9A8jiLm6wXRVq5O7WLA2bRcOZ2/NNk8sMIcMGdDp3tAP
	 faXsVbSd1llPWZhDpS92sfMu0w9FCDkCj36CxwjuO9yXX2PM3HqsFJmwpKul/b1Fjv
	 KI3OUHEXN8txRDoGc8JF6lZfP2sMypiukY4uPbBONsOXykR0TomVlzEyIa6sP5pSrn
	 i2Sj/bzC+eJxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E04DCC43618;
	Sun, 28 Apr 2024 22:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v13 0/4] riscv: Create and document
 PR_RISCV_SET_ICACHE_FLUSH_CTX prctl
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171434163491.22130.7402887915365003575.git-patchwork-notify@kernel.org>
Date: Sun, 28 Apr 2024 22:00:34 +0000
References: <20240312-fencei-v13-0-4b6bdc2bbf32@rivosinc.com>
In-Reply-To: <20240312-fencei-v13-0-4b6bdc2bbf32@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, corbet@lwn.net,
 conor.dooley@microchip.com, cleger@rivosinc.com, atishp@atishpatra.org,
 rdunlap@infradead.org, alex@ghiti.fr, samuel.holland@sifive.com,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, atishp@rivosinc.com,
 alexghiti@rivosinc.com

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 12 Mar 2024 16:53:39 -0700 you wrote:
> Improve the performance of icache flushing by creating a new prctl flag
> PR_RISCV_SET_ICACHE_FLUSH_CTX. The interface is left generic to allow
> for future expansions such as with the proposed J extension [1].
> 
> Documentation is also provided to explain the use case.
> 
> Patch sent to add PR_RISCV_SET_ICACHE_FLUSH_CTX to man-pages [2].
> 
> [...]

Here is the summary with links:
  - [v13,1/4] riscv: Remove unnecessary irqflags processor.h include
    https://git.kernel.org/riscv/c/bebc345413f5
  - [v13,2/4] riscv: Include riscv_set_icache_flush_ctx prctl
    https://git.kernel.org/riscv/c/6b9391b581fd
  - [v13,3/4] documentation: Document PR_RISCV_SET_ICACHE_FLUSH_CTX prctl
    https://git.kernel.org/riscv/c/6a08e4709c58
  - [v13,4/4] cpumask: Add assign cpu
    https://git.kernel.org/riscv/c/decde1fa2093

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



