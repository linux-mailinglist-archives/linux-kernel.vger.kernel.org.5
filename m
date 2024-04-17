Return-Path: <linux-kernel+bounces-147787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6CB8A79AF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 119DA1F22B04
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B21F63A;
	Wed, 17 Apr 2024 00:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqgfE3BW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC557196;
	Wed, 17 Apr 2024 00:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713312725; cv=none; b=XxSfxdRTQVY3I1Ew4gCfLHFR9OTZrOYV2+Ote4DNGevQ29vrFxZY8cgCRsyC+ntNTGYwwlLDQSfnRFmd5gd5wyQstLgFYp8UXZlU9vFzx8B1clcsG0sVfWb/4PhNgeIqPeIKfiZ9I/n9DZZAK+epbJlBcMil+U5Ga4fo7KkGFaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713312725; c=relaxed/simple;
	bh=PJkA+lit/IMxrTj6xellbkQ4vhyYiRcm3GUH7WV5wRA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CIyAsei0L3kCaAVf5GbGAJONwL6yzttR6HGWDOH4JO99NVyt0o2TekYVy/QZ0OyW0sdRhViWH/mrthVD9ntdn+009OpomfXqSG+cmYVwtTtY3VdQnjLmILMjbvDM4vd9kqwfxlnMnZDjcMBQeu3ZsR882ej4yxQ7T9mL0qQb2rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqgfE3BW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11101C113CE;
	Wed, 17 Apr 2024 00:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713312725;
	bh=PJkA+lit/IMxrTj6xellbkQ4vhyYiRcm3GUH7WV5wRA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aqgfE3BWWn5UbVhA2IENjF5xOZKTeeNJ2G7GqSLfETa/opVc5E+1r8cAr4/h42MFy
	 JsUwhlwZ70z0Ln8tXziq1e6OQe5vdWmlmztKnJXUQfTzFT5zjUpD7c78jv+YXHE086
	 PVVw+HekU9A0RSGeYRsz1DRsNSXxA1AdSM2NsjXFGFTUrKnKlhWrmDMwjv6ymEKO3y
	 ptVGMCm/aQczdyOQibuCmwrK89VBrjNpywQ2HNjhQ8p1ovFPJwFITeAgunrYwFlSAn
	 kaFwuMLRXmdIdVaahJ74xOGqG9W3zYy9KPaWdhJPJhhHKcQvpITghGaQNLnXBQWgg1
	 YIDeIhYTqyVpA==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, "end.to.start" <end.to.start@mail.ru>
Cc: linux-sound@vger.kernel.org
In-Reply-To: <20240412075533.10214-1-end.to.start@mail.ru>
References: <20240412075533.10214-1-end.to.start@mail.ru>
Subject: Re: [PATCH] Support microphone from Acer Aspire A315-24P
Message-Id: <171331272446.1685717.66002151665481050.b4-ty@kernel.org>
Date: Wed, 17 Apr 2024 09:12:04 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Fri, 12 Apr 2024 10:55:33 +0300, end.to.start wrote:
> Add support microphone from Acer Aspire A315-24P and for some other similar devices with such vendor
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] Support microphone from Acer Aspire A315-24P
      commit: c21614d5c0e76cf1d7a864f15d495fd3e5876acc

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


