Return-Path: <linux-kernel+bounces-149367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FB68A9025
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0052E1C2189E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 00:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1865250;
	Thu, 18 Apr 2024 00:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gls3g7qO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BAB10FA;
	Thu, 18 Apr 2024 00:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713401295; cv=none; b=RnKK7lWvwNCRYquKrD4sBsmeUDQRb48ab5E6C9wWRWgy2BFrAqBCbSPC6noOXG0mOpeOu40DjMIlkX0xIPdQ9ABlouvUTjsmu73uMXXr3D3WJzvKa4CEJ5KZ5VkVeMuq3SmFH9d73l40coIkTcllzr7Lp2CMpo95LDAeZkRfl38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713401295; c=relaxed/simple;
	bh=xPnahfmQIFca6y8E5nvS97ElmYlbcx7YSzNHDH6T6YY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uqw9tst6eaeZjLnfSy1Km0BrcSsW1xD5ZpAnINkVKiftLx2+mk0NPrjHInK03uhaHC5PeE2N2ZtKB/SCzczb6m2z/H3HLGdsRh0yJ8hjPlL6ozosOOdxOCrf+dQB+/Z413TnwEPDaHvmG0nGpdnBN1NWKU0HUQuK+dFmnMY35iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gls3g7qO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C1EC116B1;
	Thu, 18 Apr 2024 00:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713401294;
	bh=xPnahfmQIFca6y8E5nvS97ElmYlbcx7YSzNHDH6T6YY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gls3g7qOVJtjW4NLZUhz6lIM1d8H9jORz0wp7oR86eulbx0ggQzxPdhjyqqD0p5ft
	 4hUH68K/8ukL5SJvEGmduaayieszdweSbHH2/p1CT8cgrcRWRe2ikoY6WisBp41uF9
	 umnrW2xQdFhJFfYepc6i84c7DEQq2t6bJAM0+WaB43o4Y5Hibs7xiO+/f/KsqhNrTg
	 rTSt81pGVa+KF2F4u1qFpn2rjIrRCI0RLsujCcvhKbOqgDXR0S34W4NcusEyE87ICd
	 YNPZ+ANddqKxPerK69JGnvPMgwcFq3cKx6jHpyZpZ83mosIy7o1jPQWtqcTJwtLtYG
	 KIHdVKY/eo+LA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, John Watts <contact@jookia.org>
Cc: linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>
In-Reply-To: <20240417-sunxi_s32_fix-v1-1-d82e451565c0@jookia.org>
References: <20240417-sunxi_s32_fix-v1-1-d82e451565c0@jookia.org>
Subject: Re: [PATCH] ASoC: sunxi: sun4i-i2s: Fix pcm_formats type
 specification
Message-Id: <171340129170.1712879.4402908289231209104.b4-ty@kernel.org>
Date: Thu, 18 Apr 2024 09:48:11 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Wed, 17 Apr 2024 15:14:43 +1000, John Watts wrote:
> pcm_formats should be a u64 as it is a SNDRV_PCM_FMTBIT_* not a
> SNDRV_PCM_FORMAT_*.
> 
> Also fix a small grammar error while we're here.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sunxi: sun4i-i2s: Fix pcm_formats type specification
      commit: 9be51470d514eb20d4ce29684cf933ef1c5fff48

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


