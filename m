Return-Path: <linux-kernel+bounces-128569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A624A895C8E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D68A81C22039
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACD715B96E;
	Tue,  2 Apr 2024 19:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrqzinkJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131CC15B55A;
	Tue,  2 Apr 2024 19:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086204; cv=none; b=nRjpRCBU54Na9qvZbQJDengsaJsLk5IkwcNAgubgeJMBUuUNIQD2UQo6X8BpDFodZTvHCa/SEgZbG9RHd7FOzVbWff09b9lqJZsloAWHvdbYzSNfBoR7Vgy3nUiwz/Q1Mrn+UgZaHZbSLIMR32q/r2T4Eox5OFf5xTqp5TmJcfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086204; c=relaxed/simple;
	bh=sOk+iFeGrB7RJDCmCXpr4eaC6JFEv4sFYHZVkhAL1qA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=W4zf6KELMCHLPPeTDBWRGKd5QZSjaoxAP38k/xF8L5n3PZIhYjVM8bmZn0IwJpArbRqiH0qnuaDepr7LoWMpSpECHFFC2mVPGXiHsGSbY0ZVu2kHzyJdnArei6i1g8wLyM597FxX/y1Sq1rdODM/nbY3RJAv+9oTzUmdVEdJpF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrqzinkJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DBDDC433C7;
	Tue,  2 Apr 2024 19:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712086203;
	bh=sOk+iFeGrB7RJDCmCXpr4eaC6JFEv4sFYHZVkhAL1qA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DrqzinkJCwbtPSjQcw1FiH2Yl+aWDrNmmeOSvZGQyDCTEFu4X/Y1FTMeiDcnOg8Gc
	 pEXBsEPOpUnQEIY0oHXqGwCM+/ehzi7dyV4/U6vWEarsM15r/WY+uUz/Lq8sMJTIqB
	 FqWGmx6g7NGJpXtO1eFieK8HFfBRlC8VfVY8ZTsjRyA7nBggMrhhSCvrnf2td3+NM0
	 xUEMNM71ReXaXzi9FJqpE0TZQbU8qUCSnp75u9s/B3YxNuHaMb205t8dkc4pD53KyB
	 h3/GzV/ElUPqNWrk5cYPI8IMOJ2aGv/8AQ/MHVQn1TgCc64jIWha0ODZG+XUYXlq7V
	 Qf64pHr1DrGUQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Seven Lee <wtli@nuvoton.com>
Cc: perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, YHCHuang@nuvoton.com, KCHSU0@nuvoton.com, 
 CTLIN0@nuvoton.com, SJLIN0@nuvoton.com, scott6986@gmail.com, 
 supercraig0719@gmail.com, dardar923@gmail.com
In-Reply-To: <20240401104753.3432507-1-wtli@nuvoton.com>
References: <20240401104753.3432507-1-wtli@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8325: Revise soc_enum structure definition.
Message-Id: <171208620085.89523.17981494000577046407.b4-ty@kernel.org>
Date: Tue, 02 Apr 2024 20:30:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Mon, 01 Apr 2024 18:47:53 +0800, Seven Lee wrote:
> This patch is modified nau8325_dac_oversampl_enum enumerated.
> Use SOC_VALUE_ENUM instead to hide empty (presumably invalid) options.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: nau8325: Revise soc_enum structure definition.
      commit: 91ebd32eee6cd7714b49ca4463a0f315bc26ce0e

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


