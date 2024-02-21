Return-Path: <linux-kernel+bounces-75018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B55B85E1A3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1508C284990
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37E180C11;
	Wed, 21 Feb 2024 15:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bqiuurJu"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F5F4F8AB
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530214; cv=none; b=HjF204ZUXatvmaMLYoo8GrrzdDNCm/L4JjJ1fuZYaEUN/xSrpRXIqPyKj7NiJ/45ANhJn5IcgqeP1tJOgGsUUfQ05DYkPNIrlpnecr0vHMy1j7O//6mkl4y+xP/6DdA05U3y19bHxzM3we6yQbim30SZWeA9hKDvMT/R0iJdl9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530214; c=relaxed/simple;
	bh=dtPcZYGotYb13H+XbyPznkYrx/vuVf9Nw4dujOkUQmU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G8kyjIZ5q1O9gByxIPICSHs+NyquBJ/yIfDB+lVfiE6rDbJ/C6TenPfZInvZnYw3PFuIQClYRL8g3OiXA7Rrm/Ncbb1DK8SXqfqduKzYoJyiDEq2P6hJ79hpjiiUQHRMQZRrvpknpzZmd12hpYg52KLFUiM7QNiLkIQg97rG/Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bqiuurJu; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6047fed0132so103873207b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708530212; x=1709135012; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WHVJrIcOXAHbQ4g5qnO/XXw4nGfAyfdi3Ure4gTW0sc=;
        b=bqiuurJuSdZSIsjUWnenFHJTJ+78n5OQf0uJddVQX/jr3w+Clbzj/U1EkicafGIN9r
         ea0TLsWtGPvk580FHkZK3JjE25MbuKEfriqXq6UVP1Rz6pLdA+T/Pw3M12Pt/CYmWjRY
         HH31NbbhA/T1PxPE+g5KuvoZFqUFzx0dMzRoInytCBJrM8hJ6ZPiON0WrxRW0/Ef7ne5
         xI/T55e7tUIhh61Ix0xi3tbBQpkeRxu25HsAmY4FAXdJGVzlORHngahZ9bqiJ+Un1g3e
         wilAJD5YGwqXj7ChkOlsLzogDWGg4v0n17JWjyK0z60rBzZLGBnldXcbNMQchrNLTFNg
         Y8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708530212; x=1709135012;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WHVJrIcOXAHbQ4g5qnO/XXw4nGfAyfdi3Ure4gTW0sc=;
        b=CYAWOyOtRg7Om0DcVZHt9Nx/uQBEzVrLm8uG13w2KFFnQr1w9llrtblsvak3Glxu8M
         QsuJgE8Jme9BZmEkkyD+3RyeifRQw1oRJ9pzgppWsN33/YpAXB6c/HQ9tBKzCl1BB491
         kVbAqwhGVwhCAs9Y/+TLLCscYJwMOf5ymwhh1oe3JMf+WcK8i62ROtabNRLSkxtulwZC
         hkW3JoSdJ8SauKep1NFM6D60GG+5YHwELH2LVOHEIw2KFy3c4Pe+IvwMQ9yxwJvp3ysp
         +FLrW2uekq38b8H+AV0IOwrdoCPQgIvVrPOFa6OPiPnLXy6wSBUGIQTLRDBhHIgXnDJ3
         Y7kQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiVY+uG1ociK45aKIR49n9D6CAXvOUm9oz9jeDw2YD3eMT1ssn4viEqrzEz9rVPTEz7aRVth3gQmVgtbGpu1yGSTS/oKjp/gcaVIgE
X-Gm-Message-State: AOJu0Yw/AOFvX09zshRpl4JWbNgdimIM09igtY+YbPhqIraiwgUXrKs9
	cHnmlMCFskpJN1ckYrMNVRfVUBrzot7uXEGrYEq3UbEIaUnuHvxSI+5/8PvLb7x0Lxof83smgtG
	oSA==
X-Google-Smtp-Source: AGHT+IGhrxI4ofUDpG182hxnUyjMmsblvBAVscfBi3HLQB8eiu0haeYne7+Xs1m1lhwdsfUl21ZigjZObHI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1b85:b0:dc2:26f6:fbc8 with SMTP id
 ei5-20020a0569021b8500b00dc226f6fbc8mr752182ybb.7.1708530212469; Wed, 21 Feb
 2024 07:43:32 -0800 (PST)
Date: Wed, 21 Feb 2024 07:43:30 -0800
In-Reply-To: <05571373-5072-b63b-4a79-f21037556cfa@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240217014513.7853-1-dongli.zhang@oracle.com>
 <20240217014513.7853-4-dongli.zhang@oracle.com> <ZdPXTfHj4uxfe0Ay@google.com> <05571373-5072-b63b-4a79-f21037556cfa@oracle.com>
Message-ID: <ZdYaIn7xwqTPdofq@google.com>
Subject: Re: [PATCH 3/3] KVM: VMX: simplify MSR interception enable/disable
From: Sean Christopherson <seanjc@google.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Feb 20, 2024, Dongli Zhang wrote:
> Hi Sean,
> 
> On 2/19/24 14:33, Sean Christopherson wrote:
> > On Fri, Feb 16, 2024, Dongli Zhang wrote:
> >> ---
> >>  arch/x86/kvm/vmx/vmx.c | 55 +++++++++++++++++++++---------------------
> >>  1 file changed, 28 insertions(+), 27 deletions(-)
> >>
> >> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> >> index 5a866d3c2bc8..76dff0e7d8bd 100644
> >> --- a/arch/x86/kvm/vmx/vmx.c
> >> +++ b/arch/x86/kvm/vmx/vmx.c
> >> @@ -669,14 +669,18 @@ static int possible_passthrough_msr_slot(u32 msr)
> >>  	return -ENOENT;
> >>  }
> >>  
> >> -static bool is_valid_passthrough_msr(u32 msr)
> >> +#define VMX_POSSIBLE_PASSTHROUGH	1
> >> +#define VMX_OTHER_PASSTHROUGH		2
> >> +/*
> >> + * Vefify if the msr is the passthrough MSRs.
> >> + * Return the index in *possible_idx if it is a possible passthrough MSR.
> >> + */
> >> +static int validate_passthrough_msr(u32 msr, int *possible_idx)
> > 
> > There's no need for a custom tri-state return value or an out-param, just return
> > the slot/-ENOENT.  Not fully tested yet, but this should do the trick.
> 
> The new patch looks good to me, from functionality's perspective.
> 
> Just that the new patched function looks confusing. That's why I was adding the
> out-param initially to differentiate from different cases.
> 
> The new vmx_get_passthrough_msr_slot() is just doing the trick by combining many
> jobs together:
> 
> 1. Get the possible passthrough msr slot index.
> 
> 2. For x2APIC/PT/LBR msr, return -ENOENT.
> 
> 3. For other msr, return the same -ENOENT, with a WARN.
> 
> The semantics of the function look confusing.
> 
> If the objective is to return passthrough msr slot, why return -ENOENT for
> x2APIC/PT/LBR.

Because there is no "slot" for them in vmx_possible_passthrough_msrs, and the
main purpose of the helpers is to get that slot in order to efficiently update
the MSR bitmaps in response to userspace MSR filter changes.  The WARN is an extra
sanity check to ensure that KVM doesn't start passing through an MSR without
adding the MSR to vmx_possible_passthrough_msrs (or special casing it a la XAPIC,
PT, and LBR MSRS).

> Why both x2APIC/PT/LBR and other MSRs return the same -ENOENT, while the other
> MSRs may trigger WARN. (I know this is because the other MSRs do not belong to
> any passthrough MSRs).

The x2APIC/PT/LBR MSRs are given special treatment: KVM may pass them through to
the guest, but unlike the "regular" passthrough MSRs, userspace is NOT allowed to
override that behavior via MSR filters.

And so as mentioned above, they don't have a slot in vmx_possible_passthrough_msrs.

