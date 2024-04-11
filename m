Return-Path: <linux-kernel+bounces-141689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3219D8A2202
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBE8F1F23D48
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A1D4778E;
	Thu, 11 Apr 2024 22:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGRR/YtR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10803B2A8;
	Thu, 11 Apr 2024 22:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712876269; cv=none; b=DYjjmgrJKx3jOTz5xMV13ByO/SsWOVdyapYSDEKMoLlyiUyJ8b3VZrUyebfzeLigu7VS2xgGm4nYiXkmyX5Kx3PMLqz/UgfB3omktns7CjorVtdHkAnahWibpLZ3c+wjpFQBVt14jIfnXieeraXFjEuWTpAIbvrGImUp8a9DjvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712876269; c=relaxed/simple;
	bh=3PvQYrDxu5lunns0NauurjuD19jwN9atvmFEz3SB8N0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ln1j7wjiAHNZCP6f9E7p4Vr8JjCXGInXwnhCLnarHbZP8qGJyJkrf7CI+mi5XYOob+yMrhZwlGsGuw6sZHssuCVneJhTBywqLccTgJ9ra5PosL0VTaBZ0QQ8FLwCKPgjEKwQyVIn8oO2d5C/1LHb2GvmKEuQ3b3R2ZMbq1AsX1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGRR/YtR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8852C072AA;
	Thu, 11 Apr 2024 22:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712876269;
	bh=3PvQYrDxu5lunns0NauurjuD19jwN9atvmFEz3SB8N0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iGRR/YtR1dsmPrG/414PoViHG8v9hGs7N/dQSej+xwSMIDqJ1Cfu2xJDxMJY6VeEq
	 NVA2qyRbOWg/0tkLmjM4J+6HP0tOijXs+KsHD9/J2UXiEOnQ8dx2gb4KMIRrPEm8Wu
	 5ub1HMvsd3KwD28RblmHBfSmMygicNQGpM0UkKJLONQ5cXVqz4TbhR0yHd0DFboTxd
	 4KH2nwZRockj2MLgKqF1LIcYtc3UM9rSb6tnDIyZCnx1gjJpdM5dSCd3gk2TIFbROI
	 PJZwsB1PiZ9u1f15pjNcH6Pr791qMKEwmMmWDoYyGxIryztZ+/uQ002PZL7dlotePX
	 SMLxCJuVC4EFQ==
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240411083332.304887-1-colin.i.king@gmail.com>
References: <20240411083332.304887-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] ASoC: codecs: tas2780: remove redundant
 assignments to variable ret
Message-Id: <171287626663.99929.5680912373005541173.b4-ty@kernel.org>
Date: Thu, 11 Apr 2024 23:57:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Thu, 11 Apr 2024 09:33:32 +0100, Colin Ian King wrote:
> Variable ret is being assigned a value that is never read in a couple
> of places. The variable is being re-assigned later on. The assignments
> are redundant and can be removed.
> 
> Cleans up clang scan build warning:
> sound/soc/codecs/tas2780.c:84:2: warning: Value stored to 'ret' is
> never read [deadcode.DeadStores]
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: tas2780: remove redundant assignments to variable ret
      commit: 1d165c5a1c85747bf48f37a80636a4a73e1576a1

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


