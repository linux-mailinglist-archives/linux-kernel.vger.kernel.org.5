Return-Path: <linux-kernel+bounces-1151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1095B814B24
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 421F61C23B2C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F5736AF3;
	Fri, 15 Dec 2023 15:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MigLQ+D0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9709336AE1;
	Fri, 15 Dec 2023 15:05:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CDC2C433C9;
	Fri, 15 Dec 2023 15:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702652725;
	bh=sCnp1QgOOh3vBK1+2YkZGjH6MshpX55xHasnDdsYCU4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MigLQ+D0jLb5iQewwF5z+sy1QKTsyvACvAfpZ2+VwXu3dKAov3npZN7GYPP4OrsGI
	 O/FbKZ2SdKaBFmX0e1+CLje/rSur2I4orzONBMAZOEjgr6vpNWlqDx40SJZ3N7jl+n
	 cohrJpASyeLxskhbRBTxWv67wz1YAgf38n2NwXdATB+sh1ERHg82SvI83MqH+U7TV1
	 PoddECTn9iKW5NmIiyk9gGD7Eciukn9NV+jEAIApAjzsbc+Z495vafN6pENJzO+sQz
	 OPhzmj0HLaDCv3TQFzOefLFVG60deFlwEmsw8nxZKiVgPU7NoTjshe6nAITnL5HDWK
	 F9ynSo9Qxglgg==
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Wang Jinchao <wangjinchao@xfusion.com>
Cc: stone.xulei@xfusion.com
In-Reply-To: <202312151719+0800-wangjinchao@xfusion.com>
References: <202312151719+0800-wangjinchao@xfusion.com>
Subject: Re: [PATCH] ASoC: SOF: amd: remove duplicated including
Message-Id: <170265272222.82974.13710590379643175388.b4-ty@kernel.org>
Date: Fri, 15 Dec 2023 15:05:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Fri, 15 Dec 2023 17:20:00 +0800, Wang Jinchao wrote:
> remove the second \#include "../sof-audio.h"
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: amd: remove duplicated including
      commit: 02842209fc29bddb2b673ceb8f681267857c4bc1

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


