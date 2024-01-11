Return-Path: <linux-kernel+bounces-22943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4B282A5B7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7B58B26895
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CCA111D;
	Thu, 11 Jan 2024 02:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LRTDMAfG"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE60809
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 02:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5f6f51cd7e8so67338277b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 18:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704938454; x=1705543254; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=D95IJiOspZnkXY3ro8lL9La7I4fTbWFlMXjetLW2U0s=;
        b=LRTDMAfGbmk6wSsgJk8RgPAcPhkjdO8tzDe6nFux9W+Dn3Y2UYoHS/4BcAWIFD0zb+
         WRryUaxYeI32zfmVPpEvBF2zVWFPHMfnuIhuhWbLY73wYWdA5rYg0eWVBMC0PsgTr/wv
         pbRmHSTlcRou01ntV8Wlg/+ghcW5CYTLIN7h6aP4p740NDvosyVGN2A5d3IwydG0r1ju
         Z7m/2nVXlBt6HAOjnnrFWFIydloE06r5ME2emWUAz61aSEPWzUBdrQ2bFLxdMRoZ6XO4
         gVdbCaH+XII7yXcs0mTH9Qcabpb2AjGLD1Jbog65LjoYxqVPLjnZTrSe6QrUnvgq9Vr5
         bacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704938454; x=1705543254;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D95IJiOspZnkXY3ro8lL9La7I4fTbWFlMXjetLW2U0s=;
        b=bbTh6sfQoqyFjA4JeozOzIzYzkhnHXAdBHQjzzV8n7pyI7/6GQ7+Dolz66RuD+Noe4
         WqA5to6884zTjicBjPMVMc4gglWkV5t8SBHFp3RrPBuqJF4NsXyPFT0b/pwYmbrsFOGX
         znhTiughoz/8X/5N1dVLjnK/LYU2anzVP2KlrSJ7b+Yv2FZ+qB8eXPURkIB+klC2wrE+
         xvowRl6AxRzj3nAfsPx23OL8ELq6iQomM1P8rmEvkVkab0NTOOE4+co5mztUkYKfQHT9
         2v2wsEM4irmeNgyp7/9jTFAA5jCqPhKGurgK1VcdtQzf3iyLJJn3BOhToYzL+tQk2wI0
         VGbg==
X-Gm-Message-State: AOJu0YzXyyhXKCTmTpSqcQ15Pyif/V+92Bnm9GZdrgcC0DlZlAxUSl0j
	xUoNqlRFFZcevOfXohtXk/w/raC8M4Kpqa5RFQ==
X-Google-Smtp-Source: AGHT+IHU2L3AWsqg+VKFxa07fDe5pTrj2AA3wwqdZdelomTt1akVCSN2W4ZaypRmqaBHpCR2z17RoF67hKE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:efc3:0:b0:5d7:a8b2:327 with SMTP id
 y186-20020a0defc3000000b005d7a8b20327mr248962ywe.7.1704938454524; Wed, 10 Jan
 2024 18:00:54 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 10 Jan 2024 18:00:41 -0800
In-Reply-To: <20240111020048.844847-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240111020048.844847-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240111020048.844847-2-seanjc@google.com>
Subject: [PATCH 1/8] KVM: x86/mmu: Zap invalidated TDP MMU roots at 4KiB granularity
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Pattara Teerapong <pteerapong@google.com>
Content-Type: text/plain; charset="UTF-8"

Zap invalidated TDP MMU roots at maximum granularity, i.e. with more
frequent conditional resched checkpoints, in order to avoid running for an
extended duration (milliseconds, or worse) without honoring a reschedule
request.  And for kernels running with full or real-time preempt models,
zapping at 4KiB granularity also provides significantly reduced latency
for other tasks that are contending for mmu_lock (which isn't necessarily
an overall win for KVM, but KVM should do its best to honor the kernel's
preemption model).

To keep KVM's assertion that zapping at 1GiB granularity is functionally
ok, which is the main reason 1GiB was selected in the past, skip straight
to zapping at 1GiB if KVM is configured to prove the MMU.  Zapping roots
is far more common than a vCPU replacing a 1GiB page table with a hugepage,
e.g. generally happens multiple times during boot, and so keeping the test
coverage provided by root zaps is desirable, just not for production.

Cc: David Matlack <dmatlack@google.com>
Cc: Pattara Teerapong <pteerapong@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 6ae19b4ee5b1..372da098d3ce 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -734,15 +734,26 @@ static void tdp_mmu_zap_root(struct kvm *kvm, struct kvm_mmu_page *root,
 	rcu_read_lock();
 
 	/*
-	 * To avoid RCU stalls due to recursively removing huge swaths of SPs,
-	 * split the zap into two passes.  On the first pass, zap at the 1gb
-	 * level, and then zap top-level SPs on the second pass.  "1gb" is not
-	 * arbitrary, as KVM must be able to zap a 1gb shadow page without
-	 * inducing a stall to allow in-place replacement with a 1gb hugepage.
+	 * Zap roots in multiple passes of decreasing granularity, i.e. zap at
+	 * 4KiB=>2MiB=>1GiB=>root, in order to better honor need_resched() (all
+	 * preempt models) or mmu_lock contention (full or real-time models).
+	 * Zapping at finer granularity marginally increases the total time of
+	 * the zap, but in most cases the zap itself isn't latency sensitive.
 	 *
-	 * Because zapping a SP recurses on its children, stepping down to
-	 * PG_LEVEL_4K in the iterator itself is unnecessary.
+	 * If KVM is configured to prove the MMU, skip the 4KiB and 2MiB zaps
+	 * in order to mimic the page fault path, which can replace a 1GiB page
+	 * table with an equivalent 1GiB hugepage, i.e. can get saddled with
+	 * zapping a 1GiB region that's fully populated with 4KiB SPTEs.  This
+	 * allows verifying that KVM can safely zap 1GiB regions, e.g. without
+	 * inducing RCU stalls, without relying on a relatively rare event
+	 * (zapping roots is orders of magnitude more common).  Note, because
+	 * zapping a SP recurses on its children, stepping down to PG_LEVEL_4K
+	 * in the iterator itself is unnecessary.
 	 */
+	if (!IS_ENABLED(CONFIG_KVM_PROVE_MMU)) {
+		__tdp_mmu_zap_root(kvm, root, shared, PG_LEVEL_4K);
+		__tdp_mmu_zap_root(kvm, root, shared, PG_LEVEL_2M);
+	}
 	__tdp_mmu_zap_root(kvm, root, shared, PG_LEVEL_1G);
 	__tdp_mmu_zap_root(kvm, root, shared, root->role.level);
 
-- 
2.43.0.275.g3460e3d667-goog


