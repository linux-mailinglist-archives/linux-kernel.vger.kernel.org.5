Return-Path: <linux-kernel+bounces-100343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 313748795F2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFBB72827E5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19507B3EE;
	Tue, 12 Mar 2024 14:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H0zhra1t"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810DD7AE51
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710253210; cv=none; b=KXQnL6SlLGQ8dMm0obWO+FeHmN/MYe2KNdyyM3Sfnvr1Id5NuBX8OBOrZSsI2j7H6S03TJ2NGs1W624yNACRNxSEFj9yrf2eV/8TX9E7cfVWKbR2ho1uAr6IwRdukuoXTCsqBWS+VxLbzabbtmA6efS4DA1wikjZNm+vi9CoKMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710253210; c=relaxed/simple;
	bh=Cyv31l3V93wJczzZuVe6h3HTL/aj20Zlxrvzm4Sh8lE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X9y0/hEb2hlzoIesUlQqXLaQIvmRCROKj5z+PsMHGyGEageoCAYKatMQT927ix0e/YPOAK0q+FZCj0+txA1A93DVY11vBklVaLG0q5hRY73jy54lDsGQ76oP7+SGXh7GsEL3HfcYVQp+O1+ld47AVl+NGUWPaqZ6Q3oOgsMp05Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H0zhra1t; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc657e9bdc4so1214890276.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 07:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710253207; x=1710858007; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Jjb/PAOgGaN7lAsVIUO9NyizSvHp4sC3GUTaZ0PNJs=;
        b=H0zhra1tbF2BHsVDBkI/e5ByzJ1FKwfcZbWw1ikPhXbAFRTByAcXlwfuKBTUfpKuGg
         CByuuIJnmYSODXsQSDj/P/i9r+sVyopD8lUmj1ePR5mDX5eIpY/ZB2mKnp55rjFf0wjk
         oVZPp+PviACFX0D75LmUIcGshgNM5+TcJcGTgUNI5mOmsu5h4/kJVMIr1yywq2GXdJRF
         E9yMg6dSYc+i1Qv9To6d+ZRoVT0EIHa57RdXGeJIaBAoBGQFHlWnr361WFwXF3E3DAo7
         TdHkMpx4rh55d9XxCwwWnzmnNnZfmIOLZR4pqy55TIzMJAsOONvd0+7aPxTnartrDA+c
         GLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710253207; x=1710858007;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Jjb/PAOgGaN7lAsVIUO9NyizSvHp4sC3GUTaZ0PNJs=;
        b=WfsO+Zv4AwBS2Q5FGNhmx6NxRBrW/U89pA7UuZbPSiDMZ2JvOVZPsi/xRuJRsibf9W
         qJ6nG35hw5gHymTUre4qoaEpi456Rk85kND+UWPUAwrP9xchdcAanCr0G9LSeFe5vXNT
         7H+Auj7vzjcaUVNzJuAGCunCoJWX9U3QfFsc6F506U47IkwDPIyI1br8MwVdlnN4Jmce
         vTMoKsspE3mKn4S6dQkjPAaly1SakoMsE0eBRvKgk1EluB986pwQGyvxqsxCMGki1udx
         FYMSHFhOYVmg3kOpTcJzHYh5BrjqvPQjMKSnjHkWam7DoFkePT5yn2zKQJsBcr4CrbGC
         VQ6Q==
X-Forwarded-Encrypted: i=1; AJvYcCW5vnWR3xjQ8N4nrTHrDQmQc2gYjUX8Uqrjvs1myQEXjrrk88zvfJC5+5u1N+h5NPJViWq4iKjkP1yh5KSRHjQNep8UUd51hjD25XPF
X-Gm-Message-State: AOJu0YxOvt5ANzVXO4ENuC9AzbjQE6ZlG6+Sx0wv8PufqTWoC5UtESOS
	UVFAVEJg8UI6lvGM8yaO6ZpYOVAV6Klx9ffvazA9/R8ukiCNR/y6uxfxOeYIXzKLIrcc7s5MjXt
	22g==
X-Google-Smtp-Source: AGHT+IF2G7mI6BP+EmptPVIitfTTiB7haHK5wPTRnTR7LM1v/cn/RH1kQsYUCQo17zt2GU1GfGk8M1szpTU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:be49:0:b0:dc6:44d4:bee0 with SMTP id
 d9-20020a25be49000000b00dc644d4bee0mr512108ybm.7.1710253207502; Tue, 12 Mar
 2024 07:20:07 -0700 (PDT)
Date: Tue, 12 Mar 2024 07:20:05 -0700
In-Reply-To: <6b38d1ea3073cdda0f106313d9f0e032345b8b75.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1709288671.git.isaku.yamahata@intel.com>
 <66a957f4ec4a8591d2ff2550686e361ec648b308.1709288671.git.isaku.yamahata@intel.com>
 <Ze-TJh0BBOWm9spT@google.com> <6b38d1ea3073cdda0f106313d9f0e032345b8b75.camel@intel.com>
Message-ID: <ZfBkle1eZFfjPI8l@google.com>
Subject: Re: [RFC PATCH 6/8] KVM: x86: Implement kvm_arch_{, pre_}vcpu_map_memory()
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: Isaku Yamahata <isaku.yamahata@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"federico.parola@polito.it" <federico.parola@polito.it>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>, "michael.roth@amd.com" <michael.roth@amd.com>, 
	"dmatlack@google.com" <dmatlack@google.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 12, 2024, Kai Huang wrote:
> > Wait. KVM doesn't *need* to do PAGE.ADD from deep in the MMU.  The only inputs to
> > PAGE.ADD are the gfn, pfn, tdr (vm), and source.  The S-EPT structures need to be
> > pre-built, but when they are built is irrelevant, so long as they are in place
> > before PAGE.ADD.
> > 
> > Crazy idea.  For TDX S-EPT, what if KVM_MAP_MEMORY does all of the SEPT.ADD stuff,
> > which doesn't affect the measurement, and even fills in KVM's copy of the leaf EPTE, 
> > but tdx_sept_set_private_spte() doesn't do anything if the TD isn't finalized?
> > 
> > Then KVM provides a dedicated TDX ioctl(), i.e. what is/was KVM_TDX_INIT_MEM_REGION,
> > to do PAGE.ADD.  KVM_TDX_INIT_MEM_REGION wouldn't need to map anything, it would
> > simply need to verify that the pfn from guest_memfd() is the same as what's in
> > the TDP MMU.
> 
> One small question:
> 
> What if the memory region passed to KVM_TDX_INIT_MEM_REGION hasn't been pre-
> populated?  If we want to make KVM_TDX_INIT_MEM_REGION work with these regions,
> then we still need to do the real map.  Or we can make KVM_TDX_INIT_MEM_REGION
> return error when it finds the region hasn't been pre-populated?

Return an error.  I don't love the idea of bleeding so many TDX details into
userspace, but I'm pretty sure that ship sailed a long, long time ago.

