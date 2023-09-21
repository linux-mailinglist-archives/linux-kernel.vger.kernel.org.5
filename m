Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8877AA177
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbjIUVCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbjIUVCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:02:03 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147A790A73
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 13:33:54 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d814a1f7378so4994903276.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 13:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695328434; x=1695933234; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=1e4MrCMHTLSZnyIO0FBl7+NQqWZG7f8pPm6hkGSjc9w=;
        b=Kbs8XBLABurM4wkP1Etj58hufgt+3MCkPFJf4zzdIhVZykp6uW1fcANzyqxo7QZZNl
         NRgReh2oREqXTzpcBwDeFHoEkOItBnCH183kGo1utsFnIkPRkK5BI9dALIeieSCxSM7y
         diCyBjYAiyru3Id99pb9LMUS9AeP3OBc3yvK5NgnXYcVN/OAAYm0gVtzAEq6OQEn2hHS
         oEiHWemCa7W6hyMQCZb+4dSxGWDPuCvu1NnG2+XdQ4n482kQ0vDk8ctTx56UKrWeHWJh
         p6Js5Td2gFR2c8zX7nC+28BAC6Oj1MwERK81clMq9u0ukz5vSe1LCEjicM/Cha4BBF6Q
         CLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695328434; x=1695933234;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1e4MrCMHTLSZnyIO0FBl7+NQqWZG7f8pPm6hkGSjc9w=;
        b=fYhWlvNRF3Jp3dYremmr0JVVxLmBr9KP4oKKfeQPkscLqpCmzws5c7L7s3161izMfU
         rM2WLgNXnJfnokRTmS0Q7dHRTlqfcWmuXAA+tNy92CDKvZI5qubCqoOEsYyU45djI3Nd
         rfuUhzG86aRXGOZPEE8zwIRL6hxMgj50gJhduui5rz2fwPRo3upYzZEUzbEjbmSxI1n/
         dDt4PhAbl3qnwcEhPOZYuwXcoHy9GqRNGuC5DfB52GCTo4sN/7+8TdpjpaltV4T1N81S
         cRCQo0NaygkFrrcUa2g8tGfkRN1mpGdJi+6L/o8q9JB8uXQYy7TcmyVda3xRpKjfg0hm
         N0sg==
X-Gm-Message-State: AOJu0YxI3l02M4oOY3MAQnKwliWlGsQSestpaogFw8WfX39jtrnyxogS
        p9FyUMzRDof8P1u4D4s3d5t9Uj7J7mA=
X-Google-Smtp-Source: AGHT+IEO6fBbhlkXcJTXrJ7RZL61QFV8RTGC1IpwqpAUy2RmP7+VLi8mBQy96qpxOGMgIPsWRqQ0yEMjFGQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:abf2:0:b0:d81:57ba:4d7a with SMTP id
 v105-20020a25abf2000000b00d8157ba4d7amr10576ybi.6.1695328433855; Thu, 21 Sep
 2023 13:33:53 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 21 Sep 2023 13:33:28 -0700
In-Reply-To: <20230921203331.3746712-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230921203331.3746712-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230921203331.3746712-12-seanjc@google.com>
Subject: [PATCH 11/13] KVM: selftests: Refactor private mem conversions to
 prep for punch_hole test
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Roth <michael.roth@amd.com>,
        Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the private memory conversions test to prepare for adding a test
to verify PUNCH_HOLE functionality *without* actually do a proper
conversion, i.e. without calling KVM_SET_MEMORY_ATTRIBUTES.  Make setting
attributes optional, rename the guest code to be more descriptive, and
extract the ranges to a global variable (iterating over multiple ranges is
less interesting for PUNCH_HOLE, but with a common array it's trivially
easy to do so).

Fixes: 90535ca08f76 ("KVM: selftests: Add x86-only selftest for private memory conversions")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../kvm/x86_64/private_mem_conversions_test.c | 51 ++++++++++---------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c b/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c
index 50541246d6fd..b80cf7342d0d 100644
--- a/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c
+++ b/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c
@@ -83,13 +83,14 @@ static void guest_sync_private(uint64_t gpa, uint64_t size, uint8_t pattern)
 }
 
 /* Arbitrary values, KVM doesn't care about the attribute flags. */
-#define MAP_GPA_SHARED		BIT(0)
-#define MAP_GPA_DO_FALLOCATE	BIT(1)
+#define MAP_GPA_SET_ATTRIBUTES	BIT(0)
+#define MAP_GPA_SHARED		BIT(1)
+#define MAP_GPA_DO_FALLOCATE	BIT(2)
 
 static void guest_map_mem(uint64_t gpa, uint64_t size, bool map_shared,
 			  bool do_fallocate)
 {
-	uint64_t flags = 0;
+	uint64_t flags = MAP_GPA_SET_ATTRIBUTES;
 
 	if (map_shared)
 		flags |= MAP_GPA_SHARED;
@@ -108,19 +109,19 @@ static void guest_map_private(uint64_t gpa, uint64_t size, bool do_fallocate)
 	guest_map_mem(gpa, size, false, do_fallocate);
 }
 
-static void guest_run_test(uint64_t base_gpa, bool do_fallocate)
+struct {
+	uint64_t offset;
+	uint64_t size;
+} static const test_ranges[] = {
+	GUEST_STAGE(0, PAGE_SIZE),
+	GUEST_STAGE(0, SZ_2M),
+	GUEST_STAGE(PAGE_SIZE, PAGE_SIZE),
+	GUEST_STAGE(PAGE_SIZE, SZ_2M),
+	GUEST_STAGE(SZ_2M, PAGE_SIZE),
+};
+
+static void guest_test_explicit_conversion(uint64_t base_gpa, bool do_fallocate)
 {
-	struct {
-		uint64_t offset;
-		uint64_t size;
-		uint8_t pattern;
-	} stages[] = {
-		GUEST_STAGE(0, PAGE_SIZE),
-		GUEST_STAGE(0, SZ_2M),
-		GUEST_STAGE(PAGE_SIZE, PAGE_SIZE),
-		GUEST_STAGE(PAGE_SIZE, SZ_2M),
-		GUEST_STAGE(SZ_2M, PAGE_SIZE),
-	};
 	const uint8_t init_p = 0xcc;
 	uint64_t j;
 	int i;
@@ -130,9 +131,9 @@ static void guest_run_test(uint64_t base_gpa, bool do_fallocate)
 	guest_sync_shared(base_gpa, PER_CPU_DATA_SIZE, (uint8_t)~init_p, init_p);
 	memcmp_g(base_gpa, init_p, PER_CPU_DATA_SIZE);
 
-	for (i = 0; i < ARRAY_SIZE(stages); i++) {
-		uint64_t gpa = base_gpa + stages[i].offset;
-		uint64_t size = stages[i].size;
+	for (i = 0; i < ARRAY_SIZE(test_ranges); i++) {
+		uint64_t gpa = base_gpa + test_ranges[i].offset;
+		uint64_t size = test_ranges[i].size;
 		uint8_t p1 = 0x11;
 		uint8_t p2 = 0x22;
 		uint8_t p3 = 0x33;
@@ -214,11 +215,11 @@ static void guest_run_test(uint64_t base_gpa, bool do_fallocate)
 static void guest_code(uint64_t base_gpa)
 {
 	/*
-	 * Run everything twice, with and without doing fallocate() on the
-	 * guest_memfd backing when converting between shared and private.
+	 * Run the conversion test twice, with and without doing fallocate() on
+	 * the guest_memfd backing when converting between shared and private.
 	 */
-	guest_run_test(base_gpa, false);
-	guest_run_test(base_gpa, true);
+	guest_test_explicit_conversion(base_gpa, false);
+	guest_test_explicit_conversion(base_gpa, true);
 	GUEST_DONE();
 }
 
@@ -227,6 +228,7 @@ static void handle_exit_hypercall(struct kvm_vcpu *vcpu)
 	struct kvm_run *run = vcpu->run;
 	uint64_t gpa = run->hypercall.args[0];
 	uint64_t size = run->hypercall.args[1] * PAGE_SIZE;
+	bool set_attributes = run->hypercall.args[2] & MAP_GPA_SET_ATTRIBUTES;
 	bool map_shared = run->hypercall.args[2] & MAP_GPA_SHARED;
 	bool do_fallocate = run->hypercall.args[2] & MAP_GPA_DO_FALLOCATE;
 	struct kvm_vm *vm = vcpu->vm;
@@ -238,8 +240,9 @@ static void handle_exit_hypercall(struct kvm_vcpu *vcpu)
 	if (do_fallocate)
 		vm_guest_mem_fallocate(vm, gpa, size, map_shared);
 
-	vm_set_memory_attributes(vm, gpa, size,
-				 map_shared ? 0 : KVM_MEMORY_ATTRIBUTE_PRIVATE);
+	if (set_attributes)
+		vm_set_memory_attributes(vm, gpa, size,
+					 map_shared ? 0 : KVM_MEMORY_ATTRIBUTE_PRIVATE);
 	run->hypercall.ret = 0;
 }
 
-- 
2.42.0.515.g380fc7ccd1-goog

