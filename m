Return-Path: <linux-kernel+bounces-164340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 554FB8B7C8A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 084DE2846AB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E881A178CDE;
	Tue, 30 Apr 2024 16:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xmu4FeYh"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B05171E67
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714493612; cv=none; b=ICayA47OgyPMWDg6MRrmYNmkNQLZg4QT1qw8xBCLtHu/7QcsiyXttjKODMBiEb6bKNcy2qh4FTVBqGHMAxFqlfvjF/m9YHVhnjcAH/37hMh0vxn4tU504ZQ+qRlXa5SJUXYD4s8mJnHhuyFj9OajgoC4qiDSjke5PiD9+s22eHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714493612; c=relaxed/simple;
	bh=nIL/KvEMp4/IgWtjMvnl4C+DlegfqosHdr/T/x6z7ks=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VUXc0bDnak2n0djF9ot2FM2WbI1+VTPBK7wzU5U2H4ELGcGOTTtY5Od74AHJAIZ0HLN4yPHp4y1SHCyBQtNFqefKnxiuuOnjimXKBH9ZJ22D8Pd3FAHWthAMmEkYuED2rQwJEQdFHE3/Z7t9hnfaslkf4348xycxk2NTxTDVilc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xmu4FeYh; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61bea0c36bbso19197177b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714493610; x=1715098410; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oC4A/0bhs1W5SnhQoh5JNIURRDBxbc8YV5BTwNgFvY8=;
        b=Xmu4FeYhRxuudM7BEN/qFQSlIv/F5+ccs0tmmPu8r1zNFkK1aTbMJD+9VTmh2BPsYv
         Xy1F0KOqCiN3EhR3ZrHFy5f+wUu0fCHVbV3B0+gcMsHee7gQz7XeJxYiuvcD0qAxpA1A
         ZanS2H24MbGqaws/Le5l/Bbe4YCGz7e7v/m3pcKf2dAmzhnIOioztAc6eDMZwMIq1BTg
         iQkg6oUWtx8GQS1WHk7rebTcIk3dlOVl11j85jR6FSrvdAuvRA8EF3zCw/tf2YVYVrL/
         aPYyAkvK4Ndk7N01tk+qT789QU/HjHFRXKIggmJERHEorGtoG1y1jrAIwV1b/Q7ncuwC
         2UbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714493610; x=1715098410;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oC4A/0bhs1W5SnhQoh5JNIURRDBxbc8YV5BTwNgFvY8=;
        b=fyCw1/bLxjVbU4FCqAHRYIQ9cgORsaOj2augFL/hwz83fFTTpJupJzBcKVrz3bCnr3
         pt3K0eCtMn4a+1M32aeWeuCeXLZ8MhB2YKl4DhXta7+3m9kwr+YIZNdHgo76+LLwFOKf
         FhOI0DMpHxc5gQq4l654fOPYFUfdjkSiYm3Nqjlmwx32kys3qz21pyzwCVz0uYidS3qa
         YYH1KEnQFVcKTcOQWMm1MdkCOJrH8gebBtokVeyQSIwdlbjezN3qSwHWdPgs1vcBsZwI
         +YJ4tQy6nXmKqAhyteTSEwHVT9xNz3khdPWlhEHbdL1J7FD6w6qVNhOxHS146Bg9xdPG
         XWlA==
X-Forwarded-Encrypted: i=1; AJvYcCWERPcU6C4ph3jmNdGs8a02J2NR9CbWMlqfXZRpyiZ7iXTHLA0jx2gmgnwtCzATbGwsqfx+u0qPATQ/hQGa10YggooFFGwAJunc1xZ/
X-Gm-Message-State: AOJu0YyG1ZAI8+Hsj//YE4PYrCu1gk9vYslLztlBnTk9ggVNf2xD0vQa
	6SDFjRI8spIu2hP+1ZgWM9MIYzOv5Rpq0MqgnzrCTVlFIvw0iTJP6w9VrEVv73ZcHhiLKSE65pW
	iQQ==
X-Google-Smtp-Source: AGHT+IHPJXOWZicEl8cUsM9FpBFXJDiuKq8bODRIST42pHLkLGvawHCwZduQ2FiFTnquT9vHhjskKOj8wYc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:83c9:0:b0:61b:ec81:3f3b with SMTP id
 t192-20020a8183c9000000b0061bec813f3bmr780ywf.5.1714493609737; Tue, 30 Apr
 2024 09:13:29 -0700 (PDT)
Date: Tue, 30 Apr 2024 09:13:28 -0700
In-Reply-To: <2eab6265-3478-45db-86a5-722de6f39e74@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <d0563f077a7f86f90e72183cf3406337423f41fe.camel@intel.com>
 <ZifQiCBPVeld-p8Y@google.com> <61ec08765f0cd79f2d5ea1e2acf285ea9470b239.camel@intel.com>
 <9c6119dacac30750defb2b799f1a192c516ac79c.camel@intel.com>
 <ZiqFQ1OSFM4OER3g@google.com> <b605722ac1ffb0ffdc1d3a4702d4e987a5639399.camel@intel.com>
 <Zircphag9i1h-aAK@google.com> <b2bfc0d157929b098dde09b32c9a3af18835ec57.camel@intel.com>
 <Zi_93AF1qRapsUOq@google.com> <2eab6265-3478-45db-86a5-722de6f39e74@intel.com>
Message-ID: <ZjEYqCgtt4ZgVKth@google.com>
Subject: Re: [PATCH v19 023/130] KVM: TDX: Initialize the TDX module when
 loading the KVM intel kernel module
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: Tina Zhang <tina.zhang@intel.com>, Hang Yuan <hang.yuan@intel.com>, 
	Bo2 Chen <chen.bo@intel.com>, "sagis@google.com" <sagis@google.com>, 
	"isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Erdem Aktas <erdemaktas@google.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, 
	"isaku.yamahata@linux.intel.com" <isaku.yamahata@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 30, 2024, Kai Huang wrote:
> On 30/04/2024 8:06 am, Sean Christopherson wrote:
> > My suggestion is essentially "throw in a CR4.VMXE check before
> > TDH.SYS.LP.INIT if it's easy".  If it's not easy for some reason, then don't do
> > it.
> 
> I see.  The disconnection between us is I am not super clear why we should
> treat TDH.SYS.LP.INIT as a special one that deserves a CR4.VMXE check but
> not other SEAMCALLs.

Because TDH.SYS.LP.INIT is done on all CPUs via an IPI function call, is a one-
time thing, and is at the intersection of core TDX and KVM module code, e.g. the
the core TDX code has an explicit assumption that:

 * This function assumes the caller has: 1) held read lock of CPU hotplug
 * lock to prevent any new cpu from becoming online; 2) done both VMXON
 * and tdx_cpu_enable() on all online cpus.

KVM can obviously screw up and attempt SEAMCALLs without being post-VMXON, but
that's entirely a _KVM_ bug.  And the probability of getting all the way to
something like TDH_MEM_SEPT_ADD without being post-VMXON is comically low, e.g.
KVM and/or the kernel would likely crash long before that point. 

