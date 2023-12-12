Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C0F80F863
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377449AbjLLUuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377428AbjLLUto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:49:44 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751BD2120
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:47:52 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5e19414f714so21999057b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702414071; x=1703018871; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9b8Rem1AmPjfYzBNcLPCGf0Ya+tJ/F2me7CGYJ1U7yY=;
        b=yUA+G3z7D9ewA7kk8Dj883hsjAJfjykoePzI01xOmdxe4tCxT4x+wG4cCLW2kAsBP6
         mNEKqhK1Ue5tt0sd2wrRQKvJGkJ+3XtIKdjNYmZERe9abuyCyWR2K7cpPRYP1EwdbXYI
         YZYczvg49rClwUzXxVXCWSHBqPzngwYLDaneTyuaVgAGKCZdaqzPbQKAD2XKTCpoZv4l
         VzODXpZUGHDDPmgurdSJUrbOJuzvPDVl2yUaDGhm9+T8lFnK7+RwUQLdfQi5motCyXBQ
         KFk1WB/o1hsOHQBaCRYeYosPA8cImlfQCVUtykOzQxYEvrUNlBJbOx2EHdgABigCU9et
         cdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702414071; x=1703018871;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9b8Rem1AmPjfYzBNcLPCGf0Ya+tJ/F2me7CGYJ1U7yY=;
        b=rK7na27k4mZ6X2l5L4HwYDfrORkzMSEKjEFjKCLJ4o+2+FMUqu2NSE/p8RLzWuTGQp
         CkjJcAOncAx07VSemI6SxtA8oTXtDBfRQvB8KatbYvoBn2QcvJ78/732vhot1wKCF0g8
         sCUzQBLY7zFtdXyS2rMFrvWfd9rMVhmuBHrBrcHBmJ9Yz0wAd2RhSiUmW6IQP/tVDnEU
         0/CTaFmIxszXOiNU7MeTKggamDGzYyprgCqrxovTzAUZp7xHU3yKtAePj5jhnM7yuyzG
         8BCoq+1CbICR+e0esH5/DyP2hy/4AEpmm28SUe/9Kmts/M9FMcATbO+Sbkkx11vqGzN8
         Z9mQ==
X-Gm-Message-State: AOJu0YwBjgJeOY1M4mDx9nyRNtPxH3wh8rK9pwU57mnMPWaBuZtaITca
        7HEwMjoHCyZjKjt5Ct8Tyk5TuaZUvQ==
X-Google-Smtp-Source: AGHT+IFxV+KrDYmcwmn1PDxvzNdlpDP4pWeOD1xeuiQDvWiuL5pZVy4R12KnOvAQ3fLYUpwzgPkXIIMt+Q==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a05:690c:891:b0:5d8:eec5:f57c with SMTP id
 cd17-20020a05690c089100b005d8eec5f57cmr64746ywb.4.1702414070805; Tue, 12 Dec
 2023 12:47:50 -0800 (PST)
Date:   Tue, 12 Dec 2023 12:46:44 -0800
In-Reply-To: <20231212204647.2170650-1-sagis@google.com>
Mime-Version: 1.0
References: <20231212204647.2170650-1-sagis@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231212204647.2170650-30-sagis@google.com>
Subject: [RFC PATCH v5 29/29] KVM: selftests: TDX: Add TDX UPM selftests for
 implicit conversion
From:   Sagi Shahar <sagis@google.com>
To:     linux-kselftest@vger.kernel.org,
        Ackerley Tng <ackerleytng@google.com>,
        Ryan Afranji <afranji@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Sagi Shahar <sagis@google.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Peter Gonda <pgonda@google.com>,
        Haibo Xu <haibo1.xu@intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Roger Wang <runanwang@google.com>,
        Vipin Sharma <vipinsh@google.com>, jmattson@google.com,
        dmatlack@google.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ackerley Tng <ackerleytng@google.com>

This tests the use of guest memory without explicit MapGPA calls.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/x86_64/tdx_upm_test.c       | 86 +++++++++++++++++--
 1 file changed, 77 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/tdx_upm_test.c b/tools/testing/selftests/kvm/x86_64/tdx_upm_test.c
index 44671874a4f1..bfa921f125a0 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_upm_test.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_upm_test.c
@@ -149,7 +149,7 @@ enum {
  * Does vcpu_run, and also manages memory conversions if requested by the TD.
  */
 void vcpu_run_and_manage_memory_conversions(struct kvm_vm *vm,
-					    struct kvm_vcpu *vcpu)
+					    struct kvm_vcpu *vcpu, bool handle_conversions)
 {
 	for (;;) {
 		vcpu_run(vcpu);
@@ -163,6 +163,13 @@ void vcpu_run_and_manage_memory_conversions(struct kvm_vm *vm,
 				!(vm->arch.s_bit & vmcall_info->in_r12));
 			vmcall_info->status_code = 0;
 			continue;
+		} else if (handle_conversions &&
+			vcpu->run->exit_reason == KVM_EXIT_MEMORY_FAULT) {
+			handle_memory_conversion(
+				vm, vcpu->run->memory_fault.gpa,
+				vcpu->run->memory_fault.size,
+				vcpu->run->memory_fault.flags == KVM_MEMORY_EXIT_FLAG_PRIVATE);
+			continue;
 		} else if (
 			vcpu->run->exit_reason == KVM_EXIT_IO &&
 			vcpu->run->io.port == TDX_UPM_TEST_ACCEPT_PRINT_PORT) {
@@ -243,8 +250,53 @@ static void guest_upm_explicit(void)
 	tdx_test_success();
 }
 
+static void guest_upm_implicit(void)
+{
+	struct tdx_upm_test_area *test_area_gva_private =
+		(struct tdx_upm_test_area *)TDX_UPM_TEST_AREA_GVA_PRIVATE;
+	struct tdx_upm_test_area *test_area_gva_shared =
+		(struct tdx_upm_test_area *)TDX_UPM_TEST_AREA_GVA_SHARED;
+
+	/* Check: host reading private memory does not modify guest's view */
+	fill_test_area(test_area_gva_private, PATTERN_GUEST_GENERAL);
+
+	tdx_test_report_to_user_space(SYNC_CHECK_READ_PRIVATE_MEMORY_FROM_HOST);
+
+	TDX_UPM_TEST_ASSERT(
+		check_test_area(test_area_gva_private, PATTERN_GUEST_GENERAL));
+
+	/* Use focus area as shared */
+	fill_focus_area(test_area_gva_shared, PATTERN_GUEST_FOCUS);
+
+	/* General areas should not be affected */
+	TDX_UPM_TEST_ASSERT(
+		check_general_areas(test_area_gva_private, PATTERN_GUEST_GENERAL));
+
+	tdx_test_report_to_user_space(SYNC_CHECK_READ_SHARED_MEMORY_FROM_HOST);
+
+	/* Check that guest has the same view of shared memory */
+	TDX_UPM_TEST_ASSERT(
+		check_focus_area(test_area_gva_shared, PATTERN_HOST_FOCUS));
+
+	/* Use focus area as private */
+	fill_focus_area(test_area_gva_private, PATTERN_GUEST_FOCUS);
+
+	/* General areas should be unaffected by remapping */
+	TDX_UPM_TEST_ASSERT(
+		check_general_areas(test_area_gva_private, PATTERN_GUEST_GENERAL));
+
+	tdx_test_report_to_user_space(SYNC_CHECK_READ_PRIVATE_MEMORY_FROM_HOST_AGAIN);
+
+	/* Check that guest can use private memory after focus area is remapped as private */
+	TDX_UPM_TEST_ASSERT(
+		fill_and_check(test_area_gva_private, PATTERN_GUEST_GENERAL));
+
+	tdx_test_success();
+}
+
 static void run_selftest(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
-			 struct tdx_upm_test_area *test_area_base_hva)
+			 struct tdx_upm_test_area *test_area_base_hva,
+			 bool implicit)
 {
 	vcpu_run(vcpu);
 	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
@@ -263,7 +315,7 @@ static void run_selftest(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
 	TEST_ASSERT(check_test_area(test_area_base_hva, PATTERN_CONFIDENCE_CHECK),
 		"Host should read PATTERN_CONFIDENCE_CHECK from guest's private memory.");
 
-	vcpu_run_and_manage_memory_conversions(vm, vcpu);
+	vcpu_run_and_manage_memory_conversions(vm, vcpu, implicit);
 	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
 	TDX_TEST_ASSERT_IO(vcpu, TDX_TEST_REPORT_PORT, TDX_TEST_REPORT_SIZE,
 		 TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
@@ -280,7 +332,7 @@ static void run_selftest(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
 	TEST_ASSERT(check_focus_area(test_area_base_hva, PATTERN_HOST_FOCUS),
 		    "Host should be able to use shared memory.");
 
-	vcpu_run_and_manage_memory_conversions(vm, vcpu);
+	vcpu_run_and_manage_memory_conversions(vm, vcpu, implicit);
 	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
 	TDX_TEST_ASSERT_IO(vcpu, TDX_TEST_REPORT_PORT, TDX_TEST_REPORT_SIZE,
 		 TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
@@ -329,18 +381,20 @@ static void guest_ve_handler(struct ex_regs *regs)
 	TDX_UPM_TEST_ASSERT(!ret);
 }
 
-static void verify_upm_test(void)
+static void verify_upm_test(bool implicit)
 {
 	struct kvm_vm *vm;
 	struct kvm_vcpu *vcpu;
 
+	void *guest_code;
 	vm_vaddr_t test_area_gva_private;
 	struct tdx_upm_test_area *test_area_base_hva;
 	uint64_t test_area_npages;
 
 	vm = td_create();
 	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
-	vcpu = td_vcpu_add(vm, 0, guest_upm_explicit);
+	guest_code = implicit ? guest_upm_implicit : guest_upm_explicit;
+	vcpu = td_vcpu_add(vm, 0, guest_code);
 
 	vm_install_exception_handler(vm, VE_VECTOR, guest_ve_handler);
 
@@ -379,13 +433,26 @@ static void verify_upm_test(void)
 
 	td_finalize(vm);
 
-	printf("Verifying UPM functionality: explicit MapGPA\n");
+	if (implicit)
+		printf("Verifying UPM functionality: implicit conversion\n");
+	else
+		printf("Verifying UPM functionality: explicit MapGPA\n");
 
-	run_selftest(vm, vcpu, test_area_base_hva);
+	run_selftest(vm, vcpu, test_area_base_hva, implicit);
 
 	kvm_vm_free(vm);
 }
 
+void verify_upm_test_explicit(void)
+{
+	verify_upm_test(false);
+}
+
+void verify_upm_test_implicit(void)
+{
+	verify_upm_test(true);
+}
+
 int main(int argc, char **argv)
 {
 	/* Disable stdout buffering */
@@ -397,5 +464,6 @@ int main(int argc, char **argv)
 		return 0;
 	}
 
-	run_in_new_process(&verify_upm_test);
+	run_in_new_process(&verify_upm_test_explicit);
+	run_in_new_process(&verify_upm_test_implicit);
 }
-- 
2.43.0.472.g3155946c3a-goog

