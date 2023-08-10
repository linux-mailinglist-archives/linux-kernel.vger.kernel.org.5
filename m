Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D3A7781B4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235675AbjHJTjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbjHJTju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:39:50 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AB02683
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:39:49 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-686f090310dso1144591b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1691696388; x=1692301188;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IWt17S3YFaslvootf0h9ujcENKBrzttzFf2VE/OYOqU=;
        b=yaMFWkdnCCXezvR+resWh15I1Qcr19Du3mNTcBxYaW5gfSIk1g6BC95ZTDfKUxpLuA
         CJsWCSmgYqoZngmprN343E4sjcvu4DEXTdb2Y6XDIbEiAdsjSsm4D0uqoVFPK4bFLdDK
         f+zmwkUO987XKsIvNhqv8fAbi3B6carwBdviyaBgVYDkWyI1TCtlUFlEXbZh1aMhBpzV
         z49JmZnbDcxew2Xey9wgA2ea4229qEy3foDRdHQDZYDtpUWqnGCxqGqezwMimlGqnhTC
         /trSxizmU14G2EKCUcDNXiiU4OZjURg25eScjBmqAfetl/CLM/6HfurKOivkuOgytHt/
         0hAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691696388; x=1692301188;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWt17S3YFaslvootf0h9ujcENKBrzttzFf2VE/OYOqU=;
        b=fNQYOW6mg8ePyidt6kaozSM74PZBqGrUI80hsyUZbE51+uDrMdnIXEa4SYd0wEhXI+
         ehR4SSatkNDbdKSsAd+pHCoHBeN6oFJrRIPGIAj5isSYP6xgXLH4RjZzxe9RarAQzI2m
         qwM22rqa97ytN77a9TCeOEnSt9jVgZY7xpeJsLWALJ/H9eoOnbD5gPRvPzqbKKCYyrc/
         i4cQa1VEPasZpIzjigBc7N2WNmeEGTJhyoZi76xPwb27pAPBbiYZ1M5qcsT6BCdlC9Id
         BjQgmvFOiuJrGvsRlzAnXqafBPmLQWZcabeeA4cmC8CEtBOoCAhQyAFilnTTw3t1t8xt
         mkiQ==
X-Gm-Message-State: AOJu0YybyOlipMuArZq7wkt5aoM2g7cqmfR+AZ8Ymc4Vp6FtmaljEyMz
        Fw+RpwvuKPm2Nx1t0RFKdNRpKKOmoktiG0AncL0=
X-Google-Smtp-Source: AGHT+IETHWdPXc9jz5ySTObjPGEtqyadnvqGEPihoKI0Rs3NrxffJThDN784H9w40HJBHL0XI7tmYA==
X-Received: by 2002:a05:6a00:1992:b0:687:fb4:be30 with SMTP id d18-20020a056a00199200b006870fb4be30mr4342862pfl.4.1691696388361;
        Thu, 10 Aug 2023 12:39:48 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id fk17-20020a056a003a9100b0068743cab196sm1893571pfb.186.2023.08.10.12.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 12:39:47 -0700 (PDT)
Date:   Thu, 10 Aug 2023 12:39:47 -0700 (PDT)
X-Google-Original-Date: Thu, 10 Aug 2023 12:39:46 PDT (-0700)
Subject:     Re: [PATCH -fixes] riscv: Implement flush_cache_vmap()
In-Reply-To: <ZNUOxgJLy+QAO9uR@atctrx.andestech.com>
CC:     guoren@kernel.org, alexghiti@rivosinc.com,
        Conor Dooley <conor.dooley@microchip.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Bjorn Topel <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     dylan@andestech.com
Message-ID: <mhng-6749f3de-3fb7-4f9e-813e-66f21843e3cc@palmer-ri-x1c9a>
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

On Thu, 10 Aug 2023 09:22:30 PDT (-0700), dylan@andestech.com wrote:
> On Thu, Aug 10, 2023 at 09:00:52AM -0700, Palmer Dabbelt wrote:
>> On Tue, 08 Aug 2023 16:55:12 PDT (-0700), guoren@kernel.org wrote:
>> > On Tue, Aug 8, 2023 at 7:23 PM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
>> > >
>> > > Hey Dylan,
>> > >
>> > > Sorry I was busy debugging 6.5 failing to boot on the Unmatched (also
>> > > TLB related, crazy everything converges to TLB issues lately :))
>> > >
>> > > On Fri, Aug 4, 2023 at 9:48 AM Dylan Jhong <dylan@andestech.com> wrote:
>> > > >
>> > > > On Thu, Aug 03, 2023 at 11:48:36AM +0200, Alexandre Ghiti wrote:
>> > > > > On Thu, Aug 3, 2023 at 11:25 AM Conor Dooley <conor.dooley@microchip.com> wrote:
>> > > > > >
>> > > > > > On Thu, Aug 03, 2023 at 05:14:15PM +0800, dylan wrote:
>> > > > > > > On Sun, Jul 30, 2023 at 01:08:17AM -0400, Guo Ren wrote:
>> > > > > > > > On Tue, Jul 25, 2023 at 9:22 AM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
>> > > > > > > > >
>> > > > > > > > > The RISC-V kernel needs a sfence.vma after a page table modification: we
>> > > > > > > > > used to rely on the vmalloc fault handling to emit an sfence.vma, but
>> > > > > > > > > commit 7d3332be011e ("riscv: mm: Pre-allocate PGD entries for
>> > > > > > > > > vmalloc/modules area") got rid of this path for 64-bit kernels, so now we
>> > > > > > > > > need to explicitly emit a sfence.vma in flush_cache_vmap().
>> > > > > > > > >
>> > > > > > > > > Note that we don't need to implement flush_cache_vunmap() as the generic
>> > > > > > > > > code should emit a flush tlb after unmapping a vmalloc region.
>> > > > > > > > >
>> > > > > > > > > Fixes: 7d3332be011e ("riscv: mm: Pre-allocate PGD entries for vmalloc/modules area")
>> > > > > > > > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> > > > > > > > > ---
>> > > > > > > > >  arch/riscv/include/asm/cacheflush.h | 4 ++++
>> > > > > > > > >  1 file changed, 4 insertions(+)
>> > > > > > > > >
>> > > > > > > > > diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
>> > > > > > > > > index 8091b8bf4883..b93ffddf8a61 100644
>> > > > > > > > > --- a/arch/riscv/include/asm/cacheflush.h
>> > > > > > > > > +++ b/arch/riscv/include/asm/cacheflush.h
>> > > > > > > > > @@ -37,6 +37,10 @@ static inline void flush_dcache_page(struct page *page)
>> > > > > > > > >  #define flush_icache_user_page(vma, pg, addr, len) \
>> > > > > > > > >         flush_icache_mm(vma->vm_mm, 0)
>> > > > > > > > >
>> > > > > > > > > +#ifdef CONFIG_64BIT
>> > > > > > > > > +#define flush_cache_vmap(start, end)   flush_tlb_kernel_range(start, end)
>> > > > > > > > Sorry, I couldn't agree with the above in a PIPT cache machine. It's
>> > > > > > > > not worth for.
>> > > > > > > >
>> > > > > > > > It would reduce the performance of vmap_pages_range,
>> > > > > > > > ioremap_page_range ... API, which may cause some drivers' performance
>> > > > > > > > issues when they install/uninstall memory frequently.
>> > > > > > > >
>> > > > > > >
>> > > > > > > Hi All,
>> > > > > > >
>> > > > > > > I think functional correctness should be more important than system performance
>> > > > > > > in this case. The "preventive" SFENCE.VMA became necessary due to the RISC-V
>> > > > > > > specification allowing invalidation entries to be cached in the TLB.
>> > > > > >
>> > > > > > We are at -rc4 and this stuff is broken. Taking the bigger hammer, which
>> > > > > > can be reverted later when a more targeted fix shows up, to make sure
>> > > > > > that v6.5 doesn't end up broken, sounds rather prudent. Otherwise, the
>> > > > > > original commit should probably be reverted.
>> > > > >
>> > > > > The original commit that removed vmalloc_fault() is required, handling
>> > > > > vmalloc faults in the page fault path is not possible (see the links
>> > > > > in the description of 7d3332be011e and the example that I gave in the
>> > > > > thread https://lore.kernel.org/linux-riscv/dc26625b-6658-c078-76d2-7e975a04b1d4@ghiti.fr/).
>> > > > >
>> > > > > I totally agree with Dylan that we'll work (I'm currently working on
>> > > > > that) on the performance side of the problem in the next release, we
>> > > > > need correctness and for that we need a preventive global sfence.vma
>> > > > > as we have no means (for now) to distinguish between uarch that cache
>> > > > > or not invalid entries.
>> > > > >
>> > > > > >
>> > > > > > > The problem[1] we are currently encountering is caused by not updating the TLB
>> > > > > > > after the page table is created, and the solution to this problem can only be
>> > > > > > > solved by updating the TLB immediately after the page table is created.
>> > > > > > >
>> > > > > > > There are currently two possible approaches to flush TLB:
>> > > > > > > 1. Flush TLB in flush_cache_vmap()
>> > > > > > > 2. Flush TLB in arch_sync_kernel_mappings()
>> > > > > > >
>> > > > > > > But I'm not quite sure if it's a good idea to operate on the TLB inside flush_cache_vmap().
>> > > > > > > The name of this function indicates that it should be related to cache operations, maybe
>> > > > > > > it would be more appropriate to do TLB flush in arch_sync_kernel_mappings()?
>> > > > >
>> > > > > TLDR: The downsides to implementing arch_sync_kernel_mappings()
>> > > > > instead of flush_cache_vmap():
>> > > > >
>> > > > > - 2 global flushes for vunmap instead of 1 for flush_cache_vmap()
>> > > > > - flushes the tlb in the noflush suffixed functions so it prevents any
>> > > > > flush optimization (ie: a loop of vmap_range_noflush() without flush
>> > > > > and then a final flush afterwards)
>> > > > >
>> > > > > So I'd favour the flush_cache_vmap() implementation which seems
>> > > > > lighter. powerpc does that
>> > > > > https://elixir.bootlin.com/linux/latest/source/arch/powerpc/include/asm/cacheflush.h#L27
>> > > > > (but admits that it may not be the right place)
>> > > > >
>> > > > > Here is the long story (my raw notes):
>> > > > >
>> > > > > * arch_sync_kernel_mappings() is called from:
>> > > > > - _apply_to_page_range(): would only emit global sfence.vma if vmalloc
>> > > > > addresses, I guess that's ok.
>> > > > > - __vunmap_range_noflush(): it is noted here
>> > > > > https://elixir.bootlin.com/linux/latest/source/mm/vmalloc.c#L406 that
>> > > > > any caller must call flush_tlb_kernel_range(). Then the implementation
>> > > > > of arch_sync_kernel_mappings() would result in 2 global tlb flushes.
>> > > > > - vmap_range_noflush(): does not fit well with the noflush() suffix.
>> > > > >
>> > > > > * flush_cache_vmap() is called from:
>> > > > > - kasan_populate_vmalloc(): legit since it bypasses vmap api (but
>> > > > > called right a apply_to_page_range() so your patch would work here)
>> > > > > - kmsan_vunmap_range_noflush(): called twice for the mappings kmsan
>> > > > > establishes and flush_tlb_kernel_range() must be called afterwards =>
>> > > > > 3 global tlb flushes but the 3 are needed as they target different
>> > > > > addresses. Implementing only arch_sync_kernel_mappings() would result
>> > > > > in way more global flushes (see the loop here
>> > > > > https://elixir.bootlin.com/linux/latest/source/mm/kmsan/hooks.c#L151
>> > > > > where  __vmap_pages_range_noflush() would result in more
>> > > > > flush_tlb_all())
>> > > > > - kmsan_vmap_pages_range_noflush(): here we would flush twice, but
>> > > > > same thing for the arch_sync_kernel_mappings() implementation.
>> > > > > - ioremap_page_range(): legit, same as arch_sync_kernel_mappings()
>> > > > > implementation.
>> > > > > - vmap_pages_range(): legit, same as arch_sync_kernel_mappings() implementation.
>> > > > >
>> > > > > Let me know what you think!
>> > > > >
>> > > > > Alex
>> > > > >
>> > > > Hi Alex,
>> > > >
>> > > > Thank you for the detailed explanation. It is indeed undeniable that in certain
>> > > > situations, there might be a possibility of repeated flushing TLB. But I think
>> > > > there are some potential problem in flush_cache_vmap().
>> > > >
>> > > > In most case, vmap_range_noflush() and flush_cache_vmap() will appear at the same
>> > > > time, so it should be no problem to choose one of them to do the TLB flush. But
>> > > > flush_cache_vmap() does not cover all the places where apply_to_page_range()
>> > > > appears (please correct me if I'm wrong), such as vmap_pfn()[1].
>> > >
>> > > That's a good catch, but shouldn't there be a flush_cache_vmap() in
>> > > vmap_pfn()? What happens to architectures that implement
>> > > flush_cache_vmap() and not arch_sync_kernel_mappings() (most of them)?
>> > >
>> > > >
>> > > > The function you mentioned here, each will eventually call:
>> > > >     vmap_range_noflush() -> arch_sync_kernel_mappings() -> TLB Flush
>> > > >
>> > > > As for the performance, because the current parameter of flush_tlb_page() needs to
>> > > > pass *vma, we cannot pass in this parameter so we can only choose flush_tlb_all().
>> > > > If it can be changed to flush_tlb_page() in the future, the performance should be improved.
>> > >
>> > > We should call only flush_tlb_kernel_range() on kernel addresses, so
>> > > that won't be a problem.
>> > Another idea for reference:
>> >  1. keep vmalloc_fault()
>> >  2. flush_tlb_page() for vmap_stack when creating kernel thread.
>> >
>>
>> Sorry, I replied to the wrong thread over here <https://lore.kernel.org/all/mhng-3d3afb21-bd40-4095-ba62-41cf40b782ca@palmer-ri-x1c9/#t>.
>> I agree we'll likely have performance issues, but at least this fixes the
>> bugs we're seeing.  If there's performance issues on real workloads on real
>> HW then I'm happy to look at something more complicated, but that's probably
>> too much for this release.
>>
>> So I've queue this up, it'll end up on fixes when it passes the tests.
>>
>> Thanks!
>
> Hi Palmer,
>
> Reply to your post on another thread.
>
> Yes, we need the implementation of flush_cache_vmap() under the RISC-V architecture to
> solve our problem. Alexandre proposed another solution to deal with the TLB
> updating issue in another thread [1], I think that patch should be able to better
> ensure performance and correctness. But before that, we need this patch as a
> workaround.

Awesome, thanks.

> BTW, since there is no flush_cache_vmap() in vmap_pfn(), there may be a risk
> that the TLB is not updated. I think this patch[2] should be pulled back to the
> RISC-V port.

That one's for the MM tree, though -- it should still end up in stable, 
so we should be fine from the RISC-V side of things.

>
> [1]: http://lists.infradead.org/pipermail/linux-riscv/2023-August/038079.html
> [2]: https://lore.kernel.org/all/mhng-3d3afb21-bd40-4095-ba62-41cf40b782ca@palmer-ri-x1c9/#t
>
>>
>> > >
>> > > >
>> > > > [1]: https://elixir.bootlin.com/linux/v6.5-rc4/source/mm/vmalloc.c#L2977
>> > > >
>> > > > Best regards,
>> > > > Dylan Jhong
>> > > >
>> > > > > > >
>> > > > > > > [1]: http://lists.infradead.org/pipermail/linux-riscv/2023-August/037503.html
>> > > > > >
>> >
>> >
>> >
>> > --
>> > Best Regards
>> >  Guo Ren
