Return-Path: <linux-kernel+bounces-103742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A84C387C3DA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 345BB1F22BC6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6414476055;
	Thu, 14 Mar 2024 19:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eED2XMGq"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD672A1C7;
	Thu, 14 Mar 2024 19:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710445984; cv=none; b=l+Je+pBx7NUeWSu5/UBuSanI86Jsnx4eEFLVKXlZyCJgCmPDGad6dyIIXtyj36NfK1Zc7C1V4nvnKlS3HexK7TsVKtU+6SLqhBO1Qkq/OF9yvcGftZua1c3L5xGND267xQLxJoL8+1AMlfs4tYzfqUODQ7tr1TWbEgGkPyDqDGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710445984; c=relaxed/simple;
	bh=FT+Jxam2JbSRZnXuLmLoDxj+ZjQmr6CKt84qjcS5VvE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRPNVtx588RmPd5cEtW7ZR9D2P0MpEnZaqBBaajMU77ojr9+2gbJlG2X+ztw3Ro7TUXMsTXxcVCJb7sabsZV+OdQBiI5laav0dIsLvzKgqMNlM1NsfDi73t4Zqws30X+naWAO86g3lYu9FvRLlDFu35N1Gf0hvio9PVLsEYHRA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eED2XMGq; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5687e7662a5so1903924a12.0;
        Thu, 14 Mar 2024 12:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710445981; x=1711050781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j8XelG+9iocurj9x9eq3IaSOODzws4f/zEi7dkOsaeQ=;
        b=eED2XMGqPrGJyJ2Tm/Jy5Azm6m1616OEQ4PJdBAGI84TGPfWt+RRZG1BGW0ynSRDch
         BgxrHj/T5SnS22yFLtldo3LBwEeqy/yOUuy9+qYCRd9dJiNkwABAe/M8G78+pDkz/RiS
         k4pxkZMh/q3dxni1WprZ7x2UIn0ghtdeOwDEdEVDIsnX9QUvTyKndhfZtcAMQVtA1/FA
         REUN9k9wZX3QgWWorP6w+dDlWXP2409zbJ+apKI2O9i9JUuodm6bvWx8v4e4ZmThE73r
         71HdqgP5i0m8x+I03zKJzPPugvmOdKufYrNsZCDL9qYleI96N1uN1VjipQ6Z66ypumIV
         PD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710445981; x=1711050781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8XelG+9iocurj9x9eq3IaSOODzws4f/zEi7dkOsaeQ=;
        b=tFR4KL/gHvcCpdyjeGLRUHS+Xj8d7GEMVFFKB3wNmryjDYnESWRR5NeNr4HKfNqOY7
         MRGpBRUtjtAVAB+Epdhj/iMMHdrqyXDdOUdy6j05OcJ99HOCcYdQuNO7SoVU2jKmxLcn
         HsWrA5JCrfbhROG4MjElKHXUPbCJuC6D/UTicvTodYkuxcBusXoK7HPXo9ItdG7ki+00
         uvQPbk/BkZGLNzkJcqGhWOZZLRWpCq8gP+kYMAV5K9EgOCXMoZP5gwAWENGREv/Cge23
         +iRt4KGGlfQ8VMZOS0Mgbt+LqsZ/qMZNmFHvDG+zmiSXMaZw5afeVh/6xTXZ8iNKL1au
         mQLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsYqaTfEhlHsxGRXaTy8ixk3DcFtYxzNj94ISt/KMdp2TtEmnHwixV3KkljWuyzjit13khYtQIiE/zmFOuik3/V4V2GhdFAGVd3uUwWN4cnA5/TT/wEJA7MiT4PJxnq5W2BfDUVKML
X-Gm-Message-State: AOJu0Yz0v5DbLfsUGveD42tDQa/qh1s0tvJ/HRFq5bf17Cbitu3SkUNI
	L+UoT3Eb3nc92nL3T2etjca6H2tPVW8PkeuS1Tn20W0q1ERY5xdz
X-Google-Smtp-Source: AGHT+IHK+fsSjqESW8pcn2XNuTI6VEFIMUjkbSjYXX0wD1vDVX7afvLaGA/QHbsJaBkite5GbJONow==
X-Received: by 2002:a17:907:bb88:b0:a44:bd2:c4a with SMTP id xo8-20020a170907bb8800b00a440bd20c4amr1791387ejc.51.1710445981244;
        Thu, 14 Mar 2024 12:53:01 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:3844:3925:f1c1:4bc5])
        by smtp.gmail.com with ESMTPSA id l5-20020a1709066b8500b00a44d3847811sm984142ejr.102.2024.03.14.12.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 12:53:00 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Thu, 14 Mar 2024 20:52:58 +0100
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
	petre.rodan@subdimension.ro, linus.walleij@linaro.org,
	phil@raspberrypi.com, 579lpy@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] iio: pressure: Simplify read_* functions
Message-ID: <20240314195258.GA1964894@vamoiridPC>
References: <20240313174007.1934983-1-vassilisamir@gmail.com>
 <20240313174007.1934983-3-vassilisamir@gmail.com>
 <ZfH4IyeFTGFBKT4J@smile.fi.intel.com>
 <20240313192245.GA1938985@vamoiridPC>
 <ZfH-b2KWcU_8-Nmh@smile.fi.intel.com>
 <20240314143231.671bf685@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314143231.671bf685@jic23-huawei>

On Thu, Mar 14, 2024 at 02:32:31PM +0000, Jonathan Cameron wrote:
> On Wed, 13 Mar 2024 21:28:47 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > On Wed, Mar 13, 2024 at 08:22:45PM +0100, Vasileios Amoiridis wrote:
> > > On Wed, Mar 13, 2024 at 09:01:55PM +0200, Andy Shevchenko wrote:  
> > > > On Wed, Mar 13, 2024 at 06:40:03PM +0100, Vasileios Amoiridis wrote:  
> > 
> > ...
> > 
> > > > >  		case IIO_TEMP:
> > > > > -			ret = data->chip_info->read_temp(data, val, val2);
> > > > > +			ret = data->chip_info->read_temp(data);
> > > > > +			*val = data->chip_info->temp_coeffs[0] * ret;
> > > > > +			*val2 = data->chip_info->temp_coeffs[1];  
> > > >   
> > > > > +			if (!strcmp(indio_dev->name, "bmp580"))
> > > > > +				ret = IIO_VAL_FRACTIONAL_LOG2;
> > > > > +			else
> > > > > +				ret = IIO_VAL_FRACTIONAL;  
> > > > 
> > > > I'm wondering if we may replace these strcmp():s by using enum and respective
> > > > values in chip_info.  
> > > 
> > > The whole problem starts from the fact that all these BMPxxx_CHIP_ID defines are
> > > not unique for the respective BMPxxx device. You mean to add a new variable
> > > that could store some enum values that would be the actual chip_info IDs? Like:
> > > 
> > > enum chip_info_ids = {
> > > 	BMP085,
> > > 	BMP180,
> > > 	...
> > > 	BMP580,
> > > };
> > > 
> > > and later for every chip_info struct to use it like this:
> > > 
> > > const struct bmp280_chip_info bmpxxx_chip_info = {
> > > 	...
> > > 	.chip_info_id = BIT(BMPxxx),  
> > 
> > No BIT(), but yes.
> > 
> Better to use something more meaningful such as just storing the
> type you need to return alongside the values it refers to.
> temp_coeffs_type = IIO_VAL_FRACTIONAL_LOG2 / IIO_VAL_FRACTIONAL as appropriate.
> That way the data and what it is are found in one simple place.
> 
> Basic rule of thumb is that if there is a string comparison to identify
> what to do in a driver (other than deep in the fw handling code) then
> that is a bad design. Likewise any matching on an enum value that correlates
> with that chip ID.  I want to see all the difference between chips in one place,
> not scattered through the code.
> 
> Jonathan
> 

Yes, sounds totally right. I was just hesitating to add new variables in the
chip_info structure (as you probably noticed in the next commits as well).

Best regards,
Vasilis
> 
> > > 	...
> > > }
> > > 
> > > And in the read_raw() function to just use the test_bit() function in the same
> > > way that is done with the test_bit() and avail_scan_mask to test for the
> > > enabled channels?  
> > 
> > If BIT() is more suitable, than also yes.
> > 
> 

