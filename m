Return-Path: <linux-kernel+bounces-123960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D87891058
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507B21C251B7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9747D17576;
	Fri, 29 Mar 2024 01:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWhQigQS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB47B210FF;
	Fri, 29 Mar 2024 01:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711675753; cv=none; b=Ly7i9GjSriDaMzCOIpd6Gw3FiRlvu7r4AA4bQp7P8FJBydYWQKdcql53vAsKNlqrY14N+RVrg960qveBGcNPa0+DprPzq5pkqSbn3I58JDeURPCGZC7mm/ekdHw8MQ3JfcCK1U8RDz6dvlU1vxFXtvbJboLLnwMEORSSPOY3HNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711675753; c=relaxed/simple;
	bh=+ZY7WEsxjP6rlGieOxxT7UepK0iCVMmm6RlxtaqE0vc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gmOidRSZS0lj4sGwTBoz5SGgyVa8zFA7DuzOw7U37wnMjUbyALVwal/NWePKmKuFKxoQeu+hPv+0zrK2XT1bOolWY7ZvyypDDWp16ZFGRBGw/NZ/T81dJxQ5lgvbfdFfdBcyS1hvS6mM6yVkjxh3TZWWaQ8L0y717fgOPu+0BbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWhQigQS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C40FC433F1;
	Fri, 29 Mar 2024 01:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711675752;
	bh=+ZY7WEsxjP6rlGieOxxT7UepK0iCVMmm6RlxtaqE0vc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CWhQigQS05EL6bL8uK3cD5cNoogw/E+cJgVWENEkF0T8YXxfxnoefsHXLrPBy3Ezz
	 Wt2mlG3TFKm36JmyN5Deqf8Etv9bbujQtMpovYCDltTPlqRmc6p2mTjJc3rHWvVE7S
	 Fe78F696446a2oHQYHBn9Hcbc6/4nyjfsNkBMOjtmqT9VEArZx9Pd7N8YvYiFDoIdP
	 ShwI14u5Qxox5ImiPVEg/iqyFAjxyWhgxHWpCcpwYbfVlTjHhBybfQRg3s3Ad0FSDA
	 hgMaN+FE+vpPbl8tuBTpT+jO8ggCdyl1h8NXpqBMS+vkIkMrWpNq7ZIgoMPBPsrYUa
	 K7pLl4rsgUNmA==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Daniel Mack <daniel@zonque.org>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>, 
 Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <20240327193138.2385910-1-andriy.shevchenko@linux.intel.com>
References: <20240327193138.2385910-1-andriy.shevchenko@linux.intel.com>
Subject: Re: (subset) [PATCH v2 0/9] spi: pxa2xx: Drop
 linux/spi/pxa2xx_spi.h
Message-Id: <171167575036.187521.17547262230962160149.b4-ty@kernel.org>
Date: Fri, 29 Mar 2024 01:29:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Wed, 27 Mar 2024 21:29:19 +0200, Andy Shevchenko wrote:
> As Arnd suggested we may drop linux/spi/pxa2xx_spi.h as most of
> its content is being used solely internally to SPI subsystem
> (PXA2xx drivers). Hence this refactoring series with the additional
> win of getting rid of legacy documentation.
> 
> Changelog v2:
> - dropped applied patches
> - added patch to amend dependencies (Mark)
> - amended the second patch accordingly (Mark)
> - elaborated purpose of the patch 6 in the commit message (Mark)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/9] spi: pxa2xx: Narrow the Kconfig option visibility
      commit: 3af201a405b3e5abee65102b062c309fff68cc0e
[2/9] spi: pxa2xx: Drop ACPI_PTR() and of_match_ptr()
      commit: 9907c475dcab9b269422972577360122129ac84c
[3/9] spi: pxa2xx: Extract pxa2xx_spi_init_ssp() helper
      commit: 7290f1e4075d28ab961df5a454503296fa289271
[4/9] spi: pxa2xx: Skip SSP initialization if it's done elsewhere
      commit: bb77c99ee6d3d704086acf141d3ec92601747809

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


