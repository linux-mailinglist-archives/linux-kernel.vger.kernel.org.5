Return-Path: <linux-kernel+bounces-153670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CD18AD170
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DA9C1F21ECE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502D1153583;
	Mon, 22 Apr 2024 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSrLBgyd"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EBD1534E2;
	Mon, 22 Apr 2024 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713801765; cv=none; b=QHM9IIEAuC3jjW+i7drlS0hYjNUfSbCr8fGU9nkEvY/7bZiP9Ig1MndlvMxC476sNDi4bkJBFuJbJefFmHxKOyNGvYRK0ifHweV7/fhE9re6nakfdLPZBXxDZcmjJNXGizc9AauPXUjy98a97uvYy+Rn3zcJCsPDJ2PciHMMYgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713801765; c=relaxed/simple;
	bh=fHQ2PjfvnmtnCn4SOJYVSOpRHRjnKs0VuvtdROz0ds8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRR8XZNzcZMv4KotiqZr4e78WWRqPBcedaLIXLXYKPifJ3AqzCwqujkdbd0FbhcXNPYZQszEx881w84meWJIOTWMA+Z2VfkJQTudTM5TI5UhDKqpISr1osZdIqDtkVds7aQiTl5oirf8IjKPVmMCP9o8NZe62f2w6mQGR5aojOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSrLBgyd; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e2c725e234so42333695ad.1;
        Mon, 22 Apr 2024 09:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713801760; x=1714406560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a/Xu0Q9RrOQWribX03STH0Kv467oTIUzB+8PSzczaWs=;
        b=SSrLBgydl1ucZ0S4aqQXYjj6ORsX6jngCFtt53Gt56NBg7ucFNoWFzCs3mHaHSi8nF
         z+kV/vivOoefs0kmeqVQgnaATPSpYF+SwRmI0f093m8/aFIfgjGOSZyBhX3J/2YKkSdA
         oSqCqLKMnZppxnGc0MzONaoQ0KilQEKYOn3F5hj1LBDu+Jysd3Ftqr99OY9IDKULv532
         cdAjaSpzaCHJIG+dGYtbvMyLdKM7WC1K6yzHrvOXtLCN5+GkbyI9lzA/ioUFtm8hYjyr
         ewxdQFX/8zDc28HbFbNpR+l26yy6Waeg/dlk1gzGuUVBb9jxUiyo1/lQa2MbkN/yI0/V
         u/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713801760; x=1714406560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/Xu0Q9RrOQWribX03STH0Kv467oTIUzB+8PSzczaWs=;
        b=G4Fsp9M4pelLIkEaBi56dr3iLNxt32F+YvezP/1y8QNv7ZhtqeBec2OG4t47wvcXOA
         e3gQUY2IY6jczzO12613hLDiE071j8kYjz+0gLx0oVSMQo2Zn7xgAurg9sUduhS5XyrM
         6Dv7YdpsUtvrkzI0MOpQrsIOY2YeWZNHn/Tf3SRGrxi381cJDmBVH9HiyYU+zRzXecIu
         9AH7nuXX2m5RL26TerR4/EFTPchVnA4CBLTL4/Zk1/JVpwCC/CUTDi/357uksJDNvAIo
         ixv8jKOs6z1y2g6fEIOOk6lsQ5ChHad4BpLGVyvC9QqFOSHPx34pcDhSCT3UctJ7spbW
         82kA==
X-Forwarded-Encrypted: i=1; AJvYcCWnOX/01vA21KuZdcFIWfjMUslVxSB63vuRjp0fCZHUpBuo7sD0ETGtrMPHQAiyMBJHbvRp3dOR77e/Z0BLxOYUbkV8ncgVQR7m4UHHR3vNKFJb7miBrmrVUE4udWMx84NJFPRnPBFrCT4=
X-Gm-Message-State: AOJu0YwC0CDWcIOdglnlWBKZ0A13u/ggCKYq0mHzJgAZsjC+28R10GYq
	BaYY4LiMfO53MS7CRuO+k+SLuzD/lfj05W9iHhYllrgrP74gWbnQ
X-Google-Smtp-Source: AGHT+IGRH9epIL6w0KvKxIRyoJi9IsbWP+EZ5TlTARknvNflBbuqfYsqSvgHuf2Z+t+tQKiGcwMFRw==
X-Received: by 2002:a17:902:e74a:b0:1e2:c350:b46a with SMTP id p10-20020a170902e74a00b001e2c350b46amr77571plf.27.1713801759746;
        Mon, 22 Apr 2024 09:02:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id kf12-20020a17090305cc00b001e43a00ee07sm8301913plb.211.2024.04.22.09.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 09:02:39 -0700 (PDT)
Sender: groeck7 <groeck7@gmail.com>
Date: Mon, 22 Apr 2024 09:02:37 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: krzysztof.kozlowski+dt@linaro.org, u.kleine-koenig@pengutronix.de,
	Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] hwmon (max6639): Use regmap
Message-ID: <116aeea1-c648-4abe-9ab2-693bf64000fc@roeck-us.net>
References: <20240416171720.2875916-1-naresh.solanki@9elements.com>
 <65607114-89f8-4f48-83fc-b89d87fee247@roeck-us.net>
 <CABqG17jveAdxN+tCcPq4hNqWDy1YCJ1z0+kLpM+ect0XEyqBcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABqG17jveAdxN+tCcPq4hNqWDy1YCJ1z0+kLpM+ect0XEyqBcA@mail.gmail.com>

On Mon, Apr 22, 2024 at 04:06:16PM +0530, Naresh Solanki wrote:
> Hi Guenter,
> 
> On Wed, 17 Apr 2024 at 02:55, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On Tue, Apr 16, 2024 at 10:47:14PM +0530, Naresh Solanki wrote:
> > > Add regmap support.
> > >
> >
> > Missing (and not really utilizing) the benefits of using regmap.
> This is just replacing with regmap support
> >
> > > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > > ---
> > >  drivers/hwmon/Kconfig   |   1 +
> > >  drivers/hwmon/max6639.c | 157 ++++++++++++++++++++--------------------
> > >  2 files changed, 80 insertions(+), 78 deletions(-)
> > >
> > > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > > index c89776d91795..257ec5360e35 100644
> > > --- a/drivers/hwmon/Kconfig
> > > +++ b/drivers/hwmon/Kconfig
> > > @@ -1223,6 +1223,7 @@ config SENSORS_MAX6621
> > >  config SENSORS_MAX6639
> > >       tristate "Maxim MAX6639 sensor chip"
> > >       depends on I2C
> > > +     select REGMAP_I2C
> > >       help
> > >         If you say yes here you get support for the MAX6639
> > >         sensor chips.
> > > diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
> > > index aa7f21ab2395..1af93fc53cb5 100644
> > > --- a/drivers/hwmon/max6639.c
> > > +++ b/drivers/hwmon/max6639.c
> > > @@ -20,6 +20,7 @@
> > >  #include <linux/err.h>
> > >  #include <linux/mutex.h>
> > >  #include <linux/platform_data/max6639.h>
> > > +#include <linux/regmap.h>
> > >
> > >  /* Addresses to scan */
> > >  static const unsigned short normal_i2c[] = { 0x2c, 0x2e, 0x2f, I2C_CLIENT_END };
> > > @@ -57,6 +58,8 @@ static const unsigned short normal_i2c[] = { 0x2c, 0x2e, 0x2f, I2C_CLIENT_END };
> > >
> > >  #define MAX6639_FAN_CONFIG3_THERM_FULL_SPEED 0x40
> > >
> > > +#define MAX6639_NDEV                         2
> > > +
> > >  static const int rpm_ranges[] = { 2000, 4000, 8000, 16000 };
> > >
> > >  #define FAN_FROM_REG(val, rpm_range) ((val) == 0 || (val) == 255 ? \
> > > @@ -67,7 +70,7 @@ static const int rpm_ranges[] = { 2000, 4000, 8000, 16000 };
> > >   * Client data (each client gets its own)
> > >   */
> > >  struct max6639_data {
> > > -     struct i2c_client *client;
> > > +     struct regmap *regmap;
> > >       struct mutex update_lock;
> > >       bool valid;             /* true if following fields are valid */
> > >       unsigned long last_updated;     /* In jiffies */
> > > @@ -95,9 +98,8 @@ struct max6639_data {
> > >  static struct max6639_data *max6639_update_device(struct device *dev)
> > >  {
> > >       struct max6639_data *data = dev_get_drvdata(dev);
> > > -     struct i2c_client *client = data->client;
> > >       struct max6639_data *ret = data;
> > > -     int i;
> > > +     int i, err;
> > >       int status_reg;
> > >
> > >       mutex_lock(&data->update_lock);
> > > @@ -105,39 +107,35 @@ static struct max6639_data *max6639_update_device(struct device *dev)
> >
> > Conversions to regmap should drop all local caching and use regmap
> > for caching (where appropriate) instead.
> max6639_update_device deals with volatile registers & caching isn't
> available for these.
> 

So ? Unless you replace caching (and accept that volatile registers
are not cached) I do not see the value of this patch. Replacing direct
chip accesses with regmap should have a reason better than "because".
Using regmap for caching would be a valid reason. At the same time,
the value of caching volatile registers is very much questionable.

Guenter

