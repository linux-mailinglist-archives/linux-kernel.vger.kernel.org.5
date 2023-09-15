Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9FA7A298F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 23:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237836AbjIOVfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 17:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237871AbjIOVeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 17:34:44 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8657F19E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 14:34:34 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-577e62e2adfso2095888a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 14:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694813674; x=1695418474; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DMNKJbaDoh2XeIMNATULLDefE0skDJfasuAN0WXdJAM=;
        b=JlCRevrU/xIO1G9EorKGAD34IwEnbiYhjjZW3xv8l9pB7zzAPW91x5S+/RU+xdCcll
         0Jdt2dxdJNQaLiz4R8EgYXqvMValpdMblU3+vqTzALyMEFOkJl+iO8f1okjK123K5Oi2
         fUyXyluoPA3fecCwNYPyzrLkPGle5k2IAhR/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694813674; x=1695418474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DMNKJbaDoh2XeIMNATULLDefE0skDJfasuAN0WXdJAM=;
        b=af342bnHyDiVT+Xh2jIC+KtB4BmeJPOIyrP7kV5GywjgGPcQJqoeXoBdoLmKqHcwO5
         GgpIXvEhfPJLT6WUBPxCmJEiulnKDoNtI/KjbU4qvWwbNnJhCilZrDevjMGdRzBi0o31
         Qr1Z5Cpg2fjM3iKTpkh3lik5D9e2nJgMh3fJmm4YEMKkOVT+BVwzjp2baduI0Er7ql09
         TbtZ4EuCZTTu6qPRwjCbBCDb5PF2/ErZdTvKce+phx5kQYchsaeURhf9rr6b5qrvFSkr
         l5W5pkmTM2b8nC/WW/OniTM/QqmyiAYPQByCbAnNCkJtQTeOWqUHDqsQ+M77uDnMeXBs
         L23g==
X-Gm-Message-State: AOJu0Ywa298BmkeVSwNPI0zDCaV8+d8gqWS4jDoZynCeuBxvsf6zn1pP
        0OHUDPPttAipOmV5MOdpFWUeFA==
X-Google-Smtp-Source: AGHT+IHMHssMNnreMLJqTuCVGlIvTdvgjcemSHWehzPcVZV916K3MiLdrfG5XxR45MOqXavrLdyosg==
X-Received: by 2002:a17:90b:128a:b0:26b:698f:dda7 with SMTP id fw10-20020a17090b128a00b0026b698fdda7mr2636429pjb.32.1694813673889;
        Fri, 15 Sep 2023 14:34:33 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ga9-20020a17090b038900b0026094c23d0asm3481238pjb.17.2023.09.15.14.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 14:34:33 -0700 (PDT)
Date:   Fri, 15 Sep 2023 14:34:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matteo Rizzo <matteorizzo@google.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, luto@kernel.org, peterz@infradead.org,
        jannh@google.com, evn@google.com, poprdi@google.com,
        jordyzomer@google.com
Subject: Re: [RFC PATCH 14/14] security: add documentation for SLAB_VIRTUAL
Message-ID: <202309151428.C04391065F@keescook>
References: <20230915105933.495735-1-matteorizzo@google.com>
 <20230915105933.495735-15-matteorizzo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915105933.495735-15-matteorizzo@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 10:59:33AM +0000, Matteo Rizzo wrote:
> From: Jann Horn <jannh@google.com>
> 
> Document what SLAB_VIRTUAL is trying to do, how it's implemented, and
> why.
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> Co-developed-by: Matteo Rizzo <matteorizzo@google.com>
> Signed-off-by: Matteo Rizzo <matteorizzo@google.com>
> ---
>  Documentation/security/self-protection.rst | 102 +++++++++++++++++++++
>  1 file changed, 102 insertions(+)
> 
> diff --git a/Documentation/security/self-protection.rst b/Documentation/security/self-protection.rst
> index 910668e665cb..5a5e99e3f244 100644
> --- a/Documentation/security/self-protection.rst
> +++ b/Documentation/security/self-protection.rst
> @@ -314,3 +314,105 @@ To help kill classes of bugs that result in kernel addresses being
>  written to userspace, the destination of writes needs to be tracked. If
>  the buffer is destined for userspace (e.g. seq_file backed ``/proc`` files),
>  it should automatically censor sensitive values.
> +
> +
> +Memory Allocator Mitigations
> +============================
> +
> +Protection against cross-cache attacks (SLAB_VIRTUAL)
> +-----------------------------------------------------
> +
> +SLAB_VIRTUAL is a mitigation that deterministically prevents cross-cache
> +attacks.
> +
> +Linux Kernel use-after-free vulnerabilities are commonly exploited by turning
> +them into an object type confusion (having two active pointers of different
> +types to the same memory location) using one of the following techniques:
> +
> +1. Direct object reuse: make the kernel give the victim object back to the slab
> +   allocator, then allocate the object again from the same slab cache as a
> +   different type. This is only possible if the victim object resides in a slab
> +   cache which can contain objects of different types - for example one of the
> +   kmalloc caches.
> +2. "Cross-cache attack": make the kernel give the victim object back to the slab
> +   allocator, then make the slab allocator give the page containing the object
> +   back to the page allocator, then either allocate the page directly as some
> +   other type of page or make the slab allocator allocate it again for a
> +   different slab cache and allocate an object from there.

I feel like adding a link to
https://googleprojectzero.blogspot.com/2021/10/how-simple-linux-kernel-memory.html
would be nice here, as some folks reading this may not understand how
plausible the second attack can be. :)

> +
> +In either case, the important part is that the same virtual address is reused
> +for two objects of different types.
> +
> +The first case can be addressed by separating objects of different types
> +into different slab caches. If a slab cache only contains objects of the
> +same type then directly turning an use-after-free into a type confusion is
> +impossible as long as the slab page that contains the victim object remains
> +assigned to that slab cache. This type of mitigation is easily bypassable
> +by cross-cache attacks: if the attacker can make the slab allocator return
> +the page containing the victim object to the page allocator and then make
> +it use the same page for a different slab cache, type confusion becomes
> +possible again. Addressing the first case is therefore only worthwhile if
> +cross-cache attacks are also addressed. AUTOSLAB uses a combination of

I think you mean CONFIG_RANDOM_KMALLOC_CACHES, not AUTOSLAB which isn't
upstream.

> +probabilistic mitigations for this. SLAB_VIRTUAL addresses the second case
> +deterministically by changing the way the slab allocator allocates memory.
> +
> +Preventing slab virtual address reuse
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +In theory there is an easy fix against cross-cache attacks: modify the slab
> +allocator so that it never gives memory back to the page allocator. In practice
> +this would be problematic because physical memory remains permanently assigned
> +to a slab cache even if it doesn't contain any active objects. A viable
> +cross-cache mitigation must allow the system to reclaim unused physical memory.
> +In the current design of the slab allocator there is no way
> +to keep a region of virtual memory permanently assigned to a slab cache without
> +also permanently reserving physical memory. That is because the virtual
> +addresses that the slab allocator uses come from the linear map region, where
> +there is a 1:1 correspondence between virtual and physical addresses.
> +
> +SLAB_VIRTUAL's solution is to create a dedicated virtual memory region that is
> +only used for slab memory, and to enforce that once a range of virtual addresses
> +is used for a slab cache, it is never reused for any other caches. Using a
> +dedicated region of virtual memory lets us reserve ranges of virtual addresses
> +to prevent cross-cache attacks and at the same time release physical memory back
> +to the system when it's no longer needed. This is what Chromium's PartitionAlloc
> +does in userspace
> +(https://chromium.googlesource.com/chromium/src/+/354da2514b31df2aa14291199a567e10a7671621/base/allocator/partition_allocator/PartitionAlloc.md).
> +
> +Implementation
> +~~~~~~~~~~~~~~
> +
> +SLAB_VIRTUAL reserves a region of virtual memory for the slab allocator. All
> +pointers returned by the slab allocator point to this region. The region is
> +statically partitioned in two sub-regions: the metadata region and the data
> +region. The data region is where the actual objects are allocated from. The
> +metadata region is an array of struct slab objects, one for each PAGE_SIZE bytes
> +in the data region.
> +Without SLAB_VIRTUAL, struct slab is overlaid on top of the struct page/struct
> +folio that corresponds to the physical memory page backing the slab instead of
> +using a dedicated memory region. This doesn't work for SLAB_VIRTUAL, which needs
> +to store metadata for slabs even when no physical memory is allocated to them.
> +Having an array of struct slab lets us implement virt_to_slab efficiently purely
> +with arithmetic. In order to support high-order slabs, the struct slabs
> +corresponding to tail pages contain a pointer to the head slab, which
> +corresponds to the slab's head page.
> +
> +TLB flushing
> +~~~~~~~~~~~~
> +
> +Before it can release a page of physical memory back to the page allocator, the
> +slab allocator must flush the TLB entries for that page on all CPUs. This is not
> +only necessary for the mitigation to work reliably but it's also required for
> +correctness. Without a TLB flush some CPUs might continue using the old mapping
> +if the virtual address range is reused for a new slab and cause memory
> +corruption even in the absence of other bugs. The slab allocator can release
> +pages in contexts where TLB flushes can't be performed (e.g. in hardware
> +interrupt handlers). Pages to free are not freed directly, and instead they are
> +put on a queue and freed from a workqueue context which also flushes the TLB.
> +
> +Performance
> +~~~~~~~~~~~
> +
> +SLAB_VIRTUAL's performance impact depends on the workload. On kernel compilation
> +(kernbench) the slowdown is about 1-2% depending on the machine type and is
> +slightly worse on machines with more cores.

Is there anything that can be added to the docs about future work, areas
of improvement, etc?

-Kees

-- 
Kees Cook
