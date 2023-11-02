Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400DE7DF6C0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347572AbjKBPpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235392AbjKBPo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:44:58 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AA2185
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 08:44:54 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5b053454aeeso16140297b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 08:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698939894; x=1699544694; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MWop9ChiDn+5U1d7ZFSKgT7XQaKJkOCdphsca+5hdRc=;
        b=2HWGoThmgpVyvN9kveIIciJRpecImS9TZEgN45xXW9mHLuu9UUMwkP7Ihh7vkQrPfD
         fN5nF1K+tpUujdqrvoFgUr4pZJCPpkGN84BDbVFsR1YOsBua0Ygy0M7PER2kk56p0c16
         mD/QAqjgcJScNuOPijWGMD+Vnpe3YssMeRsNFLa5946MrhmQSiTvyJlAxBiIQlwJIRK9
         gvfEaKatBvklsQErDH+doyL9YdAiVrI0vMGbPZjkaEO80f6Jkxaq5SgOdUMCG6aRWPPI
         W9XGBitq36uGiwh4/LmRufUr22rX3mFn3fIna5zJ+JiZAdyEQE1tSTRj5cshaKKjCieh
         +f3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698939894; x=1699544694;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MWop9ChiDn+5U1d7ZFSKgT7XQaKJkOCdphsca+5hdRc=;
        b=ZPjk8fPWPvWwv6yyv8drSEDmZIuCc7tySJlsYf1fKwDKqBWMADIboz7GzveMWZqLXU
         9v5QECaaSenzyKe2h+CMmZEzAW87+2C9nUb1HyCQj1HV8/Yx4jDsK6qaFRjq25JzOtB7
         t0FnOUD0NNqvbMrrLUFtwD6pXEi3A3Ej/6IwpilDi3bbhARsi/BnDT1sc6BBldIOEvGC
         ceQjflkbPPO18fiPN+WstleEctwv1VhXIEf09dOGt6sT02XKXPNhQXc4zVIGvFAGYJd2
         mYgppd/rjMHVY479rqayoaMl+iUAAXXFDO8ZafnvB1MjjW/TwNVKBpwNSHapUrKqHsc6
         9zNw==
X-Gm-Message-State: AOJu0YwCR9ap8r9HNH7I0s8gqPhc1BRbCNS9fFbjpMIrs9/K1suWI+qk
        3gD3Z/xKiEQ2T25V4WaGSdW855JhygQ=
X-Google-Smtp-Source: AGHT+IEDx2fXN1mZpC4wdLenC0gEZqGHeyYGeZi/NHNboFx849UKp0hRFulm5OGynaHR+kwHxlTzuAC9hXU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:d785:0:b0:59b:c811:a709 with SMTP id
 z127-20020a0dd785000000b0059bc811a709mr3270ywd.0.1698939893755; Thu, 02 Nov
 2023 08:44:53 -0700 (PDT)
Date:   Thu, 2 Nov 2023 08:44:52 -0700
In-Reply-To: <496b78bb-ad12-4eed-a62c-8c2fd725ec61@redhat.com>
Mime-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-10-seanjc@google.com>
 <482bfea6f54ea1bb7d1ad75e03541d0ba0e5be6f.camel@intel.com>
 <ZUKMsOdg3N9wmEzy@google.com> <64e3764e36ba7a00d94cc7db1dea1ef06b620aaf.camel@intel.com>
 <32cb71700aedcbd1f65276cf44a601760ffc364b.camel@intel.com> <496b78bb-ad12-4eed-a62c-8c2fd725ec61@redhat.com>
Message-ID: <ZUPD9NWF4eOXqeiA@google.com>
Subject: Re: [PATCH v13 09/35] KVM: Add KVM_EXIT_MEMORY_FAULT exit to report
 faults to userspace
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Kai Huang <kai.huang@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
        "kvm-riscv@lists.infradead.org" <kvm-riscv@lists.infradead.org>,
        "mic@digikod.net" <mic@digikod.net>,
        "liam.merwick@oracle.com" <liam.merwick@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "amoorthy@google.com" <amoorthy@google.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "tabba@google.com" <tabba@google.com>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
        "michael.roth@amd.com" <michael.roth@amd.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        Vishal Annapurve <vannapurve@google.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "dmatlack@google.com" <dmatlack@google.com>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "yu.c.zhang@linux.intel.com" <yu.c.zhang@linux.intel.com>,
        Yilun Xu <yilun.xu@intel.com>,
        "qperret@google.com" <qperret@google.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>,
        "ackerleytng@google.com" <ackerleytng@google.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Wei W Wang <wei.w.wang@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023, Paolo Bonzini wrote:
> On 11/2/23 10:35, Huang, Kai wrote:
> > IIUC KVM can already handle the case of poisoned
> > page by sending signal to user app:
> > 
> > 	static int kvm_handle_error_pfn(struct kvm_vcpu *vcpu, 			struct
> > kvm_page_fault *fault)                                               	{
> > 		...
> > 
> >        		if (fault->pfn == KVM_PFN_ERR_HWPOISON) {
> >               		kvm_send_hwpoison_signal(fault->slot, fault->gfn);

No, this doesn't work, because that signals the host virtual address

	unsigned long hva = gfn_to_hva_memslot(slot, gfn);

	send_sig_mceerr(BUS_MCEERR_AR, (void __user *)hva, PAGE_SHIFT, current);

which is the *shared* page.

> >                 	return RET_PF_RETRY;
> > 	}
> > 	}
> 
> EHWPOISON is not implemented by this series, so it should be left out of the
> documentation.

EHWPOISON *is* implemented.  kvm_gmem_get_pfn() returns -EWPOISON as appropriate,
and kvm_faultin_pfn() returns that directly without going through kvm_handle_error_pfn().

  kvm_faultin_pfn_private()
  |
  |-> kvm_gmem_get_pfn()
      |
      |-> if (folio_test_hwpoison(folio)) {
		r = -EHWPOISON;
		goto out_unlock;
	  }

          |
          |-> 	r = kvm_gmem_get_pfn(vcpu->kvm, fault->slot, fault->gfn, &fault->pfn,
			     &max_order);
		if (r) {
			kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
			return r;
		}

		|
		|-> ret = __kvm_faultin_pfn(vcpu, fault);
		    if (ret != RET_PF_CONTINUE)
			    return ret;

		    if (unlikely(is_error_pfn(fault->pfn)))
			    return kvm_handle_error_pfn(vcpu, fault);
