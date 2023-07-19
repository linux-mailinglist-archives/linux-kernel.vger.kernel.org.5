Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4599C7594E6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 14:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjGSMRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 08:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjGSMRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 08:17:03 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCFE1A6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 05:17:02 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-7837329a00aso355582939f.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 05:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689769021; x=1692361021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gtzzKVAHhLWtmgTgEKFVuZjkd6mBq2VLjXUP1sGUb8=;
        b=dq9bsg67nAqSPjInMf+84OSvtQG8sh1KeCbIhpcGV3O6YNFe+deEvYCJoF8x1oVy6f
         r3iX0k2fRvKdHEutbQNYoqgZb8g/WVAEnZipJqlsfyOkzGzrqBTnuolaiVZL3zfyrRHd
         mz14hMh3h9Fa7vvKrSfTlJSq4FwwqAJIU6I1PxZcPW1Sujo6lu6/0bbxU2TtAwengeJR
         YaU4+nh0oA/oN2Z+EC4ZhPY3tZxdkPuLy/7uPu/hPf/IElyLUVubgZkK0O1DVW6SDoEg
         JGO1qqzNvb94Nm3+OEkmqrHkhxm6djmiyBNk001fX8GAJl3QEjUajobvDCMkr91CMqSK
         NgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689769021; x=1692361021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9gtzzKVAHhLWtmgTgEKFVuZjkd6mBq2VLjXUP1sGUb8=;
        b=dBzSUUBcakbVGq8s9BVZOA9rB/O0XPyebmt5Dq6C+gOcEZHEnB79hhqgn3puyeCkFw
         9uxPQd7pMVs8DgrrVRRVI6vvVy2GRXKLyYijSRLIgiDHtNyBvykBgPiDvNJeZAvtlTos
         92qkLZT9gblb6+Levrl+xgZmjl9riSrqSqs8ESaWq6xPiTDR4VgQrgVPcVGIRnut57FD
         3SPinTqVWNT32I0vNxJMKCX3BMWmUmhzikqPH06q9HJeaU9dqWCZNOVKBF2cDz2PU1+g
         YkCNW4SVzZby4IsT+/FZuUDtyE+DwoVGemfoJFeEZhwv0k8fiaJwi92fBC11hsUaZyBf
         w14w==
X-Gm-Message-State: ABy/qLZ/omHF39AFqPYWBAAabag0eJrYlyONuIMoYrfKlif47GL82Tgy
        tzd29DH6siJ2HVOlQUMNxB/9jk6TQWwcKNakXRSVIA==
X-Google-Smtp-Source: APBJJlGobHCSraSUpFBD8/1E4av4Xn5ZLlbDCQ34Uyxde51yfGhozPsyHii1Fmv4Xg3kHXPEJFJjliX8gMYFyIQQUmM=
X-Received: by 2002:a5d:9419:0:b0:780:ce89:ca73 with SMTP id
 v25-20020a5d9419000000b00780ce89ca73mr2251970ion.14.1689769021561; Wed, 19
 Jul 2023 05:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230717113709.328671-1-glider@google.com> <20230717113709.328671-4-glider@google.com>
 <ZLVG7GCTTBV4odAG@smile.fi.intel.com> <CAG_fn=XvoKjYpS2VPnSYBC3t7p7U-M_bfXohbXSvkepzS=6Tvg@mail.gmail.com>
 <ZLbJPwdFCdSeur6k@smile.fi.intel.com>
In-Reply-To: <ZLbJPwdFCdSeur6k@smile.fi.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 19 Jul 2023 14:16:24 +0200
Message-ID: <CAG_fn=XDt1OqWFC4SeagSGCjnHa2mEnC8ri4Ecx75Me1PdowrA@mail.gmail.com>
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 7:18=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> > However it doesn't seem to be very picky.
> >
> >   $ scripts/kernel-doc -v  -none arch/arm64/include/asm/mtecomp.h
> >
> > warns about e.g. parameter name mismatch, but does not care about the
> > missing return section.
>
> -Wreturn is missing

Nice, adding it (or -Wall) uncovered more problems.

> ...
>
> > > Also
> > > why you put the descriptions in to the header file? It's a bit unusua=
l for the
> > > exported ones.
> >
> > https://docs.kernel.org/doc-guide/kernel-doc.html was not specific on
> > this, and I thought anyone wanting to understand how an interface
> > works would prefer reading the header rather than the implementation.
> > I can move the comments to arch/arm64/mm/mtecomp.c if you think it's a
> > better place for them.
>
> With the kernel doc in the C file you may also comment the internal ones =
and
> generate documentation only for exported ones. This is not possible with =
h.

I see.
After some hesitation and looking at the existing practices in the
kernel, I moved the kernel doc comments to mtecomp.c



> > but all those values are >=3D 0
> > and <=3D 256, so there should be no problems.
> > (shorts could have been ints as well, we are just saving some stack
> > space in ea0_compress()/ea0_decompress()).
>
> Then why they are signed? Please, justify that.
> Signdness prone to subtle and hard to hunt errors due to integer promotio=
ns.

Switched to unsigned shorts.

> ...
>
> > > > +#include <linux/bits.h>
> > > > +#include <linux/bitmap.h>
> > >
> > > bitmap guarantees that bits.h will be included.
> >
> > I am following the IWYU principle here, and I believe it's a good thing=
 to do.
> > I've seen cases where these transitive dependencies rotted after some
> > refactoring, but the fact was only noticed in certain configurations.
> > Also, there's an ongoing work by Ingo Molnar to speed up kernel builds
> > by optimizing headers
> > (https://lwn.net/ml/linux-kernel/YdIfz+LMewetSaEB@gmail.com/), and it
> > relies on explicit dependencies which are easier to untangle.
>
> Yes, but we have some guarantees. E.g., we don't include compiler*.h
> when types.h is included, because of the guarantees.
Ok, I removed bits.h

> Otherwise your code misses _a lot_ of headers.

... and tried to expand the list of headers where applicable.

>
> ...
>
> > > Can you make it unsigned and start from 0?
> >
> > Changed to start with 0, but I am a bit hesitant about making it
> > unsigned: it is now no more special than a loop variable.
>
> Signdness is a beast in C, needs always an additional justification.

Changed all ints to unsigned, because, well, why not :)


> > Shall I undef the constants above as well (e.g. BITS_PER_TAG)?
> > The intuitive answer is "no",
>
> Correct.
>
> > but then there should be some difference between those and RANGES_INLIN=
E?
>
> Yes, one is widely used constant and one is a _localized_ helper.

Ack

>
> ...
>
> > > > +static void bitmap_write(unsigned long *bitmap, unsigned long valu=
e,
> > > > +                      unsigned long *pos, unsigned long bits)
> > >
> > > Please, don't use reserved namespace. Yours is ea0, use it:
> > > ea0_bitmap_write()! Same to other similarly named functions.
> >
> > Done.
> > However there are two parallel namespaces now: "ea0" for the
> > compression algorithm, and "memcomp" for the module initialization and
> > data structures.
> > Dunno if it makes sense to merge them (and rename the .c file according=
ly).
>
> Your choice. Mu point, just do prefix it with something meaningful.
Fine, I'll go with "ea0" for the algorithm and "memcomp" for the
module-specific stuff.
Let's also see what ARM maintainers say.

> ...
>
> > > > +     u8 r_tags[256];
> > > > +     int r_len =3D ARRAY_SIZE(r_tags);
> > >
> > No, it is the length of the arrays (both r_tags and r_sizes).
> > Below you make a good point it will spare us a kernel.h dependency,
> > but for the sake of keeping the code error-prone we probably shouldn't
> > assume r_tags is a byte array.
>
> It's a common practice even outside of Linux kernel to use sizeof() again=
st
> char arrays. I don't see the point to have the ARRAY_SIZE() complication =
here.

Fixed.

> ...
>
> > > > +             snprintf(name, ARRAY_SIZE(name), "mte-tags-%d", size)=
;
>
> You see, if you grep for similar calls I'm pretty sure the order of 2 of =
power
> of 10 will be the difference between sizeof()/ARRAY_SIZE() if the latter =
even
> occurs at least once.

You are right, it is 3700+ vs. 66 :)
Changed ARRAY_SIZE() to sizeof() here as well.
