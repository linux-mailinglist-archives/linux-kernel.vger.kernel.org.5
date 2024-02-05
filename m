Return-Path: <linux-kernel+bounces-52303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BA0849689
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99C2F1C220B3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009E812B8A;
	Mon,  5 Feb 2024 09:33:57 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7ED12E54;
	Mon,  5 Feb 2024 09:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707125636; cv=none; b=NIr58bzAJiAdyFgViCLXCt69e580akKVDINwXC/Q9SCS4EUgDscbDIPO00oe9T11SPTcYlnhT1xZmTYlbKjx/Ckeu0YuRp7XPjNj/xNwzZ4ctHHonhAU+KE53w9QXm7yv92CVempP9LWKMzCOkwZCBM3rVkAnGZvRkn3yYHqlTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707125636; c=relaxed/simple;
	bh=S65GSXVDFKVEny76ploiFHb93ODa1vq3YiADC4xUBPE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rNva7kx19VYbG1ftSrvyokTQCDlu4fAwJ52STZ0qoOVYRWzJ3uEIZnoftp1McEeiZaHtCgXoUQg5n8AQofP1jQ0JU0rYXh2Eo9rznk85D/WOaV9olvEjt/2M7OI5aYJd2PhGZlnAPXS7GaIfmy9nQ3RVT41M7ji1PRbNlfVrzWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TT1ML014zz6K99W;
	Mon,  5 Feb 2024 17:30:38 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 505AB140A87;
	Mon,  5 Feb 2024 17:33:51 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 5 Feb
 2024 09:33:50 +0000
Date: Mon, 5 Feb 2024 09:33:49 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, Javier Carrasco
	<javier.carrasco.cruz@gmail.com>, Li peiyu <579lpy@gmail.com>, "Lars-Peter
 Clausen" <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: humidity: hdc3020: add threshold events support
Message-ID: <20240205093349.00003e10@Huawei.com>
In-Reply-To: <20240205070421.GA2264419@debian>
References: <20240204103710.19212-1-dima.fedrau@gmail.com>
	<20240204144347.7f0eb822@jic23-huawei>
	<20240205070421.GA2264419@debian>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

> > >  static const u8 HDC3020_S_AUTO_10HZ_MOD0[2] = { 0x27, 0x37 };
> > >  
> > > +static const u8 HDC3020_S_STATUS[2] = { 0x30, 0x41 };
> > > +
> > >  static const u8 HDC3020_EXIT_AUTO[2] = { 0x30, 0x93 };
> > >  
> > > +static const u8 HDC3020_S_T_RH_THRESH_LOW[2] = { 0x61, 0x00 };  
> > 
> > Ah. missed this in original driver, but this use of capitals for
> > non #defines is really confusing and we should aim to clean that
> > up.
> >  
> Could use small letters instead.

That would avoid any confusion.

> 
> > As I mention below, I'm unconvinced that it makes sense to handle
> > these as pairs.
> >  
> For the threshold I could convert it as it is for the heater registers:
> 
> #define HDC3020_S_T_RH_THRESH_MSB	0x61
> #define HDC3020_S_T_RH_THRESH_LOW	0x00
> #define HDC3020_S_T_RH_THRESH_LOW_CLR	0x0B
> #define HDC3020_S_T_RH_THRESH_HIGH_CLR	0x16
> #define HDC3020_S_T_RH_THRESH_HIGH	0x1D
> 
> #define HDC3020_R_T_RH_THRESH_MSB	0xE1
> #define HDC3020_R_T_RH_THRESH_LOW	0x02
> #define HDC3020_R_T_RH_THRESH_LOW_CLR	0x09
> #define HDC3020_R_T_RH_THRESH_HIGH_CLR	0x14
> #define HDC3020_R_T_RH_THRESH_HIGH	0x1F
> 
> or:
> 
> #define HDC3020_S_T_RH_THRESH_LOW       0x6100
> #define HDC3020_S_T_RH_THRESH_LOW_CLR   0x610B
> #define HDC3020_S_T_RH_THRESH_HIGH_CLR  0x6116
> #define HDC3020_S_T_RH_THRESH_HIGH      0x611D
> 
> #define HDC3020_R_T_RH_THRESH_LOW       0x6102
> #define HDC3020_R_T_RH_THRESH_LOW_CLR   0x6109
> #define HDC3020_R_T_RH_THRESH_HIGH_CLR  0x6114
> #define HDC3020_R_T_RH_THRESH_HIGH      0x611F
> 
> I don't know if it's a good idea, as we would need to make sure it is
> big endian in the buffer. Probably with a function that handles this.
I think this is the best plan with a
put_unaligned_be16() to deal with the endianness.
The compiler should be able to optimize that heavily.


> > > +static int hdc3020_read_thresh(struct iio_dev *indio_dev,
> > > +			       const struct iio_chan_spec *chan,
> > > +			       enum iio_event_type type,
> > > +			       enum iio_event_direction dir,
> > > +			       enum iio_event_info info,
> > > +			       int *val, int *val2)
> > > +{
> > > +	struct hdc3020_data *data = iio_priv(indio_dev);
> > > +	u16 *thresh;
> > > +
> > > +	/* Select threshold */
> > > +	if (info == IIO_EV_INFO_VALUE) {
> > > +		if (dir == IIO_EV_DIR_RISING)
> > > +			thresh = &data->t_rh_thresh_high;
> > > +		else
> > > +			thresh = &data->t_rh_thresh_low;
> > > +	} else {
> > > +		if (dir == IIO_EV_DIR_RISING)
> > > +			thresh = &data->t_rh_thresh_high_clr;
> > > +		else
> > > +			thresh = &data->t_rh_thresh_low_clr;
> > > +	}
> > > +
> > > +	guard(mutex)(&data->lock);  
> > 
> > Why take the lock here?
> > 
> > you are relying on a single value that is already cached.
> >  
> A single threshold value is used for humidity and temperature values. I
> didn't see a lock in "iio_ev_value_show", so there might be some
> concurrent access triggered by "in_temp_thresh_rising_value" and
> "in_humidityrelative_thresh_rising_value" sysfs files which is not
> secured by a mutex or similiar.

Unless you going to get value tearing (very unlikely and lots of the
kernel assumes that won't happen - more of a theoretical possibility
that we don't want compilers to do!) this just protects against a race
where you read one and write the other.  That doesn't really help us
as it just moves the race to which one gets the lock first.

Jonathan


