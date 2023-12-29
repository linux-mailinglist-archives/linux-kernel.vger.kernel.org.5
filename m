Return-Path: <linux-kernel+bounces-13196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECC382010A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 19:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 514FB1C216BB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 18:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E85C12B95;
	Fri, 29 Dec 2023 18:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mn9WDNmS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE4312B93;
	Fri, 29 Dec 2023 18:29:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6533C433C7;
	Fri, 29 Dec 2023 18:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703874578;
	bh=hqR27ax3GvRDzb81QemkDHU9Yrtch566u+O8ptjm5Pw=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=Mn9WDNmSIPAXoNI6au1+/Y1sFoGTDOBqu/yrKeLqr7iSYBkR9OzXsMcBx/wVxrnDk
	 0FvmY2QMj+1nvldulH+IFowzDoG3vLfLTZ7ZzKOMlA27JZDyQlrWAP1S7r0TiSHUax
	 zIpA5i0puq2ECWJNEOMFqFxpOSPipQuVbJ3huSAX2OOC4uPhvIY20HH6+n1tv/gEpm
	 smL6Vl5ly7plJIlD9O66zUoFej5WSrQlLw8Ej7zZZDj0MRcw74wl5yNaRngMbMFbpi
	 g9lSNi2B0mAv8NV0DgUPXJkK9BK+rwySpS94dBViKSRiZlv4cbwLjxohKHI0Pq/0sD
	 Ec9LZPzedCq3A==
From: Mark Brown <broonie@kernel.org>
To: pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com, 
 peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com, 
 ranjani.sridharan@linux.intel.com, daniel.baluta@nxp.com, 
 kai.vehmanen@linux.intel.com, perex@perex.cz, tiwai@suse.com, 
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
 festevam@gmail.com, linux-imx@nxp.com, sound-open-firmware@alsa-project.org, 
 linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com, 
 Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <1703669263-13832-1-git-send-email-shengjiu.wang@nxp.com>
References: <1703669263-13832-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: SOF: imx: Add SNDRV_PCM_INFO_BATCH flag
Message-Id: <170387457344.3008588.12379397390101428213.b4-ty@kernel.org>
Date: Fri, 29 Dec 2023 18:29:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Wed, 27 Dec 2023 17:27:43 +0800, Shengjiu Wang wrote:
> The sof imx pcm device is a device which should support
> double buffering.
> 
> Found this issue with pipewire. When there is no
> SNDRV_PCM_INFO_BATCH flag in driver, the pipewire will
> set headroom to be zero, and because sof pcm device
> don't support residue report, when the latency setting
> is small, the "delay" always larger than "target" in
> alsa-pcm.c, that reading next period data is not
> scheduled on time.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: imx: Add SNDRV_PCM_INFO_BATCH flag
      commit: b6190c452a2264ccd88c849b91990fe854a7ec72

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


