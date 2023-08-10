Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66372777D1A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236413AbjHJQBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236363AbjHJQBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:01:15 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC33B2D48
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:00:53 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bbff6b2679so8248305ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1691683253; x=1692288053;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QHIs9XTS1qguj+sQNLSLFZrbEwyrW6BkMHbHVlQm7XY=;
        b=TVhUl8MSg3Vr/hMgrnDQ3AYCKuMJYq6HGDkZncb6rri3JDzdbKxjklsSgMIJVYManu
         jCBpEQXfb5P5NYzkCv++YJd7Klv+qZ6umReVSiML3XVDd6JgEy8Slnhm8IyPyZMVXPbH
         okp9nQ9qqQnd3rnKFS3VpsQG4P7lRVbZY5iQKw2rLeY60bpIKZD1pSQzvJErhJlNeIoV
         3Ntby/H6ZyfgaGGcD9mfa9OGYo0YOKJv6kq6eD/TWBpqmhB/W0q/MLW2HRRxRv5sJ5kx
         e4fIzoOMaKyiAaEm2b+hRW6tUyoSSp+o8pU4/6zu+TBcVul+/mSzHOKAbe12Onz9HabK
         g76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691683253; x=1692288053;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHIs9XTS1qguj+sQNLSLFZrbEwyrW6BkMHbHVlQm7XY=;
        b=W6Xw4fLK3y8PugF6rBkW7SZ+J6mZSIcLaXxLcXuXCxGjRu/g9pcUXclqtCudjex9dd
         cx7jv/xtoW67egrXrgCmOz0so2jXonotQMSr4gzmFvultoYqxGxpLAyCO5WjwxG2d+MT
         FMwdMkZywQt6vXZeQb/CgMIK8a78dGontK7PzYZmpcwiAmZpGsBn+SRqkfnEOB4fW/Mx
         tFTCveoG6phleKwhO5fbWXac+33AX+ZlaNplz3gjsKZvqcoKuFROPxBIUv/0m/LHyP6i
         nKJhaTywbdi/1kAb5bNkgQmpkeTJZbYNTBWqKW/6kvllNhTFXR2CPkCgX97HxBdP7AxZ
         CPJA==
X-Gm-Message-State: AOJu0YxMYM+LShhQ9kD+VRzHAIfujVYHDG1nT0C0P+DyFAWDQLU1oxfH
        Q20guNJX1532/VtBQea5CB7qzw==
X-Google-Smtp-Source: AGHT+IHkbgClVoJf/O6okFNIJqI+AyckFgCGBWws3FdEewqSLN0i3CPvCztmlmlPoK0EFj8UInzOfw==
X-Received: by 2002:a17:903:11c9:b0:1b7:c0b3:b17d with SMTP id q9-20020a17090311c900b001b7c0b3b17dmr2814209plh.5.1691683253122;
        Thu, 10 Aug 2023 09:00:53 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902c2c400b001b89045ff03sm1951420pla.233.2023.08.10.09.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 09:00:52 -0700 (PDT)
Date:   Thu, 10 Aug 2023 09:00:52 -0700 (PDT)
X-Google-Original-Date: Thu, 10 Aug 2023 09:00:49 PDT (-0700)
Subject:     Re: [PATCH -fixes] riscv: Implement flush_cache_vmap()
In-Reply-To: <CAJF2gTSwoitnkm8qR15rfRPfqH3+oT+LDzP5oXYqAshLs0sF0g@mail.gmail.com>
CC:     dylan@andestech.com, Conor Dooley <conor.dooley@microchip.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Bjorn Topel <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     guoren@kernel.org, alexghiti@rivosinc.com
Message-ID: <mhng-10164d16-b30e-489e-8a06-84d62e740b8b@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Aug 2023 16:55:12 PDT (-0700), guoren@kernel.org wrote:
> On Tue, Aug 8, 2023 at 7:23 PM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
>>
>> Hey Dylan,
>>
>> Sorry I was busy debugging 6.5 failing to boot on the Unmatched (also
>> TLB related, crazy everything converges to TLB issues lately :))
>>
>> On Fri, Aug 4, 2023 at 9:48 AM Dylan Jhong <dylan@andestech.com> wrote:
>> >
>> > On Thu, Aug 03, 2023 at 11:48:36AM +0200, Alexandre Ghiti wrote:
>> > > On Thu, Aug 3, 2023 at 11:25 AM Conor Dooley <conor.dooley@microchip.com> wrote:
>> > > >
>> > > > On Thu, Aug 03, 2023 at 05:14:15PM +0800, dylan wrote:
>> > > > > On Sun, Jul 30, 2023 at 01:08:17AM -0400, Guo Ren wrote:
>> > > > > > On Tue, Jul 25, 2023 at 9:22 AM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
>> > > > > > >
>> > > > > > > The RISC-V kernel needs a sfence.vma after a page table modification: we
>> > > > > > > used to rely on the vmalloc fault handling to emit an sfence.vma, but
>> > > > > > > commit 7d3332be011e ("riscv: mm: Pre-allocate PGD entries for
>> > > > > > > vmalloc/modules area") got rid of this path for 64-bit kernels, so now we
>> > > > > > > need to explicitly emit a sfence.vma in flush_cache_vmap().
>> > > > > > >
>> > > > > > > Note that we don't need to implement flush_cache_vunmap() as the generic
>> > > > > > > code should emit a flush tlb after unmapping a vmalloc region.
>> > > > > > >
>> > > > > > > Fixes: 7d3332be011e ("riscv: mm: Pre-allocate PGD entries for vmalloc/modules area")
>> > > > > > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> > > > > > > ---
>> > > > > > >  arch/riscv/include/asm/cacheflush.h | 4 ++++
>> > > > > > >  1 file changed, 4 insertions(+)
>> > > > > > >
>> > > > > > > diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
>> > > > > > > index 8091b8bf4883..b93ffddf8a61 100644
>> > > > > > > --- a/arch/riscv/include/asm/cacheflush.h
>> > > > > > > +++ b/arch/riscv/include/asm/cacheflush.h
>> > > > > > > @@ -37,6 +37,10 @@ static inline void flush_dcache_page(struct page *page)
>> > > > > > >  #define flush_icache_user_page(vma, pg, addr, len) \
>> > > > > > >         flush_icache_mm(vma->vm_mm, 0)
>> > > > > > >
>> > > > > > > +#ifdef CONFIG_64BIT
>> > > > > > > +#define flush_cache_vmap(start, end)   flush_tlb_kernel_range(start, end)
>> > > > > > Sorry, I couldn't agree with the above in a PIPT cache machine. It's
>> > > > > > not worth for.
>> > > > > >
>> > > > > > It would reduce the performance of vmap_pages_range,
>> > > > > > ioremap_page_range ... API, which may cause some drivers' performance
>> > > > > > issues when they install/uninstall memory frequently.
>> > > > > >
>> > > > >
>> > > > > Hi All,
>> > > > >
>> > > > > I think functional correctness should be more important than system performance
>> > > > > in this case. The "preventive" SFENCE.VMA became necessary due to the RISC-V
>> > > > > specification allowing invalidation entries to be cached in the TLB.
>> > > >
>> > > > We are at -rc4 and this stuff is broken. Taking the bigger hammer, which
>> > > > can be reverted later when a more targeted fix shows up, to make sure
>> > > > that v6.5 doesn't end up broken, sounds rather prudent. Otherwise, the
>> > > > original commit should probably be reverted.
>> > >
>> > > The original commit that removed vmalloc_fault() is required, handling
>> > > vmalloc faults in the page fault path is not possible (see the links
>> > > in the description of 7d3332be011e and the example that I gave in the
>> > > thread https://lore.kernel.org/linux-riscv/dc26625b-6658-c078-76d2-7e975a04b1d4@ghiti.fr/).
>> > >
>> > > I totally agree with Dylan that we'll work (I'm currently working on
>> > > that) on the performance side of the problem in the next release, we
>> > > need correctness and for that we need a preventive global sfence.vma
>> > > as we have no means (for now) to distinguish between uarch that cache
>> > > or not invalid entries.
>> > >
>> > > >
>> > > > > The problem[1] we are currently encountering is caused by not updating the TLB
>> > > > > after the page table is created, and the solution to this problem can only be
>> > > > > solved by updating the TLB immediately after the page table is created.
>> > > > >
>> > > > > There are currently two possible approaches to flush TLB:
>> > > > > 1. Flush TLB in flush_cache_vmap()
>> > > > > 2. Flush TLB in arch_sync_kernel_mappings()
>> > > > >
>> > > > > But I'm not quite sure if it's a good idea to operate on the TLB inside flush_cache_vmap().
>> > > > > The name of this function indicates that it should be related to cache operations, maybe
>> > > > > it would be more appropriate to do TLB flush in arch_sync_kernel_mappings()?
>> > >
>> > > TLDR: The downsides to implementing arch_sync_kernel_mappings()
>> > > instead of flush_cache_vmap():
>> > >
>> > > - 2 global flushes for vunmap instead of 1 for flush_cache_vmap()
>> > > - flushes the tlb in the noflush suffixed functions so it prevents any
>> > > flush optimization (ie: a loop of vmap_range_noflush() without flush
>> > > and then a final flush afterwards)
>> > >
>> > > So I'd favour the flush_cache_vmap() implementation which seems
>> > > lighter. powerpc does that
>> > > https://elixir.bootlin.com/linux/latest/source/arch/powerpc/include/asm/cacheflush.h#L27
>> > > (but admits that it may not be the right place)
>> > >
>> > > Here is the long story (my raw notes):
>> > >
>> > > * arch_sync_kernel_mappings() is called from:
>> > > - _apply_to_page_range(): would only emit global sfence.vma if vmalloc
>> > > addresses, I guess that's ok.
>> > > - __vunmap_range_noflush(): it is noted here
>> > > https://elixir.bootlin.com/linux/latest/source/mm/vmalloc.c#L406 that
>> > > any caller must call flush_tlb_kernel_range(). Then the implementation
>> > > of arch_sync_kernel_mappings() would result in 2 global tlb flushes.
>> > > - vmap_range_noflush(): does not fit well with the noflush() suffix.
>> > >
>> > > * flush_cache_vmap() is called from:
>> > > - kasan_populate_vmalloc(): legit since it bypasses vmap api (but
>> > > called right a apply_to_page_range() so your patch would work here)
>> > > - kmsan_vunmap_range_noflush(): called twice for the mappings kmsan
>> > > establishes and flush_tlb_kernel_range() must be called afterwards =>
>> > > 3 global tlb flushes but the 3 are needed as they target different
>> > > addresses. Implementing only arch_sync_kernel_mappings() would result
>> > > in way more global flushes (see the loop here
>> > > https://elixir.bootlin.com/linux/latest/source/mm/kmsan/hooks.c#L151
>> > > where  __vmap_pages_range_noflush() would result in more
>> > > flush_tlb_all())
>> > > - kmsan_vmap_pages_range_noflush(): here we would flush twice, but
>> > > same thing for the arch_sync_kernel_mappings() implementation.
>> > > - ioremap_page_range(): legit, same as arch_sync_kernel_mappings()
>> > > implementation.
>> > > - vmap_pages_range(): legit, same as arch_sync_kernel_mappings() implementation.
>> > >
>> > > Let me know what you think!
>> > >
>> > > Alex
>> > >
>> > Hi Alex,
>> >
>> > Thank you for the detailed explanation. It is indeed undeniable that in certain
>> > situations, there might be a possibility of repeated flushing TLB. But I think
>> > there are some potential problem in flush_cache_vmap().
>> >
>> > In most case, vmap_range_noflush() and flush_cache_vmap() will appear at the same
>> > time, so it should be no problem to choose one of them to do the TLB flush. But
>> > flush_cache_vmap() does not cover all the places where apply_to_page_range()
>> > appears (please correct me if I'm wrong), such as vmap_pfn()[1].
>>
>> That's a good catch, but shouldn't there be a flush_cache_vmap() in
>> vmap_pfn()? What happens to architectures that implement
>> flush_cache_vmap() and not arch_sync_kernel_mappings() (most of them)?
>>
>> >
>> > The function you mentioned here, each will eventually call:
>> >     vmap_range_noflush() -> arch_sync_kernel_mappings() -> TLB Flush
>> >
>> > As for the performance, because the current parameter of flush_tlb_page() needs to
>> > pass *vma, we cannot pass in this parameter so we can only choose flush_tlb_all().
>> > If it can be changed to flush_tlb_page() in the future, the performance should be improved.
>>
>> We should call only flush_tlb_kernel_range() on kernel addresses, so
>> that won't be a problem.
> Another idea for reference:
>  1. keep vmalloc_fault()
>  2. flush_tlb_page() for vmap_stack when creating kernel thread.
>

Sorry, I replied to the wrong thread over here 
<https://lore.kernel.org/all/mhng-3d3afb21-bd40-4095-ba62-41cf40b782ca@palmer-ri-x1c9/#t>.  
I agree we'll likely have performance issues, but at least this fixes 
the bugs we're seeing.  If there's performance issues on real workloads 
on real HW then I'm happy to look at something more complicated, but 
that's probably too much for this release.

So I've queue this up, it'll end up on fixes when it passes the tests.

Thanks!

>>
>> >
>> > [1]: https://elixir.bootlin.com/linux/v6.5-rc4/source/mm/vmalloc.c#L2977
>> >
>> > Best regards,
>> > Dylan Jhong
>> >
>> > > > >
>> > > > > [1]: http://lists.infradead.org/pipermail/linux-riscv/2023-August/037503.html
>> > > >
>
>
>
> -- 
> Best Regards
>  Guo Ren
