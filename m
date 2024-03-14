Return-Path: <linux-kernel+bounces-103150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB6787BB9F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BE5DB23E87
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DD86F072;
	Thu, 14 Mar 2024 10:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSEoxgrS"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B006EB73;
	Thu, 14 Mar 2024 10:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710413855; cv=none; b=Evv4fygb00GMMfi2YB36IA7i5xoDSPlX+C/yhiQjT2d3rCrK8ZbUgOJDelwCmPfR8sG0zy5nxTU4xwS0YfY3nogpDPA7GisfNChMaagyVgOLFZ/+wm0icaOFExEtZsE4n4h/Cur3tUlEiTTHxbC/SGZS4jxnrvsEebVh/gzXka4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710413855; c=relaxed/simple;
	bh=r896VFbfcS0xuGXvgjLwcx9xIEMapA2z9gV09qYRM7o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJDEYLHlTBshSXELTrr+rgLpAZ4S1lDtBsxVaeFuDUaSgdk/WkIADq4s3k8DTW4dG2MLFrT+xlsChCbVKXEf6GzDtuQ+QvdsOfLBuC+CqI44ZyPEe9+1maEujf+eyGjVmnbNrgTQFSo2hyUrgE3i6a5xsjdtAE65g1U/KrY1zTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSEoxgrS; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5683576ea18so1038163a12.3;
        Thu, 14 Mar 2024 03:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710413851; x=1711018651; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xo1CXpxaozz3bIcU8SWM6IvQgEAj2vZ6WjYgjDbJujM=;
        b=bSEoxgrSQ4pxwo/EHAu3SNbKethMBpjameqeJLtFQf7Wz3nFsRTDIbhy8Uver1BF5V
         a5RE8SdcwE+o2kRm5sl6uxAPOy5Gc3pFMruz4OOfHMur+m4TideqwEWNFp3N4lWURYuc
         T0AgYoBc7GFklldury6gWDNygqPmA9rp6YHvRDd3+HselTw5r0UHiBdy7fjj/r/R+M2p
         Z+9bcEcMpObI3mZ50hey1dd4yMlSCSufxk1XjgLhhZlBx5LteL/7EFjs778K+0jI0fmZ
         KHTVrfJezu+V4YOecmD7nOnTrKVAkzlguY4mWTZhstXD3bGcHKyrqvyi+GUzuXoXCH96
         SGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710413851; x=1711018651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xo1CXpxaozz3bIcU8SWM6IvQgEAj2vZ6WjYgjDbJujM=;
        b=GTMLY3pd9eRTwVzVCq8sZkTmxE4NnkhLe/O05WV2Eav8Z3+9V2/NkwGH8pE/V+G+yT
         NWXGgi4O1fXr3qHs+h4LD2xDDn51w2imNX+YuwXswTdFDf3xDsrCsz2tSooaZKz/sIJv
         aqhLB0LzMmR2PCKmv2oO5sLUEc2ijKkSGZ8OIHxycSGufdFLORDA9nLBMNHng5sVGfjK
         /8nlKh0aDIAB0B+WJ98kwGRKg8JfR2LPwCYrUM//NtaUN6m/uFfreYVhJ5+sgVZP+PCA
         ZQS4vGRqGHnqHWF/8QDSMvnYWMtBts3ATDHq+4kVZs+d9Uhp9EvdG9E9EuDQfU1WTHST
         KSIg==
X-Forwarded-Encrypted: i=1; AJvYcCXNHdgZ6m1qe5YkKj4Re7GWy2elnaeHXcN0kjGkjH5XNOoGPsnT5uUWYJdlSA9PjBs8pLv2WBzhnkJh2ldfrmUqlcaYm5WVnzkLlfxdb+AuiCABZJWzJTj3ew596IhZYpBPWGrmuepA
X-Gm-Message-State: AOJu0YxXrWJYnu1cUbro4oRvQACVcgncl1ZAmBCGV1cxuXBZ0m/5h0tC
	BXs49QjLLsjqJ42pRvMCzRvDJcPeYS7tXtLA1y1xnFOAvpGcHou4
X-Google-Smtp-Source: AGHT+IGw/KeaG17TYOgZ30Ngr/ndiMiQGoIcXycvl1tBSZjJ7CzVWdChe7/tUBvg0IT6qFXkb6YcSA==
X-Received: by 2002:a17:907:cbc6:b0:a46:22a3:4798 with SMTP id vk6-20020a170907cbc600b00a4622a34798mr1298961ejc.46.1710413850593;
        Thu, 14 Mar 2024 03:57:30 -0700 (PDT)
Received: from vamoirid-EDL-PC ([2001:1458:204:1::102:bd5f])
        by smtp.gmail.com with ESMTPSA id p25-20020a1709061b5900b00a461d8335f2sm587897ejg.45.2024.03.14.03.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 03:57:30 -0700 (PDT)
From: vamoirid <vassilisamir@gmail.com>
X-Google-Original-From: vamoirid <vamoirid@vamoirid-edl-pc>
Date: Thu, 14 Mar 2024 11:57:28 +0100
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jic23@kernel.org,
	lars@metafoo.de, ang.iglesiasg@gmail.com, mazziesaccount@gmail.com,
	ak@it-klinger.de, petre.rodan@subdimension.ro,
	linus.walleij@linaro.org, phil@raspberrypi.com, 579lpy@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] iio: pressure: add SCALE and RAW values for
 channels
Message-ID: <ZfLYGL/vXMHUGghz@vamoirid-EDL-PC>
References: <20240313174007.1934983-1-vassilisamir@gmail.com>
 <20240313174007.1934983-4-vassilisamir@gmail.com>
 <ZfH4bET-HX0e3PO_@smile.fi.intel.com>
 <20240313195110.GB1938985@vamoiridPC>
 <ZfIGtUPZpyDBnWwz@smile.fi.intel.com>
 <20240313212812.GE1938985@vamoiridPC>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313212812.GE1938985@vamoiridPC>

On Wed, Mar 13, 2024 at 10:28:12PM +0100, Vasileios Amoiridis wrote:
> On Wed, Mar 13, 2024 at 10:04:05PM +0200, Andy Shevchenko wrote:
> > On Wed, Mar 13, 2024 at 08:51:10PM +0100, Vasileios Amoiridis wrote:
> > > On Wed, Mar 13, 2024 at 09:03:08PM +0200, Andy Shevchenko wrote:
> > > > On Wed, Mar 13, 2024 at 06:40:04PM +0100, Vasileios Amoiridis wrote:
> > > > > Add extra IIO_CHAN_INFO_SCALE and IIO_CHAN_INFO_RAW in order to be
> > > > > able to calculate the processed value with standard userspace IIO
> > > > > tools. Can be used for triggered buffers as well.
> > 
> > ...
> > 
> > > > > +	case IIO_CHAN_INFO_RAW:
> > > > > +		switch (chan->type) {
> > > > > +		case IIO_HUMIDITYRELATIVE:
> > > > > +			*val = data->chip_info->read_humid(data);
> > > > > +			ret = IIO_VAL_INT;
> > > > > +			break;
> > > > > +		case IIO_PRESSURE:
> > > > > +			*val = data->chip_info->read_press(data);
> > > > > +			ret = IIO_VAL_INT;
> > > > > +			break;
> > > > > +		case IIO_TEMP:
> > > > > +			*val = data->chip_info->read_temp(data);
> > > > > +			ret = IIO_VAL_INT;
> > > > > +			break;
> > > > > +		default:
> > > > > +			ret = -EINVAL;
> > > > > +			break;
> > > > 
> > > > Is it mutex that prevents us from returning here?
> > > > If so, perhaps switching to use cleanup.h first?
> > > 
> > > I haven't seen cleanup.h used in any file and now that I searched,
> > > only 5-6 are including it.
> > 
> > Hmm... Which repository you are checking with?
> > 
> > $ git grep -lw cleanup.h -- drivers/ | wc -l
> > 47
> > 
> > (Today's Linux Next)
> >
> 
> I am checking the drivers/iio of 6.8 (on sunday) and I can only find 7
> drivers that use it.
> 
> > > I am currently thinking if the mutex
> > > that already exists is really needed since most of the drivers
> > > don't have it + I feel like this is something that should be done
> > > by IIO, thus maybe it's not even needed here.
> >

After some researching today, I realized that all the                           
{read/write}_{raw/avail}_{multi/}() functions are in drivers/iio/inkern.c
for channel mapping in the kernel and it looks like they are guarded by
the mutex_{un}lock(&iio_dev_opaque->info_exist_lock). So I feel that the
mutexes in the aforementioned functions can be dropped. When you have the
time please have a look, maybe the could be dropped.

In general, there is quite some cleaning that can be done in this driver
but is it wise to include it in the triggered buffer support series??? I
have noticed quite some things that could be improved but I am hesitating
to do it now in order to not "pollute" this series with many cleanups and
leave it for another cleanup series for example.

Best regards,
Vasilis Amoiridis

> > > > > +		}
> > > > > +		break;
> > 
> > -- 
> > With Best Regards,
> > Andy Shevchenko
> > 
> > 

