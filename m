Return-Path: <linux-kernel+bounces-5103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B6A818696
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 393EB1C23C7F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00A618AF3;
	Tue, 19 Dec 2023 11:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vYK5roC1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5EA1862B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 11:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40c32bea30dso47925e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 03:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702986463; x=1703591263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WKYUS8nd9z/w82LwXMjmDphAjvYpl6ryuYSpgDd10Z4=;
        b=vYK5roC12TqeVV2O+KxQjn1jiARSDKhAAuheEgO2qANQW+q+3+McIcv20+YFoABQOH
         WBtHzOgg1BrOGDjHHQ3M+bqL3M2LqiB3lr68CO1uONc0RYUKmDZ9kRJNR9+nt0tD+ZF6
         vB1xnpLAH5YuXqE5R8O1MuY/RG5nS0pMzdHnH8I2mN/t3eKLpIfq/2yFhbJ91ySgBZO8
         lDeNZlvhxODDMOyFDTgHerKm27Vq8YQ67Fwz2V6M1qo1zHOhL461RQcyBKFQoaaQZq6P
         huSaLiRulJAW3/3zM51NJHFk+lZPURoizON5WyymJ0UEz9NlrAAXqF3A4Jxoxs2m0hSh
         8qqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702986463; x=1703591263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKYUS8nd9z/w82LwXMjmDphAjvYpl6ryuYSpgDd10Z4=;
        b=c2EU6t2fyRXw4kE+HzHBzJt2aTvzzdrUVaKkfb74NpXC3XnIIM6deDxMSA7UseTi2V
         9KMRCjIKIqDCzUBwuS0UynpFfQ/XAEOUcBVak9+cbz5y0+8kxiVYsnchRyXa83EslUlL
         4qO8O5tt7N4BfS5NVKQgMFZ7qyQSsyk7Uo7dnDrgBQ38bT1S1LVeXXgnjMk8WmuhtQOf
         XcQM3sI9UqoSGZbeCRwuZVQvjbOchaR7Nkoqn1OucGvxw5ip+u6P9dTMKdVl2lkv9k5N
         /OKKSh0NXpkD5oXFXWKjL2ChnU9ptoGd13bQSPS6c5NyG1iP8SnyF+PkfB9Y8zShFSLq
         m1ZA==
X-Gm-Message-State: AOJu0Yw1jQ80GmNCQgU226oaHdpJCM3z8FQ5zTCTAz7ECsoBZ1pymLHt
	gdKM3P2X3XfBnxnbFE5P26NvhB19cAEu
X-Google-Smtp-Source: AGHT+IHuJBXW+M/1WdVf9NpQ6RzHQn7JcJLP1l/MFWfAJ2aC36CcAsttwAa+T6KS3V/tlBWUunX8qQ==
X-Received: by 2002:a05:600c:3ba8:b0:40d:2bc7:e9b with SMTP id n40-20020a05600c3ba800b0040d2bc70e9bmr36857wms.4.1702986462970;
        Tue, 19 Dec 2023 03:47:42 -0800 (PST)
Received: from google.com (185.83.140.34.bc.googleusercontent.com. [34.140.83.185])
        by smtp.gmail.com with ESMTPSA id y15-20020a056000108f00b003366464cae9sm6662436wrw.100.2023.12.19.03.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 03:47:42 -0800 (PST)
Date: Tue, 19 Dec 2023 11:47:40 +0000
From: Sebastian Ene <sebastianene@google.com>
To: will@kernel.org, Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>, catalin.marinas@arm.com,
	mark.rutland@arm.com, akpm@linux-foundation.org, maz@kernel.org
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	vdonnefort@google.com, qperret@google.com, smostafa@google.com
Subject: Re: [PATCH v4 02/10] KVM: arm64: Add ptdump registration with
 debugfs for the stage-2 pagetables
Message-ID: <ZYGC3F_UJB8U_wuD@google.com>
References: <20231218135859.2513568-2-sebastianene@google.com>
 <20231218135859.2513568-4-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218135859.2513568-4-sebastianene@google.com>

On Mon, Dec 18, 2023 at 01:58:52PM +0000, Sebastian Ene wrote:
> While arch/*/mem/ptdump handles the kernel pagetable dumping code,
> introduce KVM/ptdump which deals with the stage-2 pagetables. The
> separation is necessary because most of the definitions from the
> stage-2 pagetable reside in the KVM path and we will be invoking
> functionality **specific** to KVM.
> 
> This registers a wrapper on top of debugfs_create_file which allows us
> to hook callbacks on the debugfs open/show/close. The callbacks are used
> to prepare the display portion of the pagetable dumping code.
> Guard this functionality under the newly introduced PTDUMP_STAGE2_DEBUGFS.
> 
> Signed-off-by: Sebastian Ene <sebastianene@google.com>
> ---
>  arch/arm64/kvm/Kconfig      | 13 +++++
>  arch/arm64/kvm/Makefile     |  1 +
>  arch/arm64/kvm/arm.c        |  2 +
>  arch/arm64/kvm/kvm_ptdump.h | 18 +++++++
>  arch/arm64/kvm/ptdump.c     | 96 +++++++++++++++++++++++++++++++++++++
>  5 files changed, 130 insertions(+)
>  create mode 100644 arch/arm64/kvm/kvm_ptdump.h
>  create mode 100644 arch/arm64/kvm/ptdump.c
> 
> diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
> index 83c1e09be..0014e55e2 100644
> --- a/arch/arm64/kvm/Kconfig
> +++ b/arch/arm64/kvm/Kconfig
> @@ -71,4 +71,17 @@ config PROTECTED_NVHE_STACKTRACE
>  
>  	  If unsure, or not using protected nVHE (pKVM), say N.
>  
> +config PTDUMP_STAGE2_DEBUGFS
> +       bool "Present the stage-2 pagetables to debugfs"
> +       depends on PTDUMP_DEBUGFS && KVM
> +       default n
> +       help
> +         Say Y here if you want to show the stage-2 kernel pagetables
> +         layout in a debugfs file. This information is only useful for kernel developers
> +         who are working in architecture specific areas of the kernel.
> +         It is probably not a good idea to enable this feature in a production
> +         kernel.
> +
> +         If in doubt, say N.
> +
>  endif # VIRTUALIZATION
> diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
> index c0c050e53..190eac175 100644
> --- a/arch/arm64/kvm/Makefile
> +++ b/arch/arm64/kvm/Makefile
> @@ -23,6 +23,7 @@ kvm-y += arm.o mmu.o mmio.o psci.o hypercalls.o pvtime.o \
>  	 vgic/vgic-its.o vgic/vgic-debug.o
>  
>  kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o pmu.o
> +kvm-$(CONFIG_PTDUMP_STAGE2_DEBUGFS) += ptdump.o
>  
>  always-y := hyp_constants.h hyp-constants.s
>  
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index e5f75f1f1..ee8d7cb67 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -40,6 +40,7 @@
>  #include <asm/kvm_pkvm.h>
>  #include <asm/kvm_emulate.h>
>  #include <asm/sections.h>
> +#include <kvm_ptdump.h>
>  
>  #include <kvm/arm_hypercalls.h>
>  #include <kvm/arm_pmu.h>
> @@ -2592,6 +2593,7 @@ static __init int kvm_arm_init(void)
>  	if (err)
>  		goto out_subs;
>  
> +	kvm_ptdump_register_host();
>  	kvm_arm_initialised = true;
>  
>  	return 0;
> diff --git a/arch/arm64/kvm/kvm_ptdump.h b/arch/arm64/kvm/kvm_ptdump.h
> new file mode 100644
> index 000000000..98b595ce8
> --- /dev/null
> +++ b/arch/arm64/kvm/kvm_ptdump.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +//
> +// Copyright (C) Google, 2023
> +// Author: Sebastian Ene <sebastianene@google.com>
> +
> +#ifndef __KVM_PTDUMP_H
> +#define __KVM_PTDUMP_H
> +
> +#include <asm/ptdump.h>
> +
> +
> +#ifdef CONFIG_PTDUMP_STAGE2_DEBUGFS
> +void kvm_ptdump_register_host(void);
> +#else
> +static inline void kvm_ptdump_register_host(void) { }
> +#endif /* CONFIG_PTDUMP_STAGE2_DEBUGFS */
> +
> +#endif /* __KVM_PTDUMP_H */
> diff --git a/arch/arm64/kvm/ptdump.c b/arch/arm64/kvm/ptdump.c
> new file mode 100644
> index 000000000..5816fc632
> --- /dev/null
> +++ b/arch/arm64/kvm/ptdump.c
> @@ -0,0 +1,96 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +//
> +// Debug helper used to dump the stage-2 pagetables of the system and their
> +// associated permissions.
> +//
> +// Copyright (C) Google, 2023
> +// Author: Sebastian Ene <sebastianene@google.com>
> +
> +#include <linux/debugfs.h>
> +#include <linux/kvm_host.h>
> +#include <linux/seq_file.h>
> +
> +#include <asm/kvm_pkvm.h>
> +#include <kvm_ptdump.h>
> +
> +
> +struct kvm_ptdump_register {
> +	void *(*get_ptdump_info)(struct kvm_ptdump_register *reg);
> +	void (*put_ptdump_info)(void *priv);
> +	int (*show_ptdump_info)(struct seq_file *m, void *v);
> +	void *priv;
> +};
> +
> +static int kvm_ptdump_open(struct inode *inode, struct file *file);
> +static int kvm_ptdump_release(struct inode *inode, struct file *file);
> +static int kvm_ptdump_show(struct seq_file *m, void *);
> +
> +static const struct file_operations kvm_ptdump_fops = {
> +	.open		= kvm_ptdump_open,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= kvm_ptdump_release,
> +};
> +
> +static int kvm_ptdump_open(struct inode *inode, struct file *file)
> +{
> +	struct kvm_ptdump_register *reg = inode->i_private;
> +	void *info = NULL;
> +	int ret;
> +
> +	if (reg->get_ptdump_info) {
> +		info = reg->get_ptdump_info(reg);
> +		if (!info)
> +			return -ENOMEM;
> +	}
> +
> +	if (!reg->show_ptdump_info)
> +		reg->show_ptdump_info = kvm_ptdump_show;
> +
> +	ret = single_open(file, reg->show_ptdump_info, info);
> +	if (ret && reg->put_ptdump_info)
> +		reg->put_ptdump_info(info);
> +
> +	return ret;
> +}
> +
> +static int kvm_ptdump_release(struct inode *inode, struct file *file)
> +{
> +	struct kvm_ptdump_register *reg = inode->i_private;
> +	struct seq_file *seq_file = file->private_data;
> +
> +	if (reg->put_ptdump_info)
> +		reg->put_ptdump_info(seq_file->private);
> +

Call single_release here.

> +	return 0;
> +}
> +
> +static int kvm_ptdump_show(struct seq_file *m, void *)
> +{
> +	return -EINVAL;
> +}
> +
> +static void kvm_ptdump_debugfs_register(struct kvm_ptdump_register *reg,
> +					const char *name, struct dentry *parent)
> +{
> +	debugfs_create_file(name, 0400, parent, reg, &kvm_ptdump_fops);
> +}
> +
> +static struct kvm_ptdump_register host_reg;
> +
> +void kvm_ptdump_register_host(void)
> +{
> +	if (!is_protected_kvm_enabled())
> +		return;
> +
> +	kvm_ptdump_debugfs_register(&host_reg, "host_page_tables",
> +				    kvm_debugfs_dir);
> +}
> +
> +static int __init kvm_host_ptdump_init(void)
> +{
> +	host_reg.priv = (void *)host_s2_pgtable_pages();
> +	return 0;
> +}
> +
> +device_initcall(kvm_host_ptdump_init);
> -- 
> 2.43.0.472.g3155946c3a-goog
> 

