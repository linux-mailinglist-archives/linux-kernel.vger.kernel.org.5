Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A057E505E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 07:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjKHG2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 01:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbjKHG2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 01:28:04 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030E1170A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 22:28:02 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5bd85b1939aso1982292a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 22:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699424881; x=1700029681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9jF1QK+yyjyKZImYz9gxPKsB+w+B6p6y+hlZQwC+t44=;
        b=e7r4IOPWMgM0oR8ALWjTumSRUdxYunMEszfiBVCJZDwbPAbBGHwf2xjl/ITtDCATqx
         dycznH2N0BJ2zM7/VZf+EgzBJmctQ549Xwq4o45GfmlXnZdtotOyArmsZlR7Lx96pzIw
         GrXBwFK01g9HFJbiGeRLsqGwjPMgo6LsxDOWnPROb6HOb3nLHPrx7gv2qhsuYpci5DnP
         pTBoqZWWLcnGwDksnyqwk7HKm6nwEmMZRpKTlWnSQlYByKzRxfe8Ol5LVkmibEO1dLiJ
         4/tXe1lSXSAIvljny9vfpYEekT3aSxf4qzdaVTQkweo/mUXd53OTOpS99lbPeocNXbcR
         gywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699424881; x=1700029681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9jF1QK+yyjyKZImYz9gxPKsB+w+B6p6y+hlZQwC+t44=;
        b=UFCPEuTT7eeKMBqjjJiWGm36Utrm3BghKb33MjsLg1gtmH7+oczL5Nctd89gbrLRto
         LoRj9OWSDZFW16BImK58/j7G/ailJ5ZtBEQnuk1SJ4ZKqttvARv6I3OVavXW9KNzRdYW
         WkkP29zGkOtcR8Mg8V83jfnek5fHXQI2ddzn6ze2lAYtdKnJ1fu2H4AhizbNvsM5cInU
         BhhjB7Zj+nXgwV4/EDetpNG+xH6fEIWpAUQf7Xd83Rj1olPNHdGblGpaV3qGE9aEN6EW
         /QWM5YL275JnZSTZcEqQDb4NBWMEyFuxwoQYwzdFZWWnqQ1c/0tpSd1rTAo9kxVc6ZMx
         4zkA==
X-Gm-Message-State: AOJu0YyqbnSQsGfsknbxGj/4R8fcQCdanyyOclIbdApFwC7OKw+Iy9pe
        /AWYA5w3RgAQvTHBuWvbeQA=
X-Google-Smtp-Source: AGHT+IFm/t9bE3MqSJoZetIa9IO7EJjqkxlX3hPrSaCg8YueuSwL8q9rWULMP7cAmCa2oeQzSdiWsQ==
X-Received: by 2002:a05:6a21:3390:b0:16b:7602:15b1 with SMTP id yy16-20020a056a21339000b0016b760215b1mr1231540pzb.12.1699424881300;
        Tue, 07 Nov 2023 22:28:01 -0800 (PST)
Received: from omkarwagle.hsd1.ca.comcast.net (c-73-92-27-236.hsd1.ca.comcast.net. [73.92.27.236])
        by smtp.gmail.com with ESMTPSA id x17-20020a170902821100b001cc31dcec49sm880956pln.146.2023.11.07.22.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 22:28:00 -0800 (PST)
From:   Omkar Wagle <ov.wagle@gmail.com>
To:     catalin.marinas@arm.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omkar Wagle <ov.wagle@gmail.com>
Subject: [PATCH] MM: kmemleak: Removed coding style warnings and added a NULL check
Date:   Tue,  7 Nov 2023 22:27:56 -0800
Message-Id: <20231108062756.8129-1-ov.wagle@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed most of the coding style warnings
Added a NULL check to "object" pointer before accessing its members

Signed-off-by: Omkar Wagle <ov.wagle@gmail.com>
---
 mm/kmemleak.c | 50 +++++++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 1eacca03bedd..a7b74dc3ff01 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * mm/kmemleak.c
  *
  * Copyright (C) 2008 ARM Limited
  * Written by Catalin Marinas <catalin.marinas@arm.com>
@@ -97,7 +96,7 @@
 #include <linux/crc32.h>
 
 #include <asm/sections.h>
-#include <asm/processor.h>
+#include <linux/processor.h>
 #include <linux/atomic.h>
 
 #include <linux/kasan.h>
@@ -368,6 +367,7 @@ static void print_unreferenced(struct seq_file *seq,
 
 	for (i = 0; i < nr_entries; i++) {
 		void *ptr = (void *)entries[i];
+
 		warn_or_seq_printf(seq, "    [<%pK>] %pS\n", ptr, ptr);
 	}
 }
@@ -406,10 +406,13 @@ static struct kmemleak_object *__lookup_object(unsigned long ptr, int alias,
 	unsigned long untagged_ptr = (unsigned long)kasan_reset_tag((void *)ptr);
 
 	while (rb) {
-		struct kmemleak_object *object;
+		struct kmemleak_object *object = NULL;
 		unsigned long untagged_objp;
 
 		object = rb_entry(rb, struct kmemleak_object, rb_node);
+		if (!object)
+			break;
+
 		untagged_objp = (unsigned long)kasan_reset_tag((void *)object->pointer);
 
 		if (untagged_ptr < untagged_objp)
@@ -674,10 +677,10 @@ static int __link_object(struct kmemleak_object *object, unsigned long ptr,
 	/* task information */
 	if (in_hardirq()) {
 		object->pid = 0;
-		strncpy(object->comm, "hardirq", sizeof(object->comm));
+		strscpy(object->comm, "hardirq", sizeof(object->comm));
 	} else if (in_serving_softirq()) {
 		object->pid = 0;
-		strncpy(object->comm, "softirq", sizeof(object->comm));
+		strscpy(object->comm, "softirq", sizeof(object->comm));
 	} else {
 		object->pid = current->pid;
 		/*
@@ -686,7 +689,7 @@ static int __link_object(struct kmemleak_object *object, unsigned long ptr,
 		 * dependency issues with current->alloc_lock. In the worst
 		 * case, the command line is not correct.
 		 */
-		strncpy(object->comm, current->comm, sizeof(object->comm));
+		strscpy(object->comm, current->comm, sizeof(object->comm));
 	}
 
 	/* kernel backtrace */
@@ -1027,7 +1030,7 @@ static void object_no_scan(unsigned long ptr)
 void __ref kmemleak_alloc(const void *ptr, size_t size, int min_count,
 			  gfp_t gfp)
 {
-	pr_debug("%s(0x%px, %zu, %d)\n", __func__, ptr, size, min_count);
+	pr_debug("%s(0x%p, %zu, %d)\n", __func__, ptr, size, min_count);
 
 	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
 		create_object((unsigned long)ptr, size, min_count, gfp);
@@ -1048,7 +1051,7 @@ void __ref kmemleak_alloc_percpu(const void __percpu *ptr, size_t size,
 {
 	unsigned int cpu;
 
-	pr_debug("%s(0x%px, %zu)\n", __func__, ptr, size);
+	pr_debug("%s(0x%p, %zu)\n", __func__, ptr, size);
 
 	/*
 	 * Percpu allocations are only scanned and not reported as leaks
@@ -1072,7 +1075,7 @@ EXPORT_SYMBOL_GPL(kmemleak_alloc_percpu);
  */
 void __ref kmemleak_vmalloc(const struct vm_struct *area, size_t size, gfp_t gfp)
 {
-	pr_debug("%s(0x%px, %zu)\n", __func__, area, size);
+	pr_debug("%s(0x%p, %zu)\n", __func__, area, size);
 
 	/*
 	 * A min_count = 2 is needed because vm_struct contains a reference to
@@ -1095,7 +1098,7 @@ EXPORT_SYMBOL_GPL(kmemleak_vmalloc);
  */
 void __ref kmemleak_free(const void *ptr)
 {
-	pr_debug("%s(0x%px)\n", __func__, ptr);
+	pr_debug("%s(0x%p)\n", __func__, ptr);
 
 	if (kmemleak_free_enabled && ptr && !IS_ERR(ptr))
 		delete_object_full((unsigned long)ptr);
@@ -1113,7 +1116,7 @@ EXPORT_SYMBOL_GPL(kmemleak_free);
  */
 void __ref kmemleak_free_part(const void *ptr, size_t size)
 {
-	pr_debug("%s(0x%px)\n", __func__, ptr);
+	pr_debug("%s(0x%p)\n", __func__, ptr);
 
 	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
 		delete_object_part((unsigned long)ptr, size, false);
@@ -1131,7 +1134,7 @@ void __ref kmemleak_free_percpu(const void __percpu *ptr)
 {
 	unsigned int cpu;
 
-	pr_debug("%s(0x%px)\n", __func__, ptr);
+	pr_debug("%s(0x%p)\n", __func__, ptr);
 
 	if (kmemleak_free_enabled && ptr && !IS_ERR(ptr))
 		for_each_possible_cpu(cpu)
@@ -1152,7 +1155,7 @@ void __ref kmemleak_update_trace(const void *ptr)
 	struct kmemleak_object *object;
 	unsigned long flags;
 
-	pr_debug("%s(0x%px)\n", __func__, ptr);
+	pr_debug("%s(0x%p)\n", __func__, ptr);
 
 	if (!kmemleak_enabled || IS_ERR_OR_NULL(ptr))
 		return;
@@ -1183,7 +1186,7 @@ EXPORT_SYMBOL(kmemleak_update_trace);
  */
 void __ref kmemleak_not_leak(const void *ptr)
 {
-	pr_debug("%s(0x%px)\n", __func__, ptr);
+	pr_debug("%s(0x%p)\n", __func__, ptr);
 
 	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
 		make_gray_object((unsigned long)ptr);
@@ -1201,7 +1204,7 @@ EXPORT_SYMBOL(kmemleak_not_leak);
  */
 void __ref kmemleak_ignore(const void *ptr)
 {
-	pr_debug("%s(0x%px)\n", __func__, ptr);
+	pr_debug("%s(0x%p)\n", __func__, ptr);
 
 	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
 		make_black_object((unsigned long)ptr, false);
@@ -1221,7 +1224,7 @@ EXPORT_SYMBOL(kmemleak_ignore);
  */
 void __ref kmemleak_scan_area(const void *ptr, size_t size, gfp_t gfp)
 {
-	pr_debug("%s(0x%px)\n", __func__, ptr);
+	pr_debug("%s(0x%p)\n", __func__, ptr);
 
 	if (kmemleak_enabled && ptr && size && !IS_ERR(ptr))
 		add_scan_area((unsigned long)ptr, size, gfp);
@@ -1239,7 +1242,7 @@ EXPORT_SYMBOL(kmemleak_scan_area);
  */
 void __ref kmemleak_no_scan(const void *ptr)
 {
-	pr_debug("%s(0x%px)\n", __func__, ptr);
+	pr_debug("%s(0x%p)\n", __func__, ptr);
 
 	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
 		object_no_scan((unsigned long)ptr);
@@ -1255,7 +1258,7 @@ EXPORT_SYMBOL(kmemleak_no_scan);
  */
 void __ref kmemleak_alloc_phys(phys_addr_t phys, size_t size, gfp_t gfp)
 {
-	pr_debug("%s(0x%px, %zu)\n", __func__, &phys, size);
+	pr_debug("%s(0x%p, %zu)\n", __func__, &phys, size);
 
 	if (kmemleak_enabled)
 		/*
@@ -1275,7 +1278,7 @@ EXPORT_SYMBOL(kmemleak_alloc_phys);
  */
 void __ref kmemleak_free_part_phys(phys_addr_t phys, size_t size)
 {
-	pr_debug("%s(0x%px)\n", __func__, &phys);
+	pr_debug("%s(0x%p)\n", __func__, &phys);
 
 	if (kmemleak_enabled)
 		delete_object_part((unsigned long)phys, size, true);
@@ -1289,7 +1292,7 @@ EXPORT_SYMBOL(kmemleak_free_part_phys);
  */
 void __ref kmemleak_ignore_phys(phys_addr_t phys)
 {
-	pr_debug("%s(0x%px)\n", __func__, &phys);
+	pr_debug("%s(0x%p)\n", __func__, &phys);
 
 	if (kmemleak_enabled)
 		make_black_object((unsigned long)phys, true);
@@ -1662,6 +1665,7 @@ static void kmemleak_scan(void)
 		rcu_read_lock();
 		for_each_process_thread(g, p) {
 			void *stack = try_get_task_stack(p);
+
 			if (stack) {
 				scan_block(stack, stack + THREAD_SIZE, NULL);
 				put_task_stack(p);
@@ -1768,6 +1772,7 @@ static int kmemleak_scan_thread(void *arg)
 	 */
 	if (first_run) {
 		signed long timeout = msecs_to_jiffies(SECS_FIRST_SCAN * 1000);
+
 		first_run = 0;
 		while (timeout && !kthread_should_stop())
 			timeout = schedule_timeout_interruptible(timeout);
@@ -2013,7 +2018,7 @@ static ssize_t kmemleak_write(struct file *file, const char __user *user_buf,
 	else if (strncmp(buf, "scan=off", 8) == 0)
 		stop_scan_thread();
 	else if (strncmp(buf, "scan=", 5) == 0) {
-		unsigned secs;
+		unsigned int secs;
 		unsigned long msecs;
 
 		ret = kstrtouint(buf + 5, 0, &secs);
@@ -2130,8 +2135,7 @@ static int __init kmemleak_boot_config(char *str)
 	else if (strcmp(str, "on") == 0) {
 		kmemleak_skip_disable = 1;
 		stack_depot_request_early_init();
-	}
-	else
+	} else
 		return -EINVAL;
 	return 0;
 }
-- 
2.34.1

