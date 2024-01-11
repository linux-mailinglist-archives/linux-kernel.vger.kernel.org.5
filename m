Return-Path: <linux-kernel+bounces-24088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AF882B6A4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 22:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FF31281ABB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E41E5813D;
	Thu, 11 Jan 2024 21:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+hyhlEY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB71D5812A;
	Thu, 11 Jan 2024 21:28:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F2AC433C7;
	Thu, 11 Jan 2024 21:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705008501;
	bh=xfT2lbYAwKsfWKscclTNCiUip1woT0/W69P1c37dqBw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=o+hyhlEYYzWi7d2r740CFFGz6drWNPDfrqjOKc6JjyWWsoeruXenxmY/e2Y+UopKY
	 qv0bY6rvU0Ft2ELBEF9q2bBnnuMhH52+Ucvipv+w8MPUJPZ8oYBFXvTxKgN8lMYDjT
	 o4ESKQGR8WsdTtMXnE2RLRiJTjxpo4PWe09DiLDDkPA8rnWofDFkmLfvq3Se/ycdfU
	 MKzX2zRIqC93UtSzxFuZ4TOSbYlMCVTTe/kwWNzEZVCsGRzPVeRaYmXl4OqCR3X30T
	 CR+lyKZeZ5OsOpu7roGAVqhL6dfluZCtJGL9NM2qqq+9K9XOwVWxP5/Xyzu+P5fnNJ
	 HhLZqtxMLEOdg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: perex@perex.cz, tiwai@suse.com, matthias.bgg@gmail.com, 
 trevor.wu@mediatek.com, kuninori.morimoto.gx@renesas.com, 
 chunxu.li@mediatek.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
In-Reply-To: <20240111105226.117603-1-angelogioacchino.delregno@collabora.com>
References: <20240111105226.117603-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] ASoC: mediatek: sof-common: Add NULL check for
 normal_link string
Message-Id: <170500849826.453613.12911028566745797174.b4-ty@kernel.org>
Date: Thu, 11 Jan 2024 21:28:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Thu, 11 Jan 2024 11:52:26 +0100, AngeloGioacchino Del Regno wrote:
> It's not granted that all entries of struct sof_conn_stream declare
> a `normal_link` (a non-SOF, direct link) string, and this is the case
> for SoCs that support only SOF paths (hence do not support both direct
> and SOF usecases).
> 
> For example, in the case of MT8188 there is no normal_link string in
> any of the sof_conn_stream entries and there will be more drivers
> doing that in the future.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: sof-common: Add NULL check for normal_link string
      commit: e3b3ec967a7d93b9010a5af9a2394c8b5c8f31ed

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


