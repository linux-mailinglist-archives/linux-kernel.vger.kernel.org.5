Return-Path: <linux-kernel+bounces-5768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBE6818F3E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D08A31C24AD2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62C7381A5;
	Tue, 19 Dec 2023 18:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLAF0I+3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BA337D2D;
	Tue, 19 Dec 2023 18:06:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32572C433C9;
	Tue, 19 Dec 2023 18:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703009203;
	bh=2hRsDtJWTlv3D2t7ayBN7VifqP3cCgmJPM68zidIgsc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WLAF0I+3homyRrth3xOkWlm1xgWrIyJJGNubn+ftfKtjU7VYr+jUxba/32LqsQKHI
	 xWXsfY1BNu5M2jylG59rO4NdTkYFjMRb6160PHnljlLIOI3xmjBFqsEUqqS9OU1BaC
	 ysE05CsTqI4n1sURw0TsJVpXtcKinJbrRwbDldbvWop7TZ43AyrdnGMFCE5jPmxGtw
	 6ZO3Tb4n7xuBKyQoWP/m1r9CGjqLRYZUdgEq0phA3OPTWbb9e5kSofVjdNGZegqWnd
	 KrWKBQKtPVnJluwd43gXBuRCKMwnAG6t/3wXiBPNlIcxubR89vbXmSNALBv4gED3Cw
	 obgXwvvev9E+Q==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>, 
 Marian Postevca <posteuca@mutex.one>, 
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>, 
 Syed Saba Kareem <Syed.SabaKareem@amd.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 Rander Wang <rander.wang@intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>, 
 Bard Liao <bard.liao@intel.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com
In-Reply-To: <20231209203229.878730-1-cristian.ciocaltea@collabora.com>
References: <20231209203229.878730-1-cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH 0/5] Improve AMD ACP Vangogh audio support for Steam
 Deck OLED
Message-Id: <170300919992.125466.14486520202506235011.b4-ty@kernel.org>
Date: Tue, 19 Dec 2023 18:06:39 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Sat, 09 Dec 2023 22:32:18 +0200, Cristian Ciocaltea wrote:
> This patch series provides several fixes and improvements to AMD ACP drivers
> targeting the Vangogh platform, as found on the Valve's new Steam Deck OLED.
> 
> Although in theory the board should have been supported by both SOF and legacy
> ACP drivers, as of next-20231208 the audio seems to be completely broken.
> 
> Please note this only restores the legacy support, while SOF will be handled in
> a separate series.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: amd: vangogh: Drop conflicting ACPI-based probing
      commit: ddd1ee12a8fb6e4d6f86eddeba64c135eee56623
[2/5] ASoC: amd: vangogh: Allow probing ACP PCI when SOF is disabled
      commit: 2cef11ec3dfd5f14d8ddef917682408ed01e5805
[3/5] ASoC: amd: vangogh: Switch to {RUNTIME,SYSTEM_SLEEP}_PM_OPS
      commit: 78d3924675d4e076faa5600b48b8565fcb135ee0
[4/5] ASoC: amd: acp-config: Add missing MODULE_DESCRIPTION
      commit: 6e202e758b4b8d85dfb909c8eb710db8c6160303
[5/5] ASoC: amd: acp: Add missing MODULE_DESCRIPTION in mach-common
      commit: 576f3aef47f42f368db08fd5e3f49880c4493bf5

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


