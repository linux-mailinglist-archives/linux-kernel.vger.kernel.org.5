Return-Path: <linux-kernel+bounces-130654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8B6897AFD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF3FE1C217B2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B42F156881;
	Wed,  3 Apr 2024 21:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRTWD4Uf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F0D155A46;
	Wed,  3 Apr 2024 21:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712180802; cv=none; b=qCmfyRXHKuiC2rZePXQl4oR11m/4R/tFnUSPRGFlBBroyKNJjmAD+9duJd18WhJGr1diC2nDVON/1hOtdSb2NyDGXidofdza9N8Z0dyOiFMp8SLC2Ipv7nMWmGh51+MlOBE1YkltLRbNKoMq3WZJ4vsymK174JFFIzdJz+F2aZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712180802; c=relaxed/simple;
	bh=4tC+5taKZf/smeBIPknU43y/DOI7Vg2B1xYLbmWArxI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Z2aC+dVPPti2LDv3GvS4eHb0rsZbBAhx4nROsYrAGxF1pfvgmqnYAr/e7BGFaXx6PyrGY9z5Sn7P4Ynw2M5OXwYOs1KWMMI2D+Wuoo/zLzq7mPglxtuQXYTpt8Ps/e6ibyRBMnRJ4xJSeOQzR3NFp9sn5uoPN/dYi2Mg/solwDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRTWD4Uf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF13C433F1;
	Wed,  3 Apr 2024 21:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712180802;
	bh=4tC+5taKZf/smeBIPknU43y/DOI7Vg2B1xYLbmWArxI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TRTWD4UfNrRFS2eoq961aY8QAM4Vsr0qPJd42elma3lahlcU/ajLK93gh5G42axuh
	 ipWvk/ull1efWA4/VunPDcByP5OrX1uMBipJ0QVZJUla+CIVbHiSUH7O3WHltCXT3b
	 zaPK06Ir0zRz6dLfT3eNYtHMG3gt6ZSOqYLiMuPmwm94IjtG/sSeFJ9b78LinFTUWH
	 6Slqh/n8YZIAvmN9+kV09SWHSSApe3P66D2qpjfWZAvwJIdxNNQb+NX4aJTIy0l0XP
	 lb+x9eyWRWVxxZWR4qrlm8Hez/jM+ys3dk5Y0oWbtl1ynG84DgF6Ym/CwNTEVPCghS
	 f2fiZfwBSKPXA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Heiko Stuebner <heiko@sntech.de>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>
In-Reply-To: <20240403-rk3308-audio-codec-fix-warning-v2-0-816bae4c1dc5@bootlin.com>
References: <20240403-rk3308-audio-codec-fix-warning-v2-0-816bae4c1dc5@bootlin.com>
Subject: Re: [PATCH v2 0/2] ASoC: codecs: rk3308: fix build warning without
 OF
Message-Id: <171218080011.1232330.13275012484135476972.b4-ty@kernel.org>
Date: Wed, 03 Apr 2024 22:46:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Wed, 03 Apr 2024 13:03:17 +0200, Luca Ceresoli wrote:
> This small series fixes a build warning reported by kernel test robot
> <lkp@intel.com> and improves the Kconfig entry.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: codecs: rk3308: fix "defined but not used" warning on !OF
      commit: 38d5387b7660476fd7e8e07d16ee436819e3544d
[2/2] ASoC: codecs: rk3308: depend on ARM64 || COMPILE_TEST
      commit: 03246ade4646653bbc98fa6fa506891a51983259

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


