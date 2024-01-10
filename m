Return-Path: <linux-kernel+bounces-21629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA61829218
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 02:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43E2B28A1EF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 01:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94395DDD5;
	Wed, 10 Jan 2024 01:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="usPyjKfz"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA08C8F5B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 01:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5c17cff57f9so1553631a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 17:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704850034; x=1705454834; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=iBBhsVReFdkY5Qcu4g5Me7VWeVaRdBMAkHcGlOP8ClI=;
        b=usPyjKfzpYYa6kyMLj88WwG3q5VDQRhqbd27V4H9+oZI0jM/4D6/lM8onS7JwQL+Ll
         7+36bkBlEVwVjTzg7vI6E+eMKrMEACdJZUv26vN4heuFJh+F46ZGK93dU8oWMz1uxtQA
         Iq7ZP7AeYSBizmKZeDzwmWYI/WV9Yl7mYWWwY3JxRUGnj0taTY5Hbg40Zg/vNTT1f488
         zUWwGvShCAaalkJmwFlSRW48Ftlp50cM9wmBgI5aaNwUzRKPewATgik+FzprBXI8Bpt+
         6kerwMsAJmRu5VVlriUUtrG+BGiE07I2tvVSvqOwalHVzb4F/TOQjwNoDIsmDzgSG4Hg
         Mj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704850034; x=1705454834;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iBBhsVReFdkY5Qcu4g5Me7VWeVaRdBMAkHcGlOP8ClI=;
        b=pHDzKao5SLU+2hMQ3GqlxY7zzdRdOWc6VcRTcv5QXWeR1GWDEMPe8LyfH8c3ef+CXz
         TMSyfyt0Cq+uTKKiT9Mnof2DDlVfiDSYsUDnHC3MIOzBbRDFOtv2wS5dRO8lH8XxFatb
         t7o8bYukvNPEv+rygc8by/OrssfnwcwYws1FX5NdpjffAs3KTpuec9/kYLHkaTiDnyMa
         iNYqp5K8ojHS7wMXYGJkFXbGM8jyOLYoJPguLiOjwIKHuK08AtDO7+b+TLjiPMtle7DO
         5WLg8kB+Xt7NSSRvopTUjkXWtzm8LZwi+rWOnh0p4wyU3eAUUfzXj78/5tduiTpvVU3o
         igMg==
X-Gm-Message-State: AOJu0YwkBBanUS2GAZXFiseTc39It10LAvOgKuBbkIfW4YooFeuzN5xR
	Po+g/jOnY2gwdGs7ahaiF0VI7KZBoYkp65pXXQ==
X-Google-Smtp-Source: AGHT+IGlaUnQVcKuEIDin5adhGbNb0XYaNcIuk3AJ4BTPw2pEqhR7hpu7dF0Yycp6qIdFD8Y6Dk+Ty/yXM8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:9554:0:b0:5ca:450e:25cb with SMTP id
 t20-20020a639554000000b005ca450e25cbmr849pgn.6.1704850033419; Tue, 09 Jan
 2024 17:27:13 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  9 Jan 2024 17:27:02 -0800
In-Reply-To: <20240110012705.506918-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240110012705.506918-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240110012705.506918-4-seanjc@google.com>
Subject: [PATCH 3/6] KVM: VMX: Handle forced exit due to preemption timer in fastpath
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Handle VMX preemption timer VM-Exits due to KVM forcing an exit in the
exit fastpath, i.e. avoid calling back into handle_preemption_timer() for
the same exit.  There is no work to be done for forced exits, as the name
suggests the goal is purely to get control back in KVM.

In addition to shaving a few cycles, this will allow cleanly separating
handle_fastpath_preemption_timer() from handle_preemption_timer(), e.g.
it's not immediately obvious why _apparently_ calling
handle_fastpath_preemption_timer() twice on a "slow" exit is necessary:
the "slow" call is necessary to handle exits from L2, which are excluded
from the fastpath by vmx_vcpu_run().

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 4caad881d9a0..c4a10d46d7a8 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6003,12 +6003,15 @@ static fastpath_t handle_fastpath_preemption_timer(struct kvm_vcpu *vcpu)
 	if (unlikely(vmx->loaded_vmcs->hv_timer_soft_disabled))
 		return EXIT_FASTPATH_REENTER_GUEST;
 
-	if (!vmx->req_immediate_exit) {
-		kvm_lapic_expired_hv_timer(vcpu);
-		return EXIT_FASTPATH_REENTER_GUEST;
-	}
+	/*
+	 * If the timer expired because KVM used it to force an immediate exit,
+	 * then mission accomplished.
+	 */
+	if (vmx->req_immediate_exit)
+		return EXIT_FASTPATH_EXIT_HANDLED;
 
-	return EXIT_FASTPATH_NONE;
+	kvm_lapic_expired_hv_timer(vcpu);
+	return EXIT_FASTPATH_REENTER_GUEST;
 }
 
 static int handle_preemption_timer(struct kvm_vcpu *vcpu)
-- 
2.43.0.472.g3155946c3a-goog


