Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB6F7DE56F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 18:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbjKARg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 13:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjKARgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 13:36:53 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAB3ED
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 10:36:50 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da0cb98f66cso6455442276.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 10:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698860209; x=1699465009; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Aa5pPv4/g+I3C3eNDgudVhrFstr6S8Xmtwrf0OlljDI=;
        b=1G73i3bpqP3lEIiYf1Xa+PqF+ry3FPPmHtzhkTz2ESLqKv/PJo83UzY0L3tGLSLtgw
         FEf6apQxu3ajl2eaf2jpMXM8oiMYlwvL+Gaj7CmFke3L5WVAzOh6QUSsRjnNhhvyggQP
         /0obTqP8SXrHs5tm5Lcs1IoffSqT4ZAyvwPXIthiiQ2/DYs3pRsDS0oN02OgNcKyJmxV
         +il1EDZ1G9lZ1tby+sgxcieBPfodwSlNZ7rJ6OOgSa83N+qrWIIICrK86C1Ay71kdg1m
         h7J1Ii0mSVbVxFFpS5Ul/5maHoLcclIuFP3aDRfEoQUS+LZ7DrcFMxeDrV3szI4QTAZm
         WoHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698860209; x=1699465009;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aa5pPv4/g+I3C3eNDgudVhrFstr6S8Xmtwrf0OlljDI=;
        b=LfTsGkMi5PmCHna65jac9dWx9BrKyUij2qKCviqvOkmFfpEqY8QTDwiobwM82yX855
         9ZyKbFUpHpzQv+cK3et1iSN3N01Io7Sn7GRU8+05zME7MqchJZkVxpo+YtCFjjogGBCF
         X1DO/YeYK2VX40+NTWoezUE25UQlKfUEkFdq5Afz3n7/AAcoR4P+xLvThwbI5i86I3SD
         ttBhM7iK5G32ul12MLRpnwhWvOAbFe44dSXVYiCDrLFWElYVeHI+D7yIfz6CGyLp49Cn
         Gfb8zfLlh2ksT5UWo7IyOqbDTB5qoUJHKz7075yRuVPPTmPEjACUmXG31pwpoMPpl4Mj
         pt7Q==
X-Gm-Message-State: AOJu0Yyw+Q1oyumXPR1w+PDiwUKK2LwagJB+71w1TPSW+qKE2iorUyLa
        TUm5b/J85iZ7QT8liCYiwE/gl5+tbuA=
X-Google-Smtp-Source: AGHT+IG/a6Sj0mASs5/8PEJQnR69sSphX+9SHKWYEjRPOLGEF4l6c52AgzjYtmdhHr7JL68mzkGP7JI8NEg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:168c:b0:da0:3e46:8ba5 with SMTP id
 bx12-20020a056902168c00b00da03e468ba5mr304342ybb.8.1698860209654; Wed, 01 Nov
 2023 10:36:49 -0700 (PDT)
Date:   Wed, 1 Nov 2023 10:36:48 -0700
In-Reply-To: <482bfea6f54ea1bb7d1ad75e03541d0ba0e5be6f.camel@intel.com>
Mime-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-10-seanjc@google.com>
 <482bfea6f54ea1bb7d1ad75e03541d0ba0e5be6f.camel@intel.com>
Message-ID: <ZUKMsOdg3N9wmEzy@google.com>
Subject: Re: [PATCH v13 09/35] KVM: Add KVM_EXIT_MEMORY_FAULT exit to report
 faults to userspace
From:   Sean Christopherson <seanjc@google.com>
To:     Kai Huang <kai.huang@intel.com>
Cc:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
        "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "maz@kernel.org" <maz@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "willy@infradead.org" <willy@infradead.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        "kvm-riscv@lists.infradead.org" <kvm-riscv@lists.infradead.org>,
        "mic@digikod.net" <mic@digikod.net>,
        "liam.merwick@oracle.com" <liam.merwick@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "tabba@google.com" <tabba@google.com>,
        "amoorthy@google.com" <amoorthy@google.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "michael.roth@amd.com" <michael.roth@amd.com>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Vishal Annapurve <vannapurve@google.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>,
        "yu.c.zhang@linux.intel.com" <yu.c.zhang@linux.intel.com>,
        "qperret@google.com" <qperret@google.com>,
        "dmatlack@google.com" <dmatlack@google.com>,
        Yilun Xu <yilun.xu@intel.com>,
        "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>,
        "ackerleytng@google.com" <ackerleytng@google.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Wei W Wang <wei.w.wang@intel.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023, Kai Huang wrote:
> 
> > +7.34 KVM_CAP_MEMORY_FAULT_INFO
> > +------------------------------
> > +
> > +:Architectures: x86
> > +:Returns: Informational only, -EINVAL on direct KVM_ENABLE_CAP.
> > +
> > +The presence of this capability indicates that KVM_RUN will fill
> > +kvm_run.memory_fault if KVM cannot resolve a guest page fault VM-Exit, e.g. if
> > +there is a valid memslot but no backing VMA for the corresponding host virtual
> > +address.
> > +
> > +The information in kvm_run.memory_fault is valid if and only if KVM_RUN returns
> > +an error with errno=EFAULT or errno=EHWPOISON *and* kvm_run.exit_reason is set
> > +to KVM_EXIT_MEMORY_FAULT.
> 
> IIUC returning -EFAULT or whatever -errno is sort of KVM internal
> implementation.

The errno that is returned to userspace is ABI.  In KVM, it's a _very_ poorly
defined ABI for the vast majority of ioctls(), but it's still technically ABI.
KVM gets away with being cavalier with errno because the vast majority of errors
are considered fatal by userespace, i.e. in most cases, userspace simply doesn't
care about the exact errno.

A good example is KVM_RUN with -EINTR; if KVM were to return something other than
-EINTR on a pending signal or vcpu->run->immediate_exit, userspace would fall over.

> Is it better to relax the validity of kvm_run.memory_fault when
> KVM_RUN returns any -errno?

Not unless there's a need to do so, and if there is then we can update the
documentation accordingly.  If KVM's ABI is that kvm_run.memory_fault is valid
for any errno, then KVM would need to purge kvm_run.exit_reason super early in
KVM_RUN, e.g. to prevent an -EINTR return due to immediate_exit from being
misinterpreted as KVM_EXIT_MEMORY_FAULT.  And purging exit_reason super early is
subtly tricky because KVM's (again, poorly documented) ABI is that *some* exit
reasons are preserved across KVM_RUN with vcpu->run->immediate_exit (or with a
pending signal).

https://lore.kernel.org/all/ZFFbwOXZ5uI%2Fgdaf@google.com

> [...]
> 
> 
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -2327,4 +2327,15 @@ static inline void kvm_account_pgtable_pages(void *virt, int nr)
> >  /* Max number of entries allowed for each kvm dirty ring */
> >  #define  KVM_DIRTY_RING_MAX_ENTRIES  65536
> >  
> > +static inline void kvm_prepare_memory_fault_exit(struct kvm_vcpu *vcpu,
> > +						 gpa_t gpa, gpa_t size)
> > +{
> > +	vcpu->run->exit_reason = KVM_EXIT_MEMORY_FAULT;
> > +	vcpu->run->memory_fault.gpa = gpa;
> > +	vcpu->run->memory_fault.size = size;
> > +
> > +	/* Flags are not (yet) defined or communicated to userspace. */
> > +	vcpu->run->memory_fault.flags = 0;
> > +}
> > +
> 
> KVM_CAP_MEMORY_FAULT_INFO is x86 only, is it better to put this function to
> <asm/kvm_host.h>?

I'd prefer to keep it in generic code, as it's highly likely to end up there
sooner than later.  There's a known use case for ARM (exit to userspace on missing
userspace mapping[*]), and I'm guessing pKVM (also ARM) will also utilize this API.

[*] https://lore.kernel.org/all/20230908222905.1321305-8-amoorthy@google.com
