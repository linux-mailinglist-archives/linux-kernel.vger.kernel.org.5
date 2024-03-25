Return-Path: <linux-kernel+bounces-116382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AF0889B22
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FC45B42B36
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A3C12FF93;
	Mon, 25 Mar 2024 05:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dII2jxeX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DC514A60D;
	Mon, 25 Mar 2024 01:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711331664; cv=none; b=dqNoUQqC3i1bXvOl/1eLuRtDyEVTcQoMP8HK3xY9L98u/uwJFFyoljbfMI1mHKaLdn2utbZAfvFube/x7fD5QDSjaEBxDLB9pUFvkhE+ZnAoUHgpSiSSrOVwEMDx/dgM03WMoldLboVfmBJvYmPOHXLNgxMUv+Wi/OPsiZBzSRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711331664; c=relaxed/simple;
	bh=tTNkWJm2u7rbfvKHXDM27rz2ldG82nwlj1db2mwHPtk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=habF7w4cqmY9m4GegUV9+dO3V+ADoCZuSa86k8lUU6DTmGE8Ub7K+PrsWv5Z2d2B4e0vvrQHgMIEEUhT0+lvR0esXOI8LSM5NaSpGoRbFy4RCZRFYVY27Xb+MpPOGvq+IUyyCImfKS1+NQEHiUhq0xyb+erMj4nvpvnwf1Yd0EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dII2jxeX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6B02C43142;
	Mon, 25 Mar 2024 01:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711331662;
	bh=tTNkWJm2u7rbfvKHXDM27rz2ldG82nwlj1db2mwHPtk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dII2jxeX1BSLDsnKeg//tK9gI5fbTVGhzNlDDHrPlYKUajd7pFBILqvuRvHyDKkje
	 noKvtWsc/tCZaxtPadQN9IAkg/Xn7fcAaVMKmyvayB9JgkoavUBwGa3aJnOnLijuyx
	 7rtuHpNwpf1podWxnBto2SW3m/hNAit9D6AOdjlhorUBKe+mOKmxfi1grMabDg7ft2
	 mXXzxb6ovv31YxJKatY/5/P6S3TEM9uVvxvflV1My2eP3Zorzs9TP0AM2iG3Q/Wd5k
	 xAfCh8em5sNXROYWepOXxFHrlbWVIydaLjNO+5y4bRGDJ/ZttPX5Q7HD2z8N3McxZU
	 YqxCcT+ttNXFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 96FCAD2D0E7;
	Mon, 25 Mar 2024 01:54:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] mfd: cros_ec_dev: Add gpio device and DT binding
From: patchwork-bot+chrome-platform@kernel.org
Message-Id: 
 <171133166261.9916.7576640271534034867.git-patchwork-notify@kernel.org>
Date: Mon, 25 Mar 2024 01:54:22 +0000
References: <20240219202325.4095816-1-swboyd@chromium.org>
In-Reply-To: <20240219202325.4095816-1-swboyd@chromium.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: lee@kernel.org, linux-kernel@vger.kernel.org, patches@lists.linux.dev,
 devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
 dianders@chromium.org, treapking@chromium.org, brgl@bgdev.pl,
 bleung@chromium.org, conor+dt@kernel.org, groeck@chromium.org,
 krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org,
 robh+dt@kernel.org

Hello:

This series was applied to chrome-platform/linux.git (for-kernelci)
by Lee Jones <lee@kernel.org>:

On Mon, 19 Feb 2024 12:23:22 -0800 you wrote:
> This is the mfd part of a larger series[1] that describes the USB
> topology on ARM based chromebooks. These two patches add the gpio device
> and DT bindings when the GPIO feature is present. The gpio driver will
> be sent separately.
> 
> Stephen Boyd (2):
>   dt-bindings: cros-ec: Add properties for GPIO controller
>   mfd: cros_ec_dev: Add gpio device if feature present on EC
> 
> [...]

Here is the summary with links:
  - [1/2] dt-bindings: cros-ec: Add properties for GPIO controller
    https://git.kernel.org/chrome-platform/c/7b79740d42e7
  - [2/2] mfd: cros_ec_dev: Add gpio device if feature present on EC
    https://git.kernel.org/chrome-platform/c/8f49b623b934

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



