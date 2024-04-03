Return-Path: <linux-kernel+bounces-130655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 635B3897AFE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 947A91C21A1F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C5C15696C;
	Wed,  3 Apr 2024 21:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cV1Inn70"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B65156897;
	Wed,  3 Apr 2024 21:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712180804; cv=none; b=M8Wc3WAoaXJXmcezOtucHSBW9mYCRoobu/asBw89tW3BIS6W8TIfSm/BkR4uiIgRScFwDpbawsueewh8tX738JoSjLiNUg6TkPODs/bq1k5c9NvBlt9LFG1bhjyAGJS8DcL6UpivkMxUOITiI3cvqsaaSMKzzcjkDovFnDMJnRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712180804; c=relaxed/simple;
	bh=6sN5aEJQrMb2UsRjJUwqNYo/m7U4mSwJvDTwGZBrQkw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=u1cKnto5zX2UufaHtxGzlpVuGIk+ijYKu+skKyt9vkN4E3aySGs6QbAmwXEkue9PgKbK9ZRcgJAO6TLXdQXqFfZsWOGiKI99fxVZPa5n20yjYVnMNgVsS5+AoM+5RPNrJ5uuwCsxfu6OJWAmzJZx9k427Z51uxW5awRsmlfTv/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cV1Inn70; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BAD0C43390;
	Wed,  3 Apr 2024 21:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712180803;
	bh=6sN5aEJQrMb2UsRjJUwqNYo/m7U4mSwJvDTwGZBrQkw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cV1Inn706cFECsK5JN0H4Si/lBN7ZP6N39OvGwwnfDhiDdHfuWqKuZwsGuEGuVb0K
	 mQe28AHwDrWxeYcYD8fso0FlAZ/1WVN6T9Xo0gqBG6zE0gSAOebK/kgxOOw5RC10rD
	 WJvilJ2QQYoQw2ik++ZM1QQYGOdAquVpNNIt0jHolGdj1IUen9wM/WWEgSSiFPIclL
	 czS08yqN/OGfDfD9tvNI3s4XtUgWaF4/kA7kZ4WrmEcLtlnvT9ymVvpdL+R8o7MDDq
	 +Uyz16/PE3UvZd4UwOANhONdXZfhWZHNHPAGvJ0U1o20BCi1XJb9LShkxsZqrsgcwH
	 PUxofDCB46CCw==
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.com, Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, 
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20240325113127.112783-1-rf@opensource.cirrus.com>
References: <20240325113127.112783-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH 0/5] ALSA: cirrus: Tidy up of firmware control
 read/write
Message-Id: <171218080230.1232330.14409527355047888815.b4-ty@kernel.org>
Date: Wed, 03 Apr 2024 22:46:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Mon, 25 Mar 2024 11:31:22 +0000, Richard Fitzgerald wrote:
> This set of patches factors out some repeated code to clean up
> firmware control read/write functions, and removes some redundant
> control notification code.
> 
> Simon Trimmer (5):
>   firmware: cs_dsp: Add locked wrappers for coeff read and write
>   ASoC: wm_adsp: Use cs_dsp_coeff_lock_and_[read|write]_ctrl()
>   ALSA: hda: hda_cs_dsp_ctl: Use
>     cs_dsp_coeff_lock_and_[read|write]_ctrl()
>   ASoC: wm_adsp: Remove notification of driver write
>   ALSA: hda: hda_cs_dsp_ctl: Remove notification of driver write
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] firmware: cs_dsp: Add locked wrappers for coeff read and write
      commit: 4d0333798ebbfa1683cc3bc056d1b25b8c24344c
[2/5] ASoC: wm_adsp: Use cs_dsp_coeff_lock_and_[read|write]_ctrl()
      commit: 3802a9969bd365749f5e34928082cff96ed7769b
[3/5] ALSA: hda: hda_cs_dsp_ctl: Use cs_dsp_coeff_lock_and_[read|write]_ctrl()
      commit: 62daf3df8a6b1920f7613e478935443a8f449708
[4/5] ASoC: wm_adsp: Remove notification of driver write
      commit: e81f5c9f7d06a69dc505fa6ad351df6cc86a6c2d
[5/5] ALSA: hda: hda_cs_dsp_ctl: Remove notification of driver write
      commit: d641def12ec929af6c4f9b1b28efcd3e5dff21b4

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


