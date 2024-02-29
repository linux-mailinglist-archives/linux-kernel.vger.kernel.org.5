Return-Path: <linux-kernel+bounces-86556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C27486C6FF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A886EB27191
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FA67995E;
	Thu, 29 Feb 2024 10:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Awnze/Ea"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1553F79B7A
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 10:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709202813; cv=none; b=lCjTOvKElEX7aT4xecB/FgFr7KX8SebIu/+9+SGCe6JJUNMhD9EtQMZafdtnQcW8sCR3IwlHeH2tNaJ7bO6wbQ0h7oUAhgQG7ywg3lZkHG7pumt8gNy/vToo4PHD8UYd+yIPXHxaSvEku9i1h6LQn32Q40HLO81bPJJCvyfqJdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709202813; c=relaxed/simple;
	bh=0143QA1Xyj0N42m47GM1F46kirWTT27+RVAWs5tQJok=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWZZdt6N+YvnvNVU2rZc6MF07LMf+grXIffUPtw+y56Tj+QLfZC+Vgc0NURY2wCLgA44PTPdECrUv+NQb20ekt/i/ZNK/nUuXvhVzo4XWZr7+1WKDriUOcEEGY2aa9uQ9IWoFSZobx2B9syxJZkDhlbwL8u6K0EIhXQY60GI830=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Awnze/Ea; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5132b1c9f7fso179358e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 02:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709202808; x=1709807608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nQl+fyrc7gr5M0XagvOsbZaoINJk1clL/Vv0rjJoV4s=;
        b=Awnze/EaknmgRud32YeWaZ3yOJLY6dSPsNY6ALVT9QtgYnflsaLF5b2IBlX0oJv/eV
         aiVHZ4qph2w0jUuJSmwIKPOCxdYngk3VzPomIOFgOIAW3+1EkZJoAzn2trGSvy2IO4JR
         Zfv5rMNKnRojI7RO4Sn5ESAToIUVaH+qzwKCxpjjJvoI4SpnfJuR4wdki+ZroiQuniJJ
         5Y54z1I9xM7nC23aH70ZQEDfdqfN2x0E26SoPaiqvqkeAdhPL3sm5U1SQlKNuhNlgNse
         CxS4rDJgVCduesIwSqsFKp2xMpLh3NYkcip6Dwe1JZl8W8kjh+0I9wnnJaTRJPAw84dB
         b7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709202808; x=1709807608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQl+fyrc7gr5M0XagvOsbZaoINJk1clL/Vv0rjJoV4s=;
        b=WBZpcH7+OUPAFL650PLFlUsj/Ez46jiTnV+1Y5X167uyNTMlW6GvmYsVs/u1ZM00iL
         n6si7kLYtQaEQQRY/YANBG9stNbUj/KgQnOFQWucY8hUlI2FKhEX8KtevK3/3GEAXW2V
         6ParzLBqLk5PWROU2bE1K2nn2tr5f6Q/VZRTrauvyDj1RkZoKeA4M+lSEu3MyyFW5cpv
         NIGb1jhPuVH8+OBUM1tPg93ywfcbdt7hb7oT+jH1N3x23TdCGz0NB1t3OjxeGe1S8isU
         707nTI8eWdwij1ZApWimpseiRfVtQ9BJh3hXofTAAMnYPjmaUUcU1uVFO+703/gZZX0l
         nFBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU56kPAKUWuzW0a8E5fqZcBf6FMc3Pn+hBKvIwL95n9G7DEG+nVHKyW3LlOEJZSOiu7ypFwljDAL/WdtErQyEe2+gXUuB6/oTeEmYKe
X-Gm-Message-State: AOJu0Yzzd7vNy6Gs3HW65vkC/seItdMw7PAeNz64q+kq4g1mIYccMItY
	krVpCgmT+zx0uY6V5DK230a2CtAhblBw0OUvNd+pMC85iTXZU4fuI22AhJxVsSo=
X-Google-Smtp-Source: AGHT+IFWyjKjAlNiSjqaRPUs0Xu6bGmQJGy4LpaFWeaebN2VSos2G1fvUr4d/OWaFa8UC3DEJ1Beaw==
X-Received: by 2002:ac2:43d0:0:b0:513:2473:9b93 with SMTP id u16-20020ac243d0000000b0051324739b93mr997542lfl.8.1709202807738;
        Thu, 29 Feb 2024 02:33:27 -0800 (PST)
Received: from pc636 (host-90-233-206-150.mobileonline.telia.com. [90.233.206.150])
        by smtp.gmail.com with ESMTPSA id a15-20020a056512200f00b00512daaef13bsm201261lfb.102.2024.02.29.02.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 02:33:27 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 29 Feb 2024 11:33:24 +0100
To: Baoquan He <bhe@redhat.com>, rulinhuang <rulin.huang@intel.com>
Cc: rulinhuang <rulin.huang@intel.com>, urezki@gmail.com,
	akpm@linux-foundation.org, colin.king@intel.com, hch@infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lstoakes@gmail.com, tianyou.li@intel.com, tim.c.chen@intel.com,
	wangyang.guo@intel.com, zhiguo.zhou@intel.com
Subject: Re: [PATCH v6] mm/vmalloc: lock contention optimization under
 multi-threading
Message-ID: <ZeBddOuKQKHO0V6b@pc636>
References: <20240229082611.4104839-1-rulin.huang@intel.com>
 <ZeBYcCAdHBCiDJkz@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeBYcCAdHBCiDJkz@MiWiFi-R3L-srv>

On Thu, Feb 29, 2024 at 06:12:00PM +0800, Baoquan He wrote:
> Hi Rulin,
> 
> Thanks for the great work and v6, some concerns, please see inline
> comments.
> 
> On 02/29/24 at 12:26am, rulinhuang wrote:
> > When allocating a new memory area where the mapping address range is
> > known, it is observed that the vmap_node->busy.lock is acquired twice.
> > 
> > The first acquisition occurs in the alloc_vmap_area() function when
> > inserting the vm area into the vm mapping red-black tree. The second
> > acquisition occurs in the setup_vmalloc_vm() function when updating the
> > properties of the vm, such as flags and address, etc.
> > 
> > Combine these two operations together in alloc_vmap_area(), which
> > improves scalability when the vmap_node->busy.lock is contended.
> > By doing so, the need to acquire the lock twice can also be eliminated
> >  to once.
> > 
> > With the above change, tested on intel sapphire rapids
> > platform(224 vcpu), a 4% performance improvement is
> > gained on stress-ng/pthread(https://github.com/ColinIanKing/stress-ng),
> > which is the stress test of thread creations.
> > 
> > Reviewed-by: Uladzislau Rezki <urezki@gmail.com>
> > Reviewed-by: Baoquan He <bhe@redhat.com>
> > Reviewed-by: "Chen, Tim C" <tim.c.chen@intel.com>
> > Reviewed-by: "King, Colin" <colin.king@intel.com>
> 
> 
> We possibly need remove these reviewers' tags when new code change is
> taken so that people check and add Acked-by or Reviewed-by again if then
> agree, or add new comments if any concern.
> 
> > Signed-off-by: rulinhuang <rulin.huang@intel.com>
> > ---
> > V1 -> V2: Avoided the partial initialization issue of vm and
> > separated insert_vmap_area() from alloc_vmap_area()
> > V2 -> V3: Rebased on 6.8-rc5
> > V3 -> V4: Rebased on mm-unstable branch
> > V4 -> V5: cancel the split of alloc_vmap_area()
> > and keep insert_vmap_area()
> > V5 -> V6: add bug_on
> > ---
> >  mm/vmalloc.c | 132 +++++++++++++++++++++++++--------------------------
> >  1 file changed, 64 insertions(+), 68 deletions(-)
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 25a8df497255..5ae028b0d58d 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -1841,15 +1841,66 @@ node_alloc(unsigned long size, unsigned long align,
> >  	return va;
> >  }
> >  
> > +/*** Per cpu kva allocator ***/
> > +
> > +/*
> > + * vmap space is limited especially on 32 bit architectures. Ensure there is
> > + * room for at least 16 percpu vmap blocks per CPU.
> > + */
> > +/*
> > + * If we had a constant VMALLOC_START and VMALLOC_END, we'd like to be able
> > + * to #define VMALLOC_SPACE		(VMALLOC_END-VMALLOC_START). Guess
> > + * instead (we just need a rough idea)
> > + */
> > +#if BITS_PER_LONG == 32
> > +#define VMALLOC_SPACE		(128UL*1024*1024)
> > +#else
> > +#define VMALLOC_SPACE		(128UL*1024*1024*1024)
> > +#endif
> > +
> > +#define VMALLOC_PAGES		(VMALLOC_SPACE / PAGE_SIZE)
> > +#define VMAP_MAX_ALLOC		BITS_PER_LONG	/* 256K with 4K pages */
> > +#define VMAP_BBMAP_BITS_MAX	1024	/* 4MB with 4K pages */
> > +#define VMAP_BBMAP_BITS_MIN	(VMAP_MAX_ALLOC*2)
> > +#define VMAP_MIN(x, y)		((x) < (y) ? (x) : (y)) /* can't use min() */
> > +#define VMAP_MAX(x, y)		((x) > (y) ? (x) : (y)) /* can't use max() */
> > +#define VMAP_BBMAP_BITS		\
> > +		VMAP_MIN(VMAP_BBMAP_BITS_MAX,	\
> > +		VMAP_MAX(VMAP_BBMAP_BITS_MIN,	\
> > +			VMALLOC_PAGES / roundup_pow_of_two(NR_CPUS) / 16))
> > +
> > +#define VMAP_BLOCK_SIZE		(VMAP_BBMAP_BITS * PAGE_SIZE)
> > +
> > +/*
> > + * Purge threshold to prevent overeager purging of fragmented blocks for
> > + * regular operations: Purge if vb->free is less than 1/4 of the capacity.
> > + */
> > +#define VMAP_PURGE_THRESHOLD	(VMAP_BBMAP_BITS / 4)
> > +
> > +#define VMAP_RAM		0x1 /* indicates vm_map_ram area*/
> > +#define VMAP_BLOCK		0x2 /* mark out the vmap_block sub-type*/
> > +#define VMAP_FLAGS_MASK		0x3
> 
> These code moving is made because we need check VMAP_RAM in advance. We
> may need move all those data structures and basic helpers related to per
> cpu kva allocator up too to along with these macros, just as the newly
> introduced vmap_node does. If that's agreed, better be done in a
> separate patch. My personal opinion. Not sure if Uladzislau has
> different thoughts.
> 
> Other than this, the overall looks good to me.
> 
I agree, the split should be done. One is a preparation move saying that
no functional change happens and final one an actual change is.

--
Uladzislau Rezki

