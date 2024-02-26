Return-Path: <linux-kernel+bounces-81923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C238867C3E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B530C1F22AC7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D9312C53E;
	Mon, 26 Feb 2024 16:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3V2VU9Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABE81DFEA;
	Mon, 26 Feb 2024 16:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708965733; cv=none; b=ofGEpo4OXrREnDdAa6IEDauWIwf1nn+UUKsS39QS6hPLQ+9Qt86UnEyQkBA6x5BABE27GUHsbShYoVo6E3I0hcga5SmOsXIJ0EIoTggPqUyqCITA356twMu9EvGZeSpQBW8eeUzfhXwhLqgUFML696MtgLj2OQbaqwSpOrdThsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708965733; c=relaxed/simple;
	bh=yw07OWyD0LtGybRZCX/Yqm2aQwlLwnlMybFWhWjrytk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MzzMl4wkY0PM8p806ehhGofzXvm2ndA/gVE4h4QJVy/N2ZeixiFIxi7ovFVx6mkhCe1c8RBAS4S2KXyjeOVbYfiJpUk3DXMc4OCo/qxjS4/q8G0ahqlbdtMwnP5JLDij7QZ3tXtZr1Ik12kDyOc9el3R60Ng/EoZgyO1ZVywM4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3V2VU9Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41460C43390;
	Mon, 26 Feb 2024 16:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708965733;
	bh=yw07OWyD0LtGybRZCX/Yqm2aQwlLwnlMybFWhWjrytk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=n3V2VU9YIFkybyzgFGadV160pUuRkp2plaLGHlaYeyQHlXcWr70M0e09RRifFEbht
	 lweekPfQpw0KnMwogvAjS4Yd5+Yl9jggk84KE6IP+Q0MNPT1U08Q9GGHqR8mHMEVIj
	 X7J/pKmfgLTXb39+YeEYE0VUSrmZyJQ/GyY+2wCFS/ahlfV39oaKj6Z0j6u5LHisrn
	 JIT99tz4DEFL6st8vHeFZp+aoSCD0QGD9pOb2dSYPNR7f6sosIrwgN1h3Qalt7LR+j
	 yICKTiRPwrZr5PzzsiSRc6UvhNxfjylF1HpoHVEytgpk88nqXpJfO9wahx5J9/Nqe/
	 7cOdv1qoG5kog==
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.com, Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, 
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20240221150507.1039979-1-rf@opensource.cirrus.com>
References: <20240221150507.1039979-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH 0/9] ALSA: cs35l56: Apply calibration from EFI
Message-Id: <170896573086.55097.17093703884740704115.b4-ty@kernel.org>
Date: Mon, 26 Feb 2024 16:42:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Wed, 21 Feb 2024 15:04:58 +0000, Richard Fitzgerald wrote:
> Factory calibration of the speakers stores the calibration information
> into an EFI variable.
> 
> This set of patches adds support for applying speaker calibration
> data from that EFI variable.
> 
> Patch #1 and #2 are bugfixes that are prerequisites.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/9] ASoC: wm_adsp: Fix missing mutex_lock in wm_adsp_write_ctl()
      (no commit info)
[2/9] ALSA: hda: hda_cs_dsp_ctl: Only call notify when a control has been added to a card
      (no commit info)
[3/9] ASoC: wm_adsp: Add wm_adsp_start() and wm_adsp_stop()
      commit: 5519ac3a7164d5d1c31879bf5b0d279b58c8e88f
[4/9] ASoC: cs-amp-lib: Add helpers for factory calibration data
      commit: 1cad8725f2b98965ed3658bc917090b30adb14fa
[5/9] ASoC: cs35l56: Add helper functions for amp calibration
      commit: e1830f66f6c62d288d2c27a7ed18ab93caa0b253
[6/9] ASoC: cs35l56: Apply amp calibration from EFI data
      commit: 1326444e93c250ff99eba048f699313ba6acbf2f
[7/9] ALSA: hda: hda_cs_dsp_ctl: Add helper function to write calibration
      (no commit info)
[8/9] ALSA: hda: cs35l56: Apply amp calibration from EFI data
      commit: cfa43aaa7948be5a701ad4099588cf49d5a02708
[9/9] ASoC: cs-amp-lib: Add KUnit test for calibration helpers
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


