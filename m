Return-Path: <linux-kernel+bounces-154531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFC98ADD2B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FB5C1F22E23
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20ABA20B3E;
	Tue, 23 Apr 2024 05:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIiexB48"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677B163C8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 05:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713850464; cv=none; b=gLUfiLxmQs8GSCrkrZiu+CPRg3L3n+H7PasGA6kquD/cAY+WogSWCWPWKW9S/icA4j9FQDyxyUBLMQ67YNLs1FcjutsRv3kH2hZovwMyFegMpJqlo1ociH2mSy7VzC/RUB46eQMaTtK+dFfRfeXy6gDa/VT3XTFQ1z7Hz92+6EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713850464; c=relaxed/simple;
	bh=wl33m1m5cEoe49D2s1ZHPhV/BK2S0RFicqiib2V5jXc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kJkGiGea3imPapD2WrD6eBWsE9qnrarsEdXinZ9T1W4YDm3PgF8Fe/UQUMZiQG/Ql3tWLBNJQCsuKIA3dXyIrYvArRk49GjzRRTGfeH33VLMryi71IMFFm4GS2jKEOs1vL7YIKgfG3HGp3gT1ApDDV6hbaLPGmU9Tbd8SlsJoew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIiexB48; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2CEBC116B1;
	Tue, 23 Apr 2024 05:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713850464;
	bh=wl33m1m5cEoe49D2s1ZHPhV/BK2S0RFicqiib2V5jXc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bIiexB48+GS5yxoZn1hGe0wmZlIQwxTgcQYKlrxe59K/RJhrBf9iSP9Ne+HCfW32L
	 HENsyYW1z9mcENU0OEsV+q1QNGE/bafMzcaRgEcnbW/d/i2EONbaC6Dxxe9V+QkZLZ
	 reKF7w6f3oE3TuPr/eW6zCqvTd6oVfIM2UtFg7mcufKxe8Acn1X7Jp9vv5JQMQvuqR
	 HajEnFli115vO66kN4NYMuhAyfPmJ4smLvhUXFNg7NR2ju6OtZFhmiDk9ff2lyZFjZ
	 himiD5I2D3CahRCnT7WcHk1wyKAN2DrM2Kuve6w2Rgy59i4n0ClZ/+RWI68SEtFh3a
	 sl10HRXv3RihA==
From: Mark Brown <broonie@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, 
 Aleksander Mazur <deweloper@wp.pl>, Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <ZiYF6d1V1vSPcsJS@drtxq0yyyyyyyyyyyyyby-3.rev.dnainternet.fi>
References: <ZiYF6d1V1vSPcsJS@drtxq0yyyyyyyyyyyyyby-3.rev.dnainternet.fi>
Subject: Re: [PATCH] regulator: change stubbed devm_regulator_get_enable to
 return Ok
Message-Id: <171385046257.1774956.13833475166479174352.b4-ty@kernel.org>
Date: Tue, 23 Apr 2024 14:34:22 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Mon, 22 Apr 2024 09:38:33 +0300, Matti Vaittinen wrote:
> The devm_regulator_get_enable() should be a 'call and forget' API,
> meaning, when it is used to enable the regulators, the API does not
> provide a handle to do any further control of the regulators. It gives
> no real benefit to return an error from the stub if CONFIG_REGULATOR is
> not set.
> 
> On the contrary, returning and error is causing problems to drivers when
> hardware is such it works out just fine with no regulator control.
> Returning an error forces drivers to specifically handle the case where
> CONFIG_REGULATOR is not set, making the mere existence of the stub
> questionalble. Furthermore, the stub of the regulator_enable() seems to
> be returning Ok.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: change stubbed devm_regulator_get_enable to return Ok
      commit: 96e20adc43c4f81e9163a5188cee75a6dd393e09

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


