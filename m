Return-Path: <linux-kernel+bounces-131619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F01898A29
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BF3D28B744
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA5A1BF37;
	Thu,  4 Apr 2024 14:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYA0EB1H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7DB1B964;
	Thu,  4 Apr 2024 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712241083; cv=none; b=GPmPS6AH+1YpCA8wgnMdXPmXFK1WmFC8bdSyjyCTh11jXvyeLpzBYGD+a++WQ6okvhBI7ncBUzV/26RpxVCqzb1ElfY877eD3VQqsYJ5RZPuzGiKOASEWK0BZqCE78FRxBMFJHMBBehDXqjmKsokKtwD7ab7T3EhKKkaoGo3R7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712241083; c=relaxed/simple;
	bh=vhO27Ty+RIin9lraup6Rk3YVD0AeGpm38zAeCXXfmFs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KwjyXiJl4XepoW+MsA6cdqrXCaXeAFBug/o804ImuPYlAico6yg21baXKF1s8Z4sxvlGLhFhZoiDZFlI1hDATXTgP598WorbjOtibD+CpitmUiOkl9ej3o1SwevLszyP3vO8GvIBpDCYHxm6rowyy/tvxreNVFUwYXY8bVgYc3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYA0EB1H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1BD7C43390;
	Thu,  4 Apr 2024 14:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712241083;
	bh=vhO27Ty+RIin9lraup6Rk3YVD0AeGpm38zAeCXXfmFs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iYA0EB1HEHAHXvo+A6Ny8g4xZ8unx/pE/qT1+v5LgJdIUqZG5yAcG+WwrNmyxfUYW
	 jfiLSCw3mxm+yr0Gs9OcyVAwTxFbYS+p250aDX2FFPdREPrqXbtuGnRdbUhT/AYa4u
	 WSCIDQ0Aw5Nj29Qs3+AjHRAxYYd68YoS4aOGZnnmvdxEMSVb1qfHU2CDn/ZXTYC9xY
	 Agh0AvFv7FEU7cR4kEo+RvhdTsESiypU8eb9SClDXO+AwAOETOPkZNcl5FxNG49fSE
	 WOQ1Rosi1OCEW4H2jTYRyPwZtSq7oOI2OOSzFHWRnL6IPpHrYyLakzKdnST1r+phtC
	 mrEFwKkT83ktw==
From: Mark Brown <broonie@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240404095755.650364-1-arnd@kernel.org>
References: <20240404095755.650364-1-arnd@kernel.org>
Subject: Re: [PATCH] ASoC: codecs: rk3308: fix building without CONFIG_OF
Message-Id: <171224108145.46716.9770725515757829141.b4-ty@kernel.org>
Date: Thu, 04 Apr 2024 15:31:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Thu, 04 Apr 2024 11:57:34 +0200, Arnd Bergmann wrote:
> The newly added codec has an extraneous of_match_ptr() annotation for
> the ID table:
> 
> sound/soc/codecs/rk3308_codec.c:956:34: error: 'rk3308_codec_of_match' defined but not used [-Werror=unused-const-variable=]
>   956 | static const struct of_device_id rk3308_codec_of_match[] = {
> 
> Remove it to avoid introducing a warning when -Wunused-const-variable
> gets enabled by default:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: rk3308: fix building without CONFIG_OF
      commit: 2ba2d17170f9e415fc31d7978214f0f26e8afc64

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


