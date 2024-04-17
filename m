Return-Path: <linux-kernel+bounces-147864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF95A8A7AB0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06971C20BB1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2B17470;
	Wed, 17 Apr 2024 02:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpW4vqh0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C64187F;
	Wed, 17 Apr 2024 02:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713321963; cv=none; b=g+nKTEsEgFLnrARyEEkV6M2XNt93OXLxCHjdM/bKKU4UN1XxUI5E2PnXr97OgTKsw/0vr4fBGNSWkmAWKfkOfdb5aa5/NtaBPdnIISq1qrUPrAops4883MVnknLvtIIVQ2W4hufjgfF9ksMUYSSh1RPgeEiVc5aZS2teV9GgDcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713321963; c=relaxed/simple;
	bh=oRtdwcXfjYROqHZ+bXnWxLq9Cp1snZlo3O4Podnjrow=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RxonZy8AfajPp+H/mtc5Rgr4wpBFYLJGv7Af+8rRhUOjZ3MUaLj0p/wEyBju66ezuSm8Ql3LBLMRKcQWQvuonAeVtW6TBobDp8YVKZDlaqYos9DLdHopB+m9G/6CFsAxKuPBGWshqXCOkORmqUTsJd8AORVuE2JEl4U5lBWS8tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpW4vqh0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92545C113CE;
	Wed, 17 Apr 2024 02:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713321963;
	bh=oRtdwcXfjYROqHZ+bXnWxLq9Cp1snZlo3O4Podnjrow=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fpW4vqh0BjpWsLCUBevhTAyL3ZG+QFur7d8HIWX6Yl7PECKnUaJzZcqEd5Ajg8CBU
	 K7HvNhnlbXjf7UZJtI4CaVPZcDS0xmFpBGVy30SX5YP41IDLBxKGeOOUpg0F0DYFEI
	 bOKY/MzExNwizaQjM7QQYUETz6XvNP5uEgTME7XokykGI2UWrI5jnRaupWxBct/vYK
	 MML/15VIOedxSUXFFbbdLapD66lSgkXCrdhZFGEOS7lgI1kTd/afdl1RA6XdAY1J6z
	 P36J6UIiGar0gzwO1eOYczLSgdXW5A7V4CkC3+Bi978ODdvCJjR4aBYRcmTGwv18z7
	 7pK1Huo2rX3iw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20240416-esai_arm_dts_warning-v2-0-879e59c0c3b8@nxp.com>
References: <20240416-esai_arm_dts_warning-v2-0-879e59c0c3b8@nxp.com>
Subject: Re: (subset) [PATCH v2 0/4] arm: dts: nxp: imx6: fix esai related
 dtb_check warning
Message-Id: <171332196061.1698800.11762670932468430918.b4-ty@kernel.org>
Date: Wed, 17 Apr 2024 11:46:00 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Tue, 16 Apr 2024 10:47:46 -0400, Frank Li wrote:
> two patches update binding doc. two patches fix dts file.
> 
> dt_binding_check each patch.
> 
> git rebase -i aa8a0e0038936 --exec "make ARCH=arm CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,esai.yaml"
> Executing: make ARCH=arm CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,esai.yaml
>   LINT    Documentation/devicetree/bindings
>   DTEX    Documentation/devicetree/bindings/sound/fsl,esai.example.dts
>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>   DTC_CHK Documentation/devicetree/bindings/sound/fsl,esai.example.dtb
> Executing: make ARCH=arm CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,esai.yaml
>   DTEX    Documentation/devicetree/bindings/sound/fsl,esai.example.dts
>   LINT    Documentation/devicetree/bindings
>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>   DTC_CHK Documentation/devicetree/bindings/sound/fsl,esai.example.dtb
> Executing: make ARCH=arm CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,esai.yaml
> Executing: make ARCH=arm CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,esai.yaml
> Successfully rebased and updated refs/heads/b4/esai_arm_dts_warning.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: dt-bindings: fsl-esai: Remove 'fsl,*' from required list
      commit: 5894ff6c4707af645f2faa36cf07cc2745e1658f
[2/4] ASoC: dt-bindings: fsl-esai: Add ref: dai-common.yaml
      commit: 9aea6d64bb3acbff6b2f33cb5bbff65e824ab9a7

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


