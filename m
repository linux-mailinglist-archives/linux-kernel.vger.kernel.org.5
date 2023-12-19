Return-Path: <linux-kernel+bounces-4653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 793D681804C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106BF2862E8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CEFC12F;
	Tue, 19 Dec 2023 03:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D/4OGzgJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC24BE59
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 03:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5534180f0e9so5142a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 19:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702958041; x=1703562841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iy2IztVRXYniuUXW1tQyYprWZIpRHnU4kupTPbOUIiw=;
        b=D/4OGzgJRuH+EmHhahDvvXm14xPv9IC6beccImb1Y4tsPaaBu3+4RzhVMXcqQHW/U+
         AJSugPHkTOX9derzmCWhqaYpFw4OEf0/WuORGH+CTE/l7mrOzSABpzNy3JwfXE7++X9b
         r0c6ZnbMQOsqJ0ASWdZ9sHF0gRHDPbJPtRbrUfWst25Al+1tbCtE5BpdtCsk52vQ8/eW
         vUi/A0NPE33p5OJUYtFnNrlI0k/7LwNmEupWI7Eyi7e7XvpynqxxqSulQgZFqMl59jHc
         Mdn7eJO+sgzE2sBD2ri0p2yDuRafiOZKQbmjHLihfRWqnFO9OdBk+xr31EjlulP73wN/
         8Qxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702958041; x=1703562841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iy2IztVRXYniuUXW1tQyYprWZIpRHnU4kupTPbOUIiw=;
        b=DxIcNXgq3bAOFuZs/01VYc9PwmDsg6NL3DRruFJrxCPZRzlcg39cUYcmkZZwG88z1z
         X2kPT7bn4T8aojeAfM0uLNQOs4jXmUZ003k6HDNY9iNO7rt2NkTTWJxZF+c0c+Z0oWUR
         af0Dt14ZK5g5QPAH4NZ/pwCu6HsJb+SCxb8p9RjzHI9eS7EnxF5iyDsHrMdBP5IdZ6ig
         yY8IBh1MaOYvaRchPUbzZPk56nrVOghaxdfxvCzW472uMnNUKJ2UgsVLFWW3/i1ECCJE
         HKc4/umn/HdVcjfkvEPYAfXxoco+KA2tnM5ff0PtFyIrIjlqkbgpu5cqoroqgIOjpEYp
         V5qQ==
X-Gm-Message-State: AOJu0YyMgaddZAL38dDiy3jBvDwJaMk4OLSrFuYZ8prgvkPSwqEcw9sd
	Bmvs6H0nQm34V5C3goQuLY4zYrRvq2pW8tB4CVl4UvYPsQjs2Tz/G1Lg2ZFgoA==
X-Google-Smtp-Source: AGHT+IEEcf01KRStT8R0i4hzxGzlAiUGsWXmaILFfg25YRZNXMoDFFcG0M3wdkS8X8RotCCvWrJjEr2hrXUssL2tqKw=
X-Received: by 2002:a50:d613:0:b0:553:44c8:cfc9 with SMTP id
 x19-20020a50d613000000b0055344c8cfc9mr113134edi.0.1702958040896; Mon, 18 Dec
 2023 19:54:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1699936040.git.isaku.yamahata@intel.com>
 <1c12f378af7de16d7895f8badb18c3b1715e9271.1699936040.git.isaku.yamahata@intel.com>
 <938efd3cfcb25d828deab0cc0ba797177cc69602.camel@redhat.com>
 <ZXo54VNuIqbMsYv-@google.com> <aa7aa5ea5b112a0ec70c6276beb281e19c052f0e.camel@redhat.com>
 <ZXswR04H9Tl7xlyj@google.com> <20231219014045.GA2639779@ls.amr.corp.intel.com>
In-Reply-To: <20231219014045.GA2639779@ls.amr.corp.intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 18 Dec 2023 19:53:45 -0800
Message-ID: <CALMp9eRgWct3bb5en0=geT0HmMemipkzXkjL9kmEAV+1yJg-pw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] KVM: x86: Make the hardcoded APIC bus frequency vm variable
To: Isaku Yamahata <isaku.yamahata@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Maxim Levitsky <mlevitsk@redhat.com>, isaku.yamahata@intel.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, isaku.yamahata@gmail.com, 
	Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com, 
	Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 5:40=E2=80=AFPM Isaku Yamahata
<isaku.yamahata@linux.intel.com> wrote:
>
> On Thu, Dec 14, 2023 at 08:41:43AM -0800,
> Sean Christopherson <seanjc@google.com> wrote:
>
> > On Thu, Dec 14, 2023, Maxim Levitsky wrote:
> > > On Wed, 2023-12-13 at 15:10 -0800, Sean Christopherson wrote:
> > > > Upstream KVM's non-TDX behavior is fine, because KVM doesn't advert=
ise support
> > > > for CPUID 0x15, i.e. doesn't announce to host userspace that it's s=
afe to expose
> > > > CPUID 0x15 to the guest.  Because TDX makes exposing CPUID 0x15 man=
datory, KVM
> > > > needs to be taught to correctly emulate the guest's APIC bus freque=
ncy, a.k.a.
> > > > the TDX guest core crystal frequency of 25Mhz.
> > >
> > > I assume that TDX doesn't allow to change the CPUID 0x15 leaf.
> >
> > Correct.  I meant to call that out below, but left my sentence half-fin=
ished.  It
> > was supposed to say:
> >
> >   I halfheartedly floated the idea of "fixing" the TDX module/architect=
ure to either
> >   use 1Ghz as the base frequency or to allow configuring the base frequ=
ency
> >   advertised to the guest.
> >
> > > > I halfheartedly floated the idea of "fixing" the TDX module/archite=
cture to either
> > > > use 1Ghz as the base frequency (off list), but it definitely isn't =
a hill worth
> > > > dying on since the KVM changes are relatively simple.
> > > >
> > > > https://lore.kernel.org/all/ZSnIKQ4bUavAtBz6@google.com
> > > >
> > >
> > > Best regards,
> > >     Maxim Levitsky
>
> The followings are the updated version of the commit message.
>
>
> KVM: x86: Make the hardcoded APIC bus frequency VM variable
>
> The TDX architecture hard-codes the APIC bus frequency to 25MHz in the
> CPUID leaf 0x15.  The
> TDX mandates it to be exposed and doesn't allow the VMM to override
> its value.  The KVM APIC timer emulation hard-codes the frequency to
> 1GHz.  It doesn't unconditionally enumerate it to the guest unless the
> user space VMM sets the CPUID leaf 0x15 by KVM_SET_CPUID.
>
> If the CPUID leaf 0x15 is enumerated, the guest kernel uses it as the
> APIC bus frequency.  If not, the guest kernel measures the frequency
> based on other known timers like the ACPI timer or the legacy PIT.
> The TDX guest kernel gets timer interrupt more times by 1GHz / 25MHz.
>
> To ensure that the guest doesn't have a conflicting view of the APIC
> bus frequency, allow the userspace to tell KVM to use the same
> frequency that TDX mandates instead of the default 1Ghz.
>
> There are several options to address this.
> 1. Make the KVM able to configure APIC bus frequency (This patch).
>    Pros: It resembles the existing hardware.  The recent Intel CPUs
>    adapts 25MHz.
>    Cons: Require the VMM to emulate the APIC timer at 25MHz.
> 2. Make the TDX architecture enumerate CPUID 0x15 to configurable
>    frequency or not enumerate it.
>    Pros: Any APIC bus frequency is allowed.
>    Cons: Deviation from the real hardware.
> 3. Make the TDX guest kernel use 1GHz when it's running on KVM.
>    Cons: The kernel ignores CPUID leaf 0x15.

4. Change CPUID.15H under TDX to report the crystal clock frequency as 1 GH=
z.
Pro: This has been the virtual APIC frequency for KVM guests for 13 years.
Pro: This requires changing only one hard-coded constant in TDX.

I see no compelling reason to complicate KVM with support for
configurable APIC frequencies, and I see no advantages to doing so.

