Return-Path: <linux-kernel+bounces-97661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CB2876D3A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 23:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 537A51C219EB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E4D4E1CE;
	Fri,  8 Mar 2024 22:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oVolC4Pz"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C454CDEB
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 22:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709937437; cv=none; b=HCI0QnZbWTHgeKPcrOl0g7+CnBidwiV+aiqS9Lg1YyKQDdY4hrFeyVH3Sm734gBrGZpb+Q0LTUMp60PLPl92UBUVcZDRYUmitq+GZlCf++d6KVGili72da8vrVbBRixSLcqDkc4X6/XrwAb5KvxWPRvukJX/feWcX9i1Ivc70gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709937437; c=relaxed/simple;
	bh=GVX9GtS2jO4/AU5ZUhjw99ZSzSSyUs5GF9Sj/L1TvvM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uZYTumNxSvLkEuedRgM0JhcSvJJZ5/qzoKosxwIQgXH3CsRPdY3WCGB2WPxL9gahda7+JMi/It6igp14p3EexQaCEIm1FzMc5xfMBQMlNsq1jQg+/c+Pa1k1hlsXbczXaL0QfaDYMqG9I0aT6Q4xnxYh3vlTxzqY6awJuxUVvi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oVolC4Pz; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-609ff5727f9so21420067b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 14:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709937435; x=1710542235; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=fwit3zPKPJowboW07esGbJJ/DYpDWWtu6UvUgXB1DWM=;
        b=oVolC4PzKNL8UV0V1ro9RjPXrejmwxdCz1YiqFSeK7feL4I4yyNczT5ouEur6ccQpx
         4cY9+yqI/qZ/Kksi9zHblRosZnTYIJxSBwAcC+Aevnk4yxJYkFAWpbm0KeKaC+wW5VWn
         ZQfOuApOCFMQERDGwGkcrz7zElJ/k2V7XAIbugxhc3ZdCdSkiguRjM86dOy/zZOZrcWH
         /5FKSgQGTMYgt6aEtpjKEkRDATwaXDOLS9hG6uqXRbx8wZy2n+9AEDVZwhl6lda0Seon
         cEi6MHLY9BzeUbzdC1i0CFlIq7sv2SNoEotZ9r2JZ5Ss/aeks7OOp6Vuacv4yGNZ6kvJ
         qJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709937435; x=1710542235;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fwit3zPKPJowboW07esGbJJ/DYpDWWtu6UvUgXB1DWM=;
        b=fDWBM/HYD88iENx2PcusxW9tu4fBHACET7eBdhROdgeTVYYP8XHwUV4IzLvxYL/XCw
         5FjvoBJa72/eMVke52ilV4WNkrVGPX5lTy/4ufvPoP5vzIzYX0WAvsLEUzUCiWNra+lI
         cKFMytq0baHDNbDfDugvtmNtV6PGG1JD4NTiRmiYyreCrzS5OasMYV/xW7L195ki1pie
         WL5+yJcNsrCp1J4oy46H+Jt5qAOVzSGviXgXlInyiYfTNJMF66IHULbEjot6S4eHOJVQ
         egOtayHmciDTf1YvYLn30qgeOLy2ms1ppkxxuBQR25nasF4uxix4wzobyDQDcptFK0ok
         y8/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXIyEZf2994YEq8XyLFv7RLm272QnzEdAQXqV0sXETHaCFZjCo9p90WusCeJ256UhwASRnRRhOVDeLc/NNYMa4eJQ5L75VnVKlXyBIq
X-Gm-Message-State: AOJu0YyKmsAp4G9FVQTYjpxgtO31mgfDkkeL/rF+1Wt3Ze2xpqN6B0dJ
	shOUJe2gSdeRZz/88jZem9lqH6QhKlHAEHB0DrePNHLoZ1R+V1d6A9o4yesyMYHlXGXENVNykIE
	fzA==
X-Google-Smtp-Source: AGHT+IGBKyIAz2GkM/hYToD+b4J4B0JxtCkZlF2tzy9ZBMWHuA2MNbKVsDAFZHk3Wu1kNz+HN+Z3cV9xbIc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:cc8a:0:b0:608:b6fe:9616 with SMTP id
 o132-20020a0dcc8a000000b00608b6fe9616mr142198ywd.2.1709937434784; Fri, 08 Mar
 2024 14:37:14 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  8 Mar 2024 14:36:57 -0800
In-Reply-To: <20240308223702.1350851-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240308223702.1350851-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240308223702.1350851-5-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: MMU changes for 6.9
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

The bulk of the changes are TDP MMU improvements related to memslot deletion
(ChromeOS has a use case that "requires" frequent deletion of a GPU buffer).
The other highlight is allocating the write-tracking metadata on-demand, e.g.
so that distro kernels pay the memory cost of the arrays if and only if KVM
or KVMGT actually needs to shadow guest page tables.

The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3:

  Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-mmu-6.9

for you to fetch changes up to a364c014a2c1ad6e011bc5fdb8afb9d4ba316956:

  kvm/x86: allocate the write-tracking metadata on-demand (2024-02-27 11:49:54 -0800)

----------------------------------------------------------------
KVM x86 MMU changes for 6.9:

 - Clean up code related to unprotecting shadow pages when retrying a guest
   instruction after failed #PF-induced emulation.

 - Zap TDP MMU roots at 4KiB granularity to minimize the delay in yielding if
   a reschedule is needed, e.g. if a high priority task needs to run.  Because
   KVM doesn't support yielding in the middle of processing a zapped non-leaf
   SPTE, zapping at 1GiB granularity can result in multi-millisecond lag when
   attempting to schedule in a high priority.

 - Rework TDP MMU root unload, free, and alloc to run with mmu_lock held for
   read, e.g. to avoid serializing vCPUs when userspace deletes a memslot.

 - Allocate write-tracking metadata on-demand to avoid the memory overhead when
   running kernels built with KVMGT support (external write-tracking enabled),
   but for workloads that don't use nested virtualization (shadow paging) or
   KVMGT.

----------------------------------------------------------------
Andrei Vagin (1):
      kvm/x86: allocate the write-tracking metadata on-demand

Kunwu Chan (1):
      KVM: x86/mmu: Use KMEM_CACHE instead of kmem_cache_create()

Mingwei Zhang (1):
      KVM: x86/mmu: Don't acquire mmu_lock when using indirect_shadow_pages as a heuristic

Sean Christopherson (10):
      KVM: x86: Drop dedicated logic for direct MMUs in reexecute_instruction()
      KVM: x86: Drop superfluous check on direct MMU vs. WRITE_PF_TO_SP flag
      KVM: x86/mmu: Zap invalidated TDP MMU roots at 4KiB granularity
      KVM: x86/mmu: Don't do TLB flush when zappings SPTEs in invalid roots
      KVM: x86/mmu: Allow passing '-1' for "all" as_id for TDP MMU iterators
      KVM: x86/mmu: Skip invalid roots when zapping leaf SPTEs for GFN range
      KVM: x86/mmu: Skip invalid TDP MMU roots when write-protecting SPTEs
      KVM: x86/mmu: Check for usable TDP MMU root while holding mmu_lock for read
      KVM: x86/mmu: Alloc TDP MMU roots while holding mmu_lock for read
      KVM: x86/mmu: Free TDP MMU roots while holding mmy_lock for read

 arch/x86/include/asm/kvm_host.h |   9 +++
 arch/x86/kvm/mmu/mmu.c          |  37 +++++++-----
 arch/x86/kvm/mmu/page_track.c   |  68 +++++++++++++++++++++-
 arch/x86/kvm/mmu/tdp_mmu.c      | 124 ++++++++++++++++++++++++++++------------
 arch/x86/kvm/mmu/tdp_mmu.h      |   2 +-
 arch/x86/kvm/x86.c              |  35 +++++-------
 6 files changed, 201 insertions(+), 74 deletions(-)

