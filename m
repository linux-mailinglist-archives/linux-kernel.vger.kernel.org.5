Return-Path: <linux-kernel+bounces-7483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC93F81A8B9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7973428B844
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106EC49F7F;
	Wed, 20 Dec 2023 22:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RrVhP0DW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC2148780
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5e898eb4432so3434187b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 14:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703110022; x=1703714822; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=twaoVxa46Zq7Us3SlYz5ukbixjYRr3FrFNCXxXQIcEU=;
        b=RrVhP0DW3deaYUGUMfsfhYib3IMk/0Tp1D4BKju0dTOKNVMWr2AuI82+GaLX23TZ8d
         wIt97T7/d8h0qq+QPJOwGsUt8RCN045+FkH6ccIy5wuDiOU4FZkHClleSNsq6uwNJ/T4
         CmaNaeN9NHFADtpVV3gdnHsebmL3kT6/iV0AU08yGmUeR9An69wGw58UylfjhHLjQR69
         OuVnsUvWJhnGJBwfNDPdzVo8CV81KjvqK92C98Za1oNsfOiH3LQUkKi5alC1z/R0nRxi
         wBg/J7b1h84GSHIldhQn99d/ek6sBbtqhTsqNbQMmCHUrIOo6Q1tSsngYFUMEvdmxnUy
         YWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703110022; x=1703714822;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=twaoVxa46Zq7Us3SlYz5ukbixjYRr3FrFNCXxXQIcEU=;
        b=uJEBCa9jzNAPIJ6KOQ+pMaAa/oMpSepV4GY3wkbuD+YCxuAtkOnj5/j/WnQzmbHRiI
         k+ce6SpZNQZ+Om4MbmXx3umH3oVS4pPTg9gGJb/vxACwBBy2uHVIfO8eVxQjku+TVu10
         eKo7beJUbzijEqEThwrBbIn3XUd50ZYukQsjtBKRylrSkD8DI3U0mGnUz0G2EZF8TVOU
         ZY/5r082IkQJWzNWIHIsoSIX+8CPrYjYuulL3U3K6LLKxUo25dgtAgFY5sZggkkrtjvE
         Wzo1jlrW1DWB/yJPFyOrWZWTYo/Umlk0KP7A6WYOfE5BIQ6Uq1yVaxSI9JZla8rBB+gM
         H/8A==
X-Gm-Message-State: AOJu0YzH8sdK3Rs3UX3t8LQspx8hMlB2ggPcSX6zDbDo7rQgfGiOBX4m
	0jsTwoj9ACUL7iMdx/iMsnCvE5Gg4nY=
X-Google-Smtp-Source: AGHT+IGrRH+xCGlIICVf9RYSmyKktND+5ibjizfY6hM4NM8AzbBBfnWK6zAv5vm+0wYBoLUpxnTJXhBMkEU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:8750:0:b0:d9a:e3d9:99bd with SMTP id
 e16-20020a258750000000b00d9ae3d999bdmr16524ybn.5.1703110022170; Wed, 20 Dec
 2023 14:07:02 -0800 (PST)
Date: Wed, 20 Dec 2023 14:07:00 -0800
In-Reply-To: <20231219081104.GB2639779@ls.amr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1699936040.git.isaku.yamahata@intel.com>
 <1c12f378af7de16d7895f8badb18c3b1715e9271.1699936040.git.isaku.yamahata@intel.com>
 <938efd3cfcb25d828deab0cc0ba797177cc69602.camel@redhat.com>
 <ZXo54VNuIqbMsYv-@google.com> <aa7aa5ea5b112a0ec70c6276beb281e19c052f0e.camel@redhat.com>
 <ZXswR04H9Tl7xlyj@google.com> <20231219014045.GA2639779@ls.amr.corp.intel.com>
 <CALMp9eRgWct3bb5en0=geT0HmMemipkzXkjL9kmEAV+1yJg-pw@mail.gmail.com> <20231219081104.GB2639779@ls.amr.corp.intel.com>
Message-ID: <ZYNlhKCcOHgjTcFZ@google.com>
Subject: Re: [PATCH v2 1/3] KVM: x86: Make the hardcoded APIC bus frequency vm variable
From: Sean Christopherson <seanjc@google.com>
To: Isaku Yamahata <isaku.yamahata@linux.intel.com>
Cc: Jim Mattson <jmattson@google.com>, Maxim Levitsky <mlevitsk@redhat.com>, isaku.yamahata@intel.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, isaku.yamahata@gmail.com, 
	Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com, 
	Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Dec 19, 2023, Isaku Yamahata wrote:
> On Mon, Dec 18, 2023 at 07:53:45PM -0800, Jim Mattson <jmattson@google.com> wrote:
> > > There are several options to address this.
> > > 1. Make the KVM able to configure APIC bus frequency (This patch).
> > >    Pros: It resembles the existing hardware.  The recent Intel CPUs
> > >    adapts 25MHz.
> > >    Cons: Require the VMM to emulate the APIC timer at 25MHz.
> > > 2. Make the TDX architecture enumerate CPUID 0x15 to configurable
> > >    frequency or not enumerate it.
> > >    Pros: Any APIC bus frequency is allowed.
> > >    Cons: Deviation from the real hardware.

I don't buy this as a valid Con.  TDX is one gigantic deviation from real hardware,
and since TDX obviously can't guarantee the APIC timer is emulated at the correct
frequency, there can't possibly be any security benefits.  If this were truly a
Con that anyone cared about, we would have gotten patches to "fix" KVM a long time
ago.

If the TDX module wasn't effectively hardware-defined software, i.e. was actually
able to adapt at the speed of software, then fixing this in TDX would be a complete
no-brainer.

The KVM uAPI required to play nice is relatively minor, so I'm not totally opposed
to adding it.  But I totally agree with Jim that forcing KVM to change 13+ years
of behavior just because someone at Intel decided that 25MHz was a good number is
ridiculous.

> > > 3. Make the TDX guest kernel use 1GHz when it's running on KVM.
> > >    Cons: The kernel ignores CPUID leaf 0x15.
> > 
> > 4. Change CPUID.15H under TDX to report the crystal clock frequency as 1 GHz.
> > Pro: This has been the virtual APIC frequency for KVM guests for 13 years.
> > Pro: This requires changing only one hard-coded constant in TDX.
> > 
> > I see no compelling reason to complicate KVM with support for
> > configurable APIC frequencies, and I see no advantages to doing so.
> 
> Because TDX isn't specific to KVM, it should work with other VMM technologies.
> If we'd like to go for this route, the frequency would be configurable.  What
> frequency should be acceptable securely is obscure.  25MHz has long history with
> the real hardware.

