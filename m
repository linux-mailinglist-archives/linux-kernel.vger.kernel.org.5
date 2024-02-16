Return-Path: <linux-kernel+bounces-68970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 042038582CA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8D7D1C21737
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D90B130ACB;
	Fri, 16 Feb 2024 16:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDoDBewz"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9147C12F36A;
	Fri, 16 Feb 2024 16:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708101644; cv=none; b=gT2XntNmSZRE+MdEkfSCjHRNOqK+8HGsJCiT+jlP/dmLl3E8mK2lFMLha/XcdZwt7jNkh/OV9SspIlTjzz2wmSUAF0mp1vBuCMnja+cMshZisVJxsZSJA3WTftlkfJ1XGcGJ/XE4HoiVygDqx7cfB95dSaBFnrkU11tmYrIwuoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708101644; c=relaxed/simple;
	bh=nLWhQczn2CJfsefZmkJS0eLnq+fCloh9Ntxr5XF1TUs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2bqZjq32TUdmM7TVPYD8zLtnGVjygSg6uoWSKNN5bPjzJrnh9SCowx+9ZiRkK2BSiG8U75RQXDMT197ZBJyi7gGWSYBcDFXvA3ZgFH2rM0Uo/dDABh8rE3OE1L1nflYK/Kpgal6JN+jMnLMiqVShuIKD0Dac3UqUxc1Fi29DBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDoDBewz; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55f0b2c79cdso3592342a12.3;
        Fri, 16 Feb 2024 08:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708101641; x=1708706441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GKp+N4i+q6yxZFB78Y2kUkbZb6u1oAoIbnmaWbrGddg=;
        b=NDoDBewzEyDQwdkQspAD5DwjHsKOTKwW8yNtv9ffolOGBD8Qjj6l4uFVrluU4PJDP3
         UQ+tl6Ndcr0/WC2wWZwQjYfXCWTicpZJtIKw4j482Iu7QLCgCsTdZPCKXNHcUbZbEilu
         xFTOhVKssY/nbpBJfLMdG2wdBkpeRVm3jD2na5o3N9y6NDhz7bcGVaReq+Aqm/gV4uuY
         8l3zmU+jzMLw32kZdU3Jl50WW395dqpL9VJDNohG6jk/8uRvoH332TM0+vnG2AHD7gOM
         s6XvopcDcf2zoAJjsDPArGAd3vgLVQzuVD+UiG9uIVCSGxx2okgEVMyBHhKiGav/Y7IP
         qwaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708101641; x=1708706441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKp+N4i+q6yxZFB78Y2kUkbZb6u1oAoIbnmaWbrGddg=;
        b=xU0jQ875Y8vKe1ONI+IKOmBwx5mJ8Z4VbLiz5srlU3GIpWIk9xvHJzdeOh8tjJC5/r
         l3bbT4SzN/FTBkiAK3n1xdz15yWzRA/1jG7O7R+bpyN0NA9fr1q41CtoxN49JQboIAh4
         eamBfzD6drnmOgPewHN7zzskmMrCJLRRWg+/YRugctGYK6FQeK50s68sldoGEpIorlk7
         aDToUWiEbqSJNG8LcACoQL2l0/94KrmhpGWxzrkonfvLVRnnJ2izcSZMx/aths+H/jDv
         KTbjLUTm69G9hePPDvYSt0RmRhKfxYMgdnmzaM21b7n/57iSu/x1ynU2BGz56Ukpo/Rn
         Mu6Q==
X-Forwarded-Encrypted: i=1; AJvYcCULi3cZk9NpBrSWUrIXTBKnXFl93DWc4BqlngU3hSZTCCt2eZQba97Lx/HYiIsJTYigabggTS1ee1yOM/JFc34O7r0JeolrRwxMx1Yda5yYyWxHq8osbryd7/iZFzhy7CxNkBy1U3Rl
X-Gm-Message-State: AOJu0YyQHyRy3DgFuhNUv6wuj8OaKGs1mcV7Z6YW5jmQZaFxLOSzDyDG
	Bx0CSUHSy/W3yFvLmnFNMA5PkZC3RiWw4xVaqal9KVAdrlb7wQlj
X-Google-Smtp-Source: AGHT+IHsgz8LFvkQffINGP3bi0mD6eppxTPFQ9FUfJbK77dq1B00e4MC26javzCIBKHuP/c/rpQ3pQ==
X-Received: by 2002:aa7:c142:0:b0:561:849:76fd with SMTP id r2-20020aa7c142000000b00561084976fdmr4054210edp.23.1708101640526;
        Fri, 16 Feb 2024 08:40:40 -0800 (PST)
Received: from vamoiridPC ([2a04:ee41:82:7577:78f:5c0c:61d7:68fd])
        by smtp.gmail.com with ESMTPSA id dm26-20020a05640222da00b00560a1ce1373sm141480edb.57.2024.02.16.08.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 08:40:39 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Fri, 16 Feb 2024 17:40:36 +0100
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	ang.iglesiasg@gmail.com, andriy.shevchenko@linux.intel.com,
	579lpy@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: iio: pressure: Add SPI support for BMP38x and
 BMP390
Message-ID: <20240216164036.GA4230@vamoiridPC>
References: <20240215164332.506736-1-vassilisamir@gmail.com>
 <20240216111834.73287ab0@jic23-huawei>
 <20240216132644.GA4236@vamoiridPC>
 <20240216154742.685bd875@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216154742.685bd875@jic23-huawei>

On Fri, Feb 16, 2024 at 03:47:42PM +0000, Jonathan Cameron wrote:
> On Fri, 16 Feb 2024 14:26:44 +0100
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > On Fri, Feb 16, 2024 at 11:18:34AM +0000, Jonathan Cameron wrote:
> > > On Thu, 15 Feb 2024 17:43:32 +0100
> > > Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> > >   
> > > > According to the datasheet of BMP38x and BMP390 devices, in SPI
> > > > operation, the first byte that returns after a read operation is
> > > > garbage and it needs to be dropped and return the rest of the
> > > > bytes.  
> > > 
> > > Make it clear in the patch title that this is a fix and add a fixes tag.
> > >   
> > 
> > The original support for SPI was added 8 years ago. Should I include that commit
> > of 8 years ago in the fixes tag or just use a the word "fixes" with the rest of the
> > title?
> > 
> Original git commit for the fixes tag.  Lets us know this wants to go in all stable kernels.
> Also fixes in the title.
 
Ok, will do that!
>
> 
> > > > +	ssize_t status;
> > > > +	u8 buf;
> > > > +
> > > > +	memcpy(&buf, reg, reg_size);
> > > > +	buf |= 0x80;  
> > > 
> > > Can you use regmap_bus read_flag_mask for this?  Seems to apply to 
> > > all devices supported. + that's common for spi regmaps
> > >  
> > 
> > Yes I noticed it yesterday in my tests that this was missing and it actually
> > applies to all the devices. So the read_flag_mask should be added to both
> > regmap_bus structs. 
> 
> It's there sort of indirectly for the bmp280 - the register addresses all happen
> to include that bit, then it is cleared explicitly for the other direction.

Oh okay, now I understand what you mean. Ok then I can also send a different patch
for this as well just to keep the code consistent.
> 
> 
> 
> > > 
> > > Mind you I note the bmp280_regmap_spi_write() is masking the bit out which seems
> > > backwards  - all the registers are defined with the bit set for that part
> > > but not the 380.  Ah well - not part of this fix even if it's odd.
> > > 
> 
> > > > diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
> > > > index 4012387d7956..ca482b7e4295 100644
> > > > --- a/drivers/iio/pressure/bmp280.h
> > > > +++ b/drivers/iio/pressure/bmp280.h
> > > > @@ -191,6 +191,8 @@
> > > >  #define BMP380_TEMP_SKIPPED		0x800000
> > > >  #define BMP380_PRESS_SKIPPED		0x800000
> > > >  
> > > > +#define BMP380_SPI_MAX_REG_COUNT_READ   3  
> > > This doesn't seem useful as only used in one place.  
> > 
> > Could this define be moved in the bmp280-spi.c file or to not even use a define?
> Not use it. Don't see how it is helpful. Just check that the
> thing will fit in the array using an ARRAY_SIZE()...

Understood.
> > 
> > > > +
> > > >  /* BMP280 specific registers */
> > > >  #define BMP280_REG_HUMIDITY_LSB		0xFE
> > > >  #define BMP280_REG_HUMIDITY_MSB		0xFD  
> > >   
> 

Thank you very much for the feedback, I'll work on the patches and submit them again.

Best regards,
Vasileios Amoiridis

