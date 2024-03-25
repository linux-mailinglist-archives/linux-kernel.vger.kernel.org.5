Return-Path: <linux-kernel+bounces-117628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1057A88AD78
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 416681C3DF36
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C183F13A41C;
	Mon, 25 Mar 2024 17:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9RiyC+C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38872F37;
	Mon, 25 Mar 2024 17:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388680; cv=none; b=f4/srghOw/oZI75D/yFnFk+9Lm4dvm+ZSCKeM1M1pV/Ss+MNSSt0K2FSPT/lnIBDWKee9ghY47904RqU4ZYPDgN/ccpeJyWtnAhBxzPm8nm2EymDZToKTntm+fB5VsG6+811gLuBdtD1YPI7Ngh/SO9dvUkoIsIaugqB5PpS5bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388680; c=relaxed/simple;
	bh=c6BZPJhlGRa0tRJZhQO7xwz3M0+lYD/NNGwD4smCPw4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qW5ngq+pP7UN4qznq+XS2/jxaG8BgslHAT0uLRvYkgto8iFdpZht6Zt3jZqyrwTI/plrCsspUNdbVh1DqIVE4ZZ5y2j3ftcS47OYrDT2qduict5oFb/5ivTJ1m+L205NddUTvPsqhv7LzdrnQLQ03EtZYNg8nhkoJbzAfdHAn3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9RiyC+C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C391C433C7;
	Mon, 25 Mar 2024 17:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711388679;
	bh=c6BZPJhlGRa0tRJZhQO7xwz3M0+lYD/NNGwD4smCPw4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=f9RiyC+CK0Hh0O2yqKhqupf2ci3+Uv46FC8YzKWVHEaY3ZhdVCgTikqB24vhYzdog
	 kXia+gLQhh23Jlu1xdUbcrEv5C4wkJfUbaW48RuyAt635EnfGucI5Iuof5nNmeeKT4
	 +SS9qFYu1eiufwdSjskE7vjyvkFpPZNHy/r1gud2LnVVCRBqh9v8CJaTIeM0N3rwhn
	 2nnGdJdFkOxhTYpn99uyyhxs+lXwIyAL3AK8Ju204Yu47kFjX9sHSFyBlW8au4oFjX
	 NmGvYzUKloVEmIkdPtCD1KQtg8fy5wu5/7J3cj+O9SFzKCjnxr5zTckOQqP0C8MgrQ
	 8cB0fV6XyYcQg==
From: Mark Brown <broonie@kernel.org>
To: ping.bai@nxp.com, lgirdwood@gmail.com, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, shawnguo@kernel.org, 
 s.hauer@pengutronix.de, Joy Zou <joy.zou@nxp.com>
Cc: kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev
In-Reply-To: <20240314032923.2360248-1-joy.zou@nxp.com>
References: <20240314032923.2360248-1-joy.zou@nxp.com>
Subject: Re: (subset) [PATCH v4 0/3] add pmic pca9451a support
Message-Id: <171138867685.327260.1555861934487475559.b4-ty@kernel.org>
Date: Mon, 25 Mar 2024 17:44:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Thu, 14 Mar 2024 11:29:20 +0800, Joy Zou wrote:
> The patchset supports pmic pca9451a.
> For the details, please check the patch commit log.
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] regulator: dt-bindings: pca9450: add pca9451a support
      commit: 0f3b73eb1440d18d2236ac660d4aa76fd726bec7
[2/3] regulator: pca9450: add pca9451a support
      commit: 5edeb7d312628961046eec9b26a7e72f44baf846

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


