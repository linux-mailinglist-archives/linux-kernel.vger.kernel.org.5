Return-Path: <linux-kernel+bounces-4164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 719258178AE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26E4C1F24460
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B2C5D758;
	Mon, 18 Dec 2023 17:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oz6bp6e6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86855D733;
	Mon, 18 Dec 2023 17:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57042C433C9;
	Mon, 18 Dec 2023 17:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702920498;
	bh=BwWLjWBOPW4u2jx0dHRvkSUVQlMbXSzwnRbz6jImvxU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oz6bp6e6cpAfbiAQRa/VnRD/neVdCXOBwk/XYA3lqfFpgOsIQKJUwf2fn9L+jy9a7
	 wgCFqah8ZPjTAJqJA5gYpECYTYcw43eJM8CgyuLDO3jiA2v0mO0OiFRoeqi4xGuWL6
	 DbW0GuX1eD80F00M1QIsK2TXl+GyvFT7pa8LgxJS1r3DHOIJZRWiSuX/dDaizP+LcN
	 RCJTQ5P9GEZgYd7/TPcLyYKDlFXwn9JN4ztad67Hnrh1sdFps+8HT8cinVy2u6gryr
	 wl7ozIgL+e78/HV3krvtX04195kM8u0EQfXHpb9rE54xJ4lXyDifgXc3wAXTO6u/8H
	 Ga4oa2vKa3vSQ==
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Gergo Koteles <soyer@irl.hu>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, 
 stable@vger.kernel.org
In-Reply-To: <98d4ee4e01e834af72a1a0bea6736facf43582e0.1702513517.git.soyer@irl.hu>
References: <98d4ee4e01e834af72a1a0bea6736facf43582e0.1702513517.git.soyer@irl.hu>
Subject: Re: [PATCH] ASoC: tas2781: add support for FW version 0x0503
Message-Id: <170292049608.89121.12171534337983645112.b4-ty@kernel.org>
Date: Mon, 18 Dec 2023 17:28:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Thu, 14 Dec 2023 01:25:39 +0100, Gergo Koteles wrote:
> Layout of FW version 0x0503 is compatible with 0x0502.
> Already supported by TI's tas2781-linux-driver tree.
> https://git.ti.com/cgit/tas2781-linux-drivers/tas2781-linux-driver/
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tas2781: add support for FW version 0x0503
      commit: ee00330a5b78e2acf4b3aac32913da43e2c12a26

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


