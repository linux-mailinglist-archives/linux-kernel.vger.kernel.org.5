Return-Path: <linux-kernel+bounces-24719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A31EE82C149
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D2F7B21390
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340096D1BF;
	Fri, 12 Jan 2024 14:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lhpBqmVy"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40E95917D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 14:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e5a5b0fb5so25945615e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 06:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705068213; x=1705673013; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UEeO6KfMVHE4TCnnYSwCeQCXJS1d2iwkJ/b5jGtcO00=;
        b=lhpBqmVy1C+HoAGTAZiwIlQVKasJ/yD2fmy8hi3vDZn0nQ8RWZxVmcvrWLFs7Ip3V7
         LZk98wK73NgIcaJNfCvcrLXN05Tum9vxqWUoYKJM9UIojOh9nVv+KAxkrXaQAqRTd6MC
         7zZEY4bWfqfxiFhPUIjG85F2ymVyB6oCS5sZiMwYmPUGIizypik5gvd+2lfdoOE8OSOJ
         hjCBXWHD+9rxxxfvuBguGyYIjeSEGwhGB9PajfKnAmAqjezlSr/tXHcOIpJ8ut2dyUdH
         xwF/quAGXJcAhzIUn5A/lvKoIf1BII9IZ/88SAa1lrFY0QjCpGoJFUvUr8f8aw/Q0XDN
         VwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705068213; x=1705673013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEeO6KfMVHE4TCnnYSwCeQCXJS1d2iwkJ/b5jGtcO00=;
        b=v+sijBKHcurvgkodvf1uWPcA0Ofy4BDHyD9KoXFnqA2UStmq9wgClblCHgTIr9tLCp
         ml5/mlvWaxN2yyK0ZeSApY5mhqVJXAfWQlfVz2jzTFtNaMxhnN9UyjUo+Jv2UoHRzv7r
         WgtfjA2ecc82BR/sqm2LJWIaCldH4JuOZ3RypljrPy2eA49q/2RK+Xo3UddIcnlM1w9k
         hvlQQ+RhLJFl7YhJj+VVj4LVw8T3BQpMCwSOmFt8jo64tSCOpYaYCxPZh7m/cyt1iunf
         UelbaRAsYIt0uVFKdgfAGAFoNUwUtAe2BWcsnoBrY67nxeJ+1EEkfesvzhEi4OrPS8Da
         8C5Q==
X-Gm-Message-State: AOJu0Yz6Gba41BG8ybVMB63UxeWmqAMEn/LTBLnJ68m+G10MB/cSUVIY
	wlNaPCC5JTjuCFdP7bLsZ9lG4MjPHyHDbnEtFDDCZubsrs4=
X-Google-Smtp-Source: AGHT+IFgGgR8UEGkfCFo4XcLeyMOXZstBznmpQZ1x/fsp8+54cyEfD+rBX3DXCfu0AYfHvPVXdt8Fg==
X-Received: by 2002:a05:600c:154b:b0:40e:50c1:4e6c with SMTP id f11-20020a05600c154b00b0040e50c14e6cmr738521wmg.153.1705068213030;
        Fri, 12 Jan 2024 06:03:33 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id c11-20020a05600c0a4b00b0040d53588d94sm9899003wmq.46.2024.01.12.06.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 06:03:32 -0800 (PST)
Date: Fri, 12 Jan 2024 17:03:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Laight <David.Laight@aculab.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
	'Andrew Morton' <akpm@linux-foundation.org>,
	"'Matthew Wilcox (Oracle)'" <willy@infradead.org>,
	'Christoph Hellwig' <hch@infradead.org>,
	"'Jason A. Donenfeld'" <Jason@zx2c4.com>
Subject: Re: [PATCH next v4 1/5] minmax: Add umin(a, b) and umax(a, b)
Message-ID: <02701430-65cf-44ab-8a8b-752c5d973d21@moroto.mountain>
References: <b97faef60ad24922b530241c5d7c933c@AcuMS.aculab.com>
 <41d93ca827a248698ec64bf57e0c05a5@AcuMS.aculab.com>
 <737627fd-b68b-4c9d-8700-f0e0d6d9cec8@moroto.mountain>
 <8e45b321c49b4c27a61b2db076ed5383@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e45b321c49b4c27a61b2db076ed5383@AcuMS.aculab.com>

On Fri, Jan 12, 2024 at 01:40:30PM +0000, David Laight wrote:
> From: Dan Carpenter
> > Sent: 12 January 2024 12:50
> > 
> > On Mon, Sep 18, 2023 at 08:16:30AM +0000, David Laight wrote:
> > > +/**
> > > + * umin - return minimum of two non-negative values
> > > + *   Signed types are zero extended to match a larger unsigned type.
> > > + * @x: first value
> > > + * @y: second value
> > > + */
> > > +#define umin(x, y)	\
> > > +	__careful_cmp((x) + 0u + 0ul + 0ull, (y) + 0u + 0ul + 0ull, <)
> > 
> > Why do we match "a larger unsigned type" instead of ULL_MAX?  Presumably
> > it helps performance somehow...  I agree that it's probably fine but I
> > would be more comfortable if it skipped UINT_MAX and jumped directly to
> > ULONG_MAX.  These days 4 gigs is small potatoes.  The vmalloc() function
> > can allocate 4G so we've had integer overflow bugs with this before.
> 
> The '+ 0ul*' carefully zero extend signed values without changing
> unsigned values.
> The compiler detects when it has zero-extended both sides and
> uses the smaller compare.
> In essence:
> 	x + 0u converts 'int' to 'unsigned int'.
> 		Avoids the sign extension adding 0ul on 64bit.
> 	x + 0ul converts a 'long' to 'unsigned long'.
> 		Avoids the sign extension adding 0ull on 32bit
> 	x + 0ull converts a 'long long' to 'unsigned long long'.
> You need all three to avoid sign extensions and get an unsigned
> compare.

So unsigned int compares are faster than unsigned long compares?

It's just sort of weird how it works.

	min_t(unsigned long, -1, 10000000000)); => 10000000000
	umin(umin(-1, 10000000000)); => UINT_MAX

UINT_MAX is just kind of a random value.  I would have prefered
ULONG_MAX, it's equally random but it's more safe because nothing can
allocate ULONG_MAX bytes.

regards,
dan carpenter







> If the type is __int128 (signed or unsigned) then nothing happens.
> (which means you can still get a signed v unsigned error.)
> You could add in (__uint128)0 on 64bit systems that support it,
> but it is so uncommon it really isn't worth the hassle.
> 
> Unlike any kind of cast the arithmetic cannot discard high bits.
> I've found a few min_t() with dubious types.
> One was a real bug found by someone else at much the same time.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

