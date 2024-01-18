Return-Path: <linux-kernel+bounces-30008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FA08316AF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A3828258F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C476120B05;
	Thu, 18 Jan 2024 10:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mZcDyamJ"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C50EA42
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 10:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705573860; cv=none; b=TNJ5plR/zkMSFTi+0Tr517h/XXJdnJzboKj4syVlGH0Vz2FVPq34ZJ3v8ZTnXvDgQBGOMES7hwn1KEspLkjJ03Zaunp4bhAshdyftRnse/Tm0qAKr3wAM0V/brilU/NtpECVs9bq1o98FbVid0xg0r9PyCcBnfSqat5s8HljJ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705573860; c=relaxed/simple;
	bh=2LaYni2ALdyLXX8C/p+uyNMU3L7D1TXFe76UtWyOVDY=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OzIKhBEqzUK64eLG85JvbXEMYgJF8pIhIw2F0xJfaZO22icssH22YFy6M4g1SsqEZEWtbXc+6DUgBIRS6UJynwe7XBfT5XO0EygyucTWWB2aA1aLRYLIljS/9VNIbCwxAxUzoPZyRaRtLHz9vNwRU8AL6taUqok/boTbO4Ax6vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mZcDyamJ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e7065b7bdso50262705e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 02:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705573855; x=1706178655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=puh0I2pZNJUghfANUr9RC+vshk+nAWk8JdQSAu06TD0=;
        b=mZcDyamJLKo1+JiN+Db7i8s0/rsQBdQmaXt2v4BtbVOLV8lIBExbZlMbBTO8R1k2bM
         9sqWm1nLXS5wEeXNcOATUmETgEzr7gZac2PTl9g6F9mN55ZBw86p7IRl2uYnfLqbG5qR
         xv7aTE49sE5gNwPntHGQB1MGGrnVzz1evVa+FspCCcJ+tPMuXLGpnfOn0eGWI47yC7V2
         W3drzTCHqP5mlPnJkXsUED8NqW4FaHWDTpY+KmLUvbhai2Vv9PrEfVFLCbqsVIKvDKJX
         Robuh101vh587AGqEaB7pPiT9y/cizBcoSkRc31aaPMfzpjJCtv8wKBl5XhMG3ujg6hl
         y56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705573855; x=1706178655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puh0I2pZNJUghfANUr9RC+vshk+nAWk8JdQSAu06TD0=;
        b=TFQbjo7prxy1N7v9mCkAt3PeixkpjMW5dewwLohc1gEp6g7ae4fySl8y9gBzHO4ot+
         T83h2emdyIQoV9KN26uHRqFjJIq6HRrt4SeJygPPTsdUsD0sjICTsorvniPVcr4fSzSC
         92+i50jkA6mpeMA+D4iSGQEZdaLTjFbt39HVmnKVMZi5FDGGE0Dxiyh1ZqsFJ5MuszdX
         ydtAdmHM1SnVllhf0FCWwPzAiE7FyEtJQBS10l9hd7mMiz4TYhOrJ93tFYwI/ndnDGEq
         wz+BdrWHhj6KRJl3YeDI+XgRlEqRJFLsDzi3vSXYZX9KDDgxIVEOsrVjtWUIVnbQnMF1
         M6Yg==
X-Gm-Message-State: AOJu0Yw7yhJzPWjnKfYP3jMuZc92K6PkFgac1fG1DWledq7MEzDVrE8Y
	xBTq58acZN03UtoO4cv/72MObkbWB25cIBSYrCzgdO6YgR0heojH4soql4vFQFo=
X-Google-Smtp-Source: AGHT+IFbQAURPfglSE3x7LpSbRaP1FIQ3glhCyaKIwv0eVlSt7UxqTJeZiIQyRf/ew4k/abQgGCSEQ==
X-Received: by 2002:a7b:c399:0:b0:40e:5d1b:b1a1 with SMTP id s25-20020a7bc399000000b0040e5d1bb1a1mr271744wmj.67.1705573855555;
        Thu, 18 Jan 2024 02:30:55 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id z12-20020a5d640c000000b00337bcef9193sm3711367wru.44.2024.01.18.02.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 02:30:55 -0800 (PST)
Date: Thu, 18 Jan 2024 13:30:52 +0300
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
Message-ID: <af0bfe8a-8b29-43df-b385-a23f0da54a7b@moroto.mountain>
References: <b97faef60ad24922b530241c5d7c933c@AcuMS.aculab.com>
 <41d93ca827a248698ec64bf57e0c05a5@AcuMS.aculab.com>
 <737627fd-b68b-4c9d-8700-f0e0d6d9cec8@moroto.mountain>
 <8e45b321c49b4c27a61b2db076ed5383@AcuMS.aculab.com>
 <02701430-65cf-44ab-8a8b-752c5d973d21@moroto.mountain>
 <d05f91a308174cf0b3e5707625a212bc@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d05f91a308174cf0b3e5707625a212bc@AcuMS.aculab.com>

On Fri, Jan 12, 2024 at 02:26:33PM +0000, David Laight wrote:
> From: Dan Carpenter
> > Sent: 12 January 2024 14:03
> > 
> > On Fri, Jan 12, 2024 at 01:40:30PM +0000, David Laight wrote:
> > > From: Dan Carpenter
> > > > Sent: 12 January 2024 12:50
> > > >
> > > > On Mon, Sep 18, 2023 at 08:16:30AM +0000, David Laight wrote:
> > > > > +/**
> > > > > + * umin - return minimum of two non-negative values
> > > > > + *   Signed types are zero extended to match a larger unsigned type.
> > > > > + * @x: first value
> > > > > + * @y: second value
> > > > > + */
> > > > > +#define umin(x, y)	\
> > > > > +	__careful_cmp((x) + 0u + 0ul + 0ull, (y) + 0u + 0ul + 0ull, <)
> > > >
> > > > Why do we match "a larger unsigned type" instead of ULL_MAX?  Presumably
> > > > it helps performance somehow...  I agree that it's probably fine but I
> > > > would be more comfortable if it skipped UINT_MAX and jumped directly to
> > > > ULONG_MAX.  These days 4 gigs is small potatoes.  The vmalloc() function
> > > > can allocate 4G so we've had integer overflow bugs with this before.
> > >
> > > The '+ 0ul*' carefully zero extend signed values without changing
> > > unsigned values.
> > > The compiler detects when it has zero-extended both sides and
> > > uses the smaller compare.
> > > In essence:
> > > 	x + 0u converts 'int' to 'unsigned int'.
> > > 		Avoids the sign extension adding 0ul on 64bit.
> > > 	x + 0ul converts a 'long' to 'unsigned long'.
> > > 		Avoids the sign extension adding 0ull on 32bit
> > > 	x + 0ull converts a 'long long' to 'unsigned long long'.
> > > You need all three to avoid sign extensions and get an unsigned
> > > compare.
> > 
> > So unsigned int compares are faster than unsigned long compares?
> > 
> > It's just sort of weird how it works.
> > 
> > 	min_t(unsigned long, -1, 10000000000)); => 10000000000
> > 	umin(umin(-1, 10000000000)); => UINT_MAX
> > 
> > UINT_MAX is just kind of a random value.  I would have prefered
> > ULONG_MAX, it's equally random but it's more safe because nothing can
> > allocate ULONG_MAX bytes.
> 
> umin() is only defined for non-negative values.

I'm so confused by this.  To me the big selling point of min_t() was
that it clamps things to between zero and the max.

> So that example is really outside the domain of the function.
> 
> Consider:
> 	int x = some_positive_value;
> 	unsigned long long y;
> then:
> 	min_t(unsigned long long, x, y);
> 	Does (unsigned long long)x which is (unsigned long long)(long long)x
> 	and requires that x be sign extended to 64bits.
> 	On 32bit that is quite horrid.

I wasn't saying jump straight to ull.  I was suggesting jump to ul then
ull, but skip uint.  On a 32bit system, you can't allocate ULONG_MAX
bytes, so it still ends up being quite a safe number.

regards,
dan carpenter


