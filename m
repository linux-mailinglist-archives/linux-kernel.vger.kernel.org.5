Return-Path: <linux-kernel+bounces-64615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD1E8540E7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CA5928AA7A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7079F801;
	Wed, 14 Feb 2024 00:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEsCu6C7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B247F;
	Wed, 14 Feb 2024 00:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707871741; cv=none; b=Y4X4h0f2lWaDBgc3sat7tGS3JSe1xeYhjQXO1pFWgP742aHOdDLCKqiNmfD9yfAfpzXoJoPXZOWmEiL3J9UsGEt/EipnJRDX5a/6w6sBONUf0cidQAPTb8NcyEPJOCzKQz6W8PGp64H+ajt2NqA+T7gv3PSS+/0Q7PNWA87iTw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707871741; c=relaxed/simple;
	bh=skhRkO7Uxedf6QXw1VE3CGUkjfOGv90B45ezzdW27i8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oJOfixCPmAhvzzGPG89+oq6ylzX59tbmPICnwi3d+yAuvdc/Vo9206U9qNhIoZTYwub9WUYWY/BcDCDVr2/ZfMVuMoyNlpL2pdm9OqlJENqv9kNyM7YzxlGKFN6qDe2rMiT2kYU9GwxkMZfNXIXN+2G/mgdtTN8xMVFNzelciiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEsCu6C7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5829CC433C7;
	Wed, 14 Feb 2024 00:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707871741;
	bh=skhRkO7Uxedf6QXw1VE3CGUkjfOGv90B45ezzdW27i8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KEsCu6C7n5FsKmERkVh90tkAZ+hICu0JUarOA5kI2oFSV+HuPT81zP+bKzRmbNa+R
	 BCuX/grdeBd7VsZflmy4+6LUnk1L7ogUlFzMQOwRgWwsjN1YLsLkVToMjystqIZfEs
	 3naLHLd5T+6clrX0dBYOwWWt1B2mzsfVcvwkFJ7FySdhLnBcTnOy1NQW+uQ2DUqNcj
	 x1hDBaL4EMeWRKKJNDTaGW5ejmkEIH0mw89rWqdt3KTHq3DyiqSGl42UjGBoIBXcvE
	 /cbxGPm90ihDmyg6L/jDdqMMN+h8H/4bpM8Jml1fCShPcenEpq87npboI3my9kolk5
	 pNoC3d7jmE9Ng==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 neil.armstrong@linaro.org
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240203-topic-sm8x50-upstream-va-macro-npl-v2-1-f2db82ae3359@linaro.org>
References: <20240203-topic-sm8x50-upstream-va-macro-npl-v2-1-f2db82ae3359@linaro.org>
Subject: Re: [PATCH v2] ASoC: codecs: va-macro: add npl clk
Message-Id: <170787173909.1088332.13543091218086927386.b4-ty@kernel.org>
Date: Wed, 14 Feb 2024 00:48:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Sat, 03 Feb 2024 21:43:05 +0100, neil.armstrong@linaro.org wrote:
> New versions of VA Macro has soundwire integrated, so handle the soundwire npl
> clock correctly in the codec driver.
> 
> Introduce has_npl_clk and handle the sm8550 case separately because
> it has soundwire integrated but doesn't have an npl clock.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: va-macro: add npl clk
      commit: a6eb64e7e32c7a6a502a19c20e3f04818091c2dc

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


