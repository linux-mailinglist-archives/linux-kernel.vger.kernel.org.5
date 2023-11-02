Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EAF7DF710
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377091AbjKBPwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347653AbjKBPwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:52:14 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE7A1B5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 08:51:57 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5a08e5c7debso868014a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 08:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698940317; x=1699545117; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n3KS4TORQ08dXaJsqxd4Pb+jR6Q6AdhcH6h0cpJ7xRs=;
        b=RN0UVusdj7tpK4hQeFYbhvaU4omd5amSOlKVxzal4e/nLCstlMRgxT8KS/lWr65n+r
         6KNMcJ1uKXesH49i3odou+YkBwJ/tIhElW36o05O1Ng3MGOW1zTOynUX0OWlSK9iMlHj
         OJMx4TYtkPZdEEKgufM2y157tcR2VvjSNNRsDidCaRHU/7AGqt2eLsOIb0GjDh4h5UkI
         d3xSLnn7aKg34XyKrRvm0qT7UzZTcqDYj4o2l8TTa90NNHoGCdJWPnuATWPv334jHVIS
         in4oABR4fLBPKErRzF5sU0/Cy34MuQs7nc5sUT00ipFmdSGxD/NyK8sttyJUHhWQTYBy
         +O1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698940317; x=1699545117;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n3KS4TORQ08dXaJsqxd4Pb+jR6Q6AdhcH6h0cpJ7xRs=;
        b=ckX6tHcgcfrBwiS6rfL0XVkl6gu2cKc2WDHTiBGGLGs+EZHcR75N0CJH83e4NAg2sV
         Oly0af0hqir/APirpS5z4stktYMieCBbvmATEW8FvcQzPTxnouYIPb2+Vt2xpsXwtWri
         oaduFAPwXOKyofz2Tmf/zUjJZS3Juvd0JS2qsyznPqIeUHHuXtTHiJriro4h8xcoLTJs
         rWokORLXMgRFbNULbrObWdeUun61lREUDrb5c1fQfUR2P3ZFlamjCfWwJrhTxbHkKJe8
         ASNxyxykBZiYR/OPbRdz9y3B8bCJCE4WjUWAFbWOPLtqCe9jQFGypcTt4Jm4Ya6FFoK2
         mpvg==
X-Gm-Message-State: AOJu0YwPxaCsJr8VKfMRIkl4iUPxWV80+uB73roGZ0+jKbBqc06OFY/r
        aJd4G39bfqNehBJCePg4FLsyXGEbk+0=
X-Google-Smtp-Source: AGHT+IFDcwl4s8UdqmTM5rWncqnvjP5M1c0a+jaZEj3IxvzEAcY13jClAPWsClQownnFGH/6j2HG46oUm7Q=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:efd1:b0:1c6:2b9d:570b with SMTP id
 ja17-20020a170902efd100b001c62b9d570bmr344133plb.7.1698940317130; Thu, 02 Nov
 2023 08:51:57 -0700 (PDT)
Date:   Thu, 2 Nov 2023 08:51:55 -0700
In-Reply-To: <33686031-c1df-4ef5-a6ac-1aab7f5c656e@intel.com>
Mime-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-10-seanjc@google.com>
 <482bfea6f54ea1bb7d1ad75e03541d0ba0e5be6f.camel@intel.com>
 <ZUKMsOdg3N9wmEzy@google.com> <33686031-c1df-4ef5-a6ac-1aab7f5c656e@intel.com>
Message-ID: <ZUPFmwWjPFlXRlPi@google.com>
Subject: Re: [PATCH v13 09/35] KVM: Add KVM_EXIT_MEMORY_FAULT exit to report
 faults to userspace
From:   Sean Christopherson <seanjc@google.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Kai Huang <kai.huang@intel.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023, Xiaoyao Li wrote:
> On 11/2/2023 1:36 AM, Sean Christopherson wrote:
> > > KVM_CAP_MEMORY_FAULT_INFO is x86 only, is it better to put this function to
> > > <asm/kvm_host.h>?
> > I'd prefer to keep it in generic code, as it's highly likely to end up there
> > sooner than later.  There's a known use case for ARM (exit to userspace on missing
> > userspace mapping[*]), and I'm guessing pKVM (also ARM) will also utilize this API.
> > 
> > [*]https://lore.kernel.org/all/20230908222905.1321305-8-amoorthy@google.com
> 
> I wonder how this CAP is supposed to be checked in userspace, for guest
> memfd case? 

It's basically useless for guest_memfd.

> 	if (!kvm_check_extension(s, KVM_CAP_MEMORY_FAULT_INFO) &&
> 	    run->exit_reason == KVM_EXIT_MEMORY_FAULT)
> 		abort("unexpected KVM_EXIT_MEMORY_FAULT");
> 
> In my implementation of QEMU patches, I find it's unnecessary. When
> userspace gets an exit with KVM_EXIT_MEMORY_FAULT, it implies
> "KVM_CAP_MEMORY_FAULT_INFO".
> 
> So I don't see how it is necessary in this series. Whether it's necessary or
> not for [*], I don't have the answer but we can leave the discussion to that
> patch series.

It's not strictly necessary there either.

However, Oliver felt (and presumably still feels) quite strongly, and I agree,
that neither reporting extra information shouldn't be tightly coupled to
KVM_CAP_EXIT_ON_MISSING or KVM_CAP_GUEST_MEMFD.

E.g. if userspace develops a "standalone" use case for KVM_CAP_MEMORY_FAULT_INFO,
userspace should be able to check for support without having to take a dependency
on KVM_CAP_GUEST_MEMFD, especially since because KVM_CAP_GUEST_MEMFD may not be
supported, i.e. userspace should be able to do:

	if (!kvm_check_extension(s, KVM_CAP_MEMORY_FAULT_INFO))
		abort("KVM_CAP_MEMORY_FAULT_INFO required for fancy feature XYZ");


