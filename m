Return-Path: <linux-kernel+bounces-101707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CA487AAD4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E5771F22899
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2E548781;
	Wed, 13 Mar 2024 16:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dzfspTi9"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DE1481BA
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 16:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710345616; cv=none; b=NjKuZNz33RM67D8P0GuNzJFXU2eoe+KbkHc6vr2YkaXBFLjXDMCQovE/B2GOKes1nPbVJNbHfcqYWgU7LW8j73mrYXzQ7lX1MRSKemJxIGDmfKjUSLua7F1zYtXHcJw9yFO1q1nwJTMaJlFuqZaaPOdC2r/wkTeW2b0buwmeKtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710345616; c=relaxed/simple;
	bh=yHXtaDtNvztZB6cDPOuC8+5o2hFx6wTETY3sSzeZDMg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RaWS/XElbVX52uxVdBfTg2vVX4g5MN1d14YxsnwSdXeCCCQuKDDm9qboJm9To7V2H8I4FPSHarJGj6XCAh+/u4/Lj7UiAq0IRqAu/2ZI4ziE5mROMMw2xGzTS9fVMebEKRiOaGXRNPMb7vXHybINPve2tXsQQcqGKF82WIIMqqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dzfspTi9; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a20c33f06so18922837b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 09:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710345613; x=1710950413; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UTq/Gh3fb1Jc7qkNObzjz7+0X1KEbNuRRHpZgPcsL2A=;
        b=dzfspTi9J6rzhowghpUwmuGLuxmeFd5PfeYmIIvvEpsGGp/eFtTrlAiZJ7f/iRsn35
         nqyJ24X6KuwFLhO+l9Snu0GTB0RoMa/fHM2n/codvGHgYWHScB4pYLytEgBKE9Za9ZZU
         LNGoPVMIjptLnP1XV/5yCNeoYZ7y943nVuZWz8LXOHbdyMo1EJr4701B8SALvnrXJSew
         TSv4FetT/0Tfe4KdB1tfhDjO781axXeIUiUbX3R7j/E8Abxu+syEnjrejQ49Svx46f50
         zK9X6sw3RDK1U7u5a1WQMWfSjCirEtr/RuUyClvAzMNcahD/ph12i3za2J6Fk3KC20Fd
         ZmHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710345613; x=1710950413;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UTq/Gh3fb1Jc7qkNObzjz7+0X1KEbNuRRHpZgPcsL2A=;
        b=Z9Cybhs6yCQuk2gjlbfYQIQa4eSWEmIlwoR55b1+bhrVPfbgjaykVO6yZ8JfcRfAiw
         ILnbTXLazh2zXMENXC1aju2ehZyiRcYbC8fQrShVUOFW1T6odz3TOf474VxJ78KLmWRy
         RWWbeS4RT2MXTX3DHQN81V9Wb2snd2ml2zVT5PHvyO2HL6Xo0Z7qxJikNopulwbZy2mT
         gJ9PKnR4haD1a6eQ1BMqkiVv6Rz1DYn4iSW00GBC2xPzebj9ntFXSNuTxfM0+Bu8ARft
         YtHpbTEghlGEUAc0ZD72WouATHBaJmWifEUekE7TyWrI3fMKvubl7gaX0c5PJ0dRWLJJ
         Ahcg==
X-Forwarded-Encrypted: i=1; AJvYcCVTtHYKT+IIHARNF38WtmUzDcyXgV1F9r0WBR5mF8rQrBQyvaxCwVhlsM3GjYmxGHxbqIOXaSiZhgROgXJbqfZm5sIoAoqsAi3Hy3cb
X-Gm-Message-State: AOJu0Yw/BN6STKrLTLwGYzV06tWLTMPBA0MOKRZ0OYDDtjbjlPIbcSwF
	MmeC+EWfOIPoDRXyYq7lG/2HTjyJpD4GGVuHSxYEkDj2EAHbVFjg6OMI9V6tdjKQKqFBCbnSgL7
	EKw==
X-Google-Smtp-Source: AGHT+IEoGNlbig6XYJAvCcWrepmCLlus1yjvBLESmgOc8ZxJz1T8zJHZBME/5qcbcxjsISVE/uzaEqyDf4A=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:a02:b0:609:ecbd:27dd with SMTP id
 cg2-20020a05690c0a0200b00609ecbd27ddmr503567ywb.3.1710345613487; Wed, 13 Mar
 2024 09:00:13 -0700 (PDT)
Date: Wed, 13 Mar 2024 09:00:12 -0700
In-Reply-To: <9f820b96-0e4b-4cdc-93ff-f63aed829f0d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240219074733.122080-1-weijiang.yang@intel.com>
 <20240219074733.122080-21-weijiang.yang@intel.com> <ZfDdS8rtVtyEr0UR@google.com>
 <9f820b96-0e4b-4cdc-93ff-f63aed829f0d@intel.com>
Message-ID: <ZfHNjJWWsI0wpDRd@google.com>
Subject: Re: [PATCH v10 20/27] KVM: VMX: Emulate read and write to CET MSRs
From: Sean Christopherson <seanjc@google.com>
To: Weijiang Yang <weijiang.yang@intel.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	chao.gao@intel.com, rick.p.edgecombe@intel.com, mlevitsk@redhat.com, 
	john.allen@amd.com, Aaron Lewis <aaronlewis@google.com>, 
	Jim Mattson <jmattson@google.com>, Oliver Upton <oupton@google.com>, 
	Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Mar 13, 2024, Weijiang Yang wrote:
> On 3/13/2024 6:55 AM, Sean Christopherson wrote:
> > PERF_CAPABILITIES has a similar, but opposite, problem where KVM returns a non-zero
> > value on reads, but rejects that same non-zero value on write.  PERF_CAPABILITIES
> > is even more complicated because KVM stuff a non-zero value at vCPU creation, but
> > that's not really relevant to this discussion, just another data point for how
> > messed up this all is.
> > 
> > Also relevant to this discussion are KVM's PV MSRs, e.g. MSR_KVM_ASYNC_PF_ACK,
> > as KVM rejects attempts to write '0' if the guest doesn't support the MSR, but
> > if and only userspace has enabled KVM_CAP_ENFORCE_PV_FEATURE_CPUID.
> > 
> > Coming to the point, this mess is getting too hard to maintain, both from a code
> > perspective and "what is KVM's ABI?" perspective.
> > 
> > Rather than play whack-a-mole and inevitably end up with bugs and/or inconsistencies,
> > what if we (a) return KVM_MSR_RET_INVALID when an MSR access is denied based on
> > guest CPUID,
> 
> Can we define a new return value KVM_MSR_RET_REJECTED for this case in order
> to tell it from KVM_MSR_RET_INVALID which means the msr index doesn't exit?

No.  Well, I mean, we could, but I don't see any reason to define another return
value, because the semantics further up the stack need to be identical.  And
unfortunately, correctly differentiating between the two scenario would require
quite a bit of surgery to play nice with PMU MSRs.

Hmm, I suppose we could WARN if a _completely_ unhandled MSR ends up in the
msrs_to_save or emulated_msrs lists.  But because of the PMU MSRs complications,
this is definitely not worth doing right away, if ever.

> > static bool kvm_is_msr_to_save(u32 msr_index)
> > {
> > 	unsigned int i;
> > 
> > 	for (i = 0; i < num_msrs_to_save; i++) {
> > 		if (msrs_to_save[i] == msr_index)
> > 			return true;
> > 	}
> 
> Should we also check emulated_msrs list here since KVM_GET_MSR_INDEX_LIST
> exposes it too?

Ah, yes.  I was thinking msrs_to_save was a superset, but KVM_GET_MSR_INDEX_LIST
is where the lists get smushed together.

