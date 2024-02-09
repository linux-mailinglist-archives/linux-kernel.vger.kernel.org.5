Return-Path: <linux-kernel+bounces-59959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE4C84FDEB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D1C9B22B1F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E2B1096F;
	Fri,  9 Feb 2024 20:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMBikLLK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33476AB6;
	Fri,  9 Feb 2024 20:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707511739; cv=none; b=mGwLI0x8clA13hcrNafGUUDVN7AXAYzW1fSv66oGXNcqJsbCuE7sVB593zCQBX4CPM+aGO9kjAd3/0Ee0JJFuexqDpTpQKbLGe3eL/19ZnncMmwFm31ofQMjA3WVAmcnRXsmLSGQgE4/U0zaXCirZqqIFSI9hIYwF/3XNHEBZx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707511739; c=relaxed/simple;
	bh=aMm3jCAmscam4Ca9yc9ljuMQxNCTZtcYAs3R9F/qeNQ=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sPqgc/X6tuQWouvbni6iUMMQ+gRSshwkTM+v6BTfznHWnFQ5oqnDo34lnuQ6TdrTz3bIHo/50Ulh8HhXDIOE4DfHk935PvllOEnTo0YdnEXYpHFgkydu4mFCPoyCxhA8/aV92GeioObABYtODo2UtRIttBGSHbKN7aK3j0wfoRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMBikLLK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82901C43390;
	Fri,  9 Feb 2024 20:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707511739;
	bh=aMm3jCAmscam4Ca9yc9ljuMQxNCTZtcYAs3R9F/qeNQ=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=RMBikLLKkWHJZl7TN7ucFe1QvTOJMHwLKrOsNT930VQzj4NVVnItNcJ+B4v4nvAEB
	 WnxJWfLpjECOoI0Xmu4qj5uhwgbJfjL7pTQHmPAdHORQRJ1STrGlOkh6pssygV71WQ
	 WjP6OHRAK1Uo2OalBc2bcheelgSIpFRM33rlK9ttZFcMEnGu0OuniCygEdFZzMCP4I
	 WhiZUK/3ZT0rrQOFxz5MLYUUh2HUP7opsClCu/dTj4l1hAqXiS+5EhRvllG/Xu6T/P
	 JkvMgpTO8Jnoug9Ns6XRln5mwYjXlwvpqXHwS2RQiANlT/AhivltfgPrfUWUJBxda4
	 xhKSIWyW9R15g==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240209165423.2305493-1-andriy.shevchenko@linux.intel.com>
References: <20240209165423.2305493-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] spi: gpio: Follow renaming of SPI "master" to
 "controller"
Message-Id: <170751173815.2414604.18398970608323344488.b4-ty@kernel.org>
Date: Fri, 09 Feb 2024 20:48:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Fri, 09 Feb 2024 18:54:23 +0200, Andy Shevchenko wrote:
> In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
> some functions and struct members were renamed. Recent work by Uwe
> completes this renaming. However, there are plenty of leftovers in
> the comments and in-code documentation. Update them as well.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: gpio: Follow renaming of SPI "master" to "controller"
      commit: fc5b764bef24d0cf722deb5c1a44948cd17d4afe

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


