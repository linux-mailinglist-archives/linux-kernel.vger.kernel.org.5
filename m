Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399B87745A0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbjHHSo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbjHHSoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:44:06 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981BC3A4E3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:39:40 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso818321866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691512778; x=1692117578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eg3cgX9Y6P5/jVr5DXAR/pge6n1O8D2P3/JoFiRSFMg=;
        b=fV4TFptRwSM3ti0/7bf8w70VQALFv1LKCqwU9LX/fqv9kPTANvjBs+v39pV3tZt1/b
         +9NqmW21WvxpEExPvFo1K0I2HOuUcOEJCiYahZOKJanMKsak0QTBX8PzDXRnU/buONDT
         u0lUHvTpKM4U3UYyBC26+YOVu0zkP0Nw3VtSBlWjValGb/IO51ODSYQXPGMJNADpyLWd
         qBszswgnY3IPNW5Q2t7SC3vFICl6PEnZZrORGaOwmP7w0L9OD+g1b5Qnr8V958HJZW+d
         tUnQ7snydd+UpN2eP1cxlxPWnXg03PUXpL7exDy6yTc2W8RoQFSrLQQRwc8QUrPLB9aD
         Kc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691512778; x=1692117578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eg3cgX9Y6P5/jVr5DXAR/pge6n1O8D2P3/JoFiRSFMg=;
        b=IPD4MN7sLPsckNxoypshXW+E+HNYuXUhsfv80O0KdXaWQ1rPU6sghyLvvjtGWJKIlb
         RZzHjh8tBc8/ZFRgbgk3vgHzfRAcFT1o8pFGfxcTSGkvkUmatvUc+CN7rPA6J3KdUwR/
         jyENg5TNTRKeECU+AHi+leAYfNzsd+hXNH+je67qCON4FQ/cRFEJ4ADXm0su3wXSUYDr
         FxgB/a1AW9LY4K6R+JpFgET1fOXhTxonhSn3fbYfbMq6SkVajTOzpfe4wzASyBg8t7fO
         j9+ajYoAPYohRjfwvgxqsLp6X0CrbojiJt1NOwpxh6hRHjeXoMTyTM+6WWIQlGJTyx0K
         cbvA==
X-Gm-Message-State: AOJu0YykPHQFZPCAyiTBLajFZgFHHqqQwcRmPevNHnwwyePjO5eMQPLI
        xCvn1x4nUUWjLOpjg4ORDG/CxYWNbRgeSMp+k6AY4/iRXksGgfNa
X-Google-Smtp-Source: AGHT+IHfrnfzjjFIDr5IaB8PF7cOEja8GeDBblGtdIOP7IXXIqKAZ1QYWEPd88PTEBwaW7zPiuqRzwgSACsZ6o5Vos4=
X-Received: by 2002:adf:f801:0:b0:317:6849:2d39 with SMTP id
 s1-20020adff801000000b0031768492d39mr9767648wrp.10.1691493811273; Tue, 08 Aug
 2023 04:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230725132246.817726-1-alexghiti@rivosinc.com>
 <CAJF2gTRm59RAJvSf=L2uqbb3rHnANVheO+yLqrJGuVBh1w8Oug@mail.gmail.com>
 <ZMtv5+ut5z3pjlFJ@atctrx.andestech.com> <20230803-stadium-unusable-6cf00e35ec22@wendy>
 <CAHVXubiz-7LaxCJLW=-ekr7TBFswXojr1ODU4mo59Z1OBmjieg@mail.gmail.com> <ZMytNY2J8iyjbPPy@atctrx.andestech.com>
In-Reply-To: <ZMytNY2J8iyjbPPy@atctrx.andestech.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Tue, 8 Aug 2023 13:23:19 +0200
Message-ID: <CAHVXubhwo7BQ3a3C5zr7955hxekqVQg3FWy9J2GqscZbbBtc7A@mail.gmail.com>
Subject: Re: [PATCH -fixes] riscv: Implement flush_cache_vmap()
To:     Dylan Jhong <dylan@andestech.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Dylan,

Sorry I was busy debugging 6.5 failing to boot on the Unmatched (also
TLB related, crazy everything converges to TLB issues lately :))

On Fri, Aug 4, 2023 at 9:48=E2=80=AFAM Dylan Jhong <dylan@andestech.com> wr=
ote:
>
> On Thu, Aug 03, 2023 at 11:48:36AM +0200, Alexandre Ghiti wrote:
> > On Thu, Aug 3, 2023 at 11:25=E2=80=AFAM Conor Dooley <conor.dooley@micr=
ochip.com> wrote:
> > >
> > > On Thu, Aug 03, 2023 at 05:14:15PM +0800, dylan wrote:
> > > > On Sun, Jul 30, 2023 at 01:08:17AM -0400, Guo Ren wrote:
> > > > > On Tue, Jul 25, 2023 at 9:22=E2=80=AFAM Alexandre Ghiti <alexghit=
i@rivosinc.com> wrote:
> > > > > >
> > > > > > The RISC-V kernel needs a sfence.vma after a page table modific=
ation: we
> > > > > > used to rely on the vmalloc fault handling to emit an sfence.vm=
a, but
> > > > > > commit 7d3332be011e ("riscv: mm: Pre-allocate PGD entries for
> > > > > > vmalloc/modules area") got rid of this path for 64-bit kernels,=
 so now we
> > > > > > need to explicitly emit a sfence.vma in flush_cache_vmap().
> > > > > >
> > > > > > Note that we don't need to implement flush_cache_vunmap() as th=
e generic
> > > > > > code should emit a flush tlb after unmapping a vmalloc region.
> > > > > >
> > > > > > Fixes: 7d3332be011e ("riscv: mm: Pre-allocate PGD entries for v=
malloc/modules area")
> > > > > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > > > > ---
> > > > > >  arch/riscv/include/asm/cacheflush.h | 4 ++++
> > > > > >  1 file changed, 4 insertions(+)
> > > > > >
> > > > > > diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/i=
nclude/asm/cacheflush.h
> > > > > > index 8091b8bf4883..b93ffddf8a61 100644
> > > > > > --- a/arch/riscv/include/asm/cacheflush.h
> > > > > > +++ b/arch/riscv/include/asm/cacheflush.h
> > > > > > @@ -37,6 +37,10 @@ static inline void flush_dcache_page(struct =
page *page)
> > > > > >  #define flush_icache_user_page(vma, pg, addr, len) \
> > > > > >         flush_icache_mm(vma->vm_mm, 0)
> > > > > >
> > > > > > +#ifdef CONFIG_64BIT
> > > > > > +#define flush_cache_vmap(start, end)   flush_tlb_kernel_range(=
start, end)
> > > > > Sorry, I couldn't agree with the above in a PIPT cache machine. I=
t's
> > > > > not worth for.
> > > > >
> > > > > It would reduce the performance of vmap_pages_range,
> > > > > ioremap_page_range ... API, which may cause some drivers' perform=
ance
> > > > > issues when they install/uninstall memory frequently.
> > > > >
> > > >
> > > > Hi All,
> > > >
> > > > I think functional correctness should be more important than system=
 performance
> > > > in this case. The "preventive" SFENCE.VMA became necessary due to t=
he RISC-V
> > > > specification allowing invalidation entries to be cached in the TLB=
.
> > >
> > > We are at -rc4 and this stuff is broken. Taking the bigger hammer, wh=
ich
> > > can be reverted later when a more targeted fix shows up, to make sure
> > > that v6.5 doesn't end up broken, sounds rather prudent. Otherwise, th=
e
> > > original commit should probably be reverted.
> >
> > The original commit that removed vmalloc_fault() is required, handling
> > vmalloc faults in the page fault path is not possible (see the links
> > in the description of 7d3332be011e and the example that I gave in the
> > thread https://lore.kernel.org/linux-riscv/dc26625b-6658-c078-76d2-7e97=
5a04b1d4@ghiti.fr/).
> >
> > I totally agree with Dylan that we'll work (I'm currently working on
> > that) on the performance side of the problem in the next release, we
> > need correctness and for that we need a preventive global sfence.vma
> > as we have no means (for now) to distinguish between uarch that cache
> > or not invalid entries.
> >
> > >
> > > > The problem[1] we are currently encountering is caused by not updat=
ing the TLB
> > > > after the page table is created, and the solution to this problem c=
an only be
> > > > solved by updating the TLB immediately after the page table is crea=
ted.
> > > >
> > > > There are currently two possible approaches to flush TLB:
> > > > 1. Flush TLB in flush_cache_vmap()
> > > > 2. Flush TLB in arch_sync_kernel_mappings()
> > > >
> > > > But I'm not quite sure if it's a good idea to operate on the TLB in=
side flush_cache_vmap().
> > > > The name of this function indicates that it should be related to ca=
che operations, maybe
> > > > it would be more appropriate to do TLB flush in arch_sync_kernel_ma=
ppings()?
> >
> > TLDR: The downsides to implementing arch_sync_kernel_mappings()
> > instead of flush_cache_vmap():
> >
> > - 2 global flushes for vunmap instead of 1 for flush_cache_vmap()
> > - flushes the tlb in the noflush suffixed functions so it prevents any
> > flush optimization (ie: a loop of vmap_range_noflush() without flush
> > and then a final flush afterwards)
> >
> > So I'd favour the flush_cache_vmap() implementation which seems
> > lighter. powerpc does that
> > https://elixir.bootlin.com/linux/latest/source/arch/powerpc/include/asm=
/cacheflush.h#L27
> > (but admits that it may not be the right place)
> >
> > Here is the long story (my raw notes):
> >
> > * arch_sync_kernel_mappings() is called from:
> > - _apply_to_page_range(): would only emit global sfence.vma if vmalloc
> > addresses, I guess that's ok.
> > - __vunmap_range_noflush(): it is noted here
> > https://elixir.bootlin.com/linux/latest/source/mm/vmalloc.c#L406 that
> > any caller must call flush_tlb_kernel_range(). Then the implementation
> > of arch_sync_kernel_mappings() would result in 2 global tlb flushes.
> > - vmap_range_noflush(): does not fit well with the noflush() suffix.
> >
> > * flush_cache_vmap() is called from:
> > - kasan_populate_vmalloc(): legit since it bypasses vmap api (but
> > called right a apply_to_page_range() so your patch would work here)
> > - kmsan_vunmap_range_noflush(): called twice for the mappings kmsan
> > establishes and flush_tlb_kernel_range() must be called afterwards =3D>
> > 3 global tlb flushes but the 3 are needed as they target different
> > addresses. Implementing only arch_sync_kernel_mappings() would result
> > in way more global flushes (see the loop here
> > https://elixir.bootlin.com/linux/latest/source/mm/kmsan/hooks.c#L151
> > where  __vmap_pages_range_noflush() would result in more
> > flush_tlb_all())
> > - kmsan_vmap_pages_range_noflush(): here we would flush twice, but
> > same thing for the arch_sync_kernel_mappings() implementation.
> > - ioremap_page_range(): legit, same as arch_sync_kernel_mappings()
> > implementation.
> > - vmap_pages_range(): legit, same as arch_sync_kernel_mappings() implem=
entation.
> >
> > Let me know what you think!
> >
> > Alex
> >
> Hi Alex,
>
> Thank you for the detailed explanation. It is indeed undeniable that in c=
ertain
> situations, there might be a possibility of repeated flushing TLB. But I =
think
> there are some potential problem in flush_cache_vmap().
>
> In most case, vmap_range_noflush() and flush_cache_vmap() will appear at =
the same
> time, so it should be no problem to choose one of them to do the TLB flus=
h. But
> flush_cache_vmap() does not cover all the places where apply_to_page_rang=
e()
> appears (please correct me if I'm wrong), such as vmap_pfn()[1].

That's a good catch, but shouldn't there be a flush_cache_vmap() in
vmap_pfn()? What happens to architectures that implement
flush_cache_vmap() and not arch_sync_kernel_mappings() (most of them)?

>
> The function you mentioned here, each will eventually call:
>     vmap_range_noflush() -> arch_sync_kernel_mappings() -> TLB Flush
>
> As for the performance, because the current parameter of flush_tlb_page()=
 needs to
> pass *vma, we cannot pass in this parameter so we can only choose flush_t=
lb_all().
> If it can be changed to flush_tlb_page() in the future, the performance s=
hould be improved.

We should call only flush_tlb_kernel_range() on kernel addresses, so
that won't be a problem.

>
> [1]: https://elixir.bootlin.com/linux/v6.5-rc4/source/mm/vmalloc.c#L2977
>
> Best regards,
> Dylan Jhong
>
> > > >
> > > > [1]: http://lists.infradead.org/pipermail/linux-riscv/2023-August/0=
37503.html
> > >
