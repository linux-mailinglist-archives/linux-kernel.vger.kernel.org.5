Return-Path: <linux-kernel+bounces-22945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1017E82A5BB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7041BB21AD8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF8A5382;
	Thu, 11 Jan 2024 02:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lh6jSNZ6"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1757A20F8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 02:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-db402e6f61dso6228135276.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 18:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704938458; x=1705543258; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=l9/uUlAc1H6ges5WZZ0my7oKxRDSlYhBNEqPxH+MbT4=;
        b=Lh6jSNZ6lnn/YTXtA//qLIgGy6u0hLEtPrmRi5Pdkw5vn/FTbaSzmLXnYkxLsE2128
         c0v/kjJso7bu1epNSy5w9FvTq98LzRZxnBtZmDkDXt4O+FG/bCycXVhVY2FBpTEkmqsW
         5HSkpjkp3MphMjU1+zHcgujvsvldwir1V/YaFzYBqgPSWwrnUtt0+6yXFqJriQW6D8bD
         RzjRibYTT/p7+tG5Q+xBEy6Klu1clqcfCxRWZSGGjuxbP649zS7h7S5DtLhJe2oTmw/Y
         CUp2+HAglm1fYnMhIXAV5Xlqq75XUA4ApEW3j90EkddrIq2VljHYqDuKXLjzQIyPxDm9
         p52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704938458; x=1705543258;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l9/uUlAc1H6ges5WZZ0my7oKxRDSlYhBNEqPxH+MbT4=;
        b=ptsHCFKv8GLW8Bg3E/q/8jvUBIcPIVmLIABEJwIaEqYtOq4AguDL8m3mum80xsDSj6
         boRPsPuPU47DcK0CQ3otInNErZRUvU6j4iUjAn90IaL86+QVsfK5Ln5gDPkynJSerAIE
         0CxFkrfOQZQ08n0tuVOMZWgFvHf8NbWgj1wFio4UDJuPfmUdcrN78rREhvbvwTcx9NLs
         2KK5iCryMwCujgma8z9V8psAt9J8vGYLC61/LvK0+Q0Qg0klBPQtNoWrZ0/sxU9UeRei
         vRXoqelVX63zdL9sAxjBxMBcp/hVLhDgh8CEJTJEOIwVXze6seNuM3hQtGyGLGCbEu5K
         WSrw==
X-Gm-Message-State: AOJu0YzTLkWTLH4JpeEOPSzNVMS6y2MGLdhw3jFyHwc34KA01P+AhGkX
	cz/wo0rQx5nQWyZPT4jwiibOE+F5CHIkIyEYCg==
X-Google-Smtp-Source: AGHT+IH1AmU0WCb2Gp9Ea9RybRQmF02qQ8h/mg95lotcVnIJqt7Wd2ZELLjTguwBfn6b4owyhXqtgNr922s=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:9f02:0:b0:dbe:642c:2124 with SMTP id
 n2-20020a259f02000000b00dbe642c2124mr222202ybq.0.1704938458187; Wed, 10 Jan
 2024 18:00:58 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 10 Jan 2024 18:00:43 -0800
In-Reply-To: <20240111020048.844847-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240111020048.844847-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240111020048.844847-4-seanjc@google.com>
Subject: [PATCH 3/8] KVM: x86/mmu: Allow passing '-1' for "all" as_id for TDP
 MMU iterators
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Pattara Teerapong <pteerapong@google.com>
Content-Type: text/plain; charset="UTF-8"

Modify for_each_tdp_mmu_root() and __for_each_tdp_mmu_root_yield_safe() to
accept -1 for _as_id to mean "process all memslot address spaces".  That
way code that wants to process both SMM and !SMM doesn't need to iterate
over roots twice (and likely copy+paste code in the process).

Deliberately don't cast _as_id to an "int", just in case not casting helps
the compiler elide the "_as_id >=0" check when being passed an unsigned
value, e.g. from a memslot.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 68920877370b..60fff2aad59e 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -149,11 +149,11 @@ static struct kvm_mmu_page *tdp_mmu_next_root(struct kvm *kvm,
  * If shared is set, this function is operating under the MMU lock in read
  * mode.
  */
-#define __for_each_tdp_mmu_root_yield_safe(_kvm, _root, _as_id, _only_valid)\
-	for (_root = tdp_mmu_next_root(_kvm, NULL, _only_valid);	\
-	     ({ lockdep_assert_held(&(_kvm)->mmu_lock); }), _root;	\
-	     _root = tdp_mmu_next_root(_kvm, _root, _only_valid))	\
-		if (kvm_mmu_page_as_id(_root) != _as_id) {		\
+#define __for_each_tdp_mmu_root_yield_safe(_kvm, _root, _as_id, _only_valid)	\
+	for (_root = tdp_mmu_next_root(_kvm, NULL, _only_valid);		\
+	     ({ lockdep_assert_held(&(_kvm)->mmu_lock); }), _root;		\
+	     _root = tdp_mmu_next_root(_kvm, _root, _only_valid))		\
+		if (_as_id >= 0 && kvm_mmu_page_as_id(_root) != _as_id) {	\
 		} else
 
 #define for_each_valid_tdp_mmu_root_yield_safe(_kvm, _root, _as_id)	\
@@ -171,10 +171,10 @@ static struct kvm_mmu_page *tdp_mmu_next_root(struct kvm *kvm,
  * Holding mmu_lock for write obviates the need for RCU protection as the list
  * is guaranteed to be stable.
  */
-#define for_each_tdp_mmu_root(_kvm, _root, _as_id)			\
-	list_for_each_entry(_root, &_kvm->arch.tdp_mmu_roots, link)	\
-		if (kvm_lockdep_assert_mmu_lock_held(_kvm, false) &&	\
-		    kvm_mmu_page_as_id(_root) != _as_id) {		\
+#define for_each_tdp_mmu_root(_kvm, _root, _as_id)				\
+	list_for_each_entry(_root, &_kvm->arch.tdp_mmu_roots, link)		\
+		if (kvm_lockdep_assert_mmu_lock_held(_kvm, false) &&		\
+		    _as_id >= 0 && kvm_mmu_page_as_id(_root) != _as_id) {	\
 		} else
 
 static struct kvm_mmu_page *tdp_mmu_alloc_sp(struct kvm_vcpu *vcpu)
-- 
2.43.0.275.g3460e3d667-goog


