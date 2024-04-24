Return-Path: <linux-kernel+bounces-157031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0938B0BD2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 285AD1C23CAC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B6E15DBC7;
	Wed, 24 Apr 2024 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAuCZDl4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C30215D5A9;
	Wed, 24 Apr 2024 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967339; cv=none; b=bi1sCmniJ9+sWvzy/mH1RLuZSIGqosHc73RAPMahCuPfPTWe4lR97iBtdGb/S7TnPaOeD5jSnMfkq1rJLJs2whALa8iggojRPjEGzvHoL3ym5gBVNJT/s0lovssjewWxJnhC7Y8rtHr+5UAan0Smy2jWf3jDg6CKHhZ2C+Y/mSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967339; c=relaxed/simple;
	bh=At+JIfss6PIM193Ah834PLLMn6OmGqr53fpvVdcJ5yI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=P6Li13on1GXNvcZJKL0sbYndOwqZbB8kPe9gmJtwvjUji9oLmRmqR5NjjCrcOOXK9DIqw8ApHEz89JF6Ff+ilZ0whvUWc/fb7ua/Djg7ikX/af6Qj2fLsrfUaiz8b4CCd6FCOikvfmwtXs2d79pNWcsjpwMTpEGxWT5tbSAue0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAuCZDl4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0DDC2BBFC;
	Wed, 24 Apr 2024 14:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713967338;
	bh=At+JIfss6PIM193Ah834PLLMn6OmGqr53fpvVdcJ5yI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RAuCZDl4dd1/5+7F3auuVAX1Yyf9UcesojSAT0oKYs4quDmuxzERVc968jd3Z6A1a
	 pntGEUk/e66iox4iuIwbF716aqNH6FzblVqaj4LmaVD543rSOVrB4753GezZ2y9oJA
	 /DCL6JMLxFewqJX3mMU6fUN2RgTQF19IbtEMio1qsx3f55qE57b1AAD1cO8Gbu8ftq
	 Jp7UgUKAWU2GY+XHgOdXfvS/tyMP1G2GyPvDQwujcxqa/iXA6qZdAP441MWF1CvYjp
	 pl/a1wEx5r8zUNdn84KawqNUrzEn+m5ikOPJ4W/W2HiZUZEiZ7iWRoyaN0dh/TiZQe
	 YgBgSlCWhTr+w==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Shenghao Ding <shenghao-ding@ti.com>, 
 linux-sound@vger.kernel.org, Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240423074428.1313777-1-colin.i.king@gmail.com>
References: <20240423074428.1313777-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] ASoc: PCM6240: Fix spelling mistake: "deley" ->
 "delay"
Message-Id: <171396733540.1799261.8397645692339462864.b4-ty@kernel.org>
Date: Wed, 24 Apr 2024 23:02:15 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Tue, 23 Apr 2024 08:44:28 +0100, Colin Ian King wrote:
> There is a spelling mistake in a dev_err message. Fix it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoc: PCM6240: Fix spelling mistake: "deley" -> "delay"
      commit: fe2a84133724ef56d2c99f2be5d0e06c4b8395c1

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


