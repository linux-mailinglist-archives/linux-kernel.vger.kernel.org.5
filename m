Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78F37A5106
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjIRRak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIRRai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:30:38 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6FEDB
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 10:30:31 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-530bc7c5bc3so2945682a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 10:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695058230; x=1695663030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6SisKzSSW7KsXfAah6EH3AZKjH8JH1npbZIGwb0CSI=;
        b=YFud+g1IpkkfMwqKlxWqDA6+6LI3L4Yc5uPWIjJrm3rje6StwqVO7dcwge7Kfu7onh
         5+QuhasWdd5Tzkgc58XE3nI/wV+onzHG4EHAkT3+GWCcSuOWnD4JEMchQ5zimtkeSFaR
         A7OnuBeiJpWC8MtV3rDmgA35YYc/KzDx/V9zwnwMfBMAU8wxi8jgr6rDoQHQioof2h2O
         GR6W8ZdUt9pQ8U1NvB/Ui0D7EaaAZwatzb0KUKCYliSm4DZwuQtgefSKAHkp2rLrDO3O
         N1AUILFsDO5TlCk8BZCKeVTymICAGdyJksl4HQFpJe6TldVwvCRA8+fIvaRwEfP7HqD9
         r9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695058230; x=1695663030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l6SisKzSSW7KsXfAah6EH3AZKjH8JH1npbZIGwb0CSI=;
        b=Vtjggg0y4smfJdRCmQ2Hi6p5HTM5kowIxBkAxe5Jza0F2cJjqOTE5Oq90bW0/plcJG
         vbjJWoNeEVzkFs4IwtByTzqy2lVawsO3AgfW1guYHoRcRQ1GiVztkJ9We+77I1QQu9Ip
         ojt6MyNL2xfNXTgou+5/YlpPZy2qhd16AuUyTGIOAvsUI57efOuAiTV/AUyoKbXecKcf
         7hukC/XDMTl9TEbfYKOGhQijeN5AWsJGHS0Dg1S6ChMWwSMst1ff5Zhk7TJwYEmo0mCW
         dSc9Wu98MOQgYwtxhlFJGBJhFQ4qrHHJvGYDoAR3d5Ac4H9hg2P8vHnhTMRDrCfQo1P6
         lbiQ==
X-Gm-Message-State: AOJu0YzDNZYJBv8tPP7XHQQPr5rPt0riEzMTS1TXv/NK0cNajdz24t9N
        /btLA7E1mGHaO9rktFsK39gXbwThC90OXFNQ8Xm0CHVUTMf9dSnM
X-Google-Smtp-Source: AGHT+IF+u49EWryrbSgFkdtQ3BxfrryrQ+MaFHMFqfudR3tLi3jBgpeBEGaaxoNgzT+SkEICm3NHgHPdBG6zl3Jig9M=
X-Received: by 2002:adf:f3c6:0:b0:31f:e980:df87 with SMTP id
 g6-20020adff3c6000000b0031fe980df87mr7488545wrp.38.1695042222677; Mon, 18 Sep
 2023 06:03:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230914014027.273002-1-peterlin@andestech.com>
 <51f5c170-2659-d76a-afbb-632b7a55586c@ghiti.fr> <ZQVXy6I42HJM4XLM@APC323>
In-Reply-To: <ZQVXy6I42HJM4XLM@APC323>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Mon, 18 Sep 2023 15:03:31 +0200
Message-ID: <CAHVXubjQgDbqj1Pk09odLsZ235vHyAd-XjLcOXb4xrDOgSpa9g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] riscv: Improve PTDUMP to show RSW with non-zero value
To:     Yu-Chien Peter Lin <peterlin@andestech.com>
Cc:     Alexandre Ghiti <alex@ghiti.fr>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, david@redhat.com,
        akpm@linux-foundation.org, bjorn@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        ycliang@andestech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter Lin,

On Sat, Sep 16, 2023 at 9:23=E2=80=AFAM Yu-Chien Peter Lin
<peterlin@andestech.com> wrote:
>
> Hi Alexandre,
>
> On Fri, Sep 15, 2023 at 01:07:04PM +0200, Alexandre Ghiti wrote:
> > On 14/09/2023 03:40, Yu Chien Peter Lin wrote:
> > > RSW field can be used to encode 2 bits of software defined
> > > information, currently PTDUMP only prints RSW when its value
> > > is 1 or 3.
> > >
> > > To fix this issue and enhance the debug experience with PTDUMP,
> > > we use _PAGE_SOFT as the RSW mask and redefine _PAGE_SPECIAL to
> > > (1 << 8), allow it to print the RSW with any non-zero value,
> > > otherwise, it will print an empty string for each row.
> > >
> > > This patch also removes the val from the struct prot_bits as
> > > it is no longer needed.
> > >
> > > Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> > > ---
> > >   arch/riscv/include/asm/pgtable-bits.h |  4 +--
> > >   arch/riscv/mm/ptdump.c                | 36 +++++++++++-------------=
---
> > >   2 files changed, 17 insertions(+), 23 deletions(-)
> > >
> > > diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/inclu=
de/asm/pgtable-bits.h
> > > index f896708e8331..99e60fd3eb72 100644
> > > --- a/arch/riscv/include/asm/pgtable-bits.h
> > > +++ b/arch/riscv/include/asm/pgtable-bits.h
> > > @@ -16,9 +16,9 @@
> > >   #define _PAGE_GLOBAL    (1 << 5)    /* Global */
> > >   #define _PAGE_ACCESSED  (1 << 6)    /* Set by hardware on any acces=
s */
> > >   #define _PAGE_DIRTY     (1 << 7)    /* Set by hardware on any write=
 */
> > > -#define _PAGE_SOFT      (1 << 8)    /* Reserved for software */
> > > +#define _PAGE_SOFT      (3 << 8)    /* Reserved for software */
> > > -#define _PAGE_SPECIAL   _PAGE_SOFT
> >
> >
> > That's nit, but maybe you could have introduced a _PAGE_SOFT_1 and
> > _PAGE_SOFT_2
> >
>
> Thanks for the suggestion, maybe we just add a comment here?
>
> #define _PAGE_SPECIAL   (1 << 8) /* RSW: 0x1 */
>
> > > +#define _PAGE_SPECIAL   (1 << 8)
> >
> >
> > instead of hardcoding (1<<8) here, but that can be done when we'll use =
the
> > second bit :)
> >
> > >   #define _PAGE_TABLE     _PAGE_PRESENT
> > >   /*
> > > diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
> > > index 20a9f991a6d7..85686652f342 100644
> > > --- a/arch/riscv/mm/ptdump.c
> > > +++ b/arch/riscv/mm/ptdump.c
> > > @@ -129,7 +129,6 @@ static struct ptd_mm_info efi_ptd_info =3D {
> > >   /* Page Table Entry */
> > >   struct prot_bits {
> > >     u64 mask;
> > > -   u64 val;
> > >     const char *set;
> > >     const char *clear;
> > >   };
> > > @@ -137,47 +136,38 @@ struct prot_bits {
> > >   static const struct prot_bits pte_bits[] =3D {
> > >     {
> > >             .mask =3D _PAGE_SOFT,
> > > -           .val =3D _PAGE_SOFT,
> > > -           .set =3D "RSW",
> > > -           .clear =3D "   ",
> > > +           .set =3D "RSW(%d)",
> > > +           .clear =3D "      ",
> > >     }, {
> > >             .mask =3D _PAGE_DIRTY,
> > > -           .val =3D _PAGE_DIRTY,
> > >             .set =3D "D",
> > >             .clear =3D ".",
> > >     }, {
> > >             .mask =3D _PAGE_ACCESSED,
> > > -           .val =3D _PAGE_ACCESSED,
> > >             .set =3D "A",
> > >             .clear =3D ".",
> > >     }, {
> > >             .mask =3D _PAGE_GLOBAL,
> > > -           .val =3D _PAGE_GLOBAL,
> > >             .set =3D "G",
> > >             .clear =3D ".",
> > >     }, {
> > >             .mask =3D _PAGE_USER,
> > > -           .val =3D _PAGE_USER,
> > >             .set =3D "U",
> > >             .clear =3D ".",
> > >     }, {
> > >             .mask =3D _PAGE_EXEC,
> > > -           .val =3D _PAGE_EXEC,
> > >             .set =3D "X",
> > >             .clear =3D ".",
> > >     }, {
> > >             .mask =3D _PAGE_WRITE,
> > > -           .val =3D _PAGE_WRITE,
> > >             .set =3D "W",
> > >             .clear =3D ".",
> > >     }, {
> > >             .mask =3D _PAGE_READ,
> > > -           .val =3D _PAGE_READ,
> > >             .set =3D "R",
> > >             .clear =3D ".",
> > >     }, {
> > >             .mask =3D _PAGE_PRESENT,
> > > -           .val =3D _PAGE_PRESENT,
> > >             .set =3D "V",
> > >             .clear =3D ".",
> > >     }
> > > @@ -208,15 +198,19 @@ static void dump_prot(struct pg_state *st)
> > >     unsigned int i;
> > >     for (i =3D 0; i < ARRAY_SIZE(pte_bits); i++) {
> > > -           const char *s;
> > > -
> > > -           if ((st->current_prot & pte_bits[i].mask) =3D=3D pte_bits=
[i].val)
> > > -                   s =3D pte_bits[i].set;
> > > -           else
> > > -                   s =3D pte_bits[i].clear;
> > > -
> > > -           if (s)
> > > -                   pt_dump_seq_printf(st->seq, " %s", s);
> > > +           char s[7];
> > > +           unsigned long val;
> > > +
> > > +           val =3D st->current_prot & pte_bits[i].mask;
> > > +           if (val) {
> > > +                   if (pte_bits[i].mask =3D=3D _PAGE_SOFT)
> > > +                           sprintf(s, pte_bits[i].set, val >> 8);
> > > +                   else
> > > +                           sprintf(s, "%s", pte_bits[i].set);
> > > +           } else
> > > +                   sprintf(s, "%s", pte_bits[i].clear);
> > > +
> > > +           pt_dump_seq_printf(st->seq, " %s", s);
> > >     }
> > >   }
> >
> >
> > I don't see any issue in your patch, but just the output is a bit "weir=
d"
> > now as the there is a large "hole" between the PTE type and the PTE
> > protection bits:
> >
> > Before:
> >
> > 0xffffffd800000000-0xffffffd800200000 0x0000000080000000         2M PMD
> > D A G . . W R V
> >
> > After:
> >
> > 0xffffaf8000000000-0xffffaf8000200000 0x0000000080000000         2M PMD
> > .               D A G . . W R V
> >
> > Maybe you could add the PBMT/N bits after the protections bits to void =
this
> > hole?
>
> Agreed, PBMT and RSW fields are not commonly used. How about adding ".."
> for 2-bit zero values instead of spaces? hopefully it will look better.
>
> 0xffffffc802088000-0xffffffc80208c000    0x0000000000d36000        16K PT=
E .   ..     ..   D A G . . W R V
> 0xffffffc802090000-0xffffffc802094000    0x0000000000d4d000        16K PT=
E . MT(IO)   ..   D A G . . W R V
> 0xffffffc802095000-0xffffffc8020b5000    0x0000000100d80000       128K PT=
E .   ..   RSW(2) D A G . . W R V
> 0xffffffc8020b6000-0xffffffc8020d6000    0x0000000100da0000       128K PT=
E .   ..   RSW(2) D A G . . W R V
> 0xffffffc8020d8000-0xffffffc8020dc000    0x0000000000d7b000        16K PT=
E .   ..     ..   D A G . . W R V
> 0xffffffc8020e0000-0xffffffc8020e4000    0x0000000000d7f000        16K PT=
E .   ..     ..   D A G . . W R V
>

Fine by me, I'll add my RB/TB on the next version!

Thanks,

Alex

> > Anyway, as a heavy user of this kernel page table dump, that's really
> > appreciated, thanks :)
>
> Thansk for the review :)
>
> Best regards,
> Peter Lin
>
> > Alex
> >
