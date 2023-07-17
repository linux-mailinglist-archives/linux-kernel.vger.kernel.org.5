Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2DB7568BF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjGQQL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjGQQLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:11:53 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16AC1B1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:11:52 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b89bc52cd1so25085015ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689610312; x=1692202312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GraKjblPmgkHpWhLfPrS4evOCsX6uBT2omZ9Uc1NvOA=;
        b=Wa+e+ovMWUEfgZhpAhQ6cP/N4CQprys+b0GgvzjpdjRTT3ZfcnghEKIodipqH4FKjC
         JfPAtby6MvPDcLPlHtvTNbkp9TyzOklR/0l9dhZALNtWlJvmqw2C3TSxDgO/eEQ4/FKe
         nA70ZycKmvG6t8dtwQ5GaMssF2/4hY+7xN7a0qKm0TplQu/XCH8JdDx+x8ZJ3MeBn9T1
         aBycXed48+AelPloUNfTNcQQw3GnR1vfneygHTfyy+ZVGuSP+hOCOX313SJFAH2PVZGz
         BxU0Yuphq1RcpJ3EWVFRf02U1AGHKH+6RB3nsvg/7ZlkqJjdchenE9Q3V9QoZ00VBSt1
         Khzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689610312; x=1692202312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GraKjblPmgkHpWhLfPrS4evOCsX6uBT2omZ9Uc1NvOA=;
        b=SQo5Emg+CbZEuHtgtj/cY5jtAtCzZjl/6017UPOirpCGgai5YTgUIotszyLyPDB/9f
         bBzLzumq8aEDrBrOAYPF31geJALyhzKVYwdG/LK/uAU8PDoqXK0/EgGrdJq3DFkg2QB2
         1K0IWExa2QAaZ3JIuMC0TrT7iIxnLigD9/Gj83X7z0tSb/vinCq2a074o8of6N8tpGII
         VYuaic03kw8bdxKsqBaDAokRL97EIYuUV6y+ZbeIN3DZVBIy1xzCxvdfRHDJfoNLFkd2
         +As33bH78nwM/Y++bSWMzSOGKWwrb3nuamJd92H1l8RtOF5qt/76NPpyf4aZiPYIJD6q
         9jYw==
X-Gm-Message-State: ABy/qLb3ht2P9tXyLI8UPFYCHN86ubZucTX1SA764cWfe8QWye6Ze683
        YniSckKNulZD4KuQbtQD8P4=
X-Google-Smtp-Source: APBJJlHtGugtj2wOl3jCTD9375jtpiEKqzSxQI+CP/Y/iQZoimSjQobzhyvLwFAQaOfx2ZwGVC0dSg==
X-Received: by 2002:a17:902:e995:b0:1b6:af1a:7dd3 with SMTP id f21-20020a170902e99500b001b6af1a7dd3mr11600629plb.23.1689610312229;
        Mon, 17 Jul 2023 09:11:52 -0700 (PDT)
Received: from localhost (72-24-220-98.cpe.sparklight.net. [72.24.220.98])
        by smtp.gmail.com with ESMTPSA id i10-20020a170902eb4a00b001b895a17429sm54534pli.280.2023.07.17.09.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 09:11:51 -0700 (PDT)
Date:   Mon, 17 Jul 2023 09:11:50 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
Subject: Re: [PATCH v3 2/5] lib/test_bitmap: add tests for
 bitmap_{set,get}_value()
Message-ID: <ZLVoRkmy5IZYbjUV@yury-ThinkPad>
References: <20230717113709.328671-1-glider@google.com>
 <20230717113709.328671-3-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717113709.328671-3-glider@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 01:37:05PM +0200, Alexander Potapenko wrote:
> Add basic tests ensuring that values can be added at arbitrary positions
> of the bitmap, including those spanning into the adjacent unsigned
> longs.
> 
> Signed-off-by: Alexander Potapenko <glider@google.com>
 
Thanks for the test!

> ---
> This patch was previously called
> "lib/test_bitmap: add tests for bitmap_{set,get}_value_unaligned"
> 
> v3:
>  - switch to using bitmap_{set,get}_value()
>  - change the expected bit pattern in test_set_get_value(),
>    as the test was incorrectly assuming 0 is the LSB.
> ---
>  lib/test_bitmap.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
> index 187f5b2db4cf1..c2ab54040c249 100644
> --- a/lib/test_bitmap.c
> +++ b/lib/test_bitmap.c
> @@ -71,6 +71,17 @@ __check_eq_uint(const char *srcfile, unsigned int line,
>  	return true;
>  }
>  
> +static bool __init
> +__check_eq_ulong(const char *srcfile, unsigned int line,
> +		 const unsigned long exp_ulong, unsigned long x)
> +{
> +	if (exp_ulong != x) {
> +		pr_err("[%s:%u] expected %lu, got %lu\n",
> +			srcfile, line, exp_ulong, x);
> +		return false;
> +	}
> +	return true;
> +}
>  
>  static bool __init
>  __check_eq_bitmap(const char *srcfile, unsigned int line,
> @@ -186,6 +197,7 @@ __check_eq_str(const char *srcfile, unsigned int line,
>  	})
>  
>  #define expect_eq_uint(...)		__expect_eq(uint, ##__VA_ARGS__)
> +#define expect_eq_ulong(...)		__expect_eq(ulong, ##__VA_ARGS__)
>  #define expect_eq_bitmap(...)		__expect_eq(bitmap, ##__VA_ARGS__)
>  #define expect_eq_pbl(...)		__expect_eq(pbl, ##__VA_ARGS__)
>  #define expect_eq_u32_array(...)	__expect_eq(u32_array, ##__VA_ARGS__)
> @@ -1222,6 +1234,25 @@ static void __init test_bitmap_const_eval(void)
>  	BUILD_BUG_ON(~var != ~BIT(25));
>  }
>  
> +static void __init test_set_get_value(void)
> +{
> +	DECLARE_BITMAP(bitmap, BITS_PER_LONG * 2);

It's too short. Can you make it long enough to ensure it works as
expected when start is not in the 1st word, and start+nbits is in
the following word.

> +	unsigned long val;
> +	int i;
> +
> +	for (i = 0; i < BITS_PER_LONG * 2 - 7; i++) {
> +		bitmap_zero(bitmap, BITS_PER_LONG * 2);
> +		bitmap_set_value(bitmap, 0b10101UL, i, 5);
> +		val = bitmap_get_value(bitmap, i, 5);
> +		expect_eq_ulong(0b10101UL, val);

Can you also check that the rest of bitmap is untouched?
Something like:

	DECLARE_BITMAP(bitmap, ...);
	DECLARE_BITMAP(orig, ...);

        memset(orig, 0x5a, ...);
        memset(bitmap, 0x5a, ...);

        for (j = start; j < start + nbits; j++)
                if (val & BIT(j - start))
                        __set_bit(j, orig);
                else
                        __clear_bit(j, orig);

        bitmap_set_value(bitmap, val, start, nbits);
        expect_eq_bitmap(orig, bitmap, ...);

I like this kind of testing because it gives people a better
understanding of what happens behind all that optimization tricks.

Thanks,
Yury
