Return-Path: <linux-kernel+bounces-52069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB9A8493B7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1196C1C20398
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B923E11188;
	Mon,  5 Feb 2024 06:09:34 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE4ABE62;
	Mon,  5 Feb 2024 06:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707113373; cv=none; b=s658vfEfB/XYg5cebeJ5JPftBdxGFcGMIB9e4y1qTvwH7dP3dW2eOCtjt72P1JYZJxdJTccr995hO2UNLFNYkJYVm3ULCa1jPOVm+lZyYm1h4nPXgyAZIMgGdgR/2bEpZDuK3cvYM+HJbkBBzjOVKKtR9Mj1QOszTzo1vsV2LFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707113373; c=relaxed/simple;
	bh=4d0nKTk+nvKr99zkSPoxp6Z/ddVVKv4vmxFIdpJtkiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xm+QgEhq5ZVwKw2skbxqlUN2stFmu900lE3UT2FiV+WVQIkgbLq0yHgcPRg8Y+er6mUlBVzJ6bFVUpV6iOUwgZUcO/6ExYAqrL4qxaFbJOoVHzsakDKg+lhBpXV6tQlwJIFjmNyVBPDYrNGMwAYtN1Wlg+3D5xH1mBIsvIf5bFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxqvCYe8Bl88kKAA--.30677S3;
	Mon, 05 Feb 2024 14:09:28 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxHs+Ve8BluusvAA--.49177S3;
	Mon, 05 Feb 2024 14:09:26 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Marco Elver <elver@google.com>
Cc: kasan-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kasan: docs: Update descriptions about test file and module
Date: Mon,  5 Feb 2024 14:09:21 +0800
Message-ID: <20240205060925.15594-2-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240205060925.15594-1-yangtiezhu@loongson.cn>
References: <20240205060925.15594-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxHs+Ve8BluusvAA--.49177S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxKryUuF15ZF1Uuw4fJr1xtFc_yoWDJF1xpF
	ZFgryxtFn8ArWkur4jyF1jyr10yFs7ur17K3Zaqwn3XrZ8Kw10yFsFkr4jgFyxWr4rZFyU
	Z3WktFyDGw4UGabCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_
	Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjxU4OzVUUUUU

After commit f7e01ab828fd ("kasan: move tests to mm/kasan/"), the test
file is renamed to mm/kasan/kasan_test.c and the test module is renamed
to kasan_test.ko, so update the descriptions in the document.

While at it, update the line number and testcase number when the tests
kmalloc_large_oob_right and kmalloc_double_kzfree failed to sync with
the current code in mm/kasan/kasan_test.c.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 Documentation/dev-tools/kasan.rst             | 20 +++++++++----------
 .../translations/zh_CN/dev-tools/kasan.rst    | 20 +++++++++----------
 .../translations/zh_TW/dev-tools/kasan.rst    | 20 +++++++++----------
 3 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index 858c77fe7dc4..a5a6dbe9029f 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -169,7 +169,7 @@ Error reports
 A typical KASAN report looks like this::
 
     ==================================================================
-    BUG: KASAN: slab-out-of-bounds in kmalloc_oob_right+0xa8/0xbc [test_kasan]
+    BUG: KASAN: slab-out-of-bounds in kmalloc_oob_right+0xa8/0xbc [kasan_test]
     Write of size 1 at addr ffff8801f44ec37b by task insmod/2760
 
     CPU: 1 PID: 2760 Comm: insmod Not tainted 4.19.0-rc3+ #698
@@ -179,8 +179,8 @@ A typical KASAN report looks like this::
      print_address_description+0x73/0x280
      kasan_report+0x144/0x187
      __asan_report_store1_noabort+0x17/0x20
-     kmalloc_oob_right+0xa8/0xbc [test_kasan]
-     kmalloc_tests_init+0x16/0x700 [test_kasan]
+     kmalloc_oob_right+0xa8/0xbc [kasan_test]
+     kmalloc_tests_init+0x16/0x700 [kasan_test]
      do_one_initcall+0xa5/0x3ae
      do_init_module+0x1b6/0x547
      load_module+0x75df/0x8070
@@ -200,8 +200,8 @@ A typical KASAN report looks like this::
      save_stack+0x43/0xd0
      kasan_kmalloc+0xa7/0xd0
      kmem_cache_alloc_trace+0xe1/0x1b0
-     kmalloc_oob_right+0x56/0xbc [test_kasan]
-     kmalloc_tests_init+0x16/0x700 [test_kasan]
+     kmalloc_oob_right+0x56/0xbc [kasan_test]
+     kmalloc_tests_init+0x16/0x700 [kasan_test]
      do_one_initcall+0xa5/0x3ae
      do_init_module+0x1b6/0x547
      load_module+0x75df/0x8070
@@ -510,15 +510,15 @@ When a test passes::
 
 When a test fails due to a failed ``kmalloc``::
 
-        # kmalloc_large_oob_right: ASSERTION FAILED at lib/test_kasan.c:163
+        # kmalloc_large_oob_right: ASSERTION FAILED at mm/kasan/kasan_test.c:245
         Expected ptr is not null, but is
-        not ok 4 - kmalloc_large_oob_right
+        not ok 5 - kmalloc_large_oob_right
 
 When a test fails due to a missing KASAN report::
 
-        # kmalloc_double_kzfree: EXPECTATION FAILED at lib/test_kasan.c:974
+        # kmalloc_double_kzfree: EXPECTATION FAILED at mm/kasan/kasan_test.c:709
         KASAN failure expected in "kfree_sensitive(ptr)", but none occurred
-        not ok 44 - kmalloc_double_kzfree
+        not ok 28 - kmalloc_double_kzfree
 
 
 At the end the cumulative status of all KASAN tests is printed. On success::
@@ -534,7 +534,7 @@ There are a few ways to run KUnit-compatible KASAN tests.
 1. Loadable module
 
    With ``CONFIG_KUNIT`` enabled, KASAN-KUnit tests can be built as a loadable
-   module and run by loading ``test_kasan.ko`` with ``insmod`` or ``modprobe``.
+   module and run by loading ``kasan_test.ko`` with ``insmod`` or ``modprobe``.
 
 2. Built-In
 
diff --git a/Documentation/translations/zh_CN/dev-tools/kasan.rst b/Documentation/translations/zh_CN/dev-tools/kasan.rst
index 8fdb20c9665b..2b1e8f74904b 100644
--- a/Documentation/translations/zh_CN/dev-tools/kasan.rst
+++ b/Documentation/translations/zh_CN/dev-tools/kasan.rst
@@ -137,7 +137,7 @@ KASAN受到通用 ``panic_on_warn`` 命令行参数的影响。当它被启用
 典型的KASAN报告如下所示::
 
     ==================================================================
-    BUG: KASAN: slab-out-of-bounds in kmalloc_oob_right+0xa8/0xbc [test_kasan]
+    BUG: KASAN: slab-out-of-bounds in kmalloc_oob_right+0xa8/0xbc [kasan_test]
     Write of size 1 at addr ffff8801f44ec37b by task insmod/2760
 
     CPU: 1 PID: 2760 Comm: insmod Not tainted 4.19.0-rc3+ #698
@@ -147,8 +147,8 @@ KASAN受到通用 ``panic_on_warn`` 命令行参数的影响。当它被启用
      print_address_description+0x73/0x280
      kasan_report+0x144/0x187
      __asan_report_store1_noabort+0x17/0x20
-     kmalloc_oob_right+0xa8/0xbc [test_kasan]
-     kmalloc_tests_init+0x16/0x700 [test_kasan]
+     kmalloc_oob_right+0xa8/0xbc [kasan_test]
+     kmalloc_tests_init+0x16/0x700 [kasan_test]
      do_one_initcall+0xa5/0x3ae
      do_init_module+0x1b6/0x547
      load_module+0x75df/0x8070
@@ -168,8 +168,8 @@ KASAN受到通用 ``panic_on_warn`` 命令行参数的影响。当它被启用
      save_stack+0x43/0xd0
      kasan_kmalloc+0xa7/0xd0
      kmem_cache_alloc_trace+0xe1/0x1b0
-     kmalloc_oob_right+0x56/0xbc [test_kasan]
-     kmalloc_tests_init+0x16/0x700 [test_kasan]
+     kmalloc_oob_right+0x56/0xbc [kasan_test]
+     kmalloc_tests_init+0x16/0x700 [kasan_test]
      do_one_initcall+0xa5/0x3ae
      do_init_module+0x1b6/0x547
      load_module+0x75df/0x8070
@@ -421,15 +421,15 @@ KASAN连接到vmap基础架构以懒清理未使用的影子内存。
 
 当由于 ``kmalloc`` 失败而导致测试失败时::
 
-        # kmalloc_large_oob_right: ASSERTION FAILED at lib/test_kasan.c:163
+        # kmalloc_large_oob_right: ASSERTION FAILED at mm/kasan/kasan_test.c:245
         Expected ptr is not null, but is
-        not ok 4 - kmalloc_large_oob_right
+        not ok 5 - kmalloc_large_oob_right
 
 当由于缺少KASAN报告而导致测试失败时::
 
-        # kmalloc_double_kzfree: EXPECTATION FAILED at lib/test_kasan.c:974
+        # kmalloc_double_kzfree: EXPECTATION FAILED at mm/kasan/kasan_test.c:709
         KASAN failure expected in "kfree_sensitive(ptr)", but none occurred
-        not ok 44 - kmalloc_double_kzfree
+        not ok 28 - kmalloc_double_kzfree
 
 
 最后打印所有KASAN测试的累积状态。成功::
@@ -445,7 +445,7 @@ KASAN连接到vmap基础架构以懒清理未使用的影子内存。
 1. 可加载模块
 
    启用 ``CONFIG_KUNIT`` 后，KASAN-KUnit测试可以构建为可加载模块，并通过使用
-   ``insmod`` 或 ``modprobe`` 加载 ``test_kasan.ko`` 来运行。
+   ``insmod`` 或 ``modprobe`` 加载 ``kasan_test.ko`` 来运行。
 
 2. 内置
 
diff --git a/Documentation/translations/zh_TW/dev-tools/kasan.rst b/Documentation/translations/zh_TW/dev-tools/kasan.rst
index 979eb84bc58f..ed342e67d8ed 100644
--- a/Documentation/translations/zh_TW/dev-tools/kasan.rst
+++ b/Documentation/translations/zh_TW/dev-tools/kasan.rst
@@ -137,7 +137,7 @@ KASAN受到通用 ``panic_on_warn`` 命令行參數的影響。當它被啓用
 典型的KASAN報告如下所示::
 
     ==================================================================
-    BUG: KASAN: slab-out-of-bounds in kmalloc_oob_right+0xa8/0xbc [test_kasan]
+    BUG: KASAN: slab-out-of-bounds in kmalloc_oob_right+0xa8/0xbc [kasan_test]
     Write of size 1 at addr ffff8801f44ec37b by task insmod/2760
 
     CPU: 1 PID: 2760 Comm: insmod Not tainted 4.19.0-rc3+ #698
@@ -147,8 +147,8 @@ KASAN受到通用 ``panic_on_warn`` 命令行參數的影響。當它被啓用
      print_address_description+0x73/0x280
      kasan_report+0x144/0x187
      __asan_report_store1_noabort+0x17/0x20
-     kmalloc_oob_right+0xa8/0xbc [test_kasan]
-     kmalloc_tests_init+0x16/0x700 [test_kasan]
+     kmalloc_oob_right+0xa8/0xbc [kasan_test]
+     kmalloc_tests_init+0x16/0x700 [kasan_test]
      do_one_initcall+0xa5/0x3ae
      do_init_module+0x1b6/0x547
      load_module+0x75df/0x8070
@@ -168,8 +168,8 @@ KASAN受到通用 ``panic_on_warn`` 命令行參數的影響。當它被啓用
      save_stack+0x43/0xd0
      kasan_kmalloc+0xa7/0xd0
      kmem_cache_alloc_trace+0xe1/0x1b0
-     kmalloc_oob_right+0x56/0xbc [test_kasan]
-     kmalloc_tests_init+0x16/0x700 [test_kasan]
+     kmalloc_oob_right+0x56/0xbc [kasan_test]
+     kmalloc_tests_init+0x16/0x700 [kasan_test]
      do_one_initcall+0xa5/0x3ae
      do_init_module+0x1b6/0x547
      load_module+0x75df/0x8070
@@ -421,15 +421,15 @@ KASAN連接到vmap基礎架構以懶清理未使用的影子內存。
 
 當由於 ``kmalloc`` 失敗而導致測試失敗時::
 
-        # kmalloc_large_oob_right: ASSERTION FAILED at lib/test_kasan.c:163
+        # kmalloc_large_oob_right: ASSERTION FAILED at mm/kasan/kasan_test.c:245
         Expected ptr is not null, but is
-        not ok 4 - kmalloc_large_oob_right
+        not ok 5 - kmalloc_large_oob_right
 
 當由於缺少KASAN報告而導致測試失敗時::
 
-        # kmalloc_double_kzfree: EXPECTATION FAILED at lib/test_kasan.c:974
+        # kmalloc_double_kzfree: EXPECTATION FAILED at mm/kasan/kasan_test.c:709
         KASAN failure expected in "kfree_sensitive(ptr)", but none occurred
-        not ok 44 - kmalloc_double_kzfree
+        not ok 28 - kmalloc_double_kzfree
 
 
 最後打印所有KASAN測試的累積狀態。成功::
@@ -445,7 +445,7 @@ KASAN連接到vmap基礎架構以懶清理未使用的影子內存。
 1. 可加載模塊
 
    啓用 ``CONFIG_KUNIT`` 後，KASAN-KUnit測試可以構建爲可加載模塊，並通過使用
-   ``insmod`` 或 ``modprobe`` 加載 ``test_kasan.ko`` 來運行。
+   ``insmod`` 或 ``modprobe`` 加載 ``kasan_test.ko`` 來運行。
 
 2. 內置
 
-- 
2.42.0


