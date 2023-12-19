Return-Path: <linux-kernel+bounces-5769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 368F0818F41
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8B69282D75
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A43738F94;
	Tue, 19 Dec 2023 18:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9CH5/2N"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA9038F87;
	Tue, 19 Dec 2023 18:06:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43950C433C7;
	Tue, 19 Dec 2023 18:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703009207;
	bh=IWT2Spi6n0YyBL0I+YwiyQRgCtOdqTF4PJPYvAzCjzY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=R9CH5/2NspkbtdqFagwiq5zBc5sVYhM42iB3WpampU9sH7ckPux2kVwx236hn98e1
	 74Xx/Oem6yQi+an/Rx/rmNxigMcM73wA889coHTybKA7z28ovoJS6FiADhu5q+tLSc
	 olJ8QRrOOHuHYohzLBQEXx42+Dtmij7U2GlVEvJrcxu0Ew4vSdJG38lpIxxi/XrOu6
	 jLgtru4XMquwVV//KL8WNVxNWphIIUxKO1j1vW1P3Kkynx1Cxui9DNnTpMbistCujw
	 yw1C8n7D59VUplKbTbv+jbyxDxXamF2GNszgVcJzudVL1Vv5eIfNHV3SJW7Holopbw
	 fQ5s+Ftcd9L0w==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
 perex@perex.cz, tiwai@suse.com, trevor.wu@mediatek.com, 
 allen-kh.cheng@mediatek.com, kuninori.morimoto.gx@renesas.com, 
 Rui Zhou <zhourui@huaqin.corp-partner.google.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20231212123050.4080083-1-zhourui@huaqin.corp-partner.google.com>
References: <20231212123050.4080083-1-zhourui@huaqin.corp-partner.google.com>
Subject: Re: [v9 0/4] add es8326 dt-bindings, commonize headset codec API,
 es8326 support and Enable dual amp for rt5682s
Message-Id: <170300920399.125466.9978354781339951707.b4-ty@kernel.org>
Date: Tue, 19 Dec 2023 18:06:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Tue, 12 Dec 2023 20:30:46 +0800, Rui Zhou wrote:
> Add dt-bindings for es8326 and codec es8326 support.
> Remove duplicate code, commonize headset codec init/exit API.
> At the same time, Enable dual amp max98390 for rt5682s.
> 
> Changes in v9:
> - PATCH 3/4: Add comment for MAX98390_TWO_AMP.
> - Link to v8: https://lore.kernel.org/all/20231208070933.720324-1-zhourui@huaqin.corp-partner.google.com/
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: dt-bindings: mt8188-mt6359: add es8326 support
      commit: ea244b35a4da60a92d0e3be528f82ebcbcf10753
[2/4] ASoC: mediatek: mt8188-mt6359: commonize headset codec init/exit api
      commit: 1a268000b03a162bd5feb7fce1c130f1b31602b5
[3/4] ASoC: mediatek: mt8188-mt6359: add es8326 support
      commit: e794a894427b1d64f2ebff24f003c60373d68c2c
[4/4] ASoC: mediatek: mt8188-mt6359: Enable dual amp for mt8188-rt5682s
      commit: 3423c3db22e9213acd279ff3800bb1e91aa2ac89

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


