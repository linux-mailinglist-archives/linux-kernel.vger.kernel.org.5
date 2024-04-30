Return-Path: <linux-kernel+bounces-164504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 206ED8B7E58
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C49E5283454
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB38917F385;
	Tue, 30 Apr 2024 17:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWbc+g7k"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B180417F36D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 17:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714497850; cv=none; b=ECixsSU9tQ5hKbmfvJ7i9Ts35YdtxLA8snNLsp/ZCOjVbRpFenjkTTmdPO+d3kFF7gBsKLU1QQyUnvZnJoQ30MxurwFH+JUYBW8W/GzgqVzJr1oWMU/Lm3csx5zHn0BTyPCOQb7/tzEMutvn1XjRrLdRfCshsOQZF6HdvY8Th3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714497850; c=relaxed/simple;
	bh=fXQhpvSF4TzilrKDASFj5NiPiqtys1Dtb4u68VR2dQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncHzf0Pendu9/GZ8lwJhftv+jJXFVeLkgxiDoBGyvh7mWiGq7115xzWdL9smbyQ4CKxOt3y+KP6ni8zeuQzG6/gbAErRjAm5hkjCv4HfrI0rSFtF44rso/yvIFA+W+siC+91fxb49G7V4HCBrWMy5B/LCy4mWsSuICsv65Ziyz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWbc+g7k; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-de5acdb3838so5042746276.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 10:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714497847; x=1715102647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iD63vFyJsuwO/ZEyTcDwZyYFWU/Yx7AB35okaZAiqfQ=;
        b=nWbc+g7kZMX/FFSO9YzXzNf6Gah5lpqoNxTCO/Gz6PU2D+PgMKjzmwLxQljNT2P+1f
         3/IacbXXZXtoNdGCKgNMXDdbJjY92T/RCfwPTh+yPmSy7S4L8ok89vGssdLte26GZ22W
         rt416kP42CckA1NldcryMrKyfkFxMYBpnGY+naceKK94DDZ16A6srAZgrGu8e1yqXkNp
         vcBGXKUOFVFGiYFEV5vIWlm4U9684pTAfPLmGjp9BOEg4wLJqn9uzOsDFbqz0KmtKYVZ
         yuCH9kfljQ5oek4ilnrEPVGB0Ue0FFmg7okOLBJgLFGqmsTGEsFKQmqFz725JL+/+iC1
         +1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714497847; x=1715102647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iD63vFyJsuwO/ZEyTcDwZyYFWU/Yx7AB35okaZAiqfQ=;
        b=eZKz5j7PU60qmAo12ofTCoiFlwvAx9L/N5v9XtXl8JFmmbMuepF63i5L8LVOirq+lS
         wgXLdk3k3RITPScuudZkWce7b7T2YI+qpwowu9AGptf734yez+RMU44vSq9UxzIV3ATu
         4GJuEK0euXAaGNdKcN9rVXrVf95nxR/4e1FNMdSIVHFFzrTveQEc9RJykKufElC4FXkE
         NovWnCcfcPlKkSQ+LfP+kC3eCTqDa51DNdrETbk0uG/tNA73LleIieEovxuET2Z/N9Ep
         dxM6E+cqgJW9jwWYZBaAxpeDT7LPvmgvhlSo/iAan9QuOLkMBry6dEh9MjJ6+P0+c/Lk
         YX1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWfG2q98owMLkPzj63u1/NUYY4JBxQux9Z1vkEdHspmAWXHAYHI7GU3+2vxN77a8kX0yjGfVfjeNjkuL9UvGvGRZ9Ooug8U2pBlmmNc
X-Gm-Message-State: AOJu0YxhM31Kr9OEEDQ34mny98fKsTsHWhYPhnm7HKEbEShRmYDgzdd1
	MQRJ66lLATl3loGG/F4Ws2JJJJmpNiWWj/eRGAzAOQjG0BHMr2B3
X-Google-Smtp-Source: AGHT+IGTPepDZUE+0dXJ27OX66rP4xx/9iEYMJ3wlFjMS2tdMXgcxrgvDm7YCVeylSv9I7wc/EHD6g==
X-Received: by 2002:a25:6b11:0:b0:de5:670a:9c1f with SMTP id g17-20020a256b11000000b00de5670a9c1fmr238958ybc.19.1714497845471;
        Tue, 30 Apr 2024 10:24:05 -0700 (PDT)
Received: from localhost ([69.73.66.55])
        by smtp.gmail.com with ESMTPSA id o17-20020a258d91000000b00de55b84ab49sm3828943ybl.43.2024.04.30.10.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 10:24:04 -0700 (PDT)
Date: Tue, 30 Apr 2024 10:24:03 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: akpm@linux-foundation.org, linux@rasmusvillemoes.dk,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] lib/find_bit_benchmark: Add benchmark test for
 fns()
Message-ID: <ZjEpMy3hFXqfavva@yury-ThinkPad>
References: <20240430054912.124237-1-visitorckw@gmail.com>
 <20240430054912.124237-2-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430054912.124237-2-visitorckw@gmail.com>

On Tue, Apr 30, 2024 at 01:49:11PM +0800, Kuan-Wei Chiu wrote:
> Introduce a benchmark test for the fns(). It measures the total time
> taken by fns() to process 1,000,000 test data generated using
> get_random_long() for each n in the range [0, BITS_PER_LONG].

Can you also print an example of test output?
 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>  lib/find_bit_benchmark.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/lib/find_bit_benchmark.c b/lib/find_bit_benchmark.c
> index d3fb09e6eff1..8712eacf3bbd 100644
> --- a/lib/find_bit_benchmark.c
> +++ b/lib/find_bit_benchmark.c
> @@ -146,6 +146,28 @@ static int __init test_find_next_and_bit(const void *bitmap,
>  	return 0;
>  }
>  
> +static int __init test_fns(void)
> +{
> +	const unsigned long round = 1000000;
> +	s64 time[BITS_PER_LONG + 1];
> +	unsigned int i, n;
> +	volatile unsigned long x, y;
> +
> +	for (n = 0; n <= BITS_PER_LONG; n++) {

n == BITS_PER_LONG is an error. Testing error case together with
normal cases is even worse error because it fools readers.

> +		time[n] = ktime_get();
> +		for (i = 0; i < round; i++) {
> +			x = get_random_long();
> +			y = fns(x, n);
> +		}

Here you count fns() + get_random_long() time. For your microbench
purposes it would be better exclude a random number generation
overhead.

> +		time[n] = ktime_get() - time[n];
> +	}
> +
> +	for (n = 0; n <= BITS_PER_LONG; n++)
> +		pr_err("fns: n = %2u: %12lld ns\n", n, time[n]);

Nah, not like that. Each test in there prints one line in the
report. Let's keep it that way for test_fns() too. Unless we have
a strong evidence that fns() for a particular input is worth to be
tracked separately, let's just print a total gross?

> +
> +	return 0;
> +}

I'd suggest to modify it like:

        static unsigned long buf[1000000];

        static int __init test_fns(void)
        {
                get_random_bytes(buf, ARRAY_SIZE(buf));
                time = ktime_get();

                for (n = 0; n < BITS_PER_LONG; n++)
                        for (i = 0; i < 1000000; i++)
                                fns(buf[i], n);

                time = ktime_get() - time;
                pr_err(...);
        }

>  static int __init find_bit_test(void)
>  {
>  	unsigned long nbits = BITMAP_LEN / SPARSE;
> @@ -186,6 +208,9 @@ static int __init find_bit_test(void)
>  	test_find_first_and_bit(bitmap, bitmap2, BITMAP_LEN);
>  	test_find_next_and_bit(bitmap, bitmap2, BITMAP_LEN);
>  
> +	pr_err("\nStart testing for fns()\n");
> +	test_fns();

There are 2 sections in the test - one for regular, and another for
sparse data. Adding a new section for a just one function doesn't look
like a good idea.

Even more, the fns() is already tested here. Maybe test_bitops is a
better place for this test?

> +
>  	/*
>  	 * Everything is OK. Return error just to let user run benchmark
>  	 * again without annoying rmmod.
> -- 
> 2.34.1

