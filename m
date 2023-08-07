Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD92772A5E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjHGQSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjHGQSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:18:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE2F10E3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691425061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f+TOwkD920NNblLgbScyx3AiTipyCC5JcEGUcFdBUPs=;
        b=QP/v9hKMM9+R0Pp/4ZFCOLCxvcAPYs9SXpITRRb74ncS0vNXIkTz6JqxEEztNeS6+Mkiy9
        Usg0G/NabyTVuovNdiG6UiFc7V0eEXOhezQ8C901c0o2cZi5DkffD2CIFPH6K1/m5U6Wld
        LBfnkzhIFO7XjhicQAMuuWlA4wPtbRI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-rtAcrjWdNI2ShbD_mTbAbw-1; Mon, 07 Aug 2023 12:17:37 -0400
X-MC-Unique: rtAcrjWdNI2ShbD_mTbAbw-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-40c10c73650so54861731cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:17:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691425057; x=1692029857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f+TOwkD920NNblLgbScyx3AiTipyCC5JcEGUcFdBUPs=;
        b=CGnLinj0zPJZnKlaQ43FAYHzfopTuPRqHErueh0Zl2dUX3OSMnADwunDNWrBvW/aCe
         1hcjNUj3Ywfy83CpCUtnPEL0cEeTgM6no8ESJbuDCIBIo3BDDB46i689fXlz9zGyPQh0
         /x9CWXaA4dTNZEURiJlZlsRuwL6ZD5WD4HPM2Y3O/jL1D+t29jXWq8sWsWJkMUEwoR2e
         QiPzMilupd9AANWo2tDl1orMTN+GVdrzcvs/WFwExYm3DHIQz/wme8twhcW9JtfI22z0
         6HNM01hdrs0IoBW5Y8eMRa3drYnKyNuU7/ZTUR7itdRE6ZnhkxLGb/S0bRom8HEz6aVg
         tqNw==
X-Gm-Message-State: AOJu0YxOtL0et5lUqONEpXlUEETlxEiUKTQniNLtrn1RbPu4tTeuO22b
        E+MFp8loGFd6CGjNuljaqpV0z31TiPQLFWLM1AuYqbdjpqecD/yeXpu/4bPDRr03nfj7PimkkeM
        ZWAMaEAVjAdZfzjesP/S/IwDkwO7zE3N95WO4le1y
X-Received: by 2002:ac8:5a45:0:b0:403:72fa:62fc with SMTP id o5-20020ac85a45000000b0040372fa62fcmr12784376qta.68.1691425057283;
        Mon, 07 Aug 2023 09:17:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlzwO53YEgQjvZs9+YZkXcApeDo8pVppvR3nJ2N8I8AKCEXc4gO89XVeJx6MYXSmefpt5g6JVcXHnFRGRxlSI=
X-Received: by 2002:ac8:5a45:0:b0:403:72fa:62fc with SMTP id
 o5-20020ac85a45000000b0040372fa62fcmr12784353qta.68.1691425056956; Mon, 07
 Aug 2023 09:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230804084900.1135660-2-leobras@redhat.com> <20230804084900.1135660-6-leobras@redhat.com>
 <CAJF2gTTOT3_3K_cWNY9n_DgRoPhYEhBLno=bh57r9D--OavREQ@mail.gmail.com>
 <CAJ6HWG4gy7HV11-cdoB0VAP2z1Zw-zyJhNRpJ1eDMmrkvnob3w@mail.gmail.com> <CAJF2gTQY5RX87Zo8HcM1Og-Oc6vd5Vyj97KL-o6UcqMaT4oxng@mail.gmail.com>
In-Reply-To: <CAJF2gTQY5RX87Zo8HcM1Og-Oc6vd5Vyj97KL-o6UcqMaT4oxng@mail.gmail.com>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Mon, 7 Aug 2023 13:17:22 -0300
Message-ID: <CAJ6HWG4apf5D_H43Kf7+E9pA1UmcFe1mV6YGuvk0Q9SH_ZFDdw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 4/5] riscv/cmpxchg: Implement cmpxchg for variables
 of size 1 and 2
To:     Guo Ren <guoren@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 5, 2023 at 1:24=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote:
>
> On Sat, Aug 5, 2023 at 11:14=E2=80=AFAM Leonardo Bras Soares Passos
> <leobras@redhat.com> wrote:
> >
> > Hello Guo Ren, thanks for the feedback!
> >
> > On Fri, Aug 4, 2023 at 2:45=E2=80=AFPM Guo Ren <guoren@kernel.org> wrot=
e:
> > >
> > > On Fri, Aug 4, 2023 at 4:49=E2=80=AFAM Leonardo Bras <leobras@redhat.=
com> wrote:
> > > >
> > > > cmpxchg for variables of size 1-byte and 2-bytes is not yet availab=
le for
> > > > riscv, even though its present in other architectures such as arm64=
 and
> > > > x86. This could lead to not being able to implement some locking me=
chanisms
> > > > or requiring some rework to make it work properly.
> > > >
> > > > Implement 1-byte and 2-bytes cmpxchg in order to achieve parity wit=
h other
> > > > architectures.
> > > >
> > > > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > > > ---
> > > >  arch/riscv/include/asm/cmpxchg.h | 35 ++++++++++++++++++++++++++++=
++++
> > > >  1 file changed, 35 insertions(+)
> > > >
> > > > diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/=
asm/cmpxchg.h
> > > > index 5a07646fae65..dfb433ac544f 100644
> > > > --- a/arch/riscv/include/asm/cmpxchg.h
> > > > +++ b/arch/riscv/include/asm/cmpxchg.h
> > > > @@ -72,6 +72,36 @@
> > > >   * indicated by comparing RETURN with OLD.
> > > >   */
> > > >
> > > > +#define __arch_cmpxchg_mask(sc_sfx, prepend, append, r, p, o, n)  =
     \
> > > > +({                                                                =
     \
> > > > +       /* Depends on 2-byte variables being 2-byte aligned */     =
     \
> > > > +       ulong __s =3D ((ulong)(p) & 0x3) * BITS_PER_BYTE;          =
       \
> > > > +       ulong __mask =3D GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1=
, 0)   \
> > > > +                       << __s;                                    =
     \
> > > > +       ulong __newx =3D (ulong)(n) << __s;                        =
       \
> > > > +       ulong __oldx =3D (ulong)(o) << __s;                        =
       \
> > > > +       ulong __retx;                                              =
     \
> > > > +       register unsigned int __rc;                                =
     \
> > > > +                                                                  =
     \
> > > > +       __asm__ __volatile__ (                                     =
     \
> > > > +               prepend                                            =
     \
> > > > +               "0:     lr.w %0, %2\n"                             =
     \
> > > > +               "       and  %0, %0, %z5\n"                        =
     \
> > > > +               "       bne  %0, %z3, 1f\n"                        =
     \
> >
> > > bug:
> > > -               "       and  %0, %0, %z5\n"                          =
   \
> > > -               "       bne  %0, %z3, 1f\n"                          =
   \
> > > +               "       and  %1, %0, %z5\n"                          =
   \
> > > +               "       bne  %1, %z3, 1f\n"                          =
   \
> > > Your code breaks the %0.
> >
> > What do you mean by breaks here?
> >
> > In the end of this macro, I intended  to have __retx =3D (*p & __mask)
> > which means the value is clean to be rotated at the end of the macro
> > (no need to apply the mask again): r =3D __ret >> __s;
> >
> > Also, I assumed we are supposed to return the same variable type
> > as the pointer, so this is valid:
> > u8 a, *b, c;
> > a =3D xchg(b, c);
> >
> > Is this correct?
> I missed your removing "__ret & mask" at the end. So this may not the pro=
blem.
>
> Your patch can't boot. After chewing your code for several hours, I
> found a problem:
> diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cm=
pxchg.h
> index 943f094375c7..67bcce63b267 100644
> --- a/arch/riscv/include/asm/cmpxchg.h
> +++ b/arch/riscv/include/asm/cmpxchg.h
> @@ -14,6 +14,7 @@
>  #define __arch_xchg_mask(prepend, append, r, p, n)                     \
>  ({                                                                     \
>         /* Depends on 2-byte variables being 2-byte aligned */          \
> +       volatile ulong *__p =3D (ulong *)((ulong)(p) & ~0x3);            =
 \

Wow, I totally missed this one: I should not assume the processor
behavior on unaligned lr/sc.
Thanks for spotting this :)

>         ulong __s =3D ((ulong)(p) & 0x3) * BITS_PER_BYTE;                =
 \
>         ulong __mask =3D GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)  =
 \
>                         << __s;                                         \
> @@ -29,7 +30,7 @@
>                "        sc.w %1, %1, %2\n"                              \
>                "        bnez %1, 0b\n"                                  \
>                append                                                   \
> -              : "=3D&r" (__retx), "=3D&r" (__rc), "+A" (*(p))           =
   \
> +              : "=3D&r" (__retx), "=3D&r" (__rc), "+A" (*(__p))         =
   \
>                : "rJ" (__newx), "rJ" (~__mask)                          \
>                : "memory");                                             \
>                                                                         \
> @@ -106,6 +107,7 @@
>  #define __arch_cmpxchg_mask(sc_sfx, prepend, append, r, p, o, n)       \
>  ({                                                                     \
>         /* Depends on 2-byte variables being 2-byte aligned */          \
> +       volatile ulong *__p =3D (ulong *)((ulong)(p) & ~0x3);            =
 \
>         ulong __s =3D ((ulong)(p) & 0x3) * BITS_PER_BYTE;                =
 \
>         ulong __mask =3D GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)  =
 \
>                         << __s;                                         \
> @@ -125,7 +127,7 @@
>                 "       bnez %1, 0b\n"                                  \
>                 append                                                  \
>                 "1:\n"                                                  \
> -               : "=3D&r" (__retx), "=3D&r" (__rc), "+A" (*(p))          =
   \
> +               : "=3D&r" (__retx), "=3D&r" (__rc), "+A" (*(__p))        =
   \
>                 : "rJ" ((long)__oldx), "rJ" (__newx),                   \
>                   "rJ" (__mask), "rJ" (~__mask)                         \
>                 : "memory");                                            \
>
> But the lkvm-static still can't boot with paravirt_spinlock .... Are
> there any atomic tests in the Linux?

I recall reading something about 'locktorture' or so, not sure if useful:

https://docs.kernel.org/locking/locktorture.html

>
> I found you use some "register int variables". Would it cause the problem=
?

Honestly, not sure.
I will try inspecting the generated asm for any unexpected changes
compared to your version.

>
> You can reference this file, and it has passed the lock torture test:
> https://github.com/guoren83/linux/blob/sg2042-master-qspinlock-64ilp32_v4=
/arch/riscv/include/asm/cmpxchg.h
>
> I also merged your patches with the qspinlock series: (Use the above
> cmpxchg.h the lkvm would run normally.)
> https://github.com/guoren83/linux/tree/qspinlock_v11

Thanks!

I should reply as soon as I find anything.

Best regards,
Leo

>
>
>
> >
> > > > +               append                                             =
     \
> > > > +               "1:\n"                                             =
     \
> > > > +               : "=3D&r" (__retx), "=3D&r" (__rc), "+A" (*(p))    =
         \
> > > > +               : "rJ" ((long)__oldx), "rJ" (__newx),              =
     \
> > > > +                 "rJ" (__mask), "rJ" (~__mask)                    =
     \
> > > > +               : "memory");                                       =
     \
> > > > +                                                                  =
     \
> > > > +       r =3D (__typeof__(*(p)))(__retx >> __s);                   =
       \
> > > > +})
> > > > +
> > > >
> > > >  #define __arch_cmpxchg(lr_sfx, sc_sfx, prepend, append, r, p, co, =
o, n)        \
> > > >  ({                                                                =
     \
> > > > @@ -98,6 +128,11 @@
> > > >         __typeof__(*(ptr)) __ret;                                  =
     \
> > > >                                                                    =
     \
> > > >         switch (sizeof(*__ptr)) {                                  =
     \
> > > > +       case 1:                                                    =
     \
> > > > +       case 2:                                                    =
     \
> > > > +               __arch_cmpxchg_mask(sc_sfx, prepend, append,       =
     \
> > > > +                                       __ret, __ptr, __old, __new)=
;    \
> > > > +               break;                                             =
     \
> > > >         case 4:                                                    =
     \
> > > >                 __arch_cmpxchg(".w", ".w" sc_sfx, prepend, append, =
     \
> > > >                                 __ret, __ptr, (long), __old, __new)=
;    \
> > > > --
> > > > 2.41.0
> > > >
> > >
> > >
> > > --
> > > Best Regards
> > >  Guo Ren
> > >
> >
>
>
> --
> Best Regards
>  Guo Ren
>

