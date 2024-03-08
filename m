Return-Path: <linux-kernel+bounces-97172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CAE876674
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCFC12836F2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA6C1852;
	Fri,  8 Mar 2024 14:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="AMkyxkhp"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621271C10;
	Fri,  8 Mar 2024 14:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709908702; cv=none; b=e60bnYYML0YEgFvAaM7/mEn5thMb7A3IJRkAyaTRHe33dyCVzmvinIaIEoYd2oaVTl9Sya3xkFNx7Njs9BZ9VKJYeEuJhsgVuvptOsNIGTv9ftXwtNdeQNYEpLmLgZ22SqLFAQhh9qVOpRR3n3sqXGrIs7MkCDllB3MepTL+doE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709908702; c=relaxed/simple;
	bh=AWU8JZzww9lm6MMcdbopN83Emhpz7ZofASAw35I91Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=el40jgx4a9viN94tIXm7t+CtdfgUCUi4ZsB2d8IvAkIFRrV/C06kXSU0ts5p8oAWkQHclHU+HwEA30tZh3n6WmPCcS9bRKmzo/+KONm4UuvUso9InzajHUqdEwLM5qP+794Q5hy+Yonc821ejjzbGzR7EpV5N7kX1C0koqjDrj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=AMkyxkhp; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5e42b4bbfa4so614424a12.1;
        Fri, 08 Mar 2024 06:38:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709908699; x=1710513499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+L02QjpMQRZ069rkHNYFfs2NyDQEigdeN50RLq0y49c=;
        b=LfjR1hyyRg/668taFQ345FxdZA6neNxN1ifHaPRY0xhUJt2cM+KJcBnY1idLW3V3OX
         uqOmWwbYJ6Z3vHGQUHZud1Rz3rJDOXjFZWfd6ezpgZZ0xnfD0GBP4r5cGe+2HK1aLzLg
         le9bEmQNc2KT3y3NDezPskXGo66wygGLlVoVd6/1FdQ+9hdw2ulb/wGV3CSzzhpDlAat
         aByfBemQ436MyyrwSlBRxEukhXG0Rq64w68VCYwmkDcX3dVNfqdnjaLJIka9A3CRcWNR
         10Z6rrk45Es2PaWXbg7bi2NStYdt1sanPcXtP127a2mclh9pYjC8/h1BcvHocMesaoua
         +D7g==
X-Forwarded-Encrypted: i=1; AJvYcCUauDwvUjmX4stuWKXCXoJPBTJrgJmCjBnhkk0jOncSVAL/4SyKo+zhAgUc4mxSfhPrAs4TlgnBCFBXS9OAOUi8TybCiYX2xMXEoV6q4AF0HdM8B5dVu2XBCgfk0CxArDDzGtNREz4BTg==
X-Gm-Message-State: AOJu0Yzyw9pUMZYiJLdj+sbhopdb0FjMoPVg4If7fZQd4F/CMjtWbdew
	04KIH4OMcBWY3cwMJKl9MiWsi7yQqMSai6VEVaEGjq/svSd9raRnueLXwI95DrQZfg==
X-Google-Smtp-Source: AGHT+IGd9CcgNL4AyW+WdK1pSzf58ougf2hPga9oEH4y7yiPLhfFX9Y6k+Hn9V1sgO0e8Mce7n34ng==
X-Received: by 2002:a05:6a20:2e26:b0:1a1:4b57:4e9b with SMTP id be38-20020a056a202e2600b001a14b574e9bmr8979143pzb.60.1709908699406;
        Fri, 08 Mar 2024 06:38:19 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id s68-20020a635e47000000b005b458aa0541sm14184838pgb.15.2024.03.08.06.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 06:38:18 -0800 (PST)
Date: Fri, 8 Mar 2024 11:38:14 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709908697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+L02QjpMQRZ069rkHNYFfs2NyDQEigdeN50RLq0y49c=;
	b=AMkyxkhp27aNrIpRbxDO2+so1h6RG8mwZo2r2cRTZlI5s3Htzy4B5Gd8KGyIgOGp+9LJ0R
	v7cP1ifymhhZw2/CYPzi8y9ucatTr7hBe26TweqWUynh0dveVG2pOgyPAyg44H661ux84f
	A5X9LxVCtOYCW59y9bKuXYG9o8PumUXw5gPgbDDV5tBZtn1/bBuKM9EkT3sFdytjNj9Aon
	FHqX4OdDba8go4W+smrmBPbf0e7GKwkMtas0xvBnGkbc+A8Fe2s8VkAFI7eEnXD5T6vbo+
	jXodc4j19vm8VpPSUhtlR/FEAkfD6W9VkqMQP+HDzFbER/NiNUiUYxGtVkoZ1A==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/6] s390: zcrypt: make zcrypt_class constant
Message-ID: <nh5d7ock5gb4zttfmq354si3iewm4u2zxqquzg3erl55jxjhuo@5yveroq4li4s>
References: <20240305-class_cleanup-s390-v1-0-c4ff1ec49ffd@marliere.net>
 <20240305-class_cleanup-s390-v1-1-c4ff1ec49ffd@marliere.net>
 <84263def1d38584cd83558a33bb52f22@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84263def1d38584cd83558a33bb52f22@linux.ibm.com>

On  8 Mar 15:19, Harald Freudenberger wrote:
> On 2024-03-05 12:25, Ricardo B. Marliere wrote:
> > Since commit 43a7206b0963 ("driver core: class: make class_register()
> > take
> > a const *"), the driver core allows for struct class to be in read-only
> > memory, so move the zcrypt_class structure to be declared at build time
> > placing it into read-only memory, instead of having to be dynamically
> > allocated at boot time.
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> > ---
> >  drivers/s390/crypto/zcrypt_api.c | 33 +++++++++++++++++----------------
> >  1 file changed, 17 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/s390/crypto/zcrypt_api.c
> > b/drivers/s390/crypto/zcrypt_api.c
> > index e8742757085b..d0358bb6ccf2 100644
> > --- a/drivers/s390/crypto/zcrypt_api.c
> > +++ b/drivers/s390/crypto/zcrypt_api.c
> > @@ -116,7 +116,11 @@ EXPORT_SYMBOL(zcrypt_msgtype);
> > 
> >  struct zcdn_device;
> > 
> > -static struct class *zcrypt_class;
> > +static void zcdn_device_release(struct device *dev);
> > +static const struct class zcrypt_class = {
> > +	.name = ZCRYPT_NAME,
> > +	.dev_release = zcdn_device_release,
> > +};
> >  static dev_t zcrypt_devt;
> >  static struct cdev zcrypt_cdev;
> > 
> > @@ -139,7 +143,7 @@ static int zcdn_destroy(const char *name);
> >   */
> >  static inline struct zcdn_device *find_zcdndev_by_name(const char
> > *name)
> >  {
> > -	struct device *dev = class_find_device_by_name(zcrypt_class, name);
> > +	struct device *dev = class_find_device_by_name(&zcrypt_class, name);
> > 
> >  	return dev ? to_zcdn_dev(dev) : NULL;
> >  }
> > @@ -151,7 +155,7 @@ static inline struct zcdn_device
> > *find_zcdndev_by_name(const char *name)
> >   */
> >  static inline struct zcdn_device *find_zcdndev_by_devt(dev_t devt)
> >  {
> > -	struct device *dev = class_find_device_by_devt(zcrypt_class, devt);
> > +	struct device *dev = class_find_device_by_devt(&zcrypt_class, devt);
> > 
> >  	return dev ? to_zcdn_dev(dev) : NULL;
> >  }
> > @@ -405,7 +409,7 @@ static int zcdn_create(const char *name)
> >  		goto unlockout;
> >  	}
> >  	zcdndev->device.release = zcdn_device_release;
> > -	zcdndev->device.class = zcrypt_class;
> > +	zcdndev->device.class = &zcrypt_class;
> >  	zcdndev->device.devt = devt;
> >  	zcdndev->device.groups = zcdn_dev_attr_groups;
> >  	if (name[0])
> > @@ -2067,12 +2071,9 @@ static int __init zcdn_init(void)
> >  	int rc;
> > 
> >  	/* create a new class 'zcrypt' */
> > -	zcrypt_class = class_create(ZCRYPT_NAME);
> > -	if (IS_ERR(zcrypt_class)) {
> > -		rc = PTR_ERR(zcrypt_class);
> > +	rc = class_register(&zcrypt_class);
> > +	if (rc)
> >  		goto out_class_create_failed;
> > -	}
> > -	zcrypt_class->dev_release = zcdn_device_release;
> > 
> >  	/* alloc device minor range */
> >  	rc = alloc_chrdev_region(&zcrypt_devt,
> > @@ -2088,35 +2089,35 @@ static int __init zcdn_init(void)
> >  		goto out_cdev_add_failed;
> > 
> >  	/* need some class specific sysfs attributes */
> > -	rc = class_create_file(zcrypt_class, &class_attr_zcdn_create);
> > +	rc = class_create_file(&zcrypt_class, &class_attr_zcdn_create);
> >  	if (rc)
> >  		goto out_class_create_file_1_failed;
> > -	rc = class_create_file(zcrypt_class, &class_attr_zcdn_destroy);
> > +	rc = class_create_file(&zcrypt_class, &class_attr_zcdn_destroy);
> >  	if (rc)
> >  		goto out_class_create_file_2_failed;
> > 
> >  	return 0;
> > 
> >  out_class_create_file_2_failed:
> > -	class_remove_file(zcrypt_class, &class_attr_zcdn_create);
> > +	class_remove_file(&zcrypt_class, &class_attr_zcdn_create);
> >  out_class_create_file_1_failed:
> >  	cdev_del(&zcrypt_cdev);
> >  out_cdev_add_failed:
> >  	unregister_chrdev_region(zcrypt_devt, ZCRYPT_MAX_MINOR_NODES);
> >  out_alloc_chrdev_failed:
> > -	class_destroy(zcrypt_class);
> > +	class_unregister(&zcrypt_class);
> >  out_class_create_failed:
> >  	return rc;
> >  }
> > 
> >  static void zcdn_exit(void)
> >  {
> > -	class_remove_file(zcrypt_class, &class_attr_zcdn_create);
> > -	class_remove_file(zcrypt_class, &class_attr_zcdn_destroy);
> > +	class_remove_file(&zcrypt_class, &class_attr_zcdn_create);
> > +	class_remove_file(&zcrypt_class, &class_attr_zcdn_destroy);
> >  	zcdn_destroy_all();
> >  	cdev_del(&zcrypt_cdev);
> >  	unregister_chrdev_region(zcrypt_devt, ZCRYPT_MAX_MINOR_NODES);
> > -	class_destroy(zcrypt_class);
> > +	class_unregister(&zcrypt_class);
> >  }
> > 
> >  /*
> 
> Thanks Ricardo, nice work.
> The only thing I would do is to rename the label "out_class_create_failed"
> with "out_class_register_failed".

Ah, indeed. Thanks for catching that. I will wait for more feedback on
the other patches and send a v2 if required.

> 
> Who will pick this patch? As this is part of a bundle of fixes, Richardo
> do you have a way to push this into the kernel? Otherwise as the AP/zcrypt
> maintainer I would pick only this patch and forward it to the s390
> subsystem.

I have no ways of pushing this, sorry. The series is based on
s390/linux.git/for-next, so perhaps the s390 maintainers can pick this
one along with the others with your Acked-by: provided? :) 

Thank you,
-	Ricardo.


> 
> Acked-by: Harald Freudenberger <freude@linux.ibm.com>
> 

