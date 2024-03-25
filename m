Return-Path: <linux-kernel+bounces-117926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B60CC88B163
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 561E71FA3D4B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA5E4AED8;
	Mon, 25 Mar 2024 20:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AecH4+Dk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D236B1CA9C;
	Mon, 25 Mar 2024 20:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398600; cv=none; b=pqL54PonriB5aFie8UoHMrdEfJaOYS+AKgOFAfZnTaRX9U/S6Ex8k8YWA4LL0o5VjnEyIePMqUi05k1BbhjGwSJmKZbXYuFa/isR9KknrtJ0CZGWjBu7s9zSr4X2n8Br9S6JkyjwODbCHMhZ3m5h4tHLMGIo9USK4mGmPXE7siE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398600; c=relaxed/simple;
	bh=lrr4+ppJcp5gWUTaLbGP8lFAEnh7fXbPFaiOylMKrlI=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XRzpyt4pg1tOfK/Q+PGTG83lTizyN4D6jRnUA83PoL3423UiwM0lXOCjAeQk28Gsn7SBKtGBNK4IY5N4QqltL1MsHRBWeUfmbHNN7l0XL27KXE7eQsEb+M5p4Qtt2ZgHmgkfhdHXgbpvpxBAMjyvg+kY1z3T38FeXsXtp24o46U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AecH4+Dk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09D1C433F1;
	Mon, 25 Mar 2024 20:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711398600;
	bh=lrr4+ppJcp5gWUTaLbGP8lFAEnh7fXbPFaiOylMKrlI=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=AecH4+Dk5qRpVMiWIPL7WTT9lK3mgDGw9GWAVqj2K7eRPsYEz93p2xMAgCJnV26LI
	 Vpndspc1t1Zr/ayGtVYGsvHdg3C6rIssI79gdh2dA0jgeIJtP6QMFqyC/b0yVRSYDr
	 bkOo0sl0F7cTO4WnZl1OSoLYE7mBpmMXymsaRiECrhyOPFoFYkk2GJjMB0hbnc+dan
	 D+7VJJYxfkfYle+Git9NqE10cG2CiAtZwdym3/MnqhsQT4ib1vrokBwkZoGCxytcs8
	 xpp7XdOuC+vH3EqgBiKqMShCTOYHcNFf0evzUDUwk1N8opRtms/8Jo6BQ8Xm9tk/Hs
	 3BHOuBmsPYyiw==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240307155045.3796045-1-andriy.shevchenko@linux.intel.com>
References: <20240307155045.3796045-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] spi: rspi: Get rid of unused struct
 rspi_plat_data
Message-Id: <171139859945.356390.17578572917727208884.b4-ty@kernel.org>
Date: Mon, 25 Mar 2024 20:29:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Thu, 07 Mar 2024 17:50:45 +0200, Andy Shevchenko wrote:
> No in-kernel users of struct rspi_plat_data. If required,
> the software nodes should be used for such users. For now
> just get rid of it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: rspi: Get rid of unused struct rspi_plat_data
      commit: bdeef5dcea6b164f4bd614655821b1ef12ebec9a

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


