Return-Path: <linux-kernel+bounces-24660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DFD82BFE1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F86D1C2307D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8489E59B50;
	Fri, 12 Jan 2024 12:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OFOQk6Bf"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13965917D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 12:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e636fd3d2so8401495e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 04:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705063238; x=1705668038; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=geEkxPaDW5GCpv1WqkMn5Bcqr64LHTF65oGNQRrTPxM=;
        b=OFOQk6Bfem7IXz7Vt1eg0DkBxas4os6xqvwgkwTQ8P98LGH5qdHf7qe9gNE5nwlqj5
         zSh18vw6dmDGYLCclz4lAyDUyhvcxLTla3ThAS99ZV+/zuauR/kIU5gAn+A1ra5mWvAd
         sOjnw013CqSNEiIXKUNWYCE+PiEJCcm0GGOLkG7+716luLHw3MMwABmS1/VLwJ/x0PfH
         Mln39Aup34D/VRisztxPeYq4MGNKU0MUlzpY1NV3xE1jUw8ZwJpoPonVpF5lqPSQNJ06
         rPcgxq4buGL9VbenOjlO7LmPZ/2gdP3q3BspflecjVJZThZKLeWYgOvL/dQkt6WIyA/G
         eUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705063238; x=1705668038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=geEkxPaDW5GCpv1WqkMn5Bcqr64LHTF65oGNQRrTPxM=;
        b=Isu2kALkZSby9rPlbjqWxwBQkU2TlN5k7dDhf1U9TXHHy1r/RnMy+eCExX9vVkOs5s
         p4bOUi48UnPaTfsD3df3oevng76LVddZN9o/HAu4bKSRZG2IuZTL8KX/Jt0L4lVLV2B6
         v4aotzbnhpoz2fcVPEE3P+DfsNNGfMFPxv8ANnLFl2mNkepYfu2Qp69KCXa+97J2Kdat
         to/GmvJPzYALtghdcDyrsQGaWvVKRCPs5GYgkx412KFLONk+C4xH35oqnDMg24Okzch/
         HDhsCAvjeHtC9JIqYRaafShwgIP2VtwXDdHuzLTtZjgQIIR5X99YkG4/yBDcNzCU16fy
         Miug==
X-Gm-Message-State: AOJu0YwXI+WzeO4aI5MlGSwD7GBbMzk04xfhUfW7Zf8a+CISgJbBy8tq
	HTtomAlvxnUzw7o/bRDXBpWEl3v/1wjTNw==
X-Google-Smtp-Source: AGHT+IGxD9D4VxonBvf7HRI1P+hVHOgFXZZDJkziH6t6EUKdxjWXakC8zODcIaOcWmoZ3FG2XBIk5Q==
X-Received: by 2002:a05:600c:a083:b0:40e:549c:1752 with SMTP id jh3-20020a05600ca08300b0040e549c1752mr738314wmb.13.1705063238091;
        Fri, 12 Jan 2024 04:40:38 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c190700b0040e52cac976sm9419713wmq.29.2024.01.12.04.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 04:40:37 -0800 (PST)
Date: Fri, 12 Jan 2024 15:40:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Laight <David.Laight@aculab.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
	'Andrew Morton' <akpm@linux-foundation.org>,
	"'Matthew Wilcox (Oracle)'" <willy@infradead.org>,
	'Christoph Hellwig' <hch@infradead.org>,
	"'Jason A. Donenfeld'" <Jason@zx2c4.com>
Subject: Re: [PATCH next v4 0/5] minmax: Relax type checks in min() and max().
Message-ID: <8ae34aa0-ffcc-43c9-9192-393cf2707c38@moroto.mountain>
References: <b97faef60ad24922b530241c5d7c933c@AcuMS.aculab.com>
 <918545c4-0870-4ea5-ab11-53eaed91aec7@moroto.mountain>
 <97e6fe43318b4cad865feadace402880@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97e6fe43318b4cad865feadace402880@AcuMS.aculab.com>

On Fri, Jan 12, 2024 at 12:16:00PM +0000, David Laight wrote:
> From: Dan Carpenter
> > Sent: 12 January 2024 09:13
> > 
> > I've often wondered why so many people use min_t(int, size, limit) when
> > they really do not want negative sizes...  Is there a performance reason?
> > git grep 'min_t(int,' says there are 872 instances of this.  Probably
> > some do want negatives but it's a quite small percent.
> 
> But you really don't a negative 'size' converted to a large
> unsigned value above the limit - that would be worse.
> All the type checking is there to stop that happening.
> 

I understand your changes, it seems like a really nice API.  I was just
asking about min_t(int, in old code.  Just to take the first example
from my git grep:

arch/arm/mach-orion5x/ts78xx-setup.c
   160                  sz = min_t(int, 4 - off, len);
   161                  writesb(io_base, buf, sz);

If len is negative then we write negative bytes to writesb().  What
was the thinking here?

> Even with my changes min(int_var, sizeof()) is a compile error.
> To do otherwise would really requite the sizeof() to be converted
> to int - leaving the other type alone.
> Easiest done by using 'int' instead of 'typeof(y)' for the
> local variable inside cmp_once().

I think I would maybe like a mins() which returns signed values, and
then we would convert all the min() usages to either minu() or mins()
and delete min().

regards,
dan carpenter


