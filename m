Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD46752A6F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 20:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjGMSrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 14:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbjGMSrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 14:47:37 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95176211E
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 11:47:34 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b9ed206018so26135ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 11:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689274054; x=1689878854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCMwVIQzOUutbhN/GsjN6pM+paFnW3LWSf+I9hKYPpQ=;
        b=3lxVvYBLFqoAJ02OKTEDfVZUUK0wkW5kJ6VSqGoJM7b4lBnNFpCFUCFtiPuM7u9nOX
         VSzLx40KDeP0giCms38tanWNG5c8xfii4A4aZi/1HhYtk68VovRyTHE2Tw9kgrwbUWYk
         lgrmNm/UXJYJ3QUrwEpWVqgYQQt7CWi61h13oFp4tb/Z9qxx4ZK/T0ji1ZZoxOI2eUmA
         40KTd3OKOpoIH89wLfbNxh4/jZ8GdPRsy6Oxi+4m+Sv9jvQBFc4+hHiNNXGDKsBRO5ya
         acMC0ar3TRzt2JiLwJDPfGeVijikeplK1YGsCdeFNniK+KiZ+wOosH+qnrRf1sTm/NZ0
         fP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689274054; x=1689878854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cCMwVIQzOUutbhN/GsjN6pM+paFnW3LWSf+I9hKYPpQ=;
        b=DjQ0CKQTM5sc0WOGSQ0Xu3GaNbQnMSpK+1jZ6ONU3Z4KUZb0//8pzPkDw5hDhJDP9C
         erulrHe8m7RqWhr7hDyaMrxe1JA4QWu9MDYQ3e3RW/gCMmq0X91q/co1Zy6KSrrykbog
         9ksThgGCaH/JOtJ1FAQlo1LyIqH58StuZ/7mJjIvQR3aw4BUpLd+DHmnucWrsrsrGrpJ
         zW8nPeeBdNXzRMoeUcQZQbDjlC+rCsEMDmI2psQygusaLL1GEhyJWMMI2Tq2QdQk4C4Q
         JScqRx2t460fuNRhQXKzsldgnwr+HsgBOuOGO6fvKVTCFrMXE0gfsoOnZkFhaRjrHwSo
         HVgQ==
X-Gm-Message-State: ABy/qLYjIY4SntW55Hs90bctR6EFEVZImvHPIrm+kAjIcPswILVHIOgw
        pCn0tQ7U+KDJnqaJnN6ffJ649Tt5PKZ3CUAZBAJFFA==
X-Google-Smtp-Source: APBJJlFBmm7dpauUp37YeMKq373RcC3tN66u8ZQjiY1ufKfbpQJ/qTz6oxjhnsAqBc5kb4Tn8fRf3T+9JjhqDu8XLg4=
X-Received: by 2002:a17:902:bb0f:b0:1b8:9044:91d3 with SMTP id
 im15-20020a170902bb0f00b001b8904491d3mr552902plb.18.1689274053909; Thu, 13
 Jul 2023 11:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230621175002.2832640-1-rananta@google.com> <20230621175002.2832640-8-rananta@google.com>
 <1fe280a7-0f10-e124-00aa-b137df722c33@redhat.com> <CAJHc60xQtjvVsWRE=w-pAioNJW6uh-qKuZz2wp6bkT=X4oCm5A@mail.gmail.com>
 <60ba5bb4-6fad-0e51-2cd5-845610e6631d@redhat.com>
In-Reply-To: <60ba5bb4-6fad-0e51-2cd5-845610e6631d@redhat.com>
From:   Raghavendra Rao Ananta <rananta@google.com>
Date:   Thu, 13 Jul 2023 11:47:19 -0700
Message-ID: <CAJHc60y6AaAUVy=V6GHTpVhHGO3Bjn1vpTnYpdFiFLjS-vR-uA@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 07/11] KVM: arm64: Define kvm_tlb_flush_vmid_range()
To:     Gavin Shan <gshan@redhat.com>
Cc:     Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Jing Zhang <jingzhangos@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gavin,

On Wed, Jul 5, 2023 at 5:04=E2=80=AFPM Gavin Shan <gshan@redhat.com> wrote:
>
> On 7/6/23 04:28, Raghavendra Rao Ananta wrote:
> > On Tue, Jul 4, 2023 at 5:31=E2=80=AFPM Gavin Shan <gshan@redhat.com> wr=
ote:
> >> On 6/22/23 03:49, Raghavendra Rao Ananta wrote:
> >>> Implement the helper kvm_tlb_flush_vmid_range() that acts
> >>> as a wrapper for range-based TLB invalidations. For the
> >>> given VMID, use the range-based TLBI instructions to do
> >>> the job or fallback to invalidating all the TLB entries.
> >>>
> >>> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> >>> ---
> >>>    arch/arm64/include/asm/kvm_pgtable.h | 10 ++++++++++
> >>>    arch/arm64/kvm/hyp/pgtable.c         | 20 ++++++++++++++++++++
> >>>    2 files changed, 30 insertions(+)
> >>>
> >>
> >> It may be reasonable to fold this to PATCH[08/11] since kvm_tlb_flush_=
vmid_range() is
> >> only called by ARM64's kvm_arch_flush_remote_tlbs_range(), which is ad=
ded by PATCH[08/11].
> >> In either way, the changes look good to me:
> >>
> > Ah, the patches 10 and 11 also call kvm_tlb_flush_vmid_range(), so
> > probably it's better to keep the definition isolated?
> >
>
> Thanks for your explanation. It's fine to have two separate patches in th=
is
> case. I still need to spend some time to look at PATCH[11/11] whose subje=
ct
> includes typo (intructions -> instructions)
>
I'm planning to send v6 soon, but I'm happy to wait if you have any
other comments on v5 patch-11.
Appreciate your help with the reviews.

Thank you.
Raghavendra
> Thanks,
> Gavin
>
> >> Reviewed-by: Gavin Shan <gshan@redhat.com>
> >>
> >>> diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/includ=
e/asm/kvm_pgtable.h
> >>> index 4cd6762bda805..1b12295a83595 100644
> >>> --- a/arch/arm64/include/asm/kvm_pgtable.h
> >>> +++ b/arch/arm64/include/asm/kvm_pgtable.h
> >>> @@ -682,4 +682,14 @@ enum kvm_pgtable_prot kvm_pgtable_stage2_pte_pro=
t(kvm_pte_t pte);
> >>>     *     kvm_pgtable_prot format.
> >>>     */
> >>>    enum kvm_pgtable_prot kvm_pgtable_hyp_pte_prot(kvm_pte_t pte);
> >>> +
> >>> +/**
> >>> + * kvm_tlb_flush_vmid_range() - Invalidate/flush a range of TLB entr=
ies
> >>> + *
> >>> + * @mmu:     Stage-2 KVM MMU struct
> >>> + * @addr:    The base Intermediate physical address from which to in=
validate
> >>> + * @size:    Size of the range from the base to invalidate
> >>> + */
> >>> +void kvm_tlb_flush_vmid_range(struct kvm_s2_mmu *mmu,
> >>> +                             phys_addr_t addr, size_t size);
> >>>    #endif      /* __ARM64_KVM_PGTABLE_H__ */
> >>> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtabl=
e.c
> >>> index 3d61bd3e591d2..df8ac14d9d3d4 100644
> >>> --- a/arch/arm64/kvm/hyp/pgtable.c
> >>> +++ b/arch/arm64/kvm/hyp/pgtable.c
> >>> @@ -631,6 +631,26 @@ static bool stage2_has_fwb(struct kvm_pgtable *p=
gt)
> >>>        return !(pgt->flags & KVM_PGTABLE_S2_NOFWB);
> >>>    }
> >>>
> >>> +void kvm_tlb_flush_vmid_range(struct kvm_s2_mmu *mmu,
> >>> +                             phys_addr_t addr, size_t size)
> >>> +{
> >>> +     unsigned long pages, inval_pages;
> >>> +
> >>> +     if (!system_supports_tlb_range()) {
> >>> +             kvm_call_hyp(__kvm_tlb_flush_vmid, mmu);
> >>> +             return;
> >>> +     }
> >>> +
> >>> +     pages =3D size >> PAGE_SHIFT;
> >>> +     while (pages > 0) {
> >>> +             inval_pages =3D min(pages, MAX_TLBI_RANGE_PAGES);
> >>> +             kvm_call_hyp(__kvm_tlb_flush_vmid_range, mmu, addr, inv=
al_pages);
> >>> +
> >>> +             addr +=3D inval_pages << PAGE_SHIFT;
> >>> +             pages -=3D inval_pages;
> >>> +     }
> >>> +}
> >>> +
> >>>    #define KVM_S2_MEMATTR(pgt, attr) PAGE_S2_MEMATTR(attr, stage2_has=
_fwb(pgt))
> >>>
> >>>    static int stage2_set_prot_attr(struct kvm_pgtable *pgt, enum kvm_=
pgtable_prot prot,
>
