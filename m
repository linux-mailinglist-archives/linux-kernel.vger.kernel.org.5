Return-Path: <linux-kernel+bounces-119309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D33B88C6E1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32216320840
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B1613C9DE;
	Tue, 26 Mar 2024 15:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cneiOIVU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377BB13C9CF;
	Tue, 26 Mar 2024 15:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466862; cv=none; b=dHsFxF6r8uxxoDBMVPzxNtw00X5KK5HaNTvpFdslHsOXpI5NjZBIVk0kjgquXKqX1Drc06H4RkDvQOMqBVx9kmM7jJGomHEq5cOoQVVPJZX5xbcB++czh37+cUporM1f7J1fpgYdRIYfqdLBvOlhccO305hMlemFhAOx+fCpm9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466862; c=relaxed/simple;
	bh=jnDKCBGZ3mEKwOzhDtE+4+tTWxXMCbPw9/Yta9NdMSU=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uFSUDuyVgqify3KC1E1eGRfFrFAbl4DCtYCoGSEbTMNss47V1zoMu/5ODaN4BVI8urAJrESyBjD3yOSuRIU4Q2uP4XttOn7iIFJAhso6O9G1AuyLnay8Zrmc6/4RfnMeVPzFp7TSISjClbg5mz2IVWQUVhjNanW11pJA65sGxLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cneiOIVU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A6BC43390;
	Tue, 26 Mar 2024 15:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711466861;
	bh=jnDKCBGZ3mEKwOzhDtE+4+tTWxXMCbPw9/Yta9NdMSU=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=cneiOIVUSw3BIhivAzv7EQjXpMfXoxj46GIJw2UWv9LBhSZcI+8Yi55Oq07LD7G51
	 NqsrY++g921HTWD9o0mTh/l5wcYPQuNFK8W7f4UPFUz1cdWAD0J3LTxQ4aQV6bz2U9
	 blo7r8Er+d4IQtdlVHo+81d6QdYQ+smDe0FPSeMCYJNVw1TawIaKYZ2+k1qk+eud84
	 +La8Lh/eKF7BHyTnRK6feuaUcj0Mg9IWNzTNR8A6HUfn+KhhcCY3vqz3RYVXEUwFsy
	 VpzqEaUxk+KXWSHbvM/ZV5wO2OGTSvn+7+lO2jz8ptIQXJaan1vdB2oYGk7SAR2KZk
	 lGNXQMXuvvO7Q==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
 linux-imx@nxp.com, alsa-devel@alsa-project.org, 
 linuxppc-dev@lists.ozlabs.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Chancel Liu <chancel.liu@nxp.com>
In-Reply-To: <20240311111349.723256-1-chancel.liu@nxp.com>
References: <20240311111349.723256-1-chancel.liu@nxp.com>
Subject: Re: [PATCH v3 0/5] ASoC: fsl: Support register and unregister
 rpmsg sound card through remoteproc
Message-Id: <171146685832.132239.2142300799841463466.b4-ty@kernel.org>
Date: Tue, 26 Mar 2024 15:27:38 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Mon, 11 Mar 2024 20:13:44 +0900, Chancel Liu wrote:
> 	echo /lib/firmware/fw.elf > /sys/class/remoteproc/remoteproc0/firmware
> (A)	echo start > /sys/class/remoteproc/remoteproc0/state
> (B)	echo stop > /sys/class/remoteproc/remoteproc0/state
> 
> The rpmsg sound card is registered in (A) and unregistered in (B).
> After "start", imx-audio-rpmsg registers devices for ASoC platform driver
> and machine driver. Then sound card is registered. After "stop",
> imx-audio-rpmsg unregisters devices for ASoC platform driver and machine
> driver. Then sound card is unregistered.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: fsl: imx-pcm-rpmsg: Register component with rpmsg channel name
      commit: 41f96cd53f2838ac4894491ac5eadb06f1e5b858
[2/5] ASoC: fsl: imx-audio-rpmsg: Register device with rpmsg channel name
      commit: dacc7459745df168152b5cceba34efade9b5e063
[3/5] ASoC: fsl: Let imx-audio-rpmsg register platform device for card
      commit: c73524768e9e1a7ac9eb3a4d36a1ac0d34f22644
[4/5] ASoC: fsl: fsl_rpmsg: Register CPU DAI with name of rpmsg channel
      commit: 0aa7f5406afa828a93d84d75c9b9ac991cd75367
[5/5] ASoC: fsl: imx-rpmsg: Update to correct DT node
      commit: c14445bdcb98feddf9afaeb05e6193cc1f8eec1a

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


