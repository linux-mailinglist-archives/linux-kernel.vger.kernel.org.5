Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0493C7E292B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjKFP4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbjKFP4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:56:09 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092B9118
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 07:56:06 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d99ec34829aso5356460276.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 07:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699286165; x=1699890965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2j2Mtk4lW9HEtWavGEnwteIJF5J/7dhiq9rSq3IBx+E=;
        b=jfgAGp2HE5/xK9g4UWhCfe0wF8pepGfMwluQ7Me8zjfyk6kURtfjawQkzEKUL79x23
         GA7yRpH7oYJ7PauF34lFwNQOzPOo074h3+rK5Nbw9zxFiNBJVL7dPbJmt303qnicGXhF
         nEfy/sj/763fXTU7n9f9aw4t+i+ogT4UuEHWx8nRxxHclr16shV25An5cvb61i6Now6A
         HZvr0t1B/eWzYe7LBjBhD2PvN13RVPGJ0vCSFvcA0giqJQMP2Ia9JWL28QQRK4AcKjCE
         yKF3NGLMBB0N+rtxWhEtTE6umISScKcM05FoJLvnyi5f4Ogi9MTGBHt+4K6q2C36ozTG
         krEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699286165; x=1699890965;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2j2Mtk4lW9HEtWavGEnwteIJF5J/7dhiq9rSq3IBx+E=;
        b=DP5f6fKdt1E1DVrhT+f+xk2DyfnxozWdfJkP13wWp7Gnvg17vr0+aGXLO2J6Xwf31I
         UYyfurgR6GME37dEFLZnaUOb63R0osFgVGenzS1636r1cPZnPzawTd6mRXXqZB3gHllW
         dJWOajdf4MM/nUjevMQM4EbF+n8SdBEixk+nGYceg0W/CTWHPVPFKAVriUXdPfMomNty
         5V2HMCdzLkfxxCzZ22FZz4GHRBlbcf1K3MiZ+SXCJn51B7DymjYSU59k6zdVVy6YAVsJ
         mqYFu5W9YelKrZvG6gs/zttniESaG8wYl/spApHgVEQPFpSF2/SIRTvz/evS0DV2ESTy
         zzPg==
X-Gm-Message-State: AOJu0YzX5m1h1ZiJJPpypI9sY5mPB1qV0LwnYbDDySODRZcmHO4cEEya
        cgmqEOWDThzU23Kkbz5DYkWXMyA7KzU=
X-Google-Smtp-Source: AGHT+IERk2b/M7d3G4J3vDGzrJ+T8jAsirv4bBIzvQT8OzuTMUe5AwPvC/SZu8YyGY6aMLoBT08jDOLmS/Y=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1083:b0:d9a:c3b8:4274 with SMTP id
 v3-20020a056902108300b00d9ac3b84274mr683795ybu.7.1699286165114; Mon, 06 Nov
 2023 07:56:05 -0800 (PST)
Date:   Mon, 6 Nov 2023 07:56:03 -0800
In-Reply-To: <ZUjqJjz0Epf7ii8F@yilunxu-OptiPlex-7050>
Mime-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-21-seanjc@google.com>
 <ZUeSaAKRemlSRQpO@yilunxu-OptiPlex-7050> <CABgObfb1Wf2ptitGhJPM6VcmkCG9haMoQj2BsttjeoV=9F0O9Q@mail.gmail.com>
 <ZUjqJjz0Epf7ii8F@yilunxu-OptiPlex-7050>
Message-ID: <ZUkMk6b6vZe2ANkK@google.com>
Subject: Re: [PATCH v13 20/35] KVM: x86/mmu: Handle page fault for private memory
From:   Sean Christopherson <seanjc@google.com>
To:     Xu Yilun <yilun.xu@linux.intel.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Nov 06, 2023, Xu Yilun wrote:
> On Sun, Nov 05, 2023 at 05:19:36PM +0100, Paolo Bonzini wrote:
> > On Sun, Nov 5, 2023 at 2:04=E2=80=AFPM Xu Yilun <yilun.xu@linux.intel.c=
om> wrote:
> > >
> > > > +static void kvm_mmu_prepare_memory_fault_exit(struct kvm_vcpu *vcp=
u,
> > > > +                                           struct kvm_page_fault *=
fault)
> > > > +{
> > > > +     kvm_prepare_memory_fault_exit(vcpu, fault->gfn << PAGE_SHIFT,
> > > > +                                   PAGE_SIZE, fault->write, fault-=
>exec,
> > > > +                                   fault->is_private);
> > > > +}
> > > > +
> > > > +static int kvm_faultin_pfn_private(struct kvm_vcpu *vcpu,
> > > > +                                struct kvm_page_fault *fault)
> > > > +{
> > > > +     int max_order, r;
> > > > +
> > > > +     if (!kvm_slot_can_be_private(fault->slot)) {
> > > > +             kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
> > > > +             return -EFAULT;
> > > > +     }
> > > > +
> > > > +     r =3D kvm_gmem_get_pfn(vcpu->kvm, fault->slot, fault->gfn, &f=
ault->pfn,
> > > > +                          &max_order);
> > > > +     if (r) {
> > > > +             kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
> > > > +             return r;
> > >
> > > Why report KVM_EXIT_MEMORY_FAULT here? even with a ret !=3D -EFAULT?
> >=20
> > The cases are EFAULT, EHWPOISON (which can report
> > KVM_EXIT_MEMORY_FAULT) and ENOMEM. I think it's fine
> > that even -ENOMEM can return KVM_EXIT_MEMORY_FAULT,
> > and it doesn't violate the documentation.  The docs tell you "what
> > can you do if error if EFAULT or EHWPOISON?"; they don't
> > exclude that other errnos result in KVM_EXIT_MEMORY_FAULT,
> > it's just that you're not supposed to look at it
>=20
> Thanks, it's OK for ENOMEM + KVM_EXIT_MEMORY_FAULT.
>=20
> Another concern is, now 3 places to report EFAULT + KVM_EXIT_MEMORY_FAULT=
:
>=20
>   if (!kvm_slot_can_be_private(fault->slot)) {
> 	kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
> 	return -EFAULT;
>   }
>=20
>   file =3D kvm_gmem_get_file(slot);
>   if (!file)
> 	return -EFAULT;
>=20
>   if (fault->is_private !=3D kvm_mem_is_private(vcpu->kvm, fault->gfn)) {
> 	kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
> 	return -EFAULT;
>   }
>=20
> They are different cases, and seems userspace should handle them
> differently, but not enough information to distinguish them.

For the first, the memory_fault exit will inform userspace that the guest w=
ants
to map memory as private, and userspace will see that the memslot isn't con=
figured
to support private mappings.  Userspace may not even need to query memslots=
, e.g.
if the gfn in question has been enumerated to the guest as something that c=
an only
be mapped shared.

For the second (no valid guest_memfd file), userspace put the last referenc=
e to
the guest_memfd file without informing the guest or creating a memslot.  Th=
at's
firmly a userspace bug.

For the third and last, userspace will see that the guest is requesting a p=
rivate
mapping but the gfn is configured for shared mappings.

In all cases, userspace has the necessary information to resolve the issue,=
 where
"resolving the issue" may mean terminating the guest.  If userspace isn't t=
racking
memslots or the private attribute, then userspace has far bigger problems.
