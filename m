Return-Path: <linux-kernel+bounces-117627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB77E88AD77
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2BB1C3E21B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E934A13A25B;
	Mon, 25 Mar 2024 17:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwuZJzvg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3484152F81;
	Mon, 25 Mar 2024 17:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388677; cv=none; b=D+c5nhyJxX6wPk8ulQuW7cOYs1SD16ZODBrY6SQk1Vw1D5509PuQFloNKtoEyRttSBoafKphLCf7L0kn1+A3TtXM6C99TT/xTLS783f8k0pTwc/whsNNmLy/AxWJhLA0+N44nzu3WOV+p7B9n2bHRcW10E0P/pZdFBnUMyJKhd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388677; c=relaxed/simple;
	bh=dqD8f7GGPw3IfdX7eab4jo56BaZZXebCnwORZNRnzfc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gCL9RmmfivNSzWKZSlu53rNRirWksGZQ8hXPrmwH40dyYOnRLJi6DbOxAZCvhfGc5ozSGgnsSuOBb892Z/WhprM8gkao+KGrB5FpoZ2s8NDHtpQ58WZDCKThsv4dlberF2mukIE72F82sHaPjRTSIOAXoRe+zfgk706QuxaEhmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwuZJzvg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F058CC43394;
	Mon, 25 Mar 2024 17:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711388676;
	bh=dqD8f7GGPw3IfdX7eab4jo56BaZZXebCnwORZNRnzfc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LwuZJzvg+bNglR4br2EOZcDb3FIIP4Atioq9BOyMSBB5CCc1bGpvG13c46pMJlnGs
	 AW4jH5mZ5CLNfPH2c2TjMBTiKclUM3xJzkOKAVzUDhxdx26m8JpF7eYJUAbI4579H8
	 IMVIhuOw6EVFd5azC2lvOhsMUSlmA8ubkWngCLyOWSCJjxBFp2momTXf1e6zInR3l/
	 fnNMVVfNGZmIWcTuFkt0eCeE56RSM/aXN+Rx5+MORr3LzZF9GOU6g2Ste5r+CiZjgY
	 hxm5XeliGEHXjc/5L7nxQO87aRszCZ/fmqXAQxmI7Vo3xum4JlLlWtdux/6b+mFjCO
	 xRWhDgNCN5l+A==
From: Mark Brown <broonie@kernel.org>
To: ping.bai@nxp.com, lgirdwood@gmail.com, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, shawnguo@kernel.org, 
 s.hauer@pengutronix.de, Joy Zou <joy.zou@nxp.com>
Cc: kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev
In-Reply-To: <20240311113201.664252-1-joy.zou@nxp.com>
References: <20240311113201.664252-1-joy.zou@nxp.com>
Subject: Re: (subset) [PATCH v3 0/3] add pmic pca9451a support
Message-Id: <171138867371.327260.16196435738719898884.b4-ty@kernel.org>
Date: Mon, 25 Mar 2024 17:44:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Mon, 11 Mar 2024 19:31:58 +0800, Joy Zou wrote:
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


