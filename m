Return-Path: <linux-kernel+bounces-124664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89272891B29
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43B2128B8CC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4D416F0F0;
	Fri, 29 Mar 2024 12:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXatLA2W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E8416EC16;
	Fri, 29 Mar 2024 12:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715659; cv=none; b=gM+B7SevJg9khiIdsfDR8pKSmYEIo3Ifj12T802TGj33H00GQTiI1Il4akcRG1H/pJwjV0XRF2zaQQu2av6b3D2ze4h0sBSQ7OrFKXH/NaQmoiqFFlc/MYjOlYMz+8lal4MkNvH1NR7tGrx5Er+ZaHfdKh6r78qDmFb7wB53NRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715659; c=relaxed/simple;
	bh=Ff+zqhtmUWqAGNSwKyOPavq5Ele1ON8FhCxX2fbAZR8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UXJMeCZTg2MeEQAoqsT6joJRqhkdcBce9GjVEQl3sqDk2BG1d76JQnGqK//6qoiytOM9Q0lzcy72yCrMEUqMXwYN5Gp1UBq1C+ASSZeOYIVgpJI/hqHhkj8S27z6VLD4kkmI2Sia6LCMH0XyzIh8CiwG+It6GazowZs/EkEQaDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXatLA2W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B35C43394;
	Fri, 29 Mar 2024 12:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715658;
	bh=Ff+zqhtmUWqAGNSwKyOPavq5Ele1ON8FhCxX2fbAZR8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FXatLA2WgaNyAp7ER7eTVV7MUgJWaOA0QhoDm/2k3kQDB23b2ehvwWPPtHI94Vr3+
	 SNyaoEqIgf6kCHjmh5AcwRdji4w+f9TpnRoGp+RVkrJ2X2O50SFn+jZaNE3pVgG4Am
	 xau1AcUvJcDliMUS9ADjyTJ1E/IcIxizXi5HI9jKwfVALip0v65vnfGUJdFJU+CC7y
	 IkM/gos5WA9EepFqsrRPQaQJTpPJoQVWRssXXXR4qZYCGXExusV8gaG5+dM86P7nvf
	 3lvF0dBRHrXp6vPzRvE5X4bjomF2rYOXYeGVpfYEuFg6yG5D0d95TlWqzN1jSQYjXO
	 bUKvtkIfZNRdQ==
From: Mark Brown <broonie@kernel.org>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 thomas.petazzoni@bootlin.com, Miquel Raynal <miquel.raynal@bootlin.com>, 
 yen-mei.goh@keysight.com, koon-kee.lie@keysight.com, 
 jeremie.dautheribes@bootlin.com
In-Reply-To: <20240223-spi-omap2-mcspi-multi-mode-v2-0-afe94476b9c3@bootlin.com>
References: <20240223-spi-omap2-mcspi-multi-mode-v2-0-afe94476b9c3@bootlin.com>
Subject: Re: [PATCH v2 0/3] Add multi mode support for omap-mcspi
Message-Id: <171171565713.8069.1119556185211827014.b4-ty@kernel.org>
Date: Fri, 29 Mar 2024 12:34:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Fri, 23 Feb 2024 10:32:10 +0100, Louis Chauvet wrote:
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


