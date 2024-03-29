Return-Path: <linux-kernel+bounces-124659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2ECE891B1A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81EB31F26A60
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BD616D9DE;
	Fri, 29 Mar 2024 12:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJcORa8/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B14316D9C8;
	Fri, 29 Mar 2024 12:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715649; cv=none; b=kYyWKSKUGOOMsTlFtGRLXP8oLkOWDSdMXHaq/qS3tnwcsZEiBiUINKg/VtCXNL+kzcoYBlBrtXfKD7s+ImhbiZiy9mBamK9uPAK4EJ4FAWBWQr908PqSTAvDlWgh7PQg9y6xmkPF0fu9acPuRMRjiaAKvPioTV2WpnnSmrgUn1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715649; c=relaxed/simple;
	bh=07Im89H4tHbl47gQN4Y6CAqTRo++fE4Q9rVsVsY1nW0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fwZK8er058khVV0NKHFef38aQdFeK76s0dGwjnMCktApwsD5a0TJL5qrY79RVcQJMY5OWVssKal0msuFP/VnuTeN3uwcoywcT75AjmI5jX7bnDQ7vQXPM24/ExYZgOsrpmHnxoOcjxig+e1JyaOpBsXaSD0YGkAeTxv06/3T++o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJcORa8/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8C9C43399;
	Fri, 29 Mar 2024 12:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715648;
	bh=07Im89H4tHbl47gQN4Y6CAqTRo++fE4Q9rVsVsY1nW0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dJcORa8/SPhfnx6Lc3PvgaxYPdxcahiymbXYW8+no8GI9tFomloDoADyDaB/3TL8K
	 K3SK86xefwZBHTqooPYhwX6cYjyBDmJvTp97/6xKAqBtxmf8p9RmOZ8qrEDE44DB7H
	 MoOCuEqIFmsPQfDzskIC012ryHj6U4JXg6s49go8rWEX4OW16glDYTEO4rMwZH1EsP
	 xLqHPaV12qWaYiACWEU0z0ZmGNfQXxONScEi5oRmPawLDHAbLjyih22ft5d2iXoeQa
	 rAlxMfOmAdF3+8Cij5+mp6eS8WUefto0A2Hl1oDaQobq8paRpuAhfx0wjz6h/2uImD
	 iefApBXfd9V4A==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <20240328-asrc_8qxp-v8-0-801cd6bb5be2@nxp.com>
References: <20240328-asrc_8qxp-v8-0-801cd6bb5be2@nxp.com>
Subject: Re: (subset) [PATCH v8 0/5] arm64: dts: imx8qxp add asrc and sai
Message-Id: <171171564576.7557.13075267418118502846.b4-ty@kernel.org>
Date: Fri, 29 Mar 2024 12:34:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Thu, 28 Mar 2024 10:51:32 -0400, Frank Li wrote:
> Update binding doc to avoid warning.
> Change from v1 to v2
> - Fixed dts DTB_CHECK warning
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: dt-bindings: fsl,imx-asrc/spdif: Add power-domains property
      commit: 9b21531866fced634bcc7fca33667c7ef258433f
[2/5] ASoC: dt-bindings: fsl,imx-asrc: update max interrupt numbers
      commit: 82330327ce03889f20072cef5167499d51cdf260
[3/5] ASoC: dt-bindings: fsl-sai: allow only one dma-names
      commit: 7b5f2072657a9041cbaf4ba139f672be11694ca3

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


