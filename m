Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710F07E4619
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjKGQeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjKGQek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:34:40 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AC68F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 08:34:38 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-66d190a8f87so37439766d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 08:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699374878; x=1699979678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w06lyDe6FRUqEZy0wKhzujIf+G9hzUJIKZxKL1OYVBE=;
        b=RPTzDHKgNoa17aK6PMgVBH5diOG6nMJj+snW6PkIfZ80qEqex5w7bwt+AQAwEOwBgC
         tFDapuzkTMPbNVOUAa9bnwceGFFkd1q+I+I+u/AAn/K0VLrzNhSk0Bw5wbb/BXS9DY6T
         zs1Uj/L9YkgtJgWt41WrSmbCQEtBitqFTBHCe1OF1IPYSxFYMQEwAtIghrqdvhZAnkKf
         QsAgTAVyINA5E7+ay3z+U2l4OyJlDGOfHgniw0Hi5NqoApVRAI7EXMrMx63wrS7PCazC
         03L+wZmlD5A7K9yfvgSwKfm2/A0DFP5RN53drJC/DlXUqolDNxU1shpvhYRXDnhAa/yP
         cX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699374878; x=1699979678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w06lyDe6FRUqEZy0wKhzujIf+G9hzUJIKZxKL1OYVBE=;
        b=JIx9KPlwTGD4H7GzoDw/NMZwWOU5opJd8WuWgTVqDvXTnN4fsWjEzuK2oj71V0c64X
         wZ7WSz7xwoX6o1MPQsReAYlr/xeY1oWukwo7oIamZdF1kuObNIhp/GTMMOxi3QRNCu5u
         NReOAM+9468KN6x+zakEZp+ns2lfYzXNUyrP/ZkCe1eoADENuOdWetw3DZ46XHHjqdpr
         RjUoN0P57MGyYdXFCB3bAjd1XkRX0jXoYKYO9mqvr0UabNuiAdqPaN3jej22iTQHRA48
         kRu6Hb1+SnHQLwLOpiW+HnFZUc3mktDMXe1cDCHyD4fOXAUMPufi2MLzPYamj5R6UtsW
         Ojqg==
X-Gm-Message-State: AOJu0Ywmgjsv+HHHIjVZfi3kwW2lPcEU7lfYboIuMLZ2NWGQkLT8Im4Z
        fiElF0vimorrRIGWAOf3cg+S9kOcTI+DVX07G9CK4Q==
X-Google-Smtp-Source: AGHT+IFK0kWZ26eo1pcAnj94JOyclSPQI1IoZydFC0YpkOnGjdOwwfvZz8lU/TRnwBA8gFCRirwUDeY7VPaiK6/YRp0=
X-Received: by 2002:a05:6214:d06:b0:670:710f:203a with SMTP id
 6-20020a0562140d0600b00670710f203amr32230386qvh.59.1699374877902; Tue, 07 Nov
 2023 08:34:37 -0800 (PST)
MIME-Version: 1.0
References: <202310170708.fJzLlgDM-lkp@intel.com> <bd7fe929-c6fc-42be-9d2f-3f53ec21fd10@intel.com>
 <ZUkvOCxyiin_77qd@smile.fi.intel.com> <0a29df6b-bc27-43e9-a97d-57ecabb29a9e@intel.com>
In-Reply-To: <0a29df6b-bc27-43e9-a97d-57ecabb29a9e@intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 7 Nov 2023 17:33:56 +0100
Message-ID: <CAG_fn=VtA6e3oGm4WVnxmy9yMBab780-U_4VoHSqm4tcd2UTzQ@mail.gmail.com>
Subject: Re: [alobakin:pfcp 11/19] include/linux/bitmap.h:642:17: warning:
 array subscript [1, 1024] is outside array bounds of 'long unsigned int[1]'
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        kernel test robot <lkp@intel.com>,
        oe-kbuild-all@lists.linux.dev,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 7, 2023 at 2:23=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Date: Mon, 6 Nov 2023 20:23:52 +0200
>
> > On Mon, Nov 06, 2023 at 05:31:34PM +0100, Alexander Lobakin wrote:
> >
> >>> | Reported-by: kernel test robot <lkp@intel.com>
> >>> | Closes: https://lore.kernel.org/oe-kbuild-all/202310170708.fJzLlgDM=
-lkp@intel.com/
> >
> >> Not sure how to approach this :z It was also captured on the version y=
ou
> >> sent 2 weeks ago, so this could've been resolved already.
> >
> > Is it in the repository already? if so, we should revert it.
> > Otherwise you have time to think and fix.
>
> Nah, neither Alex' series nor mine. And I'd say this should rather be
> resolved in the functions Alex introduce.
>
> Thanks,
> Olek

Sorry, I couldn't reproduce the problem using the instructions at
https://download.01.org/0day-ci/archive/20231017/202310170708.fJzLlgDM-lkp@=
intel.com/reproduce
locally, maybe that's because I only have gcc-11 and higher.

But if I'm understanding correctly what's going on, then GCC will be
reporting the same issue in the following code:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
#include <stddef.h>
#include <stdbool.h>

#define BITS_PER_LONG 64
#define unlikely(x) x
#define UL(x) (x##UL)
#define GENMASK(h, l) \
        (((~UL(0)) - (UL(1) << (l)) + 1) & \
         (~UL(0) >> (BITS_PER_LONG - 1 - (h))))

#define BIT_WORD(nr)            ((nr) / BITS_PER_LONG)
#define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - =
1)))
#define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - =
1)))

inline void bitmap_write(unsigned long *map,
                                unsigned long value,
                                unsigned long start, unsigned long nbits)
{
        size_t index;
        unsigned long offset;
        unsigned long space;
        unsigned long mask;
        bool fit;

        if (unlikely(!nbits))
                return;

        mask =3D BITMAP_LAST_WORD_MASK(nbits);
        value &=3D mask;
        offset =3D start % BITS_PER_LONG;
        space =3D BITS_PER_LONG - offset;
        fit =3D space >=3D nbits;
        index =3D BIT_WORD(start);

        map[index] &=3D (fit ? (~(mask << offset)) :
~BITMAP_FIRST_WORD_MASK(start));
        map[index] |=3D value << offset;
        if (fit)
                return;

        map[index + 1] &=3D BITMAP_FIRST_WORD_MASK(start + nbits);
        map[index + 1] |=3D (value >> space);
}

unsigned long foo(unsigned int n) {
    unsigned long bm[1] =3D {0};
    bitmap_write(bm, 1, n, 2);
    return bm[0];
}
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
(see also https://godbolt.org/z/GfGfYje53)

If so, the problem is not specific to GCC 9, trunk GCC also barks on this c=
ode:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
In function 'bitmap_write',
    inlined from 'bitmap_write' at <source>:15:13,
    inlined from 'foo' at <source>:47:7:
<source>:40:12: warning: array subscript 1 is outside array bounds of
'long unsigned int[1]' [-Warray-bounds=3D]
   40 |         map[index + 1] &=3D BITMAP_FIRST_WORD_MASK(start + nbits);
      |         ~~~^~~~~~~~~~~
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

If this is true for the code in drivers/gpio/gpio-pca953x.c,
suppressing the report for GCC 9 won't help for other versions.
Given that this report is isolated in a single file, we probably need
to give the compiler some hints about the range of values passed to
bitmap_write() rather than suppressing the optimizations.

--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
