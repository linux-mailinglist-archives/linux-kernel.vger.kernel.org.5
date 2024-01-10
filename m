Return-Path: <linux-kernel+bounces-21619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B07308291FA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 02:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA3CCB25509
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 01:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59466D536;
	Wed, 10 Jan 2024 01:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dNK39BnQ"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765E98BEC
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 01:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5ce53c43ea1so1875461a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 17:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704849344; x=1705454144; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=zbNh1anpXzgsFYy2suczQuAt+Ip04T0QEkordwGV61Q=;
        b=dNK39BnQDGkIlFULkcyO6U/3u0XQ9ssRBGzme3nz6R5Cf2WtpRvqHSy6sJnnK9fwSI
         XF1V3hDCqxe5uePm0G9gR0dxEAPMt3BexdBMN9iyM9eWuJi7fodrsucO3kbAf5qMEoKe
         tl6YLYbIel1U5JIShD9ZMh6zs7Khvx/cjrDpbhL5+ZRoX2Cnqv6QAjOh4NCOiev3s+aT
         p2wV/tFI+J4+tHotCstSRcoaoFsANnkNIWtNl3VUJIDJW8Yvbp5cymoPRHFd6F+Dwk7V
         UIFlWdyr2KiD4gzhMsRhxnoYqay5O/DTE+qhC2QSFev1A9aZ34Qxgy6Y7owHgY2Lxkrl
         yd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704849344; x=1705454144;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zbNh1anpXzgsFYy2suczQuAt+Ip04T0QEkordwGV61Q=;
        b=WrPMqWiZkrgoaF1jJRjcE/zbfZDy5BrrYfP3ioDSHG/i+d3ByvRJF0Yr5aAiHC82Uu
         rYm+1uYkyzEEbUoT7NbKt8S5ZRCXAl172ckC1tj0MgBeEh+ZjoCurd6IL+ai02tT/TmC
         vDZFbgHYYrzByn2UdmxBWBFzDEc2OyA4cDsTdaIPw/U79/HTTbVlGs97WFG2lkigm2mt
         1DaPIj1dWAC/5A1/uegdqcqnxItz3XBFaozXhNH+FBMCopAg1gxyhvEbZxfotbO7oHL6
         HVehZoQ2eIL2Cq7KbhdIdiRMiqmI54cBuZaQgT0ilX8fASRhwTCM0XrHYMt9ERlFeka5
         9zVA==
X-Gm-Message-State: AOJu0YzD68oLqCaVkglsz4PiOJ56k2nxZoe2v3wUujLbbTw4ahuSDL8d
	9+eT0tjoGeauzwqmp/cjxFbtKmf/i3fZ4HLqlw==
X-Google-Smtp-Source: AGHT+IFipzkMiu6A+DPGq7lS055oPto9adZ9Nwk3nmTujL2ZM2JT8bTuRRSR5BbyhjvU4hLC+1cHheBO0wI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:dacc:b0:1d3:d9c2:225a with SMTP id
 q12-20020a170902dacc00b001d3d9c2225amr1322plx.7.1704849343802; Tue, 09 Jan
 2024 17:15:43 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  9 Jan 2024 17:15:33 -0800
In-Reply-To: <20240110011533.503302-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240110011533.503302-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240110011533.503302-5-seanjc@google.com>
Subject: [PATCH 4/4] KVM: Nullify async #PF worker's "apf" pointer as soon as
 it might be freed
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Nullify the async #PF worker's local "apf" pointer immediately after the
point where the structure can be freed by the vCPU.  The existing comment
is helpful, but easy to overlook as there is no associated code.

Update the comment to clarify that it can be freed by as soon as the lock
is dropped, as "after this point" isn't strictly accurate, nor does it
help understand what prevents the structure from being freed earlier.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/async_pf.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/virt/kvm/async_pf.c b/virt/kvm/async_pf.c
index c3f4f351a2ae..1088c6628de9 100644
--- a/virt/kvm/async_pf.c
+++ b/virt/kvm/async_pf.c
@@ -83,13 +83,14 @@ static void async_pf_execute(struct work_struct *work)
 	apf->vcpu = NULL;
 	spin_unlock(&vcpu->async_pf.lock);
 
-	if (!IS_ENABLED(CONFIG_KVM_ASYNC_PF_SYNC) && first)
-		kvm_arch_async_page_present_queued(vcpu);
-
 	/*
-	 * apf may be freed by kvm_check_async_pf_completion() after
-	 * this point
+	 * The apf struct may freed by kvm_check_async_pf_completion() as soon
+	 * as the lock is dropped.  Nullify it to prevent improper usage.
 	 */
+	apf = NULL;
+
+	if (!IS_ENABLED(CONFIG_KVM_ASYNC_PF_SYNC) && first)
+		kvm_arch_async_page_present_queued(vcpu);
 
 	trace_kvm_async_pf_completed(addr, cr2_or_gpa);
 
-- 
2.43.0.472.g3155946c3a-goog


