Return-Path: <linux-kernel+bounces-75429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAE185E891
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 002541F28C44
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8289D12FF91;
	Wed, 21 Feb 2024 19:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ex9gPT2S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EC3126F16;
	Wed, 21 Feb 2024 19:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708545029; cv=none; b=hkkhBkBFMYe+9blkUXFquQ9eCXQXRWiHfk2O7JFGpeeAaJhRNXABs1B95a9i5V8WWGOedqfwK6tUXPRmPsfZQjsFJhSDPJzQfwpkNlV4iZNpJkIGudlrgXyWuYo8E7Y+9kSccG5rT/9/Lkx6Ak0s23xo/9MoEjp2f9rdC/AG3nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708545029; c=relaxed/simple;
	bh=7Fv9UpJfx1rHXGyrBVOIkfBWNUxLkQgV7YhfSLbTmpg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VSrduz6BDC5es/D4N3T2TGFS/HLnrtH3kHe5Zdqwi5Mi2ZIW0kSqlYxcCjEroyEYu6bxmvTT7G/NSowSKsvEG1h+hsbH3TWbS9VAs/qThb9Xg+HQ20bohgPFdkw4KRgY8kV4QfkHHDyTjGsmKc7d2tArqxQLLqXzcfZZaxXul/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ex9gPT2S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 687C1C43390;
	Wed, 21 Feb 2024 19:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708545029;
	bh=7Fv9UpJfx1rHXGyrBVOIkfBWNUxLkQgV7YhfSLbTmpg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ex9gPT2ScoKVKEavIEmFUPWMfyenO7aNFFNomGzvzBHB7fEfzvJ/R9DWViHY4OxmZ
	 uUIe15khQeUJJ0Gk7T3pr9qBrR+Q+1GRZc0KCagkAsxYE6tF5qrRXrugejqpL+4feU
	 wUXJUMWHBddvINHyJgm9XYJmBBdt6lj6F9VH3nXBzYVEPkzJjl9ztsazFgov3Fwdgr
	 tDaaQZu+WGEd47XiDAOJwhOHM/nSj93ULIyl5Rx5wsOz/LmbH5qjHM/1kH1X27fZmc
	 OOxuTHDE75Aun76PwEAIgCCea1UJoWSZ4wtUIi9k3ClSLn4nyEjhPbfbnAqEFjJMJM
	 LfUhSKq2V72YQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4B563D84BCB;
	Wed, 21 Feb 2024 19:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] tty: hvc: Don't enable the RISC-V SBI console by default
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170854502930.2044.11543238578824030795.git-patchwork-notify@kernel.org>
Date: Wed, 21 Feb 2024 19:50:29 +0000
References: <20240214153429.16484-2-palmer@rivosinc.com>
In-Reply-To: <20240214153429.16484-2-palmer@rivosinc.com>
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, atishp@rivosinc.com, ajones@ventanamicro.com,
 apatel@ventanamicro.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, kernel@esmil.dk

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 14 Feb 2024 07:34:30 -0800 you wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> The new SBI console has the same problem as the old one: there's only
> one shared backing hardware and no synchronization, so the two drivers
> end up stepping on each other.  This was the same issue the old SBI-0.1
> console drivers had, but that was disabled by default when SBI-0.1 was.
> 
> [...]

Here is the summary with links:
  - tty: hvc: Don't enable the RISC-V SBI console by default
    https://git.kernel.org/riscv/c/481860974faa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



