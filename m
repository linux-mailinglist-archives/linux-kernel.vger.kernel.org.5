Return-Path: <linux-kernel+bounces-150760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2479B8AA438
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A45FD1F22C19
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DEC190699;
	Thu, 18 Apr 2024 20:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JdH5bB/L"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A5F5427E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 20:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713473167; cv=none; b=IiHaiDi73WhgjEMMrVXYndsFWfmwbtk1fwGkfB2ADL9wnZXU1FGfh+8rFZSU3EyFGMTqY9mHxdl/NAN1RGzZVX7TuqLAVK6zKO9N6N0IQgzKcee7e/tQGahIVER/at6KfaTB/cNN/OTzmlvlG4xOhdo59bmJm5hxeKtXeoKNF14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713473167; c=relaxed/simple;
	bh=HMVi7br3BVBav1YEFm3hGbVBKQuo4jcCj8gERVq5mRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7DYxj6vZNpbuAqoqFl5fhQz3a80RP6ut90F27ZFYjzPZ+R8HICnyNi9vRV+XuBh2TTB8GFO0UfvGb41a4kUVLxmOyAgMSJvHHMWX6NyRelP6AVPtUYd3pcjrYhGWU+BdLhEvffW/S5VbteaegR/2tndn1T4AZyq5qvPlUSq0x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JdH5bB/L; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2a2da57ab3aso1041059a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 13:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713473165; x=1714077965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NAMRKO5ZJMAgar9h9RnJOh/Wa8p7zabMhMg01dIRGOg=;
        b=JdH5bB/LtWsQ8gpygCvhWh+bg2ci8KwLNDdR08ZBJmHIRs2pseOZh1D+tG57AJUvzX
         dPJbsDO4P4m0lHrHZMefPaLcFJulBSeM+VIqQPAulLFiEwylLqX+6K6ksoOclnAT/iOs
         nGpPYsw6vKJ9IEwflZF+FlhJpCX1hxxib8hKDBOV3NvAY+hNHKFa9hib+xbaRpNNDSes
         fXQvNZY3+W4Y4S84EcKPcwLDJnC0PYuSEtDkyqRgKVIrrVSyzMK9wU6whMsvcmsnhtJl
         57JWx2Onw6HxGFv8PxcIp8tWSvQxgsFlZiHuqwPT5aYG7QlakmHxKj15Ob6gYiPUbjG1
         62tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713473165; x=1714077965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAMRKO5ZJMAgar9h9RnJOh/Wa8p7zabMhMg01dIRGOg=;
        b=C694yc8bxfgf8LDXyptmRkj9FoD9cKW9Xe58GNd21GtFFCl/Bioyf8YG01y4xoESte
         bChVcKd8beHbaWmX8Sq44TinF115Hxln56Z7Bc2rpWkDKSkkmajOiz6e5ayRFbZ2FBMm
         0WQdbXV3py/u4R1vGZXUryRj0zV2O+HNyFkVm7myqXqYYm4obfbUYp5up4IFYV1Ziuav
         UZRBOPG5QR1BVKEUmIJ7XGWbHMAscbnZUhO/fuWx2//LhOlv/+gbUNb4d+Rl8f+qIhB1
         Mnvtt9OLYtQ3qqNYLEktpLyP3sR9h6D4tR1ywy3URQ0lE3L8Q4skw0+Lv/qwQrOJXm2d
         g9hg==
X-Forwarded-Encrypted: i=1; AJvYcCUiAxU3taqvNzwABH05qzb4z+/vvDX2WYCyT7VBKTUt8KUiLo9VnN/rhyDHIIGDbISQ/4dQCZRxcBZ7H4bn2SbVTZHT0qf2Yupht1TH
X-Gm-Message-State: AOJu0YzfQFZhvgCXlryoij7mBED9evw/z0RUHjVuj8ip+DMHBYw/U2ly
	2/TIavudt0eI5kIbmGNMlolSjsLGVV+15wX9RpYyU38NlSIWVI8FCkveJ1aO/Q==
X-Google-Smtp-Source: AGHT+IE6CmWwjk53jvURZMn2e6RsrDhXbrmpgr8uKqK7f4ECwf5qlnvF3BLnuP+6gnpYzXORmkclsw==
X-Received: by 2002:a17:90b:3696:b0:2a5:3438:a31b with SMTP id mj22-20020a17090b369600b002a53438a31bmr284502pjb.37.1713473164448;
        Thu, 18 Apr 2024 13:46:04 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id iq2-20020a17090afb4200b002a9f707ec45sm3611970pjb.11.2024.04.18.13.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 13:46:03 -0700 (PDT)
Date: Thu, 18 Apr 2024 20:46:00 +0000
From: Mingwei Zhang <mizhang@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Xiong Zhang <xiong.y.zhang@linux.intel.com>, pbonzini@redhat.com,
	peterz@infradead.org, kan.liang@intel.com, zhenyuw@linux.intel.com,
	dapeng1.mi@linux.intel.com, jmattson@google.com,
	kvm@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, zhiyuan.lv@intel.com,
	eranian@google.com, irogers@google.com, samantha.alt@intel.com,
	like.xu.linux@gmail.com, chao.gao@intel.com
Subject: Re: [RFC PATCH 00/41] KVM: x86/pmu: Introduce passthrough vPM
Message-ID: <ZiGGiOspm6N-vIta@google.com>
References: <20240126085444.324918-1-xiong.y.zhang@linux.intel.com>
 <ZhgX6BStTh05OfEd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhgX6BStTh05OfEd@google.com>

On Thu, Apr 11, 2024, Sean Christopherson wrote:
> <bikeshed>
> 
> I think we should call this a mediated PMU, not a passthrough PMU.  KVM still
> emulates the control plane (controls and event selectors), while the data is
> fully passed through (counters).
> 
> </bikeshed>
Sean,

I feel "mediated PMU" seems to be a little bit off the ..., no? In
KVM, almost all of features are mediated. In our specific case, the
legacy PMU is mediated by KVM and perf subsystem on the host. In new
design, it is mediated by KVM only.

We intercept the control plan in current design, but the only thing
we do is the event filtering. No fancy code change to emulate the control
registers. So, it is still a passthrough logic.

In some (rare) business cases, I think maybe we could fully passthrough
the control plan as well. For instance, sole-tenant machine, or
full-machine VM + full offload. In case if there is a cpu errata, KVM
can force vmexit and dynamically intercept the selectors on all vcpus
with filters checked. It is not supported in current RFC, but maybe
doable in later versions.

With the above, I wonder if we can still use passthrough PMU for
simplicity? But no strong opinion if you really want to keep this name.
I would have to take some time to convince myself.

Thanks.
-Mingwei
> 
> On Fri, Jan 26, 2024, Xiong Zhang wrote:
> 
> > 1. host system wide / QEMU events handling during VM running
> >    At VM-entry, all the host perf events which use host x86 PMU will be
> >    stopped. These events with attr.exclude_guest = 1 will be stopped here
> >    and re-started after vm-exit. These events without attr.exclude_guest=1
> >    will be in error state, and they cannot recovery into active state even
> >    if the guest stops running. This impacts host perf a lot and request
> >    host system wide perf events have attr.exclude_guest=1.
> > 
> >    This requests QEMU Process's perf event with attr.exclude_guest=1 also.
> > 
> >    During VM running, perf event creation for system wide and QEMU
> >    process without attr.exclude_guest=1 fail with -EBUSY. 
> > 
> > 2. NMI watchdog
> >    the perf event for NMI watchdog is a system wide cpu pinned event, it
> >    will be stopped also during vm running, but it doesn't have
> >    attr.exclude_guest=1, we add it in this RFC. But this still means NMI
> >    watchdog loses function during VM running.
> > 
> >    Two candidates exist for replacing perf event of NMI watchdog:
> >    a. Buddy hardlock detector[3] may be not reliable to replace perf event.
> >    b. HPET-based hardlock detector [4] isn't in the upstream kernel.
> 
> I think the simplest solution is to allow mediated PMU usage if and only if
> the NMI watchdog is disabled.  Then whether or not the host replaces the NMI
> watchdog with something else becomes an orthogonal discussion, i.e. not KVM's
> problem to solve.
> 
> > 3. Dedicated kvm_pmi_vector
> >    In emulated vPMU, host PMI handler notify KVM to inject a virtual
> >    PMI into guest when physical PMI belongs to guest counter. If the
> >    same mechanism is used in passthrough vPMU and PMI skid exists
> >    which cause physical PMI belonging to guest happens after VM-exit,
> >    then the host PMI handler couldn't identify this PMI belongs to
> >    host or guest.
> >    So this RFC uses a dedicated kvm_pmi_vector, PMI belonging to guest
> >    has this vector only. The PMI belonging to host still has an NMI
> >    vector.
> > 
> >    Without considering PMI skid especially for AMD, the host NMI vector
> >    could be used for guest PMI also, this method is simpler and doesn't
> 
> I don't see how multiplexing NMIs between guest and host is simpler.  At best,
> the complexity is a wash, just in different locations, and I highly doubt it's
> a wash.  AFAIK, there is no way to precisely know that an NMI came in via the
> LVTPC.
> 
> E.g. if an IPI NMI arrives before the host's PMU is loaded, confusion may ensue.
> SVM has the luxury of running with GIF=0, but that simply isn't an option on VMX.
> 
> >    need x86 subsystem to reserve the dedicated kvm_pmi_vector, and we
> >    didn't meet the skid PMI issue on modern Intel processors.
> > 
> > 4. per-VM passthrough mode configuration
> >    Current RFC uses a KVM module enable_passthrough_pmu RO parameter,
> >    it decides vPMU is passthrough mode or emulated mode at kvm module
> >    load time.
> >    Do we need the capability of per-VM passthrough mode configuration?
> >    So an admin can launch some non-passthrough VM and profile these
> >    non-passthrough VMs in host, but admin still cannot profile all
> >    the VMs once passthrough VM existence. This means passthrough vPMU
> >    and emulated vPMU mix on one platform, it has challenges to implement.
> >    As the commit message in commit 0011, the main challenge is 
> >    passthrough vPMU and emulated vPMU have different vPMU features, this
> >    ends up with two different values for kvm_cap.supported_perf_cap, which
> >    is initialized at module load time. To support it, more refactor is
> >    needed.
> 
> I have no objection to an all-or-nothing setup.  I'd honestly love to rip out the
> existing vPMU support entirely, but that's probably not be realistic, at least not
> in the near future.
> 
> > Remain Works
> > ===
> > 1. To reduce passthrough vPMU overhead, optimize the PMU context switch.
> 
> Before this gets out of its "RFC" phase, I would at least like line of sight to
> a more optimized switch.  I 100% agree that starting with a conservative
> implementation is the way to go, and the kernel absolutely needs to be able to
> profile KVM itself (and everything KVM calls into), i.e. _always_ keeping the
> guest PMU loaded for the entirety of KVM_RUN isn't a viable option.
> 
> But I also don't want to get into a situation where can't figure out a clean,
> robust way to do the optimized context switch without needing (another) massive
> rewrite.

