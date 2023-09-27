Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887997AF7A3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 03:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbjI0BUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 21:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbjI0BR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 21:17:58 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACE33C1D;
        Tue, 26 Sep 2023 17:25:16 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-4908d8f7263so3844803e0c.2;
        Tue, 26 Sep 2023 17:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695774316; x=1696379116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uk4VYbPx9jokzwBQ6bgqMLV+wRcgMMw+2UWxIJDIgis=;
        b=gpwoFPdwXcWjA2OEGq3T1sY7JwM9/RY2bOk1yMWNWZuUIGWGKYYJZmvwoW78L57km4
         +9/39DIe7Nq2UFuPMSwpcakiaSrwX306LH8uziBNsQe064Ax5D6zroQxyXcE/GNxjnae
         NYhonHEX5LCsf8LJBTbhAT592kGuKhg7vzZAntlhMoQq4vD5O50UPill1GS3WbOfmo+t
         8EXw/DKkvalQ+CelMGQXMpe03qax8mcHJl8CDTyVL3fA+2illNGWBF+zCNN8m9iwtvYi
         4kk8GmSKSYVYbG2xa1P9FVrhp/xy37hjEgxHEXr31Zp4kDkIjTI50xSZjpjQXr81djkW
         Mbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695774316; x=1696379116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uk4VYbPx9jokzwBQ6bgqMLV+wRcgMMw+2UWxIJDIgis=;
        b=UgmePZ6wfvOC0Dy/NY9EsFf2fVJwculPX+So0StPvk8tQrgsS1cJwoc17JMKwGwW9W
         XukipqrYdFdMOy7f+oC+aaCj9jLdvib3FTfuifp+XD8QHIXC7jB5E45bpk+8jDaqkQoW
         JdRSP2vQEZZbT2s01WedRddM0xCuezfpEVkSbP15jl6Zdm+V5kJI2L2FlK7EzxmplUIw
         UtZKisjPCeapRPm+Mv3mspqOT6w0NCgna21/Y9wFcE/H+ECEoCmplzb0JwEVhBXKDl1h
         XH7dyEs/e8qwD4ml4XwC1dX1cEI6gtHzJ35hWa6OFx9pJ1l3k31ILkidyAxOBeukQCox
         EVhw==
X-Gm-Message-State: AOJu0Yz7SvvjdqEl9njd9dpjAGd8p6fGemrQxwEq/vPoXWXBilDUW8Aa
        mb/2xbJR6I0m/a3ZAR3Z20U=
X-Google-Smtp-Source: AGHT+IHCOwV68ennnAuDVUGDcfDOSWvRLMXwly5VBOf38pUVwDh8Z3MZ1z6r0bXvKaLaosgT19lWog==
X-Received: by 2002:a1f:c981:0:b0:495:db2f:f4e7 with SMTP id z123-20020a1fc981000000b00495db2ff4e7mr634719vkf.1.1695774315450;
        Tue, 26 Sep 2023 17:25:15 -0700 (PDT)
Received: from localhost ([2607:fb90:be31:4195:f17f:b5d0:e0df:d9ab])
        by smtp.gmail.com with ESMTPSA id y15-20020ac5c80f000000b0048fa7f8dc89sm2180781vkl.31.2023.09.26.17.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 17:25:14 -0700 (PDT)
Date:   Tue, 26 Sep 2023 17:25:13 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: [PATCH v1 2/5] lib/bitmap: Introduce bitmap_scatter() and
 bitmap_gather() helpers
Message-ID: <ZRN2adZZaGeqWNlY@yury-ThinkPad>
References: <20230926052007.3917389-1-andriy.shevchenko@linux.intel.com>
 <20230926052007.3917389-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926052007.3917389-3-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 08:20:04AM +0300, Andy Shevchenko wrote:
> These helpers are the optimized versions of the bitmap_remap()
> where one of the bitmaps (source or destination) is of sequential bits.

If so, can you add a test that makes sure that new API is consistent
with the old bitmap_remap? And also provide numbers how well are they
optimized, comparing to bitmap_remap.
 
> See more in the kernel documentation of the helpers.

I grepped the whole kernel, not only Documentation directory, and found
nothing...

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/bitmap.h |  9 ++++++
>  lib/bitmap.c           | 70 ++++++++++++++++++++++++++++++++++++++++++
>  lib/test_bitmap.c      | 23 ++++++++++++++
>  3 files changed, 102 insertions(+)
> 
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index 1516ff979315..87013b9a7dd8 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -60,6 +60,8 @@ struct device;
>   *  bitmap_shift_left(dst, src, n, nbits)       *dst = *src << n
>   *  bitmap_cut(dst, src, first, n, nbits)       Cut n bits from first, copy rest
>   *  bitmap_replace(dst, old, new, mask, nbits)  *dst = (*old & ~(*mask)) | (*new & *mask)
> + *  bitmap_scatter(dst, src, mask, nbits)	*dst = map(dense, sparse)(src)
> + *  bitmap_gather(dst, src, mask, nbits)	*dst = map(sparse, dense)(src)
>   *  bitmap_remap(dst, src, old, new, nbits)     *dst = map(old, new)(src)
>   *  bitmap_bitremap(oldbit, old, new, nbits)    newbit = map(old, new)(oldbit)
>   *  bitmap_onto(dst, orig, relmap, nbits)       *dst = orig relative to relmap
> @@ -208,6 +210,12 @@ int bitmap_parselist(const char *buf, unsigned long *maskp,
>  			int nmaskbits);
>  int bitmap_parselist_user(const char __user *ubuf, unsigned int ulen,
>  			unsigned long *dst, int nbits);
> +
> +unsigned int bitmap_scatter(unsigned long *dst, const unsigned long *src,
> +		const unsigned long *mask, unsigned int nbits);
> +unsigned int bitmap_gather(unsigned long *dst, const unsigned long *src,
> +		const unsigned long *mask, unsigned int nbits);
> +
>  void bitmap_remap(unsigned long *dst, const unsigned long *src,
>  		const unsigned long *old, const unsigned long *new, unsigned int nbits);
>  int bitmap_bitremap(int oldbit,
> @@ -216,6 +224,7 @@ void bitmap_onto(unsigned long *dst, const unsigned long *orig,
>  		const unsigned long *relmap, unsigned int bits);
>  void bitmap_fold(unsigned long *dst, const unsigned long *orig,
>  		unsigned int sz, unsigned int nbits);
> +
>  int bitmap_find_free_region(unsigned long *bitmap, unsigned int bits, int order);
>  void bitmap_release_region(unsigned long *bitmap, unsigned int pos, int order);
>  int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order);
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index 935e0f96e785..31cfc7846aae 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -942,6 +942,76 @@ int bitmap_parse(const char *start, unsigned int buflen,
>  }
>  EXPORT_SYMBOL(bitmap_parse);
>  
> +/**
> + * bitmap_scatter - Scatter a bitmap according to the given mask
> + * @dst: scattered bitmap
> + * @src: gathered bitmap
> + * @mask: bits to assign to in the scattered bitmap
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
> + * Returns: the weight of the @mask.

Returning a weight of the mask is somewhat non-trivial... To me it
would be logical to return a weight of destination, for example...

But I see that in the following patch you're using the returned value.
Maybe add a few words to advocate that?

> + */
> +unsigned int bitmap_scatter(unsigned long *dst, const unsigned long *src,
> +			    const unsigned long *mask, unsigned int nbits)
> +{
> +	unsigned int bit;
> +	int n = 0;

Is n signed for purpose? I think it should be consistent with
return value.

> +
> +	bitmap_zero(dst, nbits);
> +
> +	for_each_set_bit(bit, mask, nbits)
> +		__assign_bit(bit, dst, test_bit(n++, src));
> +
> +	return n;
> +}
> +EXPORT_SYMBOL(bitmap_scatter);
> +
> +/**
> + * bitmap_gather - Gather a bitmap according to given mask
> + * @dst: gathered bitmap
> + * @src: scattered bitmap
> + * @mask: bits to extract from in the scattered bitmap
> + * @nbits: number of bits in each of these bitmaps
> + *
> + * Gathers bitmap with sparse bits according to the given @mask.
> + *
> + * Example:
> + * If @src bitmap = 0x0302, with @mask = 0x1313, @dst will be 0x001a.

Not sure about others, but to me hex representation is quite useless,
moreover it's followed by binary one.

> + * Or in binary form
> + * @src			@mask			@dst
> + * 0000001100000010	0001001100010011	0000000000011010
> + *
> + * (Bits 0, 1, 4, 8, 9, 12 are copied to the bits 0, 1, 2, 3, 4, 5)
> + *
> + * Returns: the weight of the @mask.
> + */

It looks like those are designed complement to each other. Is that
true? If so, can you make your example showing that
        scatter -> gather -> scatter
would restore the original bitmap?

If I'm wrong, can you please underline that they are not complement,
and why?

> +unsigned int bitmap_gather(unsigned long *dst, const unsigned long *src,
> +			   const unsigned long *mask, unsigned int nbits)
> +{
> +	unsigned int bit;
> +	int n = 0;
> +
> +	bitmap_zero(dst, nbits);
> +
> +	for_each_set_bit(bit, mask, nbits)
> +		__assign_bit(n++, dst, test_bit(bit, src));
> +
> +	return n;
> +}
> +EXPORT_SYMBOL(bitmap_gather);

I feel like they should reside in header, because they are quite a small
functions indeed, and they would benefit from compile-time optimizations
without bloating the kernel.

Moreover, you are using them in patch #3 on 64-bit bitmaps, which
would benefit from small_const_nbits() optimization.

> +
>  /**
>   * bitmap_pos_to_ord - find ordinal of set bit at given position in bitmap
>   *	@buf: pointer to a bitmap
> diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
> index 1f2dc7fef17f..f43a07679998 100644
> --- a/lib/test_bitmap.c
> +++ b/lib/test_bitmap.c
> @@ -50,6 +50,9 @@ static const unsigned long exp2[] __initconst = {
>  static const unsigned long exp2_to_exp3_mask[] __initconst = {
>  	BITMAP_FROM_U64(0x008000020020212eULL),
>  };
> +static const unsigned long exp2_to_exp3_maskg[] __initconst = {
> +	BITMAP_FROM_U64(0x00000000000001ffULL),
> +};
>  /* exp3_0_1 = (exp2[0] & ~exp2_to_exp3_mask) | (exp2[1] & exp2_to_exp3_mask) */
>  static const unsigned long exp3_0_1[] __initconst = {
>  	BITMAP_FROM_U64(0x33b3333311313137ULL),
> @@ -357,6 +360,25 @@ static void __init test_replace(void)
>  	expect_eq_bitmap(bmap, exp3_1_0, nbits);
>  }
>  
> +static void __init test_bitmap_sg(void)
> +{
> +	unsigned int nbits = 64;
> +	DECLARE_BITMAP(bmap, 1024);

Can you make it 1000? That way we'll test non-aligned case.

> +	unsigned int w;
> +
> +	bitmap_zero(bmap, 1024);
> +	w = bitmap_gather(bmap, exp2_to_exp3_mask, exp2_to_exp3_mask, nbits);
> +	expect_eq_uint(bitmap_weight(exp2_to_exp3_mask, nbits), w);
> +	expect_eq_uint(bitmap_weight(bmap, 1024), w);
> +	expect_eq_bitmap(bmap, exp2_to_exp3_maskg, nbits);
> +
> +	bitmap_zero(bmap, 1024);
> +	w = bitmap_scatter(bmap, exp2_to_exp3_maskg, exp2_to_exp3_mask, nbits);
> +	expect_eq_uint(bitmap_weight(exp2_to_exp3_maskg, nbits), w);
> +	expect_eq_uint(bitmap_weight(bmap, 1024), w);
> +	expect_eq_bitmap(bmap, exp2_to_exp3_mask, nbits);

Would be interesting to compare bitmap scatter/gather performance
against bitmap_remap.

> +}
> +
>  #define PARSE_TIME	0x1
>  #define NO_LEN		0x2
>  
> @@ -1228,6 +1250,7 @@ static void __init selftest(void)
>  	test_fill_set();
>  	test_copy();
>  	test_replace();
> +	test_bitmap_sg();
>  	test_bitmap_arr32();
>  	test_bitmap_arr64();
>  	test_bitmap_parse();
> -- 
> 2.40.0.1.gaa8946217a0b
