Return-Path: <linux-kernel+bounces-147852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 491718A7A84
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FC3C1C20C3E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D70567F;
	Wed, 17 Apr 2024 02:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBONOuAH"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193AC1878;
	Wed, 17 Apr 2024 02:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713320642; cv=none; b=n5T3iWcn7wZkrcCBxic5qKlZ4XwblyY94p40PrODZLGBrfyaLBL/UHPhGd+zTEOs4CvXVqrgWFQkYrpiEzfe2CSNwf0CctPYS4AMMt7RQDh/bwGt7ZVeYdm5u7/dnY/Dwnj0u07dmlIvX/0NFwJodmrF9zWSX02SqhRyZ3q4FYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713320642; c=relaxed/simple;
	bh=LfXfRWpiNEYP4GTs55nV/VzT+ZJapW6UCagO1mHjCTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qG5feNMSuGwUcN2FVDNKkqW+A6NRleHfQ0lb/RQ+yMzi5x09LfaT7MNTaytnDoy82W0w+gmsEQnXDJOF56jTzPuPNqo6Z3pm0vz0IjVtb5urO2l6VHWvn9r07aboECaZoCxJD6F+l7DWeU/FfT0vV4on5vdQl85845A5TRGdov0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBONOuAH; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a526d0b2349so353651366b.3;
        Tue, 16 Apr 2024 19:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713320639; x=1713925439; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epo1oT+++2cLMYZiFx2DX+JGf1s/GKSnrk05wKVL2aI=;
        b=HBONOuAH8jyESkBxAMy71gTeba6YQzP6OSXo2CL/LzSYw89KzrOOOOtCVqKWtRv1gp
         qdEPOt1DhwKorR/jJ2ALnGgVhwCSbE5f4Ud+KILBAFKyHcpxqoLQ82+Qmg2prwIXisWD
         2rLLVlDE+gpRKE86Rsn/XSxfquEIIaaOUb0YyadpqAZ1lIF6dRPz+N1ywdCc655y/ctV
         naPZt9Z3laFm99MaVdfd5tQKDeqbo7XwHqiBzPcM+ZYXLT9Ry/cL2idpmldPO2k7I7b8
         IKRsOWMwS6y3coPN5Ho7RD7S8D6MgoxJag+t0CTowgksLvprWl/gywS8tl3m7xp54t18
         nZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713320639; x=1713925439;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=epo1oT+++2cLMYZiFx2DX+JGf1s/GKSnrk05wKVL2aI=;
        b=hq7jV8LMSaqcHcYjD02xVupXWUZLC2jLQYmeCS0nBi+go/8Thlm3NutVHGqB9o6Fbk
         Yxvj+iyNjWzY/9JYb8vvzob+cQQj3RQilbUHnIhr18uWUxNNC/wO6V6Erjs7vN7pT9V+
         7w9G3yp+puc6YbmlKteJgtvqpovFB4Isdvk9JKxcmuu1xrTe7FJK8xA32ND4iMCXyhFk
         kD6B0DTkFY1R/qhsgfw4Adh6sso2vN+9ELtjBAtbeqngTSxlfW+FMO71W3/bx4WY7num
         Rhbwwy5VUM6gPf4Jq7abrurPHH4N2xLqCF5rGluV4dF5JGWkeO6taSNcRC5Mf2UCakzD
         l9zg==
X-Forwarded-Encrypted: i=1; AJvYcCXxx7t8Z3Ljr85adFljXvgSJnF5HvWjU/tdfwG4/iDxVv53AYiD3r0qAP5v2d1qCJmhqCcggsg7xUU6kkNjwRqqqy/LVs0zmemuIYLFs58Nk9iz+gDOzXi12HFCmUKgT9Zjz0uxdxYCog==
X-Gm-Message-State: AOJu0YzWrZSHjmFbMpTRBwkd0dI7suWl/XXpXjNb6ZfhOrGYmooZCDQ9
	elsQof3sZ+vzE8wWG2jjrPQqnamymoPfHJ9EBwkFI6w1q3XjnQBV
X-Google-Smtp-Source: AGHT+IEsEJ3oBX93oBSYOsmqLbKNJndsPIfuYLiWRnL0KyICPE0J7d/MnMYKik5hM5k+CpGN7fz/rw==
X-Received: by 2002:a17:906:3bc4:b0:a52:5d89:5f27 with SMTP id v4-20020a1709063bc400b00a525d895f27mr5324754ejf.14.1713320639180;
        Tue, 16 Apr 2024 19:23:59 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id ga31-20020a1709070c1f00b00a4e24d259edsm7451411ejc.167.2024.04.16.19.23.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2024 19:23:58 -0700 (PDT)
Date: Wed, 17 Apr 2024 02:23:57 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: skseofh@gmail.com
Cc: robh@kernel.org, saravanak@google.com, rppt@kernel.org,
	akpm@linux-foundation.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Daero Lee <daero_le.lee@samsung.com>
Subject: Re: [PATCH v2] memblock: add no-map alloc functions
Message-ID: <20240417022357.glrgkb5cg6ajxnqd@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <linux-mm@kvack.org>
 <20240416120635.361838-1-skseofh@gmail.com>
 <20240416120635.361838-2-skseofh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416120635.361838-2-skseofh@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Apr 16, 2024 at 09:06:35PM +0900, skseofh@gmail.com wrote:
>From: Daero Lee <daero_le.lee@samsung.com>
>
>Like reserved-memory with the 'no-map' property and only 'size' property
>(w/o 'reg' property), there are memory regions need to be allocated in
>memblock.memory marked with the MEMBLOCK_NOMAP flag, but should not be
>allocated in memblock.reserved.

We don't "allocate" memory from memblock.memory directly.

We present memory in memblock.memory and "allocate" a memory by marking it in
memblock.reserved.

>
>example : arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
>        reserved-memory {
>                #address-cells = <2>;
>                #size-cells = <2>;
>                ranges;
>
>                bman_fbpr: bman-fbpr {
>                        compatible = "shared-dma-pool";
>                        size = <0 0x1000000>;
>                        alignment = <0 0x1000000>;
>                        no-map;
>                };
>
>                qman_fqd: qman-fqd {
>                        compatible = "shared-dma-pool";
>                        size = <0 0x400000>;
>                        alignment = <0 0x400000>;
>                        no-map;
>                };
>
>                qman_pfdr: qman-pfdr {
>                        compatible = "shared-dma-pool";
>                        size = <0 0x2000000>;
>                        alignment = <0 0x2000000>;
>                        no-map;
>                };
>        };
>
>So, functions were added that find the required memory area in
>memblock.memory, but do not allocate it to memblock.reserved.
>
>In previous patch(a7259df), early_init_dt_alloc_reserved_memory was

You want to say this patch introduced a regression?

>modified to use memblock_phys_alloc_range allocating memory in
>memblock.reserved, instead of memblock_find_in_range that just find the
>available region. But if there is a 'no-map' property, memory region
>should not be allocated to memblock.reserved.

If my understanding is correct, memblock_phys_free() is called if 'no-map'
property is set. This would release the "allocation" in memblock.reserved.

>
>So, the early_init_dt_alloc_reserved_memory_arch function was modified
>using the no-map alloc function.
>
>Signed-off-by: Daero Lee <daero_le.lee@samsung.com>
>---
> drivers/of/of_reserved_mem.c |  9 +++--
> mm/memblock.c                | 78 ++++++++++++++++++++++++++++++++++++
> 2 files changed, 84 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
>index 8236ecae2953..504f2f60689c 100644
>--- a/drivers/of/of_reserved_mem.c
>+++ b/drivers/of/of_reserved_mem.c
>@@ -40,15 +40,18 @@ static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
> 
> 	end = !end ? MEMBLOCK_ALLOC_ANYWHERE : end;
> 	align = !align ? SMP_CACHE_BYTES : align;
>-	base = memblock_phys_alloc_range(size, align, start, end);
>+	if (nomap) {
>+		base = memblock_phys_alloc_range_nomap(size, align, start, end);
>+	} else {
>+		base = memblock_phys_alloc_range(size, align, start, end);
>+	}
>+	
> 	if (!base)
> 		return -ENOMEM;
> 
> 	*res_base = base;
> 	if (nomap) {
> 		err = memblock_mark_nomap(base, size);
>-		if (err)
>-			memblock_phys_free(base, size);

I see you removed it here, seems does the same as before.

> 	}
> 
> 	kmemleak_ignore_phys(base);
>diff --git a/mm/memblock.c b/mm/memblock.c
>index d09136e040d3..f103f1ecbfad 100644
>--- a/mm/memblock.c
>+++ b/mm/memblock.c
>@@ -1506,6 +1506,72 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
> 	return found;
> }
> 
>+phys_addr_t __init memblock_alloc_range_nid_nomap(phys_addr_t size,
>+                                        phys_addr_t align, phys_addr_t start,
>+                                        phys_addr_t end, int nid,
>+                                        bool exact_nid)
>+{
>+        enum memblock_flags flags = choose_memblock_flags();
>+        phys_addr_t found;
>+
>+        if (WARN_ONCE(nid == MAX_NUMNODES, "Usage of MAX_NUMNODES is deprecated. Use NUMA_NO_NODE instead\n"))
>+                nid = NUMA_NO_NODE;
>+
>+        if (!align) {
>+                /* Can't use WARNs this early in boot on powerpc */
>+                dump_stack();
>+                align = SMP_CACHE_BYTES;
>+        }
>+
>+again:
>+        found = memblock_find_in_range_node(size, align, start, end, nid,
>+                                            flags);
>+        if (found)
>+                goto done;
>+
>+        if (nid != NUMA_NO_NODE && !exact_nid) {
>+                found = memblock_find_in_range_node(size, align, start,
>+                                                    end, NUMA_NO_NODE,
>+                                                    flags);
>+                if (found)
>+                        goto done;
>+        }
>+
>+        if (flags & MEMBLOCK_MIRROR) {
>+                flags &= ~MEMBLOCK_MIRROR;
>+                pr_warn_ratelimited("Could not allocate %pap bytes of mirrored memory\n",
>+                        &size);
>+                goto again;
>+        }
>+
>+        return 0;
>+
>+done:
>+        /*
>+         * Skip kmemleak for those places like kasan_init() and
>+         * early_pgtable_alloc() due to high volume.
>+         */
>+        if (end != MEMBLOCK_ALLOC_NOLEAKTRACE)
>+                /*
>+                 * Memblock allocated blocks are never reported as
>+                 * leaks. This is because many of these blocks are
>+                 * only referred via the physical address which is
>+                 * not looked up by kmemleak.
>+                 */
>+                kmemleak_alloc_phys(found, size, 0);
>+
>+        /*
>+         * Some Virtual Machine platforms, such as Intel TDX or AMD SEV-SNP,
>+         * require memory to be accepted before it can be used by the
>+         * guest.
>+         *
>+         * Accept the memory of the allocated buffer.
>+         */
>+        accept_memory(found, found + size);
>+
>+        return found;
>+}
>+
> /**
>  * memblock_phys_alloc_range - allocate a memory block inside specified range
>  * @size: size of memory block to be allocated in bytes
>@@ -1530,6 +1596,18 @@ phys_addr_t __init memblock_phys_alloc_range(phys_addr_t size,
> 					false);
> }
> 
>+phys_addr_t __init memblock_phys_alloc_range_nomap(phys_addr_t size,
>+                                                   phys_addr_t align,
>+                                                   phys_addr_t start,
>+                                                   phys_addr_t end)
>+{
>+        memblock_dbg("%s: %llu bytes align=0x%llx from=%pa max_addr=%pa %pS\n",
>+                     __func__, (u64)size, (u64)align, &start, &end,
>+                     (void *)_RET_IP_);
>+        return memblock_alloc_range_nid_nomap(size, align, start, end, 
>+					      NUMA_NO_NODE, false);
>+}
>+
> /**
>  * memblock_phys_alloc_try_nid - allocate a memory block from specified NUMA node
>  * @size: size of memory block to be allocated in bytes
>-- 
>2.25.1
>

-- 
Wei Yang
Help you, Help me

