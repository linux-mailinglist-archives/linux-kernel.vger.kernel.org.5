Return-Path: <linux-kernel+bounces-116404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE3B889655
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76CE9299D99
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A871448D7;
	Mon, 25 Mar 2024 05:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyQ9GcpQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7583214BFAD;
	Mon, 25 Mar 2024 02:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711332788; cv=none; b=uLxv90YTrSm1WQKHWmnrlkArSAF/5kHlZ2LHD+yzvI5Ldlgti9uE1lLs9in0yMsn6CGlR97EnCmqZlwjqyA73C7TAQldAChcUsLC7BRi2Roc4HTIHETtENoZrWY/48uIiBdme7bfvLNOOQZHTmgnMoC4/yGBmz4u43/+fDaHios=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711332788; c=relaxed/simple;
	bh=ZjgqCWsmKkuovh6MisooZl+/2MBUKF7fK+TUoxzUHCY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jfuBFDahOi0A4nCuavFksz9YDWqnSXonY6ZcM6oF9GqT8EGHPNGJGazh+yYqjaEbH/y/7TiyhZcqAUOeFwTFTSIQqClOjQI/SCrM/Xdz3mF4/zMl9Az92I4n64jlb5KVWRh9ScXFHZrLDwHhFrNJ+QoesrPIASTPbsbA9ss/xPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyQ9GcpQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 936DDC43143;
	Mon, 25 Mar 2024 02:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711332787;
	bh=ZjgqCWsmKkuovh6MisooZl+/2MBUKF7fK+TUoxzUHCY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UyQ9GcpQVXzojXqUM9nOd0DRpLaGTsf7lQnP/2oEM4OV2s7EmzskxKAF3m0kyMsZ/
	 EoJSLaEw/RsRKxYAFmogtyUY6LbxNri8zfPW6jlz9Z154rcef8YdgG+MuzEY9GGgbv
	 0jnG8pZFD1YArL/3LfWRH1fn/6NuZbECfm+o+nbwfpRSCgna7epf1KkgzYdNtq/HNv
	 BaUu05Vd0gN/UZO3xJzFtAdoxG2xDhVcBlZgKBV8o/JKftE79GMlzoG3KQ0MzDYOlR
	 19+gaNycmmH6Q5THqCgCzN01lhj3UZVJGH4vldwCskiKeaCOtoJsNMQj48BwHeeUlZ
	 RYraCD/FCaX5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7FFB1D2D0E6;
	Mon, 25 Mar 2024 02:13:07 +0000 (UTC)
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
 <171133278751.9916.9482317589165848392.git-patchwork-notify@kernel.org>
Date: Mon, 25 Mar 2024 02:13:07 +0000
References: <20240220045230.2852640-1-swboyd@chromium.org>
In-Reply-To: <20240220045230.2852640-1-swboyd@chromium.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, linux-kernel@vger.kernel.org,
 patches@lists.linux.dev, devicetree@vger.kernel.org,
 chrome-platform@lists.linux.dev, dianders@chromium.org,
 treapking@chromium.org, linux-gpio@vger.kernel.org, lee@kernel.org,
 bleung@chromium.org, groeck@chromium.org

Hello:

This patch was applied to chrome-platform/linux.git (for-next)
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



