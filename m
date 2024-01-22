Return-Path: <linux-kernel+bounces-33719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D26836DA9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E81A28D1D3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CD840BE0;
	Mon, 22 Jan 2024 16:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWTMeRWX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095873FE5C;
	Mon, 22 Jan 2024 16:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705942172; cv=none; b=aejuxy/TyWftbOCoeQRfCYN9Mk/SwuUvrY0biQ+0yFt6OZs0f2C5uxiGe0gURCVirVKwNyJN5404pUiNT8k+3AFNJgweRlzAI5WXUKEi0pGgIpgX+Owt5WQatCsZQbpuK6M3kGNHOmiZH+fkG2nZPCy5Y3P5heFov2zRMEZ/eVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705942172; c=relaxed/simple;
	bh=x+kqQBeRWGqBpGnMfz3kZ5ztY8IFHHDlodUXpyS34lM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iKeFvkJ2BcKQc6a3+Vzmc6bayNQDmDv1cZ4wHzLbFp1MzW9H/MLsZfx4LShPP96xh0so8G2beRfjv5AHwcUILXukVkkdnKSfAmAdJU3WTOjFEG/umnWTXxWhkdrNeaiLw+ksG/3EeJxLkhFXXvr5hBOZXFub80e0q66PHCy2tVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWTMeRWX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3381C43390;
	Mon, 22 Jan 2024 16:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705942171;
	bh=x+kqQBeRWGqBpGnMfz3kZ5ztY8IFHHDlodUXpyS34lM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DWTMeRWXDnqBvs9qUvHkQdz6bFhzkAE+o4QI2AYUwIsb94EEP1RfheuS+AXLE1j8l
	 zhH/5/HMNS8IPxDPyG2nGkqE8cC1sQw0EZ5vvy+cuUjdkH2ABi4XJ7xRuNPra4Lvx2
	 1AIkN2IvLj8ABZTzqQp5VlOGgo9AdsvlT2xC4u5C0YcUZaVSh/Ys8/xLmMY0v0j2mP
	 955Yo8MmkVGC2KrFADbhXt3zOMk/TCeD6+6Ure+p/JAx8YgMmgzOtNCDpxuePzncQn
	 nLTLTaUZX5Z21z6C5kNk/V6sqEVitzLClrMl4oFlpiOyI6bQpHpB5ZTVpUdaq4DWPh
	 3YV9bQ+QUQSfA==
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <2024010549-erasure-swoop-1cc6@gregkh>
References: <2024010549-erasure-swoop-1cc6@gregkh>
Subject: Re: [PATCH] spi: make spi_bus_type const
Message-Id: <170594217051.69518.5102831468938210095.b4-ty@kernel.org>
Date: Mon, 22 Jan 2024 16:49:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Fri, 05 Jan 2024 11:32:50 +0100, Greg Kroah-Hartman wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the spi_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: make spi_bus_type const
      commit: 6df534cc7136fc9e023cbd4e0011a04e3659e74d

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


