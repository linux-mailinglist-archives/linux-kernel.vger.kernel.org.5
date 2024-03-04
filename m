Return-Path: <linux-kernel+bounces-91147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4D2870A16
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D78D7B221BD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FD178B73;
	Mon,  4 Mar 2024 19:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aG4JkGbA"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4801278B5C;
	Mon,  4 Mar 2024 19:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579325; cv=none; b=g43CfGhYiEWV6DI64wHexy2hGGSt2VIH/egBsoHfuf1ObDsL6gbXPII4HTzVYVW/zF/DwxzWrJRLqR4IWsJ8+eBZjt+XGSZIYv188gPYrCoLY0Se+2uIJZArxv1s40K2YAHPjmKr0/TquGRNtcjbBHpGC7pXl5in06Gt7+oBkMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579325; c=relaxed/simple;
	bh=acNWKsK8v0Hl0gWc0y1JCgujLyd6CVhwRPtUiZdy3rI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKL0pRfixEpPSUwnnLmSsINrCOnAjd+OhsKUgRplQbY7GuH9OKzaM37ZUyjqGFRzaujMrxor1yROSAxU31kT4tiQuGhcpnaER8h1RqUftn/edCE8AhW/H/4yGZt+GYnKD+HKE1HGyfgXyW7f7DEfXAkFjT3ijznT3RQi2UwhxfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aG4JkGbA; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d21cdbc85bso59197381fa.2;
        Mon, 04 Mar 2024 11:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709579321; x=1710184121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yg8xEMBWIK3KAwZ8WBuzzba30QNUj6pIsKl/SjToOww=;
        b=aG4JkGbAqMAVLoALaIXHjfO7CRUsw9Jf56AJNwx9+it1Yrff6ZF0BFjpjzM2tScGDN
         VN2PE1u2y5Seexwf3VgrTQXHtJa5SWVhjF9JmGzavlC5tvjyn/E0DUhLY01u7k3WeRgH
         Y2DVdTZqdicqzkjOY1wRa30lsZhVTYG2GT2n5z//FA+hw6V7a2EErseF4KwGGVAIb+Xf
         lmyf46FIflxkiQquw9ORrj90LV8vKf5SrLkSbcmdkEe1ah0N1HUn0DgM8TXCg3UM/GnV
         Xfm0LKKELtM5ssETeQr8UzrUsDDyZprpEMYbKuOmR+8Ru2oTFIn5YMcWviubyM+QvV1m
         Msqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709579321; x=1710184121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yg8xEMBWIK3KAwZ8WBuzzba30QNUj6pIsKl/SjToOww=;
        b=ertZIhxj+U9GMANL4aFECII0rqzgHBmYk15UuI+YJqcj+WhmAJ12r/brKNfMndHfhv
         boLPOiv8mPeHEa6LFw9Ml1IxtpKq3N5LKv+a+KhQc1vP/KuBYTp7k0x5a7A38SewOLq9
         CGuza3td1Ljq0refCf5FOY2r/2ywNKua25Y6GRlrGZ9algUowtoxMEv8Yk3H39pFKX44
         9UuTLEBuA74bgfIfDspn4GfjVeSaHZTxmiF+ba90BSN8UPQqFJHHq07w3JwFIr1wWEKO
         HoOoDQMsp8x8W87guG+YGAJLEITbIZW1K642AABatUWe85KHI1n0fhbTM0dlh4w2XyDe
         vG+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWcd0a3IEq8A65iqPBvCbow+iRUWtOaGESAjW5BP4NiP0BM4yeYPW4RWgaN0iw6LkMyD/xxLNZqO5rRhFfOY/Lc8wkLAyUHF+4EHGd7sATlc4rZbaKBVWRE8XCm6Nzb/OiCG30jX5p9
X-Gm-Message-State: AOJu0YzG6wNiyen3Eg+rPzakiCM5pUyys9jMOimi/+VTek7rTWMSiXiD
	yBJlS9bwSOZm05BzV4fx103YrWaq6ijWDcRVnub+04rPFEvphUwF
X-Google-Smtp-Source: AGHT+IF/1yeyTVBr7OaVKHCtofblAkxqFf2waO3j37JmGJEogUEA6PhP0hW1s6Qyj89+yczh4foauA==
X-Received: by 2002:a2e:99d8:0:b0:2d0:f258:df02 with SMTP id l24-20020a2e99d8000000b002d0f258df02mr6571600ljj.51.1709579321170;
        Mon, 04 Mar 2024 11:08:41 -0800 (PST)
Received: from vamoiridPC ([2a04:ee41:82:7577:d458:fb5d:c4e5:fb19])
        by smtp.gmail.com with ESMTPSA id p17-20020a056402075100b005662f95fa6dsm4917583edy.89.2024.03.04.11.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 11:08:40 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Mon, 4 Mar 2024 20:08:38 +0100
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, ang.iglesiasg@gmail.com, mazziesaccount@gmail.com,
	ak@it-klinger.de, petre.rodan@subdimension.ro, phil@raspberrypi.com,
	579lpy@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: pressure: Add triggered buffer support for
 BMP280 driver
Message-ID: <20240304190838.GA4431@vamoiridPC>
References: <20240303165300.468011-1-vassilisamir@gmail.com>
 <20240303165300.468011-5-vassilisamir@gmail.com>
 <ZeW15Q2juyQuTw5q@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeW15Q2juyQuTw5q@smile.fi.intel.com>

On Mon, Mar 04, 2024 at 01:52:05PM +0200, Andy Shevchenko wrote:
> On Sun, Mar 03, 2024 at 05:53:00PM +0100, Vasileios Amoiridis wrote:
> > Add a buffer struct that will hold the values of the measurements
> > and will be pushed to userspace. Modify all read_* functions in order
> > to just read and compensate the data without though converting to the
> > required IIO measurement units which are used for the oneshot captures.
> 
> > +#include <linux/iio/buffer.h>
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>
> > +#include <linux/iio/trigger.h>
> > +#include <linux/iio/trigger_consumer.h>
> > +#include <linux/iio/triggered_buffer.h>
> 
> Yes, taking into account the comment against patch 1, this will become the part
> of iio/* group.
> 
> ...
> 
> > +	/* val might be NULL if we're called by the buffer handler */
> > +	if (val) {
> > +		*val = comp_press;
> > +		/* Compensated pressure is in cPa (centipascals) */
> > +		*val2 = 100000;
> 
> Here and everywhere else where it makes sense
> 
> 		*val2 = CENTI * 1000; // (What is 1000 here?)
> 
> from units.h?
> 

I didn't change these values, the addition here is that I put them under an
if statement that checks if we were called by the buffer handler or by the
oneshot capture read_raw function. The point is that every sensor provides
values that need different scaling in order to have the IIO standard
measurement units. In the above code I guess since 1kPa=100000cPa that's
why *val2=100000.

The *val and *val2 values could be moved to the read_raw function as it will
already happen for the IIO_CHAN_INFO_SCALE values from chip_info arrays as
you proposed in Patch No.2. This would require though that all the functions
like this one you commented would need to change. Is that something that you
think as better?

> > +		return IIO_VAL_FRACTIONAL;
> > +	}
> 
> ...
> 
> > +	struct {
> > +		s32 temperature;
> > +		u32 pressure;
> > +		u32 humidity;
> 
> > +		s64 timestamp;
> 
> Shouldn't this be aligned properly?
> 

I saw that in some drivers it was added and in some it was not. What is the
difference of aligning just the timestamp of the kernel?
> > +	} iio_buffer;
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

