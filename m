Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DB475A055
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 23:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjGSVGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 17:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGSVG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 17:06:29 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAAA1BF0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 14:06:28 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-666ecb21f86so42930b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 14:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689800787; x=1690405587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AF9IOZ3UOTWW343eOS95NBVTfJzpdBE851mdqjeU/1Q=;
        b=Bxo5mueUwonj/5hHo73MbXlsPi5m031iP5IOMeodjpAZs7ibdbjR5Tr17Ie3TLI4xy
         AEUm8PHAq4t4g/qyrCNWivV2Od8EsAtoowpv+VMDKiZAuwG9rdFdmkutTVR5cQVEqz4d
         iK3R+hlk3OVKOwJ9n+DGjtpNaJfUjNo4h/QrOSL84P7Ege/4EC/alZ8NWwpk086IRGwH
         sqvnzmS3YYk1+PWPoOT4zv3hNH3V8v7lPnnDQeNl3P6JDLmCDvBqwnZKDmaPdzGwQWW0
         vzH9fVmvlu60xeW3jIs3B44nJLofA9n/O3z8T+19fc61yk3J6VaX9CU9ft7TiStXOXcS
         R2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689800787; x=1690405587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AF9IOZ3UOTWW343eOS95NBVTfJzpdBE851mdqjeU/1Q=;
        b=ab8AhJ/O7u262s1M76oG3TWLVvqLN6HnA7wJJfuFjjCUXpYJQ1ejDEmHEeQ1WV3xba
         UrB0x9ajCY1SRr4MlVGPN37Y/RPE1lQH1F1DxsujUn1WPntoGIfwoUARj36Ee8CUjc6k
         x8JUziTDfpH9DLIwkSDhiIGkWqRz5BlLKU3SGT5/NGGA2qHcjt42aOm+Hm7NxMSi5X4N
         g7BHNAz87PWfR4sS26tfbSyQeZRpmciFWEq5Z277TSo3L9pl27EJ/oUrdJrgXkte1ZZL
         94HhxtX5PYwvc4TPU4yrNo5uu25QUhUWN/Q0LYgsZ4mN9NLo5YyD7vPOSwk+JypGhJaz
         ZbeQ==
X-Gm-Message-State: ABy/qLb0J+U0WXxRLdRV8RQsG93b03/xG0S5c+uyR+h6lZAgBfb26bXD
        AKsTfJ3c7knV428HovVkMSE=
X-Google-Smtp-Source: APBJJlEwaAofEGdtnh1eMWsBvCcQK2w2qQxoBcziY8OHfpMopP/Cv8j2HH8Q2WOBJm6DCVE8xkNdbw==
X-Received: by 2002:a05:6a20:321b:b0:12f:9e13:12b1 with SMTP id hl27-20020a056a20321b00b0012f9e1312b1mr651719pzc.15.1689800787332;
        Wed, 19 Jul 2023 14:06:27 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id c26-20020a63961a000000b0055adced9e13sm4065221pge.0.2023.07.19.14.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 14:06:26 -0700 (PDT)
Date:   Wed, 19 Jul 2023 14:06:24 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
Subject: Re: [PATCH v3 3/5] arm64: mte: implement CONFIG_ARM64_MTE_COMP
Message-ID: <ZLhQRyWSQax5/DCL@yury-ThinkPad>
References: <20230717113709.328671-1-glider@google.com>
 <20230717113709.328671-4-glider@google.com>
 <ZLd+J3BkI3oK5vCw@yury-ThinkPad>
 <CAG_fn=USWBm=mdhgOz_df0veGQdioGOARqpZH5rAg3_fwhpbjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=USWBm=mdhgOz_df0veGQdioGOARqpZH5rAg3_fwhpbjA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 04:00:14PM +0200, Alexander Potapenko wrote:
> > > + * 4. For the inline case, the following values are stored in the 8-byte handle:
> > > + *       largest_idx : i4
> > > + *      r_tags[0..5] : i4 x 6
> > > + *     r_sizes[0..4] : i7 x 5
> > > + *    (if N is less than 6, @r_tags and @r_sizes are padded up with zero values)
> > > + *
> > > + *    Because @largest_idx is <= 5, bit 63 of the handle is always 0 (so it can
> > > + *    be stored in the Xarray), and bits 62..60 cannot all be 1, so it can be
> > > + *    distinguished from a kernel pointer.
> >
> > I honestly tried to understand... For example, what the
> >         'r_sizes[0..4] : i7 x 5'
> > means? An array of 5 elements, 17 bits each? But it's alone greater
> > than size of pointer... Oh gosh...
> 
> iN (note that it is a small i, not a 1) is LLVM notation for an N-bit
> integer type.
> There's no such thing in C syntax, and describing the data layout
> using bitfields would be painful.
> Would it help if I add a comment explaining that iN is an N-bit
> integer? Or do you prefer something like
> 
>   r_sizes[0..4] : 5 x 7 bits
> 
> ?

Yes, that would help.
 
> >
> > Moreover, MTE tags are all 4-bits.
> >
> > It seems like text without pictures is above my mental abilities. Can you
> > please illustrate it? For example, from the #4, I (hopefully correctly)
> > realized that:
> >
> > Inline frame format:
> >    0                                                    60       62  63
> >  +---------------------------------------------------------------------+
> I think it's more natural to number bits from 63 to 0
> 
> >  |              No idea what happens here             |    Lidx    | X |
> >  +---------------------------------------------------------------------+
> >  63    : X      :  RAZ : Reserved for Xarray.
> >  60-62 : Lidx   : 0..5 : Largest element index.
> 
> There's some mismatch now between this picture, where Lidx is i3, and
> the implementation that treats it as an i4, merging bit 63 into it.
> Maybe we can avoid this by not splitting off bit 63?
> 
> >                      6 : Reserved
> >                      7 : Invalid handler
> 
> No, 7 means "treat this handle as an out-of-line one". It is still
> valid, but instead of tag data it contains a pointer.

So, it's invalid combination for _inline_ handler, right? Anyways, I'm
waiting for an updated docs, so it will hopefully bring some light.

> > > +
> > > +/* Transform tag ranges back into tags. */
> > > +void ea0_ranges_to_tags(u8 *r_tags, short *r_sizes, int r_len, u8 *tags)
> > > +{
> > > +     int i, j, pos = 0;
> > > +     u8 prev;
> > > +
> > > +     for (i = 0; i < r_len; i++) {
> > > +             for (j = 0; j < r_sizes[i]; j++) {
> > > +                     if (pos % 2)
> > > +                             tags[pos / 2] = (prev << 4) | r_tags[i];
> > > +                     else
> > > +                             prev = r_tags[i];
> > > +                     pos++;

This code flushes tags at every 2nd iteration. Is that true that
there's always an even number of iterations, i.e. rsizes is always
even, assuming r_len can be 1?

If not, it's possible to loose a tag, consider rlen == 1 and
rsizes[0] == 1.

If yes, you can simplify:

     for (i = 0; i < r_len; i++)
             for (j = 0; j < r_sizes[i]; j++)
                     tags[pos++] = (r_tags[i] << 4) | r_tags[i];

Anyways, in the test can you run all possible combinations?

> > > +             }
> > > +     }
> > > +}
> > > +EXPORT_SYMBOL_NS(ea0_ranges_to_tags, MTECOMP);
> >
> > Because I didn't understand the compressed frame format, not sure I
> > can understand this logic...
> Hope the above comments will help, if not - please let me know.
> 
> > > +
> > > +/* Translate @num_ranges into the allocation size needed to hold them. */
> > > +static int ea0_alloc_size(int num_ranges)
> > > +{
> > > +     if (num_ranges <= 6)
> > > +             return 8;
> > > +     if (num_ranges <= 11)
> > > +             return 16;
> > > +     if (num_ranges <= 23)
> > > +             return 32;
> > > +     if (num_ranges <= 46)
> > > +             return 64;
> > > +     return 128;
> > > +}
> > > +
> > > +/* Translate allocation size into maximum number of ranges that it can hold. */
> > > +static int ea0_size_to_ranges(int size)
> > > +{
> > > +     switch (size) {
> > > +     case 8:
> > > +             return 6;
> > > +     case 16:
> > > +             return 11;
> > > +     case 32:
> > > +             return 23;
> > > +     case 64:
> > > +             return 46;
> > > +     default:
> > > +             return 0;
> > > +     }
> > > +}
> >
> > I wonder if there's a math formula here? Can you explain where from
> > those numbers come?
> 
> I'll add a comment there.
> Basically, for the inline case it is the biggest N such as 4 + 4*N +
> 7*(N-1) <= 63
>
> (not 64, because Xarray steals one bit from us)
> 
> For the out-of-line case it is the biggest N such as 6+4*N + 7*(N-1)
> <= array size in bits (128, 256, or 512).

So it's: N <= (BIT_CAPACITY + NUM4 - NUM7) / (TAGSZ + SZ)

Doesn't look like a rocket science...

Why don't you code the formula instead of results? Are there any
difficulties? Things may change. For example, in next spec they
may bring 3- or 5-bit tags, and your compressor will crack loudly
with hardcoded numbers.
