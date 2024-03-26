Return-Path: <linux-kernel+bounces-119448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA8488C8F2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D20A91C60645
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A064513CAA5;
	Tue, 26 Mar 2024 16:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdMrYjnh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC0D13C9B4;
	Tue, 26 Mar 2024 16:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470143; cv=none; b=uk7j24v4Q4I9TacqZIxwL8Hr4SO2OLYLD58ofSQJlYbgYFoUNcJZMkygBOuIhEx1r3/gB9mYCMe59qiEMXh/WioIE1Fs7DOT+Ij2dtjwNQTNrzSsG8MJPxlVWeKcNn3gIL8IYnHfW/lRLo3x0vLgUiQoSCqxyt7z0Q4IG2zYE1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470143; c=relaxed/simple;
	bh=//W8P4cggBSW4ea8DF0U9iBbG/iet5qmMnbhF2CbDqw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mKxpSYw2RRuH0ckp5li85hB8icdIt0PQJLm3LoDm1QS/oVput7OiKFZaKd2P7i4dz+O/ZYrVbBk1x8VCnIYDRNT/m23hJUSeadTL6nQGABQH/bkGSzy6fUPGjZWB0Hf8vHdu0bT4ahqleo9OVTURKIeJr1O5TNrJ795X+bGr3aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdMrYjnh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA99C433C7;
	Tue, 26 Mar 2024 16:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711470142;
	bh=//W8P4cggBSW4ea8DF0U9iBbG/iet5qmMnbhF2CbDqw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WdMrYjnhXYNxEf9pNXnLav5F4Q4epZrMVL+Zz2HGT5iP/apNBDGKnDGgaXPEvRqrt
	 OSt7ASfME63Asis7oPSNMMgDVkQ/tEhvKBMxVpzSrdnS/N75iru8LP3FECq+002ak4
	 gEyUzMeFj6KXQKuwDvIfyQQRgiUP6nX62l2D26HzNjSef8Oz+1ECVc+zo0iExP5RRS
	 rLgLMDcuR5YKGuOCC2PuNBrfu0P1FJeJ/hNj4mY/rqdwsDnwSvOxF572bK07/6t3KK
	 Q4sddwI+t3yMJBC95MgpPLzqKjF5xzaeAY5h8sL/UBc/OVCZpMbeY0KvMCb4pEzdtd
	 dMKOk7KIy4enA==
From: Mark Brown <broonie@kernel.org>
To: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Heiko Stuebner <heiko@sntech.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-rockchip@lists.infradead.org, linux-sound@vger.kernel.org, 
 alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Rob Herring <robh@kernel.org>
In-Reply-To: <20240305-rk3308-audio-codec-v4-0-312acdbe628f@bootlin.com>
References: <20240305-rk3308-audio-codec-v4-0-312acdbe628f@bootlin.com>
Subject: Re: (subset) [PATCH v4 0/7] Add support for the internal RK3308
 audio codec
Message-Id: <171147013904.144152.3554445649674983907.b4-ty@kernel.org>
Date: Tue, 26 Mar 2024 16:22:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Tue, 05 Mar 2024 15:36:27 +0100, Luca Ceresoli wrote:
> This series adds a driver for the internal audio codec of the Rockchip
> RK3308 SoC, along with some related patches. This codec is internally
> connected to the I2S peripherals on the same chip, and it has some
> peculiarities arising from that interconnection.
> 
> For proper bidirectional operation with the internal codec at any possible
> combination of sampling rates, the I2S peripheral needs two clock sources
> (tx and rx), while connection with an external codec commonly needs only
> one.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[2/7] ASoC: dt-bindings: Add Rockchip RK3308 internal audio codec
      commit: cce4cbb157493483f03c21213753b66425a31430
[3/7] ASoC: core: add SOC_DOUBLE_RANGE_TLV() helper macro
      commit: d75a21611a6e723d81db3f827e131ad39b69186c
[4/7] ASoC: codecs: Add RK3308 internal audio codec driver
      commit: 4ed0915f5bc4bcc81bca783a5b984f3d81e9764e

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


