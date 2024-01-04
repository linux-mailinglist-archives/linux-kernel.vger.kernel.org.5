Return-Path: <linux-kernel+bounces-16569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D59824062
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76026286279
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4888210F6;
	Thu,  4 Jan 2024 11:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="F+zpntJm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A12C208A6
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 11:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a279ce3aab9so46978166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 03:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1704366993; x=1704971793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6zqYkg8yk8zP0vzRSPS98tqeixvnsBHfftd361m6Is4=;
        b=F+zpntJmftruAc+MWbE3vedzArQ1EGZrE6NVfv8f/sxvtJxMfJr1Ir0yG1ysRwWBQh
         i4wTP0uBJyBjTNSlMm6K6h2ZM5/itO99V4Ab2TNr9y0jMiXnRgfvZHf8XpdbOaB5/YjA
         jnhVJtnap2Ue2RWUF6Cnv8EpR5H+ScTgR/ZA1mh03pjIa1yVU2SbhlcNjvpA/djhDL29
         U9jtQQ222JXVy8rloFDqdtLc9hZWph7/EkdQleIZWGHFcJ8t90Ad2W2exR/M9THK3ViZ
         R8sYDBnG9z5q0akXO+vur8a0Uff2vtiPAYbNaO66f5SOB72IPQQzTgkRO0NQnjVWWyRd
         ZfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704366993; x=1704971793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zqYkg8yk8zP0vzRSPS98tqeixvnsBHfftd361m6Is4=;
        b=nU7iQ9s00Fb7k54B/SwX6/HzDHnA7VMpOTBfOlSGeowxMocZteWAxK2JRz9/d+3yRc
         LheE4IMzTUwBVuwTA40VV/X7GVEAv7CdC91lNRQAa4SBE2Ody+7I3zgrlbJYxgE/c8d9
         N/4Ic1dd0lttgQ5MAL8LR0PYmxQH6CSum9dcblj6soe6GND5ixUFxiOixlNz0nP9ExKL
         wTAXpFWIEc/Jo+u5x06sdmNEoaWPK7mFiJ4i+YTl4tKvSlx2sOZB0eOh21tk+r0kWpOW
         YEPRrJVyxEqxFr6pdQX8197XGaNIXQ6w6rvqCT07O9H8rF+Qqj9GG/bzOu7fB3a3R74K
         Vs7g==
X-Gm-Message-State: AOJu0YxccWT5gTb2ivthbJWWnJlK5ilJnhP7I8nbCei4PJjWn0cy9T9K
	LhoGLTH/6np183W7ViqngIMtiIxZdEu5Tw==
X-Google-Smtp-Source: AGHT+IFKS6wv9L1TAw0aXFiLo+P9K0iu/ZQVSiHhV0dPtI/Qr6VzH6xarKf1rn+q35Ljo49uFB2Fng==
X-Received: by 2002:a17:906:5792:b0:a23:748e:f3eb with SMTP id k18-20020a170906579200b00a23748ef3ebmr122546ejq.286.1704366993185;
        Thu, 04 Jan 2024 03:16:33 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id ef13-20020a17090697cd00b00a28d2e95152sm596149ejb.129.2024.01.04.03.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 03:16:32 -0800 (PST)
Date: Thu, 4 Jan 2024 12:16:30 +0100
From: Petr Mladek <pmladek@suse.com>
To: Ruipeng Qi <ruipengqi7@gmail.com>
Cc: catalin.marinas@arm.com, will@kernel.org, bhe@redhat.com,
	vgoyal@redhat.com, dyoung@redhat.com, rostedt@goodmis.org,
	john.ogness@linutronix.de, senozhatsky@chromium.org,
	akpm@linux-foundation.org, qiruipeng@lixiang.com, maz@kernel.org,
	lecopzer.chen@mediatek.com, ardb@kernel.org, mark.rutland@arm.com,
	yury.norov@gmail.com, arnd@arndb.de, mcgrof@kernel.org,
	brauner@kernel.org, dianders@chromium.org, maninder1.s@samsung.com,
	michael.christie@oracle.com, samitolvanen@google.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org
Subject: Re: [RFC PATCH 2/7] osdump: reuse some code from crash_core to get
 vmcoreinfo
Message-ID: <ZZaTjl4Ngp7haNZZ@alley>
References: <20231221132522.547-1-ruipengqi7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221132522.547-1-ruipengqi7@gmail.com>

Hi Qi,

first, most people, including me, prefer to be in Cc for the entire patchset.
It helps to get the whole picture.

This mail is even worse because the other patches are not in the same
thread. As a result, I can't find the other patches even via lore,
see https://lore.kernel.org/all/20231221132522.547-1-ruipengqi7@gmail.com/


On Thu 2023-12-21 21:25:22, Ruipeng Qi wrote:
> From: qiruipeng <qiruipeng@lixiang.com>
> 
> Osdump is a new crash dumping solution like crash. It is interested in
> vmcoreinfo,too. Reuse some data and function from crash_core, but not full
> of them. So pick some code to get vmcoreinfo as needed.

> diff --git a/kernel/crash_core_mini.c b/kernel/crash_core_mini.c
> new file mode 100644
> index 000000000000..a0f8d0c79bba
> --- /dev/null
> +++ b/kernel/crash_core_mini.c
> @@ -0,0 +1,275 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * crash.c - kernel crash support code.
> + * Copyright (C) 2002-2004 Eric Biederman  <ebiederm@xmission.com>
> + */
> +
> +#include <linux/buildid.h>
> +#include <linux/init.h>
> +#include <linux/utsname.h>
> +#include <linux/vmalloc.h>
> +#include <linux/sizes.h>
> +#include <linux/kexec.h>
> +#include <linux/memory.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/memblock.h>
> +#include <linux/kexec.h>
> +#include <linux/kmemleak.h>
> +
> +#include <asm/page.h>
> +#include <asm/sections.h>
> +
> +#include <crypto/sha1.h>
> +
> +#include "kallsyms_internal.h"
> +#include "kexec_internal.h"
> +
> +/* Per cpu memory for storing cpu states in case of system crash. */
> +note_buf_t __percpu *crash_notes;
> +
> +/* vmcoreinfo stuff */
> +unsigned char *vmcoreinfo_data;
> +size_t vmcoreinfo_size;
> +u32 *vmcoreinfo_note;
> +
> +/* trusted vmcoreinfo, e.g. we can make a copy in the crash memory */
> +static unsigned char *vmcoreinfo_data_safecopy;
> +
> +
> +Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
> +			  void *data, size_t data_len)
> +{
> +	struct elf_note *note = (struct elf_note *)buf;
> +
> +	note->n_namesz = strlen(name) + 1;
> +	note->n_descsz = data_len;
> +	note->n_type   = type;
> +	buf += DIV_ROUND_UP(sizeof(*note), sizeof(Elf_Word));
> +	memcpy(buf, name, note->n_namesz);
> +	buf += DIV_ROUND_UP(note->n_namesz, sizeof(Elf_Word));
> +	memcpy(buf, data, data_len);
> +	buf += DIV_ROUND_UP(data_len, sizeof(Elf_Word));
> +
> +	return buf;
> +}
> +
> +void final_note(Elf_Word *buf)
> +{
> +	memset(buf, 0, sizeof(struct elf_note));
> +}
> +
> +static void update_vmcoreinfo_note(void)
> +{
> +	u32 *buf = vmcoreinfo_note;
> +
> +	if (!vmcoreinfo_size)
> +		return;
> +	buf = append_elf_note(buf, VMCOREINFO_NOTE_NAME, 0, vmcoreinfo_data,
> +			      vmcoreinfo_size);
> +	final_note(buf);
> +}
> +
> +void crash_update_vmcoreinfo_safecopy(void *ptr)
> +{
> +	if (ptr)
> +		memcpy(ptr, vmcoreinfo_data, vmcoreinfo_size);
> +
> +	vmcoreinfo_data_safecopy = ptr;
> +}
> +
> +void crash_save_vmcoreinfo(void)
> +{
> +	if (!vmcoreinfo_note)
> +		return;
> +
> +	/* Use the safe copy to generate vmcoreinfo note if have */
> +	if (vmcoreinfo_data_safecopy)
> +		vmcoreinfo_data = vmcoreinfo_data_safecopy;
> +
> +	vmcoreinfo_append_str("CRASHTIME=%lld\n", ktime_get_real_seconds());
> +	update_vmcoreinfo_note();
> +}
> +
> +void vmcoreinfo_append_str(const char *fmt, ...)
> +{
> +	va_list args;
> +	char buf[0x50];
> +	size_t r;
> +
> +	va_start(args, fmt);
> +	r = vscnprintf(buf, sizeof(buf), fmt, args);
> +	va_end(args);
> +
> +	r = min(r, (size_t)VMCOREINFO_BYTES - vmcoreinfo_size);
> +
> +	memcpy(&vmcoreinfo_data[vmcoreinfo_size], buf, r);
> +
> +	vmcoreinfo_size += r;
> +
> +	WARN_ONCE(vmcoreinfo_size == VMCOREINFO_BYTES,
> +		  "vmcoreinfo data exceeds allocated size, truncating");
> +}
> +
> +/*
> + * provide an empty default implementation here -- architecture
> + * code may override this
> + */
> +void __weak arch_crash_save_vmcoreinfo(void)
> +{}
> +
> +phys_addr_t __weak paddr_vmcoreinfo_note(void)
> +{
> +	return __pa(vmcoreinfo_note);
> +}
> +EXPORT_SYMBOL(paddr_vmcoreinfo_note);
> +
> +int get_note_size(void)
> +{
> +	return VMCOREINFO_NOTE_SIZE;
> +}
> +
> +static int __init crash_save_vmcoreinfo_init(void)
> +{
> +	vmcoreinfo_data = (unsigned char *)get_zeroed_page(GFP_KERNEL);
> +	if (!vmcoreinfo_data) {
> +		pr_warn("Memory allocation for vmcoreinfo_data failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	vmcoreinfo_note = alloc_pages_exact(VMCOREINFO_NOTE_SIZE,
> +						GFP_KERNEL | __GFP_ZERO);
> +	if (!vmcoreinfo_note) {
> +		free_page((unsigned long)vmcoreinfo_data);
> +		vmcoreinfo_data = NULL;
> +		pr_warn("Memory allocation for vmcoreinfo_note failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	VMCOREINFO_OSRELEASE(init_uts_ns.name.release);
> +	VMCOREINFO_BUILD_ID();
> +	VMCOREINFO_PAGESIZE(PAGE_SIZE);
> +
> +	VMCOREINFO_SYMBOL(init_uts_ns);
> +	VMCOREINFO_OFFSET(uts_namespace, name);
> +	VMCOREINFO_SYMBOL(node_online_map);
> +#ifdef CONFIG_MMU
> +	VMCOREINFO_SYMBOL_ARRAY(swapper_pg_dir);
> +#endif
> +	VMCOREINFO_SYMBOL(_stext);
> +	VMCOREINFO_SYMBOL(vmap_area_list);
> +
> +#ifndef CONFIG_NUMA
> +	VMCOREINFO_SYMBOL(mem_map);
> +	VMCOREINFO_SYMBOL(contig_page_data);
> +#endif
> +#ifdef CONFIG_SPARSEMEM
> +	VMCOREINFO_SYMBOL_ARRAY(mem_section);
> +	VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
> +	VMCOREINFO_STRUCT_SIZE(mem_section);
> +	VMCOREINFO_OFFSET(mem_section, section_mem_map);
> +	VMCOREINFO_NUMBER(SECTION_SIZE_BITS);
> +	VMCOREINFO_NUMBER(MAX_PHYSMEM_BITS);
> +#endif

[...]

It seems that this duplicates a lot of code from kernel/crash_core.c.
It is a bad idea and maintenance nightmare.

It is not acceptable from my POV. Please, split the shared code
into a separate source file.

BTW: Is it really a big deal to just share the entire vmcoreinfo?
     Osdump might just ignore entries which are not supported
     at the moment.

Best Regards,
Petr

