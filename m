Return-Path: <linux-kernel+bounces-79450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A01F8862264
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 03:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E27F1C21BA6
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB6510A3F;
	Sat, 24 Feb 2024 02:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O68hcKkd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A9EAD54;
	Sat, 24 Feb 2024 02:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708743445; cv=none; b=Srah/eK7s0CtO4Sb5Y0vGdQHuUx1jlIZMWDw2Kot8pTTZsRIoM+G1h12KG1FyNPLCqJBXM1dnfBhRgeArnzvu3FYb99jp4OIeWKs+Ldd7f1YGucKR8KK9f4S0MT0ODdbGESH6Jo31VmMIOD6i8cmrJxjJO0R1rtPz3VbLRlQWNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708743445; c=relaxed/simple;
	bh=jEHirSoRsFxzzzcf1js6eRmSK2fDWo49/HdLgHj49Tw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LXY1p5PHIhsztR6VBu/A+rbItVIj5N/w4h9YuUpninEkNnjlSIpzyiopHvuji9Kc+prKW191utx0APGhqKKY8QIXP50DzkPPrZrdEKzW0f9PEpxTNawMSvvrUd5TJQt9Eg8tkJtZdNhLMzZ1ImCDBVbvoto1ZH6PcMs9phrzFgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O68hcKkd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12420C433F1;
	Sat, 24 Feb 2024 02:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708743444;
	bh=jEHirSoRsFxzzzcf1js6eRmSK2fDWo49/HdLgHj49Tw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=O68hcKkdWjRSKTSvsTpgAvZp/MRTn9n5lDL3wnut27hif4oe+QaI66N3qgtrYOVZ6
	 S7kh9NV/W7DT7KWldB9hECnQhpjrINkb9xzczIUbsW8pcOy/YlbR8CzC/QAWerQham
	 9nunOeoi+I3lYH65iTzQoiJQUPeD5MSg74PwjlOy+tLU6LyD9kJ46CcVHt/ndigURp
	 EN7gIcYkf5Zs4pjiqllogkRw4aOtGa470yIDu+Bn4mmrs2SfBO3YxM4roeMYf7ZA1T
	 EbVTkHRGQmqhYfEBBBaUMI8vKzylpepDv2EGuQ3Jkvsmy7I3nuQFmhMMfFDJZWDBJb
	 evWSiIzdqUe3A==
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.com, Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, 
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20240223153910.2063698-1-rf@opensource.cirrus.com>
References: <20240223153910.2063698-1-rf@opensource.cirrus.com>
Subject: Re: (subset) [PATCH v2 0/6] ALSA: cs35l56: Apply calibration from
 EFI
Message-Id: <170874344273.260432.989060891858906599.b4-ty@kernel.org>
Date: Sat, 24 Feb 2024 02:57:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Fri, 23 Feb 2024 15:39:04 +0000, Richard Fitzgerald wrote:
> Factory calibration of the speakers stores the calibration information
> into an EFI variable.
> 
> This set of patches adds support for applying speaker calibration
> data from that EFI variable.
> 
> The HDA patch (#5) depends on the ASoC patches #2 and #3
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] ASoC: wm_adsp: Add wm_adsp_start() and wm_adsp_stop()
      commit: 5519ac3a7164d5d1c31879bf5b0d279b58c8e88f
[2/6] ASoC: cs-amp-lib: Add helpers for factory calibration data
      commit: 1cad8725f2b98965ed3658bc917090b30adb14fa
[3/6] ASoC: cs35l56: Add helper functions for amp calibration
      commit: e1830f66f6c62d288d2c27a7ed18ab93caa0b253
[4/6] ASoC: cs35l56: Apply amp calibration from EFI data
      commit: 1326444e93c250ff99eba048f699313ba6acbf2f
[5/6] ALSA: hda: cs35l56: Apply amp calibration from EFI data
      commit: cfa43aaa7948be5a701ad4099588cf49d5a02708

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


