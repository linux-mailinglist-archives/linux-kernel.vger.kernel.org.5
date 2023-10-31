Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B917DC383
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 01:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbjJaAS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 20:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236294AbjJaASZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 20:18:25 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E2BE1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 17:18:21 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5afe220cadeso41533677b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 17:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698711501; x=1699316301; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A/LRaTLkejTxBM8pIW/wY9k081He9jXDc1u8/vyc5yU=;
        b=1s4HUF5HGBa7X35BpqnWbaCEyhfAhcgrBER8yKEG3zV7xRlS15aK3d0yH2oH2BiGf7
         UJkPQ1acvr9TUB8EOd4NuDsop/tl8lnnBJt0+/7cT0R+qSYl+oqT7Vq2i6TtvcJ5RX5A
         1KuFknKChUpsMHNnBJ7akDBVqdNRXO46aULz9r0Y7ZgF+qipO62g9KUo/OxRS2HUPGC8
         NbPAXrjb22/pfmaZCZuEr57qvmdnhxb8XFqWYBOvoiqApEv1ccMVarcwwRarSISGIlaZ
         yZJONgmGSyRyXim0v+/HK2moTmvK1nm/AnHf44QlO0MyWbJF37Nl6zdZZyn8RpeyXDqT
         cVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698711501; x=1699316301;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A/LRaTLkejTxBM8pIW/wY9k081He9jXDc1u8/vyc5yU=;
        b=i4xfYt+pKUlluVgtUIKwwfQTpqdlN9ERMsGBD4/Aa7X3GVTGAcv90c3KlqRZ9DF3pG
         lw60lF18yei8SfB0QLK6hAG4r4yakCVf+zFWvvC9+nOIAHkp0Qy6d7o21u2+xySvwivX
         IZ8Xa8mx40ObcyrnCRMyrtxQ4YjfiQZQQg91BThl1E0EGzP1JfWuXi5CtiPbtbQULeFc
         NHH3lesF+EN4KioJh8RfXMAqCpYfeta2CZ0B3rFfB2XMZCW+5tmrwYixO8iD5uzTqb/j
         hVqd6exbWfUW/8a9b4m9/Er8Tt5oMsZRvymdhbxPqfdwfePktlljNtYb83bPoIiPZJLi
         PE3A==
X-Gm-Message-State: AOJu0YzFUkWgrfq1qyqs9dcWV4+9qY7RfNgjG7ISeagnrAAYa19B3QOI
        Gs7UT6+azusUtBt9RQ4bf++n0N78qv4=
X-Google-Smtp-Source: AGHT+IHXEBSMgWOLLItH3ZyzwVZ95nnvcf8ZeQIGcTFfJ9alEhiQZOfJ5t56nJTNUPAWz2jzQYzE0vm4h+I=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:ca0f:0:b0:5a1:d329:829c with SMTP id
 m15-20020a0dca0f000000b005a1d329829cmr241205ywd.0.1698711501089; Mon, 30 Oct
 2023 17:18:21 -0700 (PDT)
Date:   Mon, 30 Oct 2023 17:18:19 -0700
In-Reply-To: <afa0d4ec-4b37-4a67-b546-016148ef4efe@redhat.com>
Mime-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-9-seanjc@google.com>
 <211d093f-4023-4a39-a23f-6d8543512675@redhat.com> <ZUARTvhpChFSGF9s@google.com>
 <afa0d4ec-4b37-4a67-b546-016148ef4efe@redhat.com>
Message-ID: <ZUBHy3rrJN8kbFCH@google.com>
Subject: Re: [PATCH v13 08/35] KVM: Introduce KVM_SET_USER_MEMORY_REGION2
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Marc Zyngier <maz@kernel.org>,
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

On Tue, Oct 31, 2023, Paolo Bonzini wrote:
> On 10/30/23 21:25, Sean Christopherson wrote:
> > > Probably worth adding a check on valid flags here.
> > 
> > Definitely needed.  There's a very real bug here.  But rather than duplicate flags
> > checking or plumb @ioctl all the way to __kvm_set_memory_region(), now that we
> > have the fancy guard(mutex) and there are no internal calls to kvm_set_memory_region(),
> > what if we:
> > 
> >    1. Acquire/release slots_lock in __kvm_set_memory_region()
> >    2. Call kvm_set_memory_region() from x86 code for the internal memslots
> >    3. Disallow *any* flags for internal memslots
> >    4. Open code check_memory_region_flags in kvm_vm_ioctl_set_memory_region()
> 
> I dislike this step, there is a clear point where all paths meet
> (ioctl/internal, locked/unlocked) and that's __kvm_set_memory_region().
> I think that's the place where flags should be checked.  (I don't mind
> the restriction on internal memslots; it's just that to me it's not a
> particularly natural way to structure the checks).

Yeah, I just don't like the discrepancy it causes where some flags are explicitly
checked and allowed, allowed and then later disallowed.

> On the other hand, the place where to protect from out-of-bounds
> accesses, is the place where you stop caring about struct
> kvm_userspace_memory_region vs kvm_userspace_memory_region2 (and
> your code gets it right, by dropping "ioctl" as soon as possible).
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 87f45aa91ced..fe5a2af14fff 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1635,6 +1635,14 @@ bool __weak kvm_arch_dirty_log_supported(struct kvm *kvm)
>  	return true;
>  }
> +/*
> + * Flags that do not access any of the extra space of struct
> + * kvm_userspace_memory_region2.  KVM_SET_USER_MEMORY_REGION_FLAGS
> + * only allows these.
> + */
> +#define KVM_SET_USER_MEMORY_REGION_FLAGS \

Can we name this KVM_SET_USER_MEMORY_REGION_LEGACY_FLAGS, or something equally
horrific?  As is, this sounds way too much like a generic "allowed flags for any
memory region".

Or maybe invert the macro?  I.e. something to make it more obvious that it's
effectively a versioning check, not a generic "what's supported?" check.

#define KVM_SET_USER_MEMORY_FLAGS_V2_ONLY \
	(~(KVM_MEM_LOG_DIRTY_PAGES | KVM_MEM_READONLY))


> +	(KVM_MEM_LOG_DIRTY_PAGES | KVM_MEM_READONLY)
> +
>  static int check_memory_region_flags(struct kvm *kvm,
>  				     const struct kvm_userspace_memory_region2 *mem)
>  {
> @@ -5149,10 +5149,16 @@ static long kvm_vm_ioctl(struct file *filp,
>  		struct kvm_userspace_memory_region2 mem;
>  		unsigned long size;
> -		if (ioctl == KVM_SET_USER_MEMORY_REGION)
> +		if (ioctl == KVM_SET_USER_MEMORY_REGION) {
> +			/*
> +			 * Fields beyond struct kvm_userspace_memory_region shouldn't be
> +			 * accessed, but avoid leaking kernel memory in case of a bug.
> +			 */
> +			memset(&mem, 0, sizeof(mem));
>  			size = sizeof(struct kvm_userspace_memory_region);
> -		else
> +		} else {
>  			size = sizeof(struct kvm_userspace_memory_region2);
> +		}
>  		/* Ensure the common parts of the two structs are identical. */
>  		SANITY_CHECK_MEM_REGION_FIELD(slot);
> @@ -5165,6 +5167,11 @@ static long kvm_vm_ioctl(struct file *filp,
>  		if (copy_from_user(&mem, argp, size))
>  			goto out;
> +		r = -EINVAL;
> +		if (ioctl == KVM_SET_USER_MEMORY_REGION &&
> +		    (mem->flags & ~KVM_SET_USER_MEMORY_REGION_FLAGS))
> +			goto out;
> +
>  		r = kvm_vm_ioctl_set_memory_region(kvm, &mem);
>  		break;
>  	}
> 
> 
> That's a kind of patch that you can't really get wrong (though I have
> the brown paper bag ready).
> 
> Maintainance-wise it's fine, since flags are being added at a pace of
> roughly one every five years,

Heh, true.

> and anyway it's also future proof: I placed the #define near
> check_memory_region_flags so that in five years we remember to keep it up to
> date.  But worst case, the new flags will only be allowed by
> KVM_SET_USER_MEMORY_REGION2 unnecessarily; there are no security issues
> waiting to bite us.
>
> In sum, this is exactly the only kind of fix that should be in the v13->v14
> delta.

Boiling the ocean can be fun too ;-)
