Return-Path: <linux-kernel+bounces-140398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3248A13E4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C6441C2142B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A86E14B071;
	Thu, 11 Apr 2024 12:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/0021Bd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93520140E3C;
	Thu, 11 Apr 2024 12:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836994; cv=none; b=nFhqVQ7qIHohTSWqC0Kp9BuT9Wgnxyw7fafU5SrqTWhk78SPgAH/q3CM4BUqCy/2dNb0DPazPgrXx6vAdjHoAP8MafUMpCsvhqKSuVy0PSBDJtK9iBo6auVNcyTH/nCkVmqWsAG3vzWCqqZ2L0CCgRq8EgqDlgizK1H250qR0vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836994; c=relaxed/simple;
	bh=nL9f2S8UZ4KVTsuWcIhw2zuRANiF6mbd5sOWnMoueFQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qtC9B9xVLB7B/ZXndmrfb2PKvnaTzupTdc26fmO4Zg52tKiwHDZTZhajplYkrIQ5SBrDGOnk70YGY49ijByCgEzddxJHUy6pgVY+eoLtHoi7YzrpSeOUTjEXSf0mRWawFPoj80IGRRGR0HJZDyFtemBbujSznPLbmXeF9xhIR80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/0021Bd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C85C433F1;
	Thu, 11 Apr 2024 12:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712836994;
	bh=nL9f2S8UZ4KVTsuWcIhw2zuRANiF6mbd5sOWnMoueFQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=W/0021BdskERYdkTfh1jLdhIBilHqvxAORF5B+ExNQ3XfSTi+OyHiwJ09adr7jN93
	 0KHUpheGwPYxY4gN4wOlcpqC+eMifuuBe90ellHh29cub71H5zv+ZEJ0jpEbaC0QnT
	 JcQMbEXs0XxwhxQhleoPLn2qwpX2sQBZaQjL9BvCHaxtSvf90x+bKryEly8qUVsqa3
	 iv70ImT88uf7kJfS9HyXSgls7vkrwSUh9GLiAq6bBCgYeEnqb/rB2c2nXBak8DY8Hg
	 0jeSMRTuL6ZlsdshueukOk09RItvoEwBiKQQInoC6UYdHbeP2h2DPdQqYy+6p3jNG9
	 s5VzoBS+GKWEg==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vaishnav Achath <vaishnav.a@ti.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Rob Herring <robh@kernel.org>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240410-cdns-qspi-mbly-v3-0-7b7053449cf7@bootlin.com>
References: <20240410-cdns-qspi-mbly-v3-0-7b7053449cf7@bootlin.com>
Subject: Re: (subset) [PATCH v3 0/9] spi: cadence-qspi: add Mobileye EyeQ5
 support
Message-Id: <171283699002.32012.7629247540689477794.b4-ty@kernel.org>
Date: Thu, 11 Apr 2024 13:03:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14-dev

On Wed, 10 Apr 2024 11:29:03 +0200, Théo Lebrun wrote:
> V3 of this series adding octal SPI-NOR support to Mobileye EyeQ5
> platform. It has been tested on EyeQ5 hardware successfully.
> V1 cover letter [5] contains a brief summary of what gets added.
> 
> There is no dependency except if you want zero errors in devicetree:
> system-controller series [3] for <&clocks> phandle.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/9] spi: dt-bindings: cdns,qspi-nor: sort compatibles alphabetically
      commit: 002514d91fccde2adbe750c9ec5c6207d56c890b
[2/9] spi: dt-bindings: cdns,qspi-nor: add mobileye,eyeq5-ospi compatible
      commit: 52826aee484b3ebb6ed94c1ae89c0944110ed8b1
[3/9] spi: dt-bindings: cdns,qspi-nor: make cdns,fifo-depth optional
      commit: eb4fdb4bf46f875eac3c093f7ff43a223985f7b8
[4/9] spi: cadence-qspi: allow FIFO depth detection
      (no commit info)
[5/9] spi: cadence-qspi: add no-IRQ mode to indirect reads
      (no commit info)
[6/9] spi: cadence-qspi: add early busywait to cqspi_wait_for_bit()
      (no commit info)
[7/9] spi: cadence-qspi: add mobileye,eyeq5-ospi compatible
      (no commit info)

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


