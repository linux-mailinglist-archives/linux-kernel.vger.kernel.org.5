Return-Path: <linux-kernel+bounces-48696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52317845FDF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CA551C21D25
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106D812FB3C;
	Thu,  1 Feb 2024 18:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBNc7Fuw"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5D612FB0E;
	Thu,  1 Feb 2024 18:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706811987; cv=none; b=mGG1kUDM2GIxQKHP2k2DWvGEuGjZBRYNkGUWfSBthZSRxbg57oQjWCVKaP1/eQmDLVjBKE2TgWcjBoYRZ86jUgysSaVltc5jm3q1/zNWhvYgsOXKv1xqrwt4fNCPV8wT9sOmQozue/QlQYmtJ+MEeHaaeJihHYUqp2Hxbx6m668=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706811987; c=relaxed/simple;
	bh=FVTBCN2du4zlWLyaWqxrGSTkTvzubs6Y4PI45j7s9XM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exVOkgK8RGKz2NkfUKd7ZMAGfYgscvSG8AT27+5xf74MKMMUJAwnLnBmOpd5J4rty+2ksbKulBVtqWbUIGpJqox8DdAJdxf/+41zu56sl4uJAk9mzNCkNAd7i1UL8tMN8AowHfTskUDZXKP0crLjAn7oB2uHz0O/CicpQtZEj2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBNc7Fuw; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d72f71f222so10799675ad.1;
        Thu, 01 Feb 2024 10:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706811985; x=1707416785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hwmvsN2Ntz2KqUUIBBoM0a9JofCC8LHROVWl1waNCjg=;
        b=eBNc7FuwzMrOkLT0kaiJQQLPA0qSIbhbk+EIRbfP0OpKGkVR5Wfgz/RD7Rp0/WPrSm
         5Qq1zAqDgVtmOXgFuP0t6sMN7Q/rC6D2t4OJCbciRH7bhgBlYfThUjuKKVSizGqjTiHg
         wSe+Ssnu6F/+fnxaynFVuxh9sP+L5nJQe22c04gZDqh7+MvMAHS3Q6zi/96DqfGDNthO
         BJ7tQLG+H2J9fPh10wbYbEOEsHkAjkC4xW8z6gJbA+lYOKAjV8S/qUUl+acP442N98bB
         EtNS70JzdMS0MwrBGS5PRlHmX04Sgz927fhlfFrl2Chnrwf84Uo9unBAoAOj5JkI6PH5
         ZUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706811985; x=1707416785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hwmvsN2Ntz2KqUUIBBoM0a9JofCC8LHROVWl1waNCjg=;
        b=i2opzZT+M++WtoD6wOWm1X+rn6ttJenjhMExbDg4U2qrO6frMoQaLJ5xN6+2dRmmy0
         sEN6TO0DVX9yLtmmixVljZ+Am69ixpz5EE1djkqHp869cbASjpb6fcMTwHR/XSGMywFt
         AySfKzwwbHbv8GEN86ZYCgTmcva3pjml1vg0FlashQMarCks3kie74oGgx5JxFqZBKCo
         o6UMlmlMaNtE/cZn42+6ztFB08ArIHz4zGk834jzMByYHyLz3oAZURwbqU1TcpmCcRzi
         RWRO4uvC0fuxdaROrL56qpmRYact6xdvXSiddmXthb9szQIRKxXR1OyybC2PaV5W1Hih
         1ztA==
X-Gm-Message-State: AOJu0YzKbITNLWvJ1twFc/WVYJBosqtrKwEHgEnyspiWRpQ7CYcOUtaj
	SODoFtI5fR5wnjV6YbRSrFSXhzdPgzQGNDMCZBtO2RR5mByX+Xr7
X-Google-Smtp-Source: AGHT+IGfYDlPKiO2kGlPRvllIPOYXbZB9hN5jH+VTZP2buW4S8Q56DzaxHeeECZd9Qet1OzG4IecuA==
X-Received: by 2002:a17:902:d590:b0:1d9:427a:99b with SMTP id k16-20020a170902d59000b001d9427a099bmr5910320plh.32.1706811984997;
        Thu, 01 Feb 2024 10:26:24 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXJt9er2Oe/D78iSMdGinSF1rdGyGo50IHP1ZZ2fCvGk6/+VT7Znkbx2lE5lFgA6SaiprC5NEbqgW9kMhJyeKZIbyakvpqM/J0TJMFhkyrfVyeB+DeUz1mRJnnBL7daAee+zjmaLrfsmJ3BA9mk2va/eC9atWlLef9U9aizsP3x0bq4LoqUEwcgmblnSe4nzbdV2tb759DWzAjY+lKVdKj3qFjPEc73FH5fgfZe+tvkcfD61q8gMM6xZJbv19aJuQYrDsBmUJQ3nQIvmnKvoUHrAmQYw0+rZXh0Fn/6qyvEjOnDACZHK61xGWxrVsPoBgYXCFvJXZnt/yBItHWainrXh1t0aJYs5L1xQHlAnSNNP6DoDmZy8460xtWScYQh9tF95A==
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v11-20020a170902d08b00b001d7134d149dsm112730plv.256.2024.02.01.10.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 10:26:24 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 1 Feb 2024 10:26:23 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jean Delvare <jdelvare@suse.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v5 net-next 08/13] net: phy: marvell-88q2xxx: add support
 for temperature sensor
Message-ID: <0f9c8083-7287-40af-a084-98c692166b40@roeck-us.net>
References: <20240122212848.3645785-1-dima.fedrau@gmail.com>
 <20240122212848.3645785-9-dima.fedrau@gmail.com>
 <65071184-428b-4850-9e0c-baaa73513c6d@lunn.ch>
 <20240201071137.GA41347@debian>
 <5dc7d495-dd41-4b1f-b0e0-1fe512f1687c@roeck-us.net>
 <20240201161435.GA48964@debian>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201161435.GA48964@debian>

On Thu, Feb 01, 2024 at 05:14:35PM +0100, Dimitri Fedrau wrote:
> Am Thu, Feb 01, 2024 at 05:34:05AM -0800 schrieb Guenter Roeck:
> > On 1/31/24 23:11, Dimitri Fedrau wrote:
> > > Am Wed, Jan 31, 2024 at 04:17:06PM +0100 schrieb Andrew Lunn:
> > > > > +static int mv88q2xxx_hwmon_probe(struct phy_device *phydev)
> > > > > +{
> > > > > +	struct device *dev = &phydev->mdio.dev;
> > > > > +	struct device *hwmon;
> > > > > +	char *hwmon_name;
> > > > > +	int ret;
> > > > > +
> > > > > +	/* Enable temperature sensor interrupt */
> > > > > +	ret = phy_set_bits_mmd(phydev, MDIO_MMD_PCS,
> > > > > +			       MDIO_MMD_PCS_MV_TEMP_SENSOR1,
> > > > > +			       MDIO_MMD_PCS_MV_TEMP_SENSOR1_INT_EN);
> > > > 
> > > > You enable an interrupt, but i don't see any changes to the interrupt
> > > > handler to handle any interrupts which are generated?
> > > > 
> > > Hi Andrew,
> > > 
> > > you are right. Have to remove these lines. Besides enabling the interrupt
> > > in MDIO_MMD_PCS_MV_TEMP_SENSOR1, there are two further register writes
> > > necessary to make the interrupt propagate. I didn't want it to propagate.
> > > Anyway it's wrong. I couldn't find a good solution to use the temperature
> > > interrupt. Will have a look into this, and probably figuring out how to
> > > do so. But it won't be part of this patch series.
> > > 
> > 
> > From hwmon perspective, the expected use of such an interrupt would be
> > to call hwmon_notify_event() with the affected limit attribute as argument.
> > This would notify the thermal subsystem if the sensor is registered with it
> > (your patch doesn't set the necessary flag when registering the driver,
> > so this would not happen), it will send a notification to the sysfs
> > attribute, and generate a udev event.
> >
> Thanks, noted it down. Didn't know about the notification to the thermal
> subsystem and the generated udev event. :)
> 

Note that you'd have to add something like

	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),

to the code to register the sensor as thermal zone.

Guenter

