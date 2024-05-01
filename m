Return-Path: <linux-kernel+bounces-164930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1D78B8519
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 06:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A449B21D30
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 04:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863FF3D97F;
	Wed,  1 May 2024 04:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhlEr0jE"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FF03BBCC
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 04:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714539008; cv=none; b=Rgd1wPk7ClBLvbJplQI2n94wYN9QvO7n0GE0UjDff07kNCwjZDo88yKgDI1mRgcXm+4CWhXC3zp4npnRs66HPAPyAlS6DP8cq6OHC5IpIK5FVDF1AeoYx79SUN2WArQXf0HF3P2BCm14nlERs9TcJ5AabWye8dD8Ykju47jJUgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714539008; c=relaxed/simple;
	bh=i578/7sTkN961mbxSbdtDKMuuODb/49Yamg8Bl95lQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pxt+BtwpobQrYEuBnRWquXXXVL8IXwXeu8cFL2Ca6oDd1Z9lcT8RmuR8myyjWBBCp8+hTBzsfRlnOdL4c3zbY2ilWeRPWJpsPiArVifJtX0xnCrMuhQfcyIx3IjxykeBqvtjRPsYpEN6uMuyb2KSPFvIEEq9OVNmZGpYv8HSGT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhlEr0jE; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ec4ef7d13aso773045ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 21:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714539007; x=1715143807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LspveVjM0MKBddXP/sF9mpSLwuAu/OfBpOaU1i3mmpI=;
        b=nhlEr0jEoX2q7o+Lo3vvxHWazB1M7VbIwBatA+bsYuaaCOwDkIZX+Dc5qDrZpRMNqb
         +LjljhdbuEPamNO3IXSmFLYHYedP7e0G3nhRqOvfjjaO8Q9sUFX9cCS4i6CM3dKYE4dK
         u/pUBr2HMiNPjrr3+xlgeq7GxRKQNa8TVWVpy0SbpE/LryvTOuwhAPwzSsum+/tN61Js
         sEaIFmesaHpoIFX2Tx9IwUhyRFJPRZ2jYssyw6wmBZM8oWPMygdqEZ62ae9mp91E4Ihl
         yHaDiaVh4HaGC7elMdFPY6TTzsC9uqU27hWfzwtODq0bOt4mcjRHV2oUGsrSaZQeBk4l
         DnVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714539007; x=1715143807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LspveVjM0MKBddXP/sF9mpSLwuAu/OfBpOaU1i3mmpI=;
        b=RILO71BCtRPv5Tqw1Zuem7/EwxcTJqfAxwbsUutxFpYF7a0XYTcgc2myg3vx9Qp1WU
         rlZhS5iseDGZ4LIVxGskSDTRhBwhr23GRua2Nc8OdT/0Y+NGCRBbKqu6Dn3i3S+LqQL2
         eJVyf+4t55c6BKpRohOYbgBeDvwExKT+2EN7XYhuWznopGhiL5QHlKWhXEpq4t6JVbNl
         8TuQoY2HcSXUOrGLwSsxukC7OBOgFf16m/HbfvZsy2SeNggTM3lp/17obJ4SL8Eqv3iW
         +QH4cWbwpEwCOdHTnyywMC6ant6u36kNiFw40qJDLL7k5qKReOR807pm9F3Z6nT7jVYw
         jt7A==
X-Forwarded-Encrypted: i=1; AJvYcCUK2/fO2f1DtxhqVsLctbXtj1TNEEhDlQ9I6G05tSrWFRskU9ZdMbQzVbcQmmT9C2sDDkI5GTULo2RoRFBc3uoXSUU195Z1dfkiqpGs
X-Gm-Message-State: AOJu0YwwL525Z+foneNOs/abjgQNlrzp6r5/pGOfA+temhAZtTgTSxOk
	XH9keTIOaVQWN9qTDGFjYYLFoFAgG411ieTv6O5nemFUbPhsgNI3xJ985se5
X-Google-Smtp-Source: AGHT+IGl9vRYWa/BtPGQv/efKBz04cOJm9kQwEBaM7sLdYEVO91OoVQfSKykq8MKnNj7paBfXtxwMw==
X-Received: by 2002:a17:902:ea07:b0:1e5:1138:e28e with SMTP id s7-20020a170902ea0700b001e51138e28emr1556590plg.3.1714539006596;
        Tue, 30 Apr 2024 21:50:06 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id r3-20020a170902be0300b001e27462b988sm23295249pls.61.2024.04.30.21.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 21:50:06 -0700 (PDT)
Date: Wed, 1 May 2024 12:50:03 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: akpm@linux-foundation.org, linux@rasmusvillemoes.dk,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] lib/find_bit_benchmark: Add benchmark test for
 fns()
Message-ID: <ZjHJ+7GiXFMH6oc2@visitorckw-System-Product-Name>
References: <20240430054912.124237-1-visitorckw@gmail.com>
 <20240430054912.124237-2-visitorckw@gmail.com>
 <ZjEpMy3hFXqfavva@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjEpMy3hFXqfavva@yury-ThinkPad>

On Tue, Apr 30, 2024 at 10:24:03AM -0700, Yury Norov wrote:
> On Tue, Apr 30, 2024 at 01:49:11PM +0800, Kuan-Wei Chiu wrote:
> > Introduce a benchmark test for the fns(). It measures the total time
> > taken by fns() to process 1,000,000 test data generated using
> > get_random_long() for each n in the range [0, BITS_PER_LONG].
> 
> Can you also print an example of test output?
>  
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > ---
> >  lib/find_bit_benchmark.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > diff --git a/lib/find_bit_benchmark.c b/lib/find_bit_benchmark.c
> > index d3fb09e6eff1..8712eacf3bbd 100644
> > --- a/lib/find_bit_benchmark.c
> > +++ b/lib/find_bit_benchmark.c
> > @@ -146,6 +146,28 @@ static int __init test_find_next_and_bit(const void *bitmap,
> >  	return 0;
> >  }
> >  
> > +static int __init test_fns(void)
> > +{
> > +	const unsigned long round = 1000000;
> > +	s64 time[BITS_PER_LONG + 1];
> > +	unsigned int i, n;
> > +	volatile unsigned long x, y;
> > +
> > +	for (n = 0; n <= BITS_PER_LONG; n++) {
> 
> n == BITS_PER_LONG is an error. Testing error case together with
> normal cases is even worse error because it fools readers.
>
My initial intention was to add a test for fns() always returning
BITS_PER_LONG. However, I agree that this is not a good idea and may
confuse readers.

> > +		time[n] = ktime_get();
> > +		for (i = 0; i < round; i++) {
> > +			x = get_random_long();
> > +			y = fns(x, n);
> > +		}
> 
> Here you count fns() + get_random_long() time. For your microbench
> purposes it would be better exclude a random number generation
> overhead.
> 
> > +		time[n] = ktime_get() - time[n];
> > +	}
> > +
> > +	for (n = 0; n <= BITS_PER_LONG; n++)
> > +		pr_err("fns: n = %2u: %12lld ns\n", n, time[n]);
> 
> Nah, not like that. Each test in there prints one line in the
> report. Let's keep it that way for test_fns() too. Unless we have
> a strong evidence that fns() for a particular input is worth to be
> tracked separately, let's just print a total gross?
> 
> > +
> > +	return 0;
> > +}
> 
> I'd suggest to modify it like:
> 
>         static unsigned long buf[1000000];
> 
>         static int __init test_fns(void)
>         {
>                 get_random_bytes(buf, ARRAY_SIZE(buf));

Instead of ARRAY_SIZE(buf), it should be sizeof(buf).

>                 time = ktime_get();
> 
>                 for (n = 0; n < BITS_PER_LONG; n++)
>                         for (i = 0; i < 1000000; i++)
>                                 fns(buf[i], n);
> 
>                 time = ktime_get() - time;
>                 pr_err(...);
>         }
>

That does seem like a better approach. I'll move it to lib/test_bitops
and send a v3 patch series.

Regards,
Kuan-Wei

> >  static int __init find_bit_test(void)
> >  {
> >  	unsigned long nbits = BITMAP_LEN / SPARSE;
> > @@ -186,6 +208,9 @@ static int __init find_bit_test(void)
> >  	test_find_first_and_bit(bitmap, bitmap2, BITMAP_LEN);
> >  	test_find_next_and_bit(bitmap, bitmap2, BITMAP_LEN);
> >  
> > +	pr_err("\nStart testing for fns()\n");
> > +	test_fns();
> 
> There are 2 sections in the test - one for regular, and another for
> sparse data. Adding a new section for a just one function doesn't look
> like a good idea.
> 
> Even more, the fns() is already tested here. Maybe test_bitops is a
> better place for this test?
> 
> > +
> >  	/*
> >  	 * Everything is OK. Return error just to let user run benchmark
> >  	 * again without annoying rmmod.
> > -- 
> > 2.34.1

