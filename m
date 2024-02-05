Return-Path: <linux-kernel+bounces-52353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D92084970B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9A5A1C22481
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88A112E71;
	Mon,  5 Feb 2024 09:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbOG8hLt"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B44134C6;
	Mon,  5 Feb 2024 09:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707126810; cv=none; b=TXDvvt0LOZz8bkprlZzmRCQjXDHT0/g37PpzTUqOA+T91SHnVuBptd1f0qVfYV1A6AZGRiH0SF8pI53/3h4lYcX/d9RbTogBJ7u9B3m21lpTxPedXUeKN9bK9FmUxv6ipNCivYP0HPBw6rPvbmJTFpnaOG5BDIfUC37OyFN0+yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707126810; c=relaxed/simple;
	bh=qzWq2fEmrI0y52InyhdcUfWfRevTQvm9xcPd55lTSPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+scZrqTiHtCDt/yXYFyM3Yi6/QmGgY5Z9HBfdKmAMAttLUFJ8TcG40IPMp6A8kXsmUWbDmHCyf2orzPAiqD++Wdgt5TDDN+T7pEtcxZ2XcSberW8luRyhPPxMKhy+UwBe6/Dq8YCP0wA1XzlCx4yY+EqN9+0IouzPBnEDOct9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbOG8hLt; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a2f79e79f0cso566687366b.2;
        Mon, 05 Feb 2024 01:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707126806; x=1707731606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KVR1d4N0MAmwAVoqQZoMPRejFBb2H9WAFtXUDQ1yD9E=;
        b=BbOG8hLt5fPuxdhwdb3WBze8kgOV+ReUfM4JC4yFPvx7gIoXiLgVFIsEk7JgygPg/y
         9gEZ2a+NxziUQhX8+uS0KI+WeBJszJcRSE2wyp6qSDtIhkVNCh94whW/TxmDmdXTwh5k
         yFa7CZqr3eOnJ4JayuS5gbeiYf2S+egXpzr9GvyOKtendOhMmbnoi9BQKLjYNQeRag7u
         N8bXWCvpcyp67QGLrDzzaMxGbZOa303oklfs3ZvAhrQdGS2jqYRu36GGSr+/4bw4B8Lg
         WTMA1XiAsefCDYM9rvnTrAsJnPN37cApyI3Aqg6DAcgMN1HXWYsOr+j7ROTd0Cf84VDZ
         ShNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707126806; x=1707731606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVR1d4N0MAmwAVoqQZoMPRejFBb2H9WAFtXUDQ1yD9E=;
        b=RK985XY96Lg4kEiP/U+dQy9h/jehOY101BfwfEsq09cdQrS89Rt7qtFSEw31Yl2Uh0
         Qfs7CbYOCsCcrnrfy3pvh5Xzbi+Fa47fFiGDtmg2IJ4nHzIvhzpksWiLnyYiDr0cgMFN
         9K2di2L6KR3itZrpcyId8/0gz0Vz+ZDU4baXBOSMez8F00GFLAoGPzQFko4RcCw3VaUk
         LrnaHMJmomjjr+DM+a8YGn/t9JYb5Dz/tR3jEcgaFdm1hFWMs2xwJ+PAr9ji6S63eNG7
         d6L272ouowktrAaAUg4m55kBb1SeeN1I3houcYQ2DokCSWLtYA4mVG8nHeSKmpWA3m/6
         1ZMA==
X-Gm-Message-State: AOJu0Yz9Li2eYqo2IYaa8fy0sWggBk+yf7ZTxVjGEHhQKwoouwS+diCT
	zvbeYApRtCcNFTzsNzlWKPnhRnHco/ePecTCfKk3Puz5IdcxszMq
X-Google-Smtp-Source: AGHT+IHEJNj6ITyaNW2HKGk+p4SYNl7jGHN6VgcEs2G07eq6r+uN368VL70WRnSaA0uK7JJipeYiKg==
X-Received: by 2002:a17:906:8309:b0:a37:b2e6:cf65 with SMTP id j9-20020a170906830900b00a37b2e6cf65mr1879217ejx.52.1707126806411;
        Mon, 05 Feb 2024 01:53:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX7k6NLnblNcyc7fQ9YFcgOWMe2KUTVWvxSmSfu0qdx4ejn58XMDppo3lUAVeZgFWmlSWsapTeOkg0EvaG6lYRULh3YKDnqLxaU2Kd6rcnZbQv0C6LlaTlbym9haj1BBKMh6Ngs0PqBUsT5y6IqAhxCW7cot5gRQaY0LVb7a0kzCH/9M2E2h3gLO4PKH+iBvunHwx0hHtjabkyRPVSM31N2dbg+cg5F5hUoHA==
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id v8-20020a170906488800b00a37dcf17d3asm416088ejq.174.2024.02.05.01.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 01:53:25 -0800 (PST)
Date: Mon, 5 Feb 2024 10:53:23 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Li peiyu <579lpy@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: humidity: hdc3020: add threshold events support
Message-ID: <20240205095323.GA2323766@debian>
References: <20240204103710.19212-1-dima.fedrau@gmail.com>
 <20240204144347.7f0eb822@jic23-huawei>
 <20240205070421.GA2264419@debian>
 <20240205093349.00003e10@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205093349.00003e10@Huawei.com>

Am Mon, Feb 05, 2024 at 09:33:49AM +0000 schrieb Jonathan Cameron:
> > > >  static const u8 HDC3020_S_AUTO_10HZ_MOD0[2] = { 0x27, 0x37 };
> > > >  
> > > > +static const u8 HDC3020_S_STATUS[2] = { 0x30, 0x41 };
> > > > +
> > > >  static const u8 HDC3020_EXIT_AUTO[2] = { 0x30, 0x93 };
> > > >  
> > > > +static const u8 HDC3020_S_T_RH_THRESH_LOW[2] = { 0x61, 0x00 };  
> > > 
> > > Ah. missed this in original driver, but this use of capitals for
> > > non #defines is really confusing and we should aim to clean that
> > > up.
> > >  
> > Could use small letters instead.
> 
> That would avoid any confusion.
> 
> > 
> > > As I mention below, I'm unconvinced that it makes sense to handle
> > > these as pairs.
> > >  
> > For the threshold I could convert it as it is for the heater registers:
> > 
> > #define HDC3020_S_T_RH_THRESH_MSB	0x61
> > #define HDC3020_S_T_RH_THRESH_LOW	0x00
> > #define HDC3020_S_T_RH_THRESH_LOW_CLR	0x0B
> > #define HDC3020_S_T_RH_THRESH_HIGH_CLR	0x16
> > #define HDC3020_S_T_RH_THRESH_HIGH	0x1D
> > 
> > #define HDC3020_R_T_RH_THRESH_MSB	0xE1
> > #define HDC3020_R_T_RH_THRESH_LOW	0x02
> > #define HDC3020_R_T_RH_THRESH_LOW_CLR	0x09
> > #define HDC3020_R_T_RH_THRESH_HIGH_CLR	0x14
> > #define HDC3020_R_T_RH_THRESH_HIGH	0x1F
> > 
> > or:
> > 
> > #define HDC3020_S_T_RH_THRESH_LOW       0x6100
> > #define HDC3020_S_T_RH_THRESH_LOW_CLR   0x610B
> > #define HDC3020_S_T_RH_THRESH_HIGH_CLR  0x6116
> > #define HDC3020_S_T_RH_THRESH_HIGH      0x611D
> > 
> > #define HDC3020_R_T_RH_THRESH_LOW       0x6102
> > #define HDC3020_R_T_RH_THRESH_LOW_CLR   0x6109
> > #define HDC3020_R_T_RH_THRESH_HIGH_CLR  0x6114
> > #define HDC3020_R_T_RH_THRESH_HIGH      0x611F
> > 
> > I don't know if it's a good idea, as we would need to make sure it is
> > big endian in the buffer. Probably with a function that handles this.
> I think this is the best plan with a
> put_unaligned_be16() to deal with the endianness.
> The compiler should be able to optimize that heavily.
>
I think that would require some refactoring. I would add patches that
are fixing this. Have there been reasons for using the pairs ? I'm just
curious.
> 
> > > > +static int hdc3020_read_thresh(struct iio_dev *indio_dev,
> > > > +			       const struct iio_chan_spec *chan,
> > > > +			       enum iio_event_type type,
> > > > +			       enum iio_event_direction dir,
> > > > +			       enum iio_event_info info,
> > > > +			       int *val, int *val2)
> > > > +{
> > > > +	struct hdc3020_data *data = iio_priv(indio_dev);
> > > > +	u16 *thresh;
> > > > +
> > > > +	/* Select threshold */
> > > > +	if (info == IIO_EV_INFO_VALUE) {
> > > > +		if (dir == IIO_EV_DIR_RISING)
> > > > +			thresh = &data->t_rh_thresh_high;
> > > > +		else
> > > > +			thresh = &data->t_rh_thresh_low;
> > > > +	} else {
> > > > +		if (dir == IIO_EV_DIR_RISING)
> > > > +			thresh = &data->t_rh_thresh_high_clr;
> > > > +		else
> > > > +			thresh = &data->t_rh_thresh_low_clr;
> > > > +	}
> > > > +
> > > > +	guard(mutex)(&data->lock);  
> > > 
> > > Why take the lock here?
> > > 
> > > you are relying on a single value that is already cached.
> > >  
> > A single threshold value is used for humidity and temperature values. I
> > didn't see a lock in "iio_ev_value_show", so there might be some
> > concurrent access triggered by "in_temp_thresh_rising_value" and
> > "in_humidityrelative_thresh_rising_value" sysfs files which is not
> > secured by a mutex or similiar.
> 
> Unless you going to get value tearing (very unlikely and lots of the
> kernel assumes that won't happen - more of a theoretical possibility
> that we don't want compilers to do!) this just protects against a race
> where you read one and write the other.  That doesn't really help us
> as it just moves the race to which one gets the lock first.
> 
Yes, it's very unlikely to happen. Anyway, I'm dropping the support for
the caching and with it this function.

Dimitri

