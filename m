Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C690C7E297A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 17:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjKFQNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 11:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjKFQNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 11:13:06 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBC91BC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 08:13:03 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7cf717bacso63996067b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 08:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699287183; x=1699891983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mmoUoGnC/t23H3IPxV2qsT2AAyd7sUSE5gGiJgJlDX0=;
        b=Oe1xs7MQxbs5oPRVpc1SJfxw+zaBXWx0tAzWWUfGeY0ZnxLo3TUCZUwSHoYrsLcen+
         0T98De4h1V0jyIRipVTcdvrBJ3Gf6ahV4xyT5pGJZOMVm2tQZItGID1uzEtmhh/aG+xd
         iN5yBgGbHR5grM6zMLTpWxCSPRcfeObuMhPxbVqdGo94SCvbVIL/p7EHqsDDYVZS7oux
         38cAa3a5BNG2BF/RGEaagKWyzMT3MhudxuLj0b7sjmXHkLqn1bXVwZoG0xgvZmFfzo6o
         qOXxpsu4IIKS84P9O1shcP+44+bOV0AFRJXACHqrQAZ8unbvgtfM8pN2zOg6LTUiLAxB
         P8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699287183; x=1699891983;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mmoUoGnC/t23H3IPxV2qsT2AAyd7sUSE5gGiJgJlDX0=;
        b=HhLXA2+StoAxBx/50fz5r5fmSUkJLjx68IHPBXj0scHiZ3a/pYVwRgLGu/IQlS/MXK
         sh2Mk9KHTt0nqwUxLI9J2gGfFeakr07l4IWF8A0neyr0jf0dKRzWohQt4j7+l/Zh6HKc
         kAG+YSLLwCHZbWcDY6CjEAtBLp1o+WCo2CCdadKNkCb1vPXmXid0SazeAFALIVpzL2No
         7f+cSNy9BfDbfBts2Exg/Vr1K9DIVLJs4uLFW2KhbFW7oma6i/3EpQwpBBtYDSXI8KOO
         UavQPxzxqogYgmWNEr39KD86ES5N+O+tVzhgxXfsz8q56uqdpqS5JJpADiQG/RqgUF3M
         mswg==
X-Gm-Message-State: AOJu0Yxxh3xGFvbs5IPvcCU81vJaUVQ1tQguq3l612Jwql4ndT/G2Wqj
        LSN3crot1KNJVuCe9V8alMYeFibNA7c=
X-Google-Smtp-Source: AGHT+IEuz2kxbbqGFRlRrYjmJAAmCd5YL62xYCCumvx9nTcHzja2SicRUTSCOZ5GtJw0RknzXE1Az5YHDFw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:d5d2:0:b0:5a7:ad67:b4b6 with SMTP id
 x201-20020a0dd5d2000000b005a7ad67b4b6mr228755ywd.2.1699287183068; Mon, 06 Nov
 2023 08:13:03 -0800 (PST)
Date:   Mon, 6 Nov 2023 08:13:01 -0800
In-Reply-To: <CA+EHjTxy6TWM3oBG0Q6v5090XTrs+M8_m5=6Z2E1P-HyTkrGWg@mail.gmail.com>
Mime-Version: 1.0
References: <20231105163040.14904-1-pbonzini@redhat.com> <20231105163040.14904-26-pbonzini@redhat.com>
 <CA+EHjTxy6TWM3oBG0Q6v5090XTrs+M8_m5=6Z2E1P-HyTkrGWg@mail.gmail.com>
Message-ID: <ZUkQjW-yMnLfD7XW@google.com>
Subject: Re: [PATCH 25/34] KVM: selftests: Add helpers to convert guest memory
 b/w private and shared
From:   Sean Christopherson <seanjc@google.com>
To:     Fuad Tabba <tabba@google.com>
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
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

On Mon, Nov 06, 2023, Fuad Tabba wrote:
> On Sun, Nov 5, 2023 at 4:34=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
> > +void vm_guest_mem_fallocate(struct kvm_vm *vm, uint64_t base, uint64_t=
 size,
> > +                           bool punch_hole)
> > +{
> > +       const int mode =3D FALLOC_FL_KEEP_SIZE | (punch_hole ? FALLOC_F=
L_PUNCH_HOLE : 0);
> > +       struct userspace_mem_region *region;
> > +       uint64_t end =3D base + size;
> > +       uint64_t gpa, len;
> > +       off_t fd_offset;
> > +       int ret;
> > +
> > +       for (gpa =3D base; gpa < end; gpa +=3D len) {
> > +               uint64_t offset;
> > +
> > +               region =3D userspace_mem_region_find(vm, gpa, gpa);
> > +               TEST_ASSERT(region && region->region.flags & KVM_MEM_GU=
EST_MEMFD,
> > +                           "Private memory region not found for GPA 0x=
%lx", gpa);
> > +
> > +               offset =3D (gpa - region->region.guest_phys_addr);
>=20
> nit: why the parentheses?

I simply forgot to remove them when I changed the function to support spann=
ing
multiple memslots, i.e. when the code went from this

	fd_offset =3D region->region.gmem_offset +
		    (gpa - region->region.guest_phys_addr);

to what you see above.
