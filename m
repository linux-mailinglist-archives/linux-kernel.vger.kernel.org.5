Return-Path: <linux-kernel+bounces-61035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2468850C80
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 01:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 907A91F21DA3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 00:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE5610F9;
	Mon, 12 Feb 2024 00:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BP31ZqYu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A2C10E3;
	Mon, 12 Feb 2024 00:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707699454; cv=none; b=k9181TCJayc2iMRGHV2ykFp0IsnoIuAsS7FoAo3ZSKuEJ8xZTMk0m8BCOLADwaWV4uS6ty+ctnFUyK+I3fXgtx7Nh5YqHkOW5YldyZez1EP2zTxrpWv4uLXkPlUjgjUu28B6gXKBdWgUzGFtbVsCAskjxFEB7Ulg7mYlABMSj+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707699454; c=relaxed/simple;
	bh=UjSBFa2JSiRKfOnN+/YDukdaZ2mWb6/Pp9XHdBkmxZ0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OJFEu0oPS5SuON9HIZB6gn3u0kAHV4Mwb/Vz03WY7zDpJ+4eNhWgcPLR/HG+5XtbCUlz/ZKmip7vh4+lDnsC1zqQeNJIhJwe2Iz1xz7ZwDrd1HSH9vwx+WiZJJNWITB2rgc33FwmJweITQoaEMPLPYsa3HxGovHMlJUCiGd5AiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BP31ZqYu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55600C433C7;
	Mon, 12 Feb 2024 00:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707699454;
	bh=UjSBFa2JSiRKfOnN+/YDukdaZ2mWb6/Pp9XHdBkmxZ0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BP31ZqYulSD7X8sIRfQQ0+WLVCQcArYu2SiYdJqRdFNICs64L4QMUSa3xDwA6O36e
	 9lOlYWE7cdUwL774XkXcIMNJybyeKIMSJXWWBf1mtmHNjJZccVo8bb4aB1lqpiL5cO
	 3wujtMXB8KzXh+iSgdPraXeART5urvBJjvmNkd6FfWdRQ6JAVVsoVrnX5bmmZpCG8m
	 J1yOKq70peskan+BzlLIJ7S8iPFS9Vb5wiJNhAyVCFT1hifkQbZtgy+fGnP/f6Ge7D
	 11QtcxWWBr2i9pcb3QTgazuigJTjM8CVQEUfSqbZNhyapnAKjJw8b2KatSEIDlv1FW
	 lna+eRC1/EUfQ==
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
In-Reply-To: <20240208234315.2182048-1-cristian.ciocaltea@collabora.com>
References: <20240208234315.2182048-1-cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH] ASoC: SOF: amd: Fix locking in ACP IRQ handler
Message-Id: <170769944944.2475236.12312495340853191634.b4-ty@kernel.org>
Date: Mon, 12 Feb 2024 00:57:29 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Fri, 09 Feb 2024 01:43:14 +0200, Cristian Ciocaltea wrote:
> A recent change in acp_irq_thread() was meant to address a potential race
> condition while trying to acquire the hardware semaphore responsible for
> the synchronization between firmware and host IPC interrupts.
> 
> This resulted in an improper use of the IPC spinlock, causing normal
> kernel memory allocations (which may sleep) inside atomic contexts:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: amd: Fix locking in ACP IRQ handler
      commit: c4b603c6e2df3a17831731d8bbec5c16fa7bbdf8

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


