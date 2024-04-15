Return-Path: <linux-kernel+bounces-144945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 142E98A4CFE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 454241C21275
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3FD5FB92;
	Mon, 15 Apr 2024 10:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8H1GZdS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB8A5D75F;
	Mon, 15 Apr 2024 10:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713178403; cv=none; b=fIfGZ2JnH/cgNEiQdPrTCQQ8HqalEw+lG2hXwmVPVA7IsMN9L39h7Po2pbcnvMvLdtAGKfAw3zm+xH2Nk7tmzk/+SMozRyT5EDlGXrnOYOMePeCtrmb89goToMZz834oW/p4V+mfgHD9xI/FQbGJjGoNhgx25F0IVCzWT0sW5MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713178403; c=relaxed/simple;
	bh=rnyoSsMHQxr2FpuWYiyNFR/ZDGJBdTKFdNrtzd5MXvI=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=acoOoQEMcmi1ZtYGqqSSBOzopdi71TS+AS3c0VHMKFTbOOhS1ftFlTvv64bspCG/hsy6kXkVCvNCCswQXhMXNJgBWgH781xkanuHVAWvwmRtpTjEnoU5P5xQUGhJzyTSwsIU1wZaoTUXWmDFufBE2ecQmOb8Nm8PvsWqYZeFz6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8H1GZdS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2EDFC3277B;
	Mon, 15 Apr 2024 10:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713178402;
	bh=rnyoSsMHQxr2FpuWYiyNFR/ZDGJBdTKFdNrtzd5MXvI=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=f8H1GZdSXQsUopLuk7g5T7VRzyN2HLk8mfqZoMWBzWUN1CCl2JBGhgv4/zS8m4KF+
	 fLiNBJGSZoM3GMmgDUsl801iV0bkPFgCcBZ269I1wF9wuB1W43xK7muyg47/i6dJYE
	 5di4w8z+X2AjQ3yxV/ePFJFDrzpf5x1LkRrbEFBYhgP+fc18Te4lZ220I8evqejHSZ
	 fMbg2K7mCZPlLjUSVUvwM1FuLOEmtnA4WLjLp05qYs1v4WGz9FSv/RZU4XP0gnrD4x
	 htOtG6T51U9Jkya+Gnbv443xhpVqyL7Kxoeyu7xdortxcHQtzNFS/xbpAT7ZSDOQK6
	 hYXRbUxPvg6PQ==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, alsa-devel@alsa-project.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20240414154839.126852-1-krzk@kernel.org>
References: <20240414154839.126852-1-krzk@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: wcd934x: Drop unneeded MODULE_ALIAS
Message-Id: <171317840045.1652048.10866553206625890591.b4-ty@kernel.org>
Date: Mon, 15 Apr 2024 19:53:20 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Sun, 14 Apr 2024 17:48:38 +0200, Krzysztof Kozlowski wrote:
> The ID table already has respective entry and MODULE_DEVICE_TABLE and
> creates proper alias for platform driver.  Having another MODULE_ALIAS
> causes the alias to be duplicated.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: wcd934x: Drop unneeded MODULE_ALIAS
      commit: 615169c727b13ff4ec6c43b62501f73f9f88a11a
[2/2] ASoC: samsung: i2s: Drop unneeded MODULE_ALIAS
      commit: 9d85ec4e91e354ed2d8291e1ea3ba76e660205a0

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


