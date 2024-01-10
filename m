Return-Path: <linux-kernel+bounces-22494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9198B829E91
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A46F1C22ADF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC5D4CDFB;
	Wed, 10 Jan 2024 16:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SWdmK6B1"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C13A4CDE9
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 16:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5f6f51cd7e8so58740817b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 08:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704903987; x=1705508787; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KFFHpaSTADtH/VEIQF/AhIPKZkXPJShFtYY++SD4R64=;
        b=SWdmK6B1IFOTm/tk1owjnCf51Y+5eBEJMU15aS5lYr7kuiJmJ4Wv5pYSyCZQ3ipiXy
         teQ1K9N2wLauvoRiaXGwXtrrreb6Bh3YtWGpz7vy8jQpDlZ03FXqmRv/RmLqFpSfjnIK
         9cQlhiAcn6YHEWw852toBlxRH7pJbd4/sSPKTgCArw1nneQKLZo0K33+M1ePIWLua6N0
         IxT6eaZ7fxhbYPmDAFBPm7U9EkJc3CT9lHCHFaUCTSSJG6pePjripc5csD1UDZ+cNoBl
         uucjTtC2SLM4TfEGWvvsR0pjAeDA23UThrTkrMfHTqu06QrSy5Uf7Ou3+X+Wma2okOlE
         cHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704903987; x=1705508787;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KFFHpaSTADtH/VEIQF/AhIPKZkXPJShFtYY++SD4R64=;
        b=xO0ybfJK7gbNWw4VFD3EzlZxsPXjhRMOoCskyoR1O/wVEmdJgdCbThhgooNNPFGwex
         HKLtv0UZeQgzBC/aD+z/P5/2GH9czHx4JAqRajGw8V4m7dVEi0RMKiKB1RAsIVRVUzf1
         ZSTH9Y3Nxj2U+hok3hdOV/5ivuFKkKuxm7RXCOMelGcfdW+91C831uYAE7OIUIpHMXwD
         1rUumgOOTQYC93rYleEIw4vmJcyfNRYCFilT7q6yBs15gtJgq/OLAmRTV+dJ8Ah7eRdd
         Tz/0ELmz5Nt/kKqkHAvWhQo39etGhu/0iqMuLJ9NWS3c+91qIwErEpBfJYubF29NpGZe
         hh2w==
X-Gm-Message-State: AOJu0Yw3x+JU1V/u6r3XXkpJmCgIGvgynBcEAN+kNxpWxvI3scM1fkEp
	UbfU3uoE6L26ISUOSNrMF6azz+xSzglXMmhKLA==
X-Google-Smtp-Source: AGHT+IFCDKSuIqtWoPLDFSC1Mk7wHwWTWUH+fHbn5EAgAxeA4wd/cQeF+PsSB2G0XPvVQ8inC6FLysEAoJU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:134a:b0:d9a:efcc:42af with SMTP id
 g10-20020a056902134a00b00d9aefcc42afmr48907ybu.2.1704903987151; Wed, 10 Jan
 2024 08:26:27 -0800 (PST)
Date: Wed, 10 Jan 2024 08:26:25 -0800
In-Reply-To: <ZZ42Vs3uAPwBmezn@chao-email>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240110002340.485595-1-seanjc@google.com> <ZZ42Vs3uAPwBmezn@chao-email>
Message-ID: <ZZ7FMWuTHOV-_Gn7@google.com>
Subject: Re: [PATCH] x86/cpu: Add a VMX flag to enumerate 5-level EPT support
 to userspace
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yi Lai <yi1.lai@intel.com>, 
	Tao Su <tao1.su@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jan 10, 2024, Chao Gao wrote:
> On Tue, Jan 09, 2024 at 04:23:40PM -0800, Sean Christopherson wrote:
> >Add a VMX flag in /proc/cpuinfo, ept_5level, so that userspace can query
> >whether or not the CPU supports 5-level EPT paging.  EPT capabilities are
> >enumerated via MSR, i.e. aren't accessible to userspace without help from
> >the kernel, and knowing whether or not 5-level EPT is supported is sadly
> >necessary for userspace to correctly configure KVM VMs.
> 
> This assumes procfs is enabled in Kconfig and userspace has permission to
> access /proc/cpuinfo. But it isn't always true. So, I think it is better to
> advertise max addressable GPA via KVM ioctls.

Hrm, so the help for PROC_FS says:

  Several programs depend on this, so everyone should say Y here.

Given that this is working around something that is borderline an erratum, I'm
inclined to say that userspace shouldn't simply assume the worst if /proc isn't
available.  Practically speaking, I don't think a "real" VM is likely to be
affected; AFAIK, there's no reason for QEMU or any other VMM to _need_ to expose
a memslot at GPA[51:48] unless the VM really has however much memory that is
(hundreds of terabytes?).  And a if someone is trying to run such a massive VM on
such a goofy CPU...

I don't think it's unreasonable for KVM selftests to require access to
/proc/cpuinfo.  Or actually, they can probably do the same thing and self-limit
to 48-bit addresses if /proc/cpuinfo isn't available.

I'm not totally opposed to adding a more programmatic way for userspace to query
5-level EPT support, it just seems unnecessary.  E.g. unlike CPUID, userspace
can't directly influence whether or not KVM uses 5-level EPT.  Even in hindsight,
I'm not entirely sure KVM should expose such a knob, as it raises questions around
interactions guest.MAXPHYADDR and memslots that I would rather avoid.

And even if we do add such uAPI, enumerating 5-level EPT in /proc/cpuinfo is
definitely worthwhile, the only thing that would need to be tweaked is the
justification in the changelog.

One thing we can do irrespective of feature enumeration is have kvm_mmu_page_fault()
exit to userspace with an explicit error if the guest faults ona GPA that KVM
knows it can't map, i.e. exit with KVM_EXIT_INTERNAL_ERROR or maybe even
KVM_EXIT_MEMORY_FAULT instead of looping indefinitely.

