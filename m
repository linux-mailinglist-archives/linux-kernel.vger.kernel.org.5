Return-Path: <linux-kernel+bounces-71609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C18AF85A7B3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E69FD1C2224C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420B93A1BF;
	Mon, 19 Feb 2024 15:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHDsck8i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7584439840;
	Mon, 19 Feb 2024 15:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708357438; cv=none; b=AqsJG0y5lcUqWXLE2N9+ymS0m9kJCI6qEA3ohuU9cL2p4iM3Z7ZOC6a8jDcToquzphLoK9lAqGK//J9qFD82/4VG4icuK/hNR2CUgFDrzFrsCxVye3FqO2fS6BkQwXaWpchqsP7kMJc6HqJh8pJ9+dL3pWBf9TTL8GKUs0npl24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708357438; c=relaxed/simple;
	bh=Bohw/bQPmhHQbLkJwGb3KJCaLF1Qkwt6GeyegCF9liw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bX0W7R6SdRCwf9YG83Dt4KV00wtQKHki2FPKWFPJo0bq6lrvxQ7Ws1R4Xy2wrOVmsd74w5MkvPRHEiCWQ/9IMG0YCD5noUOS5qQvTYB9QTnx34pZFBChHJmUmyjq64AZZlyeQgR1uXOM6YrIWqRB3R+cl4Qb7dDjDLV0BWKRiUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHDsck8i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4BD7C43399;
	Mon, 19 Feb 2024 15:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708357437;
	bh=Bohw/bQPmhHQbLkJwGb3KJCaLF1Qkwt6GeyegCF9liw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PHDsck8ig8UVnrcvTAdSJFp8/p7ksYDXvn4bgh61MVPcjWXGrOtRApdk+LepchXTX
	 crE2kKhzja1AsBjOqV/DhkUNAyhreeSdwid8Zb+FZoiT7fPRMsPOTgnL8xGoWtkktw
	 1TBu37eGh/CCRzZS2kXxI5eOaghFtWuPQYuaqoHAb36L7vuK9jI+dPxq1Eksyu6XaO
	 QDR46mJ1JdTFTtz6lImKbIypKVAXiP+P47+RBFT0NZPmxKzBTHlYR4kniicQMCsAZA
	 qVTtTjm4vjuq8fh7p+AogP8twmWjOgHNtSFiQZ1knm+q2PiO3VRkdeS8BuXHSxorSA
	 nkVVzVuQNQP3g==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-512bde3d197so645483e87.0;
        Mon, 19 Feb 2024 07:43:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXFX+dcuCN3ssQtjuEtNx0+ta6j2xyVEZIWLgNx1+HvtUck2trV+WIbGYWhOPGAu2/cLwZyaDeOQNhg+s/7m+JEO6kxWpOcxBKmcqYWglhQiXuVXRStrSjwlpIOp5i7RxC3lBAxG2zjFQ==
X-Gm-Message-State: AOJu0YzdAa9RzEoOgjswme2fdc4kmFBcDMfDUkJDgH9MRfv4FvykgjGH
	W+UjdKN5/is0ybkrc3oCMBEqRMLgnUBYtLHDZ4D0QvpeyX/D1x/gj3FPBiRS0F3jIlnunWp+QzQ
	cUJW6ALeUQUncT1mXgzN7krr+lKU=
X-Google-Smtp-Source: AGHT+IHQf07kEE68xnwbtGzmWP2oj1ydQbkfn2UMLj/otUhl4maUjhyQ9Us3BfTNv1SBfSazBGd6gNllMltwd+JtDa4=
X-Received: by 2002:a05:6512:1590:b0:512:8d5d:6707 with SMTP id
 bp16-20020a056512159000b005128d5d6707mr8547694lfb.35.1708357436047; Mon, 19
 Feb 2024 07:43:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219135805.1c4138a3@canb.auug.org.au> <ZdNGGrUDWfvqCudV@arm.com>
 <86bk8c4gyh.wl-maz@kernel.org>
In-Reply-To: <86bk8c4gyh.wl-maz@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 19 Feb 2024 16:43:45 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEpx_Yq48waCghm88dhhL6+g07Fru53=kyVh-wg8vJcdw@mail.gmail.com>
Message-ID: <CAMj1kXEpx_Yq48waCghm88dhhL6+g07Fru53=kyVh-wg8vJcdw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the kvm-arm tree with the arm64 tree
To: Marc Zyngier <maz@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Christoffer Dall <cdall@cs.columbia.edu>, Will Deacon <will@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Feb 2024 at 16:22, Marc Zyngier <maz@kernel.org> wrote:
>
> On Mon, 19 Feb 2024 12:14:18 +0000,
> Catalin Marinas <catalin.marinas@arm.com> wrote:
> >
> > On Mon, Feb 19, 2024 at 01:58:05PM +1100, Stephen Rothwell wrote:
> > > diff --cc arch/arm64/kernel/cpufeature.c
> > > index 0be9296e9253,f309fd542c20..000000000000
> > > --- a/arch/arm64/kernel/cpufeature.c
> > > +++ b/arch/arm64/kernel/cpufeature.c
> > > @@@ -721,13 -754,12 +756,14 @@@ static const struct __ftr_reg_entry
> > >                            &id_aa64isar2_override),
> > >
> > >     /* Op1 = 0, CRn = 0, CRm = 7 */
> > >  -  ARM64_FTR_REG(SYS_ID_AA64MMFR0_EL1, ftr_id_aa64mmfr0),
> > >  +  ARM64_FTR_REG_OVERRIDE(SYS_ID_AA64MMFR0_EL1, ftr_id_aa64mmfr0,
> > >  +                         &id_aa64mmfr0_override),
> > >     ARM64_FTR_REG_OVERRIDE(SYS_ID_AA64MMFR1_EL1, ftr_id_aa64mmfr1,
> > >                            &id_aa64mmfr1_override),
> > >  -  ARM64_FTR_REG(SYS_ID_AA64MMFR2_EL1, ftr_id_aa64mmfr2),
> > >  +  ARM64_FTR_REG_OVERRIDE(SYS_ID_AA64MMFR2_EL1, ftr_id_aa64mmfr2,
> > >  +                         &id_aa64mmfr2_override),
> > >     ARM64_FTR_REG(SYS_ID_AA64MMFR3_EL1, ftr_id_aa64mmfr3),
> > > +   ARM64_FTR_REG(SYS_ID_AA64MMFR4_EL1, ftr_id_aa64mmfr4),
> > >
> > >     /* Op1 = 1, CRn = 0, CRm = 0 */
> > >     ARM64_FTR_REG(SYS_GMID_EL1, ftr_gmid),
> > > @@@ -2701,33 -2817,13 +2779,40 @@@ static const struct arm64_cpu_capabilit
> > >             .type = ARM64_CPUCAP_SYSTEM_FEATURE,
> > >             .matches = has_lpa2,
> > >     },
> > >  +#ifdef CONFIG_ARM64_VA_BITS_52
> > >  +  {
> > >  +          .capability = ARM64_HAS_VA52,
> > >  +          .type = ARM64_CPUCAP_BOOT_CPU_FEATURE,
> > >  +          .matches = has_cpuid_feature,
> > >  +          .field_width = 4,
> > >  +#ifdef CONFIG_ARM64_64K_PAGES
> > >  +          .desc = "52-bit Virtual Addressing (LVA)",
> > >  +          .sign = FTR_SIGNED,
> > >  +          .sys_reg = SYS_ID_AA64MMFR2_EL1,
> > >  +          .field_pos = ID_AA64MMFR2_EL1_VARange_SHIFT,
> > >  +          .min_field_value = ID_AA64MMFR2_EL1_VARange_52,
> > >  +#else
> > >  +          .desc = "52-bit Virtual Addressing (LPA2)",
> > >  +          .sys_reg = SYS_ID_AA64MMFR0_EL1,
> > >  +#ifdef CONFIG_ARM64_4K_PAGES
> > >  +          .sign = FTR_SIGNED,
> > >  +          .field_pos = ID_AA64MMFR0_EL1_TGRAN4_SHIFT,
> > >  +          .min_field_value = ID_AA64MMFR0_EL1_TGRAN4_52_BIT,
> > >  +#else
> > >  +          .sign = FTR_UNSIGNED,
> > >  +          .field_pos = ID_AA64MMFR0_EL1_TGRAN16_SHIFT,
> > >  +          .min_field_value = ID_AA64MMFR0_EL1_TGRAN16_52_BIT,
> > >  +#endif
> > >  +#endif
> > >  +  },
> > >  +#endif
> > > +   {
> > > +           .desc = "NV1",
> > > +           .capability = ARM64_HAS_HCR_NV1,
> > > +           .type = ARM64_CPUCAP_SYSTEM_FEATURE,
> > > +           .matches = has_nv1,
> > > +           ARM64_CPUID_FIELDS_NEG(ID_AA64MMFR4_EL1, E2H0, NI_NV1)
> > > +   },
> > >     {},
> > >   };
> >
> > Thanks Stephen. It looks fine.
>
> Actually, it breaks 52bit support in a "subtle" way (multiple reports
> on the list and IRC, all pointing to failures on QEMU). The KVM tree
> adds support for feature ranges, which this code is totally unaware
> of, and only provides the min value and not the max. Things go wrong
> from there.
>
> I propose to fix it like below, which makes it robust against the KVM
> changes (patch applies to arm64/for-next/core). I have tested it in
> combination with kvmarm/next, with 4kB and 16kB (LVA2), as well as
> 64kB (LVA).
>
> Thanks,
>
>         M.
>
> From f24638a5f41424faf47f3d9035e6dcbd3800fcb6 Mon Sep 17 00:00:00 2001
> From: Marc Zyngier <maz@kernel.org>
> Date: Mon, 19 Feb 2024 15:13:22 +0000
> Subject: [PATCH] arm64: Use Signed/Unsigned enums for TGRAN{4,16,64} and
>  VARange
>
> Open-coding the feature matching parameters for LVA/LVA2 leads to
> issues with upcoming changes to the cpufeature code.
>
> By making TGRAN{4,16,64} and VARange signed/unsigned as per the
> architecture, we can use the existing macros, making the feature
> match robust against those changes.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Thanks for the fix.

Acked-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Ard Biesheuvel <ardb@kernel.org>

