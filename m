Return-Path: <linux-kernel+bounces-136117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CD289D02B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 04:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 870901F24CD4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 02:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C3B548EB;
	Tue,  9 Apr 2024 02:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zpnWaoYh"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D7E548EA
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 02:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712628137; cv=none; b=CzvyAXHTtA686s0INna1ygjB0KalKZPyKpp13N9z+V/WibBzCoQVCMRILy8+XcaJDNTmSkFDUlaMCkXh5f52dJk+VxXKAMadEZ3mjIpZbGnYS59+7WTTFB1sXZEC6tE8N3iPvVmxRMeJguB1xi3BIVsMjSxcGevXBDdIeHE30DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712628137; c=relaxed/simple;
	bh=mfEL1XnOXqYfcMhd31fh81AnjvtUlY57KzcwlHvL1bs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sG13/K2wjyi7I4lK7wC1WJpxK1Y9c+8cVetW37+8iv5eYUX0ZgPcsOjbtiDD/49vag1QhQPK3Klz4tFbuJjRa+iL0cT30bm5wAxrdF0f/QHY/HPGRCobJ9DArmqEzyBO314eEGHG9feLf3h6N6WaP+P2uLvF3ddQ1F++Gah/X8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zpnWaoYh; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dccc49ef73eso7894793276.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 19:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712628135; x=1713232935; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pIBIwrBG9RKrmzAd4o1Rn6U7Nm/9nJJIrL9rrLVwWa8=;
        b=zpnWaoYhZgRNxV4mdS85vZ9hXs88Da37v3SbL0wbphxosGAxcXVml7ZHbNpszzZtLT
         EpT3cp6QMldltFPys1gTN//OLXGUCBrHmEH8WivpXC5ZpT2aKACST3t+UUwQ05umgWAj
         AuYQKcArZxRtt645mYqqifx5h5Cmd7rnlgYstC5mrno0zMz5+lAjvxuydqaJl8vVpNQ1
         PzfMNBPSeDfpQ9yeDhMLliJ/6zRNcSCCO089EpzjKPtDuutCIXvK4OxpUEINm6NbQy6P
         jj9XAFT0TYpxkDKO06Km9rw4Dk3DyM7aXWgwRq6dXasteHkVBmimpl9nxR9RDz7yrfCZ
         AH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712628135; x=1713232935;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pIBIwrBG9RKrmzAd4o1Rn6U7Nm/9nJJIrL9rrLVwWa8=;
        b=RCM5mi0ukNQQAyhL1eQodbb5DQQ2GyAIF6SOMVJRLSjlrfbPbQsLwtA2hT8GkXi272
         jSeNazP3OJPUg51URl4oEUfMP2oBnN6wzN5NDh/uBIiRSVaYsjN2jEvJe1ogw9sM+5+T
         jbSnmkSnz0gG/F0rAJAZqE7yX3GTeOnNxAOEglfY0QigAw2LMFaOaEJ3kj+e3ATL1QWZ
         Jjx1Q/BY8C+YL9ZSZ2FDaG/H3EUlmmMRRKGA1sCGPLIS+WSBlDU7J1/bLtoqIlpVmmaa
         QS/EXr50o1hH+ddk0Ciz5QD/Nt3E8QbrDEx3AiMFNsNiGCH4AONWwVRT3R8dZuFC9KLZ
         f7Uw==
X-Forwarded-Encrypted: i=1; AJvYcCXuKUDDUh9tJMQi1cwlS8LccO4f+HPXAEFQKBhBouqQDYbXWyaOc0Tzo3+KFfhnUDjKSADKmvFwpImq/opx9hVrwWIH+dG38z2hLSSF
X-Gm-Message-State: AOJu0YxSjc84zOtYrLb5ejTyKjPr7sYKMwfRFH6gesi93a9Y1vib01FB
	e17MzQzm/gCbmkaFfoNQksiKqBsidLZdCLWjqabkG/crAArPc8rBTCOxgehk1ZuEOR6wXilzkfc
	Qkg==
X-Google-Smtp-Source: AGHT+IFwZvu5o3vmJO8p2zw1YUxBTeUBzCfa+fwRqXertvmQ/vDGF51z+rlmPD0JXyNQKMuEIoGLHfMj/5c=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:2b88:b0:dc6:44d4:bee0 with SMTP id
 fj8-20020a0569022b8800b00dc644d4bee0mr524360ybb.7.1712628134841; Mon, 08 Apr
 2024 19:02:14 -0700 (PDT)
Date: Mon,  8 Apr 2024 19:01:31 -0700
In-Reply-To: <20240320001542.3203871-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240320001542.3203871-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <171262709411.1419562.9904481502027764758.b4-ty@google.com>
Subject: Re: [PATCH 0/3] KVM: Fix for a mostly benign gpc WARN
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+106a4f72b0474e1d1b33@syzkaller.appspotmail.com, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Content-Type: text/plain; charset="utf-8"

On Tue, 19 Mar 2024 17:15:39 -0700, Sean Christopherson wrote:
> Fix a bug found by syzkaller, thanks to a new WARN sanity check, where KVM
> marks a gfn_to_pfn_cache as active without actually setting gpc->gpa or any
> other metadata.  On top, harden against _directly_ setting gpc->gpa to KVM's
> magic INVALID_GPA, which would also fail the sanity check.
> 
> Sean Christopherson (3):
>   KVM: Add helpers to consolidate gfn_to_pfn_cache's page split check
>   KVM: Check validity of offset+length of gfn_to_pfn_cache prior to
>     activation
>   KVM: Explicitly disallow activatating a gfn_to_pfn_cache with
>     INVALID_GPA
> 
> [...]

Applied to kvm-x86 fixes, thanks!

[1/3] KVM: Add helpers to consolidate gfn_to_pfn_cache's page split check
      https://github.com/kvm-x86/linux/commit/18f06e976925
[2/3] KVM: Check validity of offset+length of gfn_to_pfn_cache prior to activation
      https://github.com/kvm-x86/linux/commit/5c9ca4ed8908
[3/3] KVM: Explicitly disallow activatating a gfn_to_pfn_cache with INVALID_GPA
      https://github.com/kvm-x86/linux/commit/fc62a4e8dee2

--
https://github.com/kvm-x86/linux/tree/next

