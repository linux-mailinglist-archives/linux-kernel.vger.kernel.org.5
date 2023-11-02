Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE32E7DF531
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 15:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjKBOgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 10:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjKBOgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 10:36:16 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0D7185
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 07:36:14 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7788f727dd7so58390985a.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 07:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698935773; x=1699540573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGQNRc9zE40ysVevY/WGU/Lu6W4371YJar5QqeiLOSY=;
        b=hyhmBDZP/FH1NQ1CnlAGSiygV2gJrwpH7BGVAbQJAQcL2N4U8BO8Fo/09dEQL4EvlC
         dart+z8obIgWwK5GWLrAl9/IRFYbTxlB7FMfMEdThFsm1J+z6m26G8t+zok3fRATp0A7
         vFegvMIL6Qw9aa6h/bcmDou5sUDII5tk7AJUXc7kgrvXxiFW5T/rNZE2W/O4bwa6fIih
         77NfWyNx8HN9dCe5FEE5Ao9xegwrGlisbnN6uIil88e+FDFtkYCidpr8z2anS05kUEU8
         rsSScaHN3rhVZye2+hKSTgIpFOT5IjkEhBK/J+O8lcaYT19DeBDy4fjsfDebeYmBFUo4
         L32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698935773; x=1699540573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGQNRc9zE40ysVevY/WGU/Lu6W4371YJar5QqeiLOSY=;
        b=OOANtEcsXDi9fDFGTHP7N86rV2A9/w+4kxaeIc+sM2xIduDvSUDEX1XTEGnWZZo4cc
         2Ny/PYcv6M0DhnZXgudEAF8a5IfVEpBcYprIM/xur+bsH6oA8UjJ0ZaW7cs9DBYkGdZz
         RgJA5SBDO/WVNI6G2aF6Jiok44vUye07/H1GWQta71OnwUo4YNb1p9LD7TisOC15YBD1
         sj9xmna6UxLBVmNrrmz/rcB9GWBDR8pt3hDRR6I7aKXye/djKG9bwl4+wSkkr7B0AD3D
         iYUf02Zv3CJdw61AhG10UFZgg42bPxZGFG3xP9ot/SfdL/xGp95OvtbiwnCscsHxfsMY
         xKVQ==
X-Gm-Message-State: AOJu0YxF2gw4O4YK1yIfBiW1C7sQFos3rSKsGful51u3eHImMfut0zAR
        oAbQCrnkUs/SxhCrhSJy68zzsLeMIrfmIF4vnenP1Q==
X-Google-Smtp-Source: AGHT+IG3zQONLtNNLFCBisiqnyb2KBBdAZoBcVXn8ZKHSOcO4zLCu8vZ+2T5E0OEe4jyHp5mk0SJgyrOfTeARfH9hlY=
X-Received: by 2002:a05:6214:242e:b0:66d:a90f:c06 with SMTP id
 gy14-20020a056214242e00b0066da90f0c06mr22425828qvb.14.1698935773112; Thu, 02
 Nov 2023 07:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-22-seanjc@google.com>
In-Reply-To: <20231027182217.3615211-22-seanjc@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Thu, 2 Nov 2023 14:35:36 +0000
Message-ID: <CA+EHjTzk0=24wGbxQUApAY4B-K3xO3+SOfLn1tPJk-hVJY0+GQ@mail.gmail.com>
Subject: Re: [PATCH v13 21/35] KVM: Drop superfluous __KVM_VCPU_MULTIPLE_ADDRESS_SPACE
 macro
To:     Sean Christopherson <seanjc@google.com>
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 7:23=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Drop __KVM_VCPU_MULTIPLE_ADDRESS_SPACE and instead check the value of
> KVM_ADDRESS_SPACE_NUM.
>
> No functional change intended.
>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---

Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

>  arch/x86/include/asm/kvm_host.h | 1 -
>  include/linux/kvm_host.h        | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
> index 8d60e4745e8b..6702f795c862 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -2124,7 +2124,6 @@ enum {
>  #define HF_SMM_MASK            (1 << 1)
>  #define HF_SMM_INSIDE_NMI_MASK (1 << 2)
>
> -# define __KVM_VCPU_MULTIPLE_ADDRESS_SPACE
>  # define KVM_ADDRESS_SPACE_NUM 2
>  # define kvm_arch_vcpu_memslots_id(vcpu) ((vcpu)->arch.hflags & HF_SMM_M=
ASK ? 1 : 0)
>  # define kvm_memslots_for_spte_role(kvm, role) __kvm_memslots(kvm, (role=
).smm)
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index e3223cafd7db..c3cfe08b1300 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -692,7 +692,7 @@ bool kvm_arch_irqchip_in_kernel(struct kvm *kvm);
>  #define KVM_MEM_SLOTS_NUM SHRT_MAX
>  #define KVM_USER_MEM_SLOTS (KVM_MEM_SLOTS_NUM - KVM_INTERNAL_MEM_SLOTS)
>
> -#ifndef __KVM_VCPU_MULTIPLE_ADDRESS_SPACE
> +#if KVM_ADDRESS_SPACE_NUM =3D=3D 1
>  static inline int kvm_arch_vcpu_memslots_id(struct kvm_vcpu *vcpu)
>  {
>         return 0;
> --
> 2.42.0.820.g83a721a137-goog
>
