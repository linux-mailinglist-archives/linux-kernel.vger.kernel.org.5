Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815B476E516
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbjHCJ7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjHCJ6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:58:55 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65996126
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 02:58:53 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe167d4a18so7899655e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 02:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691056732; x=1691661532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqckpK2MfxpBnAQGUCA9x8quoQKlwdYtjewX4SoiFF8=;
        b=0mrU30zekayCAMXAG5x8zPSkZdc++ugPSaXANL9aJK8DP8kgaSD12+FtMkpikh1ZNy
         cTIZJPnl1HgrMSMrIAw8+QiedpMU06gDAAigANAEbpoqFz6x++2LWGks70MDOsMAS3h2
         1c+YWDgsUmrsu57w1e1BvtBm7MqIIIn/jYVu39sZfM8kdV+vTyYOOKUqOhxL50UHHqyS
         EjIGQQLd3XcY+oQmssR6/Kx0V9lVnLUyQwk4Tih1FBi00NxpRKuWHX0Lq81xsCDFhW1Q
         IKc+MzXF3GJgJ3xa1uxYzPX7ImAb5SJugZK6saS1oRc1Y83w+VTLLVC2PMFZTWtzIOdD
         yl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691056732; x=1691661532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jqckpK2MfxpBnAQGUCA9x8quoQKlwdYtjewX4SoiFF8=;
        b=G5/lf1IfJ8Dx5mLvGBXad0ZVgPhVcI1ZhMjhTTFE4MTmojV5y7sVhK/pDnWpIXSYb0
         g4B1WgYWma9Q6QWxI9EIqqeflFqqOgZucPHOhRH/BpRxK7Nkj9uns+2//5/DLnT2YieC
         KjwpVYeyfC2Or1Mw5v2PGLotThO17g2bdOq/s50x7t1azXTWjpcCT+Yiem7jE65nUYQT
         M5Z2/tFT+tgBfU884WlVrqxH8U/mOWVAsFG68k1KnBwgo7jIjkniojz9yplb2vn8YK0u
         0jgf08ePCUcRk+tebLhJehb0HDpH3FAxTlUgfPtfrDDDyL0nLswyNjzeNcav2eqXSXKl
         6zHQ==
X-Gm-Message-State: ABy/qLabG9vpg5ZHAcGyz44JmxUIrfFeuJJfVxbCWtE9F5nMkKiAhO3E
        1FFvAZzP8F8SNyixXz5ZaIr+daruIu6l2B/0thLxmTOvOkMdEG4F
X-Google-Smtp-Source: APBJJlGhjO1UaFK6qznvZGQm3atfrSwYnozFcnLeHEkSBGHsQFap/Z1pleQHgia9mbPxIAXXkZWDomlMNJ5ROgEJQVs=
X-Received: by 2002:a7b:cb04:0:b0:3fe:9a6:f44 with SMTP id u4-20020a7bcb04000000b003fe09a60f44mr7086242wmj.32.1691056731809;
 Thu, 03 Aug 2023 02:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230725132246.817726-1-alexghiti@rivosinc.com>
 <CAJF2gTRm59RAJvSf=L2uqbb3rHnANVheO+yLqrJGuVBh1w8Oug@mail.gmail.com>
 <ZMtv5+ut5z3pjlFJ@atctrx.andestech.com> <20230803-stadium-unusable-6cf00e35ec22@wendy>
 <CAHVXubiz-7LaxCJLW=-ekr7TBFswXojr1ODU4mo59Z1OBmjieg@mail.gmail.com>
In-Reply-To: <CAHVXubiz-7LaxCJLW=-ekr7TBFswXojr1ODU4mo59Z1OBmjieg@mail.gmail.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Thu, 3 Aug 2023 11:58:41 +0200
Message-ID: <CAHVXubg_7GwsdVpA_tPNYk2PUuQVheSfa31YbQPJg46enh2cfQ@mail.gmail.com>
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
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 11:48=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> On Thu, Aug 3, 2023 at 11:25=E2=80=AFAM Conor Dooley <conor.dooley@microc=
hip.com> wrote:
> >
> > On Thu, Aug 03, 2023 at 05:14:15PM +0800, dylan wrote:
> > > On Sun, Jul 30, 2023 at 01:08:17AM -0400, Guo Ren wrote:
> > > > On Tue, Jul 25, 2023 at 9:22=E2=80=AFAM Alexandre Ghiti <alexghiti@=
rivosinc.com> wrote:
> > > > >
> > > > > The RISC-V kernel needs a sfence.vma after a page table modificat=
ion: we
> > > > > used to rely on the vmalloc fault handling to emit an sfence.vma,=
 but
> > > > > commit 7d3332be011e ("riscv: mm: Pre-allocate PGD entries for
> > > > > vmalloc/modules area") got rid of this path for 64-bit kernels, s=
o now we
> > > > > need to explicitly emit a sfence.vma in flush_cache_vmap().
> > > > >
> > > > > Note that we don't need to implement flush_cache_vunmap() as the =
generic
> > > > > code should emit a flush tlb after unmapping a vmalloc region.
> > > > >
> > > > > Fixes: 7d3332be011e ("riscv: mm: Pre-allocate PGD entries for vma=
lloc/modules area")
> > > > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > > > ---
> > > > >  arch/riscv/include/asm/cacheflush.h | 4 ++++
> > > > >  1 file changed, 4 insertions(+)
> > > > >
> > > > > diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/inc=
lude/asm/cacheflush.h
> > > > > index 8091b8bf4883..b93ffddf8a61 100644
> > > > > --- a/arch/riscv/include/asm/cacheflush.h
> > > > > +++ b/arch/riscv/include/asm/cacheflush.h
> > > > > @@ -37,6 +37,10 @@ static inline void flush_dcache_page(struct pa=
ge *page)
> > > > >  #define flush_icache_user_page(vma, pg, addr, len) \
> > > > >         flush_icache_mm(vma->vm_mm, 0)
> > > > >
> > > > > +#ifdef CONFIG_64BIT
> > > > > +#define flush_cache_vmap(start, end)   flush_tlb_kernel_range(st=
art, end)
> > > > Sorry, I couldn't agree with the above in a PIPT cache machine. It'=
s
> > > > not worth for.
> > > >
> > > > It would reduce the performance of vmap_pages_range,
> > > > ioremap_page_range ... API, which may cause some drivers' performan=
ce
> > > > issues when they install/uninstall memory frequently.
> > > >
> > >
> > > Hi All,
> > >
> > > I think functional correctness should be more important than system p=
erformance
> > > in this case. The "preventive" SFENCE.VMA became necessary due to the=
 RISC-V
> > > specification allowing invalidation entries to be cached in the TLB.
> >
> > We are at -rc4 and this stuff is broken. Taking the bigger hammer, whic=
h
> > can be reverted later when a more targeted fix shows up, to make sure
> > that v6.5 doesn't end up broken, sounds rather prudent. Otherwise, the
> > original commit should probably be reverted.
>
> The original commit that removed vmalloc_fault() is required, handling
> vmalloc faults in the page fault path is not possible (see the links
> in the description of 7d3332be011e and the example that I gave in the
> thread https://lore.kernel.org/linux-riscv/dc26625b-6658-c078-76d2-7e975a=
04b1d4@ghiti.fr/).

Actually the problem was there before this commit (Dylan has the issue
in 6.1), so no faulty commit to revert :)

>
> I totally agree with Dylan that we'll work (I'm currently working on
> that) on the performance side of the problem in the next release, we
> need correctness and for that we need a preventive global sfence.vma
> as we have no means (for now) to distinguish between uarch that cache
> or not invalid entries.
>
> >
> > > The problem[1] we are currently encountering is caused by not updatin=
g the TLB
> > > after the page table is created, and the solution to this problem can=
 only be
> > > solved by updating the TLB immediately after the page table is create=
d.
> > >
> > > There are currently two possible approaches to flush TLB:
> > > 1. Flush TLB in flush_cache_vmap()
> > > 2. Flush TLB in arch_sync_kernel_mappings()
> > >
> > > But I'm not quite sure if it's a good idea to operate on the TLB insi=
de flush_cache_vmap().
> > > The name of this function indicates that it should be related to cach=
e operations, maybe
> > > it would be more appropriate to do TLB flush in arch_sync_kernel_mapp=
ings()?
>
> TLDR: The downsides to implementing arch_sync_kernel_mappings()
> instead of flush_cache_vmap():
>
> - 2 global flushes for vunmap instead of 1 for flush_cache_vmap()
> - flushes the tlb in the noflush suffixed functions so it prevents any
> flush optimization (ie: a loop of vmap_range_noflush() without flush
> and then a final flush afterwards)
>
> So I'd favour the flush_cache_vmap() implementation which seems
> lighter. powerpc does that
> https://elixir.bootlin.com/linux/latest/source/arch/powerpc/include/asm/c=
acheflush.h#L27
> (but admits that it may not be the right place)
>
> Here is the long story (my raw notes):
>
> * arch_sync_kernel_mappings() is called from:
> - _apply_to_page_range(): would only emit global sfence.vma if vmalloc
> addresses, I guess that's ok.
> - __vunmap_range_noflush(): it is noted here
> https://elixir.bootlin.com/linux/latest/source/mm/vmalloc.c#L406 that
> any caller must call flush_tlb_kernel_range(). Then the implementation
> of arch_sync_kernel_mappings() would result in 2 global tlb flushes.
> - vmap_range_noflush(): does not fit well with the noflush() suffix.
>
> * flush_cache_vmap() is called from:
> - kasan_populate_vmalloc(): legit since it bypasses vmap api (but
> called right a apply_to_page_range() so your patch would work here)
> - kmsan_vunmap_range_noflush(): called twice for the mappings kmsan
> establishes and flush_tlb_kernel_range() must be called afterwards =3D>
> 3 global tlb flushes but the 3 are needed as they target different
> addresses. Implementing only arch_sync_kernel_mappings() would result
> in way more global flushes (see the loop here
> https://elixir.bootlin.com/linux/latest/source/mm/kmsan/hooks.c#L151
> where  __vmap_pages_range_noflush() would result in more
> flush_tlb_all())
> - kmsan_vmap_pages_range_noflush(): here we would flush twice, but
> same thing for the arch_sync_kernel_mappings() implementation.
> - ioremap_page_range(): legit, same as arch_sync_kernel_mappings()
> implementation.
> - vmap_pages_range(): legit, same as arch_sync_kernel_mappings() implemen=
tation.
>
> Let me know what you think!
>
> Alex
>
> > >
> > > [1]: http://lists.infradead.org/pipermail/linux-riscv/2023-August/037=
503.html
> >
