Return-Path: <linux-kernel+bounces-63961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE208536CC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DED721C22CF2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6585FBBA;
	Tue, 13 Feb 2024 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T0OrB3mt"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48BF5FB9F
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 17:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707844048; cv=none; b=U1N8VWL4KoH5X94B23SZx+WTDb9gZWRGkXAtLt3b7hgmvIWkW8UP2wgi+AduKcKKGaiB9uuXHtKYmb+jxxPfhWCD2j1y+TNELCpH3xHRbZJpo/dCozG+KcicaEuhQ+qgM0adfs/rPH4ZvifIJNNENq+S+z+IFspdzHJMWP7xNNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707844048; c=relaxed/simple;
	bh=D45EDcGt1I6ipERnCeBoice5BrPjsgms3lauWonmi7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBBg3ggTtzDHvbXT8ulfdtEycmD4M0l5HT/OMWPRKxJaARHUoqdEB1E/QUiNYs00Xr2R7RBBL4eCLg/zztuJkABmhSczBAEdZ4fDKN04QB/6RFWLa9OPMkAX0xP8IhOvT9pqLJgyDPTAbnC6zeKMKjV1e0B2hT9bEKE3NPWsSqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T0OrB3mt; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-411bfe83d11so6290825e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 09:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707844045; x=1708448845; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lBhUsqqEfcFUOvQn0dgNlKxDozoww9xJx2cBhPkvQ0Y=;
        b=T0OrB3mtTZI4VoiCkuerVN1QlPQMNEr1fpgI8arF5iczOoz9Ui/rqKqnDwDA/yuDxl
         oT/dGqIwdH/axDTDvN6kiUQbQC67y3KY7yrA9p60q7AW6g2IRNOQhizpffz+Oo3LqfWg
         Cz1jq181RMy7YVhIzThGRg1eELVD7WqQa07vm2B15H7OROi1YVHWqH3hOOJR8BnjlmTw
         7pwjnU7zgS5q2v/Z+eIE2rjIKHkMeLqn4SdLlj8YgLqaMmTRbXXdkb4qBj4AGYqJYeiR
         w/T8UDCkUSZieIw/4cluKa8qbJpN1TJPa6WbugLPFfc7vE7TJcZuVvQy40xWJiV+l0E4
         69hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707844045; x=1708448845;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lBhUsqqEfcFUOvQn0dgNlKxDozoww9xJx2cBhPkvQ0Y=;
        b=G0pvK+I+S0mPvhB1KRuLxTlT5MKxgemrqtbgQjZFV9xwm9eqPirsjOuU0PcO82CCZm
         2u7mcpkOzNlPJfwV/1hsPMvxcticgyLY4i+CcXkNYQ2fd9Du37XxnUz1lBGYKXDyQXPg
         N2Rerf5buvW621x+EzuzWfCtC2nJJCj8vUfzwLMdjOdmHMZRVbjefhDzHwX44OFpp5vc
         cezBawYyxB6aoP8JU57iF/FIH9VMEYUoO57B0SusQswNRT4G191bdjt2U+km8wEVD9es
         mWeTb6oRtBZyad5tmYQPguCdUYb3tJRN+mqa8p601tUrbB9WcLAnAUt2UqB1ET14q9r0
         NUEA==
X-Forwarded-Encrypted: i=1; AJvYcCWD0++xTn6bPCt6GPeJ4hzm6i5GWLV//tXwCKSxNcEYVNuoK6Rhve1PIkLokq0na4ysk23tf7NA6Vsw58WFEnTEebjGsb6bctCbdRh0
X-Gm-Message-State: AOJu0YzVt5Uep0C6+jiiPF5IHVuuhdFu7fJx6Bl3W0WWeJZPch/18MGz
	V+F4Y+mkeDeFqfe8O+ohyfPW2dLoRF7JG3hZ/HJkt7DmWR/nWfYDmGM8amKMQQ8=
X-Google-Smtp-Source: AGHT+IHOdmbOSJodG4xOl8OtUHg2AhxnOnqOnhs7LvrrIGgbmbq6G6U6EGxCEuh7US+3LUcdJ4gq0A==
X-Received: by 2002:a05:600c:1d92:b0:411:c93e:17c4 with SMTP id p18-20020a05600c1d9200b00411c93e17c4mr230760wms.2.1707844044890;
        Tue, 13 Feb 2024 09:07:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVfnLplCeYI/9ht+8vLHNL7yNdcE/elB9esi3PTLOKi8C4CN0JprjLpV/UwO2rSV2YLb3+PvjNsrknQFajHYnGsENBTUFoEy2oEZy9dLEd3pTdOQVDKRFBQoy9elWj+dquWnfOiUBgJ+AnHB+IMYvZRWOmYIBVVoZCB3C3gVvJBFWgjgKJUhTMH4vfIpg4U2E6qe5GEDqGlj0m8lrEcmGiAK+oZKXxS+DhXAUjm/Ca9k5L5NCN21L0OPjTvyWlVwgjw67gFTcAV2txi26pKY0zCAMyWecm9KN78euNZIfSGLJlN5evqBHmqWkUnqhX9VGFunfhBoahg89QER8mvkgEVGlYopXhhcsrkCmJpJMy/69lx+sAkrenbWiuv4onyzm5Qlq5fYSIoPXJe43D5IH70ALA/Dk3I+5/Ccd9oZA==
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c3b8500b00410e90e82ebsm5520642wms.4.2024.02.13.09.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 09:07:24 -0800 (PST)
Date: Tue, 13 Feb 2024 17:07:20 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Arnd Bergmann <arnd@kernel.org>, Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, Flavio Suligoi <f.suligoi@asem.it>,
	Hans de Goede <hdegoede@redhat.com>,
	Jianhua Lu <lujianhua000@gmail.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: ktd2801: fix LED dependency
Message-ID: <20240213170720.GA297704@aspen.lan>
References: <20240212111819.936815-1-arnd@kernel.org>
 <20240212124428.GB4593@aspen.lan>
 <4869921.GXAFRqVoOG@radijator>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4869921.GXAFRqVoOG@radijator>

On Mon, Feb 12, 2024 at 03:31:50PM +0100, Duje Mihanović wrote:
> On Monday, February 12, 2024 1:44:28 PM CET Daniel Thompson wrote:
> > On Mon, Feb 12, 2024 at 12:18:12PM +0100, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > The new backlight driver unconditionally selects LEDS_EXPRESSWIRE, which
> > > is in a different subsystem that may be disabled here:
> > >
> > > WARNING: unmet direct dependencies detected for LEDS_EXPRESSWIRE
> > >
> > >   Depends on [n]: NEW_LEDS [=n] && GPIOLIB [=y]
> > >   Selected by [y]:
> > >   - BACKLIGHT_KTD2801 [=y] && HAS_IOMEM [=y] && BACKLIGHT_CLASS_DEVICE
> [=y]
> > >
> > > Change the select to depends, to ensure the indirect dependency is
> > > met as well even when LED support is disabled.
> > >
> > > Fixes: 66c76c1cd984 ("backlight: Add Kinetic KTD2801 backlight support")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > >
> > >  drivers/video/backlight/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/video/backlight/Kconfig
> > > b/drivers/video/backlight/Kconfig index 230bca07b09d..f83f9ef037fc 100644
> > > --- a/drivers/video/backlight/Kconfig
> > > +++ b/drivers/video/backlight/Kconfig
> > > @@ -185,7 +185,7 @@ config BACKLIGHT_KTD253
> > >
> > >  config BACKLIGHT_KTD2801
> > >
> > >  	tristate "Backlight Driver for Kinetic KTD2801"
> > >
> > > -	select LEDS_EXPRESSWIRE
> > > +	depends on LEDS_EXPRESSWIRE
> >
> > As far as I can tell this resolves the warning by making it impossible
> > to enable BACKLIGHT_KTD2801 unless a largely unrelated driver
> > (LEDS_KTD2692) is also enabled!
> >
> > A better way to resolve this problem might be to eliminate the NEW_LEDS
> > dependency entirely:
>
> I believe this would be the best thing to do here. Making LEDS_EXPRESSWIRE
> user selectable doesn't make much sense to me as the library is rather low-
> level (a quick grep turns up BTREE as an example of something similar) and IMO
> the GPIOLIB dependency should be handled by LEDS_EXPRESSWIRE as it's the one
> actually using the GPIO interface (except maybe for KTD2692 as it has some
> extra GPIOs not present in the other one and thus handles them itself).

We can keep the GPIOLIB dependency in LEDS_EXPRESSWIRE but it also needs
to be included in the KTD2801 KConfig too... otherwise we'll get similar
problems to the ones Arnd addressed here:
https://lore.kernel.org/all/20240213165602.2230970-1-arnd@kernel.org/


Daniel.

