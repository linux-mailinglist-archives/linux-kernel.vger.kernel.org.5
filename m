Return-Path: <linux-kernel+bounces-5590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69836818CBE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E618BB24F05
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E19431A63;
	Tue, 19 Dec 2023 16:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N93g1EOc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD1A31A62;
	Tue, 19 Dec 2023 16:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5F5C433C8;
	Tue, 19 Dec 2023 16:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703004295;
	bh=uY8fqQCvkkUSuHn+34OsFHa3dqUCF5h5l2rlfTPHwXM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=N93g1EOcGSO+QxDP7KDszfEIlm/mKMeQVx9VDigJLiFx8WIoi4KexrYHPbRhLOXAi
	 /+UMXA2uXUFPJCvwFzcu9zljyF183OCahRGGBZIqZDsyREh8TNDM1ayw0UPJZddNTz
	 qtU1pbPt+DXLMiuY4RSsMpnvubkhHIY65ReLzcaRhX2ZxGWPBlFctallX10Mz+aHNl
	 6JhRcaqc5qIK1InZvzesgTUeNBBGg8cLl678/XZVkOg47YFem0JOXyoMrkXGQrTKrC
	 9w2AW65tVXXgi9rmnMEUBO+8GzlrIaTKNBkfGN2oBTrdCKONsQYF8wlxPT/Urm3kY3
	 47yjmndM08FFw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 linux-sound@vger.kernel.org
In-Reply-To: <d16f22ae0627249a9fc658927832590cd88c544e.1702960856.git.christophe.jaillet@wanadoo.fr>
References: <d16f22ae0627249a9fc658927832590cd88c544e.1702960856.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] ASoC: sprd: Simplify memory allocation in
 sprd_platform_compr_dma_config()
Message-Id: <170300429301.102048.9618371521087929133.b4-ty@kernel.org>
Date: Tue, 19 Dec 2023 16:44:53 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Tue, 19 Dec 2023 05:41:19 +0100, Christophe JAILLET wrote:
> 'sg' is freed at the end sprd_platform_compr_dma_config() both in the
> normal and in the error handling path.
> 
> There is no need to use the devm_kcalloc()/devm_kfree(), kcalloc()/kfree()
> is enough.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sprd: Simplify memory allocation in sprd_platform_compr_dma_config()
      commit: 1b08e7697f1eef88de902820d181d5c4291f074c

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


