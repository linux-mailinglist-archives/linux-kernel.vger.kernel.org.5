Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F48C797CD3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 21:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235816AbjIGTfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 15:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjIGTfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 15:35:01 -0400
X-Greylist: delayed 4200 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Sep 2023 12:34:55 PDT
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF37E47;
        Thu,  7 Sep 2023 12:34:55 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id EA87A18CBB2;
        Thu,  7 Sep 2023 13:12:24 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1694085145; bh=fbplRXoTU4SArEuqSCeWcBdBKDzKAfUk7UIh+zzJ294=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UeWu1Ze8yhdkAQSYLwMwA5Evs8is8jd9+WRDve9QstEAJCVJk4EyPrZUvt2GlulJO
         Acv8RNSZT4NRo56VbHVjN1Qces1eN30pA/Z8XXCRCYRiG42VIaxfqRB+JiaUWDiSNI
         7vNLYKFtmaNGH7exnrZYJl77SUb4GDfp5VfGRbajxxQjYFEMgAhMtBIGZd04dwv9py
         LsW5QNMFeGMU27vzeZa8jYcSznJj+rq7+myvFYGpQ5xn1ltALy9BQiZ0pdCtmt5J0/
         dC6nWffmW3QcD4g/Ya4kxdbnZOi4vIJaCWhouPtZgmgytg1/Um76VBACnHThhWcUwa
         sohl8kzvr6NyA==
Date:   Thu, 7 Sep 2023 13:12:23 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Petr Tesarik <petrtesarik@huaweicloud.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Petr Tesarik <petr.tesarik.ext@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        James Seo <james@equiv.tech>,
        James Clark <james.clark@arm.com>,
        Kees Cook <keescook@chromium.org>,
        "moderated list:XEN HYPERVISOR ARM" <xen-devel@lists.xenproject.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        "open list:XEN SWIOTLB SUBSYSTEM" <iommu@lists.linux.dev>,
        "open list:SLAB ALLOCATOR" <linux-mm@kvack.org>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>
Subject: Re: [PATCH v7 9/9] swiotlb: search the software IO TLB only if the
 device makes use of it
Message-ID: <20230907131223.587c1a88@meshulam.tesarici.cz>
In-Reply-To: <87il8wr348.fsf@meer.lwn.net>
References: <cover.1690871004.git.petr.tesarik.ext@huawei.com>
        <adea71bd1fa8660d4c3157a562431ad8127016d4.1690871004.git.petr.tesarik.ext@huawei.com>
        <87a5uz3ob8.fsf@meer.lwn.net>
        <87il8wr348.fsf@meer.lwn.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

sorry for my late reply; I've been away from my work setup for a
month...

On Wed, 30 Aug 2023 08:55:51 -0600
Jonathan Corbet <corbet@lwn.net> wrote:

> So it seems this code got merged without this question ever being
> answered.  Sorry if it's a dumb one, but I don't think this
> functionality works as advertised...

Yes, I believe the check was originally in is_swiotlb_buffer(), but it
got lost during one of the numerous rebases of this patch set. Let me
send a follow-up patch after making sure it actually works.

Petr T

> Thanks,
> 
> jon
> 
> Jonathan Corbet <corbet@lwn.net> writes:
> 
> > Petr Tesarik <petrtesarik@huaweicloud.com> writes:
> >  
> >> From: Petr Tesarik <petr.tesarik.ext@huawei.com>
> >>
> >> Skip searching the software IO TLB if a device has never used it,
> >> making sure these devices are not affected by the introduction of
> >> multiple IO TLB memory pools.
> >>
> >> Additional memory barrier is required to ensure that the new value
> >> of the flag is visible to other CPUs after mapping a new bounce
> >> buffer. For efficiency, the flag check should be inlined, and then
> >> the memory barrier must be moved to is_swiotlb_buffer(). However,
> >> it can replace the existing barrier in swiotlb_find_pool(),
> >> because all callers use is_swiotlb_buffer() first to verify that
> >> the buffer address belongs to the software IO TLB.
> >>
> >> Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
> >> ---  
> >
> > Excuse me if this is a silly question, but I'm not able to figure
> > it out on my own...
> >  
> >>  include/linux/device.h  |  2 ++
> >>  include/linux/swiotlb.h |  7 ++++++-
> >>  kernel/dma/swiotlb.c    | 14 ++++++--------
> >>  3 files changed, 14 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/include/linux/device.h b/include/linux/device.h
> >> index 5fd89c9d005c..6fc808d22bfd 100644
> >> --- a/include/linux/device.h
> >> +++ b/include/linux/device.h
> >> @@ -628,6 +628,7 @@ struct device_physical_location {
> >>   * @dma_io_tlb_mem: Software IO TLB allocator.  Not for driver
> >> use.
> >>   * @dma_io_tlb_pools:	List of transient swiotlb memory
> >> pools.
> >>   * @dma_io_tlb_lock:	Protects changes to the list of
> >> active pools.
> >> + * @dma_uses_io_tlb: %true if device has used the software IO TLB.
> >>   * @archdata:	For arch-specific additions.
> >>   * @of_node:	Associated device tree node.
> >>   * @fwnode:	Associated device node supplied by platform
> >> firmware. @@ -737,6 +738,7 @@ struct device {
> >>  #ifdef CONFIG_SWIOTLB_DYNAMIC
> >>  	struct list_head dma_io_tlb_pools;
> >>  	spinlock_t dma_io_tlb_lock;
> >> +	bool dma_uses_io_tlb;  
> >
> > You add this new member here, fine...
> >  
> >>  #endif
> >>  	/* arch specific additions */
> >>  	struct dev_archdata	archdata;
> >> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> >> index 8371c92a0271..b4536626f8ff 100644
> >> --- a/include/linux/swiotlb.h
> >> +++ b/include/linux/swiotlb.h
> >> @@ -172,8 +172,13 @@ static inline bool is_swiotlb_buffer(struct
> >> device *dev, phys_addr_t paddr) if (!mem)
> >>  		return false;
> >>  
> >> -	if (IS_ENABLED(CONFIG_SWIOTLB_DYNAMIC))
> >> +	if (IS_ENABLED(CONFIG_SWIOTLB_DYNAMIC)) {
> >> +		/* Pairs with smp_wmb() in swiotlb_find_slots()
> >> and
> >> +		 * swiotlb_dyn_alloc(), which modify the RCU
> >> lists.
> >> +		 */
> >> +		smp_rmb();
> >>  		return swiotlb_find_pool(dev, paddr);
> >> +	}
> >>  	return paddr >= mem->defpool.start && paddr <
> >> mem->defpool.end; }
> >>  
> >> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> >> index adf80dec42d7..d7eac84f975b 100644
> >> --- a/kernel/dma/swiotlb.c
> >> +++ b/kernel/dma/swiotlb.c
> >> @@ -730,7 +730,7 @@ static void swiotlb_dyn_alloc(struct
> >> work_struct *work) 
> >>  	add_mem_pool(mem, pool);
> >>  
> >> -	/* Pairs with smp_rmb() in swiotlb_find_pool(). */
> >> +	/* Pairs with smp_rmb() in is_swiotlb_buffer(). */
> >>  	smp_wmb();
> >>  }
> >>  
> >> @@ -764,11 +764,6 @@ struct io_tlb_pool *swiotlb_find_pool(struct
> >> device *dev, phys_addr_t paddr) struct io_tlb_mem *mem =
> >> dev->dma_io_tlb_mem; struct io_tlb_pool *pool;
> >>  
> >> -	/* Pairs with smp_wmb() in swiotlb_find_slots() and
> >> -	 * swiotlb_dyn_alloc(), which modify the RCU lists.
> >> -	 */
> >> -	smp_rmb();
> >> -
> >>  	rcu_read_lock();
> >>  	list_for_each_entry_rcu(pool, &mem->pools, node) {
> >>  		if (paddr >= pool->start && paddr < pool->end)
> >> @@ -813,6 +808,7 @@ void swiotlb_dev_init(struct device *dev)
> >>  #ifdef CONFIG_SWIOTLB_DYNAMIC
> >>  	INIT_LIST_HEAD(&dev->dma_io_tlb_pools);
> >>  	spin_lock_init(&dev->dma_io_tlb_lock);
> >> +	dev->dma_uses_io_tlb = false;  
> >
> > ...here you initialize it, fine...
> >  
> >>  #endif
> >>  }
> >>  
> >> @@ -1157,9 +1153,11 @@ static int swiotlb_find_slots(struct device
> >> *dev, phys_addr_t orig_addr, list_add_rcu(&pool->node,
> >> &dev->dma_io_tlb_pools);
> >> spin_unlock_irqrestore(&dev->dma_io_tlb_lock, flags); 
> >> -	/* Pairs with smp_rmb() in swiotlb_find_pool(). */
> >> -	smp_wmb();
> >>  found:
> >> +	dev->dma_uses_io_tlb = true;
> >> +	/* Pairs with smp_rmb() in is_swiotlb_buffer() */
> >> +	smp_wmb();
> >> +  
> >
> > ...and here you set it if swiotlb is used.
> >
> > But, as far as I can tell, you don't actually *use* this field
> > anywhere. What am I missing?
> >
> > Thanks,
> >
> > jon  

