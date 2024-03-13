Return-Path: <linux-kernel+bounces-102419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3458887B245
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30251B32E10
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAC65A78A;
	Wed, 13 Mar 2024 19:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnlpoAQ3"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED835A4CB;
	Wed, 13 Mar 2024 19:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710357771; cv=none; b=FrBuwlSs8x9UTl8AFEEzoHj3DmtULsOAWRNV+vS9FjeH0Qd1EmABBB6STzA2DQ1MT5gGYA5XjZp11QeceKL78FdISKRPz8xx55jodmfCpJrf6bx+Q8a1yekCSdwY0zynXgJMnhLfHLOPHsG+iOWw2B3mXmZITHQhIsS+i3ZQ3SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710357771; c=relaxed/simple;
	bh=hegL53YisatVfqScAH8O+Ma2lNAVHNa5j9LpcGW4hlQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qR19rMa+U8LbprpzIXDQ0RRE8480G9RZqjSMIrkxpKSBiErVD7Xwcp+VeNmmzKSTk7PA73KvSD4b/81+5yCp8mpp+7mINaCNZvpW7uJ/9KAXY5PcpHJ4nkrt0F3SZBEZz155CumVJz2uZ1qDwkEPBeRpsi1ZeyATz6jyGNH8tUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnlpoAQ3; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5139d80f8b6so274076e87.1;
        Wed, 13 Mar 2024 12:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710357768; x=1710962568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j3gL898swQb46Dg7Z65eqHW+FEtsbhrhHveU9DG0Nak=;
        b=OnlpoAQ3oLzh3jCvYf5w98A+tGzlb4doqZ7KMIF1yJrv02h/4mXMKMGgk+mRMWtHCS
         Rcb6vBLlxoRq9krOvLfc9tPlb18HMcznFgOkmSLZEmLGwdOZd8rsFEdcRVcv9tWCAGkg
         pUe3vVtJDuIVM9tmh+65HuuWi6IDujpBOrGGi4LsBv6aNmV0RIxQBx7qLUa4JY867YVs
         U2wqpRMckoNuExYvOykkd/dOS4M683/FmXMQJ/e/r3ZCpCcG81D8ss6sabjd3PbBpX4f
         LAf24UuYuWWOzLU9dhlzFAt6xZchfE1md4Y8TaYvAWLh6I5EqJ4EqEO0/EOUBgdWtLBU
         RL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710357768; x=1710962568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3gL898swQb46Dg7Z65eqHW+FEtsbhrhHveU9DG0Nak=;
        b=IVjq3WbcIMRz2GxTHWpqmIz2vZHrSkGiPRdQpIYtbkefDZFoij0DFwk3riCc9ZS6bt
         KajKjQPJLVTrPZfn+8iWJeBbha7DOr9XWFrurYbhK5nvHIumfDAwbpnty6zRMIDEldBn
         LhSak6ydS2OpBSTeybLWw2B1GGtJAw2hCgWMr8D8KFdPfLhrfKyx2ZImEhUn+HpVuHpw
         /ZJtq9r9QP/Lw0Welms+7yyaZYwoIygQCaNBYclgADhgKfGL2y+EVld70DpVyGBhBHO7
         mWTwSD4XfYyvNVElgaDldoFoZY+oMFwJEgtHGtO9Hgb8vudz3aZ6+5dSIfdmA8VLSPu9
         rGfw==
X-Forwarded-Encrypted: i=1; AJvYcCWm0RlmBS9HZ99gjTxyGcrkHn80MIBMqMNKnCXZrh56FGz8e6shVkZd1r8dVEGMv17XJarbqYWhbDG9GkvQFHFwlH4q6XMv3gcWAbLRu4IxU5AgEB+yeT5PR1FkGeqBeVa32sgIs5j/
X-Gm-Message-State: AOJu0YxDHRa7GEKDCTgWrOM1WmbE+N1hCJXdioXSZ/JWV/xKZna5/Q9u
	ZrgFoJNELLPwDGaN5RopTkkJ+37GNX596cX8lBl1i0sjjfrL95G6
X-Google-Smtp-Source: AGHT+IH8OvgB09Zk6nPwLCqXHFKhBEtAFHEG+1k9GCXH+aKBdlJaW9sgiMNTohtT47iVRdTG6sqDLw==
X-Received: by 2002:ac2:4c9a:0:b0:513:c658:7997 with SMTP id d26-20020ac24c9a000000b00513c6587997mr2707890lfl.24.1710357767813;
        Wed, 13 Mar 2024 12:22:47 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:fa35:157e:1a40:3463])
        by smtp.gmail.com with ESMTPSA id ij12-20020a056402158c00b00562d908daf4sm5200027edb.84.2024.03.13.12.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 12:22:47 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Wed, 13 Mar 2024 20:22:45 +0100
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, ang.iglesiasg@gmail.com, mazziesaccount@gmail.com,
	ak@it-klinger.de, petre.rodan@subdimension.ro,
	linus.walleij@linaro.org, phil@raspberrypi.com, 579lpy@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] iio: pressure: Simplify read_* functions
Message-ID: <20240313192245.GA1938985@vamoiridPC>
References: <20240313174007.1934983-1-vassilisamir@gmail.com>
 <20240313174007.1934983-3-vassilisamir@gmail.com>
 <ZfH4IyeFTGFBKT4J@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfH4IyeFTGFBKT4J@smile.fi.intel.com>

On Wed, Mar 13, 2024 at 09:01:55PM +0200, Andy Shevchenko wrote:
> On Wed, Mar 13, 2024 at 06:40:03PM +0100, Vasileios Amoiridis wrote:
> 
> In the Subject: ... read_*() functions
> 
> > Add the coefficients for the IIO standard units inside the chip_info
> > structure.
> > 
> > Remove the calculations with the coefficients for the IIO compatibility
> > from inside the read_(temp/press/humid) functions and move it to the
> 
> read_{temp,press,humid}()
> 
> > read_raw function.
> 
> read_raw()
> 
> > Execute the calculations with the coefficients inside the read_raw
> 
> read_raw()
> 
> > oneshot capture functions.
> > 
> > Also fix raw_* and comp_* values signs.
> 
Thank you very much for pointing these out, I should have thought it.

> ...
> 
> >  		case IIO_TEMP:
> > -			ret = data->chip_info->read_temp(data, val, val2);
> > +			ret = data->chip_info->read_temp(data);
> > +			*val = data->chip_info->temp_coeffs[0] * ret;
> > +			*val2 = data->chip_info->temp_coeffs[1];
> 
> > +			if (!strcmp(indio_dev->name, "bmp580"))
> > +				ret = IIO_VAL_FRACTIONAL_LOG2;
> > +			else
> > +				ret = IIO_VAL_FRACTIONAL;
> 
> I'm wondering if we may replace these strcmp():s by using enum and respective
> values in chip_info.
> 

The whole problem starts from the fact that all these BMPxxx_CHIP_ID defines are
not unique for the respective BMPxxx device. You mean to add a new variable
that could store some enum values that would be the actual chip_info IDs? Like:

enum chip_info_ids = {
	BMP085,
	BMP180,
	...
	BMP580,
};

and later for every chip_info struct to use it like this:

const struct bmp280_chip_info bmpxxx_chip_info = {
	...
	.chip_info_id = BIT(BMPxxx),
	...
}

And in the read_raw() function to just use the test_bit() function in the same
way that is done with the test_bit() and avail_scan_mask to test for the
enabled channels?

Best regards,
Vasilis Amoiridis 

> >  			break;
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

