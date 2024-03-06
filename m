Return-Path: <linux-kernel+bounces-93950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D26873761
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB9872824BD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5110A130AF2;
	Wed,  6 Mar 2024 13:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPGSqVyS"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6AE12FF88;
	Wed,  6 Mar 2024 13:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709730683; cv=none; b=SgA9uEkc83OztSZtPbgNRe7e+aWM0MNIzehxeGzGubPJg1V8lubre1j4laMsn+dqHEgAy+IriJF4iPa3nTFT5l7F32m8gxl0Td/vn3DmHVgxrYWGPmA5Si9EspdszswVZN/Z0O9/aarp9tzeDT0+1g7junIQj3AKKOShp2fHZWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709730683; c=relaxed/simple;
	bh=vaH08CnZq4YmUy3RdzliipfKyqHRsHEszYhKOCE6el8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeK+a6pmLDgtvbMSTWRB2s+DJEJZ3qcQexE+5GNPBbP3hnXK7QoET0CXiArGfDlZrgAlhdGGvt6JKPz8rdT/Lwx7+BAd4YdfODsRISQ9+44y6Bwr+ywCOTfh3CWhguGqOuzQmAuH0PUdaRTCA27xRYm6aDrdvK+1PZ9xI7N9jrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPGSqVyS; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6098a20ab22so46407307b3.2;
        Wed, 06 Mar 2024 05:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709730680; x=1710335480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=roOaXgRVJ2UD+hzpU1VpjqNtNVV/0xa+8QzgjG/otYQ=;
        b=YPGSqVyS42F82FYuO8/36P/ZEPuxqQ6gP826oQbpXncFeBg2WG8+KZ98rJX68C5sB0
         gBHbrqG3fEXwqPcqWO4oDjL6+fxsa4DbVPwKC50gCVrfNKQlc2+YkE2Nq8rRwEVIt5J5
         Zf/VYSSwoDNtCTVii7YCi7qmkCdD2QtpA26neWSzDb/IEuseChSjLEqc3HIFV2WLa40K
         CS/eo//3k4hG00sNRGU5ynyVTPRN5oDnHoA9dkSmu7/+k9KwEEQA4QR7PyDZnDeG72+j
         2I7gw7fKLrin9k0PLZ22OElXzCnE6wADEdWQvXRWKtbv12WY5/YqKvlYNhwLmTt4G/Iw
         chNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709730680; x=1710335480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=roOaXgRVJ2UD+hzpU1VpjqNtNVV/0xa+8QzgjG/otYQ=;
        b=cBWmLKvbohLFvzkGAOsCeK60RMw8e0YfmGNefQ1spmb08iTe13rVd4UbDlBHW74g8i
         mR6Qwbc/yRs3efhG/geHyJJcx0u7jNWQfMlowWfiVKvg4CNd9Dac3aut0vIema/bDLW3
         1+XJoHZXLTCgNmJqddpq8eKkJT0LGXi00zFQeDCtPbaBH/BkwJ4Yz3fuvZN0sRE4f+0n
         yOxwZ/4kJkfAllVWlARrdyLhyU8bYdYM+pXl8CN7nHLYeqwueKPzEaZAQKZpQdNfAFvl
         NHrESTdGwsBvAxumwrbg78B37ghrogj7cEgj2/d3SGwXgwYITyeDb2euMFNrt5Yjcr3q
         1e/w==
X-Forwarded-Encrypted: i=1; AJvYcCVXjQjHogMp0djUDNeniki/RwhLih849ry+z5b+OoowjdpMvv9qcic+LQAEVVFWXONqWBrjHdmzjyzprpr3b/LjVR4WMgk8ElglyZoS7uKzskY3STpjJuUjYOcZMxlg115MU4Qx
X-Gm-Message-State: AOJu0YwhDBUoMeDt6IYnLWg0bX16uZjt9tTg9f2VX9ufppXUlO5o1qsA
	UbJYycqcUW/nQpEAcu0WwfIow0rzjqwaHLgnqRkn75Kb7+xexsLu
X-Google-Smtp-Source: AGHT+IEOJMfd2VqHMJoD/p66gxEjQrJ2mrzfAgDuets3O0GNPreXnXlTKkPtVEu04LRe8elaDBPJdA==
X-Received: by 2002:a0d:c245:0:b0:608:b7d6:753f with SMTP id e66-20020a0dc245000000b00608b7d6753fmr15139269ywd.33.1709730680473;
        Wed, 06 Mar 2024 05:11:20 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:a708:4ac5:2d2f:c5bb])
        by smtp.gmail.com with ESMTPSA id j9-20020a81c409000000b00608aeba302dsm3670884ywi.14.2024.03.06.05.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 05:11:20 -0800 (PST)
Date: Wed, 6 Mar 2024 05:11:19 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Andrew Lunn <andrew@lunn.ch>,
	Mark Brown <broonie@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 3/5] lib/bitmap: Introduce bitmap_scatter() and
 bitmap_gather() helpers
Message-ID: <Zehrd/VgW5AnfJEu@yury-ThinkPad>
References: <20240306080726.167338-1-herve.codina@bootlin.com>
 <20240306080726.167338-4-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306080726.167338-4-herve.codina@bootlin.com>

On Wed, Mar 06, 2024 at 09:07:19AM +0100, Herve Codina wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> These helpers scatters or gathers a bitmap with the help of the mask
> position bits parameter.
> 
> bitmap_scatter() does the following:
>   src:  0000000001011010
>                   ||||||
>            +------+|||||
>            |  +----+||||
>            |  |+----+|||
>            |  ||   +-+||
>            |  ||   |  ||
>   mask: ...v..vv...v..vv
>         ...0..11...0..10
>   dst:  0000001100000010
> 
> and bitmap_gather() performs this one:
>    mask: ...v..vv...v..vv
>    src:  0000001100000010
>             ^  ^^   ^   0
>             |  ||   |  10
>             |  ||   > 010
>             |  |+--> 1010
>             |  +--> 11010
>             +----> 011010
>    dst:  0000000000011010
> 
> bitmap_gather() can the seen as the reverse bitmap_scatter() operation.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Link: https://lore.kernel.org/lkml/20230926052007.3917389-3-andriy.shevchenko@linux.intel.com/
> Co-developed-by: Herve Codina <herve.codina@bootlin.com>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Signed-off-by: Yury Norov <yury.norov@gmail.com>

Would you like to move this with the rest of the series? If so please
pull my Sof-by, otherwise I can move it with bitmap-for-next.

> ---
>  include/linux/bitmap.h | 101 +++++++++++++++++++++++++++++++++++++++++
>  lib/test_bitmap.c      |  42 +++++++++++++++++
>  2 files changed, 143 insertions(+)
> 
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index 99451431e4d6..049ba20911c5 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -62,6 +62,8 @@ struct device;
>   *  bitmap_shift_left(dst, src, n, nbits)       *dst = *src << n
>   *  bitmap_cut(dst, src, first, n, nbits)       Cut n bits from first, copy rest
>   *  bitmap_replace(dst, old, new, mask, nbits)  *dst = (*old & ~(*mask)) | (*new & *mask)
> + *  bitmap_scatter(dst, src, mask, nbits)	*dst = map(dense, sparse)(src)
> + *  bitmap_gather(dst, src, mask, nbits)	*dst = map(sparse, dense)(src)
>   *  bitmap_remap(dst, src, old, new, nbits)     *dst = map(old, new)(src)
>   *  bitmap_bitremap(oldbit, old, new, nbits)    newbit = map(old, new)(oldbit)
>   *  bitmap_onto(dst, orig, relmap, nbits)       *dst = orig relative to relmap
> @@ -487,6 +489,105 @@ static inline void bitmap_replace(unsigned long *dst,
>  		__bitmap_replace(dst, old, new, mask, nbits);
>  }
>  
> +/**
> + * bitmap_scatter - Scatter a bitmap according to the given mask
> + * @dst: scattered bitmap
> + * @src: gathered bitmap
> + * @mask: mask representing bits to assign to in the scattered bitmap
> + * @nbits: number of bits in each of these bitmaps
> + *
> + * Scatters bitmap with sequential bits according to the given @mask.
> + *
> + * Example:
> + * If @src bitmap = 0x005a, with @mask = 0x1313, @dst will be 0x0302.
> + *
> + * Or in binary form
> + * @src			@mask			@dst
> + * 0000000001011010	0001001100010011	0000001100000010
> + *
> + * (Bits 0, 1, 2, 3, 4, 5 are copied to the bits 0, 1, 4, 8, 9, 12)
> + *
> + * A more 'visual' description of the operation:
> + * src:  0000000001011010
> + *                 ||||||
> + *          +------+|||||
> + *          |  +----+||||
> + *          |  |+----+|||
> + *          |  ||   +-+||
> + *          |  ||   |  ||
> + * mask: ...v..vv...v..vv
> + *       ...0..11...0..10
> + * dst:  0000001100000010
> + *
> + * A relationship exists between bitmap_scatter() and bitmap_gather().
> + * bitmap_gather() can be seen as the 'reverse' bitmap_scatter() operation.
> + * See bitmap_scatter() for details related to this relationship.
> + */
> +static inline void bitmap_scatter(unsigned long *dst, const unsigned long *src,
> +				  const unsigned long *mask, unsigned int nbits)
> +{
> +	unsigned int n = 0;
> +	unsigned int bit;
> +
> +	bitmap_zero(dst, nbits);
> +
> +	for_each_set_bit(bit, mask, nbits)
> +		__assign_bit(bit, dst, test_bit(n++, src));
> +}
> +
> +/**
> + * bitmap_gather - Gather a bitmap according to given mask
> + * @dst: gathered bitmap
> + * @src: scattered bitmap
> + * @mask: mask representing bits to extract from in the scattered bitmap
> + * @nbits: number of bits in each of these bitmaps
> + *
> + * Gathers bitmap with sparse bits according to the given @mask.
> + *
> + * Example:
> + * If @src bitmap = 0x0302, with @mask = 0x1313, @dst will be 0x001a.
> + *
> + * Or in binary form
> + * @src			@mask			@dst
> + * 0000001100000010	0001001100010011	0000000000011010
> + *
> + * (Bits 0, 1, 4, 8, 9, 12 are copied to the bits 0, 1, 2, 3, 4, 5)
> + *
> + * A more 'visual' description of the operation:
> + * mask: ...v..vv...v..vv
> + * src:  0000001100000010
> + *          ^  ^^   ^   0
> + *          |  ||   |  10
> + *          |  ||   > 010
> + *          |  |+--> 1010
> + *          |  +--> 11010
> + *          +----> 011010
> + * dst:  0000000000011010
> + *
> + * A relationship exists between bitmap_gather() and bitmap_scatter(). See
> + * bitmap_scatter() for the bitmap scatter detailed operations.
> + * Suppose scattered computed using bitmap_scatter(scattered, src, mask, n).
> + * The operation bitmap_gather(result, scattered, mask, n) leads to a result
> + * equal or equivalent to src.
> + *
> + * The result can be 'equivalent' because bitmap_scatter() and bitmap_gather()
> + * are not bijective.
> + * The result and src values are equivalent in that sense that a call to
> + * bitmap_scatter(res, src, mask, n) and a call to
> + * bitmap_scatter(res, result, mask, n) will lead to the same res value.
> + */
> +static inline void bitmap_gather(unsigned long *dst, const unsigned long *src,
> +				 const unsigned long *mask, unsigned int nbits)
> +{
> +	unsigned int n = 0;
> +	unsigned int bit;
> +
> +	bitmap_zero(dst, nbits);
> +
> +	for_each_set_bit(bit, mask, nbits)
> +		__assign_bit(n++, dst, test_bit(bit, src));
> +}
> +
>  static inline void bitmap_next_set_region(unsigned long *bitmap,
>  					  unsigned int *rs, unsigned int *re,
>  					  unsigned int end)
> diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
> index 65f22c2578b0..6b2b33579f56 100644
> --- a/lib/test_bitmap.c
> +++ b/lib/test_bitmap.c
> @@ -380,6 +380,47 @@ static void __init test_replace(void)
>  	expect_eq_bitmap(bmap, exp3_1_0, nbits);
>  }
>  
> +static const unsigned long sg_mask[] __initconst = {
> +	BITMAP_FROM_U64(0x000000000000035aULL),
> +};
> +
> +static const unsigned long sg_src[] __initconst = {
> +	BITMAP_FROM_U64(0x0000000000000667ULL),
> +};
> +
> +static const unsigned long sg_gather_exp[] __initconst = {
> +	BITMAP_FROM_U64(0x0000000000000029ULL),
> +};
> +
> +static const unsigned long sg_scatter_exp[] __initconst = {
> +	BITMAP_FROM_U64(0x000000000000021aULL),
> +};
> +
> +static void __init test_bitmap_sg(void)
> +{
> +	unsigned int nbits = 64;
> +	DECLARE_BITMAP(bmap_gather, 100);
> +	DECLARE_BITMAP(bmap_scatter, 100);
> +	DECLARE_BITMAP(bmap_tmp, 100);
> +	DECLARE_BITMAP(bmap_res, 100);
> +
> +	/* Simple gather call */
> +	bitmap_zero(bmap_gather, 100);
> +	bitmap_gather(bmap_gather, sg_src, sg_mask, nbits);
> +	expect_eq_bitmap(sg_gather_exp, bmap_gather, nbits);
> +
> +	/* Simple scatter call */
> +	bitmap_zero(bmap_scatter, 100);
> +	bitmap_scatter(bmap_scatter, sg_src, sg_mask, nbits);
> +	expect_eq_bitmap(sg_scatter_exp, bmap_scatter, nbits);
> +
> +	/* Scatter/gather relationship */
> +	bitmap_zero(bmap_tmp, 100);
> +	bitmap_gather(bmap_tmp, bmap_scatter, sg_mask, nbits);
> +	bitmap_scatter(bmap_res, bmap_tmp, sg_mask, nbits);
> +	expect_eq_bitmap(bmap_scatter, bmap_res, nbits);
> +}
> +
>  #define PARSE_TIME	0x1
>  #define NO_LEN		0x2
>  
> @@ -1252,6 +1293,7 @@ static void __init selftest(void)
>  	test_copy();
>  	test_bitmap_region();
>  	test_replace();
> +	test_bitmap_sg();
>  	test_bitmap_arr32();
>  	test_bitmap_arr64();
>  	test_bitmap_parse();
> -- 
> 2.43.0

