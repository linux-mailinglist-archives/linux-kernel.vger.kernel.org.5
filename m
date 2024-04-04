Return-Path: <linux-kernel+bounces-131862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7152898CD2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58F5E287070
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8C012D75D;
	Thu,  4 Apr 2024 16:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhMRlJvF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244A012D20F;
	Thu,  4 Apr 2024 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712249930; cv=none; b=R8G0588fqTzZ1S9Dqk3VvpnUm0MKSEfuWBaD0xOYiS/I7scvOMFh7xwYoY2MbqyFwDb0Bj8JFJNkRNk+jjOQlieI2lnrUBU9QilDp6jQYrf9EkqVrzHy1ScQbo4R5BZpk4LzQk3tEYu92DP4DShu9f6/jD9nsDaJ4NTDVwody0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712249930; c=relaxed/simple;
	bh=RBI7Z0D65b5hGmYV+E8LnVe+nndv9mpl8f91rfo3Ucw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZiQ/yUGynWO0Ost4OIIXH9M46CGlVmQlFdCsugrZx/f+VTlQFlRKt7LztLcYN1fzgt0Xjd7OyO5+oU35OWbJt8IEVA14z508WregGR9Par1FQcIVrlzvQtmGHwzYgSpHWHQ77wQJsFhgkSZVkJlus3CpPgmj11J5CpkaB0tDfCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PhMRlJvF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDAB1C43390;
	Thu,  4 Apr 2024 16:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712249929;
	bh=RBI7Z0D65b5hGmYV+E8LnVe+nndv9mpl8f91rfo3Ucw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PhMRlJvFz1T6r47TN6b8C2joMFhqW/mhhOGC/0/RvhF/1R9bIU0y2jIiuRO62m4bf
	 Bbiws6VvhdR+xUL3g/DEhOn7nNCOoID5lTbmd4tRE2f4djQnFmDr6cjje1z7vWywaF
	 oDoXp5NVY+Q+0ez+pAkjHlwv62T7QcHPodiheXWoNE50jtUapRkbWUQ2SZim8UTr4L
	 bFvf1J1pasPSy0jJ7yoOpiQFM4ZR/dbskmIjVeY3TkMAkWGBgHnoygQ5C8IyNvCy/p
	 JjJ8pbSYY3iuQnQ6p4gKkJI5EhSL411tx7XvqvMVE7zANSQWqxM7jp+eHa7/eBKqvZ
	 ZF11OgyC9/B/g==
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <a35dded2-392b-4ccb-9dbb-d782ac9b6547@moroto.mountain>
References: <a35dded2-392b-4ccb-9dbb-d782ac9b6547@moroto.mountain>
Subject: Re: [PATCH] ASoC: SOF: Clean up sof_ipc_flood_dfs_write()
Message-Id: <171224992668.92541.12447805103129692828.b4-ty@kernel.org>
Date: Thu, 04 Apr 2024 17:58:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Thu, 04 Apr 2024 10:34:53 +0300, Dan Carpenter wrote:
> This function doesn't support partial writes so using
> simple_write_to_buffer() doesn't really make sense.  It's better to
> just use copy_from_user().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Clean up sof_ipc_flood_dfs_write()
      commit: 2cfa0eea2675ce569dc80d2c0d2d644a452b77b3

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


