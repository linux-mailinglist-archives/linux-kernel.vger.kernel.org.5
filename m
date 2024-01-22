Return-Path: <linux-kernel+bounces-34211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D97A8375A1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96EC71C235F5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3496482CA;
	Mon, 22 Jan 2024 21:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vn+MumC6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CDA4878F;
	Mon, 22 Jan 2024 21:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705960456; cv=none; b=mKqpUwMctc0XzenXeWCLZ1F5xk6sOtfb8F571r28s5NcZqJuZKOaoucc09BSgFDBt3+GAXJkVqTERybqD++gKuguR09JZE9hkEkev/Kx8gfmN3kW3Rj+MRdJ5XQ3kcx68ZhneC4BF6N5Ti9rI7JYMD/IG2MI3Tu7Yu7INfc0o2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705960456; c=relaxed/simple;
	bh=T94SzB7U4SRVRL7ytNx7MV/BH3wQQy3TjKH0KOzIpTo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=grSG/1veYIg3D1iVJtiikooZkzXk0DwLKkCqiuBfBdSwAGOC1QyqZF9fZI2RJJ4z1DgAqx8FognlqrLo8fCQfZ1YcHb00s8BZFg+Fnerc6cGYE2Pt0YwKmNRurXU66zDTVxewoiD+GK/ysXv3DiN4Zqv++LCPhLbruiWnZO1KYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vn+MumC6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4BBC43394;
	Mon, 22 Jan 2024 21:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705960455;
	bh=T94SzB7U4SRVRL7ytNx7MV/BH3wQQy3TjKH0KOzIpTo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Vn+MumC6B6P9UDuNkR73GJsKhm3xffTs3dJ+68hy42agHHLRvYl6vSWv3SmCs9p4g
	 EMvtuojOm4UA31q8xdYqpON1fBCh/pVLiNfFQmYRL6xr/lJcdNBxRK/QHhEoZIbcBq
	 FXDIqxI4Ar1ME2VJ+J12pdq0B0pFQLGVO26kHHaA5jNJg+DLEPTLElxKsmc6t0iPzA
	 FwezVJb3BacDMilI4FFLgRX7p2Qo/FF6kazPHmibDoXjiNKimS6Db4koiwt2d3pFSV
	 FuYAtBePP+ZqPx2yUafGdh+WT83tHXptUxJof6afoN3P4ebrGjseScojVZoTh84sHn
	 xiX+lNqjT3ucw==
From: Mark Brown <broonie@kernel.org>
To: Fei Shao <fshao@chromium.org>
Cc: Alexey Firago <a.firago@yadro.com>, Jaroslav Kysela <perex@perex.cz>, 
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Yang Yingliang <yangyingliang@huawei.com>, Zhu Ning <zhuning0077@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
In-Reply-To: <20240122062055.1673597-1-fshao@chromium.org>
References: <20240122062055.1673597-1-fshao@chromium.org>
Subject: Re: [PATCH] ASoC: codecs: ES8326: Remove executable bit
Message-Id: <170596045309.161959.615305273467009067.b4-ty@kernel.org>
Date: Mon, 22 Jan 2024 21:54:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Mon, 22 Jan 2024 14:20:27 +0800, Fei Shao wrote:
> Remove the executable bit that was unintentionally turned on.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: ES8326: Remove executable bit
      commit: 92c02d74ba7b7cdf3887ed56bc9af38c3ee17a8b

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


