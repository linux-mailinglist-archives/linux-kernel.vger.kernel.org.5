Return-Path: <linux-kernel+bounces-81339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4021786747D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FA401C248E7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E454605A0;
	Mon, 26 Feb 2024 12:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="gFs4D2ZC"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C12604CA;
	Mon, 26 Feb 2024 12:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708949539; cv=none; b=czsXzWF3W0UaXMcBoR8uDwphKN7Zo1QNQML/llehEO+yE+BsO2KVPkzKLdWlmXU3BDM9MG+dOJtSUtufinwXKpq36R/SM88lDP8YhbHRXGMJFhcSiIbyb3/xq3d6GPE1/wSBqxfBCssS9yJ4hIKdvEysqg7u5NdLnd56MtgIzq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708949539; c=relaxed/simple;
	bh=iuGzS6WlYi9TtdofL6bGGFT5c4OI29PZWGoXll9ZowM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6RuP8qNUQZAc6ienTx8au2DCCULNjqQPi/wmW8NnchDdNc4ViZFOHMTwCjLJ06Sqnz/w55LbffM107jBO/2yPvI2Xr7yo1ICwOH7qcI5vjFDmajxKPYP1VmjCt5sPCVnkfd+9u+pB9lklwDtRQF3qlrkfnosnR9YIcRiJOpF1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=gFs4D2ZC; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 7531A604E8;
	Mon, 26 Feb 2024 12:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1708949537;
	bh=iuGzS6WlYi9TtdofL6bGGFT5c4OI29PZWGoXll9ZowM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gFs4D2ZCrYF/SWVPKAVRLsOfeKMzT0AaJNpC9WwLQdR7h20yN/u9x+LYHMzCO4cAD
	 EQ6mcAig/6atIDcj3UkOQgj42nUoVl3vYzWEgVidQRPuf3RbEUIM5yFRK8Ahoz47ln
	 vHRSfUpwapzWNiqpF5J3cZcff7INBpwekxhysLB9DdYVK4o6kTvdsMSGmKaQJc/6Q+
	 o58CvFgQbjCAfIfyboAhuOEf0Yqh81d8iwfbx71fB4cF5DNAsy6HBsC2TeX1idpS8i
	 3vRiq0bXo3i5yMrOGP/R84RSxP9fn5RzTt87Jp5mFrqz9OVpXV11qCgArKf8lehsKY
	 tzuDnjjOknfjA==
Date: Mon, 26 Feb 2024 14:11:56 +0200
From: Tony Lindgren <tony@atomide.com>
To: Lee Jones <lee@kernel.org>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, bcousson@baylibre.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>
Subject: Re: (subset) [PATCH v4 0/5] mfd: twl: system-power-controller
Message-ID: <20240226121156.GA52537@atomide.com>
References: <20240217082007.3238948-1-andreas@kemnade.info>
 <170870473441.1731639.3240676194817206962.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170870473441.1731639.3240676194817206962.b4-ty@kernel.org>

* Lee Jones <lee@kernel.org> [240223 16:12]:
> On Sat, 17 Feb 2024 09:20:02 +0100, Andreas Kemnade wrote:
> > Add system-power-controller property in the bindings and
> > the corresponding implementation and use it where
> > appropriate.
> > Not all cases are hit yet, there has probably to be a
> > separate series after going through with a brush.
> > 
> > Changes in v4:
> > - fix spelling/grammar
> > - drop twl4030 dts cleanup, it would need an IB
> >   or be postponed till next release
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/5] dt-bindings: mfd: ti,twl: Document system-power-controller
>       commit: 0c7cc7497f6f62a65037e94cf0d885ab0af3c0d3
> [2/5] twl-core: add power off implementation for twl603x
>       commit: ca9414a1d08756c8392f9219caee607e1b7bade1
> [5/5] mfd: twl4030-power: accept standard property for power controller
>       commit: 8ba560ec14267af1169e1f5407fbce514fd4f6f6

Applying the two dts changes into omap-for-v6.9/dt thanks.

Tony

