Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545E37F728D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 12:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345771AbjKXLTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 06:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345606AbjKXLTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 06:19:01 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224B6D5A;
        Fri, 24 Nov 2023 03:18:50 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-5079f3f3d7aso2540411e87.1;
        Fri, 24 Nov 2023 03:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700824728; x=1701429528; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f+kwf4oiCNuNUPUYBMKfaUf1JMi5hC6OYmSuOQoH8zQ=;
        b=CSfLNVyUZinFMjL2ow71SUXhXOhE32QsegvcQK7t/0UxZkw4q7AkbdP0hXwoBmvFNc
         nTS8sSJzH7nJLS6yQQivWRpFqTQvwrGdAcjL9KcPvQNgUhu2wUzCdttdFLtW9zrwPL4c
         qjgGD2auJS5NWJVAK+Ubh89OxIXmQK10LHVWko3lP63fse+KeylT2m41FV3RTpnACcD0
         dnyyeaebaqfnMe7jYjmS0pFfsJV/c0Lr3TeOIIqRMBXt5VICcZTwrwDuQhIOoQVYpzT1
         AoygFSBOJgeiuTlP6Ap/URCNrPIiDXar2pVPGLZzeYnVCshZXqJPnoG8IUWgEIqsvcxE
         cN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700824728; x=1701429528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+kwf4oiCNuNUPUYBMKfaUf1JMi5hC6OYmSuOQoH8zQ=;
        b=AbBPCU/agycNzCdIC1PnPQeov6BGFeLo0e8QbOTkQQPgN4TYsbYoFAYt9amkEg4jXL
         50Uhb/Q6nfMkikv/xArkvM6k+apmMDz5scpthidHR4K17b0GHgzxAFZJclCOpm+t65DN
         AsPqkWAdC/DRYOxjq779B4EXHGpuK4E5MXld0zM0Nwv09synkoo1PHcOy4kJV2u1SeV+
         XCqbpMht0kEX2z8fSBXkoeeSqEq2/6R65l/aTilbpwY0C5NClE0GlZEzQIf+7eC+wHHt
         01MAJaxbMD48z7xIY6fqsBIeD2lbhn6jbox1uNLuDJpDW7iLZsusil33IfwpLQbRs0Ax
         8sSw==
X-Gm-Message-State: AOJu0YyQLchgsV/t+6GJeqOTg7dsgVCCEhSu9FIgMQP+jQ3wo7YNMvCo
        R65JixlyyrN++yfYMVGPy8w=
X-Google-Smtp-Source: AGHT+IFFIOO7erVajSURqg9EfF4plZK5MtY8224Y94dp5fu+s5ebLPjKwf321C7Tiwa/P5bOdNuHYg==
X-Received: by 2002:a05:6512:3d91:b0:50a:a6e2:ae73 with SMTP id k17-20020a0565123d9100b0050aa6e2ae73mr2027855lfv.44.1700824727907;
        Fri, 24 Nov 2023 03:18:47 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id t7-20020ac25487000000b0050aa705a067sm475891lfk.292.2023.11.24.03.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 03:18:47 -0800 (PST)
Date:   Fri, 24 Nov 2023 14:18:44 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Arnd Bergmann <arnd@arndb.de>,
        Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
        Aleksandar Rikalo <arikalo@gmail.com>,
        Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>,
        Chao-ying Fu <cfu@wavecomp.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Yinglu Yang <yangyinglu@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] mm/mm_init.c: Extend init unavailable range doc info
Message-ID: <h3g6ynqem6h6hefmdawzaspvzf4u5fwfh7rken3ogy5ucr5z5t@d5gagi2ql4ee>
References: <20231122182419.30633-1-fancer.lancer@gmail.com>
 <20231122182419.30633-6-fancer.lancer@gmail.com>
 <20231123101854.GF636165@kernel.org>
 <ehlzzv37o4exdn4smmu653wzjdotzdv3dhr3bduvemxssp37ro@sgegnyprquk4>
 <20231124081900.GG636165@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124081900.GG636165@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 10:19:00AM +0200, Mike Rapoport wrote:
> On Thu, Nov 23, 2023 at 01:42:39PM +0300, Serge Semin wrote:
> > On Thu, Nov 23, 2023 at 12:18:54PM +0200, Mike Rapoport wrote:
> > > On Wed, Nov 22, 2023 at 09:24:03PM +0300, Serge Semin wrote:
> > > > Besides of the already described reasons the pages backended memory holes
> > > > might be persistent due to having memory mapped IO spaces behind those
> > > > ranges in the framework of flatmem kernel config. Add such note to the
> > > > init_unavailable_range() method kdoc in order to point out to one more
> > > > reason of having the function executed for such regions.
> > > > 
> > > > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > > > 
> > > > ---
> > > > 
> > > > Please let me know if the IO-space pages must be initialized somehow
> > > > differently rather relying on free_area_init() executing the
> > > > init_unavailable_range() method.
> > > 
> > 
> > > Maybe I'm missing something, but why do you need struct pages in the
> > > IO space?
> > 
> > In my case at the very least that's due to having a SRAM device
> > available in the middle of the MMIO-space. The region is getting
> > mapped using the ioremap_wc() method (Uncached Write-Combine CA),
> > which eventually is converted to calling get_vm_area() and
> > ioremap_page_range() (see ioremap_prot() function on MIPS), which in
> > its turn use the page structs for mapping. Another similar case is
> > using ioremap_wc() in the PCIe outbound ATU space mapping of
> > the graphic/video cards framebuffers.
> 
> ioremap_page_range() does not need struct pages, but rather physical
> addresses.

Unless I miss something or MIPS32 is somehow special/wrong in that
matter, but from my just got experience it actually does at least in
the framework of the __update_cache() implementation which is called
in the set_ptes() method (former set_pte_at()), which in its turn
is eventually invoked by vmap_range_noflush() and finally by
ioremap_page_range(). See the patch
[PATCH 3/7] mips: Fix max_mapnr being uninitialized on early stages
Link: https://lore.kernel.org/linux-mips/20231122182419.30633-4-fancer.lancer@gmail.com/
of this series and the stack-trace of the bug fixed by that patch.

Is it wrong that on MIPS32 ioremap_page_range() eventually relies on
the page structs? It has been like that for, I don't know, long time.
If so then the sparse memory config might be broken on MIPS32..(

>  
> > In general having the pages array defined for the IO-memory is
> > required for mapping the IO-space other than just uncached (my sram
> > case for example) or, for instance, with special access attribute for
> > the user-space (if I am not missing something in a way VM works in
> > that case).
> 

> No, struct pages are not required to map IO space. If you need to map MMIO
> to userspace there's remap_pfn_range() for that.

Is this correct for both flat and sparse memory config? In anyway
please see my comment above about the problem I recently got.

> 
> My guess is that your system has a hole in the physical memory mappings and
> with FLATMEM that hole will have essentially unused struct pages, which are
> initialized by init_unavailable_range().  But from mm perspective this is
> still a hole even though there's some MMIO ranges in that hole.

Absolutely right. Here is the physical memory layout in my system.
0     - 128MB: RAM
128MB - 512MB: Memory mapped IO
512MB - 768MB..8.256GB: RAM

> 
> Now, if that hole is large you are wasting memory for unused memory map and
> it maybe worth considering using SPARSEMEM.

Do you think it's worth to move to the sparse memory configuration in
order to save the 384MB of mapping with the 16K page model? AFAIU flat
memory config is more performant. Performance is critical on the most
of the SoC applications especially when using the 10G ethernet or
the high-speed PCIe devices.

-Serge(y)

>  
> > -Serge(y)
> > 
> > > 
> > > > ---
> > > >  mm/mm_init.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/mm/mm_init.c b/mm/mm_init.c
> > > > index 077bfe393b5e..3fa33e2d32ba 100644
> > > > --- a/mm/mm_init.c
> > > > +++ b/mm/mm_init.c
> > > > @@ -796,6 +796,7 @@ overlap_memmap_init(unsigned long zone, unsigned long *pfn)
> > > >   * - physical memory bank size is not necessarily the exact multiple of the
> > > >   *   arbitrary section size
> > > >   * - early reserved memory may not be listed in memblock.memory
> > > > + * - memory mapped IO space
> > > >   * - memory layouts defined with memmap= kernel parameter may not align
> > > >   *   nicely with memmap sections
> > > >   *
> > > > -- 
> > > > 2.42.1
> > > > 
> > > 
> > > -- 
> > > Sincerely yours,
> > > Mike.
> > > 
> 
> -- 
> Sincerely yours,
> Mike.
