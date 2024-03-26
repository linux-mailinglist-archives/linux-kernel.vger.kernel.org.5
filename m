Return-Path: <linux-kernel+bounces-119306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3346D88C6D8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B68CB26F69
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC0B13C8F5;
	Tue, 26 Mar 2024 15:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkSh8Kky"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C667C13C8E3;
	Tue, 26 Mar 2024 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466856; cv=none; b=j2VjaoWwCY2s8fhVnfwGP84MNWgSVAxePVUiTlmNs9UfIisuaurrphFJOMjm3r2O7nmRXpUVWf2VQ/+BuhwlkGKgYY0ugCyyg2cN1fUMz2ofwpxJgb4fF8NxarQzal+g6lVortoIMUuwsodOsfkzZoJBnFGQpEe03RheJbiYjBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466856; c=relaxed/simple;
	bh=grkKelQsX82GN+mhakvoaLl2QHI3vzpYxQLvknB0Fys=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XYiGxSUeMNJjoS/twN92eV8qoQXosGbtF7N0+eC/m4UrTZOI/hlMfUeece9IH6ML9n7qHfeUft+jKH/w/5cuBkShUBnNZpGgqh0DDmH0TqC8jKKS/TjJhf87U8MbkOJFpKvy0RNTl/QdZL3+J8asKvZMTGontTLgEzU1iyvpFZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkSh8Kky; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53104C43390;
	Tue, 26 Mar 2024 15:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711466855;
	bh=grkKelQsX82GN+mhakvoaLl2QHI3vzpYxQLvknB0Fys=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bkSh8KkyQWCpYTjYjiV5w7aPLtY6PlZzfO8tu7CEQMCojpC+6L/fSddCc/szf6zWy
	 7utiKBAxT3cXcuRO6bPzWe11nNiYduIA97VJERqbXwxhD3gbxluTEaGW/ZG5q6t8pJ
	 UzRhYTsIIEmdZK0Uai96XjdNN60WXMXyH9vR/kbu6A5DfHr0LU4WxmfcapsbMP3RB1
	 6oEJJxWl1ITNy/kW7SoBpJCZFTLX9eSMj9iHDr3/4aKft7Tyk824MtX/IjYck0PHsO
	 hkjNwfflzpyiRRHAkrYid4RBQ3+rldNeqjvvd7bbq/m7rz8Z0Vgpekpi1ZeWfT+sSs
	 EM1M4N6s3BtmA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: perex@perex.cz, tiwai@suse.com, matthias.bgg@gmail.com, 
 ribalda@chromium.org, nicolas.ferre@microchip.com, 
 u.kleine-koenig@pengutronix.de, kuninori.morimoto.gx@renesas.com, 
 nfraprado@collabora.com, alsa-devel@alsa-project.org, 
 trevor.wu@mediatek.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
In-Reply-To: <20240111105247.117766-1-angelogioacchino.delregno@collabora.com>
References: <20240111105247.117766-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 0/7] ASoC: mediatek: AFE drivers cleanups
Message-Id: <171146685206.132239.17987201870136073859.b4-ty@kernel.org>
Date: Tue, 26 Mar 2024 15:27:32 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Thu, 11 Jan 2024 11:52:40 +0100, AngeloGioacchino Del Regno wrote:
> This series converts MediaTek AFE drivers' probe functions to use
> dev_err_probe() and devm functions where possible and, in some
> cases, dropping the .remove_new() callback, reducing the size.
> 
> Cheers!
> 
> AngeloGioacchino Del Regno (7):
>   ASoC: mediatek: mt8173-afe-pcm: Convert to devm_pm_runtime_enable()
>   ASoC: mediatek: mt8173-afe-pcm: Use devm_snd_soc_register_component()
>   ASoC: mediatek: mt8183-afe-pcm: Convert to devm_pm_runtime_enable()
>   ASoC: mediatek: mt8183-afe-pcm: Simplify with dev_err_probe()
>   ASoC: mediatek: mt8192-afe-pcm: Convert to devm_pm_runtime_enable()
>   ASoC: mediatek: mt8192-afe-pcm: Simplify with dev_err_probe()
>   ASoC: mediatek: mt8195-afe-pcm: Drop .remove_new() callback
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/7] ASoC: mediatek: mt8173-afe-pcm: Convert to devm_pm_runtime_enable()
      (no commit info)
[2/7] ASoC: mediatek: mt8173-afe-pcm: Use devm_snd_soc_register_component()
      (no commit info)
[3/7] ASoC: mediatek: mt8183-afe-pcm: Convert to devm_pm_runtime_enable()
      (no commit info)
[4/7] ASoC: mediatek: mt8183-afe-pcm: Simplify with dev_err_probe()
      (no commit info)
[5/7] ASoC: mediatek: mt8192-afe-pcm: Convert to devm_pm_runtime_enable()
      commit: 7aaaa22de56ce0dae15fd9f42a69a1d1a7a6e078
[6/7] ASoC: mediatek: mt8192-afe-pcm: Simplify with dev_err_probe()
      commit: 324c603a4efca7d1045e0bf3477ca54970eac72c
[7/7] ASoC: mediatek: mt8195-afe-pcm: Drop .remove_new() callback
      (no commit info)

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


