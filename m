Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91DF75DFBB
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 04:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjGWC3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 22:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjGWC3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 22:29:45 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C711BD3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 19:29:44 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6b9aadde448so2849137a34.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 19:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690079383; x=1690684183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uaustwNzjZmVePWypLXeoTLylLeiPcQlbyLPn6f6Obw=;
        b=QLeT/VCnFDu7+iJJQ8Z9+xNUr22l4+J5EJq+ySm/BvTfkXYuP8mBuvYr7YDpCXWAin
         zbHNyIYS7CM0DwIEVwoBfYtZDckqKHqXPrftBCcCrJD61Mva1kgyTF02I9TLiZPoqslB
         ElTbMkbOIOTPcSgX43AgkxHPWh8EcYbO+4stZP1c1lwbNxqh1NUV3PTvK5rR15ryWXyR
         3cBDNHXBgU7Rgi9CfbngokamJ/kgevWxeSCVwvWhLldh79012665j6P5WLPDqnCqYiWl
         yOX3cX00YdoamAzw7VeRymor4gAkWUxFgDkyT5gcn6MK1qn6Y5ghZqovbE1UsKktvRpU
         6QWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690079383; x=1690684183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uaustwNzjZmVePWypLXeoTLylLeiPcQlbyLPn6f6Obw=;
        b=fdtWLVjzh1+YukRTZUGoJkq2R6OU5Axe64m3nW5LPMBZA6Unvgsw627YSygAnG7Dwf
         L2LP//XzPsfXg2EouAGkDoTxQiz5MmLvAiw5IXy2PMRqztkbRRazmIPKxXAHCY0imbs/
         59t1jV93MoxA1+gUBJYyXVypPNpADQRdgbQ2RbJPvwYv7nvQVcimNDaack9v3W07GUmz
         DvNhuLKujxydjCyYNsUOhyp2RlfzMja/C120uRNbvQzVRIPyk87+8m/AmgMA3WWJKxfI
         06GoGEhF54DJa7sG4PG6Dv96wo3nB3JgrbJXw2A+hNCL4xGuC0qe6ucuNcutR0v6u/n1
         cO5A==
X-Gm-Message-State: ABy/qLZjibZ0kJugQjkHE4/0vLxgBl7SkG9MMrkki7mZtq1UAktv8fSm
        EzZux7B02D2dOkbhuS6kKKU=
X-Google-Smtp-Source: APBJJlHOGKDXakiRWOhkcQkFS0r6ynD4QhW1NnQ+4sbefE3ZendQTqwKIoFyuFTbGzenaqDrpMdHXQ==
X-Received: by 2002:a05:6830:19ce:b0:6b9:b985:2892 with SMTP id p14-20020a05683019ce00b006b9b9852892mr4352380otp.17.1690079383363;
        Sat, 22 Jul 2023 19:29:43 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id ji22-20020a170903325600b001bb9b87ac95sm62388plb.103.2023.07.22.19.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 19:29:42 -0700 (PDT)
Date:   Sat, 22 Jul 2023 19:29:39 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
Subject: Re: [PATCH v4 2/5] lib/test_bitmap: add tests for
 bitmap_{set,get}_value()
Message-ID: <ZLyQk5Wmcx7Cf84W@yury-ThinkPad>
References: <20230720173956.3674987-1-glider@google.com>
 <20230720173956.3674987-3-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720173956.3674987-3-glider@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 07:39:53PM +0200, Alexander Potapenko wrote:
> Add basic tests ensuring that values can be added at arbitrary positions
> of the bitmap, including those spanning into the adjacent unsigned
> longs.
> 
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[...]

> +/*
> + * Test bitmap should be big enough to include the cases when start is not in
> + * the first word, and start+nbits lands in the following word.
> + */
> +#define TEST_BIT_LEN (BITS_PER_LONG * 3)

Why not just 1000? Is your code safe against unaligned bitmaps?

> +#define TEST_BYTE_LEN (BITS_TO_LONGS(TEST_BIT_LEN) * sizeof(unsigned long))

BITS_TO_BYTES

> +static void __init test_set_get_value(void)

test_bitmap_read_write. Here, and in subjects for #1 and #2.

> +{
> +	DECLARE_BITMAP(bitmap, TEST_BIT_LEN);
> +	DECLARE_BITMAP(exp_bitmap, TEST_BIT_LEN);
> +	/* Prevent constant folding. */
> +	volatile unsigned long zero_bits = 0;

Use READ_ONCE() instead of volatile

> +	unsigned long val, bit;
> +	int i;
> +
> +	/* Setting/getting zero bytes should not crash the kernel. */
> +	bitmap_write(NULL, 0, 0, zero_bits);
> +	val = bitmap_read(NULL, 0, zero_bits);
> +	expect_eq_ulong(0, val);

No, val is undefined.

> +
> +	/*
> +	 * Ensure that bitmap_read() reads the same value that was previously
> +	 * written, and two consequent values are correctly merged.
> +	 * The resulting bit pattern is asymmetric to rule out possible issues
> +	 * with bit numeration order.
> +	 */
> +	for (i = 0; i < TEST_BIT_LEN - 7; i++) {

Can you add some empty lines in the block below in sake of
readability? Maybe after expect()?

> +		bitmap_zero(bitmap, TEST_BIT_LEN);
> +		bitmap_write(bitmap, 0b10101UL, i, 5);
> +		val = bitmap_read(bitmap, i, 5);
> +		expect_eq_ulong(0b10101UL, val);
> +		bitmap_write(bitmap, 0b101UL, i + 5, 3);
> +		val = bitmap_read(bitmap, i + 5, 3);
> +		expect_eq_ulong(0b101UL, val);
> +		val = bitmap_read(bitmap, i, 8);
> +		expect_eq_ulong(0b10110101UL, val);
> +	}
> +
> +	/*
> +	 * Check that setting a single bit does not accidentally touch the
> +	 * adjacent bits.
> +	 */
> +	for (i = 0; i < TEST_BIT_LEN; i++) {
> +		/*
> +		 * A 0b10101010 pattern to catch both 0s replaced to 1s and vice
> +		 * versa.
> +		 */
> +		memset(bitmap, 0xaa, TEST_BYTE_LEN);
> +		memset(exp_bitmap, 0xaa, TEST_BYTE_LEN);
> +		for (bit = 0; bit <= 1; bit++) {
> +			bitmap_write(bitmap, bit, i, 1);
> +			__assign_bit(i, exp_bitmap, bit);
> +			expect_eq_bitmap(exp_bitmap, bitmap, TEST_BIT_LEN);
> +		}

I suggested the other test:

val = DEADBEEF;
for (nbits = 1; nbits <= BITS_PER_LONG; nbits++)
        for (start = 0; start < 1000; i++) {
                if (start + nbits >= 1000)
                        break;;

                v = val & GENMASK(nbits - 1, 0);

		memset(bitmap, 0xaa /* also 0xff and 0x00 */, TEST_BYTE_LEN);
		memset(exp_bitmap, 0xaa, TEST_BYTE_LEN);

                for (n = 0; n < nbits; n++)
			__assign_bit(v & BIT(n), exp_bitmap, start + n);

                bitmap_write(bitmap, v, start, nbits);
		expect_eq_bitmap(exp_bitmap, bitmap, 1000);

                r = bitmap_read(bitmap, start, nbits);
                expect_eq(r, v);
        }

> +	}
> +
> +	/* Ensure setting 0 bits does not change anything. */
> +	memset(bitmap, 0xaa, TEST_BYTE_LEN);
> +	memset(exp_bitmap, 0xaa, TEST_BYTE_LEN);
> +	for (i = 0; i < TEST_BIT_LEN; i++) {
> +		bitmap_write(bitmap, ~0UL, i, 0);
> +		expect_eq_bitmap(exp_bitmap, bitmap, TEST_BIT_LEN);
> +	}
> +}
> +#undef TEST_BYTE_LEN
> +#undef TEST_BIT_LEN
> +
>  static void __init selftest(void)
>  {
>  	test_zero_clear();
> @@ -1249,6 +1328,8 @@ static void __init selftest(void)
>  	test_for_each_clear_bitrange_from();
>  	test_for_each_set_clump8();
>  	test_for_each_set_bit_wrap();
> +
> +	test_set_get_value();

This should append the test_bitmap_* section

Thanks,
Yury
