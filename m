Return-Path: <linux-kernel+bounces-61902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 311E7851824
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 641591C21807
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C9B3D0B6;
	Mon, 12 Feb 2024 15:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVq8snFF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57A03D3A1;
	Mon, 12 Feb 2024 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707752002; cv=none; b=BcIudWfI6IG+Q/WJJdRx1/rCpTmRqUse9HA75eI3N9QFCk4xsZdvXvMHV13fVobwuF6fLOpkSe4IuTyzoNyXRL8GNAfnem2nIoZigoYqFCARIvPA+AZbHbqC24wDAUOSTfN+VvRwU6EyHTLKuoqQ6ieHA/hk3VK1n6HXpNqOktE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707752002; c=relaxed/simple;
	bh=0lCFdr7xhbejL/c2fUAqXPWoHxOMR5vUxCIx9U37deA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KRwjTdoPXC0fgIPvVYRso3GZlVh7G2q/hqbyApSrKmIa1FGPI5HA+QTwFRwOeaMOw+1yPx4v3lA1B314tFJgRIXjMj3X47p9bf4HtuaByIeyyo99O+h+m4/i7o143FH2RDvuITetDWjX62XdVkkRWTNwB4YRdTJvR8rgGVkQ8KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVq8snFF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136A7C43394;
	Mon, 12 Feb 2024 15:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707752002;
	bh=0lCFdr7xhbejL/c2fUAqXPWoHxOMR5vUxCIx9U37deA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tVq8snFFHORknqktib7ju117kTqWJ4H0gi/qTv2RW7se3pGL+yrYFPTXF3EyHQc4d
	 EEiMI5VyQto2eAV9oJ51q/mECkSAd2sGcQAXr8hOstx/TwpbZZ/Qz+Fp6tsa6+NEv+
	 I0iDqvgiHflcZdHOQDK8SJXq4fEwt9NKW3e0DUDuJ/kuQQC6dwriOZ0F2z6qoaZppB
	 eKoNfmABT2hW6yGHhnBkoRYv/5UgC+bZjyYO9sOL1aCU5mFlwrZXnTqCtztj3nzRHG
	 RVBn3c8J+V79URhrE2vKGa9HbrIP4sEEDjTA3trUQBvT126LO3wXBxftrRHTWDzx8r
	 bMinPCmspJ6UA==
From: Mark Brown <broonie@kernel.org>
To: Vaishnav Achath <vaishnav.a@ti.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 vigneshr@ti.com, u-kumar1@ti.com
In-Reply-To: <20240212120049.438495-1-vaishnav.a@ti.com>
References: <20240212120049.438495-1-vaishnav.a@ti.com>
Subject: Re: [PATCH] spi: omap2-mcspi: Revert FIFO support without DMA
Message-Id: <170775200080.46149.6260047434970051936.b4-ty@kernel.org>
Date: Mon, 12 Feb 2024 15:33:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Mon, 12 Feb 2024 17:30:49 +0530, Vaishnav Achath wrote:
> MCSPI controller have few limitations regarding the transaction
> size when the FIFO buffer is enabled and the WCNT feature is used
> to find the end of word, in this case if WCNT is not a multiple of
> the FIFO Almost Empty Level (AEL), then the FIFO empty event is not
> generated correctly. In addition to this limitation, few other unknown
> sequence of events that causes the FIFO empty status to not reflect the
> exact status were found when FIFO is being used without DMA enabled
> during extended testing in AM65x platform. Till the exact root cause
> is found and fixed, revert the FIFO support without DMA.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: omap2-mcspi: Revert FIFO support without DMA
      commit: e56c671c2272d939d48a66be7e73b92b74c560c2

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


