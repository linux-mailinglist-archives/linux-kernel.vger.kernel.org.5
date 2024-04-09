Return-Path: <linux-kernel+bounces-137486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6E389E2C9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B48CE1C22C46
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E663156F46;
	Tue,  9 Apr 2024 18:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ri9oDrsK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A7150275;
	Tue,  9 Apr 2024 18:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712689042; cv=none; b=hvVIpow3LJs/nfnJcuR2fKMkmhS7kFgo8FyePyV/m1lZUhtUjWdmRYBRmcCZdoXR+rW4JIumcNvxwsE9jQ0Q4Yf5Tpig0FEgf7D4BO8eDEEK11y16wyFWfyErGYutcSrnoI91lTNbIcdP3IU+OGROAodlUIp19tc96wl3xY/PfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712689042; c=relaxed/simple;
	bh=XEPl6rvMdUEJUxQcF63UGqxzYLQBf+b+068mHOKHyKo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eMwUvGZJZ5ZyTpoGxYb7+GsXCm5D/MSfc1JgX7Tk1Kkomav2pox3NfA22WuKrXDqGn/rHGBZ9bA5WBPH/gkfHxoZqLXwKalzLHkVHgjXtYEsTFWldMPFqm7fBOOe1T+9aPDhVqd1QHNucMmON7DCIxDgBp0GBIEQviDwRTToXDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ri9oDrsK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A60C433C7;
	Tue,  9 Apr 2024 18:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712689041;
	bh=XEPl6rvMdUEJUxQcF63UGqxzYLQBf+b+068mHOKHyKo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Ri9oDrsKK06MjsP2/S9PlJBEbNIckYh92Uv1G/Gmnkhr3bfO0N2QdqI05KYfFZZsZ
	 E9wZSeOYWK24MzrQ5A92d6m+K9gYEWujsLt90AyZ5IZeE5MD3zwQo0bzcYXOUy3oKd
	 iJ9Sdu+8T98pdzlgxnaPEGsmYHnui4FEvTQiPBCjI3UYPE0ZEgIJpJtMp/b2GWNbdZ
	 AZDWH3qQJNa3C7rRonVq+jx2AfYjh78P9ntBBXdg+Wy49Y+lN8Pi3geg/jP2jYSzzl
	 3rnbJLIA1L2Ke4csy+Fw1n9bE/vQ61P8no25P1/LX3akwobrJmfzPekpoBisHzwNHE
	 iVOhXGEHPvpGA==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, Sunil-kumar.Dommati@amd.com, 
 Basavaraj.Hiregoudar@amd.com, venkataprasad.potturu@amd.com, 
 kernel test robot <lkp@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Arnd Bergmann <arnd@arndb.de>, Lucas Tanure <lucas.tanure@collabora.com>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Syed Saba Kareem <Syed.SabaKareem@amd.com>, 
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, 
 open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20240408180229.3287220-1-Vijendar.Mukunda@amd.com>
References: <20240408180229.3287220-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH] ASoC: amd: fix for soundwire build dependencies for
 legacy stack
Message-Id: <171268903831.71903.8798252407593021756.b4-ty@kernel.org>
Date: Tue, 09 Apr 2024 19:57:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Mon, 08 Apr 2024 23:32:26 +0530, Vijendar Mukunda wrote:
> The SND_SOC_AMD_SOUNDWIRE Kconfig symbol has build dependency on
> SOUNDWIRE_AMD. It gets it wrong for a configuration involving
> SND_SOC_AMD_SOUNDWIRE_LINK_BASELINE=y,SND_SOC_AMD_PS=y and SOUNDWIRE_AMD=m,
> which results in a link failure:
> 
> ld: vmlinux.o: in function `amd_sdw_probe':
> >> sound/soc/amd/ps/pci-ps.c:271:(.text+0x1d51eff):
> 	undefined reference to `sdw_amd_probe'
> ld: vmlinux.o: in function `acp63_sdw_machine_select':
> >> sound/soc/amd/ps/pci-ps.c:294:(.text+0x1d525d5):
> 	undefined reference to `sdw_amd_get_slave_info'
> ld: vmlinux.o: in function `amd_sdw_exit':
> >> sound/soc/amd/ps/pci-ps.c:280:(.text+0x1d538ce):
> 	undefined reference to `sdw_amd_exit'
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: fix for soundwire build dependencies for legacy stack
      commit: 56437a561fefab2be708dfebf80e31c4715eb52e

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


