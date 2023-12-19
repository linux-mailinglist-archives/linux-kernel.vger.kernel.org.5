Return-Path: <linux-kernel+bounces-5533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3DF818BC8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2268A1C24632
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9771C1D55B;
	Tue, 19 Dec 2023 16:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZwCGzKC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34581D542;
	Tue, 19 Dec 2023 16:05:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394FBC433CA;
	Tue, 19 Dec 2023 16:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703001943;
	bh=dFfTW4Ywg/AnVhHHspPjP/ls8JhEBJSKWAKuZw3hh00=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=EZwCGzKC1l35Wk38SgOiMAWDej7vsInLJWFf/Frx6JArZxgiihEL+axeTVAJsz8T9
	 BF2WyoDd3J8XObr7sn6XbhFCj1GaPxJvsuOB26BoXIGsM5dqyxOEDgwtZpxIoN4wwi
	 Oau/Dh7rsZIAH7WPof7tDf+Y1jGRB0L/WgyF5mMM6P7cOcok1IMlwib1ptQK178ZCz
	 wb+qf/ORQBpg1stzbdAc6tDWW4c8dxskTSMSnScN/3C73rgJFvyPbCXNHFHnGDEv6A
	 1EuZx2G/QCEhRZ/HFwGlwV/SZNullZWiCAkrbsClFSf3rJdxOHoipDbqoN3QooPE/Y
	 ZLIdkrUJ5KF4w==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
 Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <1702953057-4499-1-git-send-email-shengjiu.wang@nxp.com>
References: <1702953057-4499-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2] ASoC: fsl_sai: Fix channel swap issue on i.MX8MP
Message-Id: <170300194095.59057.18227409280630031139.b4-ty@kernel.org>
Date: Tue, 19 Dec 2023 16:05:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Tue, 19 Dec 2023 10:30:57 +0800, Shengjiu Wang wrote:
> When flag mclk_with_tere and mclk_direction_output enabled,
> The SAI transmitter or receiver will be enabled in very early
> stage, that if FSL_SAI_xMR is set by previous case,
> for example previous case is one channel, current case is
> two channels, then current case started with wrong xMR in
> the beginning, then channel swap happen.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_sai: Fix channel swap issue on i.MX8MP
      commit: 8f0f01647550daf9cd8752c1656dcb0136d79ce1

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


