Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4AE7DD949
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 00:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbjJaXeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 19:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237505AbjJaW6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 18:58:54 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA74D10A
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 15:58:50 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a909b4e079so67949967b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 15:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698793130; x=1699397930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RLwCVeVI5oZii5Igm5sOUutwRdu695KSX9ADahcPJtY=;
        b=WFQynxQp05hnL8XhFBi04tOgCx9RA7LAFkrakJ3PFi3/AwIjeva4YGFEgByIOpI78Z
         fbYay+aozrIbb2KAczvvO0cnIpEBpKoeC5k59g96KYyqwN26HsYtszjACaY0d1Van4Qn
         h4tZlSQ76UApybTIGQ05hXrTMut+/WD/mzigRu/irUDfQjoGnlCW22BYRB1EEsogDlmb
         4wcVIXwVSYoh4RKNqtkZOYcp+zqz1qJRyiMOgaxoNgRBCq0bKyUbpp30whDtdu1wZn5Z
         sSWZEfNNN1Nmck3cJ6DGgFepKuwfYNPlYrB7yhN++eQmOzFT5KaBcNVYUGAv9YwCh7JY
         w2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698793130; x=1699397930;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RLwCVeVI5oZii5Igm5sOUutwRdu695KSX9ADahcPJtY=;
        b=e5LubFdAaslw5w61ohZx5PkyKDKR7fWH0IP1GraWqqWv7jnd+r9Ac1X1uYFARAsVF1
         69YNRQykd8xMJq9WXER+MrqqETreGhVYjz0YeGMUUMLO9I+SphMI6d5RlI60C6Ipr9t9
         h1FBsE571ZcG4/joPw2jYj8JGfUQDWtYf6HNjtoj4jlEnAGGyYxjirm1jTeM+QrvhhO7
         GKpgOPN4RH2wmGEStzQDGQBOr/Siqk/fRJDCg8H+/E2Tnyq+7uZgMA2+7r1K95xfl+qx
         Z9+RqE2haClUAey5jj4nEyBEm1GsiM52FUU6iqBKrk3VdkB0NRxD2nmvBOv/16m7oGkJ
         DoHQ==
X-Gm-Message-State: AOJu0Yy2pTY22QOldJ+v0mSBc3nVYMMFZhUhdAYc3/X6AVsWH00+cMfI
        st3RLTy/jhkUsF3C6Y0PzvtJTS8MHPQ=
X-Google-Smtp-Source: AGHT+IGY1W7FwMjtaRYDRWhynFOfQZS+XHB+5i2UhMrEl2n6QjMSYZJDwmzzrnHxUM5lbBdRFIG+tKXAowY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:df82:0:b0:57a:e0b:f63 with SMTP id
 i124-20020a0ddf82000000b0057a0e0b0f63mr291812ywe.7.1698793130060; Tue, 31 Oct
 2023 15:58:50 -0700 (PDT)
Date:   Tue, 31 Oct 2023 22:58:48 +0000
In-Reply-To: <028f629d16377f9a7e9fd87ef9564846b0ab4ed9.camel@infradead.org>
Mime-Version: 1.0
References: <20231031115748.622578-1-paul@xen.org> <ZUGCPQegUeTutsrb@google.com>
 <028f629d16377f9a7e9fd87ef9564846b0ab4ed9.camel@infradead.org>
Message-ID: <ZUGGqOCU7TAU6c6p@google.com>
Subject: Re: [PATCH v2] KVM x86/xen: add an override for PVCLOCK_TSC_STABLE_BIT
From:   Sean Christopherson <seanjc@google.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023, David Woodhouse wrote:
> On Tue, 2023-10-31 at 15:39 -0700, Sean Christopherson wrote:
> > On Tue, Oct 31, 2023, Paul Durrant wrote:
> > Any reason not to make this a generic "capability" instead of a Xen spe=
cific flag?
> > E.g. I assume these problematic guests would mishandle PVCLOCK_TSC_STAB=
LE_BIT if
> > it showed up in kvmclock, but they don't use kvmclock so it's not a pro=
blem in
> > practice.
>=20
> No, those guests are just fine with kvmclock. It's the *Xen* page they
> forgot to map to userspace for the vDSO to use. And it's Xen (true Xen)
> which made you jump through hoops to use the TSC that way, such that it
> would actually expose the PVCLOCK_TSC_STABLE_BIT. We don't expect, and
> have never seen, such issues with native KVM guests.

Hmm, and I suppose theoretically the guest kernel could choose to ignore th=
e Xen
interface for whatever reason.  Mostly out of curiosity, is this flag somet=
hing
that'd be set anytime Xen is advertised to the guest?

> > I doubt there's a real need or use case, but it'd require less churn an=
d IMO is
> > simpler overall, e.g.
> >=20
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index e3eb608b6692..731b201bfd5a 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -3225,7 +3225,7 @@ static int kvm_guest_time_update(struct kvm_vcpu =
*v)
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* If the host uses TSC cloc=
ksource, then it is stable */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pvclock_flags =3D 0;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (use_master_clock)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (use_master_clock && !vcpu->kv=
m.force_tsc_unstable)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 pvclock_flags |=3D PVCLOCK_TSC_STABLE_BIT;
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vcpu->hv_clock.flags =3D pvc=
lock_flags;
> >=20
> > I also assume this is a "set and forget" thing?=C2=A0 I.e. KVM can requ=
ire the flag
> > to be set before any vCPUs are created.
>=20
> Hrm, not sure we have previously required that the KVM_XEN_HVM_CONFIG
> setup be done before any vCPUs were created.

Oh, I was asking in the context of adding a generic capability.

> I tend to prefer *not* to push ordering requirements onto userspace.

For per-VM flags that are consumed by vCPUs, it makes reasoning about corre=
ctness
and what is/isn't allowed much, much easier.

> Does it need to be a per-vcpu thing?=20

Huh?  No, I was only asking (again, for a generic capability) if we could d=
o

		mutex_lock(&kvm->lock);
		if (!kvm->created_vcpus) {
			kvm->arch.force_tsc_unstable =3D true;
			r =3D 0;
		}
		mutex_unlock(&kvm->lock);

So that it would be blatantly obvious that there's no race with checking a =
per-VM
flag without any lock/RCU protections.
