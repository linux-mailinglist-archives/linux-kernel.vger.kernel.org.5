Return-Path: <linux-kernel+bounces-73081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B6A85BD4B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E79C1C22518
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C926A33F;
	Tue, 20 Feb 2024 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="K7wiOtjR"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB3269D0B;
	Tue, 20 Feb 2024 13:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708436229; cv=none; b=dMcpikVZ2VZjDNNCXL2j8U3FLhy8dXcRxV4CW6YeB+WperkG0mWAO/q33AGivCFKZOtVLleZutKVBou+pvVOafJqOZbz2j7IXSNgsC+7RqIc/svW7NaVmgd55dLXvpDVdy3E5cceQCiQ9+hu7XZCIUIHDq20kJG3DnDKkMjiNcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708436229; c=relaxed/simple;
	bh=8pyWLegVqBLuGiX9D3EQNf/dKDuFEepE0jrXaB9ywGA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J7UnBePJnNKiEYAYMAnooBsK17aGKhCK49qbGlfd1kERevSS+E9HErM2tGUP8Yb0Udrfp7Iwp837RC6Ap0PnK1cGM9zCiB8BD0ooBgG6p8jDMhP+z1d7a5RI2Vwr4qMHu9rl9yHZKbtGbsSLd5odhjKaOj59FReFOAzw1OG1cNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=K7wiOtjR; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DBDC0E000A;
	Tue, 20 Feb 2024 13:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708436219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lmJhNa6Pj+YXDCxepZDS/382SAKzEEjdpms57STtfOk=;
	b=K7wiOtjRIaT1+CE4MNIdZSF3Z78QuqUf+XMm9968VrTMHxfeTT2Cyjils/3Qq0scGqWzPP
	hYPKoUUFBkGnXvOzaiWV70SKY52gQnNf1TEml31cHuo+a/MmEkcRAIXtHjtXD5/ZJWXZM4
	NHJUzC7644g7O6BYu2wNsX1d5ULyNMJoP0uFwkHSxQuTusCtXVNDkx5XbihDDLZOxSEFr7
	cyUyllKdR5wmRlLip8pg38hjl0ZpPFhVdfEO6xTG0Chxfsow3aljqBvT0TjkyknCxlTxiI
	ISMn32efHQeSFvIuJENafzjqroKlGAogyU4UaLvcU3x2ZYerPWUk0UVpvYFyGA==
Date: Tue, 20 Feb 2024 14:36:57 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Saravana Kannan <saravanak@google.com>, Linus Walleij
 <linus.walleij@linaro.org>, Pavel Machek <pavel@ucw.cz>, Lee Jones
 <lee@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 0/2] leds: gpio: Add devlink between the leds-gpio
 device and the gpio used.
Message-ID: <20240220143657.78c2d3f9@bootlin.com>
In-Reply-To: <CAMRc=McjoC5iWWOwX2_3XG-e3W6Tb1Zp6jub71ArHsod6UhNug@mail.gmail.com>
References: <20240220111111.133826-1-herve.codina@bootlin.com>
	<CAMRc=McjoC5iWWOwX2_3XG-e3W6Tb1Zp6jub71ArHsod6UhNug@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Bartosz,

On Tue, 20 Feb 2024 12:40:17 +0100
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> On Tue, Feb 20, 2024 at 12:11 PM Herve Codina <herve.codina@bootlin.com> wrote:
> >
> > Hi,
> >
> > When a gpio used by the leds-gpio device is removed, the leds-gpio
> > device continues to use this gpio. Also, when the gpio is back, the
> > leds-gpio still uses the old removed gpio.
> >
> > A consumer/supplier relationship is missing between the leds-gpio device
> > (consumer) and the gpio used (supplier).
> >
> > This series adds an addionnal devlink between this two device.
> > With this link when the gpio is removed, the leds-gpio device is also
> > removed.
> >
> > Best regards,
> > Hervé Codina
> >
> > Herve Codina (2):
> >   gpiolib: Introduce gpiod_device_add_link()
> >   leds: gpio: Add devlinks between the gpio consumed and the gpio leds
> >     device
> >
> >  drivers/gpio/gpiolib.c        | 32 ++++++++++++++++++++++++++++++++
> >  drivers/leds/leds-gpio.c      | 15 +++++++++++++++
> >  include/linux/gpio/consumer.h |  5 +++++
> >  3 files changed, 52 insertions(+)
> >
> > --
> > 2.43.0
> >  
> 
> You should probably Cc Saravana on anything devlink related.
> 

Sure, I am going to resend the whole series adding Saravana.

Regards,
Hervé

