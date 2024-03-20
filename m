Return-Path: <linux-kernel+bounces-108283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 835A78808BC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D7B2B220A2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69ECDC132;
	Wed, 20 Mar 2024 00:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wF2u6Bwc"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E44D8F5A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 00:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710895840; cv=none; b=q4WlZrZPF/wOXHiJo/2pp4HswJ5AVOWxNZ+9kNBK31tly5UaFNn3liJHQkGdsTKZdJDiROsr00E+ypnJpFhJbN1VJt/hn8lGCL9Un8ly5e1oSGuw5DIgf6SGoIdugAIdsHrseGxbHEOr+BwxBTk0RKksM38divji1gVoIIT5ePk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710895840; c=relaxed/simple;
	bh=W0mOjtlu5f54bLTmPCZiIAQr5uTb3v00ZxlbrR8mWrE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sJWoQ3yx7mMziDchdEW5sZ+/4Y5F+IzKzONJEm5Nb2QQ9H1R5aUzPBRCc+DDsV2SqZiADFVNBT8q5JETxPfrZmErUMyOMUM3sK+im8ohqhfWk46lejKEsNx7b2CoeX5Ho5HJdoxsaz01YqCbiSBaS8EKcERlCvg/JPvcOPkOm0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wF2u6Bwc; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-610b83ff92bso62316807b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 17:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710895838; x=1711500638; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEyM3WpVtlcPduz6nOsAULxgTTwc2EHZ5Latop+Y9uo=;
        b=wF2u6BwcW3L7nfp7pGXhVxxnu7ehekCKu8wa9WTfDLS+Rdb1R1gkb9GEgxfqFe5Eqq
         1y0vEDWfEir529+lR/0Ai1sfrAcNvzP0ykano21Rq6AB0PZvM16EWu0rat4xxeTobPq8
         cYtplhEhvkueQu/qrPXEuntxfWSue4HZEF34GRbpNebkAwZbueOsI+8Dezbmlx2XPVek
         TqcwQkHZo4BSqXxYPhUNpBY/4UhQ739d9N1dJWFA4cTeFBk4VtfpbDMhkXlrQGaRg8io
         7m4I2VxVS1KiCPY2rYK4/cofh83ef3I9E5c5kGnFvr9JFE/AtNOlBfGEfOeTbz9dU4RU
         +LTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710895838; x=1711500638;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZEyM3WpVtlcPduz6nOsAULxgTTwc2EHZ5Latop+Y9uo=;
        b=qHPGYs5N/3xeDdaIZcOjNb3g9PT/2w+4hQ6wTcN91F0sBvj47VevQ7TgLb1F81XM2e
         JPsdCQJu7binnl9HV2fW23iyNoeqdDKoohhZ7jU41M28T+t/GJEhGGp3hvMENzcH6AeS
         HLerkWS8FWUU/lDAt+e7acx9BRD9k1gMsM4uAwD4pbL9s55FVZ4QHdtKxXx6q0I31OHO
         3Da6WdABUrN1vaJRITxcguJ9C97GnaHrs7DQUoBAwB32WUE64IQOB4MFeb5rPRIyJBoe
         6Z0gOXxv0MFZVSsSPCF4WUe4a3Zrof5CviaI/MC6cbTy0VfT3ISyh7+sxvLEDz3vnSIv
         DgNg==
X-Forwarded-Encrypted: i=1; AJvYcCWLWis/pSY0mwIWPh2dJUj3K0H8jg0gMLAK7L5G0eCJNhOr5rxy28w0uXozBAgdYI0BRFBzovg4rIrK5bHPnIQkHyBW0PfgDu9GNzvY
X-Gm-Message-State: AOJu0Yw7i3Mz3cvIvGKR4Ed34vyNtcTTikJH9TBb5r1ytenwQaX1X7pI
	gKzAygdCGJPcr+5L9QvX84di4clLDpErkr/Q9kKCUtlvnliAaXTURv1CWlb9b84OJ+ao5fa2Hyj
	9Xw==
X-Google-Smtp-Source: AGHT+IGvX6kMEJQVGFiJQPwTYc+9UFzG3TlVdYPiKT28fIxYPdRocSUe0xURLQF6VnlT10vdKJ1/SWO/KWA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:2203:b0:dbe:a0c2:df25 with SMTP id
 dm3-20020a056902220300b00dbea0c2df25mr888093ybb.8.1710895838254; Tue, 19 Mar
 2024 17:50:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 19 Mar 2024 17:50:21 -0700
In-Reply-To: <20240320005024.3216282-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240320005024.3216282-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240320005024.3216282-2-seanjc@google.com>
Subject: [RFC PATCH 1/4] KVM: x86/mmu: Skip the "try unsync" path iff the old
 SPTE was a leaf SPTE
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, David Matlack <dmatlack@google.com>, 
	David Stevens <stevensd@chromium.org>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"

Apply make_spte()'s optimization to skip trying to unsync shadow pages if
and only if the old SPTE was a leaf SPTE, as non-leaf SPTEs in direct MMUs
are always writable, i.e. could trigger a false positive and incorrectly
lead to KVM creating a SPTE without write-protecting or marking shadow
pages unsync.

This bug only affects the TDP MMU, as the shadow MMU only overwrites a
shadow-present SPTE when synchronizing SPTEs (and only 4KiB SPTEs can be
unsync).  Specifically, mmu_set_spte() drops any non-leaf SPTEs *before*
calling make_spte(), whereas the TDP MMU can do a direct replacement of a
page table with the leaf SPTE.

Opportunistically update the comment to explain why skipping the unsync
stuff is safe, as opposed to simply saying "it's someone else's problem".

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/spte.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index 4a599130e9c9..b4c1119cc48b 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -206,12 +206,20 @@ bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 		spte |= PT_WRITABLE_MASK | shadow_mmu_writable_mask;
 
 		/*
-		 * Optimization: for pte sync, if spte was writable the hash
-		 * lookup is unnecessary (and expensive). Write protection
-		 * is responsibility of kvm_mmu_get_page / kvm_mmu_sync_roots.
-		 * Same reasoning can be applied to dirty page accounting.
+		 * When overwriting an existing leaf SPTE, and the old SPTE was
+		 * writable, skip trying to unsync shadow pages as any relevant
+		 * shadow pages must already be unsync, i.e. the hash lookup is
+		 * unnecessary (and expensive).
+		 *
+		 * The same reasoning applies to dirty page/folio accounting;
+		 * KVM will mark the folio dirty using the old SPTE, thus
+		 * there's no need to immediately mark the new SPTE as dirty.
+		 *
+		 * Note, both cases rely on KVM not changing PFNs without first
+		 * zapping the old SPTE, which is guaranteed by both the shadow
+		 * MMU and the TDP MMU.
 		 */
-		if (is_writable_pte(old_spte))
+		if (is_last_spte(old_spte, level) && is_writable_pte(old_spte))
 			goto out;
 
 		/*
-- 
2.44.0.291.gc1ea87d7ee-goog


