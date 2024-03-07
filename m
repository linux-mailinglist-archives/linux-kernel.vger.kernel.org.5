Return-Path: <linux-kernel+bounces-96083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6014D8756DD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3E6F1F22666
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DB21EF13;
	Thu,  7 Mar 2024 19:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYoeE/kM"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29614135A68
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 19:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709838991; cv=none; b=c21q7ZQRHCAmuNvBQXLG6iIe1E+9E7oDAdhOEFf9ZuH6+8pto81QeFq/VKppNOpq2tMl35qzXEKrPHH38dTv6Q4RozHvzZW8IPsWi2LpimxlfrD675AvpbrjiLsx4NBlPeFaWbm86lpHPmA2UcddJp80tSws5QA8TNFgnYPHVaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709838991; c=relaxed/simple;
	bh=x7BQ76O//NapXe3gdeT390Tm8e0JCj6TttWJIiSF0mg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqHskBlAEzFhf8q8OSJpWF/twOn4MbpRcR1u9Gh246XLcZJLDknKc5c21pRZOEMPVJCJaH3KRRWXWdWCE1hji83AKJssuwSUgnE3cNYhxDR0YFP1xVW4uw4j6ItZZ4oyKEgwWkALwdm1lw0v0Uaxsjbd9ReEffEINv/Uaqm1gcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYoeE/kM; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5131a9b3d5bso122400e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 11:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709838987; x=1710443787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4OUeKVtKJPLFMBmWIglHJRvn/ZfzCTXm54FGIBKHaik=;
        b=iYoeE/kMHs2LcPVBUaY8Zx4sFfOgyuAYP7LacolGIrElFhPdRtaxKD5AqD4TxFc9AT
         HSBGmwXCQNRZDVtEc70f7v8X92t/+K15ymFdkhvksvs38wnewztWuTjsY9lkFu+6JJ/B
         G2XygdakOCu0G2WKCLtV+ErwiaYHq9g/rr0sh8Zse+H0Lb6SmhDB5x7PvV87K6U6zXFw
         Jc7z/mSCl+yEgwpOD74TlUA3q6YeEQsRuZR7lmyanjzFDuJex6RmoD1DUc9TzGXW722l
         nr/S8SsxLANyR9OfEUgKOHW49m5RajLqNW1+zbVpY0ukn36qGf7GPUat7QnltxRg1trI
         rv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709838987; x=1710443787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OUeKVtKJPLFMBmWIglHJRvn/ZfzCTXm54FGIBKHaik=;
        b=LKcy9lGdqaGDsd1yAqIXWXN118tU792t345UKIhR+Url1YqgueY3miLNpBemO1BIUU
         R74zcWqTr+x8nYib4Av3iPw5xesZ53PHJo9gB+E61+elJYDMNYDS5SYyaN3h9ak5ej6A
         EkOOkEwzj0jWhP10KsrqwqkMWuIp/G/wjIcy1UMCMTgWpBgZPsRXOXUPVaFdsupT1a0l
         if1jT+JWUOj8eH5m8b71HnuBZ1NVw+4F6cnQ69zmbKk9NUF3GR6ZVScjHfogJfNgSNMS
         0tV7Venm+cYt6MS5tLww84BBUgPSk1d6xUPSQ0H2BREM7E0cuqemMDIZvnz0Ahwbq/Ov
         j2zA==
X-Forwarded-Encrypted: i=1; AJvYcCXoFz+trorUPKNYldIfIQGrnPAHJP3wRELdMekv2dz0zK3VZg8e0hVdWBFBbkv8WTO0LFHjWCxJTnVBvIRRgTfjFfCPkMqqR3cWb363
X-Gm-Message-State: AOJu0YwWEjRl5CLNOsYi3tXxFhCSIMswnV51z/qIMDAhZYsvVyF3hSuv
	Jy74YOVM4kK/GyDbzc0mZ08jy17soprZIA22xdz7c0Q4vIpSCa2s
X-Google-Smtp-Source: AGHT+IETE3KPsfvE6jVkSgFp0n9Sm44HxPyP9Xj7YlX8C58ohCu8YLqEbvp7hJTjJ/dm9RX8d/mLsA==
X-Received: by 2002:a05:6512:290:b0:513:49f7:70f with SMTP id j16-20020a056512029000b0051349f7070fmr2029999lfp.57.1709838986809;
        Thu, 07 Mar 2024 11:16:26 -0800 (PST)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id p4-20020a19f004000000b005131b457ee7sm3130537lfc.264.2024.03.07.11.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 11:16:26 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date: Thu, 7 Mar 2024 20:16:24 +0100
To: Baoquan He <bhe@redhat.com>, rulinhuang <rulin.huang@intel.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, rulinhuang <rulin.huang@intel.com>,
	akpm@linux-foundation.org, colin.king@intel.com, hch@infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lstoakes@gmail.com, tianyou.li@intel.com, tim.c.chen@intel.com,
	wangyang.guo@intel.com, zhiguo.zhou@intel.com
Subject: Re: [PATCH v7 1/2] mm/vmalloc: Moved macros with no functional
 change happened
Message-ID: <ZeoSiP-hOeHG89BJ@pc638.lan>
References: <20240301155417.1852290-1-rulin.huang@intel.com>
 <20240301155417.1852290-2-rulin.huang@intel.com>
 <Zei9n-VMxtzG8z4Y@pc636>
 <ZekW/nGXfTqOlvPZ@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZekW/nGXfTqOlvPZ@MiWiFi-R3L-srv>

On Thu, Mar 07, 2024 at 09:23:10AM +0800, Baoquan He wrote:
> On 03/06/24 at 08:01pm, Uladzislau Rezki wrote:
> > On Fri, Mar 01, 2024 at 10:54:16AM -0500, rulinhuang wrote:
> ......
> > 
> > Sorry for the late answer, i also just noticed this email. It was not in
> > my inbox...
> > 
> > OK, now you move part of the per-cpu allocator on the top and leave
> > another part down making it split. This is just for the:
> > 
> > BUG_ON(va_flags & VMAP_RAM);
> > 
> > VMAP_RAM macro. Do we really need this BUG_ON()?
> 
> Sorry, I suggested that when reviewing v5:
> https://lore.kernel.org/all/ZdiltpK5fUvwVWtD@MiWiFi-R3L-srv/T/#u
> 
> About part of per-cpu kva allocator moving and the split making, I would
> argue that we will have vmap_nodes defintion and basic helper functions
> like addr_to_node_id() etc at top, and leave other part like
> size_to_va_pool(), node_pool_add_va() etc down. These are similar.
> 
> While about whether we should add 'BUG_ON(va_flags & VMAP_RAM);', I am
> not sure about it. When I suggested that, I am also hesitant. From the
> current code, alloc_vmap_area() is called in below three functions, only
> __get_vm_area_node() will pass the non-NULL vm. 
>  new_vmap_block()     -|
>  vm_map_ram()         ----> alloc_vmap_area()
>  __get_vm_area_node() -|
> 
> It could be wrongly passed in the future? Only checking if vm is
> non-NULL makes me feel a little unsafe. While I am fine if removing the
> BUG_ON, because there's no worry in the current code. We can wait and
> see in the future.
> 
>        if (vm) {
>                BUG_ON(va_flags & VMAP_RAM);
>                setup_vmalloc_vm(vm, va, flags, caller);
>        }
> 
I would remove it, because it is really hard to mess it, there is only
one place also BUG_ON() is really a show stopper. I really appreciate
what rulinhuang <rulin.huang@intel.com> is doing and i understand that
it might be not so easy.

So, if we can avoid of moving the code, that looks to me that we can do,
if we can pass less arguments into alloc_vmap_area() since it is overloaded 
that would be great.

Just an example:

<snip>
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 25a8df497255..b6050e018539 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1841,6 +1841,30 @@ node_alloc(unsigned long size, unsigned long align,
 	return va;
 }
 
+static inline void
+__pre_setup_vmalloc_vm(struct vm_struct *vm,
+		unsigned long flags, const void *caller)
+{
+	vm->flags = flags;
+	vm->caller = caller;
+}
+
+static inline void
+__post_setup_vmalloc_vm(struct vm_struct *vm, struct vmap_area *va)
+{
+	vm->addr = (void *)va->va_start;
+	vm->size = va->va_end - va->va_start;
+	va->vm = vm;
+}
+
+static inline void
+setup_vmalloc_vm_locked(struct vm_struct *vm, struct vmap_area *va,
+		unsigned long flags, const void *caller)
+{
+	__pre_setup_vmalloc_vm(vm, flags, caller);
+	__post_setup_vmalloc_vm(vm, va);
+}
+
 /*
  * Allocate a region of KVA of the specified size and alignment, within the
  * vstart and vend.
@@ -1849,7 +1873,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 				unsigned long align,
 				unsigned long vstart, unsigned long vend,
 				int node, gfp_t gfp_mask,
-				unsigned long va_flags)
+				unsigned long va_flags, struct vm_struct *vm)
 {
 	struct vmap_node *vn;
 	struct vmap_area *va;
@@ -1912,6 +1936,9 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	va->vm = NULL;
 	va->flags = (va_flags | vn_id);
 
+	if (vm)
+		__post_setup_vmalloc_vm(vm, va);
+
 	vn = addr_to_node(va->va_start);
 
 	spin_lock(&vn->busy.lock);
@@ -2486,7 +2513,7 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 	va = alloc_vmap_area(VMAP_BLOCK_SIZE, VMAP_BLOCK_SIZE,
 					VMALLOC_START, VMALLOC_END,
 					node, gfp_mask,
-					VMAP_RAM|VMAP_BLOCK);
+					VMAP_RAM|VMAP_BLOCK, NULL);
 	if (IS_ERR(va)) {
 		kfree(vb);
 		return ERR_CAST(va);
@@ -2843,7 +2870,8 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node)
 		struct vmap_area *va;
 		va = alloc_vmap_area(size, PAGE_SIZE,
 				VMALLOC_START, VMALLOC_END,
-				node, GFP_KERNEL, VMAP_RAM);
+				node, GFP_KERNEL, VMAP_RAM, NULL);
+
 		if (IS_ERR(va))
 			return NULL;
 
@@ -2946,26 +2974,6 @@ void __init vm_area_register_early(struct vm_struct *vm, size_t align)
 	kasan_populate_early_vm_area_shadow(vm->addr, vm->size);
 }
 
-static inline void setup_vmalloc_vm_locked(struct vm_struct *vm,
-	struct vmap_area *va, unsigned long flags, const void *caller)
-{
-	vm->flags = flags;
-	vm->addr = (void *)va->va_start;
-	vm->size = va->va_end - va->va_start;
-	vm->caller = caller;
-	va->vm = vm;
-}
-
-static void setup_vmalloc_vm(struct vm_struct *vm, struct vmap_area *va,
-			      unsigned long flags, const void *caller)
-{
-	struct vmap_node *vn = addr_to_node(va->va_start);
-
-	spin_lock(&vn->busy.lock);
-	setup_vmalloc_vm_locked(vm, va, flags, caller);
-	spin_unlock(&vn->busy.lock);
-}
-
 static void clear_vm_uninitialized_flag(struct vm_struct *vm)
 {
 	/*
@@ -3002,14 +3010,15 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
 	if (!(flags & VM_NO_GUARD))
 		size += PAGE_SIZE;
 
-	va = alloc_vmap_area(size, align, start, end, node, gfp_mask, 0);
+	/* post-setup is done in the alloc_vmap_area(). */
+	__pre_setup_vmalloc_vm(area, flags, caller);
+
+	va = alloc_vmap_area(size, align, start, end, node, gfp_mask, 0, area);
 	if (IS_ERR(va)) {
 		kfree(area);
 		return NULL;
 	}
 
-	setup_vmalloc_vm(area, va, flags, caller);
-
 	/*
 	 * Mark pages for non-VM_ALLOC mappings as accessible. Do it now as a
 	 * best-effort approach, as they can be mapped outside of vmalloc code.
<snip>

--
Uladzislau Rezki

