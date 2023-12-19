Return-Path: <linux-kernel+bounces-5113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFDD8186AE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CE081F241ED
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F5418623;
	Tue, 19 Dec 2023 11:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bT09DXsm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF87182A4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 11:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40c2db0ca48so38135e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 03:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702986745; x=1703591545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6+saTyDFu3JKkTgh9+qAoCNDwyD6uD6EvbbNk9+tb9w=;
        b=bT09DXsmQPtWk8kC3Kf6466AYyw4MxqH8tAb2tVrLL68hBdhzPKSMU2Qi/nKIi78VN
         Sn0HwI52ITmRpN7cQnxu43sTzJh7gB6IFU3Pr8Gz82GQCsg+Vtas/xHhhLRsF1E+Yi/g
         0PVeScuGOwoIzMPJPYXTGIb+zOg2SC0yqzMcF2rMEPqHmKp/JxT/4iFA/UD6acFUq2JC
         BbfWdwT5i0AJOpbXT+ytHEjpQUCq1wSEYkLhHu3NpLgNuUwUd2DvA/jLR9slLCdjDaHH
         3hrErg/Yb13QBIDY2JaOzTwk/JcYojfb54Ixxxjm13TSNTZbiSQV4Cg3ClWyW9zmxeQn
         Eu9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702986745; x=1703591545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+saTyDFu3JKkTgh9+qAoCNDwyD6uD6EvbbNk9+tb9w=;
        b=caHfzx7aotbKFJiqnmsBQHUySqKcKtczqUdrFf7ORE89CH8aJS6XO4xvIl3i9Vg74d
         /2142kq+7p57t25ghxdRtSZOqN+Byu+sCvJEhtirOSCFOkoHxdL+OpU6AXfMHU5FfN0x
         iOIT7aynuWLBDgr3qXILM4021cI7x5mtESPvRmPXA+MteU7ol78pyHcHeDpFa5SIUiGM
         moTWU4ceKYUq0JmBUyN3jDQfhmhVzItbdpwYcXJJqlGe8QopVYMJ6rwzQ/Jx/+ylMVna
         vWY0oG7X4IoLB6BiyJVYxY+P8eAwM7k2V8HvkIXEXByQmx2U3iEUQ0kR6yzjNLILlmp8
         uFwg==
X-Gm-Message-State: AOJu0YwPdUlhmU+QDZ3Leb1fLMB4lHWd1qgfumKMJBNbdTNfle4jbaxJ
	3zGO0ym5WNyKjjKujLfnppmpk8lfAx8p
X-Google-Smtp-Source: AGHT+IEfwvB6yLTkW6Xj0KhpdwlCUZwWV8uL2NQqpHJVv121xmqn1IfvV6Yhn2ElHeo9GVfaU0O9zw==
X-Received: by 2002:a1c:4b14:0:b0:40d:27c5:9c16 with SMTP id y20-20020a1c4b14000000b0040d27c59c16mr65533wma.0.1702986745036;
        Tue, 19 Dec 2023 03:52:25 -0800 (PST)
Received: from google.com (185.83.140.34.bc.googleusercontent.com. [34.140.83.185])
        by smtp.gmail.com with ESMTPSA id v14-20020a05600c444e00b0040c58e410a3sm2541375wmn.14.2023.12.19.03.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 03:52:24 -0800 (PST)
Date: Tue, 19 Dec 2023 11:52:22 +0000
From: Sebastian Ene <sebastianene@google.com>
To: will@kernel.org, Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>, catalin.marinas@arm.com,
	mark.rutland@arm.com, akpm@linux-foundation.org, maz@kernel.org
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	vdonnefort@google.com, qperret@google.com, smostafa@google.com
Subject: Re: [PATCH v4 10/10] arm64: ptdump: Add guest stage-2 pagetables
 dumping
Message-ID: <ZYGD9qWqHgICBCp8@google.com>
References: <20231218135859.2513568-2-sebastianene@google.com>
 <20231218135859.2513568-12-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218135859.2513568-12-sebastianene@google.com>

On Mon, Dec 18, 2023 at 01:59:00PM +0000, Sebastian Ene wrote:
> Register a debugfs file on guest creation to be able to view their
> second translation tables with ptdump. This assumes that the host is in
> control of the guest stage-2 and has direct access to the pagetables.
> 
> Signed-off-by: Sebastian Ene <sebastianene@google.com>
> ---
>  arch/arm64/kvm/debug.c      |  6 ++++++
>  arch/arm64/kvm/kvm_ptdump.h |  3 +++
>  arch/arm64/kvm/ptdump.c     | 35 ++++++++++++++++++++++++++++++++---
>  3 files changed, 41 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
> index 8725291cb..7c4c2902d 100644
> --- a/arch/arm64/kvm/debug.c
> +++ b/arch/arm64/kvm/debug.c
> @@ -13,6 +13,7 @@
>  #include <asm/kvm_asm.h>
>  #include <asm/kvm_arm.h>
>  #include <asm/kvm_emulate.h>
> +#include <kvm_ptdump.h>
>  
>  #include "trace.h"
>  
> @@ -342,3 +343,8 @@ void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu)
>  	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_SPE);
>  	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
>  }
> +
> +int kvm_arch_create_vm_debugfs(struct kvm *kvm)
> +{
> +	return kvm_ptdump_register_guest(kvm);
> +}
> diff --git a/arch/arm64/kvm/kvm_ptdump.h b/arch/arm64/kvm/kvm_ptdump.h
> index 98b595ce8..5f5a455d0 100644
> --- a/arch/arm64/kvm/kvm_ptdump.h
> +++ b/arch/arm64/kvm/kvm_ptdump.h
> @@ -6,13 +6,16 @@
>  #ifndef __KVM_PTDUMP_H
>  #define __KVM_PTDUMP_H
>  
> +#include <linux/kvm_host.h>
>  #include <asm/ptdump.h>
>  
>  
>  #ifdef CONFIG_PTDUMP_STAGE2_DEBUGFS
>  void kvm_ptdump_register_host(void);
> +int kvm_ptdump_register_guest(struct kvm *kvm);
>  #else
>  static inline void kvm_ptdump_register_host(void) { }
> +static inline int kvm_ptdump_register_guest(struct kvm *kvm) { return -1; }
>  #endif /* CONFIG_PTDUMP_STAGE2_DEBUGFS */
>  
>  #endif /* __KVM_PTDUMP_H */
> diff --git a/arch/arm64/kvm/ptdump.c b/arch/arm64/kvm/ptdump.c
> index 4296e739f..62a753d6b 100644
> --- a/arch/arm64/kvm/ptdump.c
> +++ b/arch/arm64/kvm/ptdump.c
> @@ -181,6 +181,8 @@ static int kvm_ptdump_open(struct inode *inode, struct file *file)
>  		info = reg->get_ptdump_info(reg);
>  		if (!info)
>  			return -ENOMEM;
> +	} else {
> +		info = inode->i_private;

FIXME: Don't call kvm_ptdump_release with this ^ argument.

>  	}
>  
>  	if (!reg->show_ptdump_info)
> @@ -239,15 +241,14 @@ static int kvm_ptdump_visitor(const struct kvm_pgtable_visit_ctx *ctx,
>  	return 0;
>  }
>  
> -static int kvm_ptdump_show(struct seq_file *m, void *)
> +static int kvm_ptdump_show_common(struct seq_file *m,
> +				  struct kvm_pgtable *pgtable)
>  {
>  	u64 ipa_size;
>  	char ipa_description[32];
>  	struct pg_state st;
>  	struct addr_marker ipa_addr_markers[3] = {0};
>  	struct pg_level pg_level_descr[KVM_PGTABLE_MAX_LEVELS] = {0};
> -	struct kvm_pgtable_snapshot *snapshot = m->private;
> -	struct kvm_pgtable *pgtable = &snapshot->pgtable;
>  	struct kvm_pgtable_walker walker = (struct kvm_pgtable_walker) {
>  		.cb	= kvm_ptdump_visitor,
>  		.arg	= &st,
> @@ -282,6 +283,26 @@ static int kvm_ptdump_show(struct seq_file *m, void *)
>  	return kvm_pgtable_walk(pgtable, 0, ipa_size, &walker);
>  }
>  
> +static int kvm_host_ptdump_show(struct seq_file *m, void *)
> +{
> +	struct kvm_pgtable_snapshot *snapshot = m->private;
> +
> +	return kvm_ptdump_show_common(m, &snapshot->pgtable);
> +}
> +
> +static int kvm_ptdump_show(struct seq_file *m, void *)
> +{
> +	struct kvm *guest_kvm = m->private;
> +	struct kvm_s2_mmu *mmu = &guest_kvm->arch.mmu;
> +	int ret;
> +
> +	write_lock(&guest_kvm->mmu_lock);
> +	ret = kvm_ptdump_show_common(m, mmu->pgt);
> +	write_unlock(&guest_kvm->mmu_lock);
> +
> +	return ret;
> +}
> +
>  static void kvm_ptdump_debugfs_register(struct kvm_ptdump_register *reg,
>  					const char *name, struct dentry *parent)
>  {
> @@ -393,11 +414,19 @@ void kvm_ptdump_register_host(void)
>  
>  	host_reg.get_ptdump_info = kvm_host_get_ptdump_info;
>  	host_reg.put_ptdump_info = kvm_host_put_ptdump_info;
> +	host_reg.show_ptdump_info = kvm_host_ptdump_show;
>  
>  	kvm_ptdump_debugfs_register(&host_reg, "host_page_tables",
>  				    kvm_debugfs_dir);
>  }
>  
> +int kvm_ptdump_register_guest(struct kvm *kvm)
> +{
> +	debugfs_create_file("stage2_page_tables", 0400, kvm->debugfs_dentry,
> +			    kvm, &kvm_ptdump_fops);
> +	return 0;
> +}
> +
>  static int __init kvm_host_ptdump_init(void)
>  {
>  	host_reg.priv = (void *)host_s2_pgtable_pages();
> -- 
> 2.43.0.472.g3155946c3a-goog
> 

