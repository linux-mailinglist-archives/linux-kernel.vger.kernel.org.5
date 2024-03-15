Return-Path: <linux-kernel+bounces-104493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5725687CEB7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5B231F22910
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2B63D576;
	Fri, 15 Mar 2024 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="i7+C2wYk"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB3D3A29B;
	Fri, 15 Mar 2024 14:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710512625; cv=none; b=IZWFdQrfNBiIdk7CTD54QBltRH2cLIWOH54e+otMpe3EfKmB29wP2O4au0OhnBisdK+BHGYM2fBz5/TmtEuuIsEzqikpbRszxingFzxff37HCjvZ9GI1hsRHl7iJHC1D/Q55rm2vZkpZnWjQM6VtSFM60IsRoOwLneKxIyh+TrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710512625; c=relaxed/simple;
	bh=cr+/aQT+qT9SbX9VXJjLYOAL3dxlPMmPMDGFkNlLRRw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b5HlXPEmji3GFzGD0Igl/l08fW6Fekgt6cBc6mj8mrPxYyIga89nk0LFUCQLKXpQ3TzOrZtPniuDHymTsvNSwKh27LVqQjOwkijOJyCrqj+KElw5/bGssao9T7VOFF/eg9IAuGhkYwXDSprHm+YOP2Z7axEabGo8K8plVLUtMo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=i7+C2wYk; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F00A26000F;
	Fri, 15 Mar 2024 14:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710512615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nWOjdNRJQt/bpdeE8qfZ2hZ2CbBU52wmtVHaGOGss9o=;
	b=i7+C2wYk12fq9PeTVpN2e8X4HliWxtZGH+XwwfFPLtfcDj1C09gYCdGxmdg5HdzW3bl+mB
	IAsJ6LdKwsG0vTPG5bMZkaMOleEBpSsg8vKMY/B9LsoRS590BofF559/NLsxQTrx2T7Ya8
	u1Uiwkzgs8MaBGOsAS2GL+bygh6Rs/kIe8xfCFKOFofypuRc66ho75qhk5QbzTM4AoxMPI
	CujAS9c+nWLRDQBfIEDciN3tvnyZccTARz+aPxC3L2HAJEqhpgv92m+9FUp8UBAhA4XbE0
	diBs2+xdWEpsRxOwQTd6Q4DMMRRIRxnt9wNh68oHji1WTKc3Aejz+XAJB1txbw==
Date: Fri, 15 Mar 2024 15:23:32 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Peter Ujfalusi <peter.ujfalusi@gmail.com>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, christophercordahi@nanometrics.ca
Subject: Re: [PATCH 04/13] ASoC: ti: davinci-i2s: Replace dev_err with
 dev_err_probe
Message-ID: <20240315152332.57c8fdc4@bootlin.com>
In-Reply-To: <6102130b-b496-4e75-9b9f-f960484848fb@sirena.org.uk>
References: <20240315112745.63230-1-bastien.curutchet@bootlin.com>
	<20240315112745.63230-5-bastien.curutchet@bootlin.com>
	<6102130b-b496-4e75-9b9f-f960484848fb@sirena.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Mark,

On Fri, 15 Mar 2024 14:07:13 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Fri, Mar 15, 2024 at 12:27:36PM +0100, Bastien Curutchet wrote:
> 
> > -			dev_err(&pdev->dev, "no mem resource?\n");
> > -			return -ENODEV;
> > +			return dev_err_probe(&pdev->dev, -ENODEV, "no mem resource?\n");
> >  		}  
> 
> dev_err_probe() with a fixed error code doesn't seem to make much sense,
> the whole point is to handle deferral but for a straight lookup like
> this that can't happen.

The error code is uniformly formatted and the error path is more compact.
  https://elixir.bootlin.com/linux/latest/source/drivers/base/core.c#L4963

IMHO, to benefit of these feature, it makes sense to use it even with a fixed
error code.

Best regards,
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

