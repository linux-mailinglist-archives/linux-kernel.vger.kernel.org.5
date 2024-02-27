Return-Path: <linux-kernel+bounces-83829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF75869EFC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 459FF1F2CACC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4803614939C;
	Tue, 27 Feb 2024 18:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrvhWE6m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849BE3D541;
	Tue, 27 Feb 2024 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709058026; cv=none; b=htNmNzDAupE1OZ0Jmv0bNAl296R7/dzk8IfP45RIccBUgMCSzDw9lLtGQSyP4QJtqKpotU0cxuiOv5YB/5lxrPcL871IqPUZVm+VcQPwrgeqGa78PnS6B9A2PaKw+l2vTfUC7T9jMyU7TCGrIUu8QA5qrCyuaCoTLx00tX/nQQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709058026; c=relaxed/simple;
	bh=fVSm/DRx0dmubQfJFUjQAcvUkJEK9QkO4/q+Kz5PYCg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ekuvfU7pWny5ARBqxbkIiGzqkVZ+m4WT3/MFkNoUvyl2bWL93S5fz3URFc7GIhndJyBKwZKMP45YiiUifMB+x3/5ythvC8TOr7aXLssdBvhskytRRyazOLzvzlPSnbrTtCrmqSz+sE6LXQghLtRo9D5T2s3IbCT66Yw26/C8LbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrvhWE6m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B830C433C7;
	Tue, 27 Feb 2024 18:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709058026;
	bh=fVSm/DRx0dmubQfJFUjQAcvUkJEK9QkO4/q+Kz5PYCg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jrvhWE6mUIAI69S+AGfoj2LeqswPvs2t0NtM8IlYWXXE6UWzvQJSKxUhcxPZ1KDmB
	 XSGPM+0p19SGvAD6zMP84DQQDCAgKH8DvFv9LTaaXAZrhx7n4gw20oFLNqLK/qLFzJ
	 QFVXd6lwRt43cWLRMuh9GzCDWdN7efPY/U0PFwOK4V6aF/HW8WasM6DLg7ZvBOHWDL
	 Wp1CpCLX4FiuKLs3WpXR+MWxjnj3v4HfmWvII66YW8FdLnmLqbVFfdpg44OO6EXVHt
	 6iVzLRzP3Re/G6XrDoq6qGpw4LQIhPIdK0RGZGj6Vz2cq+sN0ODtUpe8T4dNHsMa8x
	 Ug1kQcxODYU0Q==
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: kernel@pengutronix.de, Rob Herring <robh@kernel.org>, 
 H Hartley Sweeten <hsweeten@visionengravers.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Stephen Warren <swarren@wwwdotorg.org>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240210164006.208149-5-u.kleine-koenig@pengutronix.de>
References: <20240210164006.208149-5-u.kleine-koenig@pengutronix.de>
Subject: Re: (subset) [PATCH 0/3] spi: ppc4xx: Various fixes
Message-Id: <170905802417.158350.17718365594431349151.b4-ty@kernel.org>
Date: Tue, 27 Feb 2024 18:20:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-a684c

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

[2/3] spi: ppc4xx: Fix fallout from rename in struct spi_bitbang
      commit: d748b48eeba8e1a10c822109252b75ca30288ca0

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


