Return-Path: <linux-kernel+bounces-47721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3F68451C6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4BAFB24B23
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 07:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592931586D1;
	Thu,  1 Feb 2024 07:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YS4H9asG"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7ED157E90;
	Thu,  1 Feb 2024 07:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706771503; cv=none; b=hy9OkWYaZ9M5pyqsJep6SYNfmlZu/hOWx9tyU6/anwt9L0BxY6eSnTVwfeziDn91mI5tANPvB6VrTa71izKwfL/dfV+SQiC4VQJePadPGDcD6X7NGHKJBdCs/BbPGwPvgLdFCDrQ70k5SNMQgoedNNZXhrhzhKFUJc6YvzlhD1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706771503; c=relaxed/simple;
	bh=IDC7ymgQeSHuFr0rjM4UAqt05pUsygpnpWG3puJorBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxAkdvBOBNKBNhjqjpZ7zDIXqO5h/tI1N1+GQEhdsiWuqRxjDkM36kqE9Vm+xB/KTgB8rtGfIZdQjGpSswLVUKnxyrObtJ6vppEVcs3h582cC640UtwoNPkzfJURH0/dkSAPdMPv/VI//SQfQGIqWgLLlhDT8/hITEZb6K+PyHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YS4H9asG; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40ef3f351d2so9561455e9.1;
        Wed, 31 Jan 2024 23:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706771500; x=1707376300; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4MTyarJbOldtNhuHu6n9oQqi/8jRbXK/pPJRsFzR35U=;
        b=YS4H9asGSf7bAi4V76u5mO90qP8uOdP/mF/EAHaAIt2vSHXfzmd8W8G24aWdTbfPnE
         HhJaqcEikoCPpNO/Z3UFxKzo+dqg1FsKwoLLKpi5znQEGqNoRFw2RkN1A0C/Q3nsKA0J
         MzxEpebZQXk99Upo1oOJBbHvBpo3H+WfKEwgYgBh5gj+aG/VA3+B7lxjcIB4957y+Abc
         8vsRV30Q7K+cjGw6h1PeauwyX4Zv/RoOPLJZXRrfwZoPDUuvJDH4sgohvvjCFYXd5/ep
         PmKk3pSBQR8OUT1peWCA+lpPYK/ORZPjNS20TBPAYB56UhdS8mbF7UAXIUpSNRgBaJxV
         XMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706771500; x=1707376300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4MTyarJbOldtNhuHu6n9oQqi/8jRbXK/pPJRsFzR35U=;
        b=h8wou5gt+z/3FrMbYPTqHvdMYrK7X2/Mvr/yGmHE2PbO+mU2B36/gjNlMPSCFWpbBP
         AFXKmZNR/uZr+UEIWTmfTVdCYdy4Lq4Im1vnt6IpAMLi+CXGHqUk9ra7hye0IyMxMaOM
         D6zrN4PxT9BH7BksKIuSuTNNQrx5rlGfS8aYeqiuaRA9gRIcaG2fPS24ZxphdqjGSt5e
         vPIKvi/P4uqysKl90+KZGY20aSFeP/wRLB1J0xblBuZR3L0LaSoiWM/1rbcCJ8liePeR
         n1eouvNQr2YJzW1Y3r9BQenaKhpmY0sjPFVlyDqz1UBcs5WNJH13k6+fErOf7A2J4KsV
         DsPA==
X-Gm-Message-State: AOJu0Ywza+ciI7SSbhByvgVCruTWw7KMOAHB1iTVb7gVu2BgwECBrAm8
	0ZBPDraN4KHt83ym09gcVVhL6hZ2J3HfkB6lJc3mGCrJJOEhrlE+
X-Google-Smtp-Source: AGHT+IFhZNCP7pLIRaQX31qub5NUXs5YtlIDtuXNLxD7QXJ+jJ0TNtbNMHi4DTXv1oZX+7u7E8L0AQ==
X-Received: by 2002:a05:600c:1d22:b0:40e:9fd3:6b75 with SMTP id l34-20020a05600c1d2200b0040e9fd36b75mr3490821wms.2.1706771500051;
        Wed, 31 Jan 2024 23:11:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWZbPbEgyT54/x6K2CkuFor5xDD4w48ZY+aXRc6lotr2YXNh/x2FhappvkkZwiCsEX08OoinX8Rz13BAhMHHLq5S306Vu1mJ0UmxQ9U7ujOZUErQHRjvzQt4Z5sq+qfypV4Ekzp4bS25lBLwLd2l1vrfKLzmgQrJRqKvnoNONYdLgG8S3/8cImKaRg6fzTRy/vzFK8SFnmnOZC4kWV6aeERa1h9wv4aEMoH8qU542ujxvZ8LgsFp1CwLIghGMi6KuNzDNlMZyTUg/eswacp92gAMv/a23kAXkcNevTThGH9TORq2XWPRAGlaOt0yxdIu4cVPU0UiFDCyqTW3g8sTANARo3+m/7Ni8MQwDXmvDUHiYuAD68crmPV19iDMZ0qW/M=
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id t8-20020adfe108000000b0033921c383b2sm15263806wrz.67.2024.01.31.23.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 23:11:39 -0800 (PST)
Date: Thu, 1 Feb 2024 08:11:37 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v5 net-next 08/13] net: phy: marvell-88q2xxx: add support
 for temperature sensor
Message-ID: <20240201071137.GA41347@debian>
References: <20240122212848.3645785-1-dima.fedrau@gmail.com>
 <20240122212848.3645785-9-dima.fedrau@gmail.com>
 <65071184-428b-4850-9e0c-baaa73513c6d@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65071184-428b-4850-9e0c-baaa73513c6d@lunn.ch>

Am Wed, Jan 31, 2024 at 04:17:06PM +0100 schrieb Andrew Lunn:
> > +static int mv88q2xxx_hwmon_probe(struct phy_device *phydev)
> > +{
> > +	struct device *dev = &phydev->mdio.dev;
> > +	struct device *hwmon;
> > +	char *hwmon_name;
> > +	int ret;
> > +
> > +	/* Enable temperature sensor interrupt */
> > +	ret = phy_set_bits_mmd(phydev, MDIO_MMD_PCS,
> > +			       MDIO_MMD_PCS_MV_TEMP_SENSOR1,
> > +			       MDIO_MMD_PCS_MV_TEMP_SENSOR1_INT_EN);
> 
> You enable an interrupt, but i don't see any changes to the interrupt
> handler to handle any interrupts which are generated?
>
Hi Andrew,

you are right. Have to remove these lines. Besides enabling the interrupt
in MDIO_MMD_PCS_MV_TEMP_SENSOR1, there are two further register writes
necessary to make the interrupt propagate. I didn't want it to propagate.
Anyway it's wrong. I couldn't find a good solution to use the temperature
interrupt. Will have a look into this, and probably figuring out how to
do so. But it won't be part of this patch series.

Dimitri

