Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353B47E1EFA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 11:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjKFKzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 05:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjKFKzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:55:12 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E1FB7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 02:55:07 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-778af1b5b1eso279721985a.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 02:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699268106; x=1699872906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHBvDRtRAEwaxL1lSliJcpIEY0ugq80CfKQxFJAL4q0=;
        b=kLCasMPU31DaYByFdMZh+Xq8q1ztGZ1h3iNtcXyygXRz8HqYCqSNXqSR5G6PGQ5fKZ
         48/ER32rJstXoif6Y0klI2h+XyDQuN5mnQM5Hr2ImA8MtOnVmZDasC2LgLs3FplvMxk+
         3tBeBYzUDxbkoR8qNH0PkiSMI9yPjdicUKwathXKj48l2AP5g9+4WMy0Vkqmh3j5W76t
         NSd3+t4xUq5TycRJTtU7ZMM205ztaHbO/0GMNsXbOROvUyincs1+RZrpH68ZPnlRPzFX
         rqnnnB7mGdvqSXgUhjn+WJqA3eoP3yUfHSbTOQ4lYUJMIQdJEc8RqwKJlyCcFYE7KdnY
         QYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699268106; x=1699872906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHBvDRtRAEwaxL1lSliJcpIEY0ugq80CfKQxFJAL4q0=;
        b=iR01zoNO1ZP6Ya5RFz5AeWqip3NQ67IVNrQrJVDZQ/us7BGk0nDXn1sZiC2r7/FUWn
         9l3M1y7GSqEQfGPvgwVWr5HUD1vx0ACB7JghRpYefWWRFuUEr+D5SIuEzlvyHJ+0kMTU
         u7rIVOeo1xH/lGNSSo3ZYvLNeDUM16TcB/63w4KNdhjgGPte0a9IGiuGWzC8nQkdeoJQ
         H9eXqLcMMLvcDSr1tv+Xa5tl50OeusIf2a9zJPejpmBaRDQHrmz7YF0nbZnXO+A+5Lfu
         IVHhpw8OcabuM44bdHyYPiFhFMzU5paZwXf+2uIOBO8LKMGcNKGrzgyFkfwkIMl71Akm
         V5Fw==
X-Gm-Message-State: AOJu0Yw1s4rrIoX8PIIwDvJj3efUWGPuL2z68DrmGQIUc+bMyNKfK8kH
        ATxxMh5gTslJBPhVcDRw3bNHdlqqennwuB5CA6MXWA==
X-Google-Smtp-Source: AGHT+IHQA77T0g4ukNLcN7qAXFDRTk2DUmoX/u+9pcfa/KbWWZJ9Bol7j14XEdBbYSqTk4yOjgLv7gDTy2y1jUp9r+w=
X-Received: by 2002:ad4:5ce3:0:b0:66d:5b50:44d with SMTP id
 iv3-20020ad45ce3000000b0066d5b50044dmr43103399qvb.57.1699268106185; Mon, 06
 Nov 2023 02:55:06 -0800 (PST)
MIME-Version: 1.0
References: <20231105163040.14904-1-pbonzini@redhat.com> <20231105163040.14904-19-pbonzini@redhat.com>
In-Reply-To: <20231105163040.14904-19-pbonzini@redhat.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Mon, 6 Nov 2023 10:54:30 +0000
Message-ID: <CA+EHjTxPuAxdRZMpGCRjKbiuPOsQqoCs5LFQV8kRPvdh0emzwA@mail.gmail.com>
Subject: Re: [PATCH 18/34] KVM: x86/mmu: Handle page fault for private memory
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sean Christopherson <seanjc@google.com>,
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
        Jarkko Sakkinen <jarkko@kernel.org>,
        Anish Moorthy <amoorthy@google.com>,
        David Matlack <dmatlack@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Nov 5, 2023 at 4:33=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> From: Chao Peng <chao.p.peng@linux.intel.com>
>
> Add support for resolving page faults on guest private memory for VMs
> that differentiate between "shared" and "private" memory.  For such VMs,
> KVM_MEM_PRIVATE memslots can include both fd-based private memory and

KVM_MEM_PRIVATE  -> KVM_MEM_GUEST_MEMFD

Cheers,
/fuad

> hva-based shared memory, and KVM needs to map in the "correct" variant,
> i.e. KVM needs to map the gfn shared/private as appropriate based on the
> current state of the gfn's KVM_MEMORY_ATTRIBUTE_PRIVATE flag.
>
> For AMD's SEV-SNP and Intel's TDX, the guest effectively gets to request
> shared vs. private via a bit in the guest page tables, i.e. what the gues=
t
> wants may conflict with the current memory attributes.  To support such
> "implicit" conversion requests, exit to user with KVM_EXIT_MEMORY_FAULT
> to forward the request to userspace.  Add a new flag for memory faults,
> KVM_MEMORY_EXIT_FLAG_PRIVATE, to communicate whether the guest wants to
> map memory as shared vs. private.
>
> Like KVM_MEMORY_ATTRIBUTE_PRIVATE, use bit 3 for flagging private memory
> so that KVM can use bits 0-2 for capturing RWX behavior if/when userspace
> needs such information, e.g. a likely user of KVM_EXIT_MEMORY_FAULT is to
> exit on missing mappings when handling guest page fault VM-Exits.  In
> that case, userspace will want to know RWX information in order to
> correctly/precisely resolve the fault.
>
> Note, private memory *must* be backed by guest_memfd, i.e. shared mapping=
s
> always come from the host userspace page tables, and private mappings
> always come from a guest_memfd instance.
>
> Co-developed-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Fuad Tabba <tabba@google.com>
> Tested-by: Fuad Tabba <tabba@google.com>
> Message-Id: <20231027182217.3615211-21-seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  Documentation/virt/kvm/api.rst  |   8 ++-
>  arch/x86/kvm/mmu/mmu.c          | 101 ++++++++++++++++++++++++++++++--
>  arch/x86/kvm/mmu/mmu_internal.h |   1 +
>  include/linux/kvm_host.h        |   8 ++-
>  include/uapi/linux/kvm.h        |   1 +
>  5 files changed, 110 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.=
rst
> index 6d681f45969e..4a9a291380ad 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6953,6 +6953,7 @@ spec refer, https://github.com/riscv/riscv-sbi-doc.
>
>                 /* KVM_EXIT_MEMORY_FAULT */
>                 struct {
> +  #define KVM_MEMORY_EXIT_FLAG_PRIVATE (1ULL << 3)
>                         __u64 flags;
>                         __u64 gpa;
>                         __u64 size;
> @@ -6961,8 +6962,11 @@ spec refer, https://github.com/riscv/riscv-sbi-doc=
.
>  KVM_EXIT_MEMORY_FAULT indicates the vCPU has encountered a memory fault =
that
>  could not be resolved by KVM.  The 'gpa' and 'size' (in bytes) describe =
the
>  guest physical address range [gpa, gpa + size) of the fault.  The 'flags=
' field
> -describes properties of the faulting access that are likely pertinent.
> -Currently, no flags are defined.
> +describes properties of the faulting access that are likely pertinent:
> +
> + - KVM_MEMORY_EXIT_FLAG_PRIVATE - When set, indicates the memory fault o=
ccurred
> +   on a private memory access.  When clear, indicates the fault occurred=
 on a
> +   shared access.
>
>  Note!  KVM_EXIT_MEMORY_FAULT is unique among all KVM exit reasons in tha=
t it
>  accompanies a return code of '-1', not '0'!  errno will always be set to=
 EFAULT
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index f5c6b0643645..754a5aaebee5 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3147,9 +3147,9 @@ static int host_pfn_mapping_level(struct kvm *kvm, =
gfn_t gfn,
>         return level;
>  }
>
> -int kvm_mmu_max_mapping_level(struct kvm *kvm,
> -                             const struct kvm_memory_slot *slot, gfn_t g=
fn,
> -                             int max_level)
> +static int __kvm_mmu_max_mapping_level(struct kvm *kvm,
> +                                      const struct kvm_memory_slot *slot=
,
> +                                      gfn_t gfn, int max_level, bool is_=
private)
>  {
>         struct kvm_lpage_info *linfo;
>         int host_level;
> @@ -3161,6 +3161,9 @@ int kvm_mmu_max_mapping_level(struct kvm *kvm,
>                         break;
>         }
>
> +       if (is_private)
> +               return max_level;
> +
>         if (max_level =3D=3D PG_LEVEL_4K)
>                 return PG_LEVEL_4K;
>
> @@ -3168,6 +3171,16 @@ int kvm_mmu_max_mapping_level(struct kvm *kvm,
>         return min(host_level, max_level);
>  }
>
> +int kvm_mmu_max_mapping_level(struct kvm *kvm,
> +                             const struct kvm_memory_slot *slot, gfn_t g=
fn,
> +                             int max_level)
> +{
> +       bool is_private =3D kvm_slot_can_be_private(slot) &&
> +                         kvm_mem_is_private(kvm, gfn);
> +
> +       return __kvm_mmu_max_mapping_level(kvm, slot, gfn, max_level, is_=
private);
> +}
> +
>  void kvm_mmu_hugepage_adjust(struct kvm_vcpu *vcpu, struct kvm_page_faul=
t *fault)
>  {
>         struct kvm_memory_slot *slot =3D fault->slot;
> @@ -3188,8 +3201,9 @@ void kvm_mmu_hugepage_adjust(struct kvm_vcpu *vcpu,=
 struct kvm_page_fault *fault
>          * Enforce the iTLB multihit workaround after capturing the reque=
sted
>          * level, which will be used to do precise, accurate accounting.
>          */
> -       fault->req_level =3D kvm_mmu_max_mapping_level(vcpu->kvm, slot,
> -                                                    fault->gfn, fault->m=
ax_level);
> +       fault->req_level =3D __kvm_mmu_max_mapping_level(vcpu->kvm, slot,
> +                                                      fault->gfn, fault-=
>max_level,
> +                                                      fault->is_private)=
;
>         if (fault->req_level =3D=3D PG_LEVEL_4K || fault->huge_page_disal=
lowed)
>                 return;
>
> @@ -4269,6 +4283,55 @@ void kvm_arch_async_page_ready(struct kvm_vcpu *vc=
pu, struct kvm_async_pf *work)
>         kvm_mmu_do_page_fault(vcpu, work->cr2_or_gpa, 0, true, NULL);
>  }
>
> +static inline u8 kvm_max_level_for_order(int order)
> +{
> +       BUILD_BUG_ON(KVM_MAX_HUGEPAGE_LEVEL > PG_LEVEL_1G);
> +
> +       KVM_MMU_WARN_ON(order !=3D KVM_HPAGE_GFN_SHIFT(PG_LEVEL_1G) &&
> +                       order !=3D KVM_HPAGE_GFN_SHIFT(PG_LEVEL_2M) &&
> +                       order !=3D KVM_HPAGE_GFN_SHIFT(PG_LEVEL_4K));
> +
> +       if (order >=3D KVM_HPAGE_GFN_SHIFT(PG_LEVEL_1G))
> +               return PG_LEVEL_1G;
> +
> +       if (order >=3D KVM_HPAGE_GFN_SHIFT(PG_LEVEL_2M))
> +               return PG_LEVEL_2M;
> +
> +       return PG_LEVEL_4K;
> +}
> +
> +static void kvm_mmu_prepare_memory_fault_exit(struct kvm_vcpu *vcpu,
> +                                             struct kvm_page_fault *faul=
t)
> +{
> +       kvm_prepare_memory_fault_exit(vcpu, fault->gfn << PAGE_SHIFT,
> +                                     PAGE_SIZE, fault->write, fault->exe=
c,
> +                                     fault->is_private);
> +}
> +
> +static int kvm_faultin_pfn_private(struct kvm_vcpu *vcpu,
> +                                  struct kvm_page_fault *fault)
> +{
> +       int max_order, r;
> +
> +       if (!kvm_slot_can_be_private(fault->slot)) {
> +               kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
> +               return -EFAULT;
> +       }
> +
> +       r =3D kvm_gmem_get_pfn(vcpu->kvm, fault->slot, fault->gfn, &fault=
->pfn,
> +                            &max_order);
> +       if (r) {
> +               kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
> +               return r;
> +       }
> +
> +       fault->max_level =3D min(kvm_max_level_for_order(max_order),
> +                              fault->max_level);
> +       fault->map_writable =3D !(fault->slot->flags & KVM_MEM_READONLY);
> +
> +       return RET_PF_CONTINUE;
> +}
> +
>  static int __kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_faul=
t *fault)
>  {
>         struct kvm_memory_slot *slot =3D fault->slot;
> @@ -4301,6 +4364,14 @@ static int __kvm_faultin_pfn(struct kvm_vcpu *vcpu=
, struct kvm_page_fault *fault
>                         return RET_PF_EMULATE;
>         }
>
> +       if (fault->is_private !=3D kvm_mem_is_private(vcpu->kvm, fault->g=
fn)) {
> +               kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
> +               return -EFAULT;
> +       }
> +
> +       if (fault->is_private)
> +               return kvm_faultin_pfn_private(vcpu, fault);
> +
>         async =3D false;
>         fault->pfn =3D __gfn_to_pfn_memslot(slot, fault->gfn, false, fals=
e, &async,
>                                           fault->write, &fault->map_writa=
ble,
> @@ -7188,6 +7259,26 @@ void kvm_mmu_pre_destroy_vm(struct kvm *kvm)
>  }
>
>  #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
> +bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
> +                                       struct kvm_gfn_range *range)
> +{
> +       /*
> +        * Zap SPTEs even if the slot can't be mapped PRIVATE.  KVM x86 o=
nly
> +        * supports KVM_MEMORY_ATTRIBUTE_PRIVATE, and so it *seems* like =
KVM
> +        * can simply ignore such slots.  But if userspace is making memo=
ry
> +        * PRIVATE, then KVM must prevent the guest from accessing the me=
mory
> +        * as shared.  And if userspace is making memory SHARED and this =
point
> +        * is reached, then at least one page within the range was previo=
usly
> +        * PRIVATE, i.e. the slot's possible hugepage ranges are changing=
.
> +        * Zapping SPTEs in this case ensures KVM will reassess whether o=
r not
> +        * a hugepage can be used for affected ranges.
> +        */
> +       if (WARN_ON_ONCE(!kvm_arch_has_private_mem(kvm)))
> +               return false;
> +
> +       return kvm_unmap_gfn_range(kvm, range);
> +}
> +
>  static bool hugepage_test_mixed(struct kvm_memory_slot *slot, gfn_t gfn,
>                                 int level)
>  {
> diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_inter=
nal.h
> index decc1f153669..86c7cb692786 100644
> --- a/arch/x86/kvm/mmu/mmu_internal.h
> +++ b/arch/x86/kvm/mmu/mmu_internal.h
> @@ -201,6 +201,7 @@ struct kvm_page_fault {
>
>         /* Derived from mmu and global state.  */
>         const bool is_tdp;
> +       const bool is_private;
>         const bool nx_huge_page_workaround_enabled;
>
>         /*
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index a6de526c0426..67dfd4d79529 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2357,14 +2357,18 @@ static inline void kvm_account_pgtable_pages(void=
 *virt, int nr)
>  #define  KVM_DIRTY_RING_MAX_ENTRIES  65536
>
>  static inline void kvm_prepare_memory_fault_exit(struct kvm_vcpu *vcpu,
> -                                                gpa_t gpa, gpa_t size)
> +                                                gpa_t gpa, gpa_t size,
> +                                                bool is_write, bool is_e=
xec,
> +                                                bool is_private)
>  {
>         vcpu->run->exit_reason =3D KVM_EXIT_MEMORY_FAULT;
>         vcpu->run->memory_fault.gpa =3D gpa;
>         vcpu->run->memory_fault.size =3D size;
>
> -       /* Flags are not (yet) defined or communicated to userspace. */
> +       /* RWX flags are not (yet) defined or communicated to userspace. =
*/
>         vcpu->run->memory_fault.flags =3D 0;
> +       if (is_private)
> +               vcpu->run->memory_fault.flags |=3D KVM_MEMORY_EXIT_FLAG_P=
RIVATE;
>  }
>
>  #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 2802d10aa88c..8eb10f560c69 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -535,6 +535,7 @@ struct kvm_run {
>                 } notify;
>                 /* KVM_EXIT_MEMORY_FAULT */
>                 struct {
> +#define KVM_MEMORY_EXIT_FLAG_PRIVATE   (1ULL << 3)
>                         __u64 flags;
>                         __u64 gpa;
>                         __u64 size;
> --
> 2.39.1
>
>
