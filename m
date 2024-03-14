Return-Path: <linux-kernel+bounces-103756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B042787C408
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 273B71F21CB0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C711676034;
	Thu, 14 Mar 2024 20:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Md6Z9Y6q"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFD876020;
	Thu, 14 Mar 2024 20:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710446798; cv=none; b=TNcpHBV9AGIsJs2sPlQUKZoUh4RMwCzU2ez7kbaPm1AcYmfOUXfvjqcYLEwXoLiCornO8zPRssNDphGwgoYvHyhoW7EpSzZ4+MPK18sGxKAZcq8m4gLJ9symG10pJ26F1evag0Rn+dVHWP9huDOYf6Yjw1lDY5gZxywzGTu14l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710446798; c=relaxed/simple;
	bh=uG6TRQMGLMiupX26itOp9SVRhnU7pyd5Vv1ntd0MO9Y=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyoWPkxGzukRDe+o8K6rFF3gbxUKzDa7NQzgrBToCUOHoo9KkQR894FzCDXciL3+yDajDLX8vRmJH2nGgfapzia52MYVp7nU5iKE89YSpl7ffahC1zN4kafjpK7lI6ea85rPGPen48HZdVxKo/trXpN3Rpo6J8ud1VdMihYoWYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Md6Z9Y6q; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d28051376eso17068631fa.0;
        Thu, 14 Mar 2024 13:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710446795; x=1711051595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tMSMoF4sWu22K90iVg3HlWc7k64o9qa1vNgxWQ2mgsg=;
        b=Md6Z9Y6q8oC0PeVcF7DKgDrzDY2AMFyc7QmjVMmz5tniMm/W/oSyom+xHQvmqijL9I
         x70AR6whir/V4xyqrIgopvBi/ZCks+ZI5ECXWA1YZujh447a69+ZVdAfIYKj9Q5w5xs9
         OfwLjY5fo/PPWYfoB/U3OGKs5baC1L1jlRyN15Wb25raJG4R4FdNuqWlRENeYhlPzYnw
         lVB/8SVbOCDQj56TnxX1dXv7gv5IgWzFRrwcAOodnZXjJcRvT6BVgcFnJJ9bSUcm98IP
         orVRa4MPPJwLfgOOibpSWzG1cU5bV8jmdvShudjFK9ir0xFzq0tApO/hoOtBOHcnI0iE
         KYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710446795; x=1711051595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMSMoF4sWu22K90iVg3HlWc7k64o9qa1vNgxWQ2mgsg=;
        b=LzIatLLVkX3hi1ARySyYVlj5Z27VGQURSiRV7B2tOJTtPEzdggdbCw39fFpIGH7OKV
         bWD9QlnlOd/w6jlaMIFRIiHO5/Pih1S3lm2NQEn86eyS3cFUcdfVb0CKJWNExeksogBd
         p8BS9NYsF9L7YcPKrvEhApwDFuxqY1yolPzr5PwDBYtLQwSMeHXphCzbpgWTmGdFSKs8
         oES8ddaEz2KU60NU+5pLW8YoxYamc4+Y6mHDrWKfkIDadd+g+mFwBDroEHKpHtI/Zho2
         zUjLZU42WLgzbrzpUA1N6K+zDqd1+eqe+V+xEygIGQHqrzuZETH19cM0UkGCce3o2FSi
         3+PA==
X-Forwarded-Encrypted: i=1; AJvYcCW1UW05Ki1Jn1Fh+NNb4uK1vl7mxe4RIoskgzGOevRLjtOsuf7kOtnhKQdO2cGbyv1nXz6ebrJ7WI+Y1VZbFGrzVULLXPATgnwuyxxyfbDCyZUcjAYDrUL19JcxR4JdxybJJK9FsPi7
X-Gm-Message-State: AOJu0Yw1Q1PrHE+Zy+ZKx6ddNRwIo+mordKTPz/Z32SKYua4R9KYVZP5
	pfRKkgLBzxA5XdFukEMr7eqjVUPC+5zGEUmFGelZS+HaqLuwguRT
X-Google-Smtp-Source: AGHT+IH7mQoMPG/bkAVKYsAzozgfN3o44fOKz16Tu25G2wZJcEEsy7/st9OjAYbYGNlMpkpd79o4vw==
X-Received: by 2002:a2e:321a:0:b0:2d3:5020:17e5 with SMTP id y26-20020a2e321a000000b002d3502017e5mr846397ljy.36.1710446794701;
        Thu, 14 Mar 2024 13:06:34 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:3844:3925:f1c1:4bc5])
        by smtp.gmail.com with ESMTPSA id v19-20020a1709060b5300b00a465f73df07sm1025024ejg.148.2024.03.14.13.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 13:06:34 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Thu, 14 Mar 2024 21:06:31 +0100
To: Jonathan Cameron <jic23@kernel.org>
Cc: vamoirid <vassilisamir@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	lars@metafoo.de, ang.iglesiasg@gmail.com, mazziesaccount@gmail.com,
	ak@it-klinger.de, petre.rodan@subdimension.ro,
	linus.walleij@linaro.org, phil@raspberrypi.com, 579lpy@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] iio: pressure: add SCALE and RAW values for
 channels
Message-ID: <20240314200631.GB1964894@vamoiridPC>
References: <20240313174007.1934983-1-vassilisamir@gmail.com>
 <20240313174007.1934983-4-vassilisamir@gmail.com>
 <ZfH4bET-HX0e3PO_@smile.fi.intel.com>
 <20240313195110.GB1938985@vamoiridPC>
 <ZfIGtUPZpyDBnWwz@smile.fi.intel.com>
 <20240313212812.GE1938985@vamoiridPC>
 <ZfLYGL/vXMHUGghz@vamoirid-EDL-PC>
 <20240314144647.291a1100@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314144647.291a1100@jic23-huawei>

On Thu, Mar 14, 2024 at 02:46:47PM +0000, Jonathan Cameron wrote:
> On Thu, 14 Mar 2024 11:57:28 +0100
> vamoirid <vassilisamir@gmail.com> wrote:
> 
> > On Wed, Mar 13, 2024 at 10:28:12PM +0100, Vasileios Amoiridis wrote:
> > > On Wed, Mar 13, 2024 at 10:04:05PM +0200, Andy Shevchenko wrote:  
> > > > On Wed, Mar 13, 2024 at 08:51:10PM +0100, Vasileios Amoiridis wrote:  
> > > > > On Wed, Mar 13, 2024 at 09:03:08PM +0200, Andy Shevchenko wrote:  
> > > > > > On Wed, Mar 13, 2024 at 06:40:04PM +0100, Vasileios Amoiridis wrote:  
> > > > > > > Add extra IIO_CHAN_INFO_SCALE and IIO_CHAN_INFO_RAW in order to be
> > > > > > > able to calculate the processed value with standard userspace IIO
> > > > > > > tools. Can be used for triggered buffers as well.  
> > > > 
> > > > ...
> > > >   
> > > > > > > +	case IIO_CHAN_INFO_RAW:
> > > > > > > +		switch (chan->type) {
> > > > > > > +		case IIO_HUMIDITYRELATIVE:
> > > > > > > +			*val = data->chip_info->read_humid(data);
> > > > > > > +			ret = IIO_VAL_INT;
> > > > > > > +			break;
> > > > > > > +		case IIO_PRESSURE:
> > > > > > > +			*val = data->chip_info->read_press(data);
> > > > > > > +			ret = IIO_VAL_INT;
> > > > > > > +			break;
> > > > > > > +		case IIO_TEMP:
> > > > > > > +			*val = data->chip_info->read_temp(data);
> > > > > > > +			ret = IIO_VAL_INT;
> > > > > > > +			break;
> > > > > > > +		default:
> > > > > > > +			ret = -EINVAL;
> > > > > > > +			break;  
> > > > > > 
> > > > > > Is it mutex that prevents us from returning here?
> > > > > > If so, perhaps switching to use cleanup.h first?  
> > > > > 
> > > > > I haven't seen cleanup.h used in any file and now that I searched,
> > > > > only 5-6 are including it.  
> > > > 
> > > > Hmm... Which repository you are checking with?
> > > > 
> > > > $ git grep -lw cleanup.h -- drivers/ | wc -l
> > > > 47
> > > > 
> > > > (Today's Linux Next)
> > > >  
> > > 
> > > I am checking the drivers/iio of 6.8 (on sunday) and I can only find 7
> > > drivers that use it.
> 
> Yes - but that's because it's new - most of the stuff in 6.8 was the proof
> points for the patches originally introducing support for autocleanup (so typically
> one or two cases for each type of handling) That doesn't mean we don't want it
> in drivers that are being worked upon if it gives a significant advantage.
> Some features we need will merge shortly, and a great deal more usage
> of this autocleanup will occur.
> 
> > >   
> > > > > I am currently thinking if the mutex
> > > > > that already exists is really needed since most of the drivers
> > > > > don't have it + I feel like this is something that should be done
> > > > > by IIO, thus maybe it's not even needed here.  
> > > >  
> > 
> > After some researching today, I realized that all the                           
> > {read/write}_{raw/avail}_{multi/}() functions are in drivers/iio/inkern.c
> > for channel mapping in the kernel and it looks like they are guarded by
> > the mutex_{un}lock(&iio_dev_opaque->info_exist_lock).
> 
> Why is that relevant to this patch which isn't using that interface at all?
> Those protections are to ensure that a consumer driver doesn't access a removed
> IIO device, not accesses directly from userspace.
> 
> >so I feel that the
> > mutexes in the aforementioned functions can be dropped. When you have the
> > time please have a look, maybe the could be dropped.
> 
> Identify what your locks are protecting.  Those existence locks have
> very specific purpose and should not be relied on for anything else.
> 
> If this driver is protecting state known only to itself, then it must
> be responsible for appropriate locking.
> 
> > 
> > In general, there is quite some cleaning that can be done in this driver
> > but is it wise to include it in the triggered buffer support series??? 
> 
> Generally if working on a driver and you see cleanup that you think should
> be done, it belongs before any series adding new features, precisely because
> that code can typically end up simpler as a result.  This sounds like one
> of those cases.  Normally that only includes things that are directly related
> to resulting code for new features (or applying the same cleanup across a driver)
> as we don't want to make people do a full scrub of a driver before adding
> anything as it will just create too much noise.
> 
> So for this case, it does look like a quick use of guard(mutex) in
> a precursor patch will simplify what you add here - hence that's a reasonable
> request for Andy to make.
> 
> Jonathan
> 

Hi Jonathan.

Thank you very much for the feedback once again. I didn't know that cleanup.h
was a new thing. I also didn't understand it when Andy mentioned it. Now that
I saw it better and I read about it, it certainly looks like a very good thing
to add.

I don't know if I sounded like I didn't like that request, but just to clarify,
I see it as a very good thing all the proposals that you do because first I
get to learn and understand how to write better code and second the users will
use a better driver! So please, the more requests, the better.

So a precursor patch adding the new functionality of the guard(mutex) in this
and possibly other places in the driver will be good indeed, thank you!

Best regards,
Vasilis
> 
> > I
> > have noticed quite some things that could be improved but I am hesitating
> > to do it now in order to not "pollute" this series with many cleanups and
> > leave it for another cleanup series for example.
> > 
> > Best regards,
> > Vasilis Amoiridis
> > 
> > > > > > > +		}
> > > > > > > +		break;  
> > > > 
> > > > -- 
> > > > With Best Regards,
> > > > Andy Shevchenko
> > > > 
> > > >   
> 

