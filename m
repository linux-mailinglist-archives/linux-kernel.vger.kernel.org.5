Return-Path: <linux-kernel+bounces-117623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F5F88AD6A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1B3B363650
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06945137925;
	Mon, 25 Mar 2024 17:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uleASsOJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486815C8E4;
	Mon, 25 Mar 2024 17:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388661; cv=none; b=VGhE7r8+8UVEB+Mqj4PnJTt+WH37kf39xNRPz6uGsomnjbKdO9WHS9X3LdRE4Q7UCBuX6LpOgDDOLRSiRQ2ID2NeAWB8W/oNxWg7+lT2VfXD8gyJTWiRc8yFUg39L3A02P6vrRKb3zu5kGNKX2iHB0kiyKn0bcgA1+t1t4t0pxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388661; c=relaxed/simple;
	bh=3phOsfj299vReX13jBEsAZUiG0U9Ij11nDe4fUf1txA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OjkWT5v6Fci6JQnK8Wiuv7QPwB+1yl8javZS3X9gJMcBzJqrCqTBgt98CNEwLvJAy3qxSNdk/1ydghzJ21N4P9kDczDCGiQZkGp8kBAQzi2J8O0Ha9vmjh7o/luB8pD9Lfq2eq/fWKSZQJUVGSYE7AjHF+v//X/G6YCV/fXzCKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uleASsOJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80035C433C7;
	Mon, 25 Mar 2024 17:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711388660;
	bh=3phOsfj299vReX13jBEsAZUiG0U9Ij11nDe4fUf1txA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uleASsOJVKH6GH5mbWkE7YCmO5mRO3FV8rlVA/9sTcBM5MnphiVvP8xSo0Wgt+yjk
	 I4U/dnEpppcmTx5bkfN/HCSsafZL/4i6/PmGAzTyf2IEe81kEJhD5lH10cQ0mTAyKh
	 4/Pd4vY1zFMrdyfTnIRCfQ63cqEIRmLJ10uRyKV3G1S8z7rNqAteLIwEa6ckQjjRAF
	 cFfpJspRAWTHzAESj5+y77LbMD4bOS561sIneCO6H3pVzvaRm7EqgMInepw7cYCHES
	 9jhE6Rm2TC3HBL5pZdTtv4ZLrs3XhM0pWPKdDngUp3UIaiJCXoUd1ep36evAdQ9iQN
	 731RjYgye/JlA==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, venkataprasad.potturu@amd.com, 
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com, arnd@arndb.de, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Syed Saba Kareem <Syed.SabaKareem@amd.com>, 
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, 
 open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20240322112018.3063344-1-Vijendar.Mukunda@amd.com>
References: <20240322112018.3063344-1-Vijendar.Mukunda@amd.com>
Subject: Re: [RESEND] ASoC: amd: simplify soundwire dependencies for legacy
 stack
Message-Id: <171138865825.327140.9353092446072557708.b4-ty@kernel.org>
Date: Mon, 25 Mar 2024 17:44:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Fri, 22 Mar 2024 16:50:15 +0530, Vijendar Mukunda wrote:
> The CONFIG_SOUNDWIRE_AMD is a user-visible option, it should be never
> selected by another driver.
> So replace the extra complexity with a normal Kconfig dependency in
> SND_SOC_AMD_SOUNDWIRE.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: simplify soundwire dependencies for legacy stack
      commit: a806793f231e390510343837668d8f0eade75a72

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


