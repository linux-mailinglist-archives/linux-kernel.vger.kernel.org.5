Return-Path: <linux-kernel+bounces-61037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19551850C84
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 02:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE0E51F222C4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 01:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4241610FA;
	Mon, 12 Feb 2024 01:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIUgURIN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F5BA35;
	Mon, 12 Feb 2024 01:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707699763; cv=none; b=Yf5R/Yp+1npiriQXs3jY107qo1vGyNBc84OKhAjdApQ083Txevc3aKZesjeotcV24rSwsiXHo1JTYpGT+L9kP+dnYKsPbDFG0giprgk2Ukl9H4gBJgx1XFHbxTnxfleXVIzS6yO2Pn6hHnCYkni6NRJO6yk1GPTc8pzXfKpwLfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707699763; c=relaxed/simple;
	bh=bx3BxrKGeRBMwdu0aMB0Rsq42isiv7zHhqCkQuDe9ns=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RtRcqkmjLD1tu0TjtIwbgMckPNOQPfU3WOsbhb/8Qvc43981Z0lcyTz+RkYOHdesnDN9O6gclOxZz1c5Kax8ZPpNnNnzntztLO9LxxpJCvo/PsmddPUZiCAxs7dJxCS5qTowI8r4vNgVWwdPxRlXkS3WbKiqX0H553g70lFobSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIUgURIN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D16C433F1;
	Mon, 12 Feb 2024 01:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707699763;
	bh=bx3BxrKGeRBMwdu0aMB0Rsq42isiv7zHhqCkQuDe9ns=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kIUgURINKrU5X01xZFLE7hy/pRunvsQb3+TJZQz0FwoMG2W+y3rO0Ko0Mu2eCQpuW
	 P+TipoKgq2iO0jzXC133ZkkR68s4E074pRNnAHz1YLNXNAZei7yg6YbrjaKsrCe+hc
	 Rvi8VPs7Ua8kwfmzgj1eGeZgtaUEVoHikiZ1+Fq4quIprMkvLW6C5WI+p0tOAyeEsC
	 MtJos2NMEb2BiNzVIHf7FhuCehe+ONqInQVUGIwFeQ75fixKD7FzgQxJLoHySdfOIk
	 ONWdBSRs/n8+MS2t8NVz74qG/SY/Jx8gI2B1VCZ03UAxq/ryVSIxwTuZ0ZxMVLNXau
	 V8RsPINzfppYA==
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: kernel@pengutronix.de, Rob Herring <robh@kernel.org>, 
 H Hartley Sweeten <hsweeten@visionengravers.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Stephen Warren <swarren@wwwdotorg.org>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240210164006.208149-5-u.kleine-koenig@pengutronix.de>
References: <20240210164006.208149-5-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 0/3] spi: ppc4xx: Various fixes
Message-Id: <170769976038.2477676.3054668250534465256.b4-ty@kernel.org>
Date: Mon, 12 Feb 2024 01:02:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-0438c

On Sat, 10 Feb 2024 17:40:05 +0100, Uwe Kleine-König wrote:
> this series fixes three problems of the spi-ppc4xx driver. One of them
> was introduced by myself, the other two are already older. I guess they
> were unhandled before because the driver isn't enabled in any
> allmodconfig build.
> 
> Now that I have this series, I found the first patch to be a duplicate
> of
> https://lore.kernel.org/linux-spi/3eb3f9c4407ba99d1cd275662081e46b9e839173.1707490664.git.chunkeey@gmail.com/
> . Mark claimed to have applied this patch to his for-next branch, but
> it's not included there yet. So I kept my version of it to please the
> build bots. (Also my patch has a Fixes: line, which Christian's doesn't.
> Up to Mark what to do with that.)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: ppc4xx: Fix fallout from include cleanup
      commit: 6f98e44984d5eff599906c0376c027df985bf38b
[2/3] spi: ppc4xx: Fix fallout from rename in struct spi_bitbang
      commit: de4af897ddf242aea18ee90d3ad2e21b4e64359c
[3/3] spi: ppc4xx: Drop write-only variable
      commit: b3aa619a8b4706f35cb62f780c14e68796b37f3f

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


