Return-Path: <linux-kernel+bounces-58708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A645C84EA5A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4169CB2CA55
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F72B4F885;
	Thu,  8 Feb 2024 21:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bELBbe4B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6A34F611;
	Thu,  8 Feb 2024 21:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707427315; cv=none; b=puStxoSEiD0F6eFtVvwu7L0uK+piij16QFNmGsIdL7NQHaA7pXN6wBuOOoeZ96nbrwPCsiekEPCvrE5PniY8d7ehzdhuXekPnJHDNp42cvi4xVYIgxxiYQy4+6tGpzY/ni+5pET1TdsbLp6Xiu4tB5xIAa2QWYYQHHHAg65FpiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707427315; c=relaxed/simple;
	bh=NX0tYk5CLNYg4krU2uUyBI/HY4KfbV0qoUFrOddf5fw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PzFh/aZpoof6Y+9yPwpl+4lx7wSUQPd3B6kN4cP9gOlz3nYT0ZOzPCn0IyyJLX9jGXKg+64TjdSXomFtMRUmHlVOjQ/gPO4MOt21VxK5GtHSYT1PK3EPCuPDr1VhRV1fWy8HhWN5X2kOIa5afK3wvWLtJNUcaEHrLvV2yKyhyQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bELBbe4B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14B2C433C7;
	Thu,  8 Feb 2024 21:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707427315;
	bh=NX0tYk5CLNYg4krU2uUyBI/HY4KfbV0qoUFrOddf5fw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bELBbe4B+OleB/Jtwm5HgZz1RBiChVuzY2CYLCceTsEqH3vAY2B++q7cJWRVGwVR1
	 LNSsC1eKPZOjV+qIIxgIizUR3bZvJii0ujvXPqs9rB7Ozjiv3Loitz5wuhk0Aq3VYg
	 gUEFNCt0xY5mPcPeBNVQ8+5SAFW0OwMSYKeawlFcHjMpcfjQBFmONtMP64xzKMvRu6
	 4HUdK3Z5BiEor7thgQpb7TPysXr1KoIU1ek6lYwV5MajHUIpVGoDdMJOHdEpUvEW2g
	 27UWI2BvBtvCPoA0rv2XTJyzo9p66KAoIC5iJOsosTIQO8RWhd1/F+eT36X3Gbp8mC
	 EDC5A3oaCTq9Q==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: UNGLinuxDriver@microchip.com, kumaravel.thiagarajan@microchip.com, 
 tharunkumar.pasumarthi@microchip.com
In-Reply-To: <20240207080621.30742-1-thangaraj.s@microchip.com>
References: <20240207080621.30742-1-thangaraj.s@microchip.com>
Subject: Re: [PATCH v3 SPI for-next 0/3] DMA Support for SPI in PCI1xxxx
Message-Id: <170742731351.2266792.10091004097755614677.b4-ty@kernel.org>
Date: Thu, 08 Feb 2024 21:21:53 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Wed, 07 Feb 2024 13:36:19 +0530, Thangaraj Samynathan wrote:
> This series of patch is to add DMA Support that improves SPI Performance
> in PCI1xxxx. With DMA Support in 20MHz clock, the performance is
> improved from 6Mbps to 17Mbps.
> 
> v3:
> -Merged Tx and Rx DMA patches into one to avoid unidirectional dma.
> -Changed naming from DMA read and write functions to from_io and to_io
> to avoid confusion between DMA and SPI Controller operations.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: mchp-pci1xxxx: Add support for DMA in SPI
      commit: 3e7cfd6ad29a7483ce3addebb4fba87d6409c71c
[2/2] spi: mchp-pci1xxxx: DMA support for copying data to and from SPI Buf
      commit: 9538edeb72c989a4b90964ae4bba107eaf21a791

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


