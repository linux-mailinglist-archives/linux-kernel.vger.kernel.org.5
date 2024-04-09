Return-Path: <linux-kernel+bounces-136917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCA589D9D2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06E6428219C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F9412F381;
	Tue,  9 Apr 2024 13:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouWoFneu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0EA12DDAC
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 13:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712668088; cv=none; b=o0ro3iFzyOFPwcjGTnAEuvS/RgFf54TnhAtajQg/13jckP7I/akY77VgxJWMr50QWRrm5ud3fbM5pAKg8LqM4CoLwCDf7SqsIHlKfI1U7u/cPa6oNfEgYq3fBVLkdlPihc7/hYEyGBlKZvsZEj8JnzTAoMg6VJp1AFzIyhcSK/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712668088; c=relaxed/simple;
	bh=mgoHitd7TnGSlg8YbmRXp06IWSe9L+tB4+j7dovkdb0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=V/qm1XJOrHI8kKp6dAFgI0ewWx8DEl1dGeUDNDXv/w/YGvrBtPyIJEd1SFY94xVStZGDqajA3YRDdiv2U03X1lX3sQiqCb0sWv+NAtbDz0InxfIfAuEZJvL8n6hi4PBVsJogZ60guDqEXtDUtx18Rr4wewRpNJcUO1yndlaAWBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouWoFneu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24AFEC433C7;
	Tue,  9 Apr 2024 13:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712668087;
	bh=mgoHitd7TnGSlg8YbmRXp06IWSe9L+tB4+j7dovkdb0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ouWoFneuphkOsX3MeFuptUdd8KhSLgKUb+/UeBkyxSspXzdjqh1KLaItvuF6XM0WQ
	 OXmX6YYMOFQluYBL6tfOV2YcIUJ8OeysUpzKe1og+9TNYjtW495mzVZOqtust2fz4I
	 2m2Fn/nT6lr+2IrNyn1YkS8wF49hMQTadJXgIInJb3c4jF12y1K0nrTtn/WFJPckeI
	 6puydyAV3T2GxWMHAyj1mjYxRpoSwf/6RQDI382gXWGqBdn0yPiUjADj8qdZJKikJK
	 zlK4lkDLj1QWHjRNhSNeqKLmtQqKaA21R4vXDKkA2AXgF44vCAEHKgWKfAy2chKL7t
	 H0SmsJa2cLm8Q==
From: Mark Brown <broonie@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <ZhJMuUYwaZbBXFGP@drtxq0yyyyyyyyyyyyydy-3.rev.dnainternet.fi>
References: <ZhJMuUYwaZbBXFGP@drtxq0yyyyyyyyyyyyydy-3.rev.dnainternet.fi>
Subject: Re: [PATCH] regulator: irq_helpers: duplicate IRQ name
Message-Id: <171266808686.28431.8367231474074219890.b4-ty@kernel.org>
Date: Tue, 09 Apr 2024 14:08:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Sun, 07 Apr 2024 10:35:21 +0300, Matti Vaittinen wrote:
> The regulator IRQ helper requires caller to provide pointer to IRQ name
> which is kept in memory by caller. All other data passed to the helper
> in the regulator_irq_desc structure is copied. This can cause some
> confusion and unnecessary complexity.
> 
> Make the regulator_irq_helper() to copy also the provided IRQ name
> information so caller can discard the name after the call to
> regulator_irq_helper() completes.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: irq_helpers: duplicate IRQ name
      commit: 7ab681ddedd4b6dd2b047c74af95221c5f827e1d

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


