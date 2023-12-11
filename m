Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D0880C3EE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbjLKJEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbjLKJEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:04:12 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAEAAD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:04:17 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40c41b43e1eso14655565e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702285456; x=1702890256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rA+zJQnEpXRXHPa8sM57MSeRpDyuhTRmbcQiHO1u+s=;
        b=g4jQJX8pKRiKt090UaBnIfvhl1zDq+7o3qWpBsPUHHAoQ/B/x3ApvFW0ynh8kaVSP8
         z1bQlLBRbJPD2FNuV3RHeU3pXGHzk+3UoBpUchJOpVYPPQJPRGO0/5r8zcxdnvTI6rUn
         AzJBzk+t+2wf/lisE+2yO5iw+8URa8w/ZHrvrDxVZ/hSIdKZ4Lm1GtYPvfNfgDNRmWdD
         kfsZcFmTAOWDyszIJJ+v/0y8gnGEKTyJMZzIPmyDxbEZIY8m5+CewZIfWFDVwEFbOyLC
         yGx/GKlV1bHO1a+iA2bda3ryXzOSnEemKa4boKviNW9UJygD+Ymq4+iy2AxZKRlBXdJO
         ymog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702285456; x=1702890256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7rA+zJQnEpXRXHPa8sM57MSeRpDyuhTRmbcQiHO1u+s=;
        b=DuYkT17MEUPcpYLRkOte9u/4thk5jOf2KkmYrrTgKHPd1W5MdadG6v3Ov3QR1xZGpo
         iXUT2PeI7ipzvWfAfSQCcQRxCLCxsWTMxC9x1H0SIrsZ+00tabrbKCmgU8oq0Oe2bEIf
         yOr02i+iEnck68qHZJDYTHH7RpltdMXvxI/gpxx+CoUl5dQKJkAy0sXKHIDwzCcg2Bpr
         19gZGvV1k4zPIkgtYhiyr9WwQ9dHHLNJolDLEmWVRWbUOMwDoDu9zH+mUxdN2Jsi2eec
         VDMmA6Q74iHNSAldpYaIRzZmT1hUWNk1VvNa+aR/0tuvo9Q+E1rFbrTdRV9eERQP3E2s
         EqbQ==
X-Gm-Message-State: AOJu0YygZythzI9qssyoRUE3sCjls1tMtUuvunKcXGNl0mWQG8AGSXkL
        8aeEr0VANOIjKKeTD4j8ucp8fpOilDHDU0jGEHssrg==
X-Google-Smtp-Source: AGHT+IFpNmatGvvVppvoqNpeec6Fgu1l4m42A9UAld+oqVELJcb96pUrmUgmZWFkNp2NoDAyyfMYz98BOk5CAdbJpEo=
X-Received: by 2002:a05:600c:2945:b0:40c:3c72:608f with SMTP id
 n5-20020a05600c294500b0040c3c72608fmr1628668wmd.17.1702285456052; Mon, 11 Dec
 2023 01:04:16 -0800 (PST)
MIME-Version: 1.0
References: <20231208151036.2458921-1-guoren@kernel.org> <CAHVXubjfuKZ1PBYQ8By41OX65YpAma3_kmSL7urT8L0PmMxFnQ@mail.gmail.com>
 <CAJF2gTSB-4hDo8ncSLVKvbnOOEwLSrV716kQM9d9HrzXFs7D8A@mail.gmail.com>
In-Reply-To: <CAJF2gTSB-4hDo8ncSLVKvbnOOEwLSrV716kQM9d9HrzXFs7D8A@mail.gmail.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Mon, 11 Dec 2023 10:04:05 +0100
Message-ID: <CAHVXubiK0TXMuhZhYjLq7tyk_dhFP9W2uReacECWDC7HToYuXA@mail.gmail.com>
Subject: Re: [PATCH] riscv: pgtable: Enhance set_pte to prevent OoO risk
To:     Guo Ren <guoren@kernel.org>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        willy@infradead.org, david@redhat.com, muchun.song@linux.dev,
        will@kernel.org, peterz@infradead.org, rppt@kernel.org,
        paulmck@kernel.org, atishp@atishpatra.org, anup@brainfault.org,
        alex@ghiti.fr, mike.kravetz@oracle.com, dfustini@baylibre.com,
        wefu@redhat.com, jszhang@kernel.org, falcon@tinylab.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 9:41=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote:
>
> On Mon, Dec 11, 2023 at 1:52=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosi=
nc.com> wrote:
> >
> > Hi Guo,
> >
> > On Fri, Dec 8, 2023 at 4:10=E2=80=AFPM <guoren@kernel.org> wrote:
> > >
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > When changing from an invalid pte to a valid one for a kernel page,
> > > there is no need for tlb_flush. It's okay for the TSO memory model, b=
ut
> > > there is an OoO risk for the Weak one. eg:
> > >
> > > sd t0, (a0) // a0 =3D pte address, pteval is changed from invalid to =
valid
> > > ...
> > > ld t1, (a1) // a1 =3D va of above pte
> > >
> > > If the ld instruction is executed speculatively before the sd
> > > instruction. Then it would bring an invalid entry into the TLB, and w=
hen
> > > the ld instruction retired, a spurious page fault occurred. Because t=
he
> > > vmemmap has been ignored by vmalloc_fault, the spurious page fault wo=
uld
> > > cause kernel panic.
> > >
> > > This patch was inspired by the commit: 7f0b1bf04511 ("arm64: Fix barr=
iers
> > > used for page table modifications"). For RISC-V, there is no requirem=
ent
> > > in the spec to guarantee all tlb entries are valid and no requirement=
 to
> > > PTW filter out invalid entries. Of course, micro-arch could give a mo=
re
> > > robust design, but here, use a software fence to guarantee.
> > >
> > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > ---
> > >  arch/riscv/include/asm/pgtable.h | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/as=
m/pgtable.h
> > > index 294044429e8e..2fae5a5438e0 100644
> > > --- a/arch/riscv/include/asm/pgtable.h
> > > +++ b/arch/riscv/include/asm/pgtable.h
> > > @@ -511,6 +511,13 @@ static inline int pte_same(pte_t pte_a, pte_t pt=
e_b)
> > >  static inline void set_pte(pte_t *ptep, pte_t pteval)
> > >  {
> > >         *ptep =3D pteval;
> > > +
> > > +       /*
> > > +        * Only if the new pte is present and kernel, otherwise TLB
> > > +        * maintenance or update_mmu_cache() have the necessary barri=
ers.
> > > +        */
> > > +       if (pte_val(pteval) & (_PAGE_PRESENT | _PAGE_GLOBAL))
> > > +               RISCV_FENCE(rw,rw);
> >
> > Only a sfence.vma can guarantee that the PTW actually sees a new
> > mapping, a fence is not enough. That being said, new kernel mappings
> > (vmalloc ones) are correctly handled in the kernel by using
> > flush_cache_vmap(). Did you observe something that this patch fixes?
> Thx for the reply!
>
> The sfence.vma is too expensive, so the situation is tricky. See the
> arm64 commit: 7f0b1bf04511 ("arm64: Fix barriers used for page table
> modifications"), which is similar. That is, linux assumes invalid pte
> won't get into TLB. Think about memory hotplug:
>
> mm/sparse.c: sparse_add_section() {
> ...
>         memmap =3D section_activate(nid, start_pfn, nr_pages, altmap, pgm=
ap);
>         if (IS_ERR(memmap))
>                 return PTR_ERR(memmap);
>
>         /*
>          * Poison uninitialized struct pages in order to catch invalid fl=
ags
>          * combinations.
>          */
>         page_init_poison(memmap, sizeof(struct page) * nr_pages);
> ...
> }
> The section_activate would use set_pte to setup vmemmap, and
> page_init_poison would access these pages' struct.

So I think the generic code must be fixed by adding a
flush_cache_vmap() in vmemmap_populate_range() or similar: several
architectures implement flush_cache_vmap() because they need to do
"something" after a new mapping is established, so vmemmap should not
be any different.

>
> That means:
> sd t0, (a0) // a0 =3D struct page's pte address, pteval is changed from
> invalid to valid
>  ...
> lw/sw t1, (a1) // a1 =3D va of struct page
>
> If the lw/sw instruction is executed speculatively before the set_pte,
> we need a fence to prevent this.

Yes I agree, but to me we need the fence property of sfence.vma to
make sure the PTW sees the new pte, unless I'm mistaken and something
in the privileged specification states that a fence is enough?

>
> >
> > Thanks,
> >
> > Alex
> >
> > >  }
> > >
> > >  void flush_icache_pte(pte_t pte);
> > > --
> > > 2.40.1
> > >
>
>
>
> --
> Best Regards
>  Guo Ren
