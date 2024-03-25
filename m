Return-Path: <linux-kernel+bounces-116401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C897889AA6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DE9D1C3346B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BE9142E76;
	Mon, 25 Mar 2024 05:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJ9m4W+U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0191152536;
	Mon, 25 Mar 2024 02:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711332788; cv=none; b=MxlJBO85qSBH00hC0cLTO7MNRlfWRGtEhsbIFdDqDC4LRcoJ5ZRRr3JXXlclDQGuIBpEwNUEgZffWAYmoFquUjUEbapd0zpPVr6QtxmW6BPSDj1jcLi525oo/3kM9ShKmc3t5VwUzybel5NHL1JAPWyB51tuFRJ/yG6DJ3L5Vss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711332788; c=relaxed/simple;
	bh=spYt0EJX3GXAPWTipFejxBFKEkwlS+wkBPP3f/SoL1k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NMQA9Lrq+SSkKLjiG+GPgzju4oO/MJulT5jk/vaO/j7HvKBqXkSyXCs9frA/GMzJ8W9/fG+qHUW9k0uk+EJtIgiJzJ3jfq2KZRIcP7OGTe04zfQ8cRLlQcUDLqT/OcY4PmizSOTudO6weta6yaAkx6EjKzK8ZhF9cMxv3yj92fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJ9m4W+U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF3A3C4166A;
	Mon, 25 Mar 2024 02:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711332787;
	bh=spYt0EJX3GXAPWTipFejxBFKEkwlS+wkBPP3f/SoL1k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rJ9m4W+UCFiVihb49A7pTD7kUjXX3CrS7AbFnWG1l6XLiRdiqr+RxEDN8rikZL4rF
	 3d4h78bl6lxlTqToubpi15hk//WkuQyaUWbHjnBZoZx+44kjzTc1jcUn/MGz7utU7P
	 4E8zvImHkHefn1TKFljILDxriVLpyrxQ/vBquubwkcbRNKpos3DvvgMiJCdwuLXeQQ
	 CvQanN0MHoRK8noInCYGZkVI2K6L/M9Jwdcxs088xaNYtFhWMzikIX8ofKlm7py1so
	 KKbhxJccFUEbHXdUcwCMYQrj851i0ykCqvFltWNFF2DiZjI76ZvEYBbVlXF0wcKmsx
	 Py7YYa8OeKCKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A1CE6D2D0E7;
	Mon, 25 Mar 2024 02:13:07 +0000 (UTC)
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
 <171133278765.9916.5779624777130232781.git-patchwork-notify@kernel.org>
Date: Mon, 25 Mar 2024 02:13:07 +0000
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

This series was applied to chrome-platform/linux.git (for-next)
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



