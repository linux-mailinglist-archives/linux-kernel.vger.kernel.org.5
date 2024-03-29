Return-Path: <linux-kernel+bounces-124666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7292891B2C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A36D428BCC1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B140D16F271;
	Fri, 29 Mar 2024 12:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uoXgVs5/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EF916F0FF;
	Fri, 29 Mar 2024 12:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715661; cv=none; b=H+JtD5Y3Rire78tN1RLMF9Si94hToKzsFqf+gbtn2KE7qQ+oT66OsEOezuQinQMPm7WreRLbbGtmco1Gmscoe/Piuk4SwWO1zC1uGyXTKaaZBLNrRGEOcI9N5OJdXGT7jnv6SZWm4G+ZW1uPU3dcy/GizoHNhJezTcX+LyPGhVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715661; c=relaxed/simple;
	bh=MZQ3qOHSd8N8zCilE9VhLvAhy0edj/JTTJ8t/X1AVKA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rFs3xMcBLIaFhaEXk8n0KLQL49gT7th7XP13E++cjHL8tXPPYs1NIQMIqyGG+OHT6XJROvSi7CjWAMlAYMTYbKFJp8u1jFQMhM8mF7dpH9iu7y+rMFmNXuaKtoKKgB/sNpxkmnRKf07re3NPIfMAK09IFFmuiEhe/QxlfDSRLNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uoXgVs5/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5798EC433A6;
	Fri, 29 Mar 2024 12:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715660;
	bh=MZQ3qOHSd8N8zCilE9VhLvAhy0edj/JTTJ8t/X1AVKA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uoXgVs5/fyVnsoBtpZ6mRPaYJ0eyGNnLSvl9PTmKfbOQmAR84Kw02esHna1nBd4Rd
	 ekCg7dgtEY45JWjj/EvZOcu0YeCL9X+fvbukaN0sTTOdC+SkXfLWQ1YW2BrXTMPw54
	 5vTIJqRDsFixPxKIEL51rH9Btxu8mhkHaLBfit7dqhP/lH7T5cmN5TRvoKHHg/OxBb
	 1xYX9+v8xiHp7HYxpovz2zMZ15QOWyGBtlr/tCBrDh10/KL7HpSPdaPfq532d6wx9N
	 dZmtkS8Fch5cg8+0SNwrvnm1yRbyF3Zvitfj6UMh45QrMF0+zLwE49/8gJjtSws6nk
	 cmFzja8x1alxg==
From: Mark Brown <broonie@kernel.org>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 thomas.petazzoni@bootlin.com, Miquel Raynal <miquel.raynal@bootlin.com>, 
 yen-mei.goh@keysight.com, koon-kee.lie@keysight.com, 
 jeremie.dautheribes@bootlin.com
In-Reply-To: <20240327-spi-omap2-mcspi-multi-mode-v3-0-c4ac329dd5a2@bootlin.com>
References: <20240327-spi-omap2-mcspi-multi-mode-v3-0-c4ac329dd5a2@bootlin.com>
Subject: Re: [PATCH v3 0/3] Add multi mode support for omap-mcspi
Message-Id: <171171565909.8069.14365505303739525487.b4-ty@kernel.org>
Date: Fri, 29 Mar 2024 12:34:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Wed, 27 Mar 2024 09:43:35 +0100, Louis Chauvet wrote:
> This series adds the support for the omap-mcspi multi mode which allows
> sending SPI messages with a shorter delay between CS and the message.
> 
> One drawback of the multi-mode is that the CS is raised between each word,
> so it can only be used with messages containing 1 word transfers and
> asking for cs_change. Few devices, like FPGAs, may easily workaround this
> limitation.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: spi-omap2-mcspi.c: revert "Toggle CS after each word"
      commit: 67bb37c05a6b56e0e1f804706145a52f655af3f1
[2/3] spi: omap2-mcspi: Add support for MULTI-mode
      commit: d153ff4056cb346fd6182a8a1bea6e12b714b64f
[3/3] spi: omap2-mcpsi: Enable MULTI-mode in more situations
      commit: e64d3b6fc9a388d7dc516668651cf4404bffec9b

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


