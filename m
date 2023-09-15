Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91247A24DE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 19:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236302AbjIORdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 13:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236477AbjIORdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:33:19 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E4A30D1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:32:08 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d8141d6fbe3so2851264276.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694799127; x=1695403927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=37qmqTOGLaH/3KlDOB0LJ2tfWBbha6KOXpw2IUHv5RY=;
        b=rYAOZzIofa4a7zcSYcDzqyu425BdZq8GVwoSV85pRecseyBkGgTi6aC/s702w+KmF1
         Swiwx9uiZ2Jx0D+b7h0ChOUxrPfEQwKLHvcVhr2KwI+T61LN9EiEp8/nnFCM/7k24rZ9
         03A8+aZVvpiGsxwKIZ7j/ahsQZmy7i1WljjAtPcALKshzT8Uo75Idv57pqAjPCUZE3A3
         KEnQJS0FQBZDQP1yK+jJkL7T0tkzqbQRZODZANX/RgAWUdj69H4dD7Llsa5Sd3UMUdCr
         4QubVjfusqgnP9P9Xzx2vH3SSHfie1AfbGleO2vFVVNxN69gDHl8IbkK5Ajg91ASr86X
         YDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694799127; x=1695403927;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=37qmqTOGLaH/3KlDOB0LJ2tfWBbha6KOXpw2IUHv5RY=;
        b=b5F/Khk+srThxGY9slg7XnyrUWKQ4piF+P3efbSC5rZshCGJciYEbKCWxXDOPhGARe
         11Xc93ChtBrcTAFHosrdnmcXNqkYBKufq7MqRY6jlRDwT4t/C8R/TRCrv/JGXzZOcy2q
         HxPAQ1vrUbi+FKAUy7e2NacYdcPFHkQ/yqdWvlyu5j+NELnuKIVgFydGOnqO9GnEv/HM
         Y8NQnicyM0VMftDvn5SvN4rLX2VTSui/+shA/XG7BIe7RPl0US2GdrP2ztgNxH2N/KL2
         1s9nSlcBzJk4A3DSPOpKaB/JFGYD4YVUaewvdd5yTfAq+ERnar1oqCvTaa9TcpaN4FE0
         lReQ==
X-Gm-Message-State: AOJu0YzMfXgbFFeQqoSecRQNZ1t3uhf1HftjWME8gVurVRaOghLSLWZs
        vppjO++bLHKJx+caLjRK4WB0/kN/ARs=
X-Google-Smtp-Source: AGHT+IF+XsJ5L+HiDa2KDx/axVT8363f4tYUfPM+rodc1U187Wy1yA18WxaQb4Vi6kJSAHje7GfPSJyRafU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:138e:b0:d78:245a:aac4 with SMTP id
 x14-20020a056902138e00b00d78245aaac4mr57246ybu.1.1694799127413; Fri, 15 Sep
 2023 10:32:07 -0700 (PDT)
Date:   Fri, 15 Sep 2023 10:32:05 -0700
In-Reply-To: <8b047dad-84ac-69f9-3875-38bca92d7534@amd.com>
Mime-Version: 1.0
References: <cover.1694721045.git.thomas.lendacky@amd.com> <8a5c1d2637475c7fb9657cdd6cb0e86f2bb3bab6.1694721045.git.thomas.lendacky@amd.com>
 <ZQNs7uo8F62XQawJ@google.com> <f2c0907c-9e30-e01b-7d65-a20e6be4bf49@amd.com> <8b047dad-84ac-69f9-3875-38bca92d7534@amd.com>
Message-ID: <ZQSVFQ78M/OUtWaj@google.com>
Subject: Re: [PATCH 1/2] KVM: SVM: Fix TSC_AUX virtualization setup
From:   Sean Christopherson <seanjc@google.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Babu Moger <babu.moger@amd.com>
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

On Fri, Sep 15, 2023, Tom Lendacky wrote:
> On 9/14/23 15:48, Tom Lendacky wrote:
> > On 9/14/23 15:28, Sean Christopherson wrote:
> > > On Thu, Sep 14, 2023, Tom Lendacky wrote:
>=20
> >=20
> > >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (guest_cpuid_has(vcp=
u, X86_FEATURE_RDTSCP))
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 svm_clr_intercept(svm, INTERCEPT_RDTSCP);
> > >=20
> > > Same thing here.
> >=20
> > Will do.
>=20
> For RDTSCP, svm_recalc_instruction_intercepts() will set/clear the RDTSCP
> intercept as part of the svm_vcpu_set_after_cpuid() path, but it will onl=
y
> do it based on kvm_cpu_cap_has(X86_FEATURE_RDTSCP) being true, which is v=
ery
> likely.
>=20
> Do you think that is good enough and we can drop the setting and clearing=
 of
> the RDTSCP intercept in the sev_es_vcpu_set_after_cpuid() function and on=
ly
> deal with the TSC_AUX MSR intercept?

The common handling should be good enough.

> On a side note, it looks like RDTSCP would not be intercepted if the KVM =
cap
> X86_FEATURE_RDTSCP feature is cleared, however unlikely, in
> kvm_set_cpu_caps() and RDTSCP is not advertised to the guest (assuming th=
e
> guest is ignoring the RDTSCP CPUID bit).

Hmm, yes, though the only scenario in which KVM clears RDTSCP on AMD comes =
with
a WARN (it's a guard against KVM bugs).  If the guest ignores CPUID and use=
s
RDTSCP anyways, the guest deserves its death, and leaking the host pCPU doe=
sn't
seem like a major issue.

That said, if hardware behavior is to ignore unknown intercepts, e.g. if KV=
M can
safely set INTERCEPT_RDTSCP even when hardware doesn't support said interce=
pt,
then I wouldn't be opposed to doing:

	/*
	 * Intercept INVPCID if shadow paging is enabled to sync/free shadow
	 * roots, or if INVPCID is disabled in the guest to inject #UD.
	 */
	if (!kvm_cpu_cap_has(X86_FEATURE_INVPCID) ||
	    !npt_enabled || !guest_cpuid_has(&svm->vcpu, X86_FEATURE_INVPCID))
		svm_set_intercept(svm, INTERCEPT_INVPCID);
	else
		svm_clr_intercept(svm, INTERCEPT_INVPCID);

	if (kvm_cpu_cap_has(X86_FEATURE_RDTSCP) &&
	    guest_cpuid_has(vcpu, X86_FEATURE_RDTSCP))
		svm_clr_intercept(svm, INTERCEPT_RDTSCP);
	else
		svm_set_intercept(svm, INTERCEPT_RDTSCP);

Alternatively, KVM could check boot_cpu_has() instead or kvm_cpu_cap_has(),=
 but
that's not foolproof either, e.g. see Intel's of hiding PCID to workaround =
the
TLB flushing bug on Alderlake.  So my vote would either be to keep things a=
s-is,
or do the above (if that's safe).
