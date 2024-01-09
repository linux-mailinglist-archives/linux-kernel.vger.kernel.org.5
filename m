Return-Path: <linux-kernel+bounces-21495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D54E829073
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35C71C25065
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F57640BE2;
	Tue,  9 Jan 2024 23:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M18ySga2"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0973FE40
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 23:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5e617562a65so62483757b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 15:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704841384; x=1705446184; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=9LjGHaNIdIg3QzaGl/5dN2VdX2yHsiBWEBAmyUKtKyQ=;
        b=M18ySga2NGEfEhXdZvYUV5WBQGUXvJYOvVKexifeubFL2aUcYTpzQIumClEdZaInPh
         cWexXOZJ0MROf3lrySaPfo9xl5oGeU7snZA5Wm4vSzJGHyaDcb6L4wvm8bUDVuZvZsLe
         cM7o9Imfn4ZnU7oSvGvcmRmoMlmfUWP4oGTArbR7JyDI+j0Ayn4wfEzXY6fziQ2GI0y1
         lbmI9vWXXc602neoQprGchbRuEFUrWpyVDPEduCRvS937O14RZ69g5xC/nJXiWvIsWi8
         Sk4khaJFqASNIBp2SBKCbHMr4KpmGQdxdzKwQACZSc13tEBzTLGGVjfFYI2N4KMHj9xP
         L5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704841384; x=1705446184;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9LjGHaNIdIg3QzaGl/5dN2VdX2yHsiBWEBAmyUKtKyQ=;
        b=icgT01leFRriTEh6qbe2N8TSSXHVNbnrwmohcIsSWveeWH8v3Chek+lWmfiuJDKmyq
         qxRNXHk4L7mw1UwAyk2j96atM0SqIiBiWiuuulxm+RTV14tCLjB8v8K7YKBuC/D8R/AZ
         mV8C6lkhLvNphrENpr81bhXTqyAOM1uz0Bq9ONPucd+tWAkozvGRJiDcsdSa4T9iX0qY
         TJCAid6cOb0wpB3+ljx6m4R5PnwSFXLBP37qNsxldGwG0628afm0vf19BGuP787bXK5P
         om/jAYK6YE/Zar9npL56ys+p8G12gTtzdaOn2YS11mW0NeLHxYysJC9rLkRkgQAVfvUA
         ITZg==
X-Gm-Message-State: AOJu0YwQ7RWNdy4G8AMGeSRtVmvDr3PzsmTpjkeWcZar1KJUcXYDwsD1
	mYwLWD6mPMKbOfw4hijEUw69Ee8ZYGt7pnx+Lw==
X-Google-Smtp-Source: AGHT+IFFObObKoJ49JR0BCouG9QCxKOm8CG719bWT5WdSBNFPxsFOzY42TX2XHmhAWqxO4qZBMlbLn3e+8I=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:3702:b0:5e5:5bfa:8257 with SMTP id
 fv2-20020a05690c370200b005e55bfa8257mr121585ywb.9.1704841384589; Tue, 09 Jan
 2024 15:03:04 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  9 Jan 2024 15:02:26 -0800
In-Reply-To: <20240109230250.424295-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240109230250.424295-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240109230250.424295-7-seanjc@google.com>
Subject: [PATCH v10 06/29] KVM: x86/pmu: Don't ignore bits 31:30 for RDPMC
 index on AMD
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kan Liang <kan.liang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Jim Mattson <jmattson@google.com>, Jinrong Liang <cloudliang@tencent.com>, 
	Aaron Lewis <aaronlewis@google.com>, Like Xu <likexu@tencent.com>
Content-Type: text/plain; charset="UTF-8"

Stop stripping bits 31:30 prior to validating/consuming the RDPMC index on
AMD.  Per the APM's documentation of RDPMC, *values* greater than 27 are
reserved.  The behavior of upper bits being flags is firmly Intel-only.

Fixes: ca724305a2b0 ("KVM: x86/vPMU: Implement AMD vPMU code for KVM")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/pmu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 1475d47c821c..1fafc46f61c9 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -77,8 +77,6 @@ static bool amd_is_valid_rdpmc_ecx(struct kvm_vcpu *vcpu, unsigned int idx)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 
-	idx &= ~(3u << 30);
-
 	return idx < pmu->nr_arch_gp_counters;
 }
 
@@ -86,7 +84,7 @@ static bool amd_is_valid_rdpmc_ecx(struct kvm_vcpu *vcpu, unsigned int idx)
 static struct kvm_pmc *amd_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
 	unsigned int idx, u64 *mask)
 {
-	return amd_pmc_idx_to_pmc(vcpu_to_pmu(vcpu), idx & ~(3u << 30));
+	return amd_pmc_idx_to_pmc(vcpu_to_pmu(vcpu), idx);
 }
 
 static struct kvm_pmc *amd_msr_idx_to_pmc(struct kvm_vcpu *vcpu, u32 msr)
-- 
2.43.0.472.g3155946c3a-goog


