Return-Path: <linux-kernel+bounces-119959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE7688CF6E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D9161F32EE5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFA612AAFE;
	Tue, 26 Mar 2024 20:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJZWbeJP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81733EDF;
	Tue, 26 Mar 2024 20:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711486503; cv=none; b=q86t/aG3Uz6u2stSedJ+fbtvHJdC8Bf/gHh6QH6U3ZpYyuJzzHV8EXlSJyCxlyVjAN3Q0HSiCIwJUXXaM9UNo85tIcpty9Sz2ZhKwXoomjaBu7F2QDOCG7uB+hEYqwTBsTwJUx1GEfQ/WyWnkSceJid9DLl7P1/K902UYG/iFJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711486503; c=relaxed/simple;
	bh=6UED1DuBXDFLDIlwXk5lac5pJViHxSdwaTodCx4UgWI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nBSEFxkOVOGFmHz5EvcHF1tqfYP5ZbL0qiJXI7Je7w6Q7T/x4ZWELFn8KdJEEvDibL1hVfTdRnxr9eV+BtoMCsyMRNEJu/L/AOzDnUV1Uz0zk29IqElOKygQRYfNcPH2G09fUL4mru9Q3xjPK4dajBstNkvhK2dk5CZ+ySFEarc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJZWbeJP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50EB0C433F1;
	Tue, 26 Mar 2024 20:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711486503;
	bh=6UED1DuBXDFLDIlwXk5lac5pJViHxSdwaTodCx4UgWI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mJZWbeJPV7hGF6RU0lA5z//aN3h5gPEJtX3/Z7noHrkTSGK3t+NH4zRb518eKbtH5
	 fsuj/uKmfgrlDJUVWVsCRi304we4//rdlssURXBliK45lpOeL40IUp7Q1ujl/jnhbK
	 eaW8RyT8NCCxIekdcce2BtfmaFu+4gCDD6Gv97NTMb+UGV1QSF0USoKzEo7ID+aziJ
	 jZEd5B3bYI3U+hethAv92FiS5jfNE8g/YKOgrciCOrYKMrwC6T9WxtO1EeSdE3NkdM
	 869FYrMKi/u11QG1XBl4zCIkpV2XT/Iip7RxdXwhSDJmFFmpM48Ubl32RbVJMCGaET
	 tFKDoSANT1mJw==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Daniel Mack <daniel@zonque.org>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>, 
 Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <20240326181027.1418989-1-andriy.shevchenko@linux.intel.com>
References: <20240326181027.1418989-1-andriy.shevchenko@linux.intel.com>
Subject: Re: (subset) [PATCH v1 00/10] spi: pxa2xx: Drop
 linux/spi/pxa2xx_spi.h
Message-Id: <171148650105.211121.16181693472480434734.b4-ty@kernel.org>
Date: Tue, 26 Mar 2024 20:55:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Tue, 26 Mar 2024 20:07:50 +0200, Andy Shevchenko wrote:
> As Arnd suggested we may drop linux/spi/pxa2xx_spi.h as most of
> its content is being used solely internally to SPI subsystem
> (PXA2xx drivers). Hence this refactoring series with the additional
> win of getting rid of legacy documentation.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[02/10] spi: pxa2xx: Keep PXA*_SSP types together
        commit: dad983d8812975b53db83f02ae6b0ad15f018a9e
[03/10] spi: pxa2xx: Switch to use dev_err_probe()
        commit: d5449432f794e75cd4f5e46bc33bfe6ce20b657d

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


