Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24827AAAFE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjIVH6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjIVH6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:58:19 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267BECA
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 00:58:13 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-41214998fc2so11399721cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 00:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695369492; x=1695974292; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ArWimah5exrjeoIgCLSPSDJoWNZQHiPwH1WGpg90yyk=;
        b=U0o9yK52RL2XjYCw2I38y97T441ZkrFsXU1gKGLopsklb1UpjIIMu/z0kgkJRJiMZz
         TObGMSasxLKXZuh8jkOyFazxDLPBuX6Ih+cHOTy0UKSCWIkiB/wPxI3kpwjxAN8Yqyx+
         x7z+wZ4XcHJlKqiFZNUajMagOmH7Xwz34ylyOr7t0oEJq65NbhLxj9qdVSNoSw74uNf0
         vHUmdQYuBalDPEZim9Hx938O4pm46j/VLyMviEqS3TyORrEx40nSxRMhZQeRUpd6CMOC
         U5WEzq1OgmQYfZI9xW+i5zT9LV/B+E7x1digFyiPHVNE77w/Bq1smwimJUOwHzUMjXpe
         sH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695369492; x=1695974292;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ArWimah5exrjeoIgCLSPSDJoWNZQHiPwH1WGpg90yyk=;
        b=qL68HKqYHHvMBZtvAyI+BcTh0kFITZ0SAbdsLwymEUa4mwAHV+u9+/sUK6gP7QKFP5
         OfKHzMBwVmlMTYuXoiuoKqEDANa8aB0LatN2WgyHSlhe69DkBAERQqFwxqGFCCdG6pUo
         DxwkrUrmT2+pljsNvoMA3zfBoyUEz0cj29edGi9eBhH00zzG7W048zZzO+++C0r4zibL
         DV8o6RQWE2p5uoegzz/ehjIyw8lgeDk9hhENd8QQiAI33FU7WCE3JIrCaZ3vtBL3GTG5
         apvyRrw9zVSxQ7eCvSgopyumUMIlAztCPRkWe6h3F6liuuefBwE7SrWM/HvkR+FvELr9
         iEgg==
X-Gm-Message-State: AOJu0Yytxvvgbo4mbjlZoWUd4vMaG39MR+3EIg5YIieYAp2FRH6D+cfA
        Z9VHJk5kX38qkKGAvzF28Cw3ZFSZmvIfqgWHkR31rcFB5RaWXDqTj9dYjQ==
X-Google-Smtp-Source: AGHT+IFk7v0ctfY2n76YcxfuoXr0FRzvwfQygMxttgjX9OCKhpuKlRcpouUHsqLzzn7m5PkdZLhaE+U6GZPeUKdLPuk=
X-Received: by 2002:a0c:ab11:0:b0:636:e4f:6b9a with SMTP id
 h17-20020a0cab11000000b006360e4f6b9amr7576766qvb.17.1695369492061; Fri, 22
 Sep 2023 00:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230720173956.3674987-1-glider@google.com> <20230720173956.3674987-3-glider@google.com>
 <ZLyQk5Wmcx7Cf84W@yury-ThinkPad>
In-Reply-To: <ZLyQk5Wmcx7Cf84W@yury-ThinkPad>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 22 Sep 2023 09:57:32 +0200
Message-ID: <CAG_fn=WQORJConbBPzaNF2Nuxaf9Jmhy1Vgj=nk7gj902SQxOA@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] lib/test_bitmap: add tests for bitmap_{set,get}_value()
To:     Yury Norov <yury.norov@gmail.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +/*
> > + * Test bitmap should be big enough to include the cases when start is not in
> > + * the first word, and start+nbits lands in the following word.
> > + */
> > +#define TEST_BIT_LEN (BITS_PER_LONG * 3)
>
> Why not just 1000? Is your code safe against unaligned bitmaps?

done

> > +#define TEST_BYTE_LEN (BITS_TO_LONGS(TEST_BIT_LEN) * sizeof(unsigned long))
>
> BITS_TO_BYTES

done

>
> > +static void __init test_set_get_value(void)
>
> test_bitmap_read_write. Here, and in subjects for #1 and #2.

done

> > +{
> > +     DECLARE_BITMAP(bitmap, TEST_BIT_LEN);
> > +     DECLARE_BITMAP(exp_bitmap, TEST_BIT_LEN);
> > +     /* Prevent constant folding. */
> > +     volatile unsigned long zero_bits = 0;
>
> Use READ_ONCE() instead of volatile

done

> > +     unsigned long val, bit;
> > +     int i;
> > +
> > +     /* Setting/getting zero bytes should not crash the kernel. */
> > +     bitmap_write(NULL, 0, 0, zero_bits);
> > +     val = bitmap_read(NULL, 0, zero_bits);
> > +     expect_eq_ulong(0, val);
>
> No, val is undefined.

Why? bitmap_read(..., ..., 0) always returns 0.

>
> > +
> > +     /*
> > +      * Ensure that bitmap_read() reads the same value that was previously
> > +      * written, and two consequent values are correctly merged.
> > +      * The resulting bit pattern is asymmetric to rule out possible issues
> > +      * with bit numeration order.
> > +      */
> > +     for (i = 0; i < TEST_BIT_LEN - 7; i++) {
>
> Can you add some empty lines in the block below in sake of
> readability? Maybe after expect()?

Done

(snip)

> I suggested the other test:
>
> val = DEADBEEF;
> for (nbits = 1; nbits <= BITS_PER_LONG; nbits++)
>         for (start = 0; start < 1000; i++) {
>                 if (start + nbits >= 1000)
>                         break;;
>
>                 v = val & GENMASK(nbits - 1, 0);
>
>                 memset(bitmap, 0xaa /* also 0xff and 0x00 */, TEST_BYTE_LEN);
>                 memset(exp_bitmap, 0xaa, TEST_BYTE_LEN);
>
>                 for (n = 0; n < nbits; n++)
>                         __assign_bit(v & BIT(n), exp_bitmap, start + n);
>
>                 bitmap_write(bitmap, v, start, nbits);
>                 expect_eq_bitmap(exp_bitmap, bitmap, 1000);
>
>                 r = bitmap_read(bitmap, start, nbits);
>                 expect_eq(r, v);
>         }

I factored out test cases that can benefit from different background
patterns into a separate function and added yours there. Thanks!

> > @@ -1249,6 +1328,8 @@ static void __init selftest(void)
> >       test_for_each_clear_bitrange_from();
> >       test_for_each_set_clump8();
> >       test_for_each_set_bit_wrap();
> > +
> > +     test_set_get_value();
>
> This should append the test_bitmap_* section

Done

> Thanks,
> Yury

Thanks a lot for your comments!
