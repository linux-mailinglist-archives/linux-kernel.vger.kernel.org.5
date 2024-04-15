Return-Path: <linux-kernel+bounces-146013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6FB8A5E9F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 01:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 709541C2119A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F4E159904;
	Mon, 15 Apr 2024 23:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3seQHi3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478941598FD;
	Mon, 15 Apr 2024 23:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713224593; cv=none; b=k3j7rmjzyAL6PxUYv1J0+DACpKjdwX25YX9cevRPcE38SoXgSmqoa/HCXXxJWH8mcQ+5MDxz2RtJ27tXeJKapMzacr/vpVaN3i90jW0ersxMhRkOgwfJueYdtQk6pKQuGHBhOW2DqCUWTIJJeWo/wK7zgjaqXgwmpxJLVEW9zuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713224593; c=relaxed/simple;
	bh=nSVDjyOsaXPwEFf4Masm5f7IC2GELOaFx6Wn5p9UtNU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Aq2W1Gdf6/S0m4ds6hHxkb1nzWDk/cfpQeXA9C3r6sHeOe769humK1KriRYGX2U7wTumJOlygGQ2r9etxIs8+E/j2v2KVWdggWPsb7V8Qim2r4SQJpElhV6DPt5cVDrad+8YyUa6wWS2TElLqPVh87p0DXsk/JpZCTCeWWRXIKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3seQHi3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA69CC2BD11;
	Mon, 15 Apr 2024 23:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713224592;
	bh=nSVDjyOsaXPwEFf4Masm5f7IC2GELOaFx6Wn5p9UtNU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Z3seQHi3ftMKwRqU1M7bzr4We4qvJ0rgVoKLjTO6uSZMYA9OTTMGwEcZ6fbbQmtVI
	 3kZrpyOVGeMd1TV5CNkaKmf3EDQdH56J2g/BhGeTLTkLkphvYI0Hp8BjKlChM8YHhB
	 VYmbfFBE5vakqfGEqI0AdtqI522g93wZtfF8yld2Rvxk8jLWanTgzZeqgYshcnDGxD
	 2qeiHOK6RHUTib9We9MNRF8GkZ7gGCWmq2T9EUhFAHpzxAi/Zw7hRoiZ+LhUTiARik
	 etb0lJoqnKmXlsKLvk2tJE1WDDDIuwRb6LP45RmEWi2167JQ0ml/2OPthCej6amcxL
	 lYN+YZOv8RfjQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, John Watts <contact@jookia.org>
Cc: linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20240403-sunxi_s32-v2-1-29ebf6ad590a@jookia.org>
References: <20240403-sunxi_s32-v2-1-29ebf6ad590a@jookia.org>
Subject: Re: [PATCH v2] ASoC: sunxi: sun4i-i2s: Support 32-bit audio
 formats
Message-Id: <171322459009.1659018.15608590783585175158.b4-ty@kernel.org>
Date: Tue, 16 Apr 2024 08:43:10 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Wed, 03 Apr 2024 14:47:35 +1100, John Watts wrote:
> The I2S cores used in the H3 onwards support 32-bit sample rates.
> Support these by adding a per-variant PCM format list.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sunxi: sun4i-i2s: Support 32-bit audio formats
      commit: 863f94ac5f4481a7c5665e8152d551701ac71bf3

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


