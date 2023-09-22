Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD8B7AABAE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjIVIFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbjIVIFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:05:18 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943071F05
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:03:51 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-64cca551ae2so10425276d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695369830; x=1695974630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ef1lz4NaECWVWSkMTH/C2VI1iTg3OW5SLvb2NYIpXHw=;
        b=qftf6imrqBV0Y3hzXIyLPR1dsR/W2LFIruYgfAAl2PAyPVm4Zt/yJGi/fwhsYrVZHT
         FCZxfvQKBcaW6X9+Y4de1H+RNfVHbF9kzQ0+3Hr99PeK/lpqbhKjs9mzBE44eB10CQ/y
         yzyiQTQsjJk5L6DljdIEr9ThVBvmw0lz0OGpjpw1WjTz0HsFzVeX282GbVwH5cpEtdf+
         i7w7+9mfii7/yDOVmcCuJcYpTyh4nPcRfyk/CDnk9sKJNT744H7MrDvJ+YrwANgDA99D
         lYykLDvGOA84Kwg0Nkoj7lCviKdi4O8IjPHkPlKF+MuFZclaUn2rEKzV2fU7P3p3Qcf1
         heqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695369830; x=1695974630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ef1lz4NaECWVWSkMTH/C2VI1iTg3OW5SLvb2NYIpXHw=;
        b=PV/k1ZZ9kY8LPy1KRmfWtvMVuil6FD06HOg6w8/5WXRoGH86clGOGOxg7Oubcon3O4
         X8oH/kwMEBFYfe02WxmUhVaLpSycUGjOuwiPnEGzkT+MEKaHfC5BXaHWPBIoXV2xHVWa
         ItBSO+CdrQhiIXkVJkdU5PvgzFp7Kq7zhckopHWiV8S/pqQM2Zf02pRjNhE0AT4wuKwX
         B6JNqiC97ZD3EeTjYIviz0Ro3ngutnrrGWRaNMGa7Aff7WpWcTVERXpb+UqnPb25btIE
         z6/10xLI927cCcXrwFa+k5/2A7fhPffvzhCbc3PErF2YQW+x2z6xcBJqu9b6lLXozne/
         DrCQ==
X-Gm-Message-State: AOJu0YyN/oAVkSr0VPXJt72m1q3yx+/2Dfqxqp4Shbr4ZosSN8NVrXYP
        HIy1aqa3BX5n2ZIX4l9Y7sUCpnkp9xD0flS1zGUQbQ==
X-Google-Smtp-Source: AGHT+IE7UI6I9WiH64qEClOouVDFNt1yTkDjY6ASv+xhQWngrbykoKa0FWDxLHcMX+9s76JZ51uHd0M5apwUwqihULw=
X-Received: by 2002:a0c:cd02:0:b0:62f:f2f0:2af3 with SMTP id
 b2-20020a0ccd02000000b0062ff2f02af3mr9041416qvm.41.1695369830373; Fri, 22 Sep
 2023 01:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230720173956.3674987-1-glider@google.com> <20230720173956.3674987-4-glider@google.com>
 <ZLpqXXLLj4vL/xaT@smile.fi.intel.com>
In-Reply-To: <ZLpqXXLLj4vL/xaT@smile.fi.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 22 Sep 2023 10:03:14 +0200
Message-ID: <CAG_fn=XLVQs=PSZVZ9cuh=SbTjG9B0bZsim_2xKDmnju4CHuSA@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] arm64: mte: implement CONFIG_ARM64_MTE_COMP
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 1:22=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Jul 20, 2023 at 07:39:54PM +0200, Alexander Potapenko wrote:
> > The config implements the algorithm compressing memory tags for ARM MTE
> > during swapping.
> >
> > The algorithm is based on RLE and specifically targets 128-byte buffers
> > of tags corresponding to a single page. In the common case a buffer
> > can be compressed into 63 bits, making it possible to store it without
> > additional memory allocation.
>
> ...
>
> > +Programming Interface
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > + .. kernel-doc:: arch/arm64/mm/mtecomp.c
>
> :export:

Done

> > +
>
> Is it dangling trailing blank line? Drop it.

Sorry, it's hard to attribute this comment. I am assuming it is
related to Documentation/arch/arm64/mte-tag-compression.rst - done.

> ...
>
> > +#include <linux/bitmap.h>
>
> > +#include <linux/bitops.h>
>
> This is guaranteed to be included by bitmap.h.

I think we'd better stick to IWYU here.
Ingo's patch: https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git=
/commit/?id=3D32b1e9e4f5774951a3a80604a39fa1f0674c1833
specifically adds bitmap.h where bits.h is already present, without
removing the latter.
Although there might not be general consensus on this in the kernel
right now, I think Ingo's "Fast Kernel Headers" set out a good
direction.

>
> > +/*
> > + * Sizes of compressed values. These depend on MTE_TAG_SIZE and
>
> of the

This comment is gone now

>
> > +     out_tags[0] =3D prev_tag;
>
> out_tags[cur_idx] ?

Yeah, looks more readable. Done.

>
> > +     for (i =3D 0; i < MTE_PAGE_TAG_STORAGE; i++) {
> > +             for (j =3D 0; j < 2; j++) {
> > +                     cur_tag =3D j ? (tags[i] % 16) : (tags[i] / 16);
> > +                     if (cur_tag =3D=3D prev_tag) {
> > +                             out_sizes[cur_idx]++;
>
> > +                     } else {
> > +                             cur_idx++;
> > +                             prev_tag =3D cur_tag;
> > +                             out_tags[cur_idx] =3D prev_tag;
> > +                             out_sizes[cur_idx] =3D 1;
>
> Looking more at this I think there is still a room for improvement. I can=
't
> come up right now with a proposal (lunch time :-), but I would look into
>
>         do {
>                 ...
>         } while (i < MTE_...);
>
> approach.

We can e.g. get rid of the nested loop and iterate over tags instead
of bytes (see v5)


> > +static size_t mte_size_to_ranges(size_t size)
> > +{
> > +     size_t largest_bits;
>
> > +     size_t ret =3D 0;
>
> Redundant assignment. Please, check again all of them.

Done.

> > +
> > +     largest_bits =3D (size =3D=3D 8) ? MTE_BITS_PER_LARGEST_IDX_INLIN=
E :
> > +                                  MTE_BITS_PER_LARGEST_IDX;
> > +     ret =3D (size * 8 + MTE_BITS_PER_SIZE - largest_bits) /
>
> Hmm... I thought that we moved BYTES_TO_BITS() to the generic header...
> Okay, never mind.

Ack

> > +           (MTE_BITS_PER_TAG + MTE_BITS_PER_SIZE);
> > +     return ret;
>
>         return (...) / ...;

Done

> > +}
>
> ...
>
> > +static size_t mte_alloc_size(unsigned int num_ranges)
> > +{
> > +     size_t sizes[4] =3D { 8, 16, 32, 64 };
>
> Hooray! And now it's not needed anymore...
>
> > +     unsigned int i;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(sizes); i++) {
>
> ...as sizes[i] is equivalent of (8 << i).

It's gone now.

> ...
>
> > +/**
> > + * mte_compress() - compress the given tag array.
> > + * @tags: 128-byte array to read the tags from.
> > + *
> > + * Compresses the tags and returns a 64-bit opaque handle pointing to =
the
> > + * tag storage. May allocate memory, which is freed by @mte_release_ha=
ndle().
>
> + blank line here.

Done (here and in other places in the file), but I'm wondering why
https://docs.kernel.org/doc-guide/kernel-doc.html does not mandate it.

>
> > + * Returns: 64-bit tag storage handle.
> > + */
>
> ...
>
> > +     /*
> > +      * mte_compress_to_buf() only initializes the bits that mte_decom=
press()
> > +      * will read. But when the tags are stored in the handle itself, =
it must
> > +      * have all its bits initialized.
> > +      */
> > +     unsigned long result =3D 0;
>
>         // Actually it's interesting how it's supposed to work on 32-bit
>         // builds...

It is not supposed to work on 32 bit.
First, the code is in arch/arm64 :)
Second, 32-bit CPUs do not support MTE (which reserves the four upper
bits of the address)


>
> > +static unsigned long mte_bitmap_read(const unsigned long *bitmap,
> > +                                  unsigned long *pos, unsigned long bi=
ts)
> > +{
> > +     unsigned long result;
> > +
> > +     result =3D bitmap_read(bitmap, *pos, bits);
> > +     *pos +=3D bits;
> > +     return result;
>
>         unsigned long start =3D *pos;
>
>         *pos +=3D bits;
>         return bitmap_read(bitmap, start, bits);

Done, thanks!

> > +}
>
> ...
>
> > +     unsigned short r_sizes[46], sum =3D 0;
>
> See below.
>
> ...
>
> It's cleaner and more robust to have
>
>         sum =3D 0;
>
> here.

Moved it inside the loop init statement


> --
> With Best Regards,
> Andy Shevchenko
>

Thank you!
