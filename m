Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD38C8018A3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 01:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441989AbjLBAGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 19:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442124AbjLBAFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 19:05:41 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD2F199F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 16:05:13 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5c87663a873so39602697b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 16:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701475513; x=1702080313; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=sn5K0TUz/ND3xDsLXUagKvVZbAXVyeU2LAAk3nLknAQ=;
        b=je2wEPOphLZAZjfRFJNa2KF5G1I4U0vFNbnTo2yoPrB2K8cpdwT9P/oOWhZTPaw28n
         uQhAAY9AC9BJWydnxGtq5mx6FTmg/V5USlEPqI0eejjscvipmMKPFGt03BHraLShbQoP
         BTEE3n+cOLBPLNd7mpE69gTUf7op+PrbpomO94yyvcqrN9Kl7OsGikkkfOMsnCu2XKoh
         au55mTq38RQENeuktx7odaQq9lh3R+ZZ82eG3Mgh4MRh9C2t0WB358rDnibvG8jgt25g
         0VRtVNx9YzSmVRmnp4M/OMojZmyoWBmLeDsAl1W0av6WKqF9gygN8wv2xg3NfuXG3bwt
         RdPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701475513; x=1702080313;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sn5K0TUz/ND3xDsLXUagKvVZbAXVyeU2LAAk3nLknAQ=;
        b=EsD3CZeEoU00PV7bY3mQ+FcPbQ1gCCtUXumttlR4eKdlqE4G1oqO8ZKiR1sbKZXvzR
         Bqq/FFEsbPGzt1H19jE0Ghkjycb3MBGJhqvj2AS/eeJeGpG7zAbmluI2ZMMTZkIMfqbZ
         WV3YKzw/1BKQn1WYdOaGVZY2sQUWTxs3IqBrnsKRFt+M+cj9YgzWk+QUEe30e7Vtzy68
         ijCt0Vziin0zoOdeSAiB/HrKj5sZWT4U9QZOpxhZB2zsgo7VgPoP1xAf//dosy67HU0L
         zpOeZcyhE6ir6F15/dmUAWt3qtmU/lza90po+WECQ0vTo1Hc6YD5G/hoK8J9wULTP685
         8eZw==
X-Gm-Message-State: AOJu0YxFkalzKG0D3IifnWQoOUlxys1FgbNdVMHoqNiICCWfJcGBXMNT
        B/ZsMrZRH0rRGs/O/cAd1lcZ1jEI1pc=
X-Google-Smtp-Source: AGHT+IGU5VUK2zTQkg8a/XGiiJ4Q3YoMqy7bJoHyeFwrZZ6a/+7kCqG4KfTBQRJGcM+jcjHoD9/fRhNhGkk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:d6d1:0:b0:db7:dce9:76d3 with SMTP id
 n200-20020a25d6d1000000b00db7dce976d3mr11991ybg.9.1701475512974; Fri, 01 Dec
 2023 16:05:12 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  1 Dec 2023 16:04:16 -0800
In-Reply-To: <20231202000417.922113-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231202000417.922113-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231202000417.922113-28-seanjc@google.com>
Subject: [PATCH v9 27/28] KVM: selftests: Add helpers for safe and safe+forced
 RDMSR, RDPMC, and XGETBV
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Jim Mattson <jmattson@google.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Like Xu <likexu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
2.43.0.rc2.451.g8631bc7472-goog

