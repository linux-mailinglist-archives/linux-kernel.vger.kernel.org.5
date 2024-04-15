Return-Path: <linux-kernel+bounces-146015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7608A5EA3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 01:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0464D1C214B4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CC115A4AA;
	Mon, 15 Apr 2024 23:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbbZ4ryy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219111598F5;
	Mon, 15 Apr 2024 23:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713224600; cv=none; b=HqwtA0TMOWol+BattzfVXkGStOoD/BwCP2YKQ1+wdAVoXjJu3fEyXM4W7vJt3F/h5kYvWiMXFYk3oZGVdtZBWxI80V8674gE9ugucM7l1lyvkZCWdVuNipm1HDwPuhJaQPSYBpm2UUoOCkEWNb9VYmvt7DnQTRTiIWNWxSnikaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713224600; c=relaxed/simple;
	bh=wVLCQH03zMCpvvYBm80Mf6FcDs0FL3X0KCWOZanWBrA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Cci3RZL7wcSgBKPrHdtRBKNtPFHktd8lnvZkcxp9gwKjZIUyCe4tbXB9OZ7Ys7UsaSGrgjrqPRzM1HaX1Qdfs8mHcV4Ze59Awt4b+yIAp2l6ETvt1dNaVDFn7FrFfDe6YsKNVClur56BhY5icSUlTFhTka+aXxogme4fSXMPDc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbbZ4ryy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37D8C113CC;
	Mon, 15 Apr 2024 23:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713224600;
	bh=wVLCQH03zMCpvvYBm80Mf6FcDs0FL3X0KCWOZanWBrA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kbbZ4ryyu11MW19FvJ9jUndLACbRksb2BuS61KIpR/Aw4KQKcr3qvRBsYbuhLkM9n
	 y888VYCGW37j681+V4XL8J3ebtXWzgTcWQBp04ZK2kajYzglZyv3371x/S0RBPCv7C
	 AgVJeimaLxBZ9rsAjsSPD00maP28yxWc1yeoBuptXO8XL+kZTGMLGz3GVKp81hS5hK
	 9QJ69bMTEf9kriWX7wQSDoV7eyGL9BaxBthj2vdgSz28oTBewJHPLPBmxh6aqtLw7x
	 XswfY9zO4WtI4iHBUUBo7y8z9wOCpt9dtOKp8ZWR11gj2n0fKk/qi3QNHdvz0n1C01
	 iM29ZwwP0b1gw==
From: Mark Brown <broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Daniel Mack <daniel@zonque.org>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>
In-Reply-To: <20240403171550.1074644-1-andriy.shevchenko@linux.intel.com>
References: <20240403171550.1074644-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 0/5] spi: pxa2xx: Cleanup (part 2)
Message-Id: <171322459793.1659222.10419494148665071975.b4-ty@kernel.org>
Date: Tue, 16 Apr 2024 08:43:17 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Wed, 03 Apr 2024 20:06:34 +0300, Andy Shevchenko wrote:
> Here is the additional cleanup of the driver based on the fact of
> the linux/spi/pxa2xx_spi.h being a local (to drivers/spi/) header.
> This means it's based on top of "spi: pxa2xx: Drop linux/spi/pxa2xx_spi.h"
> (20240327193138.2385910-1-andriy.shevchenko@linux.intel.com).
> 
> Andy Shevchenko (5):
>   spi: pxa2xx: Move number of CS pins validation out of condition
>   spi: pxa2xx: Drop struct pxa2xx_spi_chip
>   spi: pxa2xx: Remove DMA parameters from struct chip_data
>   spi: pxa2xx: Remove timeout field from struct chip_data
>   spi: pxa2xx: Don't provide struct chip_data for others
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/5] spi: pxa2xx: Move number of CS pins validation out of condition
      commit: df3431fd379dcc3b231bd109a55948c27474478d
[2/5] spi: pxa2xx: Drop struct pxa2xx_spi_chip
      (no commit info)
[3/5] spi: pxa2xx: Remove DMA parameters from struct chip_data
      (no commit info)
[4/5] spi: pxa2xx: Remove timeout field from struct chip_data
      (no commit info)
[5/5] spi: pxa2xx: Don't provide struct chip_data for others
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


