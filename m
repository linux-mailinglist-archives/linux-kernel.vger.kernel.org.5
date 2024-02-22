Return-Path: <linux-kernel+bounces-77384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B16286049B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A6371F2669D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA88D73F3D;
	Thu, 22 Feb 2024 21:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="kLqJfTad"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5572912D1E4;
	Thu, 22 Feb 2024 21:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708636630; cv=none; b=ci7sfUvTCgAymb+CfZDY1/yeHwbkaqAZ7PQx1RWlBxz73lZJhkSFawtr3tYvrRa5yJYiNSJzfEI27n2vSlOgnp3BBJcgHXb42wn34jDcsZwcAbOYb+AVwWxP95c38CrUZksP1+f65SWrOdswKjeCOarQGv0GaRewxzuIRhmb9Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708636630; c=relaxed/simple;
	bh=M8tOhP9vVT2zqHrXHSSFO6m8Wbbuioy5RDsNkfbHSEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TyqPKmFF6Y6dM/dz82ZYyGzZWPR6SOOlQVH0Py7pMepQGnzsucQsb6bc3mslqdeH2BdGdpMdEA/qW+/ykuCOqcOS8TLW8Yd0wHmMjQOXnbEtzuLP75n0XWHOIpFYdG2lbAfZZJqDZpWQlw+3g+r85agEG5PBYQRiKFMo3qpTsAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=kLqJfTad; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e471f5f1a5so76456b3a.1;
        Thu, 22 Feb 2024 13:17:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708636627; x=1709241427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3mzUEcrROuIEmoz2lID89JhamlaTPR97gp/6PZMhGpY=;
        b=EDJN5lTE2BBH4LfCGUb+rP5XGnW5qf6QxgwbVAPsVJepKghW9wgHKTMK/v7xl0GH/K
         k7w1AlcBG0qG/Y8MK5NwA/5bw9LG8w9KJneE2NxHmv4WIvjAbtU2BOFNWkC1eHgooiUf
         IKmmPpMWJdg/wdaV4mpnUdS3SDycBIDhPPc2vonY92MoIQejMbquCm4ChQpBtOxNdZMw
         uLKxavKbJ+gjcXnc+NI58L+hW1/c7MZGJma+bI2ulFbAn5k3Dveow2IZnuUeIw9EPTxz
         bqpJQgfuAhkjHNp0XcQ4c1XtJc3hidicWVDeu6Rjx4Zj0MJWT+9KHrTTs7aAPyttRXnl
         6pFw==
X-Forwarded-Encrypted: i=1; AJvYcCUNk3uXUN5ovgg8F3L+SfJlqca4qJbZyPByV2rD4dbz39D2PqdqXi17Cgqi29TfaLPJlIHCWQt/sxQOBqJynfQRV+HNe3+xSlW6dz67
X-Gm-Message-State: AOJu0Yx/olgIQqQ2zQMWaGhBXoV4ujgiTeTzFAsN9Gg9EqDYQ7p1DlnT
	iqeWeC4IH3JtpgmuaFrlp+ouHyPmM1XOJk1zXS/oMXCIRRrZqbuuJUMZtIg9
X-Google-Smtp-Source: AGHT+IFIatEutbGRxbG0rE/AhqKtAUzidtuAWgdwZV9bDbTlEwkK2c/a3mSRVionJ+/NJDt/WRfz5Q==
X-Received: by 2002:a62:ce0e:0:b0:6e3:f013:463 with SMTP id y14-20020a62ce0e000000b006e3f0130463mr64614pfg.28.1708636627524;
        Thu, 22 Feb 2024 13:17:07 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id du22-20020a056a002b5600b006e45d5f0645sm9074358pfb.101.2024.02.22.13.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 13:17:06 -0800 (PST)
Date: Thu, 22 Feb 2024 18:17:52 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708636625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3mzUEcrROuIEmoz2lID89JhamlaTPR97gp/6PZMhGpY=;
	b=kLqJfTadNsH5JMqLyu+Iae59QBo+Uiv3E+A7jRKUvMYIhqRNlLCFBoPHTouBdCMoG8OR8R
	LaMD6ln9taWUWtZmLwUp7fnYVtD1os4oazkCPT8RfIJSSvG6Zk3LTII/k4yI2/BUm67XLu
	q2L8E/SWnj8ih9oA1roqfrEpqwvg3wkxq6gbxrkBLN4FxqD0m65RrntEUks1F2LZIGBxl2
	QgGdOuI34Y8AMYIIppPLrXttPll+GDyJetkZRY8Tg6gEudboJ6TJeaZjjiP4a/LMg7ZTxQ
	mBZFL+6jyXrBDrrDLwAJ6earTJeZvK4Hi1eWe9UKV8bOR6PGNoXImkGvwFbjyw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] power: supply: sysfs: constify the struct device_type
 usage
Message-ID: <fzakqxmfrx7jh73ylxikjd2ehltqgkncfn2ks4chbncssfzch7@g6epshmmdanp>
References: <20240220-device_cleanup-power-v1-1-e2b9e0cea072@marliere.net>
 <j2boiqkk7fwexefgwxoytk2gdx4an5snfm4bjtflnr7wwxf5yj@g5dcmcaor453>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <j2boiqkk7fwexefgwxoytk2gdx4an5snfm4bjtflnr7wwxf5yj@g5dcmcaor453>

Hi Sebastian,

On 21 Feb 21:46, Sebastian Reichel wrote:
> Hi,
> 
> On Tue, Feb 20, 2024 at 03:40:06PM -0300, Ricardo B. Marliere wrote:
> > Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> > core can properly handle constant struct device_type. Move the
> > power_supply_dev_type variable to be a constant structure as well, placing
> > it into read-only memory which can not be modified at runtime.
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> > ---
> >  drivers/power/supply/power_supply.h       | 4 ++--
> >  drivers/power/supply/power_supply_core.c  | 2 +-
> >  drivers/power/supply/power_supply_sysfs.c | 9 ++++++---
> >  3 files changed, 9 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/power/supply/power_supply.h b/drivers/power/supply/power_supply.h
> > index 645eee4d6b6a..d547dbe5676f 100644
> > --- a/drivers/power/supply/power_supply.h
> > +++ b/drivers/power/supply/power_supply.h
> > @@ -15,12 +15,12 @@ struct power_supply;
> >  
> >  #ifdef CONFIG_SYSFS
> >  
> > -extern void power_supply_init_attrs(struct device_type *dev_type);
> > +extern void power_supply_init_attrs(const struct device_type *dev_type);
> >  extern int power_supply_uevent(const struct device *dev, struct kobj_uevent_env *env);
> >  
> >  #else
> >  
> > -static inline void power_supply_init_attrs(struct device_type *dev_type) {}
> > +static inline void power_supply_init_attrs(const struct device_type *dev_type) {}
> >  #define power_supply_uevent NULL
> >  
> >  #endif /* CONFIG_SYSFS */
> > diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> > index ecef35ac3b7e..fda21cf4111c 100644
> > --- a/drivers/power/supply/power_supply_core.c
> > +++ b/drivers/power/supply/power_supply_core.c
> > @@ -31,7 +31,7 @@ EXPORT_SYMBOL_GPL(power_supply_class);
> >  
> >  static BLOCKING_NOTIFIER_HEAD(power_supply_notifier);
> >  
> > -static struct device_type power_supply_dev_type;
> > +static const struct device_type power_supply_dev_type;
> 
> This creates an empty struct, which is being used in this file...
> 
> >  
> >  #define POWER_SUPPLY_DEFERRED_REGISTER_TIME	msecs_to_jiffies(10)
> >  
> > diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> > index 977611e16373..ed365ca54c90 100644
> > --- a/drivers/power/supply/power_supply_sysfs.c
> > +++ b/drivers/power/supply/power_supply_sysfs.c
> > @@ -399,12 +399,15 @@ static const struct attribute_group *power_supply_attr_groups[] = {
> >  	NULL,
> >  };
> >  
> > -void power_supply_init_attrs(struct device_type *dev_type)
> > +static const struct device_type power_supply_dev_type = {
> > +	.name = "power_supply",
> > +	.groups = power_supply_attr_groups,
> > +};
> 
> ... and this creates the correct one in power_supply_sysfs.c, but it
> is not being used at all. Maybe get some sleep and/or read again
> what 'static' means for a global variable?

Oh, silly me. This was a stupid patch indeed, sorry about that. I'll
send a proper fix later!

Thanks for reviewing,
-	Ricardo.


> 
> > +void power_supply_init_attrs(const struct device_type *dev_type)
> >  {
> 
> This function no longer uses dev_type argument, so you can remove
> it.
> 
> -- Sebastian
> 
> >  	int i;
> >  
> > -	dev_type->groups = power_supply_attr_groups;
> > -
> 
> >  	for (i = 0; i < ARRAY_SIZE(power_supply_attrs); i++) {
> >  		struct device_attribute *attr;
> >  
> > 
> > ---
> > base-commit: a9b254892ce1a447b06c5019cbf0e9caeb48c138
> > change-id: 20240220-device_cleanup-power-037594022cb1
> > 
> > Best regards,
> > -- 
> > Ricardo B. Marliere <ricardo@marliere.net>
> > 



