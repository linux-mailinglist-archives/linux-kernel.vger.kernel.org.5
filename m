Return-Path: <linux-kernel+bounces-146639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 218838A68A3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B63F91F21D7D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EECF128363;
	Tue, 16 Apr 2024 10:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVPLla6S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4F7127E23;
	Tue, 16 Apr 2024 10:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713263944; cv=none; b=Q7aEJNBj5udm1PwFnyquyr6oDXBESNDVQ2p6H/8pXz0L0mSnAooWtkyhSSJp4HW1CXQM6PNn6eqcn3GHQYQxcGD4U4VK9LFe/UDeR605EaLN97Ei0jHhpOBznrBCjAoU/gtMc9HSPFkCHx+JeJ5yrd6qpgC4e35PjcK+6oqC6Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713263944; c=relaxed/simple;
	bh=hNctvS/WLFpY8f2jueQ+vJMsiRhGdgQTThlnjXrGA70=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uGYXFWqPJH9ixeciiRTTo77FiV004R40RTqdMomsAOkqqpUdcQu/zmcDJRE8V+shaPanl91dtY5UmrMrFy5kr9U8g1JS3fTxGClkEXoImUvGhz+lyFo+CvyN7ZO7SM4OxIf4tvJ9tnc4dXFr3uTUyIbMGmTFPpy5zixWpi4t9Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVPLla6S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09477C2BD10;
	Tue, 16 Apr 2024 10:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713263944;
	bh=hNctvS/WLFpY8f2jueQ+vJMsiRhGdgQTThlnjXrGA70=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=ZVPLla6S9+Tm1Fb+FVhWPDVKcuu+6k0rW8chZ8aT2kCKbVqG5LrvJTt9RKRoTRWhe
	 v6i9WRn8wbd2K+AwPMonuYOfSG/rReMCZD0Z++Yx3f34NkGPAqRyiFZvZ4tOq6XKpF
	 h9x+cEYVU9e9C0UWqfnE+CFL3rYOLabGy5JMr3Q2Wjg/4zfK6IIxFXprG3VUuxAaGC
	 SDnxyILS5AHGbqwUC7iC8948jrTjpaIXw1Mv5m2pADi6d7+aysqrdufqU0LP+m81RA
	 rmZm7QR+lO1q3BXqo6/hr++Mnt8qpZJSoW/noANqQAz+QRVtdl3ZBp8aig/sEtAopa
	 IlrBn1zWSHrXQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 shengjiu.wang@gmail.com, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com, 
 perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, 
 linuxppc-dev@lists.ozlabs.org, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <1713165456-3494-1-git-send-email-shengjiu.wang@nxp.com>
References: <1713165456-3494-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH 0/2] ASoC: fsl-asoc-card: add wm8904 codec support
Message-Id: <171326394076.1668526.17357841814427298563.b4-ty@kernel.org>
Date: Tue, 16 Apr 2024 19:39:00 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Mon, 15 Apr 2024 15:17:34 +0800, Shengjiu Wang wrote:
> add wm8904 codec support in fsl-asoc-card.
> 
> Shengjiu Wang (2):
>   ASoC: fsl-asoc-card: add wm8904 codec support
>   ASoC: dt-bindings: fsl-asoc-card: Add compatbile string for wm8904
>     codec
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: fsl-asoc-card: add wm8904 codec support
      commit: 51f67862ea6ea83f9fa4cda2e59d7bfd4387f63b
[2/2] ASoC: dt-bindings: fsl-asoc-card: Add compatbile string for wm8904 codec
      commit: 62c48dd33b4f2e037554d1322ae4f9f60e9461ef

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


