Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39DC879F078
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjIMRhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjIMRha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:37:30 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327ADB8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:37:26 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1bf39e73558so162635ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694626645; x=1695231445; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1AecudT7EiX+/N1zd76G2BuWYAX0/KYuLLaU2H3llYQ=;
        b=U8BIABw/cNPFs1/y98w03BSd9X0/5LBkjSaM7PWjP1lf52AeXYmdsxMMCDIz6hXa9J
         O64a4RZhv0YQ3BiVTjffp97ynknGRZElnjkGr6EfygfgPyDWFx1QYt71Wcpz1ejZ9Bst
         zNVW+z5s8s9r8YL1KD23dY8TRleIJOSifu8nXp79vKxwmtKJu6tCxDnhUXAiENhjm5up
         w4+5eKwXnesDhFknxdmXA8XU2mbH2y/OfYlPYIOWcPR0xeUBUNWwHARPbKracOS+Jfa4
         htlxgUEOMLmfR0z8nr7z3TDKiWoFdRkT5hOg+puL7WSdEG5PV630yUkK5mLoek/K+tEQ
         Icfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694626645; x=1695231445;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1AecudT7EiX+/N1zd76G2BuWYAX0/KYuLLaU2H3llYQ=;
        b=DMJLkY9kB8HZTRk4O1j1RU7N5BdgVxPnXtGq5bj1JyzF10iywVcAO8OyMrZoK52Ln4
         xPQiFyIdOhaQjte+uocLqy8ikt28UuejNBGJte30D1/nUyO0fDwUH/JBfBfbihzAvWFX
         dLUeaxpPI2m43vysuAqQHWAFCU2klplU/zLNU2HX6BuZO7tqEXELXIz6DQHiXyntJY9b
         Tiv0NJ7dPIHP0/E9ALJdBE/5jA74tKlG7lHNrsoJKBM4cIxqGzi7Go+PEB2Jqmp6F/zG
         xR0+6ZrhaBDiESdvuk4Fb2DBktPgb6tmpQrE0LuNWncs2hbvpigrfkIOwlswHbtr8K/p
         m+1Q==
X-Gm-Message-State: AOJu0YzTwbwsRqugoFAo01iTPHLGm8yxsVhcuf3iluiJ4tHnKS5doz96
        Ji628aJG52x1KPfXvnxgqYQdRZ6Zl14=
X-Google-Smtp-Source: AGHT+IHiMeIl2kyTkgSOGsBoH7eXEckogjT+Oxb3QtAWLG1MtxlYB2PHOPs6XjcZ/s4JwKMi4FJkjjeo9Jg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:c28b:b0:26b:2001:54f5 with SMTP id
 f11-20020a17090ac28b00b0026b200154f5mr76310pjt.8.1694626645628; Wed, 13 Sep
 2023 10:37:25 -0700 (PDT)
Date:   Wed, 13 Sep 2023 10:37:24 -0700
In-Reply-To: <36f6fae6cd7aaba3b0fc18f10981bbba2c30b979.1694599703.git.isaku.yamahata@intel.com>
Mime-Version: 1.0
References: <cover.1694599703.git.isaku.yamahata@intel.com> <36f6fae6cd7aaba3b0fc18f10981bbba2c30b979.1694599703.git.isaku.yamahata@intel.com>
Message-ID: <ZQHzVOIsesTTysgf@google.com>
Subject: Re: [RFC PATCH 3/6] KVM: guest_memfd, x86: MEMORY_FAULT exit with hw
 poisoned page
From:   Sean Christopherson <seanjc@google.com>
To:     isaku.yamahata@intel.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        isaku.yamahata@gmail.com, Michael Roth <michael.roth@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com,
        Sagi Shahar <sagis@google.com>,
        David Matlack <dmatlack@google.com>,
        Kai Huang <kai.huang@intel.com>,
        Zhi Wang <zhi.wang.linux@gmail.com>, chen.bo@intel.com,
        linux-coco@lists.linux.dev,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Xu Yilun <yilun.xu@intel.com>,
        Quentin Perret <qperret@google.com>, wei.w.wang@intel.com,
        Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023, isaku.yamahata@intel.com wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> When resolving kvm page fault and hwpoisoned page is given, KVM exit
> with HWPOISONED flag so that user space VMM, e.g. qemu, handle it.
> 
> - Add a new flag POISON to KVM_EXIT_MEMORY_FAULT to indicate the page is
>   poisoned.
> - Make kvm_gmem_get_pfn() return hwpoison state by -EHWPOISON when the
>   folio is hw-poisoned.
> - When page is hw-poisoned on faulting in private gmem, return
>   KVM_EXIT_MEMORY_FAULT with HWPOISONED flag.
> 
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> ---

...

> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index eb900344a054..48329cb44415 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -527,7 +527,8 @@ struct kvm_run {
>  		} notify;
>  		/* KVM_EXIT_MEMORY_FAULT */
>  		struct {
> -#define KVM_MEMORY_EXIT_FLAG_PRIVATE	(1ULL << 3)
> +#define KVM_MEMORY_EXIT_FLAG_PRIVATE	BIT_ULL(3)
> +#define KVM_MEMORY_EXIT_FLAG_HWPOISON	BIT_ULL(4)

Rather than add a flag, I think we should double down on returning -1 + errno
when exiting with vcpu->run->exit_reason == KVM_EXIT_MEMORY_FAULT, as is being
proposed in Anish's series for accelerating UFFD-like behavior in KVM[*].

Then KVM can simply return -EFAULT or -EHWPOISON to communicate why KVM is
existing at a higher level, and let the kvm_run structure provide the finer
details about the access itself.  E.g. kvm_faultin_pfn_private() can simply
propagate the return value from kvm_gmem_get_pfn() without having to identify
*why* kvm_gmem_get_pfn() failed.

static int kvm_faultin_pfn_private(struct kvm_vcpu *vcpu,
				   struct kvm_page_fault *fault)
{
	int max_order, r;

	if (!kvm_slot_can_be_private(fault->slot)) {
		kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
		return -EFAULT;
	}

	r = kvm_gmem_get_pfn(vcpu->kvm, fault->slot, fault->gfn, &fault->pfn,
			     &max_order);
	if (r) {
		kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
		return r;
	}

	...
}

[*] https://lore.kernel.org/all/20230908222905.1321305-5-amoorthy@google.com
