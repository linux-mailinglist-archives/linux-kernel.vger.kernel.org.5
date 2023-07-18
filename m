Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD8975810A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbjGRPeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbjGRPei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:34:38 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B05A1BD7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 08:34:15 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7835971026fso252214939f.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 08:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689694454; x=1692286454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkQL6Xf3KRHoENMdm+9rlbbV5WqUhj0bw3RQYEW+eQY=;
        b=wuFzPA8Rb4naUOIPI5KyNatZwnkYUyIqeNKqLe1/q0me1rBVtBp/Eza1iY+/Je9yxf
         Bc9MpJlPRTA2CqUWTPVY3k6O9+3whho9glFiFjFZFNS19Vg3PSA7o/CiyAHYcN/nikKE
         u0vn/mAHd5gAJk7o97gWvOOj+2shiGpRrAk6HWcW8W2SJG+/mZDLBVkg2cVCACJu9S06
         /vC6rVOrxSZtDcpqQeV1vDKupw+LX3UVfNv7Kn8/YQNtKNM/yMfcxBjeFa/UTDFNafDR
         P09eLF8XFeoSKToBYHIbhD3bfhqdb1Gg13dNqS9isz3SGJrnh3Xl5t5GuHN+4kuQzwZw
         EINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689694454; x=1692286454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nkQL6Xf3KRHoENMdm+9rlbbV5WqUhj0bw3RQYEW+eQY=;
        b=ALxrFRKsIueRwOGNIS0T7ddc0hcjKh9xyibZNQOBWR3yvi/VPltNxV4E33WTbS/x2M
         RH9xnYbRuBKSD2pyAi2zcyOJ0ZgWdHHn7z3F919nK2D+SttTa8q8iCmUBalQlgs32MNC
         DWUNrJdJpTZbAXrL3nDhkPB3m/ZtXymbvba3P6tL9rEUUP14phY2LRrWtTQKFAo7b24s
         0yQkupeXIFder3EvQPQMTI+hwUqX0f9Sh5b5EpEjH2N5oI/NLcm1im1VhUph3UR/sKTm
         HnbqU1Ivz82rptP7d2Lx4DLP7GUNvVomAZCehCiUVnza9PUxLmjzGfW7rKrVCy7vC+wV
         Qogg==
X-Gm-Message-State: ABy/qLbawHcZTtMln3s45ljpYVq1PShc1PODjBgzRaBlVeyxQZ7ot18n
        VStDGeJQ1DIypMlmuifJXn0q8vQesCksaW/U//YI2w==
X-Google-Smtp-Source: APBJJlHNcaObdeFSTQ//97dWNTSRm+lmmNp5Eqe0TBg+TPzNnAxq0z5keCDXI5jrMfC2pJBmZogxLgNSccDMop5pzj8=
X-Received: by 2002:a6b:f61a:0:b0:785:d06d:7b04 with SMTP id
 n26-20020a6bf61a000000b00785d06d7b04mr2798ioh.1.1689694454313; Tue, 18 Jul
 2023 08:34:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230717113709.328671-1-glider@google.com> <20230717113709.328671-4-glider@google.com>
 <ZLVG7GCTTBV4odAG@smile.fi.intel.com>
In-Reply-To: <ZLVG7GCTTBV4odAG@smile.fi.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 18 Jul 2023 17:33:37 +0200
Message-ID: <CAG_fn=XvoKjYpS2VPnSYBC3t7p7U-M_bfXohbXSvkepzS=6Tvg@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] arm64: mte: implement CONFIG_ARM64_MTE_COMP
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 3:49=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Jul 17, 2023 at 01:37:06PM +0200, Alexander Potapenko wrote:
> > The config implements the EA0 algorithm suggested by Evgenii Stepanov
> > to compress the memory tags for ARM MTE during swapping.
> >
> > The algorithm is based on RLE and specifically targets 128-byte buffers
> > of tags corresponding to a single page. In the common case a buffer
> > can be compressed into 63 bits, making it possible to store it without
> > additional memory allocation.
>
> ...
>
> > +config ARM64_MTE_COMP
> > +     bool "Tag compression for ARM64 MTE"
>
> At least here, make sure everybody understands what you are talking about=
. WTF
> MTE is?
Replaced with "Memory Tagging Extension"


> ...
>
> > +/*
>
> Are you deliberately made it NON-kernel-doc? If so, why? And why does it
> have too many similarities with above mentioned format?

No, just by lack of habit.

> > + * ea0_compress() - compress the given tag array.
> > + * @tags: 128-byte array to read the tags from.
> > + *
> > + * Compresses the tags and returns a 64-bit opaque handle pointing to =
the
> > + * tag storage. May allocate memory, which is freed by @ea0_release_ha=
ndle().
> > + */
> > +unsigned long ea0_compress(u8 *tags);
> > +
> > +/*
> > + * ea0_decompress() - decompress the tag array addressed by the handle=
.
> > + * @handle: handle returned by @ea0_decompress()
> > + * @tags: 128-byte array to write the tags to.
> > + *
> > + * Reads the compressed data and writes it into the user-supplied tag =
array.
> > + * Returns true on success, false on error.
>
> In case you are going to make them real kernel-doc:s, make sure kernel-do=
c
> validator doesn't warn.

I'll try to.
However it doesn't seem to be very picky.

  $ scripts/kernel-doc -v  -none arch/arm64/include/asm/mtecomp.h

warns about e.g. parameter name mismatch, but does not care about the
missing return section.

> Here, for example, return section is missing. The easy
> fix is to add : after Returns. Same to the rest of function descriptions.
Done

> Also
> why you put the descriptions in to the header file? It's a bit unusual fo=
r the
> exported ones.

https://docs.kernel.org/doc-guide/kernel-doc.html was not specific on
this, and I thought anyone wanting to understand how an interface
works would prefer reading the header rather than the implementation.
I can move the comments to arch/arm64/mm/mtecomp.c if you think it's a
better place for them.

> > +/*
> > + * ea0_tags_to_ranges() - break @tags into arrays of tag ranges.
> > + * @tags: 128-byte array containing 256 MTE tags.
> > + * @out_tags: u8 array to store the tag of every range.
> > + * @out_sizes: u16 array to store the size of every range.
>
> u16? I don't see it.
Fixed.


> > +/*
> > + * ea0_ranges_to_tags() - fill @tags using given tag ranges.
> > + * @r_tags: u8[256] containing the tag of every range.
> > + * @r_sizes: u16[256] containing the size of every range.
>
> Ditto.
Fixed.

>
> > + * @r_len: length of @r_tags and @r_sizes.
> > + * @tags: 128-byte array to write the tags to.
> > + */
> > +void ea0_ranges_to_tags(u8 *r_tags, short *r_sizes, int r_len, u8 *tag=
s);
>
> In both cases signed integer may be promoted with a sign. Is it a problem=
 here?
Not sure if you mean r_len or r_sizes, but all those values are >=3D 0
and <=3D 256, so there should be no problems.
(shorts could have been ints as well, we are just saving some stack
space in ea0_compress()/ea0_decompress()).

> > + *
> > + * We encapsulate tag storage memory management in this module, becaus=
e it is
> > + * tightly coupled with the pointer representation.
>
> > + *   ea0_compress(*tags) takes a 128-byte buffer and returns an opaque=
 value
>
> ea0_compress() is usual way how we refer to the functions. Let tools to m=
ake
> the necessary references.

Done.

>
> > + *     that can be stored in Xarray
> > + *   ea0_decompress(*ptr, *tags) takes the opaque value and loads the =
tags into
>
> Ditto. And so on.
Done.


> > + * 5. For the out-of-line case, the storage is allocated from one of t=
he
> > + *    "mte-tags-{16,32,64,128}" kmem caches. The resulting pointer is =
aligned
> > + *    on 8 bytes, so its bits 2..0 can be used to store the size class=
:
>
> > + *     - 0 for 128 bytes
> > + *     - 1 for 16
> > + *     - 2 for 32
> > + *     - 4 for 64.
>
> Is this chosen deliberately (for performance?)? Otherwise why not put the=
m in
> natural exponential growing?

This way pointers to uncompressed buffers do not have extra data stored in =
them.
This property does not have any immediate use though.


> ...
>
> > +#include <linux/bits.h>
> > +#include <linux/bitmap.h>
>
> bitmap guarantees that bits.h will be included.

I am following the IWYU principle here, and I believe it's a good thing to =
do.
I've seen cases where these transitive dependencies rotted after some
refactoring, but the fact was only noticed in certain configurations.
Also, there's an ongoing work by Ingo Molnar to speed up kernel builds
by optimizing headers
(https://lwn.net/ml/linux-kernel/YdIfz+LMewetSaEB@gmail.com/), and it
relies on explicit dependencies which are easier to untangle.

>
> ...
>
> > +void ea0_tags_to_ranges(u8 *tags, u8 *out_tags, short *out_sizes, int =
*out_len)
> > +{
> > +     u8 prev_tag =3D U8_MAX;
>
> > +     int cur_idx =3D -1;
>
> At which circumstances does this assignment make sense?
This value is never used to index the array, it is incremented on the
first loop iteration.

> > +     for (i =3D 0; i < MTE_PAGE_TAG_STORAGE; i++) {
> > +             for (j =3D 0; j < 2; j++) {
> > +                     cur_tag =3D j ? (tags[i] % 16) : (tags[i] / 16);
> > +                     if (cur_tag =3D=3D prev_tag) {
> > +                             out_sizes[cur_idx]++;
>
> Who guarantees this one is not [-1]?
The fact that prev_tag is initialized to U8_MAX, whereas cur_tag <=3D 15.


> > +                     } else {
>
> > +                             cur_idx++;
>
> Aha, above seems a bit prone to out of boundaries errors.
Not really, but since you stumbled upon it, I'd better make it more readabl=
e.

> Can you make it
> unsigned and start from 0?

Changed to start with 0, but I am a bit hesitant about making it
unsigned: it is now no more special than a loop variable.

> > +void ea0_ranges_to_tags(u8 *r_tags, short *r_sizes, int r_len, u8 *tag=
s)
> > +{
> > +     int i, j, pos =3D 0;
>
> Wouldn't be more correct to have this assignment inside the first for-loo=
p?

Do you mean setting it back to 0 on every iteration of the outer loop?
We sure don't want that, since pos is the location in the tags[] array
where the next tag is written.
If what you meant is doing "for (i =3D 0, pos =3D 0; ...)" this is a
question of preference, but I can do that.


>
> > +#define RANGES_INLINE ea0_size_to_ranges(8)
>
> Don't forget to undef it when not needed.

Ok, will do.
Shall I undef the constants above as well (e.g. BITS_PER_TAG)?
The intuitive answer is "no", but then there should be some difference
between those and RANGES_INLINE?

>
> ...
>
> > +static void bitmap_write(unsigned long *bitmap, unsigned long value,
> > +                      unsigned long *pos, unsigned long bits)
>
> Please, don't use reserved namespace. Yours is ea0, use it:
> ea0_bitmap_write()! Same to other similarly named functions.

Done.
However there are two parallel namespaces now: "ea0" for the
compression algorithm, and "memcomp" for the module initialization and
data structures.
Dunno if it makes sense to merge them (and rename the .c file accordingly).

> ...
>
> > +     unsigned long bit_pos =3D 0, l_bits;
> > +     int largest_idx =3D -1, i;
> > +     short largest =3D 0;
>
> Here and elsewhere, please, double check the correctness and/or necessity=
 of
> signdness and assignments of local variables.

I replaced a bunch of ints with size_t where it made sense (basically
all array indices remain ints, but all sizes are size_t now).
Also removed the assignment to largest_idx above.


> Here
>
>                 if (largest >=3D sizes[i])
>                         continue;
> makes sense, but...
>
> > +                     largest =3D sizes[i];
> > +                     largest_idx =3D i;
> > +             }
> > +     }
>
> ...
>
> > +     for (i =3D 0; i < len; i++) {
> > +             if (i =3D=3D largest_idx)
> > +                     continue;
> > +             bitmap_write(bitmap, sizes[i], &bit_pos, BITS_PER_SIZE);
>
> ...here I would do the opposite since it's one liner.

Agreed.

>
> > +     }
>
> ...
>
> > +     u8 r_tags[256];
> > +     int r_len =3D ARRAY_SIZE(r_tags);
>
No, it is the length of the arrays (both r_tags and r_sizes).
Below you make a good point it will spare us a kernel.h dependency,
but for the sake of keeping the code error-prone we probably shouldn't
assume r_tags is a byte array.


> > +     l_bits =3D (max_ranges =3D=3D RANGES_INLINE) ? BITS_PER_LARGEST_I=
DX_INLINE :
> > +                                              BITS_PER_LARGEST_IDX;
>
> Is it a dup? Perhaps a helper for this?
Do you mean it is the same in ea0_compress_to_buf() and
ea0_decompress_from_buf()?
Added a helper.

> Seems BITS_PER_TAG, BITS_PER_SIZE and the rest should also be namespaced,
> EA0_BITS_...

Done.

> ...
>
> > +bool ea0_decompress(unsigned long handle, u8 *tags)
> > +{
> > +     unsigned long *storage =3D ea0_storage(handle);
> > +     int size =3D ea0_storage_size(handle);
> > +
> > +     if (size =3D=3D 128) {
> > +             memcpy(tags, storage, size);
> > +             return true;
> > +     }
> > +     if (size =3D=3D 8)
> > +             return ea0_decompress_from_buf(&handle, RANGES_INLINE, ta=
gs);
>
> Maybe
>
>         switch (ea0_storage_size(handle)) {
>                 ...
>         default:
>         }
>
> ?

Sounds reasonable, done.

> > +void ea0_release_handle(unsigned long handle)
> > +{
> > +     void *storage =3D ea0_storage(handle);
> > +     int size =3D ea0_storage_size(handle);
> > +     struct kmem_cache *c;
>
> > +     if (!storage)
> > +             return;
>
> I find slightly better for maintaining in the form as
>
>         struct kmem_cache *c;
>         void *storage;
>         int size;
>
>         storage =3D ea0_storage(handle);
>         if (!storage)
>                 return;
>
>         size =3D ea0_storage_size(handle);

Done.

> > +static int mtecomp_init(void)
> > +{
> > +     char name[16];
> > +     int size;
> > +     int i;
> > +
> > +     BUILD_BUG_ON(MTE_PAGE_TAG_STORAGE !=3D 128);
>
> Why not static_assert()?
>
> > +     for (i =3D 0; i < NUM_CACHES; i++) {
> > +             size =3D ea0_cache_id_to_size(i);
> > +             snprintf(name, ARRAY_SIZE(name), "mte-tags-%d", size);
>
> sizeof() will work the same way without need of having kernel.h be includ=
ed.

Done.
