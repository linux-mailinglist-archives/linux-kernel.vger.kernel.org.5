Return-Path: <linux-kernel+bounces-134139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 698DE89AE24
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 04:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AE9D281F9A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 02:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AB61879;
	Sun,  7 Apr 2024 02:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2nOB9sr"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D482D1C0DC3;
	Sun,  7 Apr 2024 02:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712458492; cv=none; b=g8LUoNzxvT67xdjDW4nPXMUCZUcpyBDz7KN153AovPpL0wNaztmtEcxvvPcvgH1lqhwldWoMr8xAQT6YIQ6ib5HFApPkosRfQm+ygVqKdDK/GJIp3UFUYATyG4CBe4hgFqWjAzot5i9I7MEYPp4F84td/Bpjaps6dgH/ihbzhSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712458492; c=relaxed/simple;
	bh=SHoHgtVZiLBV3FSiDfLP9WUEZVTI4dIiWrQXJ1cpF0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csqjusu8A/6C5lVTSvaRvsTUkb7ZATnlV4vgFebgOqL2EtfsknbdYTL3At4NhOClTrwvEZ95cThXCrIC5nnZ4iman/C7J6tUujDCgLS5Pzpx2HFAVqQbrH38Ubpq98yRfX43mxqnoP2raFWMZXZrPVc19b5ajXyJf6kSKF3HcXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2nOB9sr; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2a2fbbd6cd6so715684a91.1;
        Sat, 06 Apr 2024 19:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712458490; x=1713063290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OhJLGdNSr+zO+0mPxtNKT8J6ZW7zxUgCFXHPKP0ZIc8=;
        b=M2nOB9srNfO9ox+vKCIrpFqjMAJtaEenHAra3WiyTTQRGUFqE2Iz2nb2LncwDWHyYE
         Mt64GZdsQsySJ9zMFqbReRwG5etItXu6rg/6AdasxWGR8R4YrAJ1Q7Q9Qt0eZNWrEp7P
         179qSNo/lNnc6tJWArYg/3YCfNTOcr12zjtKdBYtugEaTOvSuAhwkIjiio99iQUwky02
         oDWJcPpkNdXDfMPBioWl2VtJEiD3Ra+mDZZ8rYWuJqu1b3rzuVSfrshPqGamZyLAgyGx
         7ZligEEPq2DOLOpVCYeMPPjaU0kjci99gIUO+3/J/EPJwKg9jACb74xkOvK/DT/QJTR9
         R9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712458490; x=1713063290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OhJLGdNSr+zO+0mPxtNKT8J6ZW7zxUgCFXHPKP0ZIc8=;
        b=YYa6dI/Ro0QCqRwR5CYVxcb/M3WhLU+/mqtjkRf4ZYYsA0YkmAFkkLgWPNE1EX7rfa
         IWkhUKHItrXsVIGP+1pFPu03UGK8bf4vT2WlgdAPCPgOkvfivIUeHgV2fxM7iPD0T8BX
         uzOecPDVXk6E9I2zekgMdqjpVtoXqfWnEu/Zuj0EAERPFXUo2zNLzJdQs7kIu6gVqZMG
         qT30D1zbnYSvOl9xvOpwNsakZPn48pqPLl98jTu8uS80UHmuFipvkXn9IqcMdGKpgVeC
         MJ4Sej18XVewBh7rBm1tzzbYAE38K2DfkQFZgGgYlPabubKbpNeesRyQKEtaVwVGx/BX
         1mYw==
X-Forwarded-Encrypted: i=1; AJvYcCW41mFjA0Ev/fTfLtRFAQTdc1t/gKjHLHhyU7x42JLLVY3PP3kvr/AXmh6F+sJs1xgtKKLIY/yY3V694VuC7oKNTW9+JHWRSinZ4k/NxP8Ccqwks/x3TjW9X+gnx5nPmqG0Co7SlxtlipVUpvM=
X-Gm-Message-State: AOJu0YzImKCTWDFCDUQ3vVLLYlVNgQHj3Tf8poeM2/MxAOHrC5Re6lXj
	omKKtN08sGaC8EpruW3uTIuEcatWZAtHGH3Y4K+mRbto4EBZQ4X/6vkUI09VZHg=
X-Google-Smtp-Source: AGHT+IFTK4ODbG0yhDvFcztozWWaVEyutmkfol+fT8vtnM5o9dslpykRgb0KbIhmeohDMhrCls/uuQ==
X-Received: by 2002:a05:6a20:8402:b0:1a7:2d42:7a8b with SMTP id c2-20020a056a20840200b001a72d427a8bmr7258607pzd.0.1712458490050;
        Sat, 06 Apr 2024 19:54:50 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id bj17-20020a17090b089100b002a4ce78e3e8sm942829pjb.35.2024.04.06.19.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 19:54:49 -0700 (PDT)
Date: Sun, 7 Apr 2024 10:54:46 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: bfoster@redhat.com, jserv@ccns.ncku.edu.tw,
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bcachefs: Optimize eytzinger0_sort() with bottom-up
 heapsort
Message-ID: <ZhIK9gcY4ptAHUq6@visitorckw-System-Product-Name>
References: <20240407013349.672667-1-visitorckw@gmail.com>
 <3vvrirq3yljcuhjj5muvuk7quihllyfhzmygbb7rrchbgh7hzj@7psuth5ctxd5>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3vvrirq3yljcuhjj5muvuk7quihllyfhzmygbb7rrchbgh7hzj@7psuth5ctxd5>

On Sat, Apr 06, 2024 at 10:05:44PM -0400, Kent Overstreet wrote:
> On Sun, Apr 07, 2024 at 09:33:49AM +0800, Kuan-Wei Chiu wrote:
> > This optimization reduces the average number of comparisons required
> > from 2*n*log2(n) - 3*n + o(n) to n*log2(n) + 0.37*n + o(n). When n is
> > sufficiently large, it results in approximately 50% fewer comparisons.
> > 
> > Currently, eytzinger0_sort employs the textbook version of heapsort,
> > where during the heapify process, each level requires two comparisons
> > to determine the maximum among three elements. In contrast, the
> > bottom-up heapsort, during heapify, only compares two children at each
> > level until reaching a leaf node. Then, it backtracks from the leaf
> > node to find the correct position. Since heapify typically continues
> > until very close to the leaf node, the standard heapify requires about
> > 2*log2(n) comparisons, while the bottom-up variant only needs log2(n)
> > comparisons.
> > 
> > The experimental data presented below is based on an array generated
> > by get_random_u32().
> > 
> > |   N   | comparisons(old) | comparisons(new) | time(old) | time(new) |
> > |-------|------------------|------------------|-----------|-----------|
> > | 10000 |     235381       |     136615       |  25545 us |  20366 us |
> > | 20000 |     510694       |     293425       |  31336 us |  18312 us |
> > | 30000 |     800384       |     457412       |  35042 us |  27386 us |
> > | 40000 |    1101617       |     626831       |  48779 us |  38253 us |
> > | 50000 |    1409762       |     799637       |  62238 us |  46950 us |
> > | 60000 |    1721191       |     974521       |  75588 us |  58367 us |
> > | 70000 |    2038536       |    1152171       |  90823 us |  68778 us |
> > | 80000 |    2362958       |    1333472       | 104165 us |  78625 us |
> > | 90000 |    2690900       |    1516065       | 116111 us |  89573 us |
> > | 100000|    3019413       |    1699879       | 133638 us | 100998 us |
> > 
> > Refs:
> >   BOTTOM-UP-HEAPSORT, a new variant of HEAPSORT beating, on an average,
> >   QUICKSORT (if n is not very small)
> >   Ingo Wegener
> >   Theoretical Computer Science, 118(1); Pages 81-98, 13 September 1993
> >   https://doi.org/10.1016/0304-3975(93)90364-Y
> > 
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > ---
> > 
> > This is the same as the patch I submitted previously [1]. Since we
> > decided not to move eytzinger.h to generic library code, I resubmitted
> > this patch.
> > 
> > This patch has undergone unit testing and micro benchmarking using the
> > following code [2].
> > 
> > [1]: https://lore.kernel.org/lkml/20240121153649.2733274-2-visitorckw@gmail.com/
> > [2]:
> > static u64 cmp_count = 0;
> > 
> > static int mycmp(const void *a, const void *b)
> > {
> > 	u32 _a = *(u32 *)a;
> > 	u32 _b = *(u32 *)b;
> > 
> > 	cmp_count++;
> > 	if (_a < _b)
> > 		return -1;
> > 	else if (_a > _b)
> > 		return 1;
> > 	else
> > 		return 0;
> > }
> > 
> > static int test(void)
> > {
> > 	size_t N, i, L, R;
> > 	ktime_t start, end;
> > 	s64 delta;
> > 	u32 *arr;
> > 
> > 	for (N = 10000; N <= 100000; N += 10000) {
> > 		arr = kmalloc_array(N, sizeof(u32), GFP_KERNEL);
> > 		cmp_count = 0;
> > 
> > 		for (i = 0; i < N; i++)
> > 			arr[i] = get_random_u32();
> > 		
> > 		start = ktime_get();
> > 		eytzinger0_sort(arr, N, sizeof(u32), mycmp, NULL);
> > 		end = ktime_get();
> > 
> > 		delta = ktime_us_delta(end, start);
> > 		printk(KERN_INFO "time: %lld\n", delta);
> > 		printk(KERN_INFO "comparisons: %lld\n", cmp_count);
> > 
> > 		for (int i = 0; i < N; i++) {
> > 			L = 2 * i + 1;
> > 			R = 2 * i + 2;
> > 			if (L < N && arr[i] < arr[L])
> > 				goto err;
> > 			if (R < N && arr[i] > arr[R])
> > 				goto err;
> > 		}
> 
> Use eytzinger0_for_each() to just compare every element against the
> previous element, and check in the test code.
>

I rewrote the testing part as follows:

	u32 prev = 0;
	eytzinger0_for_each(i, N) {
		if (prev > arr[i])
			goto err;
		prev = arr[i];
	}

And the test still passed.

Thanks,
Kuan-Wei
> > 
> > 		kfree(arr);
> > 	}
> > 	return 0;
> > 
> > err:
> > 	kfree(arr);
> > 	return -1;
> > }
> > 
> >  fs/bcachefs/eytzinger.c | 50 ++++++++++++++++++++++++-----------------
> >  1 file changed, 30 insertions(+), 20 deletions(-)
> > 
> > diff --git a/fs/bcachefs/eytzinger.c b/fs/bcachefs/eytzinger.c
> > index 0f955c3c76a7..9a99a1410d12 100644
> > --- a/fs/bcachefs/eytzinger.c
> > +++ b/fs/bcachefs/eytzinger.c
> > @@ -171,7 +171,7 @@ void eytzinger0_sort_r(void *base, size_t n, size_t size,
> >  		       swap_r_func_t swap_func,
> >  		       const void *priv)
> >  {
> > -	int i, c, r;
> > +	int i, j, k;
> >  
> >  	/* called from 'sort' without swap function, let's pick the default */
> >  	if (swap_func == SWAP_WRAPPER && !((struct wrapper *)priv)->swap_func)
> > @@ -188,17 +188,22 @@ void eytzinger0_sort_r(void *base, size_t n, size_t size,
> >  
> >  	/* heapify */
> >  	for (i = n / 2 - 1; i >= 0; --i) {
> > -		for (r = i; r * 2 + 1 < n; r = c) {
> > -			c = r * 2 + 1;
> > -
> > -			if (c + 1 < n &&
> > -			    eytzinger0_do_cmp(base, n, size, cmp_func, priv, c, c + 1) < 0)
> > -				c++;
> > -
> > -			if (eytzinger0_do_cmp(base, n, size, cmp_func, priv, r, c) >= 0)
> > -				break;
> > -
> > -			eytzinger0_do_swap(base, n, size, swap_func, priv, r, c);
> > +		/* Find the sift-down path all the way to the leaves. */
> > +		for (j = i; k = j * 2 + 1, k + 1 < n;)
> > +			j = eytzinger0_do_cmp(base, n, size, cmp_func, priv, k, k + 1) > 0 ? k : k + 1;
> > +
> > +		/* Special case for the last leaf with no sibling. */
> > +		if (j * 2 + 2 == n)
> > +			j = j * 2 + 1;
> > +
> > +		/* Backtrack to the correct location. */
> > +		while (j != i && eytzinger0_do_cmp(base, n, size, cmp_func, priv, i, j) >= 0)
> > +			j = (j - 1) / 2;
> > +
> > +		/* Shift the element into its correct place. */
> > +		for (k = j; j != i;) {
> > +			j = (j - 1) / 2;
> > +			eytzinger0_do_swap(base, n, size, swap_func, priv, j, k);
> >  		}
> >  	}
> >  
> > @@ -206,17 +211,22 @@ void eytzinger0_sort_r(void *base, size_t n, size_t size,
> >  	for (i = n - 1; i > 0; --i) {
> >  		eytzinger0_do_swap(base, n, size, swap_func, priv, 0, i);
> >  
> > -		for (r = 0; r * 2 + 1 < i; r = c) {
> > -			c = r * 2 + 1;
> > +		/* Find the sift-down path all the way to the leaves. */
> > +		for (j = 0; k = j * 2 + 1, k + 1 < i;)
> > +			j = eytzinger0_do_cmp(base, n, size, cmp_func, priv, k, k + 1) > 0 ? k : k + 1;
> >  
> > -			if (c + 1 < i &&
> > -			    eytzinger0_do_cmp(base, n, size, cmp_func, priv, c, c + 1) < 0)
> > -				c++;
> > +		/* Special case for the last leaf with no sibling. */
> > +		if (j * 2 + 2 == i)
> > +			j = j * 2 + 1;
> >  
> > -			if (eytzinger0_do_cmp(base, n, size, cmp_func, priv, r, c) >= 0)
> > -				break;
> > +		/* Backtrack to the correct location. */
> > +		while (j && eytzinger0_do_cmp(base, n, size, cmp_func, priv, 0, j) >= 0)
> > +			j = (j - 1) / 2;
> >  
> > -			eytzinger0_do_swap(base, n, size, swap_func, priv, r, c);
> > +		/* Shift the element into its correct place. */
> > +		for (k = j; j;) {
> > +			j = (j - 1) / 2;
> > +			eytzinger0_do_swap(base, n, size, swap_func, priv, j, k);
> >  		}
> >  	}
> >  }
> > -- 
> > 2.34.1
> > 

