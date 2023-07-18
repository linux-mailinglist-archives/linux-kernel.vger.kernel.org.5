Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64174758242
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbjGRQjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbjGRQjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:39:15 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FE2118
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:39:14 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-346099c6f43so179335ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689698354; x=1690303154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GG+/1fcvh5KqnoX850UtmvkXdfZhV+IvDLNUAsjH7cc=;
        b=TlTJiU5V+Q7OUEoY/0iRtJ7YOl8iw5mA9ajGTVmhWVCDz2388rieiZ0p1hVAdlJRrN
         z+C5FNBA5Bhs4GTEd0P+XnMXD7aE7cHwEn3Xnw7Fkd2graDraNrbyoqN9RF18Wzf5NzK
         psVNYtQh5Hax4YUuv9Cq+kXKBwdEQrArluQWO+rjsoSjPkvfh1rFVcDSiCznYvckC93H
         pC3BUBy5jSxy4ZGJJpWIeM0eonL1pGTFSfffbPGAKWjxUay0BH/zW6QMQ1yKgK7bwicK
         KXhSZ8truc0Oxx3bbcLYOVk5ujff5zNVB8oqau4fw7lRejIcK87ji4T8ISw4mkz33qRa
         eSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689698354; x=1690303154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GG+/1fcvh5KqnoX850UtmvkXdfZhV+IvDLNUAsjH7cc=;
        b=IZSoYYxsYWOdGvSNgEn0EQ3hItpeimmQHNgDgB0A9zJDWwoRk51Xdazxqkssr9lXr+
         Of7kFrlsO6Nhytrh0KIvnHoFDZzSlFCzw62wR9gFmlMt1DLte/IQin4I5YiDxDRCLhVs
         D5wOlWqRdEGsam50zSZUqx01XTf8xPJEXwDAsrOZl17GzYx0vDoCCsWqhf9iYwR1+w+5
         iD3Kk/lzkmW/6qhDYzXzt0IVk3t8eBRtT/vUfwtl3AULbbwZJTfryIdni2/5wcGJP7Rx
         mlAiGyx9Eo8uJZ+VuGcJtTvP1wKqlKUWNfuCrchj3mAmIMttvksulUwOiKyhAav3Z0nx
         r9xg==
X-Gm-Message-State: ABy/qLYM4K/+VmiwTszwXs0TBPHhE0b4K3KKrXpWJbUhR2//PCdmK65a
        rSmcXyQq3X3341JI6KFh3KMfjwVU2VJe3QlRBCVFnQ==
X-Google-Smtp-Source: APBJJlEeclBbyqTcLuu/Vnmge1cXNugZ3jxBkbdI1YXf+AHLvPkW9iPFyexvlRbMwFGOxqLWLSEtQPkPAiZqdo8kXgo=
X-Received: by 2002:a05:6e02:b2a:b0:346:90d:10c7 with SMTP id
 e10-20020a056e020b2a00b00346090d10c7mr302973ilu.20.1689698353849; Tue, 18 Jul
 2023 09:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230715005405.3689586-1-rananta@google.com> <20230715005405.3689586-7-rananta@google.com>
 <0b2b367e-30c7-672e-f249-e4100c4dff5f@redhat.com>
In-Reply-To: <0b2b367e-30c7-672e-f249-e4100c4dff5f@redhat.com>
From:   Raghavendra Rao Ananta <rananta@google.com>
Date:   Tue, 18 Jul 2023 09:39:02 -0700
Message-ID: <CAJHc60whqQ0fnE9_Uv1GRuCYq+_DDyN_Jaw_hOgnRYx-8F7JVg@mail.gmail.com>
Subject: Re: [PATCH v6 06/11] KVM: arm64: Implement __kvm_tlb_flush_vmid_range()
To:     Shaoqin Huang <shahuang@redhat.com>
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
        kvm@vger.kernel.org, Gavin Shan <gshan@redhat.com>
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

On Tue, Jul 18, 2023 at 12:50=E2=80=AFAM Shaoqin Huang <shahuang@redhat.com=
> wrote:
>
> Hi Raghavendra,
>
> On 7/15/23 08:54, Raghavendra Rao Ananta wrote:
> > Define  __kvm_tlb_flush_vmid_range() (for VHE and nVHE)
> > to flush a range of stage-2 page-tables using IPA in one go.
> > If the system supports FEAT_TLBIRANGE, the following patches
> > would conviniently replace global TLBI such as vmalls12e1is
> > in the map, unmap, and dirty-logging paths with ripas2e1is
> > instead.
> >
> > Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> > Reviewed-by: Gavin Shan <gshan@redhat.com>
> > ---
> >   arch/arm64/include/asm/kvm_asm.h   |  3 +++
> >   arch/arm64/kvm/hyp/nvhe/hyp-main.c | 11 +++++++++++
> >   arch/arm64/kvm/hyp/nvhe/tlb.c      | 30 +++++++++++++++++++++++++++++=
+
> >   arch/arm64/kvm/hyp/vhe/tlb.c       | 23 +++++++++++++++++++++++
> >   4 files changed, 67 insertions(+)
> >
> > diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/=
kvm_asm.h
> > index 7d170aaa2db4..2c27cb8cf442 100644
> > --- a/arch/arm64/include/asm/kvm_asm.h
> > +++ b/arch/arm64/include/asm/kvm_asm.h
> > @@ -70,6 +70,7 @@ enum __kvm_host_smccc_func {
> >       __KVM_HOST_SMCCC_FUNC___kvm_tlb_flush_vmid_ipa,
> >       __KVM_HOST_SMCCC_FUNC___kvm_tlb_flush_vmid_ipa_nsh,
> >       __KVM_HOST_SMCCC_FUNC___kvm_tlb_flush_vmid,
> > +     __KVM_HOST_SMCCC_FUNC___kvm_tlb_flush_vmid_range,
> >       __KVM_HOST_SMCCC_FUNC___kvm_flush_cpu_context,
> >       __KVM_HOST_SMCCC_FUNC___kvm_timer_set_cntvoff,
> >       __KVM_HOST_SMCCC_FUNC___vgic_v3_read_vmcr,
> > @@ -229,6 +230,8 @@ extern void __kvm_tlb_flush_vmid_ipa(struct kvm_s2_=
mmu *mmu, phys_addr_t ipa,
> >   extern void __kvm_tlb_flush_vmid_ipa_nsh(struct kvm_s2_mmu *mmu,
> >                                        phys_addr_t ipa,
> >                                        int level);
> > +extern void __kvm_tlb_flush_vmid_range(struct kvm_s2_mmu *mmu,
> > +                                     phys_addr_t start, unsigned long =
pages);
> >   extern void __kvm_tlb_flush_vmid(struct kvm_s2_mmu *mmu);
> >
> >   extern void __kvm_timer_set_cntvoff(u64 cntvoff);
> > diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nv=
he/hyp-main.c
> > index a169c619db60..857d9bc04fd4 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> > @@ -135,6 +135,16 @@ static void handle___kvm_tlb_flush_vmid_ipa_nsh(st=
ruct kvm_cpu_context *host_ctx
> >       __kvm_tlb_flush_vmid_ipa_nsh(kern_hyp_va(mmu), ipa, level);
> >   }
> >
> > +static void
> > +handle___kvm_tlb_flush_vmid_range(struct kvm_cpu_context *host_ctxt)
> > +{
> > +     DECLARE_REG(struct kvm_s2_mmu *, mmu, host_ctxt, 1);
> > +     DECLARE_REG(phys_addr_t, start, host_ctxt, 2);
> > +     DECLARE_REG(unsigned long, pages, host_ctxt, 3);
> > +
> > +     __kvm_tlb_flush_vmid_range(kern_hyp_va(mmu), start, pages);
> > +}
> > +
> >   static void handle___kvm_tlb_flush_vmid(struct kvm_cpu_context *host_=
ctxt)
> >   {
> >       DECLARE_REG(struct kvm_s2_mmu *, mmu, host_ctxt, 1);
> > @@ -327,6 +337,7 @@ static const hcall_t host_hcall[] =3D {
> >       HANDLE_FUNC(__kvm_tlb_flush_vmid_ipa),
> >       HANDLE_FUNC(__kvm_tlb_flush_vmid_ipa_nsh),
> >       HANDLE_FUNC(__kvm_tlb_flush_vmid),
> > +     HANDLE_FUNC(__kvm_tlb_flush_vmid_range),
> >       HANDLE_FUNC(__kvm_flush_cpu_context),
> >       HANDLE_FUNC(__kvm_timer_set_cntvoff),
> >       HANDLE_FUNC(__vgic_v3_read_vmcr),
> > diff --git a/arch/arm64/kvm/hyp/nvhe/tlb.c b/arch/arm64/kvm/hyp/nvhe/tl=
b.c
> > index b9991bbd8e3f..09347111c2cd 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/tlb.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/tlb.c
> > @@ -182,6 +182,36 @@ void __kvm_tlb_flush_vmid_ipa_nsh(struct kvm_s2_mm=
u *mmu,
> >       __tlb_switch_to_host(&cxt);
> >   }
> >
> > +void __kvm_tlb_flush_vmid_range(struct kvm_s2_mmu *mmu,
> > +                             phys_addr_t start, unsigned long pages)
> > +{
> > +     struct tlb_inv_context cxt;
> > +     unsigned long stride;
> > +
> > +     /*
> > +      * Since the range of addresses may not be mapped at
> > +      * the same level, assume the worst case as PAGE_SIZE
> > +      */
> > +     stride =3D PAGE_SIZE;
> > +     start =3D round_down(start, stride);
> > +
> > +     /* Switch to requested VMID */
> > +     __tlb_switch_to_guest(mmu, &cxt, false);
> > +
> > +     __flush_tlb_range_op(ipas2e1is, start, pages, stride, 0, 0, false=
);
> > +
> > +     dsb(ish);
> > +     __tlbi(vmalle1is);
> > +     dsb(ish);
> > +     isb();
> > +
> > +     /* See the comment in __kvm_tlb_flush_vmid_ipa() */
> > +     if (icache_is_vpipt())
> > +             icache_inval_all_pou();
> > +
> > +     __tlb_switch_to_host(&cxt);
> > +}
> > +
> >   void __kvm_tlb_flush_vmid(struct kvm_s2_mmu *mmu)
> >   {
> >       struct tlb_inv_context cxt;
> > diff --git a/arch/arm64/kvm/hyp/vhe/tlb.c b/arch/arm64/kvm/hyp/vhe/tlb.=
c
> > index e69da550cdc5..4ed8a1786812 100644
> > --- a/arch/arm64/kvm/hyp/vhe/tlb.c
> > +++ b/arch/arm64/kvm/hyp/vhe/tlb.c
> > @@ -138,6 +138,29 @@ void __kvm_tlb_flush_vmid_ipa_nsh(struct kvm_s2_mm=
u *mmu,
> >       dsb(nsh);
> >       __tlbi(vmalle1);
> >       dsb(nsh);
> > +
> > +     __tlb_switch_to_host(&cxt);
> > +}
> > +
> > +void __kvm_tlb_flush_vmid_range(struct kvm_s2_mmu *mmu,
> > +                             phys_addr_t start, unsigned long pages)
> > +{
> > +     struct tlb_inv_context cxt;
> > +     unsigned long stride;
> > +
> > +     /*
> > +      * Since the range of addresses may not be mapped at
> > +      * the same level, assume the worst case as PAGE_SIZE
> > +      */
> > +     stride =3D PAGE_SIZE;
> > +     start =3D round_down(start, stride);
> > +
>
> Is there lack of switch VMID to guest?
>         __tlb_switch_to_guest(mmu, &cxt, false);
>
Oh right, we should have that (I think I messed up the conflict
resolution when rebasing the series to 6.5-rc1). Thanks for pointing
this out! I'll fix it in v7.

- Raghavendra
> Thanks,
> Shaoqin
>
> > +     dsb(ishst);
> > +     __flush_tlb_range_op(ipas2e1is, start, pages, stride, 0, 0, false=
);
> > +
> > +     dsb(ish);
> > +     __tlbi(vmalle1is);
> > +     dsb(ish);
> >       isb();
> >
> >       __tlb_switch_to_host(&cxt);
>
> --
> Shaoqin
>
