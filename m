Return-Path: <linux-kernel+bounces-137380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA75E89E144
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A1C41F219E0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7D8156246;
	Tue,  9 Apr 2024 17:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Symclgfc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B4915539C;
	Tue,  9 Apr 2024 17:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712682844; cv=none; b=F+MAwZLqEfP3UyfQCRhaJIGk990iEikkC5NVq1eZadAN6YXx2nq6DyUQNJqfXDr5ILIisyrBV0BRemNObxjvJruCt9+yh9pDi5lcUWcrLjtx3nnqq67XQoRN5S/eK8hredTMkua2CgCN5N9jFcb/r2lasQoik92+Zcgb/vjg9Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712682844; c=relaxed/simple;
	bh=eLVIl7iYW4+J9rJxM3YqwKEmIf8e95ULiezgmaMUibw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=U7m+g9fXm6QhbjuEpFcgaQ1MeRtLi21h2oUeMkm3o3JzaxqvEdIVpOpamoPua+Szj/PBYkoKkOpj0asuEr8C7qlaeJrdIfbPCa8tv6Ya8MhvH3/FSrf4OmevBP/Md75kPw0sOzPrXmSRkSb3Mw0lVAVjrsso7nA793HenO4R9B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Symclgfc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D516AC433F1;
	Tue,  9 Apr 2024 17:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712682843;
	bh=eLVIl7iYW4+J9rJxM3YqwKEmIf8e95ULiezgmaMUibw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SymclgfcWVlic2Xo9YSpojdep8sD9sMRPugZF6LFfE2883Nq40JAB53fA5/6hzp9Y
	 uWTNQ8wCXZ8Wc7nO0XqoofySluyiJSm127DmOuYYGQ/X3b+Z2CDD/pSu774EultFi7
	 O3q8k2JBQTFAsheXDuaaTMOhTGfKYzEEaGfsV4XUJkhwpQZ/tGlU3Tfhd9wjN/ndEh
	 NZejBTbED3PU42oWTX9BMCga6rgtgt2D5x03QiHuVp5AuETc/amP5vJGvlwCZMbyGi
	 kLOD3QP0qiGdedKTkw22UgqDEIq7AY4sOv8lu+MwlcC1sCGefo+zRqXFrlcrwrV1KW
	 53j+67mlzCoqA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-sound@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <6cdbaf4afcf4d2059b257f6cb3a8a61bf5e17688.1712676714.git.geert+renesas@glider.be>
References: <6cdbaf4afcf4d2059b257f6cb3a8a61bf5e17688.1712676714.git.geert+renesas@glider.be>
Subject: Re: [PATCH] ASoC: codecs: Rockchip on-SoC codecs should depend on
 ARCH_ROCKCHIP
Message-Id: <171268284155.51610.12348972415810451410.b4-ty@kernel.org>
Date: Tue, 09 Apr 2024 18:14:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Tue, 09 Apr 2024 17:34:56 +0200, Geert Uytterhoeven wrote:
> The various Rockchip embedded audio codecs are only present on Rockchip
> SoCs.  Hence add dependencies on ARCH_ROCKCHIP, to prevent asking the
> user about these drivers when configuring a kernel without Rockchip SoC
> support.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: Rockchip on-SoC codecs should depend on ARCH_ROCKCHIP
      commit: 9fd60615ad2835d8e0081fd2458721c8b994f28f

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


