Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4867ADCAA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 18:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbjIYQGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 12:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjIYQGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 12:06:45 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9E492
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 09:06:36 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-59c0442a359so80564097b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 09:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695657996; x=1696262796; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YXDWtOQmeuAoPzz9skUV+Rg0agfJNdRgLYNKTJX4bFE=;
        b=HUZhslc+N5u/EQtjEyWqcZdENo1tM7avnZ1IgzAJaC9NgPejdaR7SQRJ4lvktB6tJu
         Qd86jWcrOXK38mjI27XtXA8gYpENW69FhFURSvikG5xk2pxa+3bSahkncXw4vpvXiIMy
         bP0esKCznCY961/71esxJl9LkZQCykLmsfU5BYH5HBPpEFUUEXEgyoMgPYANKETppbmE
         XNeLkJsD5eYcfv+XHbVzj84h2tYh2iRdV3wJDA/TKD7CW3PbQ6/Bd5fPUQRLPavdplrg
         Z1cDGL3tlYRnrkFMq5+QlcVwJqkJKnCZEC9sZ+CHVfnMqieIrKnqRpASF4qTdTEW5YKU
         M3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695657996; x=1696262796;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YXDWtOQmeuAoPzz9skUV+Rg0agfJNdRgLYNKTJX4bFE=;
        b=Vv3UyIeu19K8zxIn7gKVojd3532q6IEczYpUzSO1eeH8QUss16Wdtfi1kRzeobGosB
         rzscdW0jhDKVI1xVNZYNZaVppFl+cN/gbyJgFuUVJZLP3gKtVbIoGWHbDUOGTDjao8Cc
         a2h3gZYr4+evvLlrUG9k8dyP9lZNop3wRFKaANDS+WRz+6dgED+C2oXfyU+0kGFyn2T5
         klZ/OR+OrXrralKETWgTZ0OLD8kFBG8Iy/nFUiDyET2Qm3BwHRzXf9e7B0zMEvcEQkBZ
         vlTqI7MH5hiXf02Wc9jih3bGDCFlrhvtiY/HWdv5mIrvohQ94AGY8L3+uO1g9fYGqZAh
         E1pg==
X-Gm-Message-State: AOJu0YwbeL9krdTk/6z2GrX636sBbFI5Oqk9bcFXVqkFaksCA2UR95P9
        znoQlnwLCqRvc7Q69z7/9a4=
X-Google-Smtp-Source: AGHT+IFMcQAmfcNJw+f+wpOtJjOS55173Jrye276+Y6atM4/Yq6YsAerk37HlWIXHO75zkhdMVEEww==
X-Received: by 2002:a81:4f92:0:b0:59b:ec11:7734 with SMTP id d140-20020a814f92000000b0059bec117734mr6926858ywb.39.1695657995751;
        Mon, 25 Sep 2023 09:06:35 -0700 (PDT)
Received: from localhost ([2607:fb90:3eac:cd78:2863:6963:7d70:383c])
        by smtp.gmail.com with ESMTPSA id c188-20020a0df3c5000000b0059293c8d70csm2473337ywf.132.2023.09.25.09.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 09:06:35 -0700 (PDT)
Date:   Mon, 25 Sep 2023 09:06:33 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com, syednwaris@gmail.com, william.gray@linaro.org
Subject: Re: [PATCH v5 2/5] lib/test_bitmap: add tests for
 bitmap_{read,write}()
Message-ID: <ZRGv/5QNbYGIDkgw@yury-ThinkPad>
References: <20230922080848.1261487-1-glider@google.com>
 <20230922080848.1261487-3-glider@google.com>
 <CAG_fn=UeFoyhZvPJ7pGPrc5011D9h1e4ioffat4eUfVHP6Hd-Q@mail.gmail.com>
 <ZRF7r0ZjxcL9C8U8@smile.fi.intel.com>
 <CAG_fn=V8Mx89dOfKf88nEq9V9i_kMYaOdGjd3DQVOWnYrandyA@mail.gmail.com>
 <CAG_fn=WX+yAFHtbsxSvd41P61jjWtFEePqOs_1AKGJcgaWfVag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG_fn=WX+yAFHtbsxSvd41P61jjWtFEePqOs_1AKGJcgaWfVag@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 04:54:00PM +0200, Alexander Potapenko wrote:
> On Mon, Sep 25, 2023 at 3:09 PM Alexander Potapenko <glider@google.com> wrote:
> >
> > On Mon, Sep 25, 2023 at 2:23 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Mon, Sep 25, 2023 at 02:16:37PM +0200, Alexander Potapenko wrote:
> > >
> > > ...
> > >
> > > > > +/*
> > > > > + * Test bitmap should be big enough to include the cases when start is not in
> > > > > + * the first word, and start+nbits lands in the following word.
> > > > > + */
> > > > > +#define TEST_BIT_LEN (1000)
> > > >
> > > > Dunno why this didn't fire previously, but CONFIG_CPU_BIG_ENDIAN=y
> > > > kernel reports mismatches here, presumably because the last quad word
> > > > ends up partially initialized.
> > >
> > > Hmm... But if designed and used correctly it shouldn't be the issue,
> > > and 1000, I believe, is carefully chosen to be specifically not dividable
> > > by pow-of-2 value.
> > >
> >
> > The problem manifests already right after initialization:
> >
> > static void __init test_bit_len_1000(void)
> > {
> >         DECLARE_BITMAP(bitmap, TEST_BIT_LEN);
> >         DECLARE_BITMAP(exp_bitmap, TEST_BIT_LEN);
> >         memset(bitmap, 0x00, TEST_BYTE_LEN);
> >         memset(exp_bitmap, 0x00, TEST_BYTE_LEN);
> >         expect_eq_bitmap(exp_bitmap, bitmap, TEST_BIT_LEN);
> > }
> 
> The problem is that there's no direct analog of memset() that can be
> used to initialize bitmaps on both BE and LE systems.

memset fills an array of chars with the same value. In bitmap world we operate
on array of bits, and there are only 2 possible values: '0' and '1'. For those
we've got bitmap_zero() and bitmap_fill().

> bitmap_zero() and bitmap_set() work by rounding up the bitmap size to
> BITS_TO_LONGS(nbits), but there's no bitmap_memset() that would do the
> same for an arbitrary byte pattern.
> We could call memset(..., ..., BITS_TO_LONGS(TEST_BIT_LEN)), but that
> would be similar to declaring a bigger bitmap and not testing the last
> 24 bits.

No, you couldn't. On the test level, bitmap should be considered as a
black box. memset()'ing it may (and did) damage internal structure.

If you have some pattern in mind, you can use bitmap_parselist(). For example,
you can set every 2nd bit in your bitmap like this:

        bitmap_parselist("all:1/2", bitmap, 1000);

Check for almost 100 examples of bitmap_parselist usage in the test for
bitmap_parselist in the same file.

> Overall, unless allocating and initializing bitmaps with size
> divisible by sizeof(long), most of bitmap.c is undefined behavior, so
> I don't think it makes much sense to specifically test this case here
> (given that we do not extend bitmap_equal() in the patch set).

This is wrong statement. People spent huge amount of time making bitmap
API working well for all combinations of lengths and endiannesses,
including Andy and me.

NAK for this and for ignoring my other comment to v4.
