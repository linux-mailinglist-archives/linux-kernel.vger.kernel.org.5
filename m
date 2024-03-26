Return-Path: <linux-kernel+bounces-118993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A69B988C25D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D905F1C3FACA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6AB6D1B4;
	Tue, 26 Mar 2024 12:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhZgXhq9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6BF74433;
	Tue, 26 Mar 2024 12:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711456756; cv=none; b=I0BejhXqZCPVZcDOOZPAAkR0GIw3Xdvha0SfqtAZPyyENeGcc8XweqnfMroQTHwyFgGQxFZtXpucWj/WFpSiD/RaA9setbfU+kcgRtXceEKUIpPm1IOPUicPsTKWJlp8cIw9et2WyMrtPzQ+K8R0Rnqa/plfyTwLj4vwbDn/wLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711456756; c=relaxed/simple;
	bh=PeBXwtgNfaA/g4snk0iz4a05C6gmP71r6AzRxNVzSj4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qhJaBpW/FC5lAxYD8TeanT1rEvKRgtvp2sN3fiqtH31LIzYd2dpwmVSlEQZxWE0ChCTgxCFkAGhrKVHVqfHd43nLQnWuMnc65scRnSNcOrjlq3PrF22XTFcn3PA5W0d2hg2SKOjAUY0OTVWHZXPnLaJgJWzXOcU81JROmZ8/1uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhZgXhq9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC2FBC433C7;
	Tue, 26 Mar 2024 12:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711456756;
	bh=PeBXwtgNfaA/g4snk0iz4a05C6gmP71r6AzRxNVzSj4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qhZgXhq95nLRv8B7wn7d4/BdpU6rqjDB6Ge5FWzgRhYskZb/fC7h8KJAGsy9oYndp
	 AuBEGXuPSwWnL12I+vO7AjK/yBQnMlo1o9/YxJ4ZxuArn5lUDtghk1mIXBhDJLB9YP
	 M0se5ugF8jA6rQBC0NTn2rhqQk10GO7z55YH0GI0u1X4bGIJmz6lZ8q1JSfBf8n3AC
	 aiPXux7mpCijqCCCg4h9fEldenisew5WWcBjUVCxMTgPQjLK8Kcv/GYEucp4HWcqa5
	 jSZ1j33OxcoNiz+tCcV1tQz5xB+FT5OIogPRZVINZqqg+GY7iOBjEH+PaEpsTnMf/x
	 DRJGF7B/30BSA==
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Daniel Mack <daniel@zonque.org>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>, 
 Russell King <linux@armlinux.org.uk>
In-Reply-To: <20240307195056.4059864-1-andriy.shevchenko@linux.intel.com>
References: <20240307195056.4059864-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 0/3] spi: pxa2xx: Clean up linux/spi/pxa2xx_spi.h
Message-Id: <171145675351.65249.10757954736069645808.b4-ty@kernel.org>
Date: Tue, 26 Mar 2024 12:39:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Thu, 07 Mar 2024 21:47:44 +0200, Andy Shevchenko wrote:
> A couple of cleanups against linux/spi/pxa2xx_spi.h.
> 
> I'm sending this as v3 to land in the SPI subsystem. Meanwhile I'm
> preparing an update to make linux/spi/pxa2xx_spi.h private to the
> subsystem (PXA2xx driver). But the second part will be presented later
> on (likely after v6.9-rc1). That said, this can be routed either via
> SoC tree or SPI, up to respective maintainers.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: pxa2xx: Kill pxa2xx_set_spi_info()
      commit: 7fd54c205f104317b853fc417ac7e9d0b9531ddb
[2/3] spi: pxa2xx: Make num_chipselect 8-bit in the struct pxa2xx_spi_controller
      commit: e3f209e269d32ebc0ba7f497f5d2af21ed4f0dd0
[3/3] spi: pxa2xx: Use proper SSP header in soc/pxa/ssp.c
      commit: b5867a5c0d7a6bf36f59f3d472c7aed33ca4d02c

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


