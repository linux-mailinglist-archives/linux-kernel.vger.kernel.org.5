Return-Path: <linux-kernel+bounces-21517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0708290A6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0C941C250DD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FF64CE1D;
	Tue,  9 Jan 2024 23:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ST4c0qte"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AFC4CB5B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 23:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-28bd4766346so1866247a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 15:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704841428; x=1705446228; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=08OoRr/gbTB9xGNdl1frY+t6wa0iZxEBlExGG+2stds=;
        b=ST4c0qteUlWOfrfQ0hqN9mQanQILL4cysEKvUDw6TSJZSe74lt3s20RpQIZSurzrJV
         VS2f6bQM4PI8xQsc8NwO1n4tsbdcPYbjpb0O3+Ot/NXsSFW94HW8OJYXI6TMgdNn3WE3
         v0QcQfDch20WguMX+3uwt4cfpNBy2NdF0adZ5ebaQQYbil5SoSGGbvpTd9cl9LLEAUev
         HjwY3LrFKTDx96Gr0tglVP7G4QbBBKcop6TbMgvpjNnfrARJ2Q/5fDV6iqzPnuoW/srU
         xzY8tOnyoFJvUZXmH+OSSztM+MzzbBNJUmVwyl4dj31St+GpT4y512qp149kKUGaiDYT
         r3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704841428; x=1705446228;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=08OoRr/gbTB9xGNdl1frY+t6wa0iZxEBlExGG+2stds=;
        b=h13eYAip+R76whLOI5Sny54Pozxa/QJP4xvckWKEFLag3K/pXsOqMLDIqeY2azVr5O
         8agbIaYwqiofd0dqO1O+yUpV601Wd1zg4uuWoPvBDZ4kMp+poIK7eIdEeLEUo1apjny8
         drhsgGaqFmlQ1jlyZK4/i5xB7ZMMK2K59iDsbdBP/gQZnHyd3tvcTvT4VeG6o9yT6qaI
         Bwbr9T3yJ0bv/PnAOSsULiZ8EWa5s5Aos6w7h1FH7/Psl5ccUItvRL8NxXevbNP+GyRs
         ZdbdiwKp2aUc4sV3bAC1ULwKaM+dLJJoHn95q0Ux/OjdWa/EVSHEe03F/EAx9Bqj4eUh
         d6hQ==
X-Gm-Message-State: AOJu0YysVuJyGXfjicYDsGfIIrvQKl/E19yS5FuJNQRqgXG+EGISF2EB
	F6H9Y4Ase8xXK1xcxRr0gVNWQYSeR7uBAwSq0Q==
X-Google-Smtp-Source: AGHT+IETKsJXOUZ8pmBB5saZkiKhZnJWFfGpi9h9YTd5Unqj4jQonc/7ucRrblymqMDdM0uxsscoIY97xDc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:4aca:b0:28d:28f5:9b5e with SMTP id
 mh10-20020a17090b4aca00b0028d28f59b5emr407pjb.0.1704841428700; Tue, 09 Jan
 2024 15:03:48 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  9 Jan 2024 15:02:48 -0800
In-Reply-To: <20240109230250.424295-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240109230250.424295-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240109230250.424295-29-seanjc@google.com>
Subject: [PATCH v10 28/29] KVM: selftests: Add helpers for safe and
 safe+forced RDMSR, RDPMC, and XGETBV
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kan Liang <kan.liang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Jim Mattson <jmattson@google.com>, Jinrong Liang <cloudliang@tencent.com>, 
	Aaron Lewis <aaronlewis@google.com>, Like Xu <likexu@tencent.com>
Content-Type: text/plain; charset="UTF-8"

Add helpers for safe and safe-with-forced-emulations versions of RDMSR,
RDPMC, and XGETBV.  Use macro shenanigans to eliminate the rather large
amount of boilerplate needed to get values in and out of registers.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/x86_64/processor.h  | 40 +++++++++++++------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index fe891424ff55..abac816f6594 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -1216,21 +1216,35 @@ void vm_install_exception_handler(struct kvm_vm *vm, int vector,
 	vector;								\
 })
 
-static inline uint8_t rdmsr_safe(uint32_t msr, uint64_t *val)
-{
-	uint64_t error_code;
-	uint8_t vector;
-	uint32_t a, d;
-
-	asm volatile(KVM_ASM_SAFE("rdmsr")
-		     : "=a"(a), "=d"(d), KVM_ASM_SAFE_OUTPUTS(vector, error_code)
-		     : "c"(msr)
-		     : KVM_ASM_SAFE_CLOBBERS);
-
-	*val = (uint64_t)a | ((uint64_t)d << 32);
-	return vector;
+#define BUILD_READ_U64_SAFE_HELPER(insn, _fep, _FEP)			\
+static inline uint8_t insn##_safe ##_fep(uint32_t idx, uint64_t *val)	\
+{									\
+	uint64_t error_code;						\
+	uint8_t vector;							\
+	uint32_t a, d;							\
+									\
+	asm volatile(KVM_ASM_SAFE##_FEP(#insn)				\
+		     : "=a"(a), "=d"(d),				\
+		       KVM_ASM_SAFE_OUTPUTS(vector, error_code)		\
+		     : "c"(idx)						\
+		     : KVM_ASM_SAFE_CLOBBERS);				\
+									\
+	*val = (uint64_t)a | ((uint64_t)d << 32);			\
+	return vector;							\
 }
 
+/*
+ * Generate {insn}_safe() and {insn}_safe_fep() helpers for instructions that
+ * use ECX as in input index, and EDX:EAX as a 64-bit output.
+ */
+#define BUILD_READ_U64_SAFE_HELPERS(insn)				\
+	BUILD_READ_U64_SAFE_HELPER(insn, , )				\
+	BUILD_READ_U64_SAFE_HELPER(insn, _fep, _FEP)			\
+
+BUILD_READ_U64_SAFE_HELPERS(rdmsr)
+BUILD_READ_U64_SAFE_HELPERS(rdpmc)
+BUILD_READ_U64_SAFE_HELPERS(xgetbv)
+
 static inline uint8_t wrmsr_safe(uint32_t msr, uint64_t val)
 {
 	return kvm_asm_safe("wrmsr", "a"(val & -1u), "d"(val >> 32), "c"(msr));
-- 
2.43.0.472.g3155946c3a-goog


