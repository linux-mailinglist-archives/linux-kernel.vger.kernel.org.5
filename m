Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F19C756BE6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjGQSYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjGQSYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:24:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615E9E7F;
        Mon, 17 Jul 2023 11:23:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 318F0611E7;
        Mon, 17 Jul 2023 18:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD4CC433C7;
        Mon, 17 Jul 2023 18:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689618219;
        bh=Nse/j1eUG8CEEk1WEGrH5kAMrZdtd7T4kYG87UHPB3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z0Vaj8WBaaRQ1JzBBk9ylsnTBYwTp89LI2Jen23jnvkd62yZApngs72XAfuF+2guV
         HsSL1B/TWQeC8pPZ1u71rPXic2z5XKTSlnIFxcAGQdNvJfft5uX9/umW5pzmz/mV9I
         3FbueSP97G30yqsot/I56NG6prjUelCRYxV4VmIuCTeJqD0d4g1ariGdH/ONzYLAJv
         nugMrX/Wty4Q91CLSPmEe3AOM+kKI8ElELoReXt3Ar60BjPwMpykjEnKpfTQ4fS+YZ
         kHsiX3Vx2Y7nGNCN8Uy2qQ3//G6RLLbxWal/YBAcevSI842ti3x31sbnqvlvoYpFNe
         NDPE5mmYY8Mkg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 22AE8CE04CD; Mon, 17 Jul 2023 11:23:39 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 02/18] rcu: Remove formal-verification tests
Date:   Mon, 17 Jul 2023 11:23:21 -0700
Message-Id: <20230717182337.1098991-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <d03c7482-acde-4f33-a7fb-fa7c58fdc9a2@paulmck-laptop>
References: <d03c7482-acde-4f33-a7fb-fa7c58fdc9a2@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CBMC-based formal-verification testing for SRCU was quite the thing
back in 2016, but the problem is that SRCU changes too quickly for the
scripting to keep up.  In addition, more recently, SRCU's grace-period
ordering has been formally modeled by a group of Linux-kernel memory-model
litmus tests.

This commit therefore removes the pioneering formal-verification tests.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../rcutorture/formal/srcu-cbmc/.gitignore    |   2 -
 .../rcutorture/formal/srcu-cbmc/Makefile      |  17 -
 .../srcu-cbmc/empty_includes/linux/delay.h    |   0
 .../srcu-cbmc/empty_includes/linux/export.h   |   0
 .../srcu-cbmc/empty_includes/linux/mutex.h    |   0
 .../srcu-cbmc/empty_includes/linux/percpu.h   |   0
 .../srcu-cbmc/empty_includes/linux/preempt.h  |   0
 .../srcu-cbmc/empty_includes/linux/rcupdate.h |   0
 .../srcu-cbmc/empty_includes/linux/sched.h    |   0
 .../srcu-cbmc/empty_includes/linux/smp.h      |   0
 .../empty_includes/linux/workqueue.h          |   0
 .../empty_includes/uapi/linux/types.h         |   0
 .../formal/srcu-cbmc/include/linux/.gitignore |   2 -
 .../formal/srcu-cbmc/include/linux/kconfig.h  |   1 -
 .../formal/srcu-cbmc/include/linux/types.h    | 152 -------
 .../formal/srcu-cbmc/modify_srcu.awk          | 376 ------------------
 .../rcutorture/formal/srcu-cbmc/src/assume.h  |  17 -
 .../formal/srcu-cbmc/src/barriers.h           |  41 --
 .../rcutorture/formal/srcu-cbmc/src/bug_on.h  |  14 -
 .../formal/srcu-cbmc/src/combined_source.c    |  14 -
 .../rcutorture/formal/srcu-cbmc/src/config.h  |  28 --
 .../formal/srcu-cbmc/src/include_srcu.c       |  32 --
 .../formal/srcu-cbmc/src/int_typedefs.h       |  34 --
 .../rcutorture/formal/srcu-cbmc/src/locks.h   | 221 ----------
 .../rcutorture/formal/srcu-cbmc/src/misc.c    |  12 -
 .../rcutorture/formal/srcu-cbmc/src/misc.h    |  58 ---
 .../rcutorture/formal/srcu-cbmc/src/percpu.h  |  93 -----
 .../rcutorture/formal/srcu-cbmc/src/preempt.c |  79 ----
 .../rcutorture/formal/srcu-cbmc/src/preempt.h |  59 ---
 .../formal/srcu-cbmc/src/simple_sync_srcu.c   |  51 ---
 .../formal/srcu-cbmc/src/workqueues.h         | 103 -----
 .../tests/store_buffering/.gitignore          |   2 -
 .../srcu-cbmc/tests/store_buffering/Makefile  |  12 -
 .../tests/store_buffering/assert_end.fail     |   1 -
 .../tests/store_buffering/force.fail          |   1 -
 .../tests/store_buffering/force2.fail         |   1 -
 .../tests/store_buffering/force3.fail         |   1 -
 .../srcu-cbmc/tests/store_buffering/main.pass |   0
 .../srcu-cbmc/tests/store_buffering/test.c    |  73 ----
 .../formal/srcu-cbmc/tests/test_script.sh     | 103 -----
 40 files changed, 1600 deletions(-)
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/.gitignore
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/Makefile
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/empty_includes/linux/delay.h
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/empty_includes/linux/export.h
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/empty_includes/linux/mutex.h
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/empty_includes/linux/percpu.h
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/empty_includes/linux/preempt.h
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/empty_includes/linux/rcupdate.h
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/empty_includes/linux/sched.h
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/empty_includes/linux/smp.h
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/empty_includes/linux/workqueue.h
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/empty_includes/uapi/linux/types.h
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/include/linux/.gitignore
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/include/linux/kconfig.h
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/include/linux/types.h
 delete mode 100755 tools/testing/selftests/rcutorture/formal/srcu-cbmc/modify_srcu.awk
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/assume.h
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/barriers.h
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/bug_on.h
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/combined_source.c
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/config.h
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/include_srcu.c
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/int_typedefs.h
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/locks.h
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/misc.c
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/misc.h
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/percpu.h
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/preempt.c
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/preempt.h
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/simple_sync_srcu.c
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/workqueues.h
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/.gitignore
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/Makefile
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/assert_end.fail
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/force.fail
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/force2.fail
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/force3.fail
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/main.pass
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/test.c
 delete mode 100755 tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/test_script.sh

diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/.gitignore b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/.gitignore
deleted file mode 100644
index 24e27957efcc..000000000000
--- a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-srcu.c
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/Makefile b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/Makefile
deleted file mode 100644
index 4bed0b678f8b..000000000000
--- a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/Makefile
+++ /dev/null
@@ -1,17 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-all: srcu.c store_buffering
-
-LINUX_SOURCE = ../../../../../..
-
-modified_srcu_input = $(LINUX_SOURCE)/include/linux/srcu.h \
-		      $(LINUX_SOURCE)/kernel/rcu/srcu.c
-
-modified_srcu_output = include/linux/srcu.h srcu.c
-
-include/linux/srcu.h: srcu.c
-
-srcu.c: modify_srcu.awk Makefile $(modified_srcu_input)
-	awk -f modify_srcu.awk $(modified_srcu_input) $(modified_srcu_output)
-
-store_buffering:
-	@cd tests/store_buffering; make
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/empty_includes/linux/delay.h b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/empty_includes/linux/delay.h
deleted file mode 100644
index e69de29bb2d1..000000000000
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/empty_includes/linux/export.h b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/empty_includes/linux/export.h
deleted file mode 100644
index e69de29bb2d1..000000000000
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/empty_includes/linux/mutex.h b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/empty_includes/linux/mutex.h
deleted file mode 100644
index e69de29bb2d1..000000000000
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/empty_includes/linux/percpu.h b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/empty_includes/linux/percpu.h
deleted file mode 100644
index e69de29bb2d1..000000000000
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/empty_includes/linux/preempt.h b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/empty_includes/linux/preempt.h
deleted file mode 100644
index e69de29bb2d1..000000000000
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/empty_includes/linux/rcupdate.h b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/empty_includes/linux/rcupdate.h
deleted file mode 100644
index e69de29bb2d1..000000000000
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/empty_includes/linux/sched.h b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/empty_includes/linux/sched.h
deleted file mode 100644
index e69de29bb2d1..000000000000
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/empty_includes/linux/smp.h b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/empty_includes/linux/smp.h
deleted file mode 100644
index e69de29bb2d1..000000000000
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/empty_includes/linux/workqueue.h b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/empty_includes/linux/workqueue.h
deleted file mode 100644
index e69de29bb2d1..000000000000
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/empty_includes/uapi/linux/types.h b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/empty_includes/uapi/linux/types.h
deleted file mode 100644
index e69de29bb2d1..000000000000
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/include/linux/.gitignore b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/include/linux/.gitignore
deleted file mode 100644
index 57d296341304..000000000000
--- a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/include/linux/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-srcu.h
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/include/linux/kconfig.h b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/include/linux/kconfig.h
deleted file mode 100644
index f2860dd1b407..000000000000
--- a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/include/linux/kconfig.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <LINUX_SOURCE/linux/kconfig.h>
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/include/linux/types.h b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/include/linux/types.h
deleted file mode 100644
index 8bc960e5e713..000000000000
--- a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/include/linux/types.h
+++ /dev/null
@@ -1,152 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * This header has been modifies to remove definitions of types that
- * are defined in standard userspace headers or are problematic for some
- * other reason.
- */
-
-#ifndef _LINUX_TYPES_H
-#define _LINUX_TYPES_H
-
-#define __EXPORTED_HEADERS__
-#include <uapi/linux/types.h>
-
-#ifndef __ASSEMBLY__
-
-#define DECLARE_BITMAP(name, bits) \
-	unsigned long name[BITS_TO_LONGS(bits)]
-
-typedef __u32 __kernel_dev_t;
-
-/* bsd */
-typedef unsigned char		u_char;
-typedef unsigned short		u_short;
-typedef unsigned int		u_int;
-typedef unsigned long		u_long;
-
-/* sysv */
-typedef unsigned char		unchar;
-typedef unsigned short		ushort;
-typedef unsigned int		uint;
-typedef unsigned long		ulong;
-
-#ifndef __BIT_TYPES_DEFINED__
-#define __BIT_TYPES_DEFINED__
-
-typedef		__u8		u_int8_t;
-typedef		__s8		int8_t;
-typedef		__u16		u_int16_t;
-typedef		__s16		int16_t;
-typedef		__u32		u_int32_t;
-typedef		__s32		int32_t;
-
-#endif /* !(__BIT_TYPES_DEFINED__) */
-
-typedef		__u8		uint8_t;
-typedef		__u16		uint16_t;
-typedef		__u32		uint32_t;
-
-/* this is a special 64bit data type that is 8-byte aligned */
-#define aligned_u64 __u64 __attribute__((aligned(8)))
-#define aligned_be64 __be64 __attribute__((aligned(8)))
-#define aligned_le64 __le64 __attribute__((aligned(8)))
-
-/**
- * The type used for indexing onto a disc or disc partition.
- *
- * Linux always considers sectors to be 512 bytes long independently
- * of the devices real block size.
- *
- * blkcnt_t is the type of the inode's block count.
- */
-typedef u64 sector_t;
-
-/*
- * The type of an index into the pagecache.
- */
-#define pgoff_t unsigned long
-
-/*
- * A dma_addr_t can hold any valid DMA address, i.e., any address returned
- * by the DMA API.
- *
- * If the DMA API only uses 32-bit addresses, dma_addr_t need only be 32
- * bits wide.  Bus addresses, e.g., PCI BARs, may be wider than 32 bits,
- * but drivers do memory-mapped I/O to ioremapped kernel virtual addresses,
- * so they don't care about the size of the actual bus addresses.
- */
-#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
-typedef u64 dma_addr_t;
-#else
-typedef u32 dma_addr_t;
-#endif
-
-#ifdef CONFIG_PHYS_ADDR_T_64BIT
-typedef u64 phys_addr_t;
-#else
-typedef u32 phys_addr_t;
-#endif
-
-typedef phys_addr_t resource_size_t;
-
-/*
- * This type is the placeholder for a hardware interrupt number. It has to be
- * big enough to enclose whatever representation is used by a given platform.
- */
-typedef unsigned long irq_hw_number_t;
-
-typedef struct {
-	int counter;
-} atomic_t;
-
-#ifdef CONFIG_64BIT
-typedef struct {
-	long counter;
-} atomic64_t;
-#endif
-
-struct list_head {
-	struct list_head *next, *prev;
-};
-
-struct hlist_head {
-	struct hlist_node *first;
-};
-
-struct hlist_node {
-	struct hlist_node *next, **pprev;
-};
-
-/**
- * struct callback_head - callback structure for use with RCU and task_work
- * @next: next update requests in a list
- * @func: actual update function to call after the grace period.
- *
- * The struct is aligned to size of pointer. On most architectures it happens
- * naturally due ABI requirements, but some architectures (like CRIS) have
- * weird ABI and we need to ask it explicitly.
- *
- * The alignment is required to guarantee that bits 0 and 1 of @next will be
- * clear under normal conditions -- as long as we use call_rcu() or
- * call_srcu() to queue callback.
- *
- * This guarantee is important for few reasons:
- *  - future call_rcu_lazy() will make use of lower bits in the pointer;
- *  - the structure shares storage spacer in struct page with @compound_head,
- *    which encode PageTail() in bit 0. The guarantee is needed to avoid
- *    false-positive PageTail().
- */
-struct callback_head {
-	struct callback_head *next;
-	void (*func)(struct callback_head *head);
-} __attribute__((aligned(sizeof(void *))));
-#define rcu_head callback_head
-
-typedef void (*rcu_callback_t)(struct rcu_head *head);
-typedef void (*call_rcu_func_t)(struct rcu_head *head, rcu_callback_t func);
-
-/* clocksource cycle base type */
-typedef u64 cycle_t;
-
-#endif /*  __ASSEMBLY__ */
-#endif /* _LINUX_TYPES_H */
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/modify_srcu.awk b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/modify_srcu.awk
deleted file mode 100755
index e05182d3e47d..000000000000
--- a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/modify_srcu.awk
+++ /dev/null
@@ -1,376 +0,0 @@
-#!/usr/bin/awk -f
-# SPDX-License-Identifier: GPL-2.0
-
-# Modify SRCU for formal verification. The first argument should be srcu.h and
-# the second should be srcu.c. Outputs modified srcu.h and srcu.c into the
-# current directory.
-
-BEGIN {
-	if (ARGC != 5) {
-		print "Usange: input.h input.c output.h output.c" > "/dev/stderr";
-		exit 1;
-	}
-	h_output = ARGV[3];
-	c_output = ARGV[4];
-	ARGC = 3;
-
-	# Tokenize using FS and not RS as FS supports regular expressions. Each
-	# record is one line of source, except that backslashed lines are
-	# combined. Comments are treated as field separators, as are quotes.
-	quote_regexp="\"([^\\\\\"]|\\\\.)*\"";
-	comment_regexp="\\/\\*([^*]|\\*+[^*/])*\\*\\/|\\/\\/.*(\n|$)";
-	FS="([ \\\\\t\n\v\f;,.=(){}+*/<>&|^-]|\\[|\\]|" comment_regexp "|" quote_regexp ")+";
-
-	inside_srcu_struct = 0;
-	inside_srcu_init_def = 0;
-	srcu_init_param_name = "";
-	in_macro = 0;
-	brace_nesting = 0;
-	paren_nesting = 0;
-
-	# Allow the manipulation of the last field separator after has been
-	# seen.
-	last_fs = "";
-	# Whether the last field separator was intended to be output.
-	last_fs_print = 0;
-
-	# rcu_batches stores the initialization for each instance of struct
-	# rcu_batch
-
-	in_comment = 0;
-
-	outputfile = "";
-}
-
-{
-	prev_outputfile = outputfile;
-	if (FILENAME ~ /\.h$/) {
-		outputfile = h_output;
-		if (FNR != NR) {
-			print "Incorrect file order" > "/dev/stderr";
-			exit 1;
-		}
-	}
-	else
-		outputfile = c_output;
-
-	if (prev_outputfile && outputfile != prev_outputfile) {
-		new_outputfile = outputfile;
-		outputfile = prev_outputfile;
-		update_fieldsep("", 0);
-		outputfile = new_outputfile;
-	}
-}
-
-# Combine the next line into $0.
-function combine_line() {
-	ret = getline next_line;
-	if (ret == 0) {
-		# Don't allow two consecutive getlines at the end of the file
-		if (eof_found) {
-			print "Error: expected more input." > "/dev/stderr";
-			exit 1;
-		} else {
-			eof_found = 1;
-		}
-	} else if (ret == -1) {
-		print "Error reading next line of file" FILENAME > "/dev/stderr";
-		exit 1;
-	}
-	$0 = $0 "\n" next_line;
-}
-
-# Combine backslashed lines and multiline comments.
-function combine_backslashes() {
-	while (/\\$|\/\*([^*]|\*+[^*\/])*\**$/) {
-		combine_line();
-	}
-}
-
-function read_line() {
-	combine_line();
-	combine_backslashes();
-}
-
-# Print out field separators and update variables that depend on them. Only
-# print if p is true. Call with sep="" and p=0 to print out the last field
-# separator.
-function update_fieldsep(sep, p) {
-	# Count braces
-	sep_tmp = sep;
-	gsub(quote_regexp "|" comment_regexp, "", sep_tmp);
-	while (1)
-	{
-		if (sub("[^{}()]*\\{", "", sep_tmp)) {
-			brace_nesting++;
-			continue;
-		}
-		if (sub("[^{}()]*\\}", "", sep_tmp)) {
-			brace_nesting--;
-			if (brace_nesting < 0) {
-				print "Unbalanced braces!" > "/dev/stderr";
-				exit 1;
-			}
-			continue;
-		}
-		if (sub("[^{}()]*\\(", "", sep_tmp)) {
-			paren_nesting++;
-			continue;
-		}
-		if (sub("[^{}()]*\\)", "", sep_tmp)) {
-			paren_nesting--;
-			if (paren_nesting < 0) {
-				print "Unbalanced parenthesis!" > "/dev/stderr";
-				exit 1;
-			}
-			continue;
-		}
-
-		break;
-	}
-
-	if (last_fs_print)
-		printf("%s", last_fs) > outputfile;
-	last_fs = sep;
-	last_fs_print = p;
-}
-
-# Shifts the fields down by n positions. Calls next if there are no more. If p
-# is true then print out field separators.
-function shift_fields(n, p) {
-	do {
-		if (match($0, FS) > 0) {
-			update_fieldsep(substr($0, RSTART, RLENGTH), p);
-			if (RSTART + RLENGTH <= length())
-				$0 = substr($0, RSTART + RLENGTH);
-			else
-				$0 = "";
-		} else {
-			update_fieldsep("", 0);
-			print "" > outputfile;
-			next;
-		}
-	} while (--n > 0);
-}
-
-# Shifts and prints the first n fields.
-function print_fields(n) {
-	do {
-		update_fieldsep("", 0);
-		printf("%s", $1) > outputfile;
-		shift_fields(1, 1);
-	} while (--n > 0);
-}
-
-{
-	combine_backslashes();
-}
-
-# Print leading FS
-{
-	if (match($0, "^(" FS ")+") > 0) {
-		update_fieldsep(substr($0, RSTART, RLENGTH), 1);
-		if (RSTART + RLENGTH <= length())
-			$0 = substr($0, RSTART + RLENGTH);
-		else
-			$0 = "";
-	}
-}
-
-# Parse the line.
-{
-	while (NF > 0) {
-		if ($1 == "struct" && NF < 3) {
-			read_line();
-			continue;
-		}
-
-		if (FILENAME ~ /\.h$/ && !inside_srcu_struct &&
-		    brace_nesting == 0 && paren_nesting == 0 &&
-		    $1 == "struct" && $2 == "srcu_struct" &&
-		    $0 ~ "^struct(" FS ")+srcu_struct(" FS ")+\\{") {
-			inside_srcu_struct = 1;
-			print_fields(2);
-			continue;
-		}
-		if (inside_srcu_struct && brace_nesting == 0 &&
-		    paren_nesting == 0) {
-			inside_srcu_struct = 0;
-			update_fieldsep("", 0);
-			for (name in rcu_batches)
-				print "extern struct rcu_batch " name ";" > outputfile;
-		}
-
-		if (inside_srcu_struct && $1 == "struct" && $2 == "rcu_batch") {
-			# Move rcu_batches outside of the struct.
-			rcu_batches[$3] = "";
-			shift_fields(3, 1);
-			sub(/;[[:space:]]*$/, "", last_fs);
-			continue;
-		}
-
-		if (FILENAME ~ /\.h$/ && !inside_srcu_init_def &&
-		    $1 == "#define" && $2 == "__SRCU_STRUCT_INIT") {
-			inside_srcu_init_def = 1;
-			srcu_init_param_name = $3;
-			in_macro = 1;
-			print_fields(3);
-			continue;
-		}
-		if (inside_srcu_init_def && brace_nesting == 0 &&
-		    paren_nesting == 0) {
-			inside_srcu_init_def = 0;
-			in_macro = 0;
-			continue;
-		}
-
-		if (inside_srcu_init_def && brace_nesting == 1 &&
-		    paren_nesting == 0 && last_fs ~ /\.[[:space:]]*$/ &&
-		    $1 ~ /^[[:alnum:]_]+$/) {
-			name = $1;
-			if (name in rcu_batches) {
-				# Remove the dot.
-				sub(/\.[[:space:]]*$/, "", last_fs);
-
-				old_record = $0;
-				do
-					shift_fields(1, 0);
-				while (last_fs !~ /,/ || paren_nesting > 0);
-				end_loc = length(old_record) - length($0);
-				end_loc += index(last_fs, ",") - length(last_fs);
-
-				last_fs = substr(last_fs, index(last_fs, ",") + 1);
-				last_fs_print = 1;
-
-				match(old_record, "^"name"("FS")+=");
-				start_loc = RSTART + RLENGTH;
-
-				len = end_loc - start_loc;
-				initializer = substr(old_record, start_loc, len);
-				gsub(srcu_init_param_name "\\.", "", initializer);
-				rcu_batches[name] = initializer;
-				continue;
-			}
-		}
-
-		# Don't include a nonexistent file
-		if (!in_macro && $1 == "#include" && /^#include[[:space:]]+"rcu\.h"/) {
-			update_fieldsep("", 0);
-			next;
-		}
-
-		# Ignore most preprocessor stuff.
-		if (!in_macro && $1 ~ /#/) {
-			break;
-		}
-
-		if (brace_nesting > 0 && $1 ~ "^[[:alnum:]_]+$" && NF < 2) {
-			read_line();
-			continue;
-		}
-		if (brace_nesting > 0 &&
-		    $0 ~ "^[[:alnum:]_]+[[:space:]]*(\\.|->)[[:space:]]*[[:alnum:]_]+" &&
-		    $2 in rcu_batches) {
-			# Make uses of rcu_batches global. Somewhat unreliable.
-			shift_fields(1, 0);
-			print_fields(1);
-			continue;
-		}
-
-		if ($1 == "static" && NF < 3) {
-			read_line();
-			continue;
-		}
-		if ($1 == "static" && ($2 == "bool" && $3 == "try_check_zero" ||
-		                       $2 == "void" && $3 == "srcu_flip")) {
-			shift_fields(1, 1);
-			print_fields(2);
-			continue;
-		}
-
-		# Distinguish between read-side and write-side memory barriers.
-		if ($1 == "smp_mb" && NF < 2) {
-			read_line();
-			continue;
-		}
-		if (match($0, /^smp_mb[[:space:]();\/*]*[[:alnum:]]/)) {
-			barrier_letter = substr($0, RLENGTH, 1);
-			if (barrier_letter ~ /A|D/)
-				new_barrier_name = "sync_smp_mb";
-			else if (barrier_letter ~ /B|C/)
-				new_barrier_name = "rs_smp_mb";
-			else {
-				print "Unrecognized memory barrier." > "/dev/null";
-				exit 1;
-			}
-
-			shift_fields(1, 1);
-			printf("%s", new_barrier_name) > outputfile;
-			continue;
-		}
-
-		# Skip definition of rcu_synchronize, since it is already
-		# defined in misc.h. Only present in old versions of srcu.
-		if (brace_nesting == 0 && paren_nesting == 0 &&
-		    $1 == "struct" && $2 == "rcu_synchronize" &&
-		    $0 ~ "^struct(" FS ")+rcu_synchronize(" FS ")+\\{") {
-			shift_fields(2, 0);
-			while (brace_nesting) {
-				if (NF < 2)
-					read_line();
-				shift_fields(1, 0);
-			}
-		}
-
-		# Skip definition of wakeme_after_rcu for the same reason
-		if (brace_nesting == 0 && $1 == "static" && $2 == "void" &&
-		    $3 == "wakeme_after_rcu") {
-			while (NF < 5)
-				read_line();
-			shift_fields(3, 0);
-			do {
-				while (NF < 3)
-					read_line();
-				shift_fields(1, 0);
-			} while (paren_nesting || brace_nesting);
-		}
-
-		if ($1 ~ /^(unsigned|long)$/ && NF < 3) {
-			read_line();
-			continue;
-		}
-
-		# Give srcu_batches_completed the correct type for old SRCU.
-		if (brace_nesting == 0 && $1 == "long" &&
-		    $2 == "srcu_batches_completed") {
-			update_fieldsep("", 0);
-			printf("unsigned ") > outputfile;
-			print_fields(2);
-			continue;
-		}
-		if (brace_nesting == 0 && $1 == "unsigned" && $2 == "long" &&
-		    $3 == "srcu_batches_completed") {
-			print_fields(3);
-			continue;
-		}
-
-		# Just print out the input code by default.
-		print_fields(1);
-	}
-	update_fieldsep("", 0);
-	print > outputfile;
-	next;
-}
-
-END {
-	update_fieldsep("", 0);
-
-	if (brace_nesting != 0) {
-		print "Unbalanced braces!" > "/dev/stderr";
-		exit 1;
-	}
-
-	# Define the rcu_batches
-	for (name in rcu_batches)
-		print "struct rcu_batch " name " = " rcu_batches[name] ";" > c_output;
-}
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/assume.h b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/assume.h
deleted file mode 100644
index 570a49d9da7e..000000000000
--- a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/assume.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef ASSUME_H
-#define ASSUME_H
-
-/* Provide an assumption macro that can be disabled for gcc. */
-#ifdef RUN
-#define assume(x) \
-	do { \
-		/* Evaluate x to suppress warnings. */ \
-		(void) (x); \
-	} while (0)
-
-#else
-#define assume(x) __CPROVER_assume(x)
-#endif
-
-#endif
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/barriers.h b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/barriers.h
deleted file mode 100644
index 3f95a768a03b..000000000000
--- a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/barriers.h
+++ /dev/null
@@ -1,41 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef BARRIERS_H
-#define BARRIERS_H
-
-#define barrier() __asm__ __volatile__("" : : : "memory")
-
-#ifdef RUN
-#define smp_mb() __sync_synchronize()
-#define smp_mb__after_unlock_lock() __sync_synchronize()
-#else
-/*
- * Copied from CBMC's implementation of __sync_synchronize(), which
- * seems to be disabled by default.
- */
-#define smp_mb() __CPROVER_fence("WWfence", "RRfence", "RWfence", "WRfence", \
-				 "WWcumul", "RRcumul", "RWcumul", "WRcumul")
-#define smp_mb__after_unlock_lock() __CPROVER_fence("WWfence", "RRfence", "RWfence", "WRfence", \
-				    "WWcumul", "RRcumul", "RWcumul", "WRcumul")
-#endif
-
-/*
- * Allow memory barriers to be disabled in either the read or write side
- * of SRCU individually.
- */
-
-#ifndef NO_SYNC_SMP_MB
-#define sync_smp_mb() smp_mb()
-#else
-#define sync_smp_mb() do {} while (0)
-#endif
-
-#ifndef NO_READ_SIDE_SMP_MB
-#define rs_smp_mb() smp_mb()
-#else
-#define rs_smp_mb() do {} while (0)
-#endif
-
-#define READ_ONCE(x) (*(volatile typeof(x) *) &(x))
-#define WRITE_ONCE(x) ((*(volatile typeof(x) *) &(x)) = (val))
-
-#endif
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/bug_on.h b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/bug_on.h
deleted file mode 100644
index 5e7912c6a521..000000000000
--- a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/bug_on.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef BUG_ON_H
-#define BUG_ON_H
-
-#include <assert.h>
-
-#define BUG() assert(0)
-#define BUG_ON(x) assert(!(x))
-
-/* Does it make sense to treat warnings as errors? */
-#define WARN() BUG()
-#define WARN_ON(x) (BUG_ON(x), false)
-
-#endif
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/combined_source.c b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/combined_source.c
deleted file mode 100644
index e67ee5b3dd7c..000000000000
--- a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/combined_source.c
+++ /dev/null
@@ -1,14 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <config.h>
-
-/* Include all source files. */
-
-#include "include_srcu.c"
-
-#include "preempt.c"
-#include "misc.c"
-
-/* Used by test.c files */
-#include <pthread.h>
-#include <stdlib.h>
-#include <linux/srcu.h>
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/config.h b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/config.h
deleted file mode 100644
index 283d7103334f..000000000000
--- a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/config.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* "Cheater" definitions based on restricted Kconfig choices. */
-
-#undef CONFIG_TINY_RCU
-#undef __CHECKER__
-#undef CONFIG_DEBUG_LOCK_ALLOC
-#undef CONFIG_DEBUG_OBJECTS_RCU_HEAD
-#undef CONFIG_HOTPLUG_CPU
-#undef CONFIG_MODULES
-#undef CONFIG_NO_HZ_FULL_SYSIDLE
-#undef CONFIG_PREEMPT_COUNT
-#undef CONFIG_PREEMPT_RCU
-#undef CONFIG_PROVE_RCU
-#undef CONFIG_RCU_NOCB_CPU
-#undef CONFIG_RCU_NOCB_CPU_ALL
-#undef CONFIG_RCU_STALL_COMMON
-#undef CONFIG_RCU_TRACE
-#undef CONFIG_RCU_USER_QS
-#undef CONFIG_TASKS_RCU
-#define CONFIG_TREE_RCU
-
-#define CONFIG_GENERIC_ATOMIC64
-
-#if NR_CPUS > 1
-#define CONFIG_SMP
-#else
-#undef CONFIG_SMP
-#endif
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/include_srcu.c b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/include_srcu.c
deleted file mode 100644
index e5202d4cff30..000000000000
--- a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/include_srcu.c
+++ /dev/null
@@ -1,32 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <config.h>
-
-#include <assert.h>
-#include <errno.h>
-#include <inttypes.h>
-#include <pthread.h>
-#include <stddef.h>
-#include <string.h>
-#include <sys/types.h>
-
-#include "int_typedefs.h"
-
-#include "barriers.h"
-#include "bug_on.h"
-#include "locks.h"
-#include "misc.h"
-#include "preempt.h"
-#include "percpu.h"
-#include "workqueues.h"
-
-#ifdef USE_SIMPLE_SYNC_SRCU
-#define synchronize_srcu(sp) synchronize_srcu_original(sp)
-#endif
-
-#include <srcu.c>
-
-#ifdef USE_SIMPLE_SYNC_SRCU
-#undef synchronize_srcu
-
-#include "simple_sync_srcu.c"
-#endif
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/int_typedefs.h b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/int_typedefs.h
deleted file mode 100644
index 0dd27aa517a7..000000000000
--- a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/int_typedefs.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef INT_TYPEDEFS_H
-#define INT_TYPEDEFS_H
-
-#include <inttypes.h>
-
-typedef int8_t s8;
-typedef uint8_t u8;
-typedef int16_t s16;
-typedef uint16_t u16;
-typedef int32_t s32;
-typedef uint32_t u32;
-typedef int64_t s64;
-typedef uint64_t u64;
-
-typedef int8_t __s8;
-typedef uint8_t __u8;
-typedef int16_t __s16;
-typedef uint16_t __u16;
-typedef int32_t __s32;
-typedef uint32_t __u32;
-typedef int64_t __s64;
-typedef uint64_t __u64;
-
-#define S8_C(x) INT8_C(x)
-#define U8_C(x) UINT8_C(x)
-#define S16_C(x) INT16_C(x)
-#define U16_C(x) UINT16_C(x)
-#define S32_C(x) INT32_C(x)
-#define U32_C(x) UINT32_C(x)
-#define S64_C(x) INT64_C(x)
-#define U64_C(x) UINT64_C(x)
-
-#endif
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/locks.h b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/locks.h
deleted file mode 100644
index 1e24827f96f1..000000000000
--- a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/locks.h
+++ /dev/null
@@ -1,221 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef LOCKS_H
-#define LOCKS_H
-
-#include <limits.h>
-#include <pthread.h>
-#include <stdbool.h>
-
-#include "assume.h"
-#include "bug_on.h"
-#include "preempt.h"
-
-int nondet_int(void);
-
-#define __acquire(x)
-#define __acquires(x)
-#define __release(x)
-#define __releases(x)
-
-/* Only use one lock mechanism. Select which one. */
-#ifdef PTHREAD_LOCK
-struct lock_impl {
-	pthread_mutex_t mutex;
-};
-
-static inline void lock_impl_lock(struct lock_impl *lock)
-{
-	BUG_ON(pthread_mutex_lock(&lock->mutex));
-}
-
-static inline void lock_impl_unlock(struct lock_impl *lock)
-{
-	BUG_ON(pthread_mutex_unlock(&lock->mutex));
-}
-
-static inline bool lock_impl_trylock(struct lock_impl *lock)
-{
-	int err = pthread_mutex_trylock(&lock->mutex);
-
-	if (!err)
-		return true;
-	else if (err == EBUSY)
-		return false;
-	BUG();
-}
-
-static inline void lock_impl_init(struct lock_impl *lock)
-{
-	pthread_mutex_init(&lock->mutex, NULL);
-}
-
-#define LOCK_IMPL_INITIALIZER {.mutex = PTHREAD_MUTEX_INITIALIZER}
-
-#else /* !defined(PTHREAD_LOCK) */
-/* Spinlock that assumes that it always gets the lock immediately. */
-
-struct lock_impl {
-	bool locked;
-};
-
-static inline bool lock_impl_trylock(struct lock_impl *lock)
-{
-#ifdef RUN
-	/* TODO: Should this be a test and set? */
-	return __sync_bool_compare_and_swap(&lock->locked, false, true);
-#else
-	__CPROVER_atomic_begin();
-	bool old_locked = lock->locked;
-	lock->locked = true;
-	__CPROVER_atomic_end();
-
-	/* Minimal barrier to prevent accesses leaking out of lock. */
-	__CPROVER_fence("RRfence", "RWfence");
-
-	return !old_locked;
-#endif
-}
-
-static inline void lock_impl_lock(struct lock_impl *lock)
-{
-	/*
-	 * CBMC doesn't support busy waiting, so just assume that the
-	 * lock is available.
-	 */
-	assume(lock_impl_trylock(lock));
-
-	/*
-	 * If the lock was already held by this thread then the assumption
-	 * is unsatisfiable (deadlock).
-	 */
-}
-
-static inline void lock_impl_unlock(struct lock_impl *lock)
-{
-#ifdef RUN
-	BUG_ON(!__sync_bool_compare_and_swap(&lock->locked, true, false));
-#else
-	/* Minimal barrier to prevent accesses leaking out of lock. */
-	__CPROVER_fence("RWfence", "WWfence");
-
-	__CPROVER_atomic_begin();
-	bool old_locked = lock->locked;
-	lock->locked = false;
-	__CPROVER_atomic_end();
-
-	BUG_ON(!old_locked);
-#endif
-}
-
-static inline void lock_impl_init(struct lock_impl *lock)
-{
-	lock->locked = false;
-}
-
-#define LOCK_IMPL_INITIALIZER {.locked = false}
-
-#endif /* !defined(PTHREAD_LOCK) */
-
-/*
- * Implement spinlocks using the lock mechanism. Wrap the lock to prevent mixing
- * locks of different types.
- */
-typedef struct {
-	struct lock_impl internal_lock;
-} spinlock_t;
-
-#define SPIN_LOCK_UNLOCKED {.internal_lock = LOCK_IMPL_INITIALIZER}
-#define __SPIN_LOCK_UNLOCKED(x) SPIN_LOCK_UNLOCKED
-#define DEFINE_SPINLOCK(x) spinlock_t x = SPIN_LOCK_UNLOCKED
-
-static inline void spin_lock_init(spinlock_t *lock)
-{
-	lock_impl_init(&lock->internal_lock);
-}
-
-static inline void spin_lock(spinlock_t *lock)
-{
-	/*
-	 * Spin locks also need to be removed in order to eliminate all
-	 * memory barriers. They are only used by the write side anyway.
-	 */
-#ifndef NO_SYNC_SMP_MB
-	preempt_disable();
-	lock_impl_lock(&lock->internal_lock);
-#endif
-}
-
-static inline void spin_unlock(spinlock_t *lock)
-{
-#ifndef NO_SYNC_SMP_MB
-	lock_impl_unlock(&lock->internal_lock);
-	preempt_enable();
-#endif
-}
-
-/* Don't bother with interrupts */
-#define spin_lock_irq(lock) spin_lock(lock)
-#define spin_unlock_irq(lock) spin_unlock(lock)
-#define spin_lock_irqsave(lock, flags) spin_lock(lock)
-#define spin_unlock_irqrestore(lock, flags) spin_unlock(lock)
-
-/*
- * This is supposed to return an int, but I think that a bool should work as
- * well.
- */
-static inline bool spin_trylock(spinlock_t *lock)
-{
-#ifndef NO_SYNC_SMP_MB
-	preempt_disable();
-	return lock_impl_trylock(&lock->internal_lock);
-#else
-	return true;
-#endif
-}
-
-struct completion {
-	/* Hopefully this won't overflow. */
-	unsigned int count;
-};
-
-#define COMPLETION_INITIALIZER(x) {.count = 0}
-#define DECLARE_COMPLETION(x) struct completion x = COMPLETION_INITIALIZER(x)
-#define DECLARE_COMPLETION_ONSTACK(x) DECLARE_COMPLETION(x)
-
-static inline void init_completion(struct completion *c)
-{
-	c->count = 0;
-}
-
-static inline void wait_for_completion(struct completion *c)
-{
-	unsigned int prev_count = __sync_fetch_and_sub(&c->count, 1);
-
-	assume(prev_count);
-}
-
-static inline void complete(struct completion *c)
-{
-	unsigned int prev_count = __sync_fetch_and_add(&c->count, 1);
-
-	BUG_ON(prev_count == UINT_MAX);
-}
-
-/* This function probably isn't very useful for CBMC. */
-static inline bool try_wait_for_completion(struct completion *c)
-{
-	BUG();
-}
-
-static inline bool completion_done(struct completion *c)
-{
-	return c->count;
-}
-
-/* TODO: Implement complete_all */
-static inline void complete_all(struct completion *c)
-{
-	BUG();
-}
-
-#endif
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/misc.c b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/misc.c
deleted file mode 100644
index 9440cc39e3c6..000000000000
--- a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/misc.c
+++ /dev/null
@@ -1,12 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <config.h>
-
-#include "misc.h"
-#include "bug_on.h"
-
-struct rcu_head;
-
-void wakeme_after_rcu(struct rcu_head *head)
-{
-	BUG();
-}
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/misc.h b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/misc.h
deleted file mode 100644
index aca50030f954..000000000000
--- a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/misc.h
+++ /dev/null
@@ -1,58 +0,0 @@
-#ifndef MISC_H
-#define MISC_H
-
-#include "assume.h"
-#include "int_typedefs.h"
-#include "locks.h"
-
-#include <linux/types.h>
-
-/* Probably won't need to deal with bottom halves. */
-static inline void local_bh_disable(void) {}
-static inline void local_bh_enable(void) {}
-
-#define MODULE_ALIAS(X)
-#define module_param(...)
-#define EXPORT_SYMBOL_GPL(x)
-
-#define container_of(ptr, type, member) ({			\
-	const typeof(((type *)0)->member) *__mptr = (ptr);	\
-	(type *)((char *)__mptr - offsetof(type, member));	\
-})
-
-#ifndef USE_SIMPLE_SYNC_SRCU
-/* Abuse udelay to make sure that busy loops terminate. */
-#define udelay(x) assume(0)
-
-#else
-
-/* The simple custom synchronize_srcu is ok with try_check_zero failing. */
-#define udelay(x) do { } while (0)
-#endif
-
-#define trace_rcu_torture_read(rcutorturename, rhp, secs, c_old, c) \
-	do { } while (0)
-
-#define notrace
-
-/* Avoid including rcupdate.h */
-struct rcu_synchronize {
-	struct rcu_head head;
-	struct completion completion;
-};
-
-void wakeme_after_rcu(struct rcu_head *head);
-
-#define rcu_lock_acquire(a) do { } while (0)
-#define rcu_lock_release(a) do { } while (0)
-#define rcu_lockdep_assert(c, s) do { } while (0)
-#define RCU_LOCKDEP_WARN(c, s) do { } while (0)
-
-/* Let CBMC non-deterministically choose switch between normal and expedited. */
-bool rcu_gp_is_normal(void);
-bool rcu_gp_is_expedited(void);
-
-/* Do the same for old versions of rcu. */
-#define rcu_expedited (rcu_gp_is_expedited())
-
-#endif
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/percpu.h b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/percpu.h
deleted file mode 100644
index 27e67a3f291f..000000000000
--- a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/percpu.h
+++ /dev/null
@@ -1,93 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef PERCPU_H
-#define PERCPU_H
-
-#include <stddef.h>
-#include "bug_on.h"
-#include "preempt.h"
-
-#define __percpu
-
-/* Maximum size of any percpu data. */
-#define PERCPU_OFFSET (4 * sizeof(long))
-
-/* Ignore alignment, as CBMC doesn't care about false sharing. */
-#define alloc_percpu(type) __alloc_percpu(sizeof(type), 1)
-
-static inline void *__alloc_percpu(size_t size, size_t align)
-{
-	BUG();
-	return NULL;
-}
-
-static inline void free_percpu(void *ptr)
-{
-	BUG();
-}
-
-#define per_cpu_ptr(ptr, cpu) \
-	((typeof(ptr)) ((char *) (ptr) + PERCPU_OFFSET * cpu))
-
-#define __this_cpu_inc(pcp) __this_cpu_add(pcp, 1)
-#define __this_cpu_dec(pcp) __this_cpu_sub(pcp, 1)
-#define __this_cpu_sub(pcp, n) __this_cpu_add(pcp, -(typeof(pcp)) (n))
-
-#define this_cpu_inc(pcp) this_cpu_add(pcp, 1)
-#define this_cpu_dec(pcp) this_cpu_sub(pcp, 1)
-#define this_cpu_sub(pcp, n) this_cpu_add(pcp, -(typeof(pcp)) (n))
-
-/* Make CBMC use atomics to work around bug. */
-#ifdef RUN
-#define THIS_CPU_ADD_HELPER(ptr, x) (*(ptr) += (x))
-#else
-/*
- * Split the atomic into a read and a write so that it has the least
- * possible ordering.
- */
-#define THIS_CPU_ADD_HELPER(ptr, x) \
-	do { \
-		typeof(ptr) this_cpu_add_helper_ptr = (ptr); \
-		typeof(ptr) this_cpu_add_helper_x = (x); \
-		typeof(*ptr) this_cpu_add_helper_temp; \
-		__CPROVER_atomic_begin(); \
-		this_cpu_add_helper_temp = *(this_cpu_add_helper_ptr); \
-		__CPROVER_atomic_end(); \
-		this_cpu_add_helper_temp += this_cpu_add_helper_x; \
-		__CPROVER_atomic_begin(); \
-		*(this_cpu_add_helper_ptr) = this_cpu_add_helper_temp; \
-		__CPROVER_atomic_end(); \
-	} while (0)
-#endif
-
-/*
- * For some reason CBMC needs an atomic operation even though this is percpu
- * data.
- */
-#define __this_cpu_add(pcp, n) \
-	do { \
-		BUG_ON(preemptible()); \
-		THIS_CPU_ADD_HELPER(per_cpu_ptr(&(pcp), thread_cpu_id), \
-				    (typeof(pcp)) (n)); \
-	} while (0)
-
-#define this_cpu_add(pcp, n) \
-	do { \
-		int this_cpu_add_impl_cpu = get_cpu(); \
-		THIS_CPU_ADD_HELPER(per_cpu_ptr(&(pcp), this_cpu_add_impl_cpu), \
-				    (typeof(pcp)) (n)); \
-		put_cpu(); \
-	} while (0)
-
-/*
- * This will cause a compiler warning because of the cast from char[][] to
- * type*. This will cause a compile time error if type is too big.
- */
-#define DEFINE_PER_CPU(type, name) \
-	char name[NR_CPUS][PERCPU_OFFSET]; \
-	typedef char percpu_too_big_##name \
-		[sizeof(type) > PERCPU_OFFSET ? -1 : 1]
-
-#define for_each_possible_cpu(cpu) \
-	for ((cpu) = 0; (cpu) < NR_CPUS; ++(cpu))
-
-#endif
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/preempt.c b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/preempt.c
deleted file mode 100644
index b4083ae348fb..000000000000
--- a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/preempt.c
+++ /dev/null
@@ -1,79 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <config.h>
-
-#include "preempt.h"
-
-#include "assume.h"
-#include "locks.h"
-
-/* Support NR_CPUS of at most 64 */
-#define CPU_PREEMPTION_LOCKS_INIT0 LOCK_IMPL_INITIALIZER
-#define CPU_PREEMPTION_LOCKS_INIT1 \
-	CPU_PREEMPTION_LOCKS_INIT0, CPU_PREEMPTION_LOCKS_INIT0
-#define CPU_PREEMPTION_LOCKS_INIT2 \
-	CPU_PREEMPTION_LOCKS_INIT1, CPU_PREEMPTION_LOCKS_INIT1
-#define CPU_PREEMPTION_LOCKS_INIT3 \
-	CPU_PREEMPTION_LOCKS_INIT2, CPU_PREEMPTION_LOCKS_INIT2
-#define CPU_PREEMPTION_LOCKS_INIT4 \
-	CPU_PREEMPTION_LOCKS_INIT3, CPU_PREEMPTION_LOCKS_INIT3
-#define CPU_PREEMPTION_LOCKS_INIT5 \
-	CPU_PREEMPTION_LOCKS_INIT4, CPU_PREEMPTION_LOCKS_INIT4
-
-/*
- * Simulate disabling preemption by locking a particular cpu. NR_CPUS
- * should be the actual number of cpus, not just the maximum.
- */
-struct lock_impl cpu_preemption_locks[NR_CPUS] = {
-	CPU_PREEMPTION_LOCKS_INIT0
-#if (NR_CPUS - 1) & 1
-	, CPU_PREEMPTION_LOCKS_INIT0
-#endif
-#if (NR_CPUS - 1) & 2
-	, CPU_PREEMPTION_LOCKS_INIT1
-#endif
-#if (NR_CPUS - 1) & 4
-	, CPU_PREEMPTION_LOCKS_INIT2
-#endif
-#if (NR_CPUS - 1) & 8
-	, CPU_PREEMPTION_LOCKS_INIT3
-#endif
-#if (NR_CPUS - 1) & 16
-	, CPU_PREEMPTION_LOCKS_INIT4
-#endif
-#if (NR_CPUS - 1) & 32
-	, CPU_PREEMPTION_LOCKS_INIT5
-#endif
-};
-
-#undef CPU_PREEMPTION_LOCKS_INIT0
-#undef CPU_PREEMPTION_LOCKS_INIT1
-#undef CPU_PREEMPTION_LOCKS_INIT2
-#undef CPU_PREEMPTION_LOCKS_INIT3
-#undef CPU_PREEMPTION_LOCKS_INIT4
-#undef CPU_PREEMPTION_LOCKS_INIT5
-
-__thread int thread_cpu_id;
-__thread int preempt_disable_count;
-
-void preempt_disable(void)
-{
-	BUG_ON(preempt_disable_count < 0 || preempt_disable_count == INT_MAX);
-
-	if (preempt_disable_count++)
-		return;
-
-	thread_cpu_id = nondet_int();
-	assume(thread_cpu_id >= 0);
-	assume(thread_cpu_id < NR_CPUS);
-	lock_impl_lock(&cpu_preemption_locks[thread_cpu_id]);
-}
-
-void preempt_enable(void)
-{
-	BUG_ON(preempt_disable_count < 1);
-
-	if (--preempt_disable_count)
-		return;
-
-	lock_impl_unlock(&cpu_preemption_locks[thread_cpu_id]);
-}
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/preempt.h b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/preempt.h
deleted file mode 100644
index f8b762cd214c..000000000000
--- a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/preempt.h
+++ /dev/null
@@ -1,59 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef PREEMPT_H
-#define PREEMPT_H
-
-#include <stdbool.h>
-
-#include "bug_on.h"
-
-/* This flag contains garbage if preempt_disable_count is 0. */
-extern __thread int thread_cpu_id;
-
-/* Support recursive preemption disabling. */
-extern __thread int preempt_disable_count;
-
-void preempt_disable(void);
-void preempt_enable(void);
-
-static inline void preempt_disable_notrace(void)
-{
-	preempt_disable();
-}
-
-static inline void preempt_enable_no_resched(void)
-{
-	preempt_enable();
-}
-
-static inline void preempt_enable_notrace(void)
-{
-	preempt_enable();
-}
-
-static inline int preempt_count(void)
-{
-	return preempt_disable_count;
-}
-
-static inline bool preemptible(void)
-{
-	return !preempt_count();
-}
-
-static inline int get_cpu(void)
-{
-	preempt_disable();
-	return thread_cpu_id;
-}
-
-static inline void put_cpu(void)
-{
-	preempt_enable();
-}
-
-static inline void might_sleep(void)
-{
-	BUG_ON(preempt_disable_count);
-}
-
-#endif
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/simple_sync_srcu.c b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/simple_sync_srcu.c
deleted file mode 100644
index 97f592048e0b..000000000000
--- a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/simple_sync_srcu.c
+++ /dev/null
@@ -1,51 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <config.h>
-
-#include <assert.h>
-#include <errno.h>
-#include <inttypes.h>
-#include <pthread.h>
-#include <stddef.h>
-#include <string.h>
-#include <sys/types.h>
-
-#include "int_typedefs.h"
-
-#include "barriers.h"
-#include "bug_on.h"
-#include "locks.h"
-#include "misc.h"
-#include "preempt.h"
-#include "percpu.h"
-#include "workqueues.h"
-
-#include <linux/srcu.h>
-
-/* Functions needed from modify_srcu.c */
-bool try_check_zero(struct srcu_struct *sp, int idx, int trycount);
-void srcu_flip(struct srcu_struct *sp);
-
-/* Simpler implementation of synchronize_srcu that ignores batching. */
-void synchronize_srcu(struct srcu_struct *sp)
-{
-	int idx;
-	/*
-	 * This code assumes that try_check_zero will succeed anyway,
-	 * so there is no point in multiple tries.
-	 */
-	const int trycount = 1;
-
-	might_sleep();
-
-	/* Ignore the lock, as multiple writers aren't working yet anyway. */
-
-	idx = 1 ^ (sp->completed & 1);
-
-	/* For comments see srcu_advance_batches. */
-
-	assume(try_check_zero(sp, idx, trycount));
-
-	srcu_flip(sp);
-
-	assume(try_check_zero(sp, idx^1, trycount));
-}
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/workqueues.h b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/workqueues.h
deleted file mode 100644
index 28b960300971..000000000000
--- a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/workqueues.h
+++ /dev/null
@@ -1,103 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef WORKQUEUES_H
-#define WORKQUEUES_H
-
-#include <stdbool.h>
-
-#include "barriers.h"
-#include "bug_on.h"
-#include "int_typedefs.h"
-
-#include <linux/types.h>
-
-/* Stub workqueue implementation. */
-
-struct work_struct;
-typedef void (*work_func_t)(struct work_struct *work);
-void delayed_work_timer_fn(unsigned long __data);
-
-struct work_struct {
-/*	atomic_long_t data; */
-	unsigned long data;
-
-	struct list_head entry;
-	work_func_t func;
-#ifdef CONFIG_LOCKDEP
-	struct lockdep_map lockdep_map;
-#endif
-};
-
-struct timer_list {
-	struct hlist_node	entry;
-	unsigned long		expires;
-	void			(*function)(unsigned long);
-	unsigned long		data;
-	u32			flags;
-	int			slack;
-};
-
-struct delayed_work {
-	struct work_struct work;
-	struct timer_list timer;
-
-	/* target workqueue and CPU ->timer uses to queue ->work */
-	struct workqueue_struct *wq;
-	int cpu;
-};
-
-
-static inline bool schedule_work(struct work_struct *work)
-{
-	BUG();
-	return true;
-}
-
-static inline bool schedule_work_on(int cpu, struct work_struct *work)
-{
-	BUG();
-	return true;
-}
-
-static inline bool queue_work(struct workqueue_struct *wq,
-			      struct work_struct *work)
-{
-	BUG();
-	return true;
-}
-
-static inline bool queue_delayed_work(struct workqueue_struct *wq,
-				      struct delayed_work *dwork,
-				      unsigned long delay)
-{
-	BUG();
-	return true;
-}
-
-#define INIT_WORK(w, f) \
-	do { \
-		(w)->data = 0; \
-		(w)->func = (f); \
-	} while (0)
-
-#define INIT_DELAYED_WORK(w, f) INIT_WORK(&(w)->work, (f))
-
-#define __WORK_INITIALIZER(n, f) { \
-		.data = 0, \
-		.entry = { &(n).entry, &(n).entry }, \
-		.func = f \
-	}
-
-/* Don't bother initializing timer. */
-#define __DELAYED_WORK_INITIALIZER(n, f, tflags) { \
-	.work = __WORK_INITIALIZER((n).work, (f)), \
-	}
-
-#define DECLARE_WORK(n, f) \
-	struct workqueue_struct n = __WORK_INITIALIZER
-
-#define DECLARE_DELAYED_WORK(n, f) \
-	struct delayed_work n = __DELAYED_WORK_INITIALIZER(n, f, 0)
-
-#define system_power_efficient_wq ((struct workqueue_struct *) NULL)
-
-#endif
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/.gitignore b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/.gitignore
deleted file mode 100644
index d65462d64816..000000000000
--- a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-*.out
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/Makefile b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/Makefile
deleted file mode 100644
index ad21b925fbb4..000000000000
--- a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/Makefile
+++ /dev/null
@@ -1,12 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-CBMC_FLAGS = -I../.. -I../../src -I../../include -I../../empty_includes -32 -pointer-check -mm pso
-
-all:
-	for i in ./*.pass; do \
-		echo $$i ; \
-		CBMC_FLAGS="$(CBMC_FLAGS)" sh ../test_script.sh --should-pass $$i > $$i.out 2>&1 ; \
-	done
-	for i in ./*.fail; do \
-		echo $$i ; \
-		CBMC_FLAGS="$(CBMC_FLAGS)" sh ../test_script.sh --should-fail $$i > $$i.out 2>&1 ; \
-	done
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/assert_end.fail b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/assert_end.fail
deleted file mode 100644
index 40c8075919d1..000000000000
--- a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/assert_end.fail
+++ /dev/null
@@ -1 +0,0 @@
-test_cbmc_options="-DASSERT_END"
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/force.fail b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/force.fail
deleted file mode 100644
index ada5baf0b60d..000000000000
--- a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/force.fail
+++ /dev/null
@@ -1 +0,0 @@
-test_cbmc_options="-DFORCE_FAILURE"
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/force2.fail b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/force2.fail
deleted file mode 100644
index 8fe00c8db466..000000000000
--- a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/force2.fail
+++ /dev/null
@@ -1 +0,0 @@
-test_cbmc_options="-DFORCE_FAILURE_2"
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/force3.fail b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/force3.fail
deleted file mode 100644
index 612ed6772844..000000000000
--- a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/force3.fail
+++ /dev/null
@@ -1 +0,0 @@
-test_cbmc_options="-DFORCE_FAILURE_3"
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/main.pass b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/main.pass
deleted file mode 100644
index e69de29bb2d1..000000000000
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/test.c b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/test.c
deleted file mode 100644
index 2ce2016f7871..000000000000
--- a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/test.c
+++ /dev/null
@@ -1,73 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <src/combined_source.c>
-
-int x;
-int y;
-
-int __unbuffered_tpr_x;
-int __unbuffered_tpr_y;
-
-DEFINE_SRCU(ss);
-
-void rcu_reader(void)
-{
-	int idx;
-
-#ifndef FORCE_FAILURE_3
-	idx = srcu_read_lock(&ss);
-#endif
-	might_sleep();
-
-	__unbuffered_tpr_y = READ_ONCE(y);
-#ifdef FORCE_FAILURE
-	srcu_read_unlock(&ss, idx);
-	idx = srcu_read_lock(&ss);
-#endif
-	WRITE_ONCE(x, 1);
-
-#ifndef FORCE_FAILURE_3
-	srcu_read_unlock(&ss, idx);
-#endif
-	might_sleep();
-}
-
-void *thread_update(void *arg)
-{
-	WRITE_ONCE(y, 1);
-#ifndef FORCE_FAILURE_2
-	synchronize_srcu(&ss);
-#endif
-	might_sleep();
-	__unbuffered_tpr_x = READ_ONCE(x);
-
-	return NULL;
-}
-
-void *thread_process_reader(void *arg)
-{
-	rcu_reader();
-
-	return NULL;
-}
-
-int main(int argc, char *argv[])
-{
-	pthread_t tu;
-	pthread_t tpr;
-
-	if (pthread_create(&tu, NULL, thread_update, NULL))
-		abort();
-	if (pthread_create(&tpr, NULL, thread_process_reader, NULL))
-		abort();
-	if (pthread_join(tu, NULL))
-		abort();
-	if (pthread_join(tpr, NULL))
-		abort();
-	assert(__unbuffered_tpr_y != 0 || __unbuffered_tpr_x != 0);
-
-#ifdef ASSERT_END
-	assert(0);
-#endif
-
-	return 0;
-}
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/test_script.sh b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/test_script.sh
deleted file mode 100755
index 2fe1f0339b4f..000000000000
--- a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/test_script.sh
+++ /dev/null
@@ -1,103 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-# This script expects a mode (either --should-pass or --should-fail) followed by
-# an input file. The script uses the following environment variables. The test C
-# source file is expected to be named test.c in the directory containing the
-# input file.
-#
-# CBMC: The command to run CBMC. Default: cbmc
-# CBMC_FLAGS: Additional flags to pass to CBMC
-# NR_CPUS: Number of cpus to run tests with. Default specified by the test
-# SYNC_SRCU_MODE: Choose implementation of synchronize_srcu. Defaults to simple.
-#                 kernel: Version included in the linux kernel source.
-#                 simple: Use try_check_zero directly.
-#
-# The input file is a script that is sourced by this file. It can define any of
-# the following variables to configure the test.
-#
-# test_cbmc_options: Extra options to pass to CBMC.
-# min_cpus_fail: Minimum number of CPUs (NR_CPUS) for verification to fail.
-#                The test is expected to pass if it is run with fewer. (Only
-#                useful for .fail files)
-# default_cpus: Quantity of CPUs to use for the test, if not specified on the
-#               command line. Default: Larger of 2 and MIN_CPUS_FAIL.
-
-set -e
-
-if test "$#" -ne 2; then
-	echo "Expected one option followed by an input file" 1>&2
-	exit 99
-fi
-
-if test "x$1" = "x--should-pass"; then
-	should_pass="yes"
-elif test "x$1" = "x--should-fail"; then
-	should_pass="no"
-else
-	echo "Unrecognized argument '$1'" 1>&2
-
-	# Exit code 99 indicates a hard error.
-	exit 99
-fi
-
-CBMC=${CBMC:-cbmc}
-
-SYNC_SRCU_MODE=${SYNC_SRCU_MODE:-simple}
-
-case ${SYNC_SRCU_MODE} in
-kernel) sync_srcu_mode_flags="" ;;
-simple) sync_srcu_mode_flags="-DUSE_SIMPLE_SYNC_SRCU" ;;
-
-*)
-	echo "Unrecognized argument '${SYNC_SRCU_MODE}'" 1>&2
-	exit 99
-	;;
-esac
-
-min_cpus_fail=1
-
-c_file=`dirname "$2"`/test.c
-
-# Source the input file.
-. $2
-
-if test ${min_cpus_fail} -gt 2; then
-	default_default_cpus=${min_cpus_fail}
-else
-	default_default_cpus=2
-fi
-default_cpus=${default_cpus:-${default_default_cpus}}
-cpus=${NR_CPUS:-${default_cpus}}
-
-# Check if there are two few cpus to make the test fail.
-if test $cpus -lt ${min_cpus_fail:-0}; then
-	should_pass="yes"
-fi
-
-cbmc_opts="-DNR_CPUS=${cpus} ${sync_srcu_mode_flags} ${test_cbmc_options} ${CBMC_FLAGS}"
-
-echo "Running CBMC: ${CBMC} ${cbmc_opts} ${c_file}"
-if ${CBMC} ${cbmc_opts} "${c_file}"; then
-	# Verification successful. Make sure that it was supposed to verify.
-	test "x${should_pass}" = xyes
-else
-	cbmc_exit_status=$?
-
-	# An exit status of 10 indicates a failed verification.
-	# (see cbmc_parse_optionst::do_bmc in the CBMC source code)
-	if test ${cbmc_exit_status} -eq 10 && test "x${should_pass}" = xno; then
-		:
-	else
-		echo "CBMC returned ${cbmc_exit_status} exit status" 1>&2
-
-		# Parse errors have exit status 6. Any other type of error
-		# should be considered a hard error.
-		if test ${cbmc_exit_status} -ne 6 && \
-		   test ${cbmc_exit_status} -ne 10; then
-			exit 99
-		else
-			exit 1
-		fi
-	fi
-fi
-- 
2.40.1

