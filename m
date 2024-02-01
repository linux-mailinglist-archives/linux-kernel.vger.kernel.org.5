Return-Path: <linux-kernel+bounces-48497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A981845CEB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25D1E29153E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7B65A4FB;
	Thu,  1 Feb 2024 16:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWa3Mi8Q"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED23A5A4EC;
	Thu,  1 Feb 2024 16:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804081; cv=none; b=cY/u2YZCyy8aAlax+lQP+4oTKSTjvdthPNgmFVj4EebRmUQqU5Y9hof0HDrsoFmUMf7jO34UViIpH+HFZ1P0ONNABOFltHFrvyOjMqJme1aXVMnEJdqaK13m8gEwZkqvOgav9vR00E2RaQm/NKhq8K2FYA9PmvYm2Nxif8Z3+QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804081; c=relaxed/simple;
	bh=ncco8NqeugB/kq7KQpde9jMxzGMA8TKJcj0Em+XhoTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8tdqMPyBK9B16nIS1qaXARckuhYgro4dINcfejF82yxIX7sWaBqkIKOzzarJAj6apawKTopN1/oEiiWXEnq+YFAzkJUEIY8pdYoKg829ehECwIc2hDSJXzn185vRheXoYOpI/yEJz8OQsicNiV87IG3GJryS8VvS8mPM86zP+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWa3Mi8Q; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51120e285f6so1349422e87.2;
        Thu, 01 Feb 2024 08:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706804078; x=1707408878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Gfd/Jch068W4pwXVQxoLeTPeF9ebDcb3jfL8IeozdY=;
        b=ZWa3Mi8QYJH0QGw8Mhl3QdWT/lTq2QGD9oh+WAKnJE2fwB+g7u1miXxjkxofRFO9Pm
         rbDLTqhwY7kAVX7PbANW80/p2BAeVRc4yr0bMUrSyB1xdSeKkEsMfHaSAum7NcsSqJB4
         F8U9IHXZ8PK16Q7rMQlWXKelL5L/TwQ+zkbiq2rq8EOavfe1CGW85M95Y2ZbEgG/Btx3
         AFomehTYQYeG3W02Ho7BUrMuhRjRb5fpp1qR3zesM14tWtEOdqIxGgJyvMCLA37G+Ac4
         x4XU/Rbs56oiwRkO9ppKXDS6zQuLo5gfvlo8m/PfdXvnYzMhiUfvdTGPMyCxUGnCfqu/
         pTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706804078; x=1707408878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Gfd/Jch068W4pwXVQxoLeTPeF9ebDcb3jfL8IeozdY=;
        b=AOOEqw8ar9PcfB/3xj+kah0Xamt2JazAYzl9crSwIQiFU0+K2EM3y0OBwq/NQpxKyk
         IgljJ3xmQY4KtvBFFGjKfd4BpnZ2AEQzMClBp1Nis6chgMt4v8pQa2gy6m/8Vnd6vCed
         YTMx+Jp4NP+kI0rcjXxwT9Z8zqjefijWd+KmwwBcO6PzhqlSiOhKu/dV4eq01BnRN+Qh
         gQFSK8LyGrqcBfmfwr6CKMl8M31zwpBCmEbZapU7LCQNGicL4Cy2St1PtL6S3e/EqKEd
         Tadncvao8fMFOaNWmnUhwHzqrxxOHZa8ierhOq+vLajEcAfAUZp7g6Qw2L0hbH4LAnWl
         uG2g==
X-Gm-Message-State: AOJu0YzUTAelS148x4M6V1sdRAB0uD76e2KNQrmoYt6GWng2t7kSX3MP
	sebdovukFs+AV/fsnYlgOySLsjH6YDsKaawy/G/L9cvpHhN3yUovX5829A/b
X-Google-Smtp-Source: AGHT+IEs8nHnPdzf++bEISoMlJe1Auuulz6+xr1f07w18f6bKYuIICjifQZOkAoheTAaGcK40vtpxg==
X-Received: by 2002:a05:6512:376d:b0:510:c75:8e9d with SMTP id z13-20020a056512376d00b005100c758e9dmr2310236lft.26.1706804077668;
        Thu, 01 Feb 2024 08:14:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXagI9c2qRtWoUZ0sftsZbMiG4Khamf5UkQrxuhad4LfR7AsVYz69wHS/0ptr5enXbZ+ZVj58q+1xQjpdSIfmjRrkGQ29PpI08Z0UGQEM+sowEasm5VCm+DNBVcuIONR/SxiwSBlxBhz8o7fJpNS3purxtuHr5mJApsRNjA9HMPzE1UGWAYAAMkFFgDlkE6MuJWnpCQNyD8TLe4GMtO8olbrVJ6wcIFYi5b8g91GFBhEiBRFEk8z4WfZxhAIUPsjT4kvsMDh8igWThJrQUvnxXV1RZnlu3c4nN6HRA2juo/O1lK0KKGZiO+MWXjJbMFeFJnFgp1AYWlI/acnMhox+gdX+gCIDMJQeCSgLbOWGUrG+GqBpriq1yolvqIS5PEOM2GUg==
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c025200b0040d4e1393dcsm4876130wmj.20.2024.02.01.08.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 08:14:37 -0800 (PST)
Date: Thu, 1 Feb 2024 17:14:35 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
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
Message-ID: <20240201161435.GA48964@debian>
References: <20240122212848.3645785-1-dima.fedrau@gmail.com>
 <20240122212848.3645785-9-dima.fedrau@gmail.com>
 <65071184-428b-4850-9e0c-baaa73513c6d@lunn.ch>
 <20240201071137.GA41347@debian>
 <5dc7d495-dd41-4b1f-b0e0-1fe512f1687c@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dc7d495-dd41-4b1f-b0e0-1fe512f1687c@roeck-us.net>

Am Thu, Feb 01, 2024 at 05:34:05AM -0800 schrieb Guenter Roeck:
> On 1/31/24 23:11, Dimitri Fedrau wrote:
> > Am Wed, Jan 31, 2024 at 04:17:06PM +0100 schrieb Andrew Lunn:
> > > > +static int mv88q2xxx_hwmon_probe(struct phy_device *phydev)
> > > > +{
> > > > +	struct device *dev = &phydev->mdio.dev;
> > > > +	struct device *hwmon;
> > > > +	char *hwmon_name;
> > > > +	int ret;
> > > > +
> > > > +	/* Enable temperature sensor interrupt */
> > > > +	ret = phy_set_bits_mmd(phydev, MDIO_MMD_PCS,
> > > > +			       MDIO_MMD_PCS_MV_TEMP_SENSOR1,
> > > > +			       MDIO_MMD_PCS_MV_TEMP_SENSOR1_INT_EN);
> > > 
> > > You enable an interrupt, but i don't see any changes to the interrupt
> > > handler to handle any interrupts which are generated?
> > > 
> > Hi Andrew,
> > 
> > you are right. Have to remove these lines. Besides enabling the interrupt
> > in MDIO_MMD_PCS_MV_TEMP_SENSOR1, there are two further register writes
> > necessary to make the interrupt propagate. I didn't want it to propagate.
> > Anyway it's wrong. I couldn't find a good solution to use the temperature
> > interrupt. Will have a look into this, and probably figuring out how to
> > do so. But it won't be part of this patch series.
> > 
> 
> From hwmon perspective, the expected use of such an interrupt would be
> to call hwmon_notify_event() with the affected limit attribute as argument.
> This would notify the thermal subsystem if the sensor is registered with it
> (your patch doesn't set the necessary flag when registering the driver,
> so this would not happen), it will send a notification to the sysfs
> attribute, and generate a udev event.
>
Thanks, noted it down. Didn't know about the notification to the thermal
subsystem and the generated udev event. :)

Dimitri

