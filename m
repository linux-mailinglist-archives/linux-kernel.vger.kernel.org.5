Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B457A76CF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbjITJEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbjITJEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:04:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD66CFC;
        Wed, 20 Sep 2023 02:04:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 57E721FE31;
        Wed, 20 Sep 2023 09:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695200644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X2lVHakLrQt1LUndbWfEXURHJ3ClBXtmgdVVnOA5KNo=;
        b=jV/gQkwgMh2kRtzTDIwbuXmRVY0O2qCrkRSR+x02tdW527P6xmwZwfQr4I0ei+QUwPu+LW
        Kq+dGT1E7wuwaPQRcjZGXkGbB7skWtECTIMZGEB6kfTmtCNjt/q9+iWmKEtGEbzlZmF2a+
        3gWWmd0llOJ6hTal/rU1VAEHfwurvUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695200644;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X2lVHakLrQt1LUndbWfEXURHJ3ClBXtmgdVVnOA5KNo=;
        b=FDbsCmRdWTY5IV1syw1j52bD8UgkMJB1UbBbFf3P7m/3Us6sriCdp15hDDiNkDw6vY+Srk
        7Co1IiGh4OX3zzCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E44D11333E;
        Wed, 20 Sep 2023 09:04:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id l2ARN4O1CmUqaQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 20 Sep 2023 09:04:03 +0000
Message-ID: <059cdca4-6dc7-3928-c6f7-54e4816cf728@suse.cz>
Date:   Wed, 20 Sep 2023 11:04:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 14/14] security: add documentation for SLAB_VIRTUAL
Content-Language: en-US
To:     Matteo Rizzo <matteorizzo@google.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, luto@kernel.org, peterz@infradead.org,
        Matthew Wilcox <willy@infradead.org>
Cc:     jannh@google.com, evn@google.com, poprdi@google.com,
        jordyzomer@google.com
References: <20230915105933.495735-1-matteorizzo@google.com>
 <20230915105933.495735-15-matteorizzo@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230915105933.495735-15-matteorizzo@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/23 12:59, Matteo Rizzo wrote:
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
> +
> +In either case, the important part is that the same virtual address is reused
> +for two objects of different types.

Hmm but in the 2. technique and "either allocate the page directly" case,
it's not just the virtual address, right? So we should be saying that
SLAB_VIRTUAL won't help with that case, but hopefully it's also less
common/harder to exploit? I'm not sure though - kmalloc() in SLUB will pass
anything larger than order-1 (8kB) directly to the page allocator via
kmalloc_large() so it will bypass both CONFIG_RANDOM_KMALLOC_CACHES and
SLAB_VIRTUAL, AFAICS?

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
> +probabilistic mitigations for this. SLAB_VIRTUAL addresses the second case

As Kees mentioned - I don't think you're talking about
CONFIG_RANDOM_KMALLOC_CACHES here, but it should be mentioned. Comparison of
the combination of both with AUTOSLAB could be also interesting, if
clarified it's not mainline, so unaware readers are not confused.

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

I think ideally we should be using the folio code to get from tail pages to
a folio and then a single struct slab - it would be more in line how Matthew
envisions future of struct page array AFAIK. Unless it's significantly
slower, which would be a shame :/

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

