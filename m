Return-Path: <linux-kernel+bounces-155601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B5B8AF4AE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D9D28933A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B375313D627;
	Tue, 23 Apr 2024 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rtPE/21M"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786C313E032
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 16:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713891220; cv=none; b=Mcxbh1VXUO+nva3QI7PI9vdm713TA7vl9DPmnq0zFucnwcIVnGvcoEtgEV+q4rXBpBX91sAHvqmThYiEmFn4TAxmnRfnuP+Y4szi5UFds3eLTdEK3T1S+5xQj8RjMUtJl6nv04ultDwFv5k+fNikntl4Y6wkfM8zWvs/Ixi7YF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713891220; c=relaxed/simple;
	bh=F6jaJv52CDprALPzgiY8c/9fYHL9o+SM83T+9ypBoLM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pAm73eusFwKoRjRdmMOH1mk6vRh4PA1Dt9RG/1uIRAE32ru1xFzeRNmOJaBPz844uCu1pRkNB1ELlGks/P9coHGOFchQzJjNWuHHNf8GVEAvlTXWqGIVYgeBRujFmulneMfYK3P4rQBdSLeC0qPasT1mEKS8UvqCUl+WBiNd0ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rtPE/21M; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6188040f3d2so122426417b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 09:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713891216; x=1714496016; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=sV9yNB6aR8W90fYMIdgt/s8o7GSizOulqAtOjmc/hB4=;
        b=rtPE/21MiptS2MvgASuGbodmcY5nlHuZ+1sB3J/zzGr0tfGryJFjx1HacGf8AhAhya
         YAfIH9TOjpgsqdhgFW2RfOMny0bO6DZuM6emVJLXum5BWcl+r4x7tn5BS5hIU4LlWf6g
         7PkfcK+Le8ajAIoT4UzlaU28C8Xncb/x+fREVYhAHk1Yn43B3HHjsB9OCpTGD8EUTKDY
         eyNB91vhXTL5cBvL2Ar9mUldsQNe/05FR1rI0U/xZ/SHfXEeayO5uaCq4ZCY24LpbrE2
         gBtdVpsPwxEl0LZERIid/W+aiaIHbhwuydLOj1hkY9wkBg0jOwBR4tvlVV6aSAufTjKI
         huaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713891216; x=1714496016;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sV9yNB6aR8W90fYMIdgt/s8o7GSizOulqAtOjmc/hB4=;
        b=MJZ1KcK5wwKCfCnwOshR59BBPlyovdDWdA1n8XOMA2KdKYadM+SEDJKz7785O+97KI
         Bu7Sdl+xxIDJYiVl0Mqvtf+kyIy+AE0PWnoMKglIeWuW+DUHHNKPQk7UYyNVSpTUvSNj
         N+L1s2DbtxPB2vv1BFocU5ENsUnukewTzrhLmzmEHsmMK5aKYjVZaCLOUC+cf/7TzEfc
         mRksWBsUIkU9ZHBac6YkURqZKo8tKqHzBpX0kNCRfi2P5rV3so9uBnIg8ot4zF4Vmh4O
         S6cdclxYXyONFS/DM3+5Soa6IuTZ9JiDr09e/YsC84yn7vuvNYgCF7SlrHTVZTHym1ZG
         OZiw==
X-Forwarded-Encrypted: i=1; AJvYcCWUYIZh+WKvjPDXwkr9xaq7C4Sc0MJRCp0Or5e9LL0X2pj9C0kLmb8ycPPrOiAKXOEtiwBS68kR9F0/egVnZdQHrjogHxc0ljnu3wJu
X-Gm-Message-State: AOJu0YwKH4ylu0dJuPMCegmGlTYhPkAKWWtlt48QgSBFWMWePEfffdG7
	UTaChmnKu4snWsTLD1J2hzs5N1jrdq10z+zUT5psmat5JkfcKNYvPMWrfGJciALc/pG5UqaK8BI
	KtQ==
X-Google-Smtp-Source: AGHT+IEKtvFjeB+RwGhO/xxjR9keN4d9sjRQVzhkBfwnys03punNsGEp7Y1n5s+Kg7LT6FmELNYfr5dM7rE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:10c2:b0:dd9:3a6b:11f8 with SMTP id
 w2-20020a05690210c200b00dd93a6b11f8mr38570ybu.5.1713891216480; Tue, 23 Apr
 2024 09:53:36 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 23 Apr 2024 09:53:28 -0700
In-Reply-To: <20240423165328.2853870-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240423165328.2853870-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240423165328.2853870-4-seanjc@google.com>
Subject: [PATCH 3/3] KVM: x86: Explicitly zero kvm_caps during vendor module load
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Zero out all of kvm_caps when loading a new vendor module to ensure that
KVM can't inadvertently rely on global initialization of a field, and add
a comment above the definition of kvm_caps to call out that all fields
needs to be explicitly computed during vendor module load.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 44ce187bad89..8f3979d5fc80 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -92,6 +92,11 @@
 #define MAX_IO_MSRS 256
 #define KVM_MAX_MCE_BANKS 32
 
+/*
+ * Note, kvm_caps fields should *never* have default values, all fields must be
+ * recomputed from scratch during vendor module load, e.g. to account for a
+ * vendor module being reloaded with different module parameters.
+ */
 struct kvm_caps kvm_caps __read_mostly;
 EXPORT_SYMBOL_GPL(kvm_caps);
 
@@ -9755,6 +9760,8 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 		return -EIO;
 	}
 
+	memset(&kvm_caps, 0, sizeof(kvm_caps));
+
 	x86_emulator_cache = kvm_alloc_emulator_cache();
 	if (!x86_emulator_cache) {
 		pr_err("failed to allocate cache for x86 emulator\n");
-- 
2.44.0.769.g3c40516874-goog


