Return-Path: <linux-kernel+bounces-3586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 280DF816E16
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C38942847AC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82FF82EE9;
	Mon, 18 Dec 2023 12:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eHkQINzW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A0480E0B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 12:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--glider.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5534b41f529so478276a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 04:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702903258; x=1703508058; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tbTPsWqaE0zk/zTD6ZnQV+kyVQAmtpdkrOV6ohS4lXU=;
        b=eHkQINzWdORAI45+Bb7WutxyiritI/YLFdw6Z9ArWl85qNYtIQrw94Jf0bNb2qjG2R
         cGLBldv6KEqkSdac19G+ckFEeHuR7Z1/u1HLCi0gi+qrz7c5NrQJL9jw9n7+BfMoKLJW
         /rPlAybna3+FRZeoRDrCWWWbwyxnl5gEvD5FSk0+IEbm7/qX3h3woHQGKNV0tgkGohV2
         0mVtoFmbkZ94Al4Jhe9DGZFyH0asEWxRg4PC8oWGe6qyA2vwtJRCLFI292EhzZilQ/my
         1zgJT0Sf1GxBUgxrnasH9R6z84bbvSgzBqExAa0XABzSGlEYhbHoztFOKTyFNZ6G5tKZ
         cs7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702903258; x=1703508058;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tbTPsWqaE0zk/zTD6ZnQV+kyVQAmtpdkrOV6ohS4lXU=;
        b=tQ+ZZ6VcDtFkujbyV7T3XhNYK+fPycFGcz2Zpm02SrmTCJBRrppMbxSBisHdoRbmqG
         kw6A2mQkbQYYS73haAB8c+2Fle3zmDQujQuVOHWstIImcOU6KNOb/RTRRk0TmtPFkr/s
         NNW49DohZ+2HvEQ2pisNJHog1JvPaGSDrfeKZ2t4JQeqHoLdWqWbpSzvJSIjlTeXDPET
         ZV3kkm44tm95crmVq4HL1R5M8c5BY/lUnV5yIoAAwEvDu7OmyLfo1EMps1KCCuZfPvVR
         D6uz/uVy9eLXnmW8ouJKDS3JF+qDWVaJ6ditLqfRo+Vu9O/bO0lWapa/BuVXzsvaGAVj
         64hw==
X-Gm-Message-State: AOJu0Yx+BEHhczkre6B0JyZ3ZQhoP92PQ+cJhCdtwxZbWXMWHIdDHqx5
	tNvXzfPSqMEgtd3x6BZqPFtQDWTfM7k=
X-Google-Smtp-Source: AGHT+IFMV7VwSrjypK+QQcM8Gkbn6+2AcXQTl/9IjPplGqpiMfDbdEPDzKVag/hy05/X3j0+nq6wM7Yrbe4=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:9a3f:c8e7:1395:806e])
 (user=glider job=sendgmr) by 2002:a50:cc8e:0:b0:54d:15e9:560 with SMTP id
 q14-20020a50cc8e000000b0054d15e90560mr125342edi.2.1702903257881; Mon, 18 Dec
 2023 04:40:57 -0800 (PST)
Date: Mon, 18 Dec 2023 13:40:33 +0100
In-Reply-To: <20231218124033.551770-1-glider@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231218124033.551770-1-glider@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231218124033.551770-8-glider@google.com>
Subject: [PATCH v11-mte 7/7] arm64: mte: implement CONFIG_ARM64_MTE_SWAP_STATS
From: Alexander Potapenko <glider@google.com>
To: glider@google.com, catalin.marinas@arm.com, will@kernel.org, 
	pcc@google.com, andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com, 
	aleksander.lobakin@intel.com, linux@rasmusvillemoes.dk, yury.norov@gmail.com, 
	alexandru.elisei@arm.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	eugenis@google.com, syednwaris@gmail.com, william.gray@linaro.org
Content-Type: text/plain; charset="UTF-8"

Provide a config to collect the usage statistics for ARM MTE tag
compression. This patch introduces allocation/deallocation counters
for buffers that were stored uncompressed (and thus occupy 128 bytes of
heap plus the Xarray overhead to store a pointer) and those that were
compressed into 8-byte pointers (effectively using 0 bytes of heap in
addition to the Xarray overhead).

The counters are exposed to the userspace via
/sys/kernel/debug/mteswap/stats:

  # cat /sys/kernel/debug/mteswap/stats
  8 bytes:      102496 allocations,     67302 deallocations
  128 bytes:    212234 allocations,     178278 deallocations
  uncompressed tag storage size:        8851200
  compressed tag storage size:  4346368

Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Yury Norov <yury.norov@gmail.com>

---

This patch was split off from the "arm64: mte: add compression support
to mteswap.c" patch
(https://lore.kernel.org/linux-arm-kernel/ZUVulBKVYK7cq2rJ@yury-ThinkPad/T/#m819ec30beb9de53d5c442f7e3247456f8966d88a)

v11-mte:
 - add Yury's Reviewed-by:

v10-mte:
 - added Catalin's Acked-by:

v9:
 - add this patch, put the stats behind a separate config,
   mention /sys/kernel/debug/mteswap/stats in the documentation
---
 .../arch/arm64/mte-tag-compression.rst        | 12 +++
 arch/arm64/Kconfig                            | 15 +++
 arch/arm64/mm/mteswap.c                       | 93 ++++++++++++++++++-
 3 files changed, 118 insertions(+), 2 deletions(-)

diff --git a/Documentation/arch/arm64/mte-tag-compression.rst b/Documentation/arch/arm64/mte-tag-compression.rst
index 8fe6b51a9db6d..4c25b96f7d4b5 100644
--- a/Documentation/arch/arm64/mte-tag-compression.rst
+++ b/Documentation/arch/arm64/mte-tag-compression.rst
@@ -145,6 +145,18 @@ Tag compression and decompression implicitly rely on the fixed MTE tag size
 (4 bits) and number of tags per page. Should these values change, the algorithm
 may need to be revised.
 
+Stats
+=====
+
+When `CONFIG_ARM64_MTE_SWAP_STATS` is enabled, `arch/arm64/mm/mteswap.c` exports
+usage statistics for tag compression used when swapping tagged pages. The data
+can be accessed via debugfs::
+
+  # cat /sys/kernel/debug/mteswap/stats
+  8 bytes:        10438 allocations,      10417 deallocations
+  128 bytes:      26180 allocations,      26179 deallocations
+  uncompressed tag storage size:  2816
+  compressed tag storage size:    128
 
 Programming Interface
 =====================
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6a1397a96f2f0..49a786c7edadd 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2100,6 +2100,21 @@ config ARM64_MTE_COMP_KUNIT_TEST
 	  be compressed into pointer-size values and correctly decompressed
 	  afterwards.
 
+config ARM64_MTE_SWAP_STATS
+	bool "Collect usage statistics of tag compression for swapped MTE tags"
+	default y
+	depends on ARM64_MTE && ARM64_MTE_COMP
+	help
+	  Collect usage statistics for ARM64 MTE tag compression during swapping.
+
+	  Adds allocation/deallocation counters for buffers that were stored
+	  uncompressed (and thus occupy 128 bytes of heap plus the Xarray
+	  overhead to store a pointer) and those that were compressed into
+	  8-byte pointers (effectively using 0 bytes of heap in addition to
+	  the Xarray overhead).
+	  The counters are exposed to the userspace via
+	  /sys/kernel/debug/mteswap/stats.
+
 config ARM64_SVE
 	bool "ARM Scalable Vector Extension support"
 	default y
diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
index 70f5c8ecd640d..1c6c78b9a9037 100644
--- a/arch/arm64/mm/mteswap.c
+++ b/arch/arm64/mm/mteswap.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/debugfs.h>
 #include <linux/pagemap.h>
 #include <linux/xarray.h>
 #include <linux/slab.h>
@@ -11,16 +12,54 @@
 
 static DEFINE_XARRAY(mte_pages);
 
+enum mteswap_counters {
+	MTESWAP_CTR_INLINE = 0,
+	MTESWAP_CTR_OUTLINE,
+	MTESWAP_CTR_SIZE
+};
+
+#if defined(CONFIG_ARM64_MTE_SWAP_STATS)
+static atomic_long_t alloc_counters[MTESWAP_CTR_SIZE];
+static atomic_long_t dealloc_counters[MTESWAP_CTR_SIZE];
+
+static void inc_alloc_counter(int kind)
+{
+	atomic_long_inc(&alloc_counters[kind]);
+}
+
+static void inc_dealloc_counter(int kind)
+{
+	atomic_long_inc(&dealloc_counters[kind]);
+}
+#else
+static void inc_alloc_counter(int kind)
+{
+}
+
+static void inc_dealloc_counter(int kind)
+{
+}
+#endif
+
 void *mte_allocate_tag_storage(void)
 {
+	void *ret;
+
 	/* tags granule is 16 bytes, 2 tags stored per byte */
-	return kmalloc(MTE_PAGE_TAG_STORAGE, GFP_KERNEL);
+	ret = kmalloc(MTE_PAGE_TAG_STORAGE, GFP_KERNEL);
+	if (ret)
+		inc_alloc_counter(MTESWAP_CTR_OUTLINE);
+	return ret;
 }
 
 void mte_free_tag_storage(char *storage)
 {
-	if (!mte_is_compressed(storage))
+	if (!mte_is_compressed(storage)) {
 		kfree(storage);
+		inc_dealloc_counter(MTESWAP_CTR_OUTLINE);
+	} else {
+		inc_dealloc_counter(MTESWAP_CTR_INLINE);
+	}
 }
 
 int mte_save_tags(struct page *page)
@@ -39,6 +78,7 @@ int mte_save_tags(struct page *page)
 	if (compressed_storage) {
 		mte_free_tag_storage(tag_storage);
 		tag_storage = compressed_storage;
+		inc_alloc_counter(MTESWAP_CTR_INLINE);
 	}
 
 	/* lookup the swap entry.val from the page */
@@ -98,3 +138,52 @@ void mte_invalidate_tags_area(int type)
 	}
 	xa_unlock(&mte_pages);
 }
+
+#if defined(CONFIG_ARM64_MTE_SWAP_STATS)
+/* DebugFS interface. */
+static int stats_show(struct seq_file *seq, void *v)
+{
+	unsigned long total_mem_alloc = 0, total_mem_dealloc = 0;
+	unsigned long total_num_alloc = 0, total_num_dealloc = 0;
+	unsigned long sizes[2] = { 8, MTE_PAGE_TAG_STORAGE };
+	long alloc, dealloc;
+	unsigned long size;
+	int i;
+
+	for (i = 0; i < MTESWAP_CTR_SIZE; i++) {
+		alloc = atomic_long_read(&alloc_counters[i]);
+		dealloc = atomic_long_read(&dealloc_counters[i]);
+		total_num_alloc += alloc;
+		total_num_dealloc += dealloc;
+		size = sizes[i];
+		/*
+		 * Do not count 8-byte buffers towards compressed tag storage
+		 * size.
+		 */
+		if (i) {
+			total_mem_alloc += (size * alloc);
+			total_mem_dealloc += (size * dealloc);
+		}
+		seq_printf(seq,
+			   "%lu bytes:\t%lu allocations,\t%lu deallocations\n",
+			   size, alloc, dealloc);
+	}
+	seq_printf(seq, "uncompressed tag storage size:\t%lu\n",
+		   (total_num_alloc - total_num_dealloc) *
+			   MTE_PAGE_TAG_STORAGE);
+	seq_printf(seq, "compressed tag storage size:\t%lu\n",
+		   total_mem_alloc - total_mem_dealloc);
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(stats);
+
+static int mteswap_init(void)
+{
+	struct dentry *mteswap_dir;
+
+	mteswap_dir = debugfs_create_dir("mteswap", NULL);
+	debugfs_create_file("stats", 0444, mteswap_dir, NULL, &stats_fops);
+	return 0;
+}
+module_init(mteswap_init);
+#endif
-- 
2.43.0.472.g3155946c3a-goog


