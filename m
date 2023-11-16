Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923BE7EE949
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 23:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbjKPW3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 17:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjKPW3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 17:29:30 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142F0D50
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 14:29:05 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da3b6438170so1758626276.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 14:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700173744; x=1700778544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EGIwhjjvgrhlrw+QQSLX3tkHhBU1bs3NPucIP+8y40A=;
        b=WDBqCypKRfmdqyIZbx4YX1B8VtiZ6pA6Hww0p0FklcH6xr/6IvVVKfHibct+QfoTPo
         hWkOGx0zD3MMwvLDaivC+dNoBgaK266d8xWj2j9Ey9IE05bSUx+G6KOh0eqyZdlDB8hJ
         +h4yE7R+sJjvIYHBLq52s9oVLMWbEGNMOObLaC7fqNk8l9yAoTfZicJGf7q3+Bbj7v1d
         Q0X9BR7h3XkncZ9A3RQcLumiYYfl+ahBstWmeSpFjn0Pul7vtA0NNjNJUM+XkNJ2gGKX
         wol4BoRq8m4nESwhkbB0xlI+YAimQKd1/WNsWFeACQJpPBDGeDmEP4VEfHQbjzxNTYY1
         ROcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700173744; x=1700778544;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EGIwhjjvgrhlrw+QQSLX3tkHhBU1bs3NPucIP+8y40A=;
        b=cIoBuUzbx7ApW018MsqH0O2s5Sn+zVmN2P6ibY7XyzFISPzcdIAzJkED2Qttl5g/AL
         YTZLq6oyCR+Q8dzmQhE8tqqNJL5Cnxdk44gOmUDPGPxJwWp3uVHLbZpjVZvOEyDKHYIa
         VSEfHj58GaU4C0HQ4Kxsj0XmhJ/uFHCJUKTV08dopP2EJ/vvTFiFmk8JJvo6N+wIIb+Q
         8A6c7jBw20XQWvEcQQ/eWQykafXC5EOFXVkd/bDsWCXYeL67vrdRM9I9B4Plr7rYUfjt
         GV6rjvNf69kPo3WZLKq9itT1EqMtQPD6azmI9YFhX4dUoa+3X7gLK1d+G4NjSX1Uvx//
         TYWQ==
X-Gm-Message-State: AOJu0Yw0w8LLrAk4CfTRyy5SDM5dHee6WJ6xXJuME+h+nAiEj1xtTgxi
        2dPWRKnGDEF76F0m1EbsWPnFoaQtuZE=
X-Google-Smtp-Source: AGHT+IHmkM33E4jFA0/MUtJrzYod4Ks3z+LGFmRASfpJFYhl5YrBscD5jElQXrez+uXiBB14AafIAhwWLKc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:890a:0:b0:d9a:bce6:acf3 with SMTP id
 e10-20020a25890a000000b00d9abce6acf3mr520661ybl.0.1700173744305; Thu, 16 Nov
 2023 14:29:04 -0800 (PST)
Date:   Thu, 16 Nov 2023 14:29:02 -0800
In-Reply-To: <c9f65fc1-ab55-4959-a8ec-390aee51ee3a@intel.com>
Mime-Version: 1.0
References: <20231110235528.1561679-1-seanjc@google.com> <20231110235528.1561679-4-seanjc@google.com>
 <c9f65fc1-ab55-4959-a8ec-390aee51ee3a@intel.com>
Message-ID: <ZVaXroTZQi1IcTvm@google.com>
Subject: Re: [PATCH 3/9] KVM: x86: Initialize guest cpu_caps based on guest CPUID
From:   Sean Christopherson <seanjc@google.com>
To:     Weijiang Yang <weijiang.yang@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023, Weijiang Yang wrote:
> On 11/11/2023 7:55 AM, Sean Christopherson wrote:
>=20
> [...]
>=20
> > -static __always_inline void guest_cpu_cap_check_and_set(struct kvm_vcp=
u *vcpu,
> > -							unsigned int x86_feature)
> > +static __always_inline void guest_cpu_cap_clear(struct kvm_vcpu *vcpu,
> > +						unsigned int x86_feature)
> >   {
> > -	if (kvm_cpu_cap_has(x86_feature) && guest_cpuid_has(vcpu, x86_feature=
))
> > +	unsigned int x86_leaf =3D __feature_leaf(x86_feature);
> > +
> > +	reverse_cpuid_check(x86_leaf);
> > +	vcpu->arch.cpu_caps[x86_leaf] &=3D ~__feature_bit(x86_feature);
> > +}
> > +
> > +static __always_inline void guest_cpu_cap_change(struct kvm_vcpu *vcpu=
,
> > +						 unsigned int x86_feature,
> > +						 bool guest_has_cap)
> > +{
> > +	if (guest_has_cap)
> >   		guest_cpu_cap_set(vcpu, x86_feature);
> > +	else
> > +		guest_cpu_cap_clear(vcpu, x86_feature);
> > +}
>=20
> I don't see any necessity to add 3 functions, i.e., guest_cpu_cap_{set, c=
lear, change}, for

I want to have equivalents to the cpuid_entry_*() APIs so that we don't end=
 up
with two different sets of names.  And the clear() API already has a second=
 user.

> guest_cpu_cap update. IMHO one function is enough, e.g,:

Hrm, I open coded the OR/AND logic in cpuid_entry_change() to try to force =
CMOV
instead of Jcc.  That honestly seems like a pointless optimization.  I woul=
d
rather use the helpers, which is less code.

> static __always_inline void guest_cpu_cap_update(struct kvm_vcpu *vcpu,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned=
 int x86_feature,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool gue=
st_has_cap)
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int x86_leaf =3D __fe=
ature_leaf(x86_feature);
>=20
> reverse_cpuid_check(x86_leaf);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (guest_has_cap)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 vcpu->arch.cpu_caps[x86_leaf] |=3D __feature_bit(x86_fea=
ture);
> else
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 vcpu->arch.cpu_caps[x86_leaf] &=3D ~__feature_bit(x86_fe=
ature);
> }
>=20
> > +
> > +static __always_inline void guest_cpu_cap_restrict(struct kvm_vcpu *vc=
pu,
> > +						   unsigned int x86_feature)
> > +{
> > +	if (!kvm_cpu_cap_has(x86_feature))
> > +		guest_cpu_cap_clear(vcpu, x86_feature);
> >   }
>=20
> _restrict is not clear to me for what the function actually does -- it
> conditionally clears guest cap depending on KVM support of the feature.
>=20
> How about renaming it to guest_cpu_cap_sync()?

"sync" isn't correct because it's not synchronizing with KVM's capabilitiy,=
 e.g.
the guest capability will remaing unset if the guest CPUID bit is clear but=
 the
KVM capability is available.

How about constrain()?
