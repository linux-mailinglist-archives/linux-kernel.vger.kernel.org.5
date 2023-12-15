Return-Path: <linux-kernel+bounces-1150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF75814B23
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A37C1F24CDE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AF435F14;
	Fri, 15 Dec 2023 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J82Ykm4F"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810C7358B3;
	Fri, 15 Dec 2023 15:05:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B90C433C7;
	Fri, 15 Dec 2023 15:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702652722;
	bh=XOILv9Fmwwz3Rta+62IPEge55zNcBrrWIBM03rU+5UE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=J82Ykm4F3QSyWLSqa7ED/v/ozXselGaYeoF/WX6M4v0Tws+q+L/NnlN+b+c5XyPJJ
	 0oRLZ1Qo+ulD5PbpBqh8sBrlVEHI0/D9M7Sh0xCi9jYHXO66xjFcBJZKYgtmZ6hCF5
	 YtCmKKZEfvO3tFE2NNHZJtcU9fUBaQf2feOG0ItjoUlncJIO0R3SvVH+V2y51EGoBU
	 lMcDrDTQv/jaLvD1vE4E1sYXJxQ+MUFRPhWyE2Zh4pmyAUjkIwhLZSHxhBf1MGN9BW
	 mswU/V4Rey357AU7dMhKfKRj2NxsxEJ0GxL2k+SHZfq6Me39WaErEvLy1vhyrKq7nv
	 0MceiqvqXxTNg==
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, 
 linuxppc-dev@lists.ozlabs.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Wang Jinchao <wangjinchao@xfusion.com>
Cc: stone.xulei@xfusion.com
In-Reply-To: <202312151713+0800-wangjinchao@xfusion.com>
References: <202312151713+0800-wangjinchao@xfusion.com>
Subject: Re: [PATCH] ASoC: fsl_mqs: remove duplicated including
Message-Id: <170265271919.82974.8640827688447166639.b4-ty@kernel.org>
Date: Fri, 15 Dec 2023 15:05:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Fri, 15 Dec 2023 17:13:51 +0800, Wang Jinchao wrote:
> rm the second \#include <linux/of.h>
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_mqs: remove duplicated including
      commit: e7a4a2fd9a4116286a1523ea1a5cbabd2c36f5b9

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


