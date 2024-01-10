Return-Path: <linux-kernel+bounces-21590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CBD82918B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 01:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B57F5282EFB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCA18F5A;
	Wed, 10 Jan 2024 00:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YZutqnol"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC8753A6
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 00:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-28c183f8205so4131316a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 16:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704847186; x=1705451986; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Pqe71wm1M+G2sxafHwJo+rZxz6yjUptaYMkbv+1aMM0=;
        b=YZutqnol1HrLWmrIvBtq9YKcUcRem3wQuRHt0Z6JPlQJdhkdkkIy6b0H1Novt9dfrw
         x3Y1+dfoAsXhqHNqwgbrnIiRlbJrc1EZam8ca79n9SxW1xiOyB/jpe0vrw2kSzE91B7u
         68QOdMNX6JKL3kBG7xhNoNfRph7JkNN9N6Do87ftmzaNsunYJBzQp7iEaDfW7t9SUP/I
         i3twlbvl2vaB70CY//4mX6SxTNsvZNX//3chVKTAw8c3k3CCWemLxE1nYOb0uQb0DkwQ
         zmJGzI7RlvjNTEOkWNt4KIEgXvGz/9cvXycDoWCuV8bse1qrm3bqFacrFtIUWnDFt3rd
         hUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704847186; x=1705451986;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pqe71wm1M+G2sxafHwJo+rZxz6yjUptaYMkbv+1aMM0=;
        b=ZUcjaq9oXAqYRG6nGpV/CS3N4EG8ndXde576AeO4VubeXRPkL0m5UajS1K2FbI66Ct
         093SS5WWia6BDIk6eon6XaWJTTXwsKm4eEwufupj5jEXMv0O7GowDI+CrbBz1Oq9JT1E
         qW3pYRIHMnFeQ5prfOM9Wz1RgMW7lms0x9vjThi2H+zRokUZ8jnwN9D+xi6VLnEIMm10
         hQ5Ti0bgSeAvWc1EA1UI1EGOqXltUw1dA8TVrdronYVAvIXr35UxThJ6qVydod/2IYLN
         oASlWwAHgL+I3vJy8SK37FusGW5aG1DNxvlXJTVYQ+YDaSfO1o77ni4na1v5Yow6CkG3
         xkNw==
X-Gm-Message-State: AOJu0Yx5j1xahQpfaxRqX72e+TN40Y/fhWLc/EO4JjlwrXiYAqyzN6U1
	f3zq1zouiEwAzC3jRJyeNHArRDBSrRGxxlCCBg==
X-Google-Smtp-Source: AGHT+IHy3G82NSplUegkyA2Eh3U1cZHYVq7yVh3SDYUhCqB4HtyzIO3xeq0bjWvyF5FfhYIa/SDY5MlL1wM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:38c2:b0:28b:4489:38fc with SMTP id
 nn2-20020a17090b38c200b0028b448938fcmr10289pjb.2.1704847186504; Tue, 09 Jan
 2024 16:39:46 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  9 Jan 2024 16:39:37 -0800
In-Reply-To: <20240110003938.490206-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240110003938.490206-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240110003938.490206-4-seanjc@google.com>
Subject: [PATCH 3/4] KVM: x86: Clean up directed yield API for "has pending interrupt"
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Like Xu <like.xu.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Directly return the boolean result of whether or not a vCPU has a pending
interrupt instead of effectively doing:

  if (true)
	return true;

  return false;

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 77494f9c8d49..b7996a75d9a3 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13083,11 +13083,8 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu)
 
 bool kvm_arch_dy_has_pending_interrupt(struct kvm_vcpu *vcpu)
 {
-	if (kvm_vcpu_apicv_active(vcpu) &&
-	    static_call(kvm_x86_dy_apicv_has_pending_interrupt)(vcpu))
-		return true;
-
-	return false;
+	return kvm_vcpu_apicv_active(vcpu) &&
+	       static_call(kvm_x86_dy_apicv_has_pending_interrupt)(vcpu);
 }
 
 bool kvm_arch_vcpu_preempted_in_kernel(struct kvm_vcpu *vcpu)
-- 
2.43.0.472.g3155946c3a-goog


