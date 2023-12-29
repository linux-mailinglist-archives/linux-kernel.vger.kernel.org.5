Return-Path: <linux-kernel+bounces-13169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D89148200A4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 17:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 117421C2276C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 16:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9910512B6F;
	Fri, 29 Dec 2023 16:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbs7vhMY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62C3125AB;
	Fri, 29 Dec 2023 16:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B1FC433C7;
	Fri, 29 Dec 2023 16:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703869101;
	bh=b4JkRx9IW/2Mqis6Wxs8UBnV3+psqONjdD8/WLplL4o=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=qbs7vhMYcMb4ICsZXu39XriMqUaLOaVs4Lk/yGM4iXMzitHergVz/QOBScC8ykPv8
	 j9yb2b8Re7LqgxUgcSCdzPm2fR9HO87QOB6LuPXRMbOmcocqJH4sfwM6KvjKsexTmP
	 S0LqOlAtTh1USnt0kCcyzCka/EnFb/jhes7tXkPXftd8ruQtaPj1dxU6ND346Dnu1C
	 kp58fT/d63Xk6D/owpnFxB78dV/8y76W/+6qTs/6KCkqQbiPIHCNh1EfHBYrhHwhZ9
	 P29VMADrlu9B3W6t4/ONRs0aoTlrtMguEz1IZHeNzK8P/+apm71kiy85Xwmux2zxiz
	 cZrBO7XNHHNCQ==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-sound@vger.kernel.org, 
 Chancel Liu <chancel.liu@nxp.com>
In-Reply-To: <20231225080608.967953-1-chancel.liu@nxp.com>
References: <20231225080608.967953-1-chancel.liu@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_rpmsg: Fix error handler with
 pm_runtime_enable
Message-Id: <170386909836.3001741.632329944524813915.b4-ty@kernel.org>
Date: Fri, 29 Dec 2023 16:58:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Mon, 25 Dec 2023 17:06:08 +0900, Chancel Liu wrote:
> There is error message when defer probe happens:
> 
> fsl_rpmsg rpmsg_audio: Unbalanced pm_runtime_enable!
> 
> Fix the error handler with pm_runtime_enable.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_rpmsg: Fix error handler with pm_runtime_enable
      commit: f9d378fc68c43fd41b35133edec9cd902ec334ec

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


