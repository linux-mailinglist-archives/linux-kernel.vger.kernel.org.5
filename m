Return-Path: <linux-kernel+bounces-152939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EDB8AC65D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51E461F215D9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE205336D;
	Mon, 22 Apr 2024 08:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rK/qq5vb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B6848CF2;
	Mon, 22 Apr 2024 08:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713773356; cv=none; b=cIr8pRk7r+OktaBxjZZR0/MWVTsLGQ4PqA3UA249J+XEqSLSkTjnjp+UR7/vfyyBCilw+T5rdzNGxiGbbZ95CCX37WtZtp+H5C56kzWBxv/6fhn5hsd28Sf2EisyzdQfiaNiuALGgnbzM2ha+WK7xyc39Mq36ZxvQuGjMEBLf8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713773356; c=relaxed/simple;
	bh=lrAtAACNMRKkPVl9BmgLOc7v8tggNspHY9s2WWLZpRc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ecYLJVtYALrHknEhC6AJMv9RH76zLAD7dMU6nytwvK72+BU5SxZTnRgHRZ0Gt6tmJRcuO1Q/yWy0TD+eT0i7mcNIJzHQGYeRljvOG9XRTvUJ2Nl9hh3Rcsl8jLy4SRp4dNiZmeZWkcX/K7CjWxA/nFvNeSnWrM4nXSq/q4AbE1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rK/qq5vb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F09C32782;
	Mon, 22 Apr 2024 08:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713773356;
	bh=lrAtAACNMRKkPVl9BmgLOc7v8tggNspHY9s2WWLZpRc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rK/qq5vbzE6YvdpbLr0+h98Gn4+fgRViM07W9nW0ift0iRF3HXn+4281wnYI5N/5d
	 b8Q39bOySrS1oC1EoBJuOyxnALVuxMXGmAA3YI9StNnzj4JBivuZrpGhKWcQE1pTqh
	 r6TA6UfuzQFscpNiikKuSc3t/X9aIP0dXKmyIJc4ltbIP9qwi9eyvgDh4G9e3HZXsN
	 Z5nDpViHP0hy+kVzxMWhB7Fmx7K749dIj81sMELMe30nP9Z8jCSZYc8gfAu0ttWtsD
	 pQM2DKUtGg+Tod6FSxjfdExLpIf5I/VHCREKp9814wVE52g1JYsaniQ6nmzr/kGBu0
	 sHNsgGpydNDcA==
From: Mark Brown <broonie@kernel.org>
To: Seven Lee <wtli@nuvoton.com>
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, 
 devicetree@vger.kernel.org, linux-sound@vger.kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org, 
 robh+dt@kernel.org, conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com, 
 edson.drosdeck@gmail.com, u.kleine-koenig@pengutronix.de, 
 YHCHuang@nuvoton.com, KCHSU0@nuvoton.com, CTLIN0@nuvoton.com, 
 SJLIN0@nuvoton.com, scott6986@gmail.com, supercraig0719@gmail.com, 
 dardar923@gmail.com
In-Reply-To: <20240415070649.3496487-1-wtli@nuvoton.com>
References: <20240415070649.3496487-1-wtli@nuvoton.com>
Subject: Re: [PATCH v2 0/3] ASoC: nau8821: Add delay control for ADC
Message-Id: <171377335152.1755143.9849585932457146523.b4-ty@kernel.org>
Date: Mon, 22 Apr 2024 17:09:11 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Mon, 15 Apr 2024 15:06:46 +0800, Seven Lee wrote:
> Change the original fixed delay to the assignment from the property. It
> will make it more flexible to different platforms to avoid pop noise at
> the beginning of recording.
> 
> Change:
> V1 -> V2:
> - Revise adc-delay-ms properties description.
> - Fix examples of bugs found by bots.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: dt-bindings: nau8821: Add delay control for ADC
      commit: 467d2528d64e8fcf784850ac94f665efae2af149
[2/3] ASoC: nau8821: Add delay control for ADC
      commit: bd74e9c31f0d1880ff4482f1a7ce33a006d870ed
[3/3] ASoC: nau8821: Remove redundant ADC controls
      commit: ad8ba241bc93536a2c8af150b237c5be8fafe942

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


