Return-Path: <linux-kernel+bounces-104952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B266387D66F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 23:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4603EB21D5B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 22:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB4754F89;
	Fri, 15 Mar 2024 22:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYWuKH5x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599E514276;
	Fri, 15 Mar 2024 22:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710540261; cv=none; b=lxVvqgwc8AxRmEjgjSqSOsGwH9BXXIc0qc/Xvu9Z2Kw5MxQeHninCTR+sZuSXRRqyPQhxeAU3WVkdlQrx9UzFsGSjHTrmhLhsTq/hBTXz7WcOBwA/gKpuz503+iA0ytcUrGgXmO0Xn6iv1MCxPJfWi0TCkjnmwZ58WL2c48TBFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710540261; c=relaxed/simple;
	bh=55d02eBOn9dVSEV1nC826S33Ja0fZxXUxGbxrPros3I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Im45LTbxdl1oyDx2/VYQfltOSL+y0+q42QN08yAA7w3iITpFxAvdJ/KEm4S7nDRCyh7QaiR4eq4ooDPHm8CTHdvpWG760bLx8Dh5pDN0bGbjKEoOpfWLFm46MMLR7HbwMvrmWBX9h11/hPm7cUzIdKWesBLRMkp2cSpJT1AtOCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYWuKH5x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA30C433F1;
	Fri, 15 Mar 2024 22:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710540261;
	bh=55d02eBOn9dVSEV1nC826S33Ja0fZxXUxGbxrPros3I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LYWuKH5xER2A8wOAtUti7njqo6GjmQex7kvAwajEhq4zOFxYxdzUv4xIw63uvHD7w
	 506nvqYkXMHf40y8Un/Axl5yS/ttxk762XCPVSeRAllJ4UDjVZdAbhydmBckkkpLfC
	 frsoiRHSX+F+DcJ0L9uy/VBIZtopULdN2fZNtvpSsFVhT8E3kTl1HGpToKqvTMFMo1
	 XLenWIwEsrfUmGSaQwBoUOmd3eHWgVshZzATwzHVsdfG/MmXVfUFFnPDNgTxE9WEbh
	 Q/My+xf4621XX4wgKL6J5V1lwuwuSEzWqk6ih/6FXm5jnVqQZ0AzbuWmouCy+k1AUY
	 Mh/B1pKLNAOIQ==
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com
In-Reply-To: <20240220201623.438944-1-cristian.ciocaltea@collabora.com>
References: <20240220201623.438944-1-cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v3 0/2] ASoC: SOF: amd: Skip IRAM/DRAM size
 modification for Steam Deck OLED
Message-Id: <171054025817.128762.3711303869431739426.b4-ty@kernel.org>
Date: Fri, 15 Mar 2024 22:04:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Tue, 20 Feb 2024 22:16:02 +0200, Cristian Ciocaltea wrote:
> This patch series restores audio support on Valve's Steam Deck OLED model, which
> broke after the recent introduction of ACP/PSP communication for IRAM/DRAM fence
> register programming.
> 
> Changes in v3:
> - Drop a patch file that was sent by mistake in v2
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: SOF: amd: Move signed_fw_image to struct acp_quirk_entry
      commit: 33c3d813330718c403a60d220f03fbece0f4fb5c
[2/2] ASoC: SOF: amd: Skip IRAM/DRAM size modification for Steam Deck OLED
      commit: 094d11768f740f11483dad4efcd9bbcffa4ce146

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


