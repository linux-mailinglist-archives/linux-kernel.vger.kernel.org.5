Return-Path: <linux-kernel+bounces-4167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D09FE8178B6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 718E21F23208
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E49F72050;
	Mon, 18 Dec 2023 17:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSN0j1Ff"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7456D72062;
	Mon, 18 Dec 2023 17:28:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B3EC433C9;
	Mon, 18 Dec 2023 17:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702920505;
	bh=q46dcEAXXG662nZG0w7NLZkBW1ToPTQM5x8PxxwXJyU=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=TSN0j1FfKpPcvU8weZ9IwMEyvso93ofkv2bOG74NmoAYvdmUQ3Lafld2DNzmt3o5M
	 edS+AKyKfeV00O+Ae7jJ3nIGRcpZJSeE/lpAwn8yAJplyNYRsriKBMRTm2cgXQJghY
	 VFMHnQgLV2JZI0OCmiJOg5Zev2Ajfe5SZrN/P1mGiMJ9dO/ib3h09PAwFsXPQbwMfd
	 vIMBA11feV44jT/MFD5CzfjRzlJmiSQcWW+l5IoO7F5dli/L8s5Uhvmoc6u2/qjn1Z
	 rDZF5Vb/iaqJCkWNu0PjvNlIrXPBJg4gQvUBmf3/e0CgUi+LkcKTT7D4dY/FtannWf
	 /SLDvNRwe99ag==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Chancel Liu <chancel.liu@nxp.com>
In-Reply-To: <20231204111532.3165-1-chancel.liu@nxp.com>
References: <20231204111532.3165-1-chancel.liu@nxp.com>
Subject: Re: [PATCH] ASoC: soc-pcm.c: Complete the active count for
 components without DAIs
Message-Id: <170292050439.89121.5834781324201085971.b4-ty@kernel.org>
Date: Mon, 18 Dec 2023 17:28:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Mon, 04 Dec 2023 19:15:32 +0800, Chancel Liu wrote:
> Some components like platforms don't have DAIs. If the active count of
> these components is ignored pinctrl may be wrongly selected between
> default and sleep state. So need to increment or decrement the active
> count for components without DAIs to avoid it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-pcm.c: Complete the active count for components without DAIs
      commit: 8f039360897bdd2f1f455b46a7f504b677405913

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


