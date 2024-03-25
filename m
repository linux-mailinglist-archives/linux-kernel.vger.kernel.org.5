Return-Path: <linux-kernel+bounces-116387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7FE88993A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4389B256BA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFA7132483;
	Mon, 25 Mar 2024 05:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gl+UKIWl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD798149C78;
	Mon, 25 Mar 2024 01:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711331662; cv=none; b=OEK+lF0V7LwpSHg1udTJ2OUZXsmEhSo76p6DE4mQ31F8oFXl01NQFNIIf1UXprJGYuci4Z6jPWQhO8CVOlryki23WuGRlKkHsHc3gmbtprC1ER3xWIzWypnGHY90CaPFSdD0OWi6gj90fLucBo5/5u+p1ICjbQ+Gcp1oW4EZrao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711331662; c=relaxed/simple;
	bh=iNGGIR2WzWnGk0XaABC+/QwzPkT5Pzv4yA9dV707Yy4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gAUnjahhT5S8ZiCbJPcGKPZIjrW38uuYUYKmt1fSSzR/ARbWYMv2JlW3vhValCR3FzP/E6Wzp1+2D4mRy87yFm8S1SuV259bNIvDQtrBAvj/6FDgCGcu2F02JiOtufAJdvZhZoGPpicWQY/RHJzBkMIEgTXx4wv2oEdzUtWrS3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gl+UKIWl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F8B1C43390;
	Mon, 25 Mar 2024 01:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711331662;
	bh=iNGGIR2WzWnGk0XaABC+/QwzPkT5Pzv4yA9dV707Yy4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Gl+UKIWl9/5Fdlf/GHr+f4fNNDMAREDvZoXNg3USffZUL+kTg69phl0Eg1vOvzTH9
	 8kHNGfEtbogTo/rCFcFtycGToECdnyrDZI2aLGorqfVioHrhbZlZ7fbABpWhpnuhc/
	 BdRZ5iC8RIYLxG5N6M0Dira7tpFrHpe1M+DYtpJ1HeBLLP7EWkMbFiB4X1RS+Hl2JA
	 ZRCDng9xeTSVgqGTYdyKOqiOWn/YKce9ERJAwZUqlAEhhmqqfZ9x6nz01ifil7+r1z
	 IQeuHOMfmORVbaeIMVSm6CAas7rrAqmrfxl1Ty1K+pR4dKzxZQ449yKxzsb51MU1zF
	 fZ3SNgyf7z7mg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4D233D2D0E3;
	Mon, 25 Mar 2024 01:54:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/3] Introduce EC-based watchdog
From: patchwork-bot+chrome-platform@kernel.org
Message-Id: 
 <171133166231.9916.7231250620075780929.git-patchwork-notify@kernel.org>
Date: Mon, 25 Mar 2024 01:54:22 +0000
References: <20240119084328.3135503-1-lma@chromium.org>
In-Reply-To: <20240119084328.3135503-1-lma@chromium.org>
To: =?utf-8?q?=C5=81ukasz_Majczak_=3Clma=40chromium=2Eorg=3E?=@codeaurora.org
Cc: gwendal@chromium.org, tzungbi@kernel.org, biernacki@google.com,
 wim@linux-watchdog.org, lee@kernel.org, bleung@chromium.org,
 groeck@chromium.org, krzk@kernel.org, linux-watchdog@vger.kernel.org,
 linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev

Hello:

This series was applied to chrome-platform/linux.git (for-kernelci)
by Lee Jones <lee@kernel.org>:

On Fri, 19 Jan 2024 08:43:24 +0000 you wrote:
> Chromeos devices are equipped with the embedded controller (EC)
> that can be used as a watchdog. The following patches
> updates the structures and definitions required to
> communicate with EC-based watchdog and implements the
> driver itself.
> 
> The previous version of this patch was sent here:
> https://patchwork.kernel.org/project/linux-watchdog/list/?series=817925
> 
> [...]

Here is the summary with links:
  - [v3,1/3] platform/chrome: Update binary interface for EC-based watchdog
    https://git.kernel.org/chrome-platform/c/4d2ff655fb85
  - [v3,2/3] watchdog: Add ChromeOS EC-based watchdog driver
    (no matching commit)
  - [v3,3/3] mfd: cros_ec: Register EC-based watchdog subdevice
    https://git.kernel.org/chrome-platform/c/6cea614ba78d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



