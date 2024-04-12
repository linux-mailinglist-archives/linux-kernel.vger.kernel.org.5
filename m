Return-Path: <linux-kernel+bounces-142534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8088A2CE3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D34DA2867FE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2915E502B2;
	Fri, 12 Apr 2024 10:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="baQvrPg4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C022B4437D;
	Fri, 12 Apr 2024 10:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712919051; cv=none; b=agI63FN97bc6ZGSzyIGyg/YD1qjfqlIEipDHly9XTQk87NdRjRoxh4WhQmJPLGAxRhmSspruYssyrnbVqF1hk6srm9pi4yLeQsjLyrdVJVjj0GQ3kf110a21a794cRiepx13M6RnqB+Vi05RdASbLke/qCKM169q7kTL6kSrxds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712919051; c=relaxed/simple;
	bh=GohIU7PTUMgQBbmhyynUeHFzjmQmOHowzMSb+cbaCPE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NF7UHHQw6Gsc7ke9mov+JYCT7bHeBtE4tXMZaQRQXxgjmA70P/TVJ0AbpLVj86YSNPoenr2e4jgXq/j25daAZoN59djmXQWGBBz/PAKXIyxx0MZPQVVW+D85QL6sz42VYsd61HSnGIpY9YNylGI27JJ25pydXcyl4IkeBczZinE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=baQvrPg4; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712919050; x=1744455050;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GohIU7PTUMgQBbmhyynUeHFzjmQmOHowzMSb+cbaCPE=;
  b=baQvrPg4KUYBRUMt7GKG0EkLjG6Ixds7hMy8cBawFGUAGrTTz3lKZ+GA
   EC76f6bdUu0OYSCRZjcMfHmVyWCG54SdG7vnM17E9Byna66Zx47OCnmP4
   j0AhOxRBT1c4bn0ksWra3c2xKaRiOI3VnnqB/CuUpPZfMAONSJc+l45ML
   AHFb+C7J2Lw9+Pm2UWLJoaMl0ltrD5L2XyB+13ovhkyj42d5cfdurkoSw
   ML8yn+dqd2yjGatDJ+5nGCXN8MRyvSAsL9XfJKyJXal+FFEzElZ0sUyna
   2LGmtwa2w/jZ9CRivsyaqUIS81O5akuEN8s222kfIQ5i5OEU3oRr35l66
   g==;
X-CSE-ConnectionGUID: AMj6cBckRVW0L3N/TegX7g==
X-CSE-MsgGUID: UX1nFCoZTga6n7GmT40LZQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="19082267"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="19082267"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 03:50:49 -0700
X-CSE-ConnectionGUID: Qv/+1vgsTmGU+jKOZFjuQg==
X-CSE-MsgGUID: 06IKaASSQQWtqxu8/BEc1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="25853694"
Received: from dev-qz.sh.intel.com (HELO localhost) ([10.239.147.89])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 03:50:46 -0700
From: qiang4.zhang@linux.intel.com
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Qiang Zhang <qiang4.zhang@intel.com>,
	Stable@vger.kernel.org
Subject: [PATCH v2] bootconfig: use memblock_free_late to free xbc memory to buddy
Date: Fri, 12 Apr 2024 18:49:41 +0800
Message-Id: <20240412104940.456257-1-qiang4.zhang@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qiang Zhang <qiang4.zhang@intel.com>

On the time to free xbc memory in xbc_exit(), memblock may has handed
over memory to buddy allocator. So it doesn't make sense to free memory
back to memblock. memblock_free() called by xbc_exit() even causes UAF bugs
on architectures with CONFIG_ARCH_KEEP_MEMBLOCK disabled like x86.
Following KASAN logs shows this case.

This patch fixes the xbc memory free problem by calling memblock_free()
in early xbc init error rewind path and calling memblock_free_late() in
xbc exit path to free memory to buddy allocator.

[    9.410890] ==================================================================
[    9.418962] BUG: KASAN: use-after-free in memblock_isolate_range+0x12d/0x260
[    9.426850] Read of size 8 at addr ffff88845dd30000 by task swapper/0/1

[    9.435901] CPU: 9 PID: 1 Comm: swapper/0 Tainted: G     U             6.9.0-rc3-00208-g586b5dfb51b9 #5
[    9.446403] Hardware name: Intel Corporation RPLP LP5 (CPU:RaptorLake)/RPLP LP5 (ID:13), BIOS IRPPN02.01.01.00.00.19.015.D-00000000 Dec 28 2023
[    9.460789] Call Trace:
[    9.463518]  <TASK>
[    9.465859]  dump_stack_lvl+0x53/0x70
[    9.469949]  print_report+0xce/0x610
[    9.473944]  ? __virt_addr_valid+0xf5/0x1b0
[    9.478619]  ? memblock_isolate_range+0x12d/0x260
[    9.483877]  kasan_report+0xc6/0x100
[    9.487870]  ? memblock_isolate_range+0x12d/0x260
[    9.493125]  memblock_isolate_range+0x12d/0x260
[    9.498187]  memblock_phys_free+0xb4/0x160
[    9.502762]  ? __pfx_memblock_phys_free+0x10/0x10
[    9.508021]  ? mutex_unlock+0x7e/0xd0
[    9.512111]  ? __pfx_mutex_unlock+0x10/0x10
[    9.516786]  ? kernel_init_freeable+0x2d4/0x430
[    9.521850]  ? __pfx_kernel_init+0x10/0x10
[    9.526426]  xbc_exit+0x17/0x70
[    9.529935]  kernel_init+0x38/0x1e0
[    9.533829]  ? _raw_spin_unlock_irq+0xd/0x30
[    9.538601]  ret_from_fork+0x2c/0x50
[    9.542596]  ? __pfx_kernel_init+0x10/0x10
[    9.547170]  ret_from_fork_asm+0x1a/0x30
[    9.551552]  </TASK>

[    9.555649] The buggy address belongs to the physical page:
[    9.561875] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x45dd30
[    9.570821] flags: 0x200000000000000(node=0|zone=2)
[    9.576271] page_type: 0xffffffff()
[    9.580167] raw: 0200000000000000 ffffea0011774c48 ffffea0012ba1848 0000000000000000
[    9.588823] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[    9.597476] page dumped because: kasan: bad access detected

[    9.605362] Memory state around the buggy address:
[    9.610714]  ffff88845dd2ff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    9.618786]  ffff88845dd2ff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    9.626857] >ffff88845dd30000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[    9.634930]                    ^
[    9.638534]  ffff88845dd30080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[    9.646605]  ffff88845dd30100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[    9.654675] ==================================================================

Cc: Stable@vger.kernel.org
Signed-off-by: Qiang Zhang <qiang4.zhang@intel.com>
---
v2:
- add an early flag in xbc_free_mem() to free memory back to memblock in
  xbc_init error path or put memory to buddy allocator in normal xbc_exit.

---
 include/linux/bootconfig.h |  7 ++++++-
 lib/bootconfig.c           | 19 +++++++++++--------
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index e5ee2c694401..3f4b4ac527ca 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -288,7 +288,12 @@ int __init xbc_init(const char *buf, size_t size, const char **emsg, int *epos);
 int __init xbc_get_info(int *node_size, size_t *data_size);
 
 /* XBC cleanup data structures */
-void __init xbc_exit(void);
+void __init _xbc_exit(bool early);
+
+static inline void xbc_exit(void)
+{
+	_xbc_exit(false);
+}
 
 /* XBC embedded bootconfig data in kernel */
 #ifdef CONFIG_BOOT_CONFIG_EMBED
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index c59d26068a64..f9a45adc6307 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -61,9 +61,12 @@ static inline void * __init xbc_alloc_mem(size_t size)
 	return memblock_alloc(size, SMP_CACHE_BYTES);
 }
 
-static inline void __init xbc_free_mem(void *addr, size_t size)
+static inline void __init xbc_free_mem(void *addr, size_t size, bool early)
 {
-	memblock_free(addr, size);
+	if (early)
+		memblock_free(addr, size);
+	else
+		memblock_free_late(__pa(addr), size);
 }
 
 #else /* !__KERNEL__ */
@@ -73,7 +76,7 @@ static inline void *xbc_alloc_mem(size_t size)
 	return malloc(size);
 }
 
-static inline void xbc_free_mem(void *addr, size_t size)
+static inline void xbc_free_mem(void *addr, size_t size, bool early)
 {
 	free(addr);
 }
@@ -904,13 +907,13 @@ static int __init xbc_parse_tree(void)
  * If you need to reuse xbc_init() with new boot config, you can
  * use this.
  */
-void __init xbc_exit(void)
+void __init _xbc_exit(bool early)
 {
-	xbc_free_mem(xbc_data, xbc_data_size);
+	xbc_free_mem(xbc_data, xbc_data_size, early);
 	xbc_data = NULL;
 	xbc_data_size = 0;
 	xbc_node_num = 0;
-	xbc_free_mem(xbc_nodes, sizeof(struct xbc_node) * XBC_NODE_MAX);
+	xbc_free_mem(xbc_nodes, sizeof(struct xbc_node) * XBC_NODE_MAX, early);
 	xbc_nodes = NULL;
 	brace_index = 0;
 }
@@ -963,7 +966,7 @@ int __init xbc_init(const char *data, size_t size, const char **emsg, int *epos)
 	if (!xbc_nodes) {
 		if (emsg)
 			*emsg = "Failed to allocate bootconfig nodes";
-		xbc_exit();
+		_xbc_exit(true);
 		return -ENOMEM;
 	}
 	memset(xbc_nodes, 0, sizeof(struct xbc_node) * XBC_NODE_MAX);
@@ -977,7 +980,7 @@ int __init xbc_init(const char *data, size_t size, const char **emsg, int *epos)
 			*epos = xbc_err_pos;
 		if (emsg)
 			*emsg = xbc_err_msg;
-		xbc_exit();
+		_xbc_exit(true);
 	} else
 		ret = xbc_node_num;
 
-- 
2.39.2


