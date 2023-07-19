Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1475C7597A1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 16:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjGSOA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 10:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbjGSOAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 10:00:53 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E9AA7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 07:00:52 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-785ccf19489so341716639f.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 07:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689775252; x=1692367252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sm5iUVzDjI6gtV1CUEzsIfEMKheElnJtk12R8Kcga4w=;
        b=AVjUX5sIScJhPd/PaRJ/WytxTzNMZtgYf0uiVAVBKOuOEQSCbVB0ilRKZ5QiD8lU1x
         XdK5vI7Q1yOKC32qLCDQfzsH46vKYZtS9ngPXFb1DwMwc8Rst5K43lOauReYD3UNMen3
         s6k8+39O+dmB4IxfokHqIR2IbdNWYyesRAm2Aj1G3uVLLt+CpSZYVineDAssC37Zfi9/
         XGVVtsKHo5UW3S3237LBrVMmTa+iXOqAp69hq2T1M5nmp3DLI1BXrzLwfcWBb7NuE2jm
         Vep92QmraEtl568n+7aIKMp57eHJRMoZ0V4d9yUuZerew4GiUUfXVz8t88Xc2cJWMmqc
         XO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689775252; x=1692367252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sm5iUVzDjI6gtV1CUEzsIfEMKheElnJtk12R8Kcga4w=;
        b=RWOTSH6QsssObZ90dSVSVjKtM2jHCIg3RynhvLj0k3LkQ5blgWbv+31892l3oyxivr
         SKqYhIoySEvmwKinH2y0thjc7jP+mv33uEns1yoHUQLWFBp0COS1al7Ur3Gc88iTBdhs
         kd7nCQxKKLvxNsJ8hf8+ggXQPGCtdabl4aWL8siutR2LiVIL+PKglTZaF2TPuYaFSQyS
         RJ3494iyVTf8110s6eTUQek9ui8mQaj/9Gb8ymGOr95qitmAVQIf3A7FKhWaqYcx0/hP
         VezDmRtAke+ru5I1KoJ57wYtIj3vJ38ovlNJBKf8+/mKjJ9h8/mvIGgiCKufFJBudWKI
         ImAA==
X-Gm-Message-State: ABy/qLayqKE/N2u41AmpmGAIFnX9ddw20nJIy6WrKR7/kLhPp9g1t8/R
        EOTgVipcQQDgicOmv0vrjlestztd3d6muZVOoEV+CA==
X-Google-Smtp-Source: APBJJlH8nmA9FeuGVLYUZEujVBfCWqRf6lw0eP3LFo9BVnqinoFrbCWdpUoBhe0hCoxBSEopQ5nuit7MmTjOtTFM7Jk=
X-Received: by 2002:a5e:a709:0:b0:785:cfa1:fcac with SMTP id
 b9-20020a5ea709000000b00785cfa1fcacmr5100870iod.20.1689775251390; Wed, 19 Jul
 2023 07:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230717113709.328671-1-glider@google.com> <20230717113709.328671-4-glider@google.com>
 <ZLd+J3BkI3oK5vCw@yury-ThinkPad>
In-Reply-To: <ZLd+J3BkI3oK5vCw@yury-ThinkPad>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 19 Jul 2023 16:00:14 +0200
Message-ID: <CAG_fn=USWBm=mdhgOz_df0veGQdioGOARqpZH5rAg3_fwhpbjA@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] arm64: mte: implement CONFIG_ARM64_MTE_COMP
To:     Yury Norov <yury.norov@gmail.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 8:09=E2=80=AFAM Yury Norov <yury.norov@gmail.com> w=
rote:
...
> > +
> > +/* Functions below are exported for testing purposes. */
>
> Then declare them in a separate local header or simply in the test, but
> please not in a public header.

Fair enough, moved them to the test.

> > +
> > +/*
> > + * EA0 stands for "Evgenii's Algorithm 0", as the initial proposal con=
tained two
> > + * compression algorithms.
>
> This is the 4th time I see mr. Stepanov's credentials in the patch.
> I've no doubts he's a worthy gentleman but please avoid mentioning
> people in source code. Suggested-by is enough. IIRC, the rule for
> that exists for about decade.
>
> For the purpose of namespacing, the mte_compress/mte_decompress would
> sound better.

This indeed makes sense; "EA0" is not widely recognizable, and we are
unlikely to have more than one MTE compression algorithm anyway.
I changed "ea0" to "mte" in the patch series.



> > + *
> > + * 4. For the inline case, the following values are stored in the 8-by=
te handle:
> > + *       largest_idx : i4
> > + *      r_tags[0..5] : i4 x 6
> > + *     r_sizes[0..4] : i7 x 5
> > + *    (if N is less than 6, @r_tags and @r_sizes are padded up with ze=
ro values)
> > + *
> > + *    Because @largest_idx is <=3D 5, bit 63 of the handle is always 0=
 (so it can
> > + *    be stored in the Xarray), and bits 62..60 cannot all be 1, so it=
 can be
> > + *    distinguished from a kernel pointer.
>
> I honestly tried to understand... For example, what the
>         'r_sizes[0..4] : i7 x 5'
> means? An array of 5 elements, 17 bits each? But it's alone greater
> than size of pointer... Oh gosh...

iN (note that it is a small i, not a 1) is LLVM notation for an N-bit
integer type.
There's no such thing in C syntax, and describing the data layout
using bitfields would be painful.
Would it help if I add a comment explaining that iN is an N-bit
integer? Or do you prefer something like

  r_sizes[0..4] : 5 x 7 bits

?

>
> Moreover, MTE tags are all 4-bits.
>
> It seems like text without pictures is above my mental abilities. Can you
> please illustrate it? For example, from the #4, I (hopefully correctly)
> realized that:
>
> Inline frame format:
>    0                                                    60       62  63
>  +---------------------------------------------------------------------+
I think it's more natural to number bits from 63 to 0

>  |              No idea what happens here             |    Lidx    | X |
>  +---------------------------------------------------------------------+
>  63    : X      :  RAZ : Reserved for Xarray.
>  60-62 : Lidx   : 0..5 : Largest element index.

There's some mismatch now between this picture, where Lidx is i3, and
the implementation that treats it as an i4, merging bit 63 into it.
Maybe we can avoid this by not splitting off bit 63?

>                      6 : Reserved
>                      7 : Invalid handler

No, 7 means "treat this handle as an out-of-line one". It is still
valid, but instead of tag data it contains a pointer.

>
> Because of the size, I believe this comment is worth to put in Docs,
> moreover we already have "Documentation/arch/arm64/memory-tagging-extensi=
on.rst"
> Why don't you add an 'MTE Compression' section in there?

Good idea, will do!

>
> > +#include <linux/bits.h>
> > +#include <linux/bitmap.h>
> > +#include <linux/gfp.h>
> > +#include <linux/module.h>
> > +#include <linux/slab.h>
> > +#include <linux/swab.h>
> > +#include <linux/string.h>
> > +#include <linux/types.h>
>
> Nit: Alphabetic order?
Ack.

>
> Andy is right, bitmap.h includes bit.h, no need to include both. And if
> your code will get broken one day, it's a bitmap maintainers' work to fix=
.
Ack.


> > +
> > +/*
> > + * Sizes of compressed values.
> > + */
> > +#define BITS_PER_TAG 4
> > +#define BITS_PER_SIZE 7
> > +#define BITS_PER_LARGEST_IDX_INLINE 4
> > +#define BITS_PER_LARGEST_IDX 6
>
> But in the comment you say that largest index in inline frame is 3-bits l=
ong.

The comment says "i4" (see my comments above)

> > +
> > +/* Translate allocation size into mtecomp_caches[] index. */
> > +static int ea0_size_to_cache_id(int len)
>
> Here and everywhere, do you need signed values? If not, unsigned int.

Done as part of fixing Andy's comments

> > +
> > +/* Transform tag ranges back into tags. */
> > +void ea0_ranges_to_tags(u8 *r_tags, short *r_sizes, int r_len, u8 *tag=
s)
> > +{
> > +     int i, j, pos =3D 0;
> > +     u8 prev;
> > +
> > +     for (i =3D 0; i < r_len; i++) {
> > +             for (j =3D 0; j < r_sizes[i]; j++) {
> > +                     if (pos % 2)
> > +                             tags[pos / 2] =3D (prev << 4) | r_tags[i]=
;
> > +                     else
> > +                             prev =3D r_tags[i];
> > +                     pos++;
> > +             }
> > +     }
> > +}
> > +EXPORT_SYMBOL_NS(ea0_ranges_to_tags, MTECOMP);
>
> Because I didn't understand the compressed frame format, not sure I
> can understand this logic...
Hope the above comments will help, if not - please let me know.

> > +
> > +/* Translate @num_ranges into the allocation size needed to hold them.=
 */
> > +static int ea0_alloc_size(int num_ranges)
> > +{
> > +     if (num_ranges <=3D 6)
> > +             return 8;
> > +     if (num_ranges <=3D 11)
> > +             return 16;
> > +     if (num_ranges <=3D 23)
> > +             return 32;
> > +     if (num_ranges <=3D 46)
> > +             return 64;
> > +     return 128;
> > +}
> > +
> > +/* Translate allocation size into maximum number of ranges that it can=
 hold. */
> > +static int ea0_size_to_ranges(int size)
> > +{
> > +     switch (size) {
> > +     case 8:
> > +             return 6;
> > +     case 16:
> > +             return 11;
> > +     case 32:
> > +             return 23;
> > +     case 64:
> > +             return 46;
> > +     default:
> > +             return 0;
> > +     }
> > +}
>
> I wonder if there's a math formula here? Can you explain where from
> those numbers come?

I'll add a comment there.
Basically, for the inline case it is the biggest N such as 4 + 4*N +
7*(N-1) <=3D 63
(not 64, because Xarray steals one bit from us)

For the out-of-line case it is the biggest N such as 6+4*N + 7*(N-1)
<=3D array size in bits (128, 256, or 512).

>
> > +#define RANGES_INLINE ea0_size_to_ranges(8)
>
> Maybe
>
>  #define RANGES_INLINE (6)

Fair enough.


> > +
> > +static void bitmap_write(unsigned long *bitmap, unsigned long value,
> > +                      unsigned long *pos, unsigned long bits)
>
> Please don't steal prefixes. But the idea is good. For the next
> iteration, let's rename bitmap_set_value() to bitmap_write()?
> So that your function will be an mte_bitmap_write().

I don't object, but it diverges from bitmap_set_value8() now.
Will do.
