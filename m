Return-Path: <linux-kernel+bounces-73272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E177A85C04B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DE75285CF1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F3A762E8;
	Tue, 20 Feb 2024 15:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gflXxIoT"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479DA76058;
	Tue, 20 Feb 2024 15:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708444057; cv=none; b=pIHJ6qCgv4xJKnXIpMT7epGKKWdiUCfkpYQI1yFLgGeYkfu+HmagFGkx0vgSDA976U0W+AeqdW6B3EUF8gobMP3mWhlZf1uVe+4fBCXgDmWs9E+qEaLqQxwsPXAOM3JiHG+BCt0mb95SMSy5d3AscyZHyVzepoNYlhPexFLKPhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708444057; c=relaxed/simple;
	bh=F3jhYk5mnxC3hqeqtTwV3ntkk3Zh2pJ6VRpifP5nAJw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MN52BxjfK3ji4lFNiJVvRVZiXKmvZ1fhM3yVrX1dpwqeBK12kRioKklaheAPNE2aLRCWGXJyP6dYCySL4y32iGGKNwh2sbk2vIcj3fcddoAxehn7Oj/FDDISR4cRP8IlxyDSLGnLrg5AB/010ZdwMWb6pan7wKpQcItKvFGQKBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gflXxIoT; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0DA4D1BF20A;
	Tue, 20 Feb 2024 15:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708444051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UBzWFybglIzQQW2WIYff8wLXG7tNw8XtFLNSamDrZqM=;
	b=gflXxIoT1fS/Er6Qod8vrAPUD5yGXocCvpLtJwk54rscGIDLevwmjjWIH0cNmp+Q19SjOR
	w6vv7VThdrHKWxmneV8klJVj6QA96jLcqNxV3PF0zeX3FHl/7YZHu0Iu+e7y1GARl9tGl9
	IbiwAJ+Y4K32h8EKttZU/73S4Viq+k4SVWt1/BgozNRq3qO6YRjdB92FsZ5UmL5Xx1pEkv
	aaOK1ZXbt2TOxgD9fdlsq7L5RlABljg8JDu7IhnBroG6Qbc/unLHMyemAxFPynU3US/a66
	EatUfSYMZAFKNlVmldR/VqkVRrVb6PCHxcOE85Qkdrd7cq/e5cMKV/L74WQUTA==
Date: Tue, 20 Feb 2024 16:47:30 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, Pavel Machek <pavel@ucw.cz>,
 Lee Jones <lee@kernel.org>, Saravana Kannan <saravanak@google.com>,
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH RESEND 0/2] leds: gpio: Add devlink between the
 leds-gpio device and the gpio used.
Message-ID: <20240220164730.03412479@bootlin.com>
In-Reply-To: <CAMRc=MeSgCOLZvFOXF4eQOp=bTz38K5Krzuy9r569-jnDx1zFA@mail.gmail.com>
References: <20240220133950.138452-1-herve.codina@bootlin.com>
	<CAMRc=MfWPEOHeNvAwra-JxHZBFMrQbP+273zbFLDZfxi7fx8Yg@mail.gmail.com>
	<20240220155347.693e46e1@bootlin.com>
	<CAMRc=MeSgCOLZvFOXF4eQOp=bTz38K5Krzuy9r569-jnDx1zFA@mail.gmail.com>
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

On Tue, 20 Feb 2024 16:30:11 +0100
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> On Tue, Feb 20, 2024 at 3:53 PM Herve Codina <herve.codina@bootlin.com> wrote:
> >
> > On Tue, 20 Feb 2024 15:19:57 +0100
> > Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >  
> > > On Tue, Feb 20, 2024 at 2:39 PM Herve Codina <herve.codina@bootlin.com> wrote:  
> > > >
> > > > Hi,
> > > >
> > > > Note: Resent this series with Saravana added in Cc.
> > > >
> > > > When a gpio used by the leds-gpio device is removed, the leds-gpio
> > > > device continues to use this gpio. Also, when the gpio is back, the
> > > > leds-gpio still uses the old removed gpio.
> > > >
> > > > A consumer/supplier relationship is missing between the leds-gpio device
> > > > (consumer) and the gpio used (supplier).
> > > >
> > > > This series adds an addionnal devlink between this two device.
> > > > With this link when the gpio is removed, the leds-gpio device is also
> > > > removed.
> > > >
> > > > Best regards,
> > > > Hervé Codina
> > > >
> > > > Herve Codina (2):
> > > >   gpiolib: Introduce gpiod_device_add_link()
> > > >   leds: gpio: Add devlinks between the gpio consumed and the gpio leds
> > > >     device
> > > >
> > > >  drivers/gpio/gpiolib.c        | 32 ++++++++++++++++++++++++++++++++
> > > >  drivers/leds/leds-gpio.c      | 15 +++++++++++++++
> > > >  include/linux/gpio/consumer.h |  5 +++++
> > > >  3 files changed, 52 insertions(+)
> > > >
> > > > --
> > > > 2.43.0
> > > >  
> > >
> > > Can you add some more context here in the form of DT snippets that
> > > lead to this being needed?  
> >
> > / {
> >         leds-dock {
> >                 compatible = "gpio-leds";
> >
> >                 led-5 {
> >                         label = "dock:alarm:red";
> >                         gpios = <&tca6424_dock_2 12 GPIO_ACTIVE_HIGH>;
> >                 };  
> 
> Do I understand correctly that the devlink is created between "led-5"
> and "tca6424_dock_2" but actually should also be created between
> "leds-dock" and "tca6424_dock_2"?
> 

Yes, that's my understanding too.

Best regards,
Hervé

