Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2E0756852
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjGQPvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbjGQPvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:51:06 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1521D10FE
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:51:02 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-666eb03457cso2867949b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689609061; x=1692201061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k/reFvmaQY5M0Bc+iZY3S5155xOKrp0RHCaUCisS2yg=;
        b=AOL0++AtLxwQJWCxTm97PYywkKf8pziGyH7gn3jjbXP95DrViHRRTBBacOGZJTnHN/
         a3fVdMpjubLaYqAKWJlw/0Zt020IDQOGSoThjzgq1WkozzRmr75yEqXUGu/2IGBpyxWb
         efk/HrrQ0VIbAWE6fBpI6E8sMMyOmTxCAokeYkYFr9vod9TYbOW2ums2E56+RzQVN0VL
         EMGClhd3AzG/P96bsAGJTvPi/2ASq+mTrIqRO/SeY9or2sIRBlgh1abg4B8FWXQmEDpS
         byHxUoa1q4yhj1gagXNxVwrcYmfmpiblR7Zcu1qYnmgYpmK9g7RJbwiTDV3r//26HRWj
         qiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689609061; x=1692201061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/reFvmaQY5M0Bc+iZY3S5155xOKrp0RHCaUCisS2yg=;
        b=PjBL0BfRFtmf6f5QDvtm4M9ByT0UgW0r9EEwIeFCs3qKjz2OG4eztcetB9a3Hyb4Zb
         Z8iE4tbfXJu+mS3L/ZM8KV9dAFLyEk6XqTTHk00fw1nDg8I+WCtN5Ff5qbsDirWcPZYb
         WFaJyWaX4j5DusHl5He/kfo1vQoSZY6XuhYNxI/chRlU5E5TV0GbiwKUDCwc14dDEVqf
         Una1ZLLE8LhNsVxmc5DA+G8tbhKRkOdH0USoKmItCfuyKDWL0HxN2XjHdMP0pi229+hu
         h9QvidHdtR5zFMrzLu07fhM4F6UBGualFYs7xjSB3rIiPoGmTGPt10s3xXXkR2r+yw3W
         YLbg==
X-Gm-Message-State: ABy/qLb9DNB+M0THlVZHC4Y3qN5mG7mbNNhxe2POned/L5Rltc5yGCtQ
        V2+mI0otmxQyyVbie8xIPBI=
X-Google-Smtp-Source: APBJJlFBVeJJ7Sy3CROGAJUIIIPrIkEjVtwLcAEqmsCrn6Y3gaLPo7wi7C6RGln7LA9LKkJuRqykWQ==
X-Received: by 2002:a05:6a20:841a:b0:12c:f124:5b72 with SMTP id c26-20020a056a20841a00b0012cf1245b72mr11590147pzd.43.1689609061028;
        Mon, 17 Jul 2023 08:51:01 -0700 (PDT)
Received: from localhost (72-24-220-98.cpe.sparklight.net. [72.24.220.98])
        by smtp.gmail.com with ESMTPSA id r27-20020a638f5b000000b005307501cfe4sm13145370pgn.44.2023.07.17.08.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 08:51:00 -0700 (PDT)
Date:   Mon, 17 Jul 2023 08:50:59 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 1/5] lib/bitmap: add bitmap_{set,get}_value()
Message-ID: <ZLVjYzuxlJAQVpIO@yury-ThinkPad>
References: <20230717113709.328671-1-glider@google.com>
 <20230717113709.328671-2-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717113709.328671-2-glider@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 01:37:04PM +0200, Alexander Potapenko wrote:
> The two new functions allow setting/getting values of length up to
> BITS_PER_LONG bits at arbitrary position in the bitmap.
> 
> The code was taken from "bitops: Introduce the for_each_set_clump macro"
> by Syed Nayyar Waris with a couple of minor changes:
>  - instead of using roundup(), which adds an unnecessary dependency
>    on <linux/math.h>, we calculate space as BITS_PER_LONG-offset;
>  - indentation is reduced by not using else-clauses (suggested by
>    checkpatch for bitmap_get_value())

Please preserve Syed's authorship ('From' field in git log).

> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
> Link: https://lore.kernel.org/lkml/fe12eedf3666f4af5138de0e70b67a07c7f40338.1592224129.git.syednwaris@gmail.com/
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
>  include/linux/bitmap.h | 57 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index 03644237e1efb..4559366084988 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -76,7 +76,11 @@ struct device;
>   *  bitmap_to_arr32(buf, src, nbits)            Copy nbits from buf to u32[] dst
>   *  bitmap_to_arr64(buf, src, nbits)            Copy nbits from buf to u64[] dst
>   *  bitmap_get_value8(map, start)               Get 8bit value from map at start
> + *  bitmap_get_value(map, start, nbits)         Get bit value of size 'nbits'
> + *                                              from map at start
>   *  bitmap_set_value8(map, value, start)        Set 8bit value to map at start
> + *  bitmap_set_value(map, value, start, nbits)  Set bit value of size 'nbits'
> + *                                              of map at start

The 'bit value of size' sounds more confusing than it should. The size
of bit is actually a bit... Can you rephrase? Moreover, 'set bits' has
a meaning of actually setting them, i.e. switching to '1'. Maybe:
"Copy 'nbits' to bitmap starting at 'start'"?

>   *
>   * Note, bitmap_zero() and bitmap_fill() operate over the region of
>   * unsigned longs, that is, bits behind bitmap till the unsigned long
> @@ -583,6 +587,31 @@ static inline unsigned long bitmap_get_value8(const unsigned long *map,
>  	return (map[index] >> offset) & 0xFF;
>  }
>  
> +/**
> + * bitmap_get_value - get a value of n-bits from the memory region
> + * @map: address to the bitmap memory region
> + * @start: bit offset of the n-bit value
> + * @nbits: size of value in bits


 * @nbits: size of value in bits, up to BITS_PER_LONG

> + *
> + * Returns value of nbits located at the @start bit offset within the @map
> + * memory region.
> + */
> +static inline unsigned long bitmap_get_value(const unsigned long *map,
> +					     unsigned long start,
> +					     unsigned long nbits)
> +{
> +	const size_t index = BIT_WORD(start);
> +	const unsigned long offset = start % BITS_PER_LONG;
> +	const unsigned long space = BITS_PER_LONG - offset;
> +	unsigned long value_low, value_high;
> +
> +	if (space >= nbits)
> +		return (map[index] >> offset) & GENMASK(nbits - 1, 0);
> +	value_low = map[index] & BITMAP_FIRST_WORD_MASK(start);
> +	value_high = map[index + 1] & BITMAP_LAST_WORD_MASK(start + nbits);
> +	return (value_low >> offset) | (value_high << space);
> +}

When nbits == 0, copy-like functions shouldn't touch any memory. See how
other bitmap and find_bit functions hold it.

Thanks,
Yury
