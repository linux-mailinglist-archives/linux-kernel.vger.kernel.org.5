Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010EA77EBED
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 23:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346537AbjHPVeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 17:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346540AbjHPVdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 17:33:36 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902FCFD
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:33:35 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-55c7bb27977so10694181a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692221615; x=1692826415;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+TNqWL3d830bw7UoUAlSK6Sb5FH192ad4TUZHubzgU=;
        b=Ye/CkwTjUSmFbX6Do7XI3SmnObPHrYSKXFu2VxwwjrUMLbXuP81wPEjaSZA6hLG7xJ
         H9Ye4kjEjc9PbBQ65xhUx+XO8t6fp6diRYbfVG0qj9aDzzCiCLl5lHFlibOx/YJr3TiR
         YBxncdSZFih+IdWF483R5YgRd9H1QoIZysStM/sl9HxrZTEeh0/9IYyNwk++eHvLZzg1
         Cb15vhTT2GPsOMXwW9iN66Y+4Meuwrip/U9FMs7oxf92Y4QM6I8iPqsD7Y6HOGDtGvNp
         qq2EUmmUKt2u0Zr8R5UKjlans9AArANtYHTTdObKaN5yLNcro7sUDl8KsYl473CaT/lj
         wN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692221615; x=1692826415;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R+TNqWL3d830bw7UoUAlSK6Sb5FH192ad4TUZHubzgU=;
        b=bR7qUNYysYQJpqQhd1hFMb2s5pJ4SvR6S4mL2VQKtVQ6LsxP2XYn/LYUM+8mWssjgd
         sz04xDqKqjS2Y8L4ROmHMBucUTTe+PwO5ugf0gt4uCYG8h6DA9p2WmP0qBozzSlXx7SF
         UInMQ0F4kTfnP0aLXGpMJhjGh+qmlpeBQLDTPY4cs5p4jnn6saiSHU2RdbwjzqqbZk9X
         8i1DqRQZgiLYSAUjdcDcII70rkPioitGIb5jj+PfoCnRbjZs+s0ATUZLOzwn4C3B+K7z
         Ow157DppvaeWQ5aB0LL7blAGo5x3eKCppead3fB6wlD7M6Oveim+ZKY35+/FLw8SKOHA
         ubCg==
X-Gm-Message-State: AOJu0Yyor0pcuAmbeD1Jz98drVFVWN8ZfA4zGn1l6w6pnoTSb2mw0Lqa
        hsdfyZvB3atd5CGGj8Ca6j9WeKrEGdY=
X-Google-Smtp-Source: AGHT+IGoGttkM+52JHfW4vjzHpYt1gmW/FzEhFkV1A2LWOlA2lsD9OluFklRDzhtF3myS73FHvakF6b87Cc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:3e4c:0:b0:563:dced:3f35 with SMTP id
 l73-20020a633e4c000000b00563dced3f35mr808531pga.4.1692221615018; Wed, 16 Aug
 2023 14:33:35 -0700 (PDT)
Date:   Wed, 16 Aug 2023 14:33:33 -0700
In-Reply-To: <aa17648c001704d83dcf641c1c7e9894e65eb87a.camel@intel.com>
Mime-Version: 1.0
References: <20230719144131.29052-1-binbin.wu@linux.intel.com>
 <20230719144131.29052-4-binbin.wu@linux.intel.com> <c4faf38ea79e0f4eb3d35d26c018cd2bfe9fe384.camel@intel.com>
 <66235c55-05ac-edd5-c45e-df1c42446eb3@linux.intel.com> <aa17648c001704d83dcf641c1c7e9894e65eb87a.camel@intel.com>
Message-ID: <ZN1Ardu9GRx7KlAV@google.com>
Subject: Re: [PATCH v10 3/9] KVM: x86: Use KVM-governed feature framework to
 track "LAM enabled"
From:   Sean Christopherson <seanjc@google.com>
To:     Kai Huang <kai.huang@intel.com>
Cc:     "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
        Chao Gao <chao.gao@intel.com>,
        "David.Laight@ACULAB.COM" <David.Laight@aculab.com>,
        Guang Zeng <guang.zeng@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "robert.hu@linux.intel.com" <robert.hu@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023, Kai Huang wrote:
>=20
> > > > --- a/arch/x86/kvm/vmx/vmx.c
> > > > +++ b/arch/x86/kvm/vmx/vmx.c
> > > > @@ -7783,6 +7783,9 @@ static void vmx_vcpu_after_set_cpuid(struct k=
vm_vcpu *vcpu)
> > > >   		vmx->msr_ia32_feature_control_valid_bits &=3D
> > > >   			~FEAT_CTL_SGX_LC_ENABLED;
> > > >  =20
> > > > +	if (boot_cpu_has(X86_FEATURE_LAM))
> > > > +		kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_LAM);
> > > > +
> > > If you want to use boot_cpu_has(), it's better to be done at your las=
t patch to
> > > only set the cap bit when boot_cpu_has() is true, I suppose.
> > Yes, but new version of kvm_governed_feature_check_and_set() of=20
> > KVM-governed feature framework will check against kvm_cpu_cap_has() as =
well.
> > I will remove the if statement and call=20
> > kvm_governed_feature_check_and_set()=C2=A0 directly.
> > https://lore.kernel.org/kvm/20230815203653.519297-2-seanjc@google.com/
> >=20
>=20
> I mean kvm_cpu_cap_has() checks against the host CPUID directly while her=
e you
> are using boot_cpu_has().  They are not the same. =C2=A0
>=20
> If LAM should be only supported when boot_cpu_has() is true then it seems=
 you
> can just only set the LAM cap bit when boot_cpu_has() is true.  As you al=
so
> mentioned above the kvm_governed_feature_check_and_set() here internally =
does
> kvm_cpu_cap_has().

That's covered by the last patch:

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index e961e9a05847..06061c11d74d 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -677,7 +677,7 @@ void kvm_set_cpu_caps(void)
        kvm_cpu_cap_mask(CPUID_7_1_EAX,
                F(AVX_VNNI) | F(AVX512_BF16) | F(CMPCCXADD) |
                F(FZRM) | F(FSRS) | F(FSRC) |
-               F(AMX_FP16) | F(AVX_IFMA)
+               F(AMX_FP16) | F(AVX_IFMA) | F(LAM)
        );
=20
        kvm_cpu_cap_init_kvm_defined(CPUID_7_1_EDX,


Which highlights a problem with activating a goverened feature before said =
feature
is actually supported by KVM: it's all kinds of confusing.

It'll generate a more churn in git history, but I think we should first ena=
ble
LAM without a goverened feature, and then activate a goverened feature late=
r on.
Using a goverened feature is purely an optimization, i.e. the series needs =
to be
function without using a governed feature.

That should yield an easier-to-review series on all fronts: the initial sup=
ports
won't have any more hidden dependencies than absolutely necessary, switchin=
g to
a goverened feature should be a very mechanical conversion (if it's not, th=
at's
a red flag), and last but not least, it makes it super easy to make a judgm=
ent
call as to whether using a governed feature flag is justified, because all =
of the
users will be in scope.

TL;DR: Do the whole goverened feature thing dead last.
