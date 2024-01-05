Return-Path: <linux-kernel+bounces-18298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA9F825B19
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 20:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59625284FB0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216DB35F18;
	Fri,  5 Jan 2024 19:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYb0c6/9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0BD35F03
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 19:32:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93BF3C433C7;
	Fri,  5 Jan 2024 19:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704483163;
	bh=CE7UjEaDI5KMulL1/tLDiQr0CWV92dV7m9QiTsWAdrQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sYb0c6/9+4SJRNj0rSrQJokQoxVGDDQ4v12DrEd9BEc2614Sp3o3hdmnsFEzlUzyr
	 2zam8lIhRG0w9pBRy8vOo7EBUCESyp4gZcqsoILwvBKxlCVy4eU3rvQPKV7P8vx9EH
	 IX2GXRZM06D9Oe8l1Rgbjaa/a/RjxRBuFZE6aJLs9UeLbT45Qt3Rxy+NqxE+IDPTFS
	 wV4fVywlSZwWBNxqCcFe7MJjlD9Jx1kh+LvBjaqdareEf8iPtIjmqIVq4u94sAaVhR
	 Cayg+z1vwxXpH5faIE+B6vTBgC8kha+nyCsaP5ySbXf64gijZQiR5OKXYltuF21BGO
	 r0VMAl4VxcfNA==
From: Mark Brown <broonie@kernel.org>
To: cy_huang@richtek.com
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <cover.1703813842.git.cy_huang@richtek.com>
References: <cover.1703813842.git.cy_huang@richtek.com>
Subject: Re: [PATCH 0/2] rtq9128: Fix pm runtime and TDM usage
Message-Id: <170448316228.816841.3370890831614540620.b4-ty@kernel.org>
Date: Fri, 05 Jan 2024 19:32:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Fri, 29 Dec 2023 09:46:00 +0800, cy_huang@richtek.com wrote:
> This patch series fix rtq9128 pm_runtime and TDM usage.
> 
> ChiYuan Huang (2):
>   ASoC: codecs: rtq9128: Fix PM_RUNTIME usage
>   ASoC: codecs: rtq9128: Fix TDM enable and DAI format control flow
> 
>  sound/soc/codecs/rtq9128.c | 73 +++++++++++++++++++++-----------------
>  1 file changed, 41 insertions(+), 32 deletions(-)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: codecs: rtq9128: Fix PM_RUNTIME usage
      commit: 35040410372ca27a33cec8382d42c90b6b6c99f6
[2/2] ASoC: codecs: rtq9128: Fix TDM enable and DAI format control flow
      commit: 415d10ccef712f3ec73cd880c1fef3eb48601c3a

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


