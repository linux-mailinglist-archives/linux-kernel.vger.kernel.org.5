Return-Path: <linux-kernel+bounces-1387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 213DB814E55
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCF18283C31
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6893FE40;
	Fri, 15 Dec 2023 17:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1DMIykG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988CC3FB33;
	Fri, 15 Dec 2023 17:11:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0666BC433C7;
	Fri, 15 Dec 2023 17:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702660270;
	bh=bb71eNv5ykDDBLYAbeoMWkUlxEzXqAvnDeM0adtsavQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=t1DMIykGAqdba93fDOiQwMt4uLI8Dj9nxIoyY4HAKpCngLHZgcKqdhxXm4AqYZi3b
	 3NpY8FliGO05yfRJloLMK5+Jd6Tf/3LXq8tQEKMSaGzZ7XLWRqmSrzRVyPrLtT6DGw
	 EtznZx1ncexJEObHBMsZDtLajcs2nhlW25G4nfuz9HaOxCmgkGE2DyeRUawvsIibEP
	 ayE5WrmLKW41bB32xPvKNenSrgTWi8zjJGTW2NIIP6ZF/L85qA0etOrknZDOpoGKVb
	 h1FKSgXW5TXBrIv+n0dl9RKBt0h5Ik3I1oLn55Jm3kgeW81o/ZllBnEKGUfG9nbO52
	 2DJmAyr1CDYLQ==
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Gergo Koteles <soyer@irl.hu>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, 
 stable@vger.kernel.org
In-Reply-To: <523780155bfdca9bc0acd39efc79ed039454818d.1702591356.git.soyer@irl.hu>
References: <523780155bfdca9bc0acd39efc79ed039454818d.1702591356.git.soyer@irl.hu>
Subject: Re: [PATCH] ASoC: tas2781: check the validity of prm_no/cfg_no
Message-Id: <170266026773.89698.17924199920946310411.b4-ty@kernel.org>
Date: Fri, 15 Dec 2023 17:11:07 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Thu, 14 Dec 2023 23:04:44 +0100, Gergo Koteles wrote:
> Add additional checks for program/config numbers to avoid loading from
> invalid addresses.
> 
> If prm_no/cfg_no is negative, skip uploading program/config.
> 
> The tas2781-hda driver caused a NULL pointer dereference after loading
> module, and before first runtime_suspend.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tas2781: check the validity of prm_no/cfg_no
      commit: f32c80d34249e1cfb2e647ab3c8ef38a460c787f

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


