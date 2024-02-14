Return-Path: <linux-kernel+bounces-65444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B28A3854D27
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E9E71F21DAC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163085D8F9;
	Wed, 14 Feb 2024 15:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T05Rg1GL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552C45D49E;
	Wed, 14 Feb 2024 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925462; cv=none; b=SPe29K+NyPXTbReDFmySuZc+mHHgZYzh6NjXogjqUdtrSxGCiGCfheuvbbnHLMpI3B23UpmGV9efy7KF80LMSDoUJIVZX0XLX3VYUaGW2nHLZ4QJuZIQWz3rUrhF80LXTT6sLSTNCO1Gw5OCLFWW1eywxqQN02PFWeI9zmBishU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925462; c=relaxed/simple;
	bh=dMNrclhA7uStPGoba5K2BJ7MHHMLO2MgIpz/A5BhoRY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Z+GBSl2ocHhmCNDn9nW2pcjTA4s3z+bhXjDGaELyJIXnNLQSdHQbXSDGwDi9W08LRrteXvewz3EvlVYMNbXvqOPtHWq92Iy8jEZguyHVkMHEmsFp6NaB3oHl+OeULN7ESYT9+0h6t0nW4A1VisbrhB8N4shUTzWUjCPRoDDrHu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T05Rg1GL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D6DC433F1;
	Wed, 14 Feb 2024 15:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707925461;
	bh=dMNrclhA7uStPGoba5K2BJ7MHHMLO2MgIpz/A5BhoRY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=T05Rg1GLSAp+sVabhLsKjdzy1fP1Pl2BFJTZKoDrtwXS3CIpP4rvkaQYtnR6LJoZs
	 iWB8tOSqjv7kVZr1LcpWqUV1jr5FTYAkzxwPlUAqT8VcGE81a0DlH1h3QFacVYmgoK
	 OeZv5G4V5y5h+TjztNgUoGGmOMfFgQDvM3jg0nqugDDVn+Qpz5Ofsca8Twk5Lh7W0X
	 /FSZ6OaorQkmvfY2gLbuyBKqeQQbHyeQAebpUz6e31eL1wo+Vnq/o+9MZBH8ZkBLz3
	 e31ulQSxelpSjoVK2RtuY/CwqvrhCCM+9d+drFp99lvayYQrkMfIjdc+Mg4209Mr59
	 H+tSPKTWR1xfw==
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <5593d147-058c-4de3-a6f5-540ecb96f6f8@moroto.mountain>
References: <5593d147-058c-4de3-a6f5-540ecb96f6f8@moroto.mountain>
Subject: Re: [PATCH] ASoC: SOF: Add some bounds checking to firmware data
Message-Id: <170792545901.151568.1454091420100022542.b4-ty@kernel.org>
Date: Wed, 14 Feb 2024 15:44:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Fri, 09 Feb 2024 16:02:16 +0300, Dan Carpenter wrote:
> Smatch complains about "head->full_size - head->header_size" can
> underflow.  To some extent, we're always going to have to trust the
> firmware a bit.  However, it's easy enough to add a check for negatives,
> and let's add a upper bounds check as well.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Add some bounds checking to firmware data
      commit: 98f681b0f84cfc3a1d83287b77697679e0398306

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


