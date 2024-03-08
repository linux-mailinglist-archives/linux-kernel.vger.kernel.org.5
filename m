Return-Path: <linux-kernel+bounces-97500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE9B876B18
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFCBB1C20B2A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4115B666;
	Fri,  8 Mar 2024 19:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZfFTwaUq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3527F5A7B6;
	Fri,  8 Mar 2024 19:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709925220; cv=none; b=gA+yY29d5WV9rkw6r65KHbw7ywclatyD3gJcWyj0EnZh2C0uw0eseA5LZt5gzHCEqQn/nm+HxGSMJQyCfVHmVlVnbpWwv2ySKb4BgEKSzxH84vQSDlc3PrrQgbHCjFYyfoFaAY+q7alBRgUhHjEBCPUHj2xyxnJ3artVW3vVNJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709925220; c=relaxed/simple;
	bh=Y5o3ipFQvUTD8ar3yi2ywjqGmeFnNWVLAVwJGjpsQy8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j8PkSFKHV02D4fCm6sF4Srf4+lvcdYWi90Pewwq5Pq6IkctckgJ8FwRFh9Twgejgf4HUtAyYFmXW2msncFAL8nikmw+clbb4hREl4IbQOD+t4Qy3p7Ge1tHnuS+rlmA68jJ1aLG01VE8g9cZ0cbl/gcLhbagZ3JuiFv5ygiAJA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZfFTwaUq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 428HoCkU003625;
	Fri, 8 Mar 2024 19:12:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=iAZllGHpg6KtWgQSNsjDB8XvuqSXphHIsfHsBHleu7M=; b=Zf
	FTwaUq9Scv1PKIoJRObn/VvVTj7UY2Tepa0yuCe0OSgwYteQym6Q3Q3zwcex3rht
	/qt6MYS3z5BQmlg1AoHLM9V9JWI5v2QO1klxZNFkbbaEpKNh3zUCpkheyySTdkmn
	LSbh43XmqqczyfyUnPDDqKzaL7Q6CBHNJaYujevcCNMuol9PEAp2suec+DAFNpYD
	jlfCEH7SkhSWg898kGV/gD/H+godSs62JdZ9gLX6jHydENwncOsV6iCSkpUVtL0Q
	TxUHR5J1a0LR+tiUltKhSGtAXLkInOk95rqdazStZnOZvSRlXCx2yZiEIugf0EAx
	oDp1wExyJxmBxzoX63VQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wqn8rajyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 19:12:29 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 428JCTdQ003929
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 8 Mar 2024 19:12:29 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 8 Mar 2024 11:12:25 -0800
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <vgupta@kernel.org>, <arnd@arndb.de>,
        <olof@lixom.net>, <soc@kernel.org>, <guoren@kernel.org>,
        <monstr@monstr.eu>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <dinguyen@kernel.org>, <chenhuacai@kernel.org>,
        <tsbogend@alpha.franken.de>, <jonas@southpole.se>,
        <stefan.kristiansson@saunalahti.fi>, <shorne@gmail.com>,
        <mpe@ellerman.id.au>, <ysato@users.sourceforge.jp>, <dalias@libc.org>,
        <glaubitz@physik.fu-berlin.de>, <richard@nod.at>,
        <anton.ivanov@cambridgegreys.com>, <johannes@sipsolutions.net>,
        <chris@zankel.net>, <jcmvbkbc@gmail.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <kernel@quicinc.com>, Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Subject: [PATCH v4 1/4] of: reserved_mem: Restruture how the reserved memory regions are processed
Date: Fri, 8 Mar 2024 11:12:01 -0800
Message-ID: <20240308191204.819487-2-quic_obabatun@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240308191204.819487-1-quic_obabatun@quicinc.com>
References: <20240308191204.819487-1-quic_obabatun@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: e4njR5hP9NATM0yiCv_O7Z8b0MOajMge
X-Proofpoint-GUID: e4njR5hP9NATM0yiCv_O7Z8b0MOajMge
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 mlxscore=0 bulkscore=0 malwarescore=0 adultscore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2403080152

The current implementation processes the reserved memory regions in two
stages which are done with two separate functions within the
early_init_fdt_scan_reserved_mem() function.

Within the two stages of processing, the reserved memory regions are
broken up into two groups which are processed differently:
i) Statically-placed reserved memory regions
i.e. regions defined with a static start address and size using the
     "reg" property in the DT.
ii) Dynamically-placed reserved memory regions.
i.e. regions defined by specifying a range of addresses where they can
     be placed in memory using the "alloc_ranges" and "size" properties
     in the DT.

Stage 1: fdt_scan_reserved_mem()
This stage of the reserved memory processing is used to scan through the
reserved memory nodes defined in the devicetree and do the following on
each of the nodes:

1) If the node represents a statically-placed reserved memory region,
   i.e. it is defined using the "reg" property:
   - Call memblock_reserve() or memblock_mark_nomap() as needed.
   - Add the information for the reserved region to the reserved_mem array.
     eg: fdt_reserved_mem_save_node(node, name, base, size);

2) If the node represents a dynamically-placed reserved memory region,
   i.e. it is defined using "alloc-ranges" and "size" properties:
   - Add the information for the region to the reserved_mem array with
     the starting address and size set to 0.
     eg: fdt_reserved_mem_save_node(node, name, 0, 0);

Stage 2: fdt_init_reserved_mem()
This stage of the reserved memory processing is used to iterate through
the reserved_mem array which was populated in stage 1 and do the
following on each of the entries:

1) If the entry represents a statically-placed reserved memory region:
   - Call the region specific init function.
2) If the entry represents a dynamically-placed reserved memory region:
   - Call __reserved_mem_alloc_size() which is used to allocate memory
     for the region using memblock_phys_alloc_range(), and call
     memblock_mark_nomap() on the allocated region if the region is
     specified as a no-map region.
   - Call the region specific init function.

On architectures such as arm64, the dynamic allocation of the
reserved_mem array needs to be done after the page tables have been
setup because memblock allocated memory is not writable until then. This
means that the reserved_mem array will not be available to store any
reserved memory information until after the page tables have been setup.

It is possible to call memblock_reserve() and memblock_mark_nomap() on
the statically-placed reserved memory regions and not need to save them
to the reserved_mem array until later. This is because all the
information we need is present in the devicetree.
Dynamically-placed reserved memory regions on the other hand get assigned
a start address only at runtime, and since memblock_reserve() and
memblock_mark_nomap() need to be called before the memory mappings are
created, the allocation needs to happen before the page tables are setup.

To make it easier to handle dynamically-placed reserved memory regions
before the page tables are setup, this patch makes changes to the steps
above to process the reserved memory regions in the following ways:

Step 1: fdt_scan_reserved_mem()
This stage of the reserved memory processing is used to scan through the
reserved memory nodes defined in the devicetree and do the following on
each of the nodes:

1) If the node represents a statically-placed reserved memory region,
   i.e. it is defined using the "reg" property:
   - Call memblock_reserve() or memblock_mark_nomap() as needed.

2) If the node represents a dynamically-placed reserved memory region,
   i.e. it is defined using "alloc-ranges" and "size" properties:
   - Call __reserved_mem_alloc_size() which will:
     i) Allocate memory for the reserved memory region.
     ii) Call memblock_mark_nomap() as needed.
     Note: There is no need to explicitly call memblock_reserve() here
     because it is already called by memblock when the memory for the
     region is being allocated.
     iii) Save the information for the region in the reserved_mem array.

Step 2: fdt_init_reserved_mem()
This stage of the reserved memory processing is used to:

1) Add the information for the statically-placed reserved memory into
   the reserved_mem array.

2) Iterate through all the entries in the array and call the region
   specific init function for each of them.

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 drivers/of/fdt.c                | 84 ++++++++++++++++++++++++++++++---
 drivers/of/of_private.h         |  2 +-
 drivers/of/of_reserved_mem.c    | 54 +++++++++------------
 include/linux/of_fdt.h          |  1 +
 include/linux/of_reserved_mem.h |  9 ++++
 5 files changed, 111 insertions(+), 39 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index bf502ba8da95..fe6c75c5a8c0 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -504,7 +504,6 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
 	phys_addr_t base, size;
 	int len;
 	const __be32 *prop;
-	int first = 1;
 	bool nomap;
 
 	prop = of_get_flat_dt_prop(node, "reg", &len);
@@ -532,10 +531,6 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
 			       uname, &base, (unsigned long)(size / SZ_1M));
 
 		len -= t_len;
-		if (first) {
-			fdt_reserved_mem_save_node(node, uname, base, size);
-			first = 0;
-		}
 	}
 	return 0;
 }
@@ -563,12 +558,70 @@ static int __init __reserved_mem_check_root(unsigned long node)
 	return 0;
 }
 
+/**
+ * fdt_scan_reserved_mem_reg_nodes() - Store info for the "reg" defined
+ * reserved memory regions.
+ *
+ * This function is used to scan through the DT and store the
+ * information for the reserved memory regions that are defined using
+ * the "reg" property. The region node number, name, base address, and
+ * size are all stored in the reserved_mem array by calling the
+ * fdt_reserved_mem_save_node() function.
+ */
+void __init fdt_scan_reserved_mem_reg_nodes(void)
+
+{
+	int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
+	const void *fdt = initial_boot_params;
+	phys_addr_t base, size;
+	const __be32 *prop;
+	int node, child;
+	int len;
+
+	node = fdt_path_offset(fdt, "/reserved-memory");
+	if (node < 0) {
+		pr_err("Reserved memory: Did not find reserved-memory node\n");
+		return;
+	}
+
+	if (__reserved_mem_check_root(node)) {
+		pr_err("Reserved memory: unsupported node format, ignoring\n");
+		return;
+	}
+
+	fdt_for_each_subnode(child, fdt, node) {
+		const char *uname;
+
+		prop = of_get_flat_dt_prop(child, "reg", &len);
+		if (!prop)
+			continue;
+
+		if (!of_fdt_device_is_available(fdt, child))
+			continue;
+
+		uname = fdt_get_name(fdt, child, NULL);
+		if (len && len % t_len != 0) {
+			pr_err("Reserved memory: invalid reg property in '%s', skipping node.\n",
+			       uname);
+			continue;
+		}
+
+		base = dt_mem_next_cell(dt_root_addr_cells, &prop);
+		size = dt_mem_next_cell(dt_root_size_cells, &prop);
+
+		if (size)
+			fdt_reserved_mem_save_node(child, uname, base, size);
+	}
+}
+
 /*
  * fdt_scan_reserved_mem() - scan a single FDT node for reserved memory
  */
 static int __init fdt_scan_reserved_mem(void)
 {
 	int node, child;
+	int dynamic_nodes_cnt = 0;
+	int dynamic_nodes[MAX_RESERVED_REGIONS];
 	const void *fdt = initial_boot_params;
 
 	node = fdt_path_offset(fdt, "/reserved-memory");
@@ -590,8 +643,25 @@ static int __init fdt_scan_reserved_mem(void)
 		uname = fdt_get_name(fdt, child, NULL);
 
 		err = __reserved_mem_reserve_reg(child, uname);
-		if (err == -ENOENT && of_get_flat_dt_prop(child, "size", NULL))
-			fdt_reserved_mem_save_node(child, uname, 0, 0);
+
+		/*
+		 * Delay allocation of the dynamically-placed regions
+		 * until after all other statically-placed regions have
+		 * been reserved or marked as nomap
+		 */
+		if (err == -ENOENT && of_get_flat_dt_prop(child, "size", NULL)) {
+			dynamic_nodes[dynamic_nodes_cnt] = child;
+			dynamic_nodes_cnt++;
+		}
+	}
+
+	for (int i = 0; i < dynamic_nodes_cnt; i++) {
+		const char *uname;
+
+		child = dynamic_nodes[i];
+		uname = fdt_get_name(fdt, child, NULL);
+
+		__reserved_mem_alloc_size(child, uname);
 	}
 	return 0;
 }
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index f38397c7b582..542e37a37a24 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -36,6 +36,7 @@ struct alias_prop {
 #endif
 
 #define OF_ROOT_NODE_SIZE_CELLS_DEFAULT 1
+#define MAX_RESERVED_REGIONS    64
 
 extern struct mutex of_mutex;
 extern raw_spinlock_t devtree_lock;
@@ -175,7 +176,6 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
 }
 #endif
 
-void fdt_init_reserved_mem(void);
 void fdt_reserved_mem_save_node(unsigned long node, const char *uname,
 			       phys_addr_t base, phys_addr_t size);
 
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 7ec94cfcbddb..d62f1956024c 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -26,7 +26,6 @@
 
 #include "of_private.h"
 
-#define MAX_RESERVED_REGIONS	64
 static struct reserved_mem reserved_mem[MAX_RESERVED_REGIONS];
 static int reserved_mem_count;
 
@@ -132,8 +131,7 @@ static int __init __reserved_mem_alloc_in_range(phys_addr_t size,
  * __reserved_mem_alloc_size() - allocate reserved memory described by
  *	'size', 'alignment'  and 'alloc-ranges' properties.
  */
-static int __init __reserved_mem_alloc_size(unsigned long node,
-	const char *uname, phys_addr_t *res_base, phys_addr_t *res_size)
+int __init __reserved_mem_alloc_size(unsigned long node, const char *uname)
 {
 	int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
 	phys_addr_t start = 0, end = 0;
@@ -212,10 +210,7 @@ static int __init __reserved_mem_alloc_size(unsigned long node,
 		       uname, (unsigned long)(size / SZ_1M));
 		return -ENOMEM;
 	}
-
-	*res_base = base;
-	*res_size = size;
-
+	fdt_reserved_mem_save_node(node, uname, base, size);
 	return 0;
 }
 
@@ -310,6 +305,8 @@ void __init fdt_init_reserved_mem(void)
 {
 	int i;
 
+	fdt_scan_reserved_mem_reg_nodes();
+
 	/* check for overlapping reserved regions */
 	__rmem_check_for_overlap();
 
@@ -328,30 +325,25 @@ void __init fdt_init_reserved_mem(void)
 		if (prop)
 			rmem->phandle = of_read_number(prop, len/4);
 
-		if (rmem->size == 0)
-			err = __reserved_mem_alloc_size(node, rmem->name,
-						 &rmem->base, &rmem->size);
-		if (err == 0) {
-			err = __reserved_mem_init_node(rmem);
-			if (err != 0 && err != -ENOENT) {
-				pr_info("node %s compatible matching fail\n",
-					rmem->name);
-				if (nomap)
-					memblock_clear_nomap(rmem->base, rmem->size);
-				else
-					memblock_phys_free(rmem->base,
-							   rmem->size);
-			} else {
-				phys_addr_t end = rmem->base + rmem->size - 1;
-				bool reusable =
-					(of_get_flat_dt_prop(node, "reusable", NULL)) != NULL;
-
-				pr_info("%pa..%pa (%lu KiB) %s %s %s\n",
-					&rmem->base, &end, (unsigned long)(rmem->size / SZ_1K),
-					nomap ? "nomap" : "map",
-					reusable ? "reusable" : "non-reusable",
-					rmem->name ? rmem->name : "unknown");
-			}
+		err = __reserved_mem_init_node(rmem);
+		if (err != 0 && err != -ENOENT) {
+			pr_info("node %s compatible matching fail\n",
+				rmem->name);
+			if (nomap)
+				memblock_clear_nomap(rmem->base, rmem->size);
+			else
+				memblock_phys_free(rmem->base,
+						   rmem->size);
+		} else {
+			phys_addr_t end = rmem->base + rmem->size - 1;
+			bool reusable =
+				(of_get_flat_dt_prop(node, "reusable", NULL)) != NULL;
+
+			pr_info("%pa..%pa (%lu KiB) %s %s %s\n",
+				&rmem->base, &end, (unsigned long)(rmem->size / SZ_1K),
+				nomap ? "nomap" : "map",
+				reusable ? "reusable" : "non-reusable",
+				rmem->name ? rmem->name : "unknown");
 		}
 	}
 }
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index d69ad5bb1eb1..7b2a5d93d719 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -73,6 +73,7 @@ extern int early_init_dt_scan_root(void);
 extern bool early_init_dt_scan(void *params);
 extern bool early_init_dt_verify(void *params);
 extern void early_init_dt_scan_nodes(void);
+extern void fdt_scan_reserved_mem_reg_nodes(void);
 
 extern const char *of_flat_dt_get_machine_name(void);
 extern const void *of_flat_dt_match_machine(const void *default_match,
diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index 4de2a24cadc9..2a3178920bae 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -32,12 +32,14 @@ typedef int (*reservedmem_of_init_fn)(struct reserved_mem *rmem);
 #define RESERVEDMEM_OF_DECLARE(name, compat, init)			\
 	_OF_DECLARE(reservedmem, name, compat, init, reservedmem_of_init_fn)
 
+void fdt_init_reserved_mem(void);
 int of_reserved_mem_device_init_by_idx(struct device *dev,
 				       struct device_node *np, int idx);
 int of_reserved_mem_device_init_by_name(struct device *dev,
 					struct device_node *np,
 					const char *name);
 void of_reserved_mem_device_release(struct device *dev);
+int __reserved_mem_alloc_size(unsigned long node, const char *uname);
 
 struct reserved_mem *of_reserved_mem_lookup(struct device_node *np);
 #else
@@ -45,6 +47,8 @@ struct reserved_mem *of_reserved_mem_lookup(struct device_node *np);
 #define RESERVEDMEM_OF_DECLARE(name, compat, init)			\
 	_OF_DECLARE_STUB(reservedmem, name, compat, init, reservedmem_of_init_fn)
 
+static inline void fdt_init_reserved_mem(void) { }
+
 static inline int of_reserved_mem_device_init_by_idx(struct device *dev,
 					struct device_node *np, int idx)
 {
@@ -60,6 +64,11 @@ static inline int of_reserved_mem_device_init_by_name(struct device *dev,
 
 static inline void of_reserved_mem_device_release(struct device *pdev) { }
 
+static inline int __reserved_mem_alloc_size(unsigned long node, const char *uname)
+{
+	return -ENOSYS;
+}
+
 static inline struct reserved_mem *of_reserved_mem_lookup(struct device_node *np)
 {
 	return NULL;
-- 
2.34.1


