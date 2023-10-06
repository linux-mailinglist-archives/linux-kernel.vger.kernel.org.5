Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9E97BC241
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 00:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbjJFWfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 18:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbjJFWfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 18:35:53 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648209F
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 15:35:52 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-452863742f3so1238786137.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 15:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696631751; x=1697236551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=llH4t7J63AaEPzQkwWh0fjeekIthRYPqlI68ZdJOsjQ=;
        b=FldwVKeQPxekC/50VmwGYtbKu6FRrOPTH0h8+zWFcIyPS5PwFH2wXeiFPjjbdqAYZS
         bibi9G0bD2xbqOcQwYXAPX8khN1m0jY/sq16H1wIW8Fhyqodo/ERI8yKXZKU9LY1tLpJ
         D54ZBRpJHFCvfFMaAdGjda9qV4r2eMLdHUVmg+Kq97lGUxDniAXVtdeL/euWDddpJKx2
         a82ad/keEptpQonx5VxhVv/d+PXW82G1ThkWCVRWwtLpy8ZM8wYhCH2M3KfW5cGjSLOv
         HXr8ypw+LosXW3tj00FzE76Tx2aJo3Y7knUvzTsFCYXMwC5yTLmKEJ0d5c2sl8Q8Mz2K
         l+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696631751; x=1697236551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llH4t7J63AaEPzQkwWh0fjeekIthRYPqlI68ZdJOsjQ=;
        b=Zd3FzlWlyhMEW5IZcxxAv7fAfb379k1GDncQRjuCvoSFsuhUvWtv4K/medkSSVUa4S
         IeXdo0qIFWhekOPK6i8blALz+huPVP3ZMTE980P0c2T/0jVPB/b2x8n76mTtxFev6vhj
         KT8oXKti/EdWk0Ub7F/7UKjWter2P9P8rhW/QG8t/hq8YnhFckIkrSZrYCmV0HIT4pWq
         j6ABRkdCAiv40LSNYQ1Q9ymcLGWOdHpF+Twmk8AM1pqWtbAdKXmI9ev1BWU/9aUK9M9K
         znsCkJe1hPJSvvtqPot/LW0vwyW2Tj0rya80QiUgMvg7uxOXdb7EMr9Zo1WIf6pApono
         fHgw==
X-Gm-Message-State: AOJu0Yxx3hqubB/0vLrtbBbbBFPyjm+IRCSpsdA5Py5cmva+r8Ay+9HF
        n7v83ZWYKtViUdB8BPEig5QyBIGNK3HOFQ==
X-Google-Smtp-Source: AGHT+IF76BQbr6TEh2xS8UxB+3VzLAy48WDx4mw3mjz7pDVPFP0whbNxrGwZ7qiuBfoBksODoqduKA==
X-Received: by 2002:a67:de97:0:b0:44e:e7d7:6847 with SMTP id r23-20020a67de97000000b0044ee7d76847mr9518443vsk.7.1696631751349;
        Fri, 06 Oct 2023 15:35:51 -0700 (PDT)
Received: from localhost ([2607:fb90:be24:c307:bb4d:85d4:4340:a030])
        by smtp.gmail.com with ESMTPSA id n3-20020a67e043000000b004527ba543c6sm1084717vsl.1.2023.10.06.15.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 15:35:50 -0700 (PDT)
Date:   Fri, 6 Oct 2023 15:35:49 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com,
        aleksander.lobakin@intel.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com, syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 1/5] lib/bitmap: add bitmap_{read,write}()
Message-ID: <ZSCLuCu9yMyDdHni@yury-ThinkPad>
References: <20231006134529.2816540-1-glider@google.com>
 <20231006134529.2816540-2-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006134529.2816540-2-glider@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 03:45:25PM +0200, Alexander Potapenko wrote:
> From: Syed Nayyar Waris <syednwaris@gmail.com>
> 
> The two new functions allow reading/writing values of length up to
> BITS_PER_LONG bits at arbitrary position in the bitmap.
> 
> The code was taken from "bitops: Introduce the for_each_set_clump macro"
> by Syed Nayyar Waris with a number of changes and simplifications:
>  - instead of using roundup(), which adds an unnecessary dependency
>    on <linux/math.h>, we calculate space as BITS_PER_LONG-offset;
>  - indentation is reduced by not using else-clauses (suggested by
>    checkpatch for bitmap_get_value());
>  - bitmap_get_value()/bitmap_set_value() are renamed to bitmap_read()
>    and bitmap_write();
>  - some redundant computations are omitted.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
> Link: https://lore.kernel.org/lkml/fe12eedf3666f4af5138de0e70b67a07c7f40338.1592224129.git.syednwaris@gmail.com/
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Co-developed-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> 
> ---
> This patch was previously called "lib/bitmap: add
> bitmap_{set,get}_value()"
> (https://lore.kernel.org/lkml/20230720173956.3674987-2-glider@google.com/)
> 
> v6:
>  - As suggested by Yury Norov, do not require bitmap_read(..., 0) to
>    return 0.
> 
> v5:
>  - Address comments by Yury Norov:
>    - updated code comments and patch title/description
>    - replace GENMASK(nbits - 1, 0) with BITMAP_LAST_WORD_MASK(nbits)
>    - more compact bitmap_write() implementation
> 
> v4:
>  - Address comments by Andy Shevchenko and Yury Norov:
>    - prevent passing values >= 64 to GENMASK()
>    - fix commit authorship
>    - change comments
>    - check for unlikely(nbits==0)
>    - drop unnecessary const declarations
>    - fix kernel-doc comments
>    - rename bitmap_{get,set}_value() to bitmap_{read,write}()
> ---
>  include/linux/bitmap.h | 68 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index 03644237e1efb..e72c054d21d48 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -76,7 +76,11 @@ struct device;
>   *  bitmap_to_arr32(buf, src, nbits)            Copy nbits from buf to u32[] dst
>   *  bitmap_to_arr64(buf, src, nbits)            Copy nbits from buf to u64[] dst
>   *  bitmap_get_value8(map, start)               Get 8bit value from map at start
> + *  bitmap_read(map, start, nbits)              Read an nbits-sized value from
> + *                                              map at start
>   *  bitmap_set_value8(map, value, start)        Set 8bit value to map at start
> + *  bitmap_write(map, value, start, nbits)      Write an nbits-sized value to
> + *                                              map at start
>   *
>   * Note, bitmap_zero() and bitmap_fill() operate over the region of
>   * unsigned longs, that is, bits behind bitmap till the unsigned long
> @@ -583,6 +587,33 @@ static inline unsigned long bitmap_get_value8(const unsigned long *map,
>  	return (map[index] >> offset) & 0xFF;
>  }
>  
> +/**
> + * bitmap_read - read a value of n-bits from the memory region
> + * @map: address to the bitmap memory region
> + * @start: bit offset of the n-bit value
> + * @nbits: size of value in bits, nonzero, up to BITS_PER_LONG
> + *
> + * Returns: value of nbits located at the @start bit offset within the @map
> + * memory region.
> + */
> +static inline unsigned long bitmap_read(const unsigned long *map,
> +					unsigned long start,
> +					unsigned long nbits)
> +{
> +	size_t index = BIT_WORD(start);
> +	unsigned long offset = start % BITS_PER_LONG;
> +	unsigned long space = BITS_PER_LONG - offset;
> +	unsigned long value_low, value_high;
> +
> +	if (unlikely(!nbits))
> +		return 0;
> +	if (space >= nbits)
> +		return (map[index] >> offset) & GENMASK(nbits - 1, 0);
> +	value_low = map[index] & BITMAP_FIRST_WORD_MASK(start);
> +	value_high = map[index + 1] & BITMAP_LAST_WORD_MASK(start + nbits);
> +	return (value_low >> offset) | (value_high << space);
> +}
> +
>  /**
>   * bitmap_set_value8 - set an 8-bit value within a memory region
>   * @map: address to the bitmap memory region
> @@ -599,6 +630,43 @@ static inline void bitmap_set_value8(unsigned long *map, unsigned long value,
>  	map[index] |= value << offset;
>  }
>  
> +/**
> + * bitmap_write - write n-bit value within a memory region
> + * @map: address to the bitmap memory region
> + * @value: value to write, clamped to nbits
> + * @start: bit offset of the n-bit value
> + * @nbits: size of value in bits, nonzero, up to BITS_PER_LONG.
> + *
> + * bitmap_write() behaves similarly to @nbits calls of assign_bit(), i.e. bits
> + * beyond @nbits are ignored:
> + *
> + *   for (bit = 0; bit < nbits; bit++)
> + *           assign_bit(start + bit, bitmap, val & BIT(bit));

__assign_bit()

> + */

'behaves similarly' sounds like an understatement. I think, it behaves
much faster because it can assign up to 64 bits at once, not mentioning
the pressure on cache lines traffic.

How faster - that's a good question. I'd be really pleased if you add
a performance test for bitmap_write/read. Or I can do it myself later.
You can find examples in the same lib/test_bitmap.c.

> +static inline void bitmap_write(unsigned long *map,
> +				unsigned long value,
> +				unsigned long start, unsigned long nbits)
> +{
> +	size_t index = BIT_WORD(start);
> +	unsigned long offset = start % BITS_PER_LONG;
> +	unsigned long space = BITS_PER_LONG - offset;
> +	unsigned long mask;
> +
> +	if (unlikely(!nbits))
> +		return;

can you please add more empty lines to separate blocks visually?

> +	mask = BITMAP_LAST_WORD_MASK(nbits);
> +	value &= mask;
> +	if (space >= nbits) {
> +		map[index] &= ~(mask << offset);
> +		map[index] |= value << offset;
> +		return;
> +	}
> +	map[index] &= ~BITMAP_FIRST_WORD_MASK(start);
> +	map[index] |= value << offset;
> +	map[index + 1] &= ~BITMAP_LAST_WORD_MASK(start + nbits);
> +	map[index + 1] |= (value >> space);
> +}

I compiled the below fix on spark64 BE machine:

--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -608,7 +608,7 @@ static inline unsigned long bitmap_read(const unsigned long *map,
        if (unlikely(!nbits))
                return 0;
        if (space >= nbits)
-               return (map[index] >> offset) & GENMASK(nbits - 1, 0);
+               return (map[index] >> offset) & BITMAP_LAST_WORD_MASK(nbits);
        value_low = map[index] & BITMAP_FIRST_WORD_MASK(start);
        value_high = map[index + 1] & BITMAP_LAST_WORD_MASK(start + nbits);
        return (value_low >> offset) | (value_high << space);
@@ -661,9 +661,9 @@ static inline void bitmap_write(unsigned long *map,
                map[index] |= value << offset;
                return;
        }
-       map[index] &= ~BITMAP_FIRST_WORD_MASK(start);
+       map[index] &= BITMAP_LAST_WORD_MASK(start);
        map[index] |= value << offset;
-       map[index + 1] &= ~BITMAP_LAST_WORD_MASK(start + nbits);
+       map[index + 1] &= BITMAP_FIRST_WORD_MASK(start + nbits);
        map[index + 1] |= (value >> space);
 }

All the tests are passed just as before, and there's no any difference
reported by bloat-o-meter. Can you please use non-negation versions as
they are more straightforward?

> +
>  #endif /* __ASSEMBLY__ */
>  
>  #endif /* __LINUX_BITMAP_H */
> -- 
> 2.42.0.609.gbb76f46606-goog
