Return-Path: <linux-kernel+bounces-123666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE1A890C63
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7355C291F08
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BCA13B2B0;
	Thu, 28 Mar 2024 21:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dZoy+/F9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B138136E2D;
	Thu, 28 Mar 2024 21:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711660667; cv=none; b=d2i9pJs9ZICNUpIvvWNNX6U3SRxGV88N1cfLqLC0o+JpX6D0xJzidGCkJ+aOHZB+17VDU4cHVXUUq+kGw58fmGK2qrcGGMcenZHFm5AcEtlFfcjMODPBNOFZt+FEoeEGiZjnJ20/p6yxTu57pHk4wv2w9j70mEVk4NMEVIyETUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711660667; c=relaxed/simple;
	bh=AkehjzcoL/jfETzttQlWrPul2z+f7iuOCoY08CuXaTY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rZCvEwWIaGjp2yreiqmpIc2OaGsoKJCr2qcvC25YisywaS3LF8XlddvanUNg+v4rdy23LzMSXJVcsRjR//7TnQ4xVdmDKpXYdNsSGIRW7sn2P8jWfqQ4ZJGhDuXnU0tMkU+dv/cvF16PNCkXbP8LGMJimdajTxznXHqgTTJWfN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dZoy+/F9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42SIMCcU012083;
	Thu, 28 Mar 2024 21:16:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=l0g1I6ZYjKU0wylGdofuZ7WQ7EHsy7s8fxAUkaXzb+8=; b=dZ
	oy+/F9Tsnmn32T1l0tPVAWYHRjZn2yHZXlKGGxju72T7OtciGPcnoxzJzf8CY3hU
	QyzLhPgpcTusr7OGOVhZ2CgLBmLhtcy3+5cd/myRXFJ+eJYULWV1QpH2BabYHcJG
	DoIxRqOkUIcTMu2BrpfRoozm9bxKuCl/zcVEFC5oz07VksUx/r+eQTHYXknGh4Ys
	Vu9VA77BSdCRkZy+tmmD/011leGW1BUgSMNG3EMSyyU4QANq5aSK2gotA8jPYG2D
	pwLivQhFrcsh+mV9XddCAPv+iPvb1ljq3gLkBt467iAURx8hJGAYWbrlnNeIhrsI
	GMaYMfIzHv/HQcEZrdcQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x53nxjg6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 21:16:35 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42SLGY8o032402
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 21:16:34 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 14:16:31 -0700
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
Subject: [PATCH v5 1/4] of: reserved_mem: Restruture how the reserved memory regions are processed
Date: Thu, 28 Mar 2024 14:15:40 -0700
Message-ID: <20240328211543.191876-2-quic_obabatun@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328211543.191876-1-quic_obabatun@quicinc.com>
References: <20240328211543.191876-1-quic_obabatun@quicinc.com>
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
X-Proofpoint-GUID: MxJMA00oIyykQ4GCoFabALoPHlfjxzO2
X-Proofpoint-ORIG-GUID: MxJMA00oIyykQ4GCoFabALoPHlfjxzO2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_17,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 adultscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403280152

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
   - Add the information for the reserved region to the reserved_mem
     array.
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
Dynamically-placed reserved memory regions on the other hand get
assigned a start address only at runtime, and since memblock_reserve()
and memblock_mark_nomap() need to be called before the memory mappings
are created, the allocation needs to happen before the page tables are
setup.

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

fdt_init_reserved_mem() is also now called from within the
unflatten_device_tree() function so that this step happens after the
page tables have been setup.

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 drivers/of/fdt.c             |   5 +-
 drivers/of/of_private.h      |   1 +
 drivers/of/of_reserved_mem.c | 134 +++++++++++++++++++++++++----------
 3 files changed, 100 insertions(+), 40 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index a8a04f27915b..527e6bc1c096 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -532,8 +532,6 @@ void __init early_init_fdt_scan_reserved_mem(void)
 			break;
 		memblock_reserve(base, size);
 	}
-
-	fdt_init_reserved_mem();
 }
 
 /**
@@ -1259,6 +1257,9 @@ void __init unflatten_device_tree(void)
 	of_alias_scan(early_init_dt_alloc_memory_arch);
 
 	unittest_unflatten_overlay_base();
+
+	/* initialize the reserved memory regions */
+	fdt_init_reserved_mem();
 }
 
 /**
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 485483524b7f..9ea250b80657 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -9,6 +9,7 @@
  */
 
 #define FDT_ALIGN_SIZE 8
+#define MAX_RESERVED_REGIONS    64
 
 /**
  * struct alias_prop - Alias property in 'aliases' node
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 8236ecae2953..db991de16cc0 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -27,7 +27,6 @@
 
 #include "of_private.h"
 
-#define MAX_RESERVED_REGIONS	64
 static struct reserved_mem reserved_mem[MAX_RESERVED_REGIONS];
 static int reserved_mem_count;
 
@@ -106,7 +105,6 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
 	phys_addr_t base, size;
 	int len;
 	const __be32 *prop;
-	int first = 1;
 	bool nomap;
 
 	prop = of_get_flat_dt_prop(node, "reg", &len);
@@ -134,10 +132,6 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
 			       uname, &base, (unsigned long)(size / SZ_1M));
 
 		len -= t_len;
-		if (first) {
-			fdt_reserved_mem_save_node(node, uname, base, size);
-			first = 0;
-		}
 	}
 	return 0;
 }
@@ -165,12 +159,69 @@ static int __init __reserved_mem_check_root(unsigned long node)
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
+static void __init fdt_scan_reserved_mem_reg_nodes(void)
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
+		pr_info("Reserved memory: No reserved-memory node in the DT\n");
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
+		if (!of_fdt_device_is_available(fdt, child))
+			continue;
+
+		uname = fdt_get_name(fdt, child, NULL);
+		if (len && len % t_len != 0) {
+			pr_err("Reserved memory: invalid reg property in '%s', skipping node.\n",
+			       uname);
+			continue;
+		}
+		base = dt_mem_next_cell(dt_root_addr_cells, &prop);
+		size = dt_mem_next_cell(dt_root_size_cells, &prop);
+
+		if (size)
+			fdt_reserved_mem_save_node(child, uname, base, size);
+	}
+}
+
+static int __init __reserved_mem_alloc_size(unsigned long node, const char *uname);
+
 /*
  * fdt_scan_reserved_mem() - scan a single FDT node for reserved memory
  */
 int __init fdt_scan_reserved_mem(void)
 {
 	int node, child;
+	int dynamic_nodes_cnt = 0;
+	int dynamic_nodes[MAX_RESERVED_REGIONS];
 	const void *fdt = initial_boot_params;
 
 	node = fdt_path_offset(fdt, "/reserved-memory");
@@ -192,8 +243,24 @@ int __init fdt_scan_reserved_mem(void)
 		uname = fdt_get_name(fdt, child, NULL);
 
 		err = __reserved_mem_reserve_reg(child, uname);
-		if (err == -ENOENT && of_get_flat_dt_prop(child, "size", NULL))
-			fdt_reserved_mem_save_node(child, uname, 0, 0);
+		/*
+		 * Save the nodes for the dynamically-placed regions
+		 * into an array which will be used for allocation right
+		 * after all the statically-placed regions are reserved
+		 * or marked as no-map. This is done to avoid dynamically
+		 * allocating from one of the statically-placed regions.
+		 */
+		if (err == -ENOENT && of_get_flat_dt_prop(child, "size", NULL)) {
+			dynamic_nodes[dynamic_nodes_cnt] = child;
+			dynamic_nodes_cnt++;
+		}
+	}
+	for (int i = 0; i < dynamic_nodes_cnt; i++) {
+		const char *uname;
+
+		child = dynamic_nodes[i];
+		uname = fdt_get_name(fdt, child, NULL);
+		__reserved_mem_alloc_size(child, uname);
 	}
 	return 0;
 }
@@ -253,8 +320,7 @@ static int __init __reserved_mem_alloc_in_range(phys_addr_t size,
  * __reserved_mem_alloc_size() - allocate reserved memory described by
  *	'size', 'alignment'  and 'alloc-ranges' properties.
  */
-static int __init __reserved_mem_alloc_size(unsigned long node,
-	const char *uname, phys_addr_t *res_base, phys_addr_t *res_size)
+static int __init __reserved_mem_alloc_size(unsigned long node, const char *uname)
 {
 	int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
 	phys_addr_t start = 0, end = 0;
@@ -333,10 +399,7 @@ static int __init __reserved_mem_alloc_size(unsigned long node,
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
 
@@ -431,6 +494,8 @@ void __init fdt_init_reserved_mem(void)
 {
 	int i;
 
+	fdt_scan_reserved_mem_reg_nodes();
+
 	/* check for overlapping reserved regions */
 	__rmem_check_for_overlap();
 
@@ -449,30 +514,23 @@ void __init fdt_init_reserved_mem(void)
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
+			pr_info("node %s compatible matching fail\n", rmem->name);
+			if (nomap)
+				memblock_clear_nomap(rmem->base, rmem->size);
+			else
+				memblock_phys_free(rmem->base, rmem->size);
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
-- 
2.34.1


