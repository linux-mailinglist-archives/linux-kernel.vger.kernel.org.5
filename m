Return-Path: <linux-kernel+bounces-152402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F328B8ABDE5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 03:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C323A1C20CED
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 01:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6101F1FB2;
	Sun, 21 Apr 2024 01:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTlinpGL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9952F17F5
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 01:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713661395; cv=none; b=N8h92j6Jbsroej70sWabaK+mEmA1dmPUe+oNP11QiIdhVmUhHxpyDBkgcvys20U2ik4OZf6d0FRFhuQIy7xwcZKhxBy0aPQPMMbTheNnGGPnJXt/JLLZRNr3thMzzeaTERi+UuQ/I5gE3FuoJebwEfzjh8TpOqHhCpgh0FAps0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713661395; c=relaxed/simple;
	bh=xUIt8QunbZ1fuNrSmdIMkIBH7+mTjqMkriWFaVUvmPU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qiuNu76eJFXxHJTLxYsdzsduv4COmiJvBM04pPo7vETDbfpcSRKcwPEKvoCzYfW8bU+eqyCvNFpRR6YiJGk8lle6cdbXvDIsYlvoz6afHXbC+sFywk/XrPKq51TOq3X9pCfDkpOPKnUEljaMJOE84Tr4WjhuUPuTszD/puUbyo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTlinpGL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844C3C113CC;
	Sun, 21 Apr 2024 01:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713661395;
	bh=xUIt8QunbZ1fuNrSmdIMkIBH7+mTjqMkriWFaVUvmPU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DTlinpGLbEtPgsQQw1398sBovebALKqjt0mxlSKdiF1X/n94a+ZO9D/e+EBjPQOIw
	 RbofoXTKe02dpklanETsV3VbziQNJ2MVoJi6KYtLtP4fgyVED0OVd7RaTlerzvHaaw
	 5rX5gPVVtpNfM4v4/Spig+VQbYXEDH5FOwaXt5u8pUkXwkaZt3NQdTlqUIQaTWeMOJ
	 9X4pg5Cwa9GIiuSS8dcFROuaRydb7VHvUsAajkHF3w8yiwETtVm1evoLx2mBrvyP9s
	 E9KKnIYnyO+8krFcgT4QmoVtxSWdaTzw9R8/hEldgfZVsckXYDJP+DYfbYFOXzXxKn
	 p9aFFIihalktQ==
From: Mark Brown <broonie@kernel.org>
To: srinivas.kandagatla@linaro.org
Cc: perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com, 
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, steev@kali.org, 
 jenneron@postmarketos.org
In-Reply-To: <20240419140012.91384-1-srinivas.kandagatla@linaro.org>
References: <20240419140012.91384-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: codecs: wsa881x: set clk_stop_mode1 flag
Message-Id: <171366139341.1739626.17364130148301852244.b4-ty@kernel.org>
Date: Sun, 21 Apr 2024 10:03:13 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Fri, 19 Apr 2024 15:00:12 +0100, srinivas.kandagatla@linaro.org wrote:
> WSA881x codecs do not retain the state while clock is stopped, so mark
> this with clk_stop_mode1 flag.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wsa881x: set clk_stop_mode1 flag
      commit: 32ac501957e5f68fe0e4bf88fb4db75cfb8f6566

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


