Return-Path: <linux-kernel+bounces-77307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68199860396
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99A671C24B71
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791316E604;
	Thu, 22 Feb 2024 20:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5xqPH+j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D056AFA9;
	Thu, 22 Feb 2024 20:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708633231; cv=none; b=SJDVTKpPng8jj4scQwBbnC7vk8CXvIPWZ9oh/4rMFb+bsvBDHOpXN4EJuXp2HCSsNQxS8Ei7ISLa5pmdBI9zHzw8HjbQAmq98XPHayBWjzLr6U39Tpjoc9Zh9VudmnMR4Z/I4Vu3xec8sTdQ7ALzX0ZLbeJwfGqfVrcZ1RdJoVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708633231; c=relaxed/simple;
	bh=UtGmhrVXWOQgfINhBlApcwhf/spsw5YMmZhYCI+jEww=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tHrLleSkezJwmEBQOym+ipyC9OW+48jhai0HW7yBs4ITOdOjp28WdF2vKUGySXVsJtuqWrERPl9GIOv3q6vHaGbFJ1vrb+MR0U2bePOYrNic8Z7VqWvmUK0uAr2jM13qFoGg706pLLUKIrdXPDvL/RbVI0GDm7pgtJ9UkPypxdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5xqPH+j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 549CAC43394;
	Thu, 22 Feb 2024 20:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708633231;
	bh=UtGmhrVXWOQgfINhBlApcwhf/spsw5YMmZhYCI+jEww=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b5xqPH+jNwgz99/qOuiOdzr5cJrB+12a30C/knYO2wusyXuON2BpRDK6tqpWpsZiv
	 lz/gvdJ1X/Ahd0nZn74UDJUQ+l0VKNZoNUcpHCBWEQ6CI6Qh2cx0O1SZkKpg8/lr2v
	 GQSgsQJMBkgcBBEQjLlxddaSixgzV6ixmBj8CJxpd6/NmChd0eMPALkN+P5k1W7OMo
	 75Qtkm+fRQGxuxgQGIIVbIfpsVoryXrO2WXIUMtyJh4vnkurMYQm1sQ4iWqwDybt6u
	 PwWvesXOqcW+JWSu0VDeqxBUyEc3DG1Wi1eZqLdcPTouAPs188tPH3+fNn69emz1vb
	 Cx92WtX27ptKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 39A19D84BBF;
	Thu, 22 Feb 2024 20:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v8 0/4] RISC-V: Add MMC support for TH1520 boards
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170863323122.27873.17493121539917977053.git-patchwork-notify@kernel.org>
Date: Thu, 22 Feb 2024 20:20:31 +0000
References: <20231206-th1520_mmc_dts-v8-0-69220e373e8f@baylibre.com>
In-Reply-To: <20231206-th1520_mmc_dts-v8-0-69220e373e8f@baylibre.com>
To: Drew Fustini <dfustini@baylibre.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, jszhang@kernel.org,
 guoren@kernel.org, wefu@redhat.com, conor@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, jkridner@beagleboard.org,
 robertcnelson@beagleboard.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 06 Dec 2023 00:09:20 -0800 you wrote:
> This series enables the MMC controller in the T-Head TH1520 SoC and
> enables the eMMC and microSD on both the BeagleV Ahead and the Sipeed
> LicheePi 4A.
> 
> The drivers/mmc/host patches from v6 were applied by Ulf and are already
> in the linux-next [1][2] as well as the bindings patch [3]. Thus v7 was
> only a defconfig patch and three device tree patches. This v8 is a
> followup to change the dwcmshc node names to match the documentation.
> 
> [...]

Here is the summary with links:
  - [v8,1/4] riscv: defconfig: Enable mmc and dma drivers for T-Head TH1520
    https://git.kernel.org/riscv/c/45e0b0fd6dc5
  - [v8,2/4] riscv: dts: thead: Add TH1520 mmc controllers and sdhci clock
    (no matching commit)
  - [v8,3/4] riscv: dts: thead: Enable BeagleV Ahead eMMC and microSD
    (no matching commit)
  - [v8,4/4] riscv: dts: thead: Enable LicheePi 4A eMMC and microSD
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



