Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB367E2C8E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjKFTBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjKFTBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:01:13 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E11D8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 11:01:09 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1cc3ad55c75so31266275ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 11:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699297268; x=1699902068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PGkM+GRz/6fYflQxsLrTt3gzPDlcKqRYPaToqANSy+c=;
        b=2+OIpzdYdxqDj04JgzfNtedMgHDoURt26Pdyn3DhZnXLqalChyShHj1tM11pDsKmNf
         3tirJqFkUo/eezyxQpKXC0pBCXGlDImuabh5fTuZYCOvdbQHu9ZPLZtRedJGAV6ldTrn
         xr4xEfcqdpl0Gdw+Bfi20uLKW3PEUTc87XXL/bkV/puol379wwbPJs9AG4drYU2eFGEu
         nEIowM4lnXqC636o6DX91HlQzDIrVKepU4FoASjgKr5zyky0AkWh++oNrOdgs9m+ozRX
         4XQh4MgnpU3Hf5DXONlq5uB7Um46cLt2cByfh0hBBvi3D4QuHFOQUhZTGuqxpFfe8heG
         mTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699297268; x=1699902068;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PGkM+GRz/6fYflQxsLrTt3gzPDlcKqRYPaToqANSy+c=;
        b=WFhjxXo6bApEgxzePS2JYj9Q5hjhqEFGVcGElA6DSjqTpnSHjhwAQf1ruqIVujG+gT
         mgQY1tNaIhtv4bDJI7pTe26xgnoqQ+3gZKXBASVQ+kMPbbVXP0GUmxSiFIaflIX0lJFZ
         RYCGNuD1RK+Go+kxzFszLEs1XZGNZId93C/iGKOZXEeGAEeVxle15Z6vVPgRb5o1HUWj
         WFLbU7NLWrSVzJ+0O6hjDRpL3dLcex/druLF3mClOlsx3vkyBJywac2hliaeSsZiyyIN
         vDCmKZ0BFpzg/Gvb2lAWqHnJc6LLgXSGJh3yPv8Uk9hDxeW6k+JM/qM4cQ/1dwDFjv4V
         wQYA==
X-Gm-Message-State: AOJu0Yy/s9QGuDK4H3PytiDDjCpQOw05HYQxOkB6mLmhjGK4Gx7Zgk8a
        8p5z38ftfFxpU231mfmviUDWSuali2U=
X-Google-Smtp-Source: AGHT+IHyQBAL4dOQ5LIbv0mtbn+G8Pt/3SZ5S9Z+6RamvNchDoBzMSHY+prxoGkql5VThnidOjI97mnVEXA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ee14:b0:1ca:b952:f5fa with SMTP id
 z20-20020a170902ee1400b001cab952f5famr504750plb.5.1699297268653; Mon, 06 Nov
 2023 11:01:08 -0800 (PST)
Date:   Mon, 6 Nov 2023 11:01:07 -0800
In-Reply-To: <CALMp9eTQiom+0b5qPP_0u2tGqw9GcWbJVMNGeNZms8MTH8byuQ@mail.gmail.com>
Mime-Version: 1.0
References: <20231104000239.367005-1-seanjc@google.com> <20231104000239.367005-7-seanjc@google.com>
 <CALMp9eTQiom+0b5qPP_0u2tGqw9GcWbJVMNGeNZms8MTH8byuQ@mail.gmail.com>
Message-ID: <ZUk388PuvlcC8F2T@google.com>
Subject: Re: [PATCH v6 06/20] KVM: selftests: Add vcpu_set_cpuid_property() to
 set properties
From:   Sean Christopherson <seanjc@google.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        Like Xu <likexu@tencent.com>,
        Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2023, Jim Mattson wrote:
> On Fri, Nov 3, 2023 at 5:02=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> >
> > From: Jinrong Liang <cloudliang@tencent.com>
> >
> > Add vcpu_set_cpuid_property() helper function for setting properties, a=
nd
> > use it instead of open coding an equivalent for MAX_PHY_ADDR.  Future v=
PMU
> > testcases will also need to stuff various CPUID properties.
> >
> > Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
> > Co-developed-by: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  .../testing/selftests/kvm/include/x86_64/processor.h |  4 +++-
> >  tools/testing/selftests/kvm/lib/x86_64/processor.c   | 12 +++++++++---
> >  .../kvm/x86_64/smaller_maxphyaddr_emulation_test.c   |  2 +-
> >  3 files changed, 13 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/t=
ools/testing/selftests/kvm/include/x86_64/processor.h
> > index 25bc61dac5fb..a01931f7d954 100644
> > --- a/tools/testing/selftests/kvm/include/x86_64/processor.h
> > +++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
> > @@ -994,7 +994,9 @@ static inline void vcpu_set_cpuid(struct kvm_vcpu *=
vcpu)
> >         vcpu_ioctl(vcpu, KVM_GET_CPUID2, vcpu->cpuid);
> >  }
> >
> > -void vcpu_set_cpuid_maxphyaddr(struct kvm_vcpu *vcpu, uint8_t maxphyad=
dr);
> > +void vcpu_set_cpuid_property(struct kvm_vcpu *vcpu,
> > +                            struct kvm_x86_cpu_property property,
> > +                            uint32_t value);
> >
> >  void vcpu_clear_cpuid_entry(struct kvm_vcpu *vcpu, uint32_t function);
> >  void vcpu_set_or_clear_cpuid_feature(struct kvm_vcpu *vcpu,
> > diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools=
/testing/selftests/kvm/lib/x86_64/processor.c
> > index d8288374078e..9e717bc6bd6d 100644
> > --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> > +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> > @@ -752,11 +752,17 @@ void vcpu_init_cpuid(struct kvm_vcpu *vcpu, const=
 struct kvm_cpuid2 *cpuid)
> >         vcpu_set_cpuid(vcpu);
> >  }
> >
> > -void vcpu_set_cpuid_maxphyaddr(struct kvm_vcpu *vcpu, uint8_t maxphyad=
dr)
> > +void vcpu_set_cpuid_property(struct kvm_vcpu *vcpu,
> > +                            struct kvm_x86_cpu_property property,
> > +                            uint32_t value)
> >  {
> > -       struct kvm_cpuid_entry2 *entry =3D vcpu_get_cpuid_entry(vcpu, 0=
x80000008);
> > +       struct kvm_cpuid_entry2 *entry;
> > +
> > +       entry =3D __vcpu_get_cpuid_entry(vcpu, property.function, prope=
rty.index);
> > +
> > +       (&entry->eax)[property.reg] &=3D ~GENMASK(property.hi_bit, prop=
erty.lo_bit);
> > +       (&entry->eax)[property.reg] |=3D value << (property.lo_bit);
>=20
> What if 'value' is too large?
>=20
> Perhaps:
>          value <<=3D property.lo_bit;
>          TEST_ASSERT(!(value & ~GENMASK(property.hi_bit,
> property.lo_bit)), "value is too large");

Heh, if the mask is something like bits 31:24, this would miss the case whe=
re
shifting value would drop bits.=20

Rather than explicitly detecting edge cases, I think the simplest approach =
is to
assert that kvm_cpuid_property() reads back @value, e.g.

	struct kvm_cpuid_entry2 *entry;

	entry =3D __vcpu_get_cpuid_entry(vcpu, property.function, property.index);

	(&entry->eax)[property.reg] &=3D ~GENMASK(property.hi_bit, property.lo_bit=
);
	(&entry->eax)[property.reg] |=3D value << property.lo_bit;

	vcpu_set_cpuid(vcpu);

	/* Sanity check that @value doesn't exceed the bounds in any way. */
	TEST_ASSERT_EQ(kvm_cpuid_property(vcpu->cpuid, property), value);
