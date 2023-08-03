Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DECE76E4E9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbjHCJtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235085AbjHCJsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:48:54 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC053A9C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 02:48:49 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3175d5ca8dbso611501f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 02:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691056128; x=1691660928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNt6RNLD0LJXztZ1SYoI66tx29xjSf7MjTxllw0f1IQ=;
        b=Um08LbwYpMbTIR4IPtCqL9QqBmLJRiCpNJ3lmHUDQp3U6u61H5Xt/E/ObzOTMlBi9v
         FXUkvwW/Rr13JWpL7Cunx+hgq19Fy4j6Yn8Vi4etS5HKJ1Em8lrXYiaoubgPLYP5C/8w
         QumH+KsbKtU6RN0Eeh2161V1eYVzUw0mdQy+gTztQCv4QIhkfGApwxBcpR2qYGQJVHKC
         hOD8z06keaNR3GuEzuipWK99ujCmEEWqHr+V6ySdf3ACF747JS7H6IbPPI4IC3lx4LmN
         Zlb14pquZlE3Pv20mKKYLpjOIr6NBHWQiEpXyatAuAkE4AUiGolcCUQhfuGbaJywfOZv
         lfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691056128; x=1691660928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YNt6RNLD0LJXztZ1SYoI66tx29xjSf7MjTxllw0f1IQ=;
        b=EbkFgmSMWwWQtS75Bdw1o/AL/ET+8+pWqfU8h8cFxS2qPtTeBgYJwwX7rlcdX1xxGB
         rWq/DUMnqhVMFGWtMjogZKOnkd886zpMIWAzX6t4tG3rOJSEm6AS29WwkWSoCHPO/E9U
         iaA6RJKMMxkyn72u3qb/6iUkxqrXgx7zyF5oRyTGkqbyvR0bOQznIeMu4fXpNvyb0ib7
         /EYCF5Os3f/l9OSfXkVM7E8ZeDjf2Cag+4U6sUgMKkNC5508MQ0xooDC3aEmu81LQqUL
         B7K3x13f4H7AjZ1aAaNJJV6gJhLhNeRIO4Q788Thg5aICJ7YCYeJXae75teYrK0bKoUo
         o4Pw==
X-Gm-Message-State: ABy/qLaXbFDT4M1JM1XbxytbYVLbgHisLTR4u7oIf+3B37eg73JQg8MD
        uBFBU98kMIihUEOJ7GkGRAjRmvGUHPzy8h8U+MTZqA==
X-Google-Smtp-Source: APBJJlEswcSyENuBr7birO1iqqKERgsNCGjqP2MdEOg+niR5CuCn/R70QXmpfZMvVx0d53ICWfYsdFOhZti/F8j0k7o=
X-Received: by 2002:adf:e902:0:b0:317:576c:285 with SMTP id
 f2-20020adfe902000000b00317576c0285mr5877559wrm.7.1691056127656; Thu, 03 Aug
 2023 02:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230725132246.817726-1-alexghiti@rivosinc.com>
 <CAJF2gTRm59RAJvSf=L2uqbb3rHnANVheO+yLqrJGuVBh1w8Oug@mail.gmail.com>
 <ZMtv5+ut5z3pjlFJ@atctrx.andestech.com> <20230803-stadium-unusable-6cf00e35ec22@wendy>
In-Reply-To: <20230803-stadium-unusable-6cf00e35ec22@wendy>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Thu, 3 Aug 2023 11:48:36 +0200
Message-ID: <CAHVXubiz-7LaxCJLW=-ekr7TBFswXojr1ODU4mo59Z1OBmjieg@mail.gmail.com>
Subject: Re: [PATCH -fixes] riscv: Implement flush_cache_vmap()
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     dylan <dylan@andestech.com>, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 11:25=E2=80=AFAM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> On Thu, Aug 03, 2023 at 05:14:15PM +0800, dylan wrote:
> > On Sun, Jul 30, 2023 at 01:08:17AM -0400, Guo Ren wrote:
> > > On Tue, Jul 25, 2023 at 9:22=E2=80=AFAM Alexandre Ghiti <alexghiti@ri=
vosinc.com> wrote:
> > > >
> > > > The RISC-V kernel needs a sfence.vma after a page table modificatio=
n: we
> > > > used to rely on the vmalloc fault handling to emit an sfence.vma, b=
ut
> > > > commit 7d3332be011e ("riscv: mm: Pre-allocate PGD entries for
> > > > vmalloc/modules area") got rid of this path for 64-bit kernels, so =
now we
> > > > need to explicitly emit a sfence.vma in flush_cache_vmap().
> > > >
> > > > Note that we don't need to implement flush_cache_vunmap() as the ge=
neric
> > > > code should emit a flush tlb after unmapping a vmalloc region.
> > > >
> > > > Fixes: 7d3332be011e ("riscv: mm: Pre-allocate PGD entries for vmall=
oc/modules area")
> > > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > > ---
> > > >  arch/riscv/include/asm/cacheflush.h | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/inclu=
de/asm/cacheflush.h
> > > > index 8091b8bf4883..b93ffddf8a61 100644
> > > > --- a/arch/riscv/include/asm/cacheflush.h
> > > > +++ b/arch/riscv/include/asm/cacheflush.h
> > > > @@ -37,6 +37,10 @@ static inline void flush_dcache_page(struct page=
 *page)
> > > >  #define flush_icache_user_page(vma, pg, addr, len) \
> > > >         flush_icache_mm(vma->vm_mm, 0)
> > > >
> > > > +#ifdef CONFIG_64BIT
> > > > +#define flush_cache_vmap(start, end)   flush_tlb_kernel_range(star=
t, end)
> > > Sorry, I couldn't agree with the above in a PIPT cache machine. It's
> > > not worth for.
> > >
> > > It would reduce the performance of vmap_pages_range,
> > > ioremap_page_range ... API, which may cause some drivers' performance
> > > issues when they install/uninstall memory frequently.
> > >
> >
> > Hi All,
> >
> > I think functional correctness should be more important than system per=
formance
> > in this case. The "preventive" SFENCE.VMA became necessary due to the R=
ISC-V
> > specification allowing invalidation entries to be cached in the TLB.
>
> We are at -rc4 and this stuff is broken. Taking the bigger hammer, which
> can be reverted later when a more targeted fix shows up, to make sure
> that v6.5 doesn't end up broken, sounds rather prudent. Otherwise, the
> original commit should probably be reverted.

The original commit that removed vmalloc_fault() is required, handling
vmalloc faults in the page fault path is not possible (see the links
in the description of 7d3332be011e and the example that I gave in the
thread https://lore.kernel.org/linux-riscv/dc26625b-6658-c078-76d2-7e975a04=
b1d4@ghiti.fr/).

I totally agree with Dylan that we'll work (I'm currently working on
that) on the performance side of the problem in the next release, we
need correctness and for that we need a preventive global sfence.vma
as we have no means (for now) to distinguish between uarch that cache
or not invalid entries.

>
> > The problem[1] we are currently encountering is caused by not updating =
the TLB
> > after the page table is created, and the solution to this problem can o=
nly be
> > solved by updating the TLB immediately after the page table is created.
> >
> > There are currently two possible approaches to flush TLB:
> > 1. Flush TLB in flush_cache_vmap()
> > 2. Flush TLB in arch_sync_kernel_mappings()
> >
> > But I'm not quite sure if it's a good idea to operate on the TLB inside=
 flush_cache_vmap().
> > The name of this function indicates that it should be related to cache =
operations, maybe
> > it would be more appropriate to do TLB flush in arch_sync_kernel_mappin=
gs()?

TLDR: The downsides to implementing arch_sync_kernel_mappings()
instead of flush_cache_vmap():

- 2 global flushes for vunmap instead of 1 for flush_cache_vmap()
- flushes the tlb in the noflush suffixed functions so it prevents any
flush optimization (ie: a loop of vmap_range_noflush() without flush
and then a final flush afterwards)

So I'd favour the flush_cache_vmap() implementation which seems
lighter. powerpc does that
https://elixir.bootlin.com/linux/latest/source/arch/powerpc/include/asm/cac=
heflush.h#L27
(but admits that it may not be the right place)

Here is the long story (my raw notes):

* arch_sync_kernel_mappings() is called from:
- _apply_to_page_range(): would only emit global sfence.vma if vmalloc
addresses, I guess that's ok.
- __vunmap_range_noflush(): it is noted here
https://elixir.bootlin.com/linux/latest/source/mm/vmalloc.c#L406 that
any caller must call flush_tlb_kernel_range(). Then the implementation
of arch_sync_kernel_mappings() would result in 2 global tlb flushes.
- vmap_range_noflush(): does not fit well with the noflush() suffix.

* flush_cache_vmap() is called from:
- kasan_populate_vmalloc(): legit since it bypasses vmap api (but
called right a apply_to_page_range() so your patch would work here)
- kmsan_vunmap_range_noflush(): called twice for the mappings kmsan
establishes and flush_tlb_kernel_range() must be called afterwards =3D>
3 global tlb flushes but the 3 are needed as they target different
addresses. Implementing only arch_sync_kernel_mappings() would result
in way more global flushes (see the loop here
https://elixir.bootlin.com/linux/latest/source/mm/kmsan/hooks.c#L151
where  __vmap_pages_range_noflush() would result in more
flush_tlb_all())
- kmsan_vmap_pages_range_noflush(): here we would flush twice, but
same thing for the arch_sync_kernel_mappings() implementation.
- ioremap_page_range(): legit, same as arch_sync_kernel_mappings()
implementation.
- vmap_pages_range(): legit, same as arch_sync_kernel_mappings() implementa=
tion.

Let me know what you think!

Alex

> >
> > [1]: http://lists.infradead.org/pipermail/linux-riscv/2023-August/03750=
3.html
>
