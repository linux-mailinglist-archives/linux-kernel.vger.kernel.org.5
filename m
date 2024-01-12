Return-Path: <linux-kernel+bounces-25048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E2B82C6C4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 22:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25645285BF4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 21:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466BE17731;
	Fri, 12 Jan 2024 21:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YRFLi26J"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55458175A8
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 21:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5e9de9795dfso136107947b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 13:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705095480; x=1705700280; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jG4xr+IJ1pGejJdBIle2Hs7xpC517ms091KPl27ARDY=;
        b=YRFLi26JdwwqfoGm4D2eO41OW0+mjXerEW19jAW4CpTGFIwsBfdEjaHT4BfpMuTD5P
         Gu1G/Rz7WgcpIoQMWJyK1q2m9NnnJYtgFmmxzvRbZ9X2LmI4geQ/8kEkXUUd6AvMXuTa
         JA1rHzzHeHzlp1jI1Pc4z59K0eqvWbEVvFDTjQtPe0M+pxac5hShbuubGDyBn/7o4b70
         LPiaBq0ZsBCu27gNaThnvV4wf7XhG1I/bPdMDnnrjCpf3fxF+fhMkVKD37RcT39VB4dV
         wHZ1fWLkhF1wr74GfpjWSkI3koRG0S+sUPYZ07Mgs4DuNLQ+stInmycopfc4ksNHliik
         EHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705095480; x=1705700280;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jG4xr+IJ1pGejJdBIle2Hs7xpC517ms091KPl27ARDY=;
        b=jNbsGA80ZUwudfTh5iLTLOCpWpsRJh0d2PJsYXbTN6QvWxujLlzfhr/RV8hAkHniJG
         soCsbYLTqmQCntkOFPNUZK5cQAItAnVivzGeMvEwrAwaPB/5jIidBc4ihpBS9kS803VM
         gmZCAsp9vYzNvbMqr5po6zOjdlqVLXfBxR7sqrRF4VaOJumXBXmoopkhnUAwJHyKsoE1
         Qc+2e31e7ayRwi/o2vtCiwGzvoYJpk5uQ+YsNNwNes8JENF5Z7NCtHYccbvRPntaDFlW
         EgcK0jE6pYsB158/dTpCMvcdDiDA7XU2EW6XTkd/WxNY7xEAkVRouArJV1UXbvJxrIc2
         gMiw==
X-Gm-Message-State: AOJu0YzVp2EOl9iVTx1PWgQsnKwXczE8xuBDU4W+/+YxBfc4FiIJbjFH
	FAKIQoMjUFBRgk1Am6/17evVVKp9bZOVrwQalg==
X-Google-Smtp-Source: AGHT+IFOESo1gDwkgyrwb3Dwmue/tz9mV7izQOOY5kMTv30+E6jaZ1ArRlEspUUtjJk+eua0cNedoHSx7/Q=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:220b:b0:dbd:b7cb:8a61 with SMTP id
 dm11-20020a056902220b00b00dbdb7cb8a61mr624141ybb.2.1705095480409; Fri, 12 Jan
 2024 13:38:00 -0800 (PST)
Date: Fri, 12 Jan 2024 13:37:58 -0800
In-Reply-To: <5f51fda5-bc07-42ac-a723-d09d90136961@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240109230250.424295-1-seanjc@google.com> <20240109230250.424295-17-seanjc@google.com>
 <5f51fda5-bc07-42ac-a723-d09d90136961@linux.intel.com>
Message-ID: <ZaGxNsrf_pUHkFiY@google.com>
Subject: Re: [PATCH v10 16/29] KVM: selftests: Test Intel PMU architectural
 events on gp counters
From: Sean Christopherson <seanjc@google.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kan Liang <kan.liang@linux.intel.com>, Jim Mattson <jmattson@google.com>, 
	Jinrong Liang <cloudliang@tencent.com>, Aaron Lewis <aaronlewis@google.com>, 
	Like Xu <likexu@tencent.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jan 12, 2024, Dapeng Mi wrote:
> 
> On 1/10/2024 7:02 AM, Sean Christopherson wrote:
> > +/*
> > + * If an architectural event is supported and guaranteed to generate at least
> > + * one "hit, assert that its count is non-zero.  If an event isn't supported or
> > + * the test can't guarantee the associated action will occur, then all bets are
> > + * off regarding the count, i.e. no checks can be done.
> > + *
> > + * Sanity check that in all cases, the event doesn't count when it's disabled,
> > + * and that KVM correctly emulates the write of an arbitrary value.
> > + */
> > +static void guest_assert_event_count(uint8_t idx,
> > +				     struct kvm_x86_pmu_feature event,
> > +				     uint32_t pmc, uint32_t pmc_msr)
> > +{
> > +	uint64_t count;
> > +
> > +	count = _rdpmc(pmc);
> > +	if (!this_pmu_has(event))
> > +		goto sanity_checks;
> > +
> > +	switch (idx) {
> > +	case INTEL_ARCH_INSTRUCTIONS_RETIRED_INDEX:
> > +		GUEST_ASSERT_EQ(count, NUM_INSNS_RETIRED);
> > +		break;
> > +	case INTEL_ARCH_BRANCHES_RETIRED_INDEX:
> > +		GUEST_ASSERT_EQ(count, NUM_BRANCHES);
> > +		break;
> > +	case INTEL_ARCH_CPU_CYCLES_INDEX:
> > +	case INTEL_ARCH_REFERENCE_CYCLES_INDEX:
> 
> Since we already support slots event in below guest_test_arch_event(), we
> can add check for INTEL_ARCH_TOPDOWN_SLOTS_INDEX here.

Can that actually be tested at this point, since KVM doesn't support
X86_PMU_FEATURE_TOPDOWN_SLOTS, i.e. this_pmu_has() above should always fail, no?

I'm hesitant to add an assertion of any king without the ability to actually test
the code.

