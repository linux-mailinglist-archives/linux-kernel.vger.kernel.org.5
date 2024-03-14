Return-Path: <linux-kernel+bounces-103367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 874DA87BEA0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DA291F23A3F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978476FE3E;
	Thu, 14 Mar 2024 14:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTZo4JrG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D388058ACF;
	Thu, 14 Mar 2024 14:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710425649; cv=none; b=umAGgmxEkhKJRqY1U8WysvQK2rCN2ucUF2A1ymrsy9eTgRh8EEU0P0TQbFila3l5T15Xih3ERU0Tu+O+O9GRsyt5szqcICyGNtQGnNc/42YumIcBEA5EBrtB5MSxMyEvOUrSk1rfbniGLtrUBhq0dtWmfIrdydPGLWtIA9Nl/ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710425649; c=relaxed/simple;
	bh=lK23oJRJ/bA6d6jmZaBMLcWgOIERyQT1+j1cFBWNLd0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HMo8Hx4e7r13Fj45eqmtbvnzNPHN5FDcE2gbw7OTL4kk3AfF8yvHdKidonyLxnDtlZ6Buqu38QOSdDtHcaaNq4AU1m/36RJSQOk/epfmE5Gq7aHR6bfHxwzOG+czVfAm3lXSdBStL/ztSBg4GqsSliUItSdZ59of5fX1HlkXnjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTZo4JrG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2362CC433C7;
	Thu, 14 Mar 2024 14:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710425648;
	bh=lK23oJRJ/bA6d6jmZaBMLcWgOIERyQT1+j1cFBWNLd0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=UTZo4JrGlYJvjvkqbKP9KYF2NnJrppTbDm9iTLI+SxMt0v4M0gEk8c9z8+Yae+S42
	 IGyjW+5xOoI/1FE9ZQf0er/hcFd/jhLCVnyzqKoFxXsQ+euUTlqFvpTb5ar0AzhqzI
	 OFelPUMUGPO0aWcHEZUkdYjj7HCYQwEdQ6FwKyMawyC8UoYfUvRvbV0+Cy1i4F7n4K
	 RajFBL3gIlgNOG5RtqYyRzQOEWrTLkCEBdRH/u+5/tpjGo2/cP+adQIpRiXNrMe/2Y
	 7kT9CkjUhLs/L853OBPVpzGxRiHvEG0IqaUnUPJF/gBfmFU6yaiWL+0zMnPUXGvEqv
	 mbEEATbnr4zyw==
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
Message-Id: <171042564484.33758.15956147423867309786.b4-ty@kernel.org>
Date: Thu, 14 Mar 2024 14:14:04 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

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

[1/7] ASoC: rockchip: i2s-tdm: Fix inaccurate sampling rates
      commit: 9e2ab4b18ebd46813fc3459207335af4d368e323

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


