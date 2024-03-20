Return-Path: <linux-kernel+bounces-108286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E19378808C2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 838B3B2206F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8824101F7;
	Wed, 20 Mar 2024 00:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rtkMtioc"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4B57464
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 00:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710895846; cv=none; b=YKbohzvjQgPsrVmX9P1Y9MbPz5usQM9rHXZIJXqf9+rL/gNpJUxll3wRi4BQ/R2SS/nLAmmBCJcWNKuE76+bZK3CFletaXyn0kwrvQCKk60KT6pg6z1MwZB3UZ+BPx2KkcFb8bmKcoq3lxyVMrlIeh9owqJ+UPSiBPtbueA4USk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710895846; c=relaxed/simple;
	bh=LfHjr0gh4Ja0nQSAEja4M7wubj4py+zeRyGFa6gzCSY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VXnZK+rzQVFT7pFl3CytqHXLNDsEf5roAfJ7qwVbNjYlyvFayXNHjVbAYtbXiK/8xolFZr88SiczCwmaoK9NMfiDfYHpnA+p060wZsCkTbCoZ5zrgYlby6hmmn9zLnYjkrOVlIJBRmpZ5SpKhaCOKbXqZgbMQYfRnOhNI4ShnuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rtkMtioc; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6e6fd225b40so3892639b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 17:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710895844; x=1711500644; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=5a2bqtKTV93JecoVjcrHiTik+s3Ay6FzfBzzZuxLT4w=;
        b=rtkMtiocLZwFxqLmZSpy2mFrf9rX0C05T4oKiYa3+sGRAbOVnVavD/0EZT4OH0S7Cm
         FtaqW0M7746+XFOhgxpuUOmsV7y4bsKeGmWeJyd6ayKGHEwVN8etALq0ST3+w/Y/7ejO
         wZnYr5QLYiyU/CsL1pYTbeIb8azH3cxE2k5n1cRwpnzYP/mtvPUZV6pzZAad0Kk6nAnz
         P348D6ET4aM2IXX20U5ikbjUiHkSgsracB22KI2hZtPF51WudjJiTDkIcDBQAaWCqTD3
         IhzMqZ8YWidjBrF8+WZEkdrMq034XFK0GmXMg+OQ0uhG0L0EbvgsJcCsos89Ef0BYlE2
         tAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710895844; x=1711500644;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5a2bqtKTV93JecoVjcrHiTik+s3Ay6FzfBzzZuxLT4w=;
        b=TPpsfKAGzhEwnsEqoOsj5MjmvsvZs10SH30xT2yiUIzqeODbvyC3oaKPdR7caN+VdN
         CKvZc8/3teUYHTDG72joOZoHtARHWFfMEsPvhNUouy247yxb2bKnQtTtrwOpuA3C97Vx
         aGsC6R/n9wmmJdYfK5iOT7ZDVkP0+BOtQaVTjWnxhz80OhLR1e10d0SnR8mMQzCDHO+V
         cOsNlxWRyKIoBE/O2QNOs965PHAvu5T6rCYZg6BQ7FS+feqlKAKLZUmgwb5nZ7q7aZFu
         CeApdPoy0LkcVBsbsgev+M/I9urLdSXK0g65vA3LytpMPuN02e6+Rlv/lbeCCZF/I5yq
         ipRA==
X-Forwarded-Encrypted: i=1; AJvYcCWakiFl/jqNNLpVUOj5ETJCRaI8rn12JsJB1uHie6/vtox5+ezC3EYpxD70W8OzMaOy/S1zEZPV+aER1nliMsC6FzArpPkLaNoHG8kw
X-Gm-Message-State: AOJu0YymY9D0mq+KIj7aWAT0G/z6OtpEAKA3Fvsip43nGs8GhB7LgQU1
	oOThRff2qUivoWM5NJuijugqR633Aqrycml7RbDYJxMSO0p4Le9MTGC31lQIUeiSCARDSi/YlD9
	FPQ==
X-Google-Smtp-Source: AGHT+IEaIA2aymRjDeAbUoUA5PBT+xAo8Cuxn++SVSqL/D4x7uk8+Uter3hx2zwaGXU73twu2UQ+PhDpSrE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:a0d:b0:6e7:956e:4388 with SMTP id
 p13-20020a056a000a0d00b006e7956e4388mr3227pfh.0.1710895843865; Tue, 19 Mar
 2024 17:50:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 19 Mar 2024 17:50:24 -0700
In-Reply-To: <20240320005024.3216282-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240320005024.3216282-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240320005024.3216282-5-seanjc@google.com>
Subject: [RFC PATCH 4/4] KVM: x86/mmu: Don't force flush if SPTE update clears
 Accessed bit
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, David Matlack <dmatlack@google.com>, 
	David Stevens <stevensd@chromium.org>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"

Don't force a TLB if mmu_spte_update() clears Accessed bit, as access
tracking tolerates false negatives, as evidenced by the mmu_notifier hooks
that explicit test and age SPTEs without doing a TLB flush.

In practice, this is very nearly a nop.  spte_write_protect() and
spte_clear_dirty() never clear the Accessed bit.  make_spte() always
sets the Accessed bit for !prefetch scenarios.  FNAME(sync_spte) only sets
SPTE if the protection bits are changing, i.e. if a flush will be needed
regardless of the Accessed bits.  And FNAME(pte_prefetch) sets SPTE if and
only if the old SPTE is !PRESENT.

That leaves kvm_arch_async_page_ready() as the one path that will generate
a !ACCESSED SPTE *and* overwrite a PRESENT SPTE.  And that's very arguably
a bug, as clobbering a valid SPTE in that case is nonsensical.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 0a6c6619d213..77d1072b130d 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -515,37 +515,24 @@ static u64 mmu_spte_update_no_track(u64 *sptep, u64 new_spte)
  * TLBs must be flushed. Otherwise rmap_write_protect will find a read-only
  * spte, even though the writable spte might be cached on a CPU's TLB.
  *
+ * Remote TLBs also need to be flushed if the Dirty bit is cleared, as false
+ * negatives are not acceptable, e.g. if KVM is using D-bit based PML on VMX.
+ *
+ * Don't flush if the Accessed bit is cleared, as access tracking tolerates
+ * false negatives, and the one path that does care about TLB flushes,
+ * kvm_mmu_notifier_clear_flush_young(), uses mmu_spte_update_no_track().
+ *
  * Returns true if the TLB needs to be flushed
  */
 static bool mmu_spte_update(u64 *sptep, u64 new_spte)
 {
-	bool flush = false;
 	u64 old_spte = mmu_spte_update_no_track(sptep, new_spte);
 
 	if (!is_shadow_present_pte(old_spte))
 		return false;
 
-	/*
-	 * For the spte updated out of mmu-lock is safe, since
-	 * we always atomically update it, see the comments in
-	 * spte_has_volatile_bits().
-	 */
-	if (is_mmu_writable_spte(old_spte) &&
-	      !is_writable_pte(new_spte))
-		flush = true;
-
-	/*
-	 * Flush TLB when accessed/dirty states are changed in the page tables,
-	 * to guarantee consistency between TLB and page tables.
-	 */
-
-	if (is_accessed_spte(old_spte) && !is_accessed_spte(new_spte))
-		flush = true;
-
-	if (is_dirty_spte(old_spte) && !is_dirty_spte(new_spte))
-		flush = true;
-
-	return flush;
+	return (is_mmu_writable_spte(old_spte) && !is_writable_pte(new_spte)) ||
+	       (is_dirty_spte(old_spte) && !is_dirty_spte(new_spte));
 }
 
 /*
-- 
2.44.0.291.gc1ea87d7ee-goog


