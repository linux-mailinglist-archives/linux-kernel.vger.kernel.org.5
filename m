Return-Path: <linux-kernel+bounces-104439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C874287CDCF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 429CA1F21830
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50534286B3;
	Fri, 15 Mar 2024 13:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfOKht1i"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEC4250E5;
	Fri, 15 Mar 2024 13:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710508273; cv=none; b=H98Xwb0zy/JRN3cW8u4L4pnQyMbFbC4G0bVTylhO7/k5h4OGMpQ4Aldjv3w3+J3ufmTu6k+0xJAt+p/wm7CdHdQyAamwU+gAsJIawt50cSYF9NV6+9AbC9H+q+IdQzh2KySWE+n7cqoPH8tDGQWYEcR3F5Hbl+oKX3LOpwzx1EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710508273; c=relaxed/simple;
	bh=GgGaLFmkPzqtgKiqBO0x5s2Rw5H+LeR8QZDMYQCb/k8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJghCXAfxlrevKHOpzsJc/HfgZKltL4Gw6mvLIxnW6WrK+c+33PjIfeRwKe9GLzt4+QEK+mId/JfHPP69IEZHsR0irYuGvt7c0vmu5ikITj211KpBQufKNnfFQQO62RJdetXB0QCM1W//F2iNwncrLVuRC+9huN0VPOaTewG4dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfOKht1i; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a46966e9d30so39698866b.1;
        Fri, 15 Mar 2024 06:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710508270; x=1711113070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NGClZ+LanOmMSnmGsb8Zj5kdnyfKGPa6Yy5O2cha8AA=;
        b=UfOKht1ipXwIYvQPyikJRVOeAImxELH5DJA/kxkIdH9t0ntWzpxFKXHFRFkLbGYZKu
         WI4M0351Al1hL4R9SkJTzR1b9UxvW3f21Igacm8ozeLzxTgC6wimPJ82EfVIqEQ+JW4n
         MCrl9Cfqiy5tBsVIh+LkpMMCK+1pGZGfRN+I1/IlBRf+7gng4n7wdfl14j4H07ztQ/vc
         lnuNe/7RpBmXEzqqgwjTfJvtLIuUdq4NAspX2Uk0t+vaYnzJVyTs7YrVwvAw3MI8K3T+
         X+h9tzuGPnLqIpu7UTzW1rfG1mvta2FdJ6B7awF4uJf8uvnM2zEZnfD2WzVrRNrUYfre
         EO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710508270; x=1711113070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGClZ+LanOmMSnmGsb8Zj5kdnyfKGPa6Yy5O2cha8AA=;
        b=ojDWIphMcdq45BlL+dNMtv6osAqwnUxLyHhuiPOIG/lz8pDRWmpN8gV4x8Mo0qodix
         aPzXE0rB24MtDLOlGCm6Bt0OlDz3PSOa1m0ynVaVY+/uLcGQjqj083VlptX4OWQbp0c1
         u3wTexhhX2cP51CdhoCyvKtVtpYqEUYtrf7Jiy6czaVoFS3RCgVy0590g/8hRfKsQZAC
         VvYkFdsQCunm+wEO7ap/NA0vf1NvP6QW2V8L3sX76vbFcUZFPw9An5QeR+cMsy9gw9JG
         iCm30QYNjZvoc64hKhp/qQ1sOn7qPy3V7tZ1RmnGv7z7TfoN5o/EeKpx1ZCnkTr7hEpM
         Gwcw==
X-Forwarded-Encrypted: i=1; AJvYcCU/NMeYx1yc0B5oNV0NIGLABmAOZsgjFFJykhA5E5ksaCUBQsZto/pOy41nMtzmc/k2kCgQlEzp+YHLh4yTfRa734TMZGK4PbpINaT0v//jE+M3DZJ0BvpDiJaBfh9waFr/y/Opzb38
X-Gm-Message-State: AOJu0YwNx+gcYaIxoEk66tzp4mmCJb+wje6UA4Eloq2omS+78wqK7igX
	WYZTpv+k3T3913Kt2cHwE/O8tyyOoiz5SIOKtqL+sk94cw/kEFsh
X-Google-Smtp-Source: AGHT+IGdU0u8DTj5V2Vr8wsn0Yi1JDR3cqI//+XDM/daUixF5BfQL8ujkLeU9diDuV+LjHQFtiH3EA==
X-Received: by 2002:a17:907:a607:b0:a46:6a20:7fbd with SMTP id vt7-20020a170907a60700b00a466a207fbdmr3305508ejc.61.1710508269428;
        Fri, 15 Mar 2024 06:11:09 -0700 (PDT)
Received: from vamoirid-EDL-PC ([2001:1458:202:121::101:4e8c])
        by smtp.gmail.com with ESMTPSA id jl20-20020a17090775d400b00a46497c74a0sm1706840ejc.93.2024.03.15.06.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 06:11:08 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoirid-edl-pc>
Date: Fri, 15 Mar 2024 14:11:06 +0100
To: Jonathan Cameron <jic23@kernel.org>
Cc: vamoirid <vassilisamir@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	lars@metafoo.de, ang.iglesiasg@gmail.com, mazziesaccount@gmail.com,
	ak@it-klinger.de, petre.rodan@subdimension.ro,
	linus.walleij@linaro.org, phil@raspberrypi.com, 579lpy@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] iio: pressure: add SCALE and RAW values for
 channels
Message-ID: <ZfRI6oAxr6SXPLcf@vamoirid-EDL-PC>
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

After looking into how to change the code to introduce the new guard(mutex)
I encountered the following situation.

In general, with the new guard(mutex) functinality you can remove most of the
goto statements and return immediately without doing the cleanup yourself. 
In the case of this driver, in the read_raw() call, apart from the mutex, 
the power management functions are also used. This means that in each case, 
before returning, the pm functions will need to be called, which I don't
know if it will actually make the code cleaner. Have a look below with
an example.

----- Current Implementation -----

static int bmp280_read_raw( ... )
{
	...

	pm_runtime_get_sync_data(data->dev);
	mutex_lock(&data->lock);

	switch (mask) {
	case 1:
		switch (channel) {
		case TEMP:
			ret = read_temp();
			break;
		case PRESS:
			ret = read_press();
			break;
		...
	case 2:
		switch (channel) {
		...

	case 3:
		...
	default:
		ret = -EINVAL;
		break;
	}

	mutex_unlock(&data->lock);
	pm_runtime_mark_last_busy(data->dev);
	pm_runtime_put_autosuspend(data->dev);

	return ret;
}

----- End of Current Implementation -----

With the use of the guard(mutex)(&data->lock) you could immediately
return without all the break statements. But we still need to call
the pm functions. So the code, as far as I can understand will look
like this:

----- Guard Mutex Implementation -----

static int bmp280_read_raw( ... )
{
	...

	pm_runtime_get_sync_data(data->dev);
	guard(mutex)(&data->lock);

	switch (mask) {
	case 1:
		switch (channel {
		case TEMP:
			ret = read_temp();
			pm_runtime_mark_last_busy(data->dev);
			pm_runtime_put_autosuspend(data->dev);
			return ret;
		case PRESS:
			ret = read_press();
			pm_runtime_mark_last_busy(data->dev);
			pm_runtime_put_autosuspend(data->dev);
			return ret;
		...
	case 2:
		switch (channel) {
		...
	case 3:
		...
	default:
		return -EINVAL;
	}

	return 0;
}

----- End of Guard Mutex Implementation -----

Have I completely misunderstood something? If what I explain
above is correct, you think that this is a better implementation
and I should move forward becasue we want to use the guard(mutex)
functionality? 

Maybe it is necessary to create some new type of guard to call
also the pm functions before exiting?

Cheers,
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

