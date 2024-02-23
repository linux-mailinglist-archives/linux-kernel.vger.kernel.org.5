Return-Path: <linux-kernel+bounces-78949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33437861B40
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D65428A3B3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F241419B3;
	Fri, 23 Feb 2024 18:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1V/7e8ZY"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47921A58B
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 18:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708711979; cv=none; b=YzkXK7CImXjQ7crnazUz7dx+Yf+gW5juS61BsDC8LfcwtCxhh8ZO8g0+uKy5xVk+9Zndms0BMbH/5KsRU46dJTv22L5DoxyWfJ5V9D6coJ4Vqw//PNrwvZGSngsPLlhL2ZREmSXmecSYVDrIgCdRZsuhiiZnoCik66eqwpqajtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708711979; c=relaxed/simple;
	bh=FODgi2+w3qigf3GmA5xHYAnSBSBReeCMGEY9C65E+EU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PLBj4YBwbegideao03lizzYuHVEOHKha5H4RMU441BGw5T1+B+CNQDxQWtG+r5RZe6TkUbTIiAT1508TPAunYd1vD1GfdWRFaJCJS+imGK+O8T85ObqV6WtOLxanc+PgKP98bwlX7xS7swHcIJm1OT/oeHua2IeGS/15q44W/2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1V/7e8ZY; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-29a86539b3cso277478a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 10:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708711977; x=1709316777; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RA1xAboPdMNhBUDJNDvoRwou3QKT9Qx2v7tGAmgkc9Y=;
        b=1V/7e8ZYsfMwWXeoyzoFX5xucojfSoFKPdxcM5bMBOexp+vACbmFAwAp+WGYBR2TCI
         usXqP5rG6Sb5WOH0kAGK9pbb/khsxi4mkK4e8jyVENjt32iZCqp4vdx9AStHOv4sdEo1
         OsToiYXS+lJ5/itdFYcWE3JFpvgm3NEwTb5ZNt+KLvaJMAaa1kqNcT8icG9WJEE8tfN2
         AkUlE9ZheZhn4rit8/DDePzvPVe4HNIDNSD6zocUM33o6HVIvZETpHWwKdo16URNLHlG
         TIzhvMbqML/Xj+OjsZb3V3ErE/R2hBlwXeNKutc2RcH/AWIsFLk92JuOH4YULxl0eFC7
         YxOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708711977; x=1709316777;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RA1xAboPdMNhBUDJNDvoRwou3QKT9Qx2v7tGAmgkc9Y=;
        b=neN+rsEojLK1BwuJkzC9TPMKFOCjgyhPmbzbfMHzj6wsvcPfiopVdVRWzZ+eUo8bCg
         r9rlKmYwbC+s3XZOg1rC0MHZatbxZqCiTCgnl0qNVlV/xWUjfQU3Ay34IemwPeWlylCx
         6gOLLX+HNP5rBNT/g0ZXCQV24r5PEegWb4xjQMEsgbRvfBpghlITxrYLz9gBzakl7UZA
         WCQZP+GtDtz+y/NiKpEgxKBNb4BsRv4urLviCWGRExs8cffykIWVZP/0un61QvzeGX7N
         oWh/Fr+lqo/EI6AF0fGFHuRxHVjrODC5AzP+9FN9b55YyTNF8NEgkczaBHOi4c+BGhMa
         Dhng==
X-Forwarded-Encrypted: i=1; AJvYcCW+RZS1NNn0UDR20voD5J05r7uMZWzF69+DgSHKb0rZ4tgBWZzod+14A5uRrkChe+RWQEi2NUi3DpkzQvccsvbs6QVv8T2DJJIkcQQ3
X-Gm-Message-State: AOJu0YxvzTNt9gsL1eribT8HEEbV0ip+0IBMKmFjakS8NI0fttf+9Ljg
	q6gng7k9ff+0Dnx1ii+qwt6HgFYuPsU3GdbRwFv2w7Uv+sNuj4oN/mTdxr6XNh04XoMyjS5tTT2
	TWg==
X-Google-Smtp-Source: AGHT+IH/Uew8IBGHJ4zuXaJJw00ITz38dkoKLURvzFi7MkQu//nv+r9F1bJn2RvSL2aT9fgcyLb6wVY51Q0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:3cc4:b0:299:979c:27e6 with SMTP id
 qd4-20020a17090b3cc400b00299979c27e6mr2142pjb.4.1708711975486; Fri, 23 Feb
 2024 10:12:55 -0800 (PST)
Date: Fri, 23 Feb 2024 10:12:53 -0800
In-Reply-To: <34504abb-ff58-4a83-9a63-87f22841adc7@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240203002343.383056-1-seanjc@google.com> <20240203002343.383056-5-seanjc@google.com>
 <34504abb-ff58-4a83-9a63-87f22841adc7@redhat.com>
Message-ID: <ZdjgJaVqHs7WbFnk@google.com>
Subject: Re: [PATCH v2 4/4] KVM: x86/mmu: Fix a *very* theoretical race in kvm_mmu_track_write()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Feb 23, 2024, Paolo Bonzini wrote:
> On 2/3/24 01:23, Sean Christopherson wrote:
> > Add full memory barriers in kvm_mmu_track_write() and account_shadowed()
> > to plug a (very, very theoretical) race where kvm_mmu_track_write() could
> > miss a 0->1 transition of indirect_shadow_pages and fail to zap relevant,
> > *stale* SPTEs.
> 
> Ok, so we have
> 
> emulator_write_phys
>   overwrite PTE
>   kvm_page_track_write
>     kvm_mmu_track_write
>       // memory barrier missing here
>       if (indirect_shadow_pages)
>         zap();
> 
> and on the other side
> 
>   FNAME(page_fault)
>     FNAME(fetch)
>       kvm_mmu_get_child_sp
>         kvm_mmu_get_shadow_page
>           __kvm_mmu_get_shadow_page
>             kvm_mmu_alloc_shadow_page
>               account_shadowed
>                 indirect shadow pages++
>                 // memory barrier missing here
>       if (FNAME(gpte_changed)) // reads PTE
>         goto out
> 
> If you can weave something like this in the commit message the sequence
> would be a bit clearer.

Roger that.

> > In practice, this bug is likely benign as both the 0=>1 transition and
> > reordering of this scope are extremely rare occurrences.
> 
> I wouldn't call it benign, it's more that it's unobservable in practice but
> the race is real.  However...
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 3c193b096b45..86b85060534d 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -830,6 +830,14 @@ static void account_shadowed(struct kvm *kvm, struct kvm_mmu_page *sp)
> >   	struct kvm_memory_slot *slot;
> >   	gfn_t gfn;
> > +	/*
> > +	 * Ensure indirect_shadow_pages is elevated prior to re-reading guest
> > +	 * child PTEs in FNAME(gpte_changed), i.e. guarantee either in-flight
> > +	 * emulated writes are visible before re-reading guest PTEs, or that
> > +	 * an emulated write will see the elevated count and acquire mmu_lock
> > +	 * to update SPTEs.  Pairs with the smp_mb() in kvm_mmu_track_write().
> > +	 */
> > +	smp_mb();
> 
> ... this memory barrier needs to be after the increment (the desired
> ordering is store-before-read).

Doh.  I'll post a fixed version as a one-off v3.

Thanks!

