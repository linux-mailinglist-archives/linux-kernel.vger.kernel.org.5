Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE94778574
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 04:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjHKCcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 22:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjHKCcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 22:32:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23ACEFD
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 19:32:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 950E764FEE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 02:32:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E821BC4339A
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 02:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691721153;
        bh=1O2EkKWN0fBrlXwFDWEwEBAVx35c3sa5eNkkkPDulEc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uTcB86dybTriqYgj4NaBeE7ZthHzCIibli3onludahJNNwwIm5Glk3HH4l1LT3m63
         TCxQ6LV3vcGBVkum597TuGHk9Cl2bZdwlpw47ywd7KZNAEgXj9kijF4O0I/kbV4rVG
         yzYxdEIl2QvVFl3b1o46OpM1plHnMGnGyIv7lNjDDo75Uw8BipMErjMqmYKuzPc71f
         8QbthQTzY7ANYkA9Y3fHKPwOuF8Y/acb/dXphKe3AWp5374z2bp0v7UMUdvw89k0Qb
         Li7l2jZFSJRPCEvg7ba2HWdvrCsS83uxQyAiNh2dtGVPQ13dpXqJEHJT67eL0n4raz
         vVlo18ATEb/Hg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4fe28e4671dso2430954e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 19:32:32 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx7bTPNzxiNWbeL+o0fyzsTEls3/5bHfqLttUwQuJQMDznnTU74
        9eXbq3mC7brHZ4KXTntfWA3HnXsrygQgo9uBDes=
X-Google-Smtp-Source: AGHT+IHApNSq9qLw4AN3on+YlAHfUS0hg7jqDpvMiLiFodzW9iSeP6Mzk3Yk6ll1sQHCOUOY1RMkk2OXqfAuGQ9Uk5o=
X-Received: by 2002:a05:6512:2206:b0:4fe:993:2218 with SMTP id
 h6-20020a056512220600b004fe09932218mr433949lfu.31.1691721150769; Thu, 10 Aug
 2023 19:32:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230804084900.1135660-2-leobras@redhat.com> <20230804084900.1135660-6-leobras@redhat.com>
 <CAJF2gTTOT3_3K_cWNY9n_DgRoPhYEhBLno=bh57r9D--OavREQ@mail.gmail.com>
 <CAJ6HWG4gy7HV11-cdoB0VAP2z1Zw-zyJhNRpJ1eDMmrkvnob3w@mail.gmail.com>
 <CAJF2gTQY5RX87Zo8HcM1Og-Oc6vd5Vyj97KL-o6UcqMaT4oxng@mail.gmail.com>
 <CAJ6HWG4apf5D_H43Kf7+E9pA1UmcFe1mV6YGuvk0Q9SH_ZFDdw@mail.gmail.com> <CAJ6HWG5mZTYsMAMVx9itUYNK2TOXZjAFOW=-Nzwi3q+yB2V3vQ@mail.gmail.com>
In-Reply-To: <CAJ6HWG5mZTYsMAMVx9itUYNK2TOXZjAFOW=-Nzwi3q+yB2V3vQ@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 11 Aug 2023 10:32:19 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSHg2Ww+S-E+OrsSV+NWRom1xJD=b0ZgxRTZ_o4LgnwcQ@mail.gmail.com>
Message-ID: <CAJF2gTSHg2Ww+S-E+OrsSV+NWRom1xJD=b0ZgxRTZ_o4LgnwcQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 4/5] riscv/cmpxchg: Implement cmpxchg for variables
 of size 1 and 2
To:     Leonardo Bras Soares Passos <leobras@redhat.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 9, 2023 at 10:03=E2=80=AFAM Leonardo Bras Soares Passos
<leobras@redhat.com> wrote:
>
> Hello Guo Ren,
>
> On Mon, Aug 7, 2023 at 1:17=E2=80=AFPM Leonardo Bras Soares Passos
> <leobras@redhat.com> wrote:
> >
> > On Sat, Aug 5, 2023 at 1:24=E2=80=AFAM Guo Ren <guoren@kernel.org> wrot=
e:
> > >
> > > On Sat, Aug 5, 2023 at 11:14=E2=80=AFAM Leonardo Bras Soares Passos
> > > <leobras@redhat.com> wrote:
> > > >
> > > > Hello Guo Ren, thanks for the feedback!
> > > >
> > > > On Fri, Aug 4, 2023 at 2:45=E2=80=AFPM Guo Ren <guoren@kernel.org> =
wrote:
> > > > >
> > > > > On Fri, Aug 4, 2023 at 4:49=E2=80=AFAM Leonardo Bras <leobras@red=
hat.com> wrote:
> > > > > >
> > > > > > cmpxchg for variables of size 1-byte and 2-bytes is not yet ava=
ilable for
> > > > > > riscv, even though its present in other architectures such as a=
rm64 and
> > > > > > x86. This could lead to not being able to implement some lockin=
g mechanisms
> > > > > > or requiring some rework to make it work properly.
> > > > > >
> > > > > > Implement 1-byte and 2-bytes cmpxchg in order to achieve parity=
 with other
> > > > > > architectures.
> > > > > >
> > > > > > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > > > > > ---
> > > > > >  arch/riscv/include/asm/cmpxchg.h | 35 ++++++++++++++++++++++++=
++++++++
> > > > > >  1 file changed, 35 insertions(+)
> > > > > >
> > > > > > diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/incl=
ude/asm/cmpxchg.h
> > > > > > index 5a07646fae65..dfb433ac544f 100644
> > > > > > --- a/arch/riscv/include/asm/cmpxchg.h
> > > > > > +++ b/arch/riscv/include/asm/cmpxchg.h
> > > > > > @@ -72,6 +72,36 @@
> > > > > >   * indicated by comparing RETURN with OLD.
> > > > > >   */
> > > > > >
> > > > > > +#define __arch_cmpxchg_mask(sc_sfx, prepend, append, r, p, o, =
n)       \
> > > > > > +({                                                            =
         \
> > > > > > +       /* Depends on 2-byte variables being 2-byte aligned */ =
         \
> > > > > > +       ulong __s =3D ((ulong)(p) & 0x3) * BITS_PER_BYTE;      =
           \
> > > > > > +       ulong __mask =3D GENMASK(((sizeof(*p)) * BITS_PER_BYTE)=
 - 1, 0)   \
> > > > > > +                       << __s;                                =
         \
> > > > > > +       ulong __newx =3D (ulong)(n) << __s;                    =
           \
> > > > > > +       ulong __oldx =3D (ulong)(o) << __s;                    =
           \
> > > > > > +       ulong __retx;                                          =
         \
> > > > > > +       register unsigned int __rc;                            =
         \
> > > > > > +                                                              =
         \
> > > > > > +       __asm__ __volatile__ (                                 =
         \
> > > > > > +               prepend                                        =
         \
> > > > > > +               "0:     lr.w %0, %2\n"                         =
         \
>
>       bne  %0, %z3, 1f\n"                             \
> > > >
> > > > > bug:
> > > > > -               "       and  %0, %0, %z5\n"                      =
       \
> > > > > -               "       bne  %0, %z3, 1f\n"                      =
       \
> > > > > +               "       and  %1, %0, %z5\n"                      =
       \
> > > > > +               "       bne  %1, %z3, 1f\n"                      =
       \
> > > > > Your code breaks the %0.
> > > >
> > > > What do you mean by breaks here?
> > > >
> > > > In the end of this macro, I intended  to have __retx =3D (*p & __ma=
sk)
> > > > which means the value is clean to be rotated at the end of the macr=
o
> > > > (no need to apply the mask again): r =3D __ret >> __s;
> > > >
> > > > Also, I assumed we are supposed to return the same variable type
> > > > as the pointer, so this is valid:
> > > > u8 a, *b, c;
> > > > a =3D xchg(b, c);
> > > >
> > > > Is this correct?
> > > I missed your removing "__ret & mask" at the end. So this may not the=
 problem.
>
> It was actually the problem :)
> Even though I revised a lot, I was missing this which was made clear
> by test-running on a VM:
>
>         "0:    lr.w %0, %2\n"                    \
>         "    and  %0, %0, %z5\n"                \
>         "    bne  %0, %z3, 1f\n"                \
>         "    and  %1, %0, %z6\n"                \
>         "    or   %1, %1, %z4\n"                \
>         "    sc.w" sc_sfx " %1, %1, %2\n"            \
>         "    bnez %1, 0b\n"
>
> If I do "and %0, %0, %z5" there, the line  "and  %1, %0, %z6"  will
> output %1 =3D 0, which is not the intended.
> You were right! The above fix solves the issue, and I just have to
> mask it after.
>
> Sorry it took me a few days to realize this.
Great jot! I would test your 5th patch series, thx.

>
>
> > >
> > > Your patch can't boot. After chewing your code for several hours, I
> > > found a problem:
> > > diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/as=
m/cmpxchg.h
> > > index 943f094375c7..67bcce63b267 100644
> > > --- a/arch/riscv/include/asm/cmpxchg.h
> > > +++ b/arch/riscv/include/asm/cmpxchg.h
> > > @@ -14,6 +14,7 @@
> > >  #define __arch_xchg_mask(prepend, append, r, p, n)                  =
   \
> > >  ({                                                                  =
   \
> > >         /* Depends on 2-byte variables being 2-byte aligned */       =
   \
> > > +       volatile ulong *__p =3D (ulong *)((ulong)(p) & ~0x3);        =
     \
> >
> > Wow, I totally missed this one: I should not assume the processor
> > behavior on unaligned lr/sc.
> > Thanks for spotting this :)
> >
> > >         ulong __s =3D ((ulong)(p) & 0x3) * BITS_PER_BYTE;            =
     \
> > >         ulong __mask =3D GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, =
0)   \
> > >                         << __s;                                      =
   \
> > > @@ -29,7 +30,7 @@
> > >                "        sc.w %1, %1, %2\n"                           =
   \
> > >                "        bnez %1, 0b\n"                               =
   \
> > >                append                                                =
   \
> > > -              : "=3D&r" (__retx), "=3D&r" (__rc), "+A" (*(p))       =
       \
> > > +              : "=3D&r" (__retx), "=3D&r" (__rc), "+A" (*(__p))     =
       \
> > >                : "rJ" (__newx), "rJ" (~__mask)                       =
   \
> > >                : "memory");                                          =
   \
> > >                                                                      =
   \
> > > @@ -106,6 +107,7 @@
> > >  #define __arch_cmpxchg_mask(sc_sfx, prepend, append, r, p, o, n)    =
   \
> > >  ({                                                                  =
   \
> > >         /* Depends on 2-byte variables being 2-byte aligned */       =
   \
> > > +       volatile ulong *__p =3D (ulong *)((ulong)(p) & ~0x3);        =
     \
> > >         ulong __s =3D ((ulong)(p) & 0x3) * BITS_PER_BYTE;            =
     \
> > >         ulong __mask =3D GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, =
0)   \
> > >                         << __s;                                      =
   \
> > > @@ -125,7 +127,7 @@
> > >                 "       bnez %1, 0b\n"                               =
   \
> > >                 append                                               =
   \
> > >                 "1:\n"                                               =
   \
> > > -               : "=3D&r" (__retx), "=3D&r" (__rc), "+A" (*(p))      =
       \
> > > +               : "=3D&r" (__retx), "=3D&r" (__rc), "+A" (*(__p))    =
       \
> > >                 : "rJ" ((long)__oldx), "rJ" (__newx),                =
   \
> > >                   "rJ" (__mask), "rJ" (~__mask)                      =
   \
> > >                 : "memory");                                         =
   \
> > >
> > > But the lkvm-static still can't boot with paravirt_spinlock .... Are
> > > there any atomic tests in the Linux?
> >
> > I recall reading something about 'locktorture' or so, not sure if usefu=
l:
> >
> > https://docs.kernel.org/locking/locktorture.html
> >
> > >
> > > I found you use some "register int variables". Would it cause the pro=
blem?
> >
> > Honestly, not sure.
> > I will try inspecting the generated asm for any unexpected changes
> > compared to your version.
>
> changed type to ulong, no changes detected in asm
>
> >
> > >
> > > You can reference this file, and it has passed the lock torture test:
> > > https://github.com/guoren83/linux/blob/sg2042-master-qspinlock-64ilp3=
2_v4/arch/riscv/include/asm/cmpxchg.h
> > >
> > > I also merged your patches with the qspinlock series: (Use the above
> > > cmpxchg.h the lkvm would run normally.)
> > > https://github.com/guoren83/linux/tree/qspinlock_v11
> >
> > Thanks!
> >
> > I should reply as soon as I find anything.
> >
>
> Some changes found (for xchg16):
> - pointer alignment wrong (need mask with ~0x3) : solved. Doesn't seem
> to need to be volatile, though.
>
> - AND with 0x3 for getting shift: I was trusting 2-byte vars to be
> 2-byte aligned , ie. p & 0x1 =3D=3D 0: may not be true. Solved (it's
> simple)
>
> - on your code, IIUC you also assume ptr & 0x1 =3D=3D 0, on
>         ulong *__ptr =3D (ulong *)((ulong)ptr & ~2);
> if it's not aligned, you may have __ptr =3D 0xYYYYYY01
> (Not saying it's wrong to assume this, just listing It differs on my code=
)
>
> - also verified your code generates addw and sllw on some points mine
> generates add and sll, don't see any issue there
>
> - There are extra sll and srl in my asm, because I end up casting to
> typeof(*ptr) at the end.
>
> changes found in cmpxchg (__cmpxchg_small_relaxed)
> - mostly the same as above,
>
> - the beginning of my function ends up being smaller, since I do my
> masking differently.
>
> I fixed the above issues, and  ran some userspace debugging tests on a
> VM, and all seems to be correct now.
>
> I then fetched your github repo, replaced my patches v3->v4 on your
> tree, added linux boot parameter "qspinlock" on my qemu cmdline
> (-machine virt): booting and working just fine.
>
> I will send a v4 soon, please give it a test when possible.
>
> Best regards,
> Leo
>
>
>
> > >
> > >
> > >
> > > >
> > > > > > +               append                                         =
         \
> > > > > > +               "1:\n"                                         =
         \
> > > > > > +               : "=3D&r" (__retx), "=3D&r" (__rc), "+A" (*(p))=
             \
> > > > > > +               : "rJ" ((long)__oldx), "rJ" (__newx),          =
         \
> > > > > > +                 "rJ" (__mask), "rJ" (~__mask)                =
         \
> > > > > > +               : "memory");                                   =
         \
> > > > > > +                                                              =
         \
> > > > > > +       r =3D (__typeof__(*(p)))(__retx >> __s);               =
           \
> > > > > > +})
> > > > > > +
> > > > > >
> > > > > >  #define __arch_cmpxchg(lr_sfx, sc_sfx, prepend, append, r, p, =
co, o, n)        \
> > > > > >  ({                                                            =
         \
> > > > > > @@ -98,6 +128,11 @@
> > > > > >         __typeof__(*(ptr)) __ret;                              =
         \
> > > > > >                                                                =
         \
> > > > > >         switch (sizeof(*__ptr)) {                              =
         \
> > > > > > +       case 1:                                                =
         \
> > > > > > +       case 2:                                                =
         \
> > > > > > +               __arch_cmpxchg_mask(sc_sfx, prepend, append,   =
         \
> > > > > > +                                       __ret, __ptr, __old, __=
new);    \
> > > > > > +               break;                                         =
         \
> > > > > >         case 4:                                                =
         \
> > > > > >                 __arch_cmpxchg(".w", ".w" sc_sfx, prepend, appe=
nd,      \
> > > > > >                                 __ret, __ptr, (long), __old, __=
new);    \
> > > > > > --
> > > > > > 2.41.0
> > > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Best Regards
> > > > >  Guo Ren
> > > > >
> > > >
> > >
> > >
> > > --
> > > Best Regards
> > >  Guo Ren
> > >
>


--=20
Best Regards
 Guo Ren
