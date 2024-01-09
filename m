Return-Path: <linux-kernel+bounces-21514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EB282909F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4673B1C24FD9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B338B4C60F;
	Tue,  9 Jan 2024 23:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1VWWrcEW"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B3B4C3A8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 23:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5f6c12872fbso53394627b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 15:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704841423; x=1705446223; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=GBHZvvbKUxYIR94IFblpt9Vgo5x0HhpKHQKHcFpIvzk=;
        b=1VWWrcEW0uqzCBmnm9VaWWbNc4pHzgy049j7kKTYmaEO/fIPGK2/K1VnAG8i5g0TaP
         9nBN49LSQmiggLSh2W0QygAFLRZYHTrXkPPrN4ckA9WcB5UnZB0BjpgS5pAZBpGbIhAZ
         ih8OMOnl/t9KcQikLk9Gm2rXjlh328HmVTE4m0m6FYEsggMUT80brnWwZWLYUCREC51z
         LqHiqkAyjJJmw9SkEJZQTuAo0nFqrzUabGcDKFBbjOpM+oNeZCdL0DjTIAwPeo4k8bzM
         sXQ0wh8FmWHBoSFC12K1xtVeKM4rVIge5DouycXyrR/W+Eis1f4t615JYQ3ipyc1TnPn
         GuTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704841423; x=1705446223;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GBHZvvbKUxYIR94IFblpt9Vgo5x0HhpKHQKHcFpIvzk=;
        b=G+B4k5VQn4IJBB2iJPHO+Qjrt+/Z7To7/xmPUtTZiZsgq5wEHJMiwA2kEAg4PFReej
         PFuOWq+0HhRpV43En+nsuPHKPYVzgZl5IhBhOPazMxkYd1MX1SP8uTRt/aYPnpq7UOB4
         NcKzRPR5MAkdpn+IRiZlHDt63QzgMV9lfP4oKmRF+0QCFKKXTDzs/j3r2Vo4oSFC9qVt
         on8b2PdZpu/OgWd5hOYlcqyUkzjHmn1M7QNoLvbZ8Fj3opGtBUYTt7M+IQU30t8aUiVr
         7152ALe0AJKM6bWA30ZPgnMeQM185txwLlbLdP+Qz6oYEGN1MiHAMma2UsJHjKqA7Bra
         oang==
X-Gm-Message-State: AOJu0YyDBxYwQ4WIvw2rBMivt+heuF5r4pbT4RYbEvXkYNWW3SBqpIPc
	p7OtYF113YYUpkESgV+XVHhNx6qzcfXO5uf6pg==
X-Google-Smtp-Source: AGHT+IERuwxDjrQAQv1weIwGckuOEgEz3Oq4Fpy6arL8duIdZYFULCn1Df8JQWeqeoI6t/qcbPRIMl7DCgU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:3384:b0:5e9:358e:2cb6 with SMTP id
 fl4-20020a05690c338400b005e9358e2cb6mr105069ywb.10.1704841422890; Tue, 09 Jan
 2024 15:03:42 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  9 Jan 2024 15:02:45 -0800
In-Reply-To: <20240109230250.424295-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240109230250.424295-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240109230250.424295-26-seanjc@google.com>
Subject: [PATCH v10 25/29] KVM: selftests: Move KVM_FEP macro into common
 library header
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kan Liang <kan.liang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Jim Mattson <jmattson@google.com>, Jinrong Liang <cloudliang@tencent.com>, 
	Aaron Lewis <aaronlewis@google.com>, Like Xu <likexu@tencent.com>
Content-Type: text/plain; charset="UTF-8"

Move the KVM_FEP definition, a.k.a. the KVM force emulation prefix, into
processor.h so that it can be used for other tests besides the MSR filter
test.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/x86_64/processor.h       | 3 +++
 tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index d211cea188be..6be365ac2a85 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -23,6 +23,9 @@
 extern bool host_cpu_is_intel;
 extern bool host_cpu_is_amd;
 
+/* Forced emulation prefix, used to invoke the emulator unconditionally. */
+#define KVM_FEP "ud2; .byte 'k', 'v', 'm';"
+
 #define NMI_VECTOR		0x02
 
 #define X86_EFLAGS_FIXED	 (1u << 1)
diff --git a/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c b/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c
index 9e12dbc47a72..ab3a8c4f0b86 100644
--- a/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c
+++ b/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c
@@ -12,8 +12,6 @@
 #include "kvm_util.h"
 #include "vmx.h"
 
-/* Forced emulation prefix, used to invoke the emulator unconditionally. */
-#define KVM_FEP "ud2; .byte 'k', 'v', 'm';"
 static bool fep_available;
 
 #define MSR_NON_EXISTENT 0x474f4f00
-- 
2.43.0.472.g3155946c3a-goog


