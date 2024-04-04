Return-Path: <linux-kernel+bounces-132179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 989EA8990F5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3B85B25E20
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B5713C3FC;
	Thu,  4 Apr 2024 22:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VaHPnctX"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312D513C3F2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 22:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712268174; cv=none; b=IbIGjTYS7MuNwe1WJT3cvKc3Wvi39ekDt9pRYxql4N3C21aGoaGbMz31mp4OGiHXuGBEaGNjpG1oak/qJDRBo4JHQ2ClHQYjbRcTqQwsLmmkvFHf3ykEeEqqc24aSgr2EJ+EzNGDf9Y7yHMOMYmT+Qq6Mko4m54LwROf3XxHvxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712268174; c=relaxed/simple;
	bh=gCXKx584ihLrRGLv1AW+QX7Fe19+djW1Hf4uwf3WwHA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jvFp6ACfafHsBohB5ia6a3sE8fY+H7KozfKNjXuJ5IMGf3y5r2rmj0O9BYHe5a9/BomBWqSAU0imLCYFxdrX8SvD8aIvnA758NEFL3sgOv6934WFFcxf0Lwgyjkc8l236Ne6GWZL5MCH6kElutR5YxgOHPDr/5xdj7ckTT8Dm68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VaHPnctX; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cd62fa1f9so23794617b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 15:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712268172; x=1712872972; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZNQ0U5unaFTxk2zzDkpqLdaGLsgSJwRkFdrhcIu1eQ=;
        b=VaHPnctXrCXyHSegUpa5TBFCy9Zl8TuNvFuAdlc5bd4kumNzD0X5D6xV2fcexJAMut
         Jiu4RiOWcsqXBVEQZxatOzn/Z2xpo2iYSBQ3msK8KRG45Ur2LZTMCNVbSo9kSppQaMJn
         V1+G8wq0mXC9bQcM2JdaqKbn2rIZsvQTds3VNQZ/EslCnoqUX7BDKomJj5eYsJk2EaqA
         6eBrgK7kqd1Hcv0UkDt3aQAC4VaEk0nGE3LUXfinu77y00q37uat8v3+bETbpNxcol9x
         VXEeKK9mUKjdSqitNfY2bFjn5OIjM/CA0pjnt33Dt9DrOzM0Z49FFxzy3ajJEmcMyCLl
         wSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712268172; x=1712872972;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZNQ0U5unaFTxk2zzDkpqLdaGLsgSJwRkFdrhcIu1eQ=;
        b=bBCOMHTdiH02k8gOy2zjc/dmWopUl5BHAFkwkv6QLhwDas0mJVWCm+9KowHLoYsHfK
         DxM6eS52x117ayDdipiOfKJ50zsDKASxbo6RyV37hIbMGQaIeCii8Eyy2n9S8/u505l/
         I3ClKmBop31vZLrs9p2T/UNdjZgQ9YyDM/2rQHmNjBfA8PG/uTsyYAzShrcW8bUPaKDH
         cixi5EuDtBmnXZYEXLz9+WE/2Qt1Khb2RxjwJsdb6M2R4yviOdKccnl++c/eTE3D9zVl
         d29uixOCWNnnInOHgEDZdL8Cjiuv5cKSgiwI/+ZCaXSK8UJdy5krKhwDV3h9XYxZxU5w
         Ne9g==
X-Forwarded-Encrypted: i=1; AJvYcCUaDFSPKGKjh8lWK4efSQbXui0l+/faruyrHB27345nRwfl/81q7JqcYtlwcHNy7r9pl84ATOtKvvhAEXUwI9mWYyIisaJ1dvBJx9RW
X-Gm-Message-State: AOJu0YzjWpEmNiOoyV/VOV88LXhGxXgTBFPa5uY6G6znsNuGCekYm8NK
	cbzPhx3s9JetyUDlZ0x5Bg6Jkz1ZuB2eTTehfzY9R3pAqx0BsiBznc4LVSe3n4Q96cDvkd9Mkqe
	GeA==
X-Google-Smtp-Source: AGHT+IE05QOun/pkmautFCPsP8G2K7XExWfyaZrvizqHD63veiC++eGMl5R2p4BQj9L26q3oiaqe1CURGNM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:6b4b:0:b0:dc2:26f6:fbc8 with SMTP id
 o11-20020a256b4b000000b00dc226f6fbc8mr91119ybm.7.1712268172238; Thu, 04 Apr
 2024 15:02:52 -0700 (PDT)
Date: Thu, 4 Apr 2024 15:02:50 -0700
In-Reply-To: <b3ea925f-bd47-4f54-bede-3f0d7471e3d7@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240320005024.3216282-1-seanjc@google.com> <4d04b010-98f3-4eae-b320-a7dd6104b0bf@redhat.com>
 <CALzav=eLH+V_5Y6ZWsRkmnbEb6fxPa55B7xyWxP3o6qsrs_nHA@mail.gmail.com>
 <a2fff462-dfe6-4979-a7b2-131c6e0b5017@redhat.com> <ZgygGmaEuddZGKyX@google.com>
 <ca1f320b-dc06-48e0-b4f5-ce860a72f0e2@redhat.com> <Zg3V-M3iospVUEDU@google.com>
 <42dbf562-5eab-4f82-ad77-5ee5b8c79285@redhat.com> <Zg7j2D6WFqcPaXFB@google.com>
 <b3ea925f-bd47-4f54-bede-3f0d7471e3d7@redhat.com>
Message-ID: <Zg8jip0QIBbOCgpz@google.com>
Subject: Re: [RFC PATCH 0/4] KVM: x86/mmu: Rework marking folios dirty/accessed
From: Sean Christopherson <seanjc@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: David Matlack <dmatlack@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Stevens <stevensd@chromium.org>, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 04, 2024, David Hildenbrand wrote:
> On 04.04.24 19:31, Sean Christopherson wrote:
> > On Thu, Apr 04, 2024, David Hildenbrand wrote:
> > > On 04.04.24 00:19, Sean Christopherson wrote:
> > > > Hmm, we essentially already have an mmu_notifier today, since secondary MMUs need
> > > > to be invalidated before consuming dirty status.  Isn't the end result essentially
> > > > a sane FOLL_TOUCH?
> > > 
> > > Likely. As stated in my first mail, FOLL_TOUCH is a bit of a mess right now.
> > > 
> > > Having something that makes sure the writable PTE/PMD is dirty (or
> > > alternatively sets it dirty), paired with MMU notifiers notifying on any
> > > mkclean would be one option that would leave handling how to handle dirtying
> > > of folios completely to the core. It would behave just like a CPU writing to
> > > the page table, which would set the pte dirty.
> > > 
> > > Of course, if frequent clearing of the dirty PTE/PMD bit would be a problem
> > > (like we discussed for the accessed bit), that would not be an option. But
> > > from what I recall, only clearing the PTE/PMD dirty bit is rather rare.
> > 
> > And AFAICT, all cases already invalidate secondary MMUs anyways, so if anything
> > it would probably be a net positive, e.g. the notification could more precisely
> > say that SPTEs need to be read-only, not blasted away completely.
> 
> As discussed, I think at least madvise_free_pte_range() wouldn't do that.

I'm getting a bit turned around.  Are you talking about what madvise_free_pte_range()
would do in this future world, or what madvise_free_pte_range() does today?  Because
today, unless I'm really misreading the code, secondary MMUs are invalidated before
the dirty bit is cleared.

	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm,
				range.start, range.end);

	lru_add_drain();
	tlb_gather_mmu(&tlb, mm);
	update_hiwater_rss(mm);

	mmu_notifier_invalidate_range_start(&range);
	tlb_start_vma(&tlb, vma);
	walk_page_range(vma->vm_mm, range.start, range.end,
			&madvise_free_walk_ops, &tlb);
	tlb_end_vma(&tlb, vma);
	mmu_notifier_invalidate_range_end(&range);

KVM (or any other secondary MMU) can re-establish mapping with W=1,D=0 in the
PTE, but the costly invalidation (zap+flush+fault) still happens.

> Notifiers would only get called later when actually zapping the folio.

And in case we're talking about a hypothetical future, I was thinking the above
could do MMU_NOTIFY_WRITE_PROTECT instead of MMU_NOTIFY_CLEAR.

> So at least for some time, you would have the PTE not dirty, but the SPTE
> writable or even dirty. So you'd have to set the page dirty when zapping the
> SPTE ...  and IMHO that is what we should maybe try to avoid :)

