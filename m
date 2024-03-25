Return-Path: <linux-kernel+bounces-117622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 864C088B1D8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9522B3C2DE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD0744C73;
	Mon, 25 Mar 2024 17:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CM0olkc8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B5213777F;
	Mon, 25 Mar 2024 17:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388658; cv=none; b=m/COSO/C416d1pRJC0aZesqlB13jBAPXIZ4SKTlnPeoOPHD43hrx6xvJXo7HQjXsm1BCr6GNWI2Bff//u1yFY+hioX50uhU/4/BPzRCyk/lnAWswoQ7rBiu6RaKkp00jVH8VAk/KDHVnrXwkYvRig8Pn50ohIhqN0nqcB0vsY30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388658; c=relaxed/simple;
	bh=qb0iwJLbOS+LnSN4h1wK8br8fS0Emdh+02cjuu/+jmQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dwXUWSdFele+QiaVPGhsZutFhWGDJ09tXN/gCaztWTWd4DNUVE6Qp9Y/PQvLmnapDmwZtxlPvrkKOkSMu7R2oAqA6DPrnVZkJde3culSIwtiFdqG+hDa8NOb1/f0yYqJjUAfqElP5UT4hG4Fr503HEvgozEkePwMixIFbw6XMkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CM0olkc8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF51C433F1;
	Mon, 25 Mar 2024 17:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711388658;
	bh=qb0iwJLbOS+LnSN4h1wK8br8fS0Emdh+02cjuu/+jmQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CM0olkc8ABVp8KmSIRMh1EoZWuTErWkfpQ+hJU4vDTWnSETmZfbGeyRGVE4x9Nyxa
	 27DwkyOdKYLCruQnOqbQHzR05Rp3BAE2hAyghZiJ8C137RVPkChKjQqD/PQV+L4ejY
	 2reiR8/UxcV8rWkRIj9u0WCdGg5J1pte9EghB0pRGEYPKf2DtOoAsSQ5r4dGkgxqPZ
	 eQTqsvSSW3FZK4OC3sMVhHKGAkLI2w3TT5ACE1yGocgfq9tUuug0T44ZD3bdxHFEZv
	 f/WiEP9nvnZXMqXQbbBQSQZvSGXUeZyebHHHVztGIihBia+vYv1+x4Lhc0CHDh/WRj
	 eV5x9HYl8IfSA==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, 
 linux-sound@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>
In-Reply-To: <20240318200804.181516-1-andriy.shevchenko@linux.intel.com>
References: <20240318200804.181516-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/1] ASoC: fsl: imx-es8328: Switch to using gpiod
 API
Message-Id: <171138865464.327140.5568916833564730450.b4-ty@kernel.org>
Date: Mon, 25 Mar 2024 17:44:14 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Mon, 18 Mar 2024 22:07:56 +0200, Andy Shevchenko wrote:
> This updates the driver to gpiod API, and removes yet another use of
> of_get_named_gpio().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl: imx-es8328: Switch to using gpiod API
      commit: 9855f05e553637f05494cf47a3154cbf9a5cfc67

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


