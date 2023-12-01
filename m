Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019B28016CB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 23:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjLAWmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 17:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjLAWmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 17:42:10 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F154BD6C
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 14:42:16 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5c6072bc218so918842a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 14:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701470536; x=1702075336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UHQP2r8tb6bd1CGRkfVIX9+3aPmO9CttmLCIdjw3P10=;
        b=oXFPY1V9yIUShtwAQloV+IPuUneHKxiy9SGPGsJ7R+bSsFUiJeHhxSTR93DkwuoC4L
         f3avR4iLVr6Y/MiuHqph7S3hrxlq6BWM4D8mSCelLcwWRhuWgXL0EFdGCRAqDjECjgk8
         fAtnM14UIwHprfqZLkigcG8HBxgyDE8rs71LP9ROMKbmUR9Mo4kYZEL5NmxxiZ1DksK8
         bMJVTBbXMJC1fYQSIJjHMvs5V9dIArG4/9Cg8L9Qsk0GWtW5/bPCMGzGoXvB4RqPQQvw
         /mttsPe3yvAzv5NQhQC9hZZkDZbe3T3QArLWRfoPibQrH6StLTQ6SAhmYCzSew9MW9tH
         AX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701470536; x=1702075336;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UHQP2r8tb6bd1CGRkfVIX9+3aPmO9CttmLCIdjw3P10=;
        b=lyfZAn29SIV0UCYqtUxU1ixTUot+Xfs0Pd1GIxlzPX7/3f+vu88lUyQ5PKTK+GNXEb
         wmJRZqoo+Bw0inyUW5F/nEITLDVTP1ndxNzYoQkVRO1qZw3JPC7rktl0BNQPZ6lcqw5W
         QFqbc2BV+tKiKpB/pH9LzGSqOzOIeCHtsuAK1oZDi7Up8nUgx8NupoZ+MOFfGzBXILzs
         mM4YdowCBfJKe7d9HYoBU/cVEMRBK/pw81W6S7/8MAkwxbaYYkCImONgI2YHVUfGv+3G
         gRjmswwOjqIWN/92Rh++DS5JSVrMZXAIYeWhjslboKEQREu5Wyiw7IGq+rJxgbtlyCAC
         kTPg==
X-Gm-Message-State: AOJu0Ywz1317nnnFYNYyKP3KAjXla/Rg1RnFVkzHgCmssEY3GtEhaatX
        uxmiFpfI09j/kBKNNFD3J4NtSI27ogI=
X-Google-Smtp-Source: AGHT+IGY74ILiZ6kFcffavA5ziXE30cM9e2LiHHM8NPEBAqCg9a+sjLS36fwaaqRxQYNYiTXazm5J96YBuA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:370c:b0:283:98d1:89ee with SMTP id
 mg12-20020a17090b370c00b0028398d189eemr90056pjb.0.1701470536374; Fri, 01 Dec
 2023 14:42:16 -0800 (PST)
Date:   Fri, 1 Dec 2023 14:42:14 -0800
In-Reply-To: <9718326e9b187b075de2df1059325aaa58cac900.camel@infradead.org>
Mime-Version: 1.0
References: <20231102162128.2353459-1-paul@xen.org> <ZWi6IKGFtQGpu6oR@google.com>
 <504ca757-c5b9-4d3b-900c-c5f401a02027@xen.org> <9718326e9b187b075de2df1059325aaa58cac900.camel@infradead.org>
Message-ID: <ZWphRnK_lwCyMSuN@google.com>
Subject: Re: [PATCH v5] KVM x86/xen: add an override for PVCLOCK_TSC_STABLE_BIT
From:   Sean Christopherson <seanjc@google.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     paul@xen.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>
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

On Thu, Nov 30, 2023, David Woodhouse wrote:
> On Thu, 2023-11-30 at 16:41 +0000, Paul Durrant wrote:
> > On 30/11/2023 16:36, Sean Christopherson wrote:
> > > +Andrew
> > >=20
> > > On Thu, Nov 02, 2023, Paul Durrant wrote:
> > > > From: Paul Durrant <pdurrant@amazon.com>
> > > >=20
> > > > Unless explicitly told to do so (by passing 'clocksource=3Dtsc' and
> > > > 'tsc=3Dstable:socket', and then jumping through some hoops concerni=
ng
> > > > potential CPU hotplug) Xen will never use TSC as its clocksource.
> > > > Hence, by default, a Xen guest will not see PVCLOCK_TSC_STABLE_BIT =
set
> > > > in either the primary or secondary pvclock memory areas. This has
> > > > led to bugs in some guest kernels which only become evident if
> > > > PVCLOCK_TSC_STABLE_BIT *is* set in the pvclocks. Hence, to support
> > > > such guests, give the VMM a new Xen HVM config flag to tell KVM to
> > > > forcibly clear the bit in the Xen pvclocks.
> > >=20
> > > ...
> > >=20
> > > > diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kv=
m/api.rst
> > > > index 7025b3751027..a9bdd25826d1 100644
> > > > --- a/Documentation/virt/kvm/api.rst
> > > > +++ b/Documentation/virt/kvm/api.rst
> > > > @@ -8374,6 +8374,7 @@ PVHVM guests. Valid flags are::
> > > > =C2=A0=C2=A0=C2=A0 #define KVM_XEN_HVM_CONFIG_EVTCHN_2LEVEL=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(1 << 4)
> > > > =C2=A0=C2=A0=C2=A0 #define KVM_XEN_HVM_CONFIG_EVTCHN_SEND=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
(1 << 5)
> > > > =C2=A0=C2=A0=C2=A0 #define KVM_XEN_HVM_CONFIG_RUNSTATE_UPDATE_FLAG=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(1 << 6)
> > > > +=C2=A0 #define KVM_XEN_HVM_CONFIG_PVCLOCK_TSC_UNSTABLE=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0(1 << 7)
> > >=20
> > > Does Xen actually support PVCLOCK_TSC_STABLE_BIT?=C2=A0 I.e. do we ne=
ed new uAPI to
> > > fix this, or can/should KVM simply _never_ set PVCLOCK_TSC_STABLE_BIT=
 for Xen
> > > clocks?=C2=A0 At a glance, PVCLOCK_TSC_STABLE_BIT looks like it was a=
dded as a purely
> > > Linux/KVM-only thing.
> >=20
> > It's certainly tested in arch/x86/xen/time.c, in=20
> > xen_setup_vsyscall_time_info() and xen_time_init(), so I'd guess it is=
=20
> > considered to be supported.
>=20
> And yes, Xen does set it, if you jump through the right hoops to make
> Xen actually use the TSC as its clocksource.
>=20
> The new uAPI is just a single bit in the KVM_XEN_HVM_CONFIG
> capabilities; I think it's reasonable enough.

Yeah, I was just hoping that maybe we could squeak by without it.  I'll get=
 this
queued up next week, purely because I try to avoid (but often fail) pushing=
 to
-next on Fridays.
