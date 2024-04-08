Return-Path: <linux-kernel+bounces-135232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAC689BD79
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDA821F22ED5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D955FB97;
	Mon,  8 Apr 2024 10:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="Ev4EiDC7"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F0D5EE8D;
	Mon,  8 Apr 2024 10:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712573251; cv=none; b=BQDgT94lb0phma7N15UXasGZLfR6qd332HaoVliDn72j8SGH8xCzRVmeVQGWLoULYqfxUXkW7b2zOiSnTbzWozXOetOAwdPU2G91pF/1ILCgf9GPDVQCX7XOTFo+EigHg0jofps+bz+1nG2JryLF8U+KphvnESx54NIWkWDVdyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712573251; c=relaxed/simple;
	bh=EULIeu2IYPBIomOsB6/HixDn+KPkFU5x4TipZmiOq50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJ2s1FnM1niSFbwJDza8+gwSHOuti45/5yD8tJb/2SmDlXMM6LI4vxl7FH/eDzb1pbKSVnGuhYD9D7GJsNZMpCQrno26mUjUtOq2ThyV8dBBOMsxkPnKKmrmhwmCmuC/rsnncRqYQ43ttqH+qzKwD0PiYpTO3/wvJnpATHats0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=Ev4EiDC7; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-29f93c4946cso2595329a91.1;
        Mon, 08 Apr 2024 03:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712573249; x=1713178049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Lem1V+ZUDVfxXhz5cIX+EVo2hjuDpYPyfQac0mlVZKQ=;
        b=ig/9jTcY3QZk4iL7vsNaNBi4LETfmC9dNZujev+sZYITMo8OdISI/eY1gvmHvSMj4X
         /LRxhei8wb1tySrH/cRqmARrxo/gBEix15z2jg8X4Zzzcw7GTP4T6yhkHxzVSllzUUDJ
         WhxEw0LJkBE+HfIkkuI/7yEpxpeXVO30jgDco25sJ6aiC6aD7lzgcUs+S4ndIqb0TvbC
         J7d07+9yuyr5R/wQBwz1pnEP6s2LhdeXvLvC9pN/G9sboN/o2Vh9zuehzR+H7MMgO4BP
         Dy8CR4Ypfyo/DdUMFSPIr0F6FuFO8OMqWoFQilx7m/3Hd2Uq9r6w2cwyvuudJnpwOFPW
         Wyeg==
X-Forwarded-Encrypted: i=1; AJvYcCX7vRqcNOHEnpNTgTDx0GzIfnoHa3XunPGDFAa6KrO6AX7qvE9cY8SApuCaocdZzJH//Qw7Hiif5j8qXYeNrnpBntmoCfEeLBDo3XzOLsdFsY4zEwul4i8ysy8VUWkEy4srAsiqX/HhCUw=
X-Gm-Message-State: AOJu0Yw1Mg5rQQiPBNbvu7VjRhTRxc45VC57qndEczXbKaxLX2tIG+Jf
	VoyUicVSPbyGGLbB3wls7twq3gKN+7Ao85uOE0YjOgnwKA+STaET
X-Google-Smtp-Source: AGHT+IFE+qtdK57REoxprWk8JnBiCKf8j0cyf03OkYGG9tc1+t8KBQyGbkuiRdKAgbVSfge9/19ivA==
X-Received: by 2002:a17:90a:6883:b0:2a2:2654:9e95 with SMTP id a3-20020a17090a688300b002a226549e95mr6679710pjd.36.1712573248958;
        Mon, 08 Apr 2024 03:47:28 -0700 (PDT)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id v12-20020a17090a898c00b0029df9355e79sm6111751pjn.13.2024.04.08.03.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 03:47:28 -0700 (PDT)
Date: Mon, 8 Apr 2024 07:47:16 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1712573246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lem1V+ZUDVfxXhz5cIX+EVo2hjuDpYPyfQac0mlVZKQ=;
	b=Ev4EiDC7vk3xSyXgyB+eLvQHuK8FVJqhqoAuYqE3kvCgY1I7wHzJ6O+PZrkia8ePEQDRiL
	3lCYPtpjLFcqig1pt2e0mLRZVJJgdAdwhfoQJn3sYKB9gO4KuzcRcVBVUx0/LUfQwM/YRf
	8S2J31ZZu0aTVlXBXjBUOoH5HPPKanli32ZJ6ZCXi7zbkbROqEyWgEO1ImGHqUfAUoCq+h
	LCMYXFXaxJ4RUNAJddtuwYlWXIWisbqGe23TxKQG22+K3QQLhUrmer1rOcsVmJEaae45iH
	oiaRN78WioFSgI4CnTFUwjhvnZzTKBO7CXDbAkqg/IrGVZJGBZfKNoWo3LfBkA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Sean Young <sean@mess.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] media: dvbdev: make dvb_class constant
Message-ID: <iduap7j36flhvmmsbvm6kzormftqi2xxfpndf62jp5lveljo3k@zgpxyqwckuuz>
References: <20240305-class_cleanup-media-v1-0-53e1538973cd@marliere.net>
 <20240305-class_cleanup-media-v1-1-53e1538973cd@marliere.net>
 <ae5840f3-7e19-4d60-bd87-567068a3f813@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae5840f3-7e19-4d60-bd87-567068a3f813@xs4all.nl>

Hi Hans!

On  8 Apr 11:47, Hans Verkuil wrote:
> On 05/03/2024 14:26, Ricardo B. Marliere wrote:
> > Since commit 43a7206b0963 ("driver core: class: make class_register() take
> > a const *"), the driver core allows for struct class to be in read-only
> > memory, so move the dvb_class structure to be declared at build time
> > placing it into read-only memory, instead of having to be dynamically
> > allocated at boot time.
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> > ---
> >  drivers/media/dvb-core/dvbdev.c | 23 +++++++++++++----------
> >  1 file changed, 13 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
> > index 733d0bc4b4cc..dcbf68b00240 100644
> > --- a/drivers/media/dvb-core/dvbdev.c
> > +++ b/drivers/media/dvb-core/dvbdev.c
> > @@ -78,7 +78,13 @@ static const u8 minor_type[] = {
> >  #define MAX_DVB_MINORS		(DVB_MAX_ADAPTERS * 64)
> >  #endif
> >  
> > -static struct class *dvb_class;
> > +static int dvb_uevent(const struct device *dev, struct kobj_uevent_env *env);
> > +static char *dvb_devnode(const struct device *dev, umode_t *mode);
> 
> Forward references are typically something you want to avoid.
> 
> Looking at the code, I think it makes sense to just move those two functions
> to just before this dvb_class.

Ack.

> 
> > +static const struct class dvb_class = {
> > +	.name = "dvb",
> > +	.dev_uevent = dvb_uevent,
> > +	.devnode = dvb_devnode,
> > +};
> >  
> >  static struct dvb_device *dvb_minors[MAX_DVB_MINORS];
> >  static DECLARE_RWSEM(minor_rwsem);
> 
> Also move the dvb_class (+ the two functions) to after this line. I think that's
> a more suitable place for this.

Ack.

> 
> > @@ -561,7 +567,7 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
> >  		return ret;
> >  	}
> >  
> > -	clsdev = device_create(dvb_class, adap->device,
> > +	clsdev = device_create(&dvb_class, adap->device,
> >  			       MKDEV(DVB_MAJOR, minor),
> >  			       dvbdev, "dvb%d.%s%d", adap->num, dnames[type], id);
> >  	if (IS_ERR(clsdev)) {
> > @@ -600,7 +606,7 @@ void dvb_remove_device(struct dvb_device *dvbdev)
> >  
> >  	dvb_media_device_free(dvbdev);
> >  
> > -	device_destroy(dvb_class, MKDEV(DVB_MAJOR, dvbdev->minor));
> > +	device_destroy(&dvb_class, MKDEV(DVB_MAJOR, dvbdev->minor));
> >  
> >  	list_del(&dvbdev->list_head);
> >  }
> > @@ -1096,13 +1102,10 @@ static int __init init_dvbdev(void)
> >  		goto error;
> >  	}
> >  
> > -	dvb_class = class_create("dvb");
> > -	if (IS_ERR(dvb_class)) {
> > -		retval = PTR_ERR(dvb_class);
> > +	retval = class_register(&dvb_class);
> > +	if (retval != 0)
> 
> This can just be 'if (retval)'.

But then it would be on a different style than the rest of the function:

static int __init init_dvbdev(void)
{
	int retval;
	dev_t dev = MKDEV(DVB_MAJOR, 0);

	retval = register_chrdev_region(dev, MAX_DVB_MINORS, "DVB");
	if (retval != 0) {
		pr_err("dvb-core: unable to get major %d\n", DVB_MAJOR);
		return retval;
	}

	cdev_init(&dvb_device_cdev, &dvb_device_fops);
	retval = cdev_add(&dvb_device_cdev, dev, MAX_DVB_MINORS);
	if (retval != 0) {
		pr_err("dvb-core: unable register character device\n");
		goto error;
	}

	retval = class_register(&dvb_class);
	if (retval != 0)
		goto error;

	return 0;

error:
	cdev_del(&dvb_device_cdev);
	unregister_chrdev_region(dev, MAX_DVB_MINORS);
	return retval;
}


> 
> >  		goto error;
> > -	}
> > -	dvb_class->dev_uevent = dvb_uevent;
> > -	dvb_class->devnode = dvb_devnode;
> > +
> >  	return 0;
> >  
> >  error:
> > @@ -1115,7 +1118,7 @@ static void __exit exit_dvbdev(void)
> >  {
> >  	struct dvbdevfops_node *node, *next;
> >  
> > -	class_destroy(dvb_class);
> > +	class_unregister(&dvb_class);
> >  	cdev_del(&dvb_device_cdev);
> >  	unregister_chrdev_region(MKDEV(DVB_MAJOR, 0), MAX_DVB_MINORS);
> >  
> > 
> 
> Regards,
> 
> 	Hans

