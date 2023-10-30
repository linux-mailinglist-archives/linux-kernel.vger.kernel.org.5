Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2EB7DC247
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 23:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjJ3WGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 18:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjJ3WGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 18:06:02 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CC9FA
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 15:05:59 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da033914f7cso4546167276.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 15:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698703558; x=1699308358; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1IwVDVsbZSN9+qsHUIXJ8IN4aMaIP7o7r0dMzi80JWo=;
        b=WZYA3UvCwaSfQcrK1w5QKLxMDZIAMVwX0AttOaceeOv3qvHQR4X+Xyb2Sr7TO1Qkhi
         MqYgNwofaYVjnCY7OwJQlPk7uGIw2TAu0NGrltOcX+RVNEEPwSO2q0SDHDCwACue+fAt
         kM6ynu6Fr2EXG6+Gk2Ba5uZFB+IXk+jeKNWNaMavD82UNvBuYFUmIVfcC8zfLfjWQtc7
         dfFCbjlall6cXUSuUFwfgpHZOTw3zY7QtmVGi8vKF/ycNGJs/IqYEE4YimI0jNkHxrfz
         5h4wStKPVM8DBvhVrKo7TNLn+4N3e1VJkuM0vWBCBzed5xcMgpjaNMu/TvLMOb4z2oUY
         n+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698703558; x=1699308358;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1IwVDVsbZSN9+qsHUIXJ8IN4aMaIP7o7r0dMzi80JWo=;
        b=uPzbFEzGHztD0QeFewbkuhjtnvD/leAOooWplCIST20p4rMrVsFniV0W04EF6gYOBh
         GHxK7SpD/4wIqZeJ94WIid99TDfxdS6hV8u760VZqvlVlEVa1zKEJDaEDUwRH6xrf1zW
         /87xEfAjGzN/JtrDfA9sh6/axJhoi1ZPKXWJgKWVrqt3EFwB0QiL+KRHUt9Ovxs6DQLW
         BwjrdE+Ip4NgW0WKulsyOj/IYL/EdtOJ5n9ndQYZbMNqpaQ7fgbxwTC9AyZY20LwMjU4
         KbQoYmfvGLbPk1/NItJ/frzE9If3Tgqq6C03o3DXygrnZYifPuzrQiyF7llh3IYvMjBU
         dzKQ==
X-Gm-Message-State: AOJu0YwU4vOy0YKjyPu7vNcwhzWSZmNygWFs3aKtta/9hTkQkx0w6uKV
        bVyzjLFZnSrHDTRsab7NPelCFV4zxXI=
X-Google-Smtp-Source: AGHT+IEdUnGiaB+HWnyvBXIWgJEvc4p4Jj6o8XAknp5F2BcjElHvOjmW/sQ9BadeZP3HZD1+EeGEwSi+J0Q=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:b108:0:b0:d99:3750:d607 with SMTP id
 g8-20020a25b108000000b00d993750d607mr203752ybj.8.1698703558464; Mon, 30 Oct
 2023 15:05:58 -0700 (PDT)
Date:   Mon, 30 Oct 2023 15:05:56 -0700
In-Reply-To: <ZT_ViJOW1p4TN_fI@google.com>
Mime-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-14-seanjc@google.com>
 <ZT9lQ9c7Bik6FIpw@chao-email> <ZT_ViJOW1p4TN_fI@google.com>
Message-ID: <ZUAoxCZJnpPGWjpu@google.com>
Subject: Re: [PATCH v13 13/35] KVM: Introduce per-page memory attributes
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Gao <chao.gao@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Anish Moorthy <amoorthy@google.com>,
        David Matlack <dmatlack@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023, Sean Christopherson wrote:
> On Mon, Oct 30, 2023, Chao Gao wrote:
> > On Fri, Oct 27, 2023 at 11:21:55AM -0700, Sean Christopherson wrote:
> > >From: Chao Peng <chao.p.peng@linux.intel.com>
> > >
> > >In confidential computing usages, whether a page is private or shared is
> > >necessary information for KVM to perform operations like page fault
> > >handling, page zapping etc. There are other potential use cases for
> > >per-page memory attributes, e.g. to make memory read-only (or no-exec,
> > >or exec-only, etc.) without having to modify memslots.
> > >
> > >Introduce two ioctls (advertised by KVM_CAP_MEMORY_ATTRIBUTES) to allow
> > >userspace to operate on the per-page memory attributes.
> > >  - KVM_SET_MEMORY_ATTRIBUTES to set the per-page memory attributes to
> > >    a guest memory range.
> > 
> > >  - KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES to return the KVM supported
> > >    memory attributes.
> > 
> > This ioctl() is already removed. So, the changelog is out-of-date and needs
> > an update.
> 
> Doh, I lost track of this and the fixup for KVM_CAP_MEMORY_ATTRIBUTES below.
> 
> > >+:Capability: KVM_CAP_MEMORY_ATTRIBUTES
> > >+:Architectures: x86
> > >+:Type: vm ioctl
> > >+:Parameters: struct kvm_memory_attributes(in)
> > 
> > 					   ^ add one space here?
> 
> Ah, yeah, that does appear to be the standard.
> > 
> > 
> > >+static bool kvm_pre_set_memory_attributes(struct kvm *kvm,
> > >+					  struct kvm_gfn_range *range)
> > >+{
> > >+	/*
> > >+	 * Unconditionally add the range to the invalidation set, regardless of
> > >+	 * whether or not the arch callback actually needs to zap SPTEs.  E.g.
> > >+	 * if KVM supports RWX attributes in the future and the attributes are
> > >+	 * going from R=>RW, zapping isn't strictly necessary.  Unconditionally
> > >+	 * adding the range allows KVM to require that MMU invalidations add at
> > >+	 * least one range between begin() and end(), e.g. allows KVM to detect
> > >+	 * bugs where the add() is missed.  Rexlaing the rule *might* be safe,
> > 
> > 					    ^^^^^^^^ Relaxing
> > 
> > >@@ -4640,6 +4850,17 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
> > > 	case KVM_CAP_BINARY_STATS_FD:
> > > 	case KVM_CAP_SYSTEM_EVENT_DATA:
> > > 		return 1;
> > >+#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
> > >+	case KVM_CAP_MEMORY_ATTRIBUTES:
> > >+		u64 attrs = kvm_supported_mem_attributes(kvm);
> > >+
> > >+		r = -EFAULT;
> > >+		if (copy_to_user(argp, &attrs, sizeof(attrs)))
> > >+			goto out;
> > >+		r = 0;
> > >+		break;
> > 
> > This cannot work, e.g., no @argp in this function and is fixed by a later commit:
> > 
> > 	fcbef1e5e5d2 ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")
> 
> I'll post a fixup patch for all of these, thanks much!

Heh, that was an -ENOCOFFEE.  Fixup patches for a changelog goof and an ephemeral
bug are going to be hard to post.

Paolo, do you want to take care of all of these fixups and typos, or would you
prefer that I start a v14 branch and then hand it off to you at some point?
