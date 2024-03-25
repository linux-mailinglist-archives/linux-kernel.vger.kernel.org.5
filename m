Return-Path: <linux-kernel+bounces-116389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8008899EB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 410481C32CAB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827C0133408;
	Mon, 25 Mar 2024 05:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9k94xcb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4927D14A602;
	Mon, 25 Mar 2024 01:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711331663; cv=none; b=s+Og1v+sz5Cu9YYB0bLFQFGIEh86DhtXeRa9mQCECeHyMoHfnjupBsbvGG/8lEezaoabwLfrMYKqyz1fbaTFw9QxOLtX2V3DT+TGupkf6fcgcP9/j8kFsKwOz3iq/lfpeTyxMLN4D0bGedNhcKMcILHaejPQXhhBVWGYX8vOS+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711331663; c=relaxed/simple;
	bh=3uYZHwDwMvbZsbPB9A8Yw6hlzifQeyqRpNoGZWbsN+k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pE4r8+7RgNIwwOAOSnVOTmtLdX2uDbmura8OZtnoAHM2kSNPjfXpRn0wE6aVzrZe4oa04rx1pVdBKCYfOfPXJB+zUdQ1AJBxEhE0mPOfaj6ssu5vrc10LzySpsXTRhTQnVkRsTD5lF9GCAsgwrRfe5badSZ2DSJAFewOmk4+goA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9k94xcb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92EA7C43141;
	Mon, 25 Mar 2024 01:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711331662;
	bh=3uYZHwDwMvbZsbPB9A8Yw6hlzifQeyqRpNoGZWbsN+k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h9k94xcbzJ8umZuKaQRlTjbGGULOk4jiUy+LTnqdw+5V0UeEaeG2CccGQ5FoT6wmp
	 Bc7nwkoDuWl2JWkhsNf8c/jAhkXnsvmpwuAhNnCI7Syw0XkmEo6fiLXTkHnbtCUBpP
	 +lCVm3kgaGGxFz0w+K3m0jDpgzeE96ybpByO+uvG+Yu8GN10by+bQJkUBtUPPc4SSA
	 qd0I6OD9ZsUXcTvjDA+kNSOCHOwWyGVt5rxFDpNZSgmpPnfRoCL4Rm9Nt937fcnz0o
	 WMTcuCiC5uQ7lecp/2nEZh3Cc0ZYcITDSjLAENZxAyzgMJ99vP3lJhLY6IwtsLhHc4
	 BwNKmpQAXlfAQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7E659D2D0E6;
	Mon, 25 Mar 2024 01:54:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] gpio: Add ChromeOS EC GPIO driver
From: patchwork-bot+chrome-platform@kernel.org
Message-Id: 
 <171133166251.9916.2499455576829331445.git-patchwork-notify@kernel.org>
Date: Mon, 25 Mar 2024 01:54:22 +0000
References: <20240220045230.2852640-1-swboyd@chromium.org>
In-Reply-To: <20240220045230.2852640-1-swboyd@chromium.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, linux-kernel@vger.kernel.org,
 patches@lists.linux.dev, devicetree@vger.kernel.org,
 chrome-platform@lists.linux.dev, dianders@chromium.org,
 treapking@chromium.org, linux-gpio@vger.kernel.org, lee@kernel.org,
 bleung@chromium.org, groeck@chromium.org

Hello:

This patch was applied to chrome-platform/linux.git (for-kernelci)
by Bartosz Golaszewski <bartosz.golaszewski@linaro.org>:

On Mon, 19 Feb 2024 20:52:27 -0800 you wrote:
> The ChromeOS embedded controller (EC) supports setting the state of
> GPIOs when the system is unlocked, and getting the state of GPIOs in all
> cases. The GPIOs are on the EC itself, so the EC acts similar to a GPIO
> expander. Add a driver to get and set the GPIOs on the EC through the
> host command interface.
> 
> Cc: Lee Jones <lee@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: <linux-gpio@vger.kernel.org>
> Cc: <chrome-platform@lists.linux.dev>
> Cc: Pin-yen Lin <treapking@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> 
> [...]

Here is the summary with links:
  - [v2] gpio: Add ChromeOS EC GPIO driver
    https://git.kernel.org/chrome-platform/c/f837fe1bffe6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



