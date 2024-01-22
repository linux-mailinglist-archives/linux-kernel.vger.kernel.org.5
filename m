Return-Path: <linux-kernel+bounces-32609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A826B835DE4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8D351C24841
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C66239864;
	Mon, 22 Jan 2024 09:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SFDc5YZj"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DBE3A8C2;
	Mon, 22 Jan 2024 09:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705914925; cv=none; b=IZ6TIMXf5s/Fd7Dm59s1ONc9PGLvgUx7bX91TZ4zR1dxOwkSXhbcYp7zCxjVuZjMTKYArxsF4u7efuySp98PAInqJVjc2ndmc5ce2aDGYGScla3A5vKGxwxFhWboIpIfaargroxvy0os5ffGxGzCiqVuIB6LzFx1QLxY64s6z9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705914925; c=relaxed/simple;
	bh=QOMGLQ8Zx+wPiL92sY2/XSGqt6AVHmJbZBY431fESWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqOa88ciVXuMQiDUw8DsssDlLT+XVRiJ6aFlmVrgGe5x8dqBJHZQWKqOir1CFtPxqE+zxnbsKG8h9ChOZN7isQlhiSaB5vqBw7Ls5uZoUJ1QAchP9d6PLK5lT9lj1OWmKgA3lGFeCAzmtPWHtrQdmx8YDT5nwceKpsHnvM5lMpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SFDc5YZj; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E828C1C0008;
	Mon, 22 Jan 2024 09:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705914914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LrG9+46KuXtBlxIUOx0DyHU7sjn1FkhruzlXHAOP5As=;
	b=SFDc5YZjAYVRO1aKvOuFt3JAr6qRfWGKwPgTbdbQ/8JLd8rtm9JbE+BvXMa0rqbH5G+TNI
	iFBNBhJw6VvJBsBwjBLnZJ4eFrzgxCIWgFYFZgM+5rKAjSv7Qv5be3ayicmtSpg99/LiEE
	ZArtLOhhmbouLIJYFK9bDQuasJJcksq4VSNVFdU7J1TujI7vjCB+tp7dRrO06BVCGmqhYx
	ygT/I2wQJmN+ud0cuf3cgD3x0J3Uq3qOKFfzH6kHinnuAwmtZ0wzqwnaRphmMWLC32FRoY
	euogrM+TTpBI1BpgrfHqLzuyN6j6EmGrcMiUg+m7KKfJ9PUVei+uOHtSipZj0Q==
Date: Mon, 22 Jan 2024 10:15:11 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, chao.wei@sophgo.com, unicorn_wang@outlook.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	dlan@gentoo.org
Subject: Re: [PATCH v7 2/3] rtc: sophgo: add rtc support for Sophgo CV1800 SoC
Message-ID: <2024012209151130867663@mail.local>
References: <20240122080631.2880-1-qiujingbao.dlmu@gmail.com>
 <20240122081722868bdda5@mail.local>
 <CAJRtX8QU8iHY1oQJ1uDN3YOmCeN7SH+vPC8nD29WS5+2DT1oKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJRtX8QU8iHY1oQJ1uDN3YOmCeN7SH+vPC8nD29WS5+2DT1oKQ@mail.gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 22/01/2024 16:34:00+0800, Jingbao Qiu wrote:
> On Mon, Jan 22, 2024 at 4:17 PM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> >
> > On 22/01/2024 16:06:30+0800, Jingbao Qiu wrote:
> > > Implement the RTC driver for CV1800, which able to provide time alarm
> > > and calibrate functionality.
> > >
> > > Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> > > ---
> > >
> > > Depends on https://lore.kernel.org/all/IA1PR20MB4953C774D41EDF1EADB6EC18BB6D2@IA1PR20MB4953.namprd20.prod.outlook.com/
> >
> > What is the dependency?
> >
> 
> Thank you, this driver requires support from the CLK driver.
> I will add an explanation in the next version.
> 
> >
> > Also, please fix the checkpatch.pl --strict warnings
> 
> I will use the -- strict option for testing.
> 
> >
> > > +/**
> > > + * cv1800_rtc_32k_coarse_val_calib() - Using an external
> > > + * clock to coarse calibrate the crystal oscillator
> > > + * @info: the device of calibrated
> > > + *
> > > + * @return 0 on success, or -1 on fail
> > > + *
> > > + * This RTC has an independent 32KHz oscillator. However,
> > > + * the accuracy of this oscillator is easily affected by
> > > + * external environmental interference,resulting in lower
> > > + * accuracy than the internal oscillator.Therefore, a 25M
> > > + * crystal oscillator is used as a reference source to
> > > + * calibrate the RTC and improve its accuracy.Calibration
> > > + * is completed through two steps, namely rough calibration
> > > + * and fine calibration.
> > > + */
> > > +static int cv1800_rtc_32k_coarse_val_calib(struct cv1800_rtc_priv *info)
> >
> > This is still not working as well as you think it is. You should
> > Implement the offset callbacks instead.
> >
> I'm sorry, I don't quite understand offset callbacks.
> Do you mean that this function needs to be executed periodically.

I mean implement read_offset and set_offset here:
https://elixir.bootlin.com/linux/v6.7/source/include/linux/rtc.h#L67


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

