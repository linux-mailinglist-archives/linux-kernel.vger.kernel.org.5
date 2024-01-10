Return-Path: <linux-kernel+bounces-22471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 533AC829E2B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E632C1F21D88
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294364C614;
	Wed, 10 Jan 2024 16:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJqRFiB3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E2A4CB33;
	Wed, 10 Jan 2024 16:03:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43118C43394;
	Wed, 10 Jan 2024 16:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704902597;
	bh=wxt5E37GpoAUW7+xtOpR1biWeJ1ynUtUPy5bRry8n0w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LJqRFiB3mlGh1+j4qu4hv8AFXbWTnTmwx0EMXFoxarsuALChaldVkrHnYsktMMU0Z
	 NvFc3cQqKSdWAJwq8HiD9mfs7a2tmKWhn4Ctq7N1EnchsRqqaKMli0TseJTrAW9mlg
	 NCq8XcjgB/OL1xZbkUYlWwsehSFqHZ16h1p2fJfVoglMzhivx+a6U9W3qkHScqjr76
	 OpPeRciHO91c+MNGLb9pkAPiB3BrrmhYIzageHXugtfmzIllp+B5mquPrZ7iIysXKC
	 cscmenbgfx3EvY+oSMu13QDQYFd9limyajnBuhS31kaxsWdpf79JbaqSzcWAHEyzVK
	 2accJDBoZ7Asg==
From: Mark Brown <broonie@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 matthias.bgg@gmail.com, u.kleine-koenig@pengutronix.de, 
 kuninori.morimoto.gx@renesas.com, trevor.wu@mediatek.com, 
 jernej.skrabec@gmail.com, claudiu.beznea@tuxon.dev, robh@kernel.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20240110105757.539089-1-angelogioacchino.delregno@collabora.com>
References: <20240110105757.539089-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8195: Remove afe-dai component and
 rework codec link
Message-Id: <170490259398.18995.11219791852170871212.b4-ty@kernel.org>
Date: Wed, 10 Jan 2024 16:03:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Wed, 10 Jan 2024 11:57:57 +0100, AngeloGioacchino Del Regno wrote:
> Remove the extra 'mt8195-afe-pcm-dai' component, register the DAI
> drivers to the main AFE component, and rework the DAI linking between
> the headset codec (RT5682/RT5682S) and the TDM interface in the probe
> function to stop assigning name, relying on the of_node of the codec.
> Also replace the COMP_DUMMY codec entry with a COMP_EMPTY for the
> ETDM2_IN and remove it entirely from ETDM1_OUT to fix the registration
> flow for this sound card.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8195: Remove afe-dai component and rework codec link
      commit: e70b8dd26711704b1ff1f1b4eb3d048ba69e29da

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


