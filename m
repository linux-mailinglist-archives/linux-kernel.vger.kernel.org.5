Return-Path: <linux-kernel+bounces-28378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F9D82FDC6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 00:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56E8B1F231A6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B472767C5F;
	Tue, 16 Jan 2024 23:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PczZcVmt"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B66167C51
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 23:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705448337; cv=none; b=LYQv9V+kMz9mvf2b+RxFERKqFgJIf8vkXNraPrHxK3KOL4+OBKcKrO/pr1gWoJq15tTStS72AQmOlE39PhiYQWX9enJC/+QViikLJm/2sGHLTL+IHbz7w4kPWXhMVdr8BFOjlJDcDkvDiO9wLtRSy47LrHnjGuinyf5zE0sg9AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705448337; c=relaxed/simple;
	bh=5etvGiu0T1Ci4UCNSgDgRVXFJ3x+Z9Hw03OC4MTU39A=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jKDg1CFUVKabHITmnpbgrcrlLxK87/GNIk5Kckiv6vgLXvAqsA7kdFRn1iUBlcS0KMan7FuDi9g4Cm8gAsS4aACe7oP5KEuIZJ8/LgW4L5UCcn1TxjHESYKlXaMDDBasKbHWXZXKzbqlUiKFwaUQniDzPx0nUaVuAuG3xuoakUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PczZcVmt; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e879cf632so4649955e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 15:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705448330; x=1706053130; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BxQ/BWYR+PjxzLrNnVyzasE/2yl2t/5YvcquSYRLHa4=;
        b=PczZcVmttdB2oNtEaUOd1mZx1188UY/XeuxJ6SKjTr6INC1DUPZkL9alXjSQY8sY1K
         ag9KH7Zp+Rc9CG74yyVTSzRbj6+H9Lrkkih74oZNbEuau1kYv2TU/w2EfLn8ADOmtFp5
         Rc+GlNTNoVugiU1TTSrNvCxleZQLqNozBSLoVfVbTXX1W7UTVJDILwLONkQLJMUFxCUU
         K/1ig7JnREPPXBgE00LKxoI9ip0BWULP9tGta/K96tZx9pUBjbxH13SeZaq5Vy41H6tx
         LOs+dj92R11E/Gm9tKJ39kIVG8/07iBDd5IbKsDsqDCk3exOFe3RMniJEsAVs0gey0Sx
         AVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705448330; x=1706053130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxQ/BWYR+PjxzLrNnVyzasE/2yl2t/5YvcquSYRLHa4=;
        b=AUuKbyc1X8aLtBqQR6y5XoAJCuZPyZxSm8+VfmsZPOgvVojGF/aq0ePs6BjWE4usYI
         LAUWT8R7ZdfhlZj+Ku8QhOrOFQsha+zRXj/aSW1mw4A2mZlrYuN3CH5Dyxwhf0WosoER
         ZY9EBoeMD5WdEgqtUjfgBPAEsWGlwJH5wFTBqgMZ6RIcTBqWXmrC7AlYiatIXyHBRF96
         OKM6ONtb4qEfSXNHj1byxvXKQB5UQffXFO8J195lc6CfY1APMs2OxrJ2ejtJCRSye3iX
         rTfqrpq6x2ulTpjp4eBXvtOKVKeNt0rID5ZnPuSmqC5sOgxffwEnuxn1y5KmJAfGy6LI
         GXww==
X-Gm-Message-State: AOJu0YxOlKyxmFBvHfWIoR/T+diRwc4winyFL95t/tfLUEcxUCvMjrx0
	wbt77+PXh01Ul8lb8TDBl54=
X-Google-Smtp-Source: AGHT+IEjCsioEZdDVJlyKy7MIaIRPNF+lvtLUa1ogCBD9vDCKU+cVFFygcJqpJOV53yY86Wy//8LpA==
X-Received: by 2002:a7b:cd82:0:b0:40e:6930:4c99 with SMTP id y2-20020a7bcd82000000b0040e69304c99mr1719322wmj.113.1705448330318;
        Tue, 16 Jan 2024 15:38:50 -0800 (PST)
Received: from localhost (host86-162-136-255.range86-162.btcentralplus.com. [86.162.136.255])
        by smtp.gmail.com with ESMTPSA id o31-20020a05600c511f00b0040e703ad630sm11812802wms.22.2024.01.16.15.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 15:38:49 -0800 (PST)
Date: Tue, 16 Jan 2024 23:36:35 +0000
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Dave Chinner <david@fromorbit.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v3 05/11] mm/vmalloc: remove vmap_area_list
Message-ID: <a5926122-cc27-43c0-b937-a70aa77a4005@lucifer.local>
References: <20240102184633.748113-1-urezki@gmail.com>
 <20240102184633.748113-6-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102184633.748113-6-urezki@gmail.com>

On Tue, Jan 02, 2024 at 07:46:27PM +0100, Uladzislau Rezki (Sony) wrote:
> From: Baoquan He <bhe@redhat.com>
>
> Earlier, vmap_area_list is exported to vmcoreinfo so that makedumpfile
> get the base address of vmalloc area. Now, vmap_area_list is empty, so
> export VMALLOC_START to vmcoreinfo instead, and remove vmap_area_list.
>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  Documentation/admin-guide/kdump/vmcoreinfo.rst | 8 ++++----
>  arch/arm64/kernel/crash_core.c                 | 1 -
>  arch/riscv/kernel/crash_core.c                 | 1 -
>  include/linux/vmalloc.h                        | 1 -
>  kernel/crash_core.c                            | 4 +---
>  kernel/kallsyms_selftest.c                     | 1 -
>  mm/nommu.c                                     | 2 --
>  mm/vmalloc.c                                   | 2 --
>  8 files changed, 5 insertions(+), 15 deletions(-)
>
> diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> index 78e4d2e7ba14..df54fbeaaa16 100644
> --- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
> +++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> @@ -65,11 +65,11 @@ Defines the beginning of the text section. In general, _stext indicates
>  the kernel start address. Used to convert a virtual address from the
>  direct kernel map to a physical address.
>
> -vmap_area_list
> ---------------
> +VMALLOC_START
> +-------------
>
> -Stores the virtual area list. makedumpfile gets the vmalloc start value
> -from this variable and its value is necessary for vmalloc translation.
> +Stores the base address of vmalloc area. makedumpfile gets this value
> +since is necessary for vmalloc translation.
>
>  mem_map
>  -------
> diff --git a/arch/arm64/kernel/crash_core.c b/arch/arm64/kernel/crash_core.c
> index 66cde752cd74..2a24199a9b81 100644
> --- a/arch/arm64/kernel/crash_core.c
> +++ b/arch/arm64/kernel/crash_core.c
> @@ -23,7 +23,6 @@ void arch_crash_save_vmcoreinfo(void)
>  	/* Please note VMCOREINFO_NUMBER() uses "%d", not "%x" */
>  	vmcoreinfo_append_str("NUMBER(MODULES_VADDR)=0x%lx\n", MODULES_VADDR);
>  	vmcoreinfo_append_str("NUMBER(MODULES_END)=0x%lx\n", MODULES_END);
> -	vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
>  	vmcoreinfo_append_str("NUMBER(VMALLOC_END)=0x%lx\n", VMALLOC_END);
>  	vmcoreinfo_append_str("NUMBER(VMEMMAP_START)=0x%lx\n", VMEMMAP_START);
>  	vmcoreinfo_append_str("NUMBER(VMEMMAP_END)=0x%lx\n", VMEMMAP_END);
> diff --git a/arch/riscv/kernel/crash_core.c b/arch/riscv/kernel/crash_core.c
> index 8706736fd4e2..d18d529fd9b9 100644
> --- a/arch/riscv/kernel/crash_core.c
> +++ b/arch/riscv/kernel/crash_core.c
> @@ -8,7 +8,6 @@ void arch_crash_save_vmcoreinfo(void)
>  	VMCOREINFO_NUMBER(phys_ram_base);
>
>  	vmcoreinfo_append_str("NUMBER(PAGE_OFFSET)=0x%lx\n", PAGE_OFFSET);
> -	vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
>  	vmcoreinfo_append_str("NUMBER(VMALLOC_END)=0x%lx\n", VMALLOC_END);
>  #ifdef CONFIG_MMU
>  	VMCOREINFO_NUMBER(VA_BITS);
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index c720be70c8dd..91810b4e9510 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -253,7 +253,6 @@ extern long vread_iter(struct iov_iter *iter, const char *addr, size_t count);
>  /*
>   *	Internals.  Don't use..
>   */
> -extern struct list_head vmap_area_list;
>  extern __init void vm_area_add_early(struct vm_struct *vm);
>  extern __init void vm_area_register_early(struct vm_struct *vm, size_t align);
>
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index d4313b53837e..b427f4a3b156 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -759,7 +759,7 @@ static int __init crash_save_vmcoreinfo_init(void)
>  	VMCOREINFO_SYMBOL_ARRAY(swapper_pg_dir);
>  #endif
>  	VMCOREINFO_SYMBOL(_stext);
> -	VMCOREINFO_SYMBOL(vmap_area_list);
> +	vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
>
>  #ifndef CONFIG_NUMA
>  	VMCOREINFO_SYMBOL(mem_map);
> @@ -800,8 +800,6 @@ static int __init crash_save_vmcoreinfo_init(void)
>  	VMCOREINFO_OFFSET(free_area, free_list);
>  	VMCOREINFO_OFFSET(list_head, next);
>  	VMCOREINFO_OFFSET(list_head, prev);
> -	VMCOREINFO_OFFSET(vmap_area, va_start);
> -	VMCOREINFO_OFFSET(vmap_area, list);
>  	VMCOREINFO_LENGTH(zone.free_area, MAX_ORDER + 1);
>  	log_buf_vmcoreinfo_setup();
>  	VMCOREINFO_LENGTH(free_area.free_list, MIGRATE_TYPES);
> diff --git a/kernel/kallsyms_selftest.c b/kernel/kallsyms_selftest.c
> index b4cac76ea5e9..8a689b4ff4f9 100644
> --- a/kernel/kallsyms_selftest.c
> +++ b/kernel/kallsyms_selftest.c
> @@ -89,7 +89,6 @@ static struct test_item test_items[] = {
>  	ITEM_DATA(kallsyms_test_var_data_static),
>  	ITEM_DATA(kallsyms_test_var_bss),
>  	ITEM_DATA(kallsyms_test_var_data),
> -	ITEM_DATA(vmap_area_list),
>  #endif
>  };
>
> diff --git a/mm/nommu.c b/mm/nommu.c
> index b6dc558d3144..5ec8f44e7ce9 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -131,8 +131,6 @@ int follow_pfn(struct vm_area_struct *vma, unsigned long address,
>  }
>  EXPORT_SYMBOL(follow_pfn);
>
> -LIST_HEAD(vmap_area_list);
> -
>  void vfree(const void *addr)
>  {
>  	kfree(addr);
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 786ecb18ae22..8c01f2225ef7 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -729,8 +729,6 @@ EXPORT_SYMBOL(vmalloc_to_pfn);
>
>
>  static DEFINE_SPINLOCK(free_vmap_area_lock);
> -/* Export for kexec only */
> -LIST_HEAD(vmap_area_list);
>  static bool vmap_initialized __read_mostly;
>
>  static struct rb_root purge_vmap_area_root = RB_ROOT;
> --
> 2.39.2
>

Looks good to me, I'm not _hugely_ familiar with this crash core stuff so:

Acked-by: Lorenzo Stoakes <lstoakes@gmail.com>

