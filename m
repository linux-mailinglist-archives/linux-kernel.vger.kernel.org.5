Return-Path: <linux-kernel+bounces-97502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F70876B1E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B8361F22111
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA815DF3B;
	Fri,  8 Mar 2024 19:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Z98hbQ1/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987205BAE3;
	Fri,  8 Mar 2024 19:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709925223; cv=none; b=EfgMIG4P3wFkKxVCFty4Cug+EzSA5FFknMDlRQJ7PS1g3QaFig9eKRmWXC1WzJ/8O47wHg8sEMar3x4XwGRer0OJ7r6K63A/J0EmPeECZcgavL8d3WyGswgD8nCZjgrWBCjwoGJB4R5UKxzHrlQKoWNNKlQbTPI+prGHGofHgGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709925223; c=relaxed/simple;
	bh=4ItTlbapKw6ETlwOQk9dwCUItreERbi/LvAuxJwwa5I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qHNufzaj5UWO6v5tlHiDwoKkddvPmmw0E1LZcOemfE8oN0TIViB1W2niwDWD1U26TKcNKXAHpj70VlBa75Dw9GSy284gLM0CPD+umgBKETghnaB6nR3OoPVX29Hq/MGoWLMwtwV3yCdA4PLyzcs/1700OBDT6u8LnDSTRTdIHGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Z98hbQ1/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 428IYsQm012705;
	Fri, 8 Mar 2024 19:12:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=jsv4CZiqFBsQFM+GpwqULUHCWDpnf6Ip/p9k0VmyT0k=; b=Z9
	8hbQ1/AICrz4TFyhkvD6ugUi9gHOCBpnm8r5ArIAXD7oNx4XBwUPSQ1eOJt8mTKn
	Fi3mpV/sBxqf0ylpJhrzQbbhWYnZRlAAAQ94kOm89P6fd6D6oQ/rGJ1lMDKx6ZQS
	tJ7SpVWl1OQxyBavo2wiQsbGLCqcS2pcw+fZiZl6QhFuogkrmWto6GXLqw1BTIf0
	q+MD9Zz5wcYgpR5oIHi9ZUUzn6csBs7gRxQfHF9tO4/PpkdOr78jrnk2TVdTN7LW
	2M1mdTRzgC1cUe0QfIAWfVUZX4rIRus9B3KZ3EaJDvefQZm3o3lxJbNcozznRM4d
	ByFji2iJYkO5fKZpGckw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wr82x02xa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 19:12:31 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 428JCUVq023071
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 8 Mar 2024 19:12:30 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 8 Mar 2024 11:12:26 -0800
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
Subject: [PATCH v4 3/4] of: reserved_mem: Use the unflatten_devicetree APIs to scan reserved mem. nodes
Date: Fri, 8 Mar 2024 11:12:03 -0800
Message-ID: <20240308191204.819487-4-quic_obabatun@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Bepm6DlQTpRFt33C9fflNh6-PTASB2s-
X-Proofpoint-GUID: Bepm6DlQTpRFt33C9fflNh6-PTASB2s-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=944 lowpriorityscore=0
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403080152

The unflatten_devicetree APIs have been setup and are available to be
used by the time the fdt_init_reserved_mem() function is called.
Since the unflatten_devicetree APIs are a more efficient way of scanning
through the DT nodes, switch to using these APIs to facilitate the rest
of the reserved memory processing.

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 drivers/of/fdt.c                | 56 -----------------------
 drivers/of/of_private.h         |  4 +-
 drivers/of/of_reserved_mem.c    | 81 ++++++++++++++++++++++++++-------
 include/linux/of_fdt.h          |  1 -
 include/linux/of_reserved_mem.h |  2 +-
 kernel/dma/coherent.c           |  8 ++--
 kernel/dma/contiguous.c         |  8 ++--
 kernel/dma/swiotlb.c            | 10 ++--
 8 files changed, 81 insertions(+), 89 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 2468360d6053..11630eba965c 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -558,62 +558,6 @@ static int __init __reserved_mem_check_root(unsigned long node)
 	return 0;
 }
 
-/**
- * fdt_scan_reserved_mem_reg_nodes() - Store info for the "reg" defined
- * reserved memory regions.
- *
- * This function is used to scan through the DT and store the
- * information for the reserved memory regions that are defined using
- * the "reg" property. The region node number, name, base address, and
- * size are all stored in the reserved_mem array by calling the
- * fdt_reserved_mem_save_node() function.
- */
-void __init fdt_scan_reserved_mem_reg_nodes(void)
-
-{
-	int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
-	const void *fdt = initial_boot_params;
-	phys_addr_t base, size;
-	const __be32 *prop;
-	int node, child;
-	int len;
-
-	node = fdt_path_offset(fdt, "/reserved-memory");
-	if (node < 0) {
-		pr_err("Reserved memory: Did not find reserved-memory node\n");
-		return;
-	}
-
-	if (__reserved_mem_check_root(node)) {
-		pr_err("Reserved memory: unsupported node format, ignoring\n");
-		return;
-	}
-
-	fdt_for_each_subnode(child, fdt, node) {
-		const char *uname;
-
-		prop = of_get_flat_dt_prop(child, "reg", &len);
-		if (!prop)
-			continue;
-
-		if (!of_fdt_device_is_available(fdt, child))
-			continue;
-
-		uname = fdt_get_name(fdt, child, NULL);
-		if (len && len % t_len != 0) {
-			pr_err("Reserved memory: invalid reg property in '%s', skipping node.\n",
-			       uname);
-			continue;
-		}
-
-		base = dt_mem_next_cell(dt_root_addr_cells, &prop);
-		size = dt_mem_next_cell(dt_root_size_cells, &prop);
-
-		if (size)
-			fdt_reserved_mem_save_node(child, uname, base, size);
-	}
-}
-
 int total_reserved_mem_cnt = MAX_RESERVED_REGIONS;
 
 /*
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 447b63413b39..aa8844318257 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -177,7 +177,7 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
 }
 #endif
 
-void fdt_reserved_mem_save_node(unsigned long node, const char *uname,
-			       phys_addr_t base, phys_addr_t size);
+void fdt_reserved_mem_save_node(struct device_node *node, const char *uname,
+				phys_addr_t base, phys_addr_t size);
 
 #endif /* _LINUX_OF_PRIVATE_H */
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 3c4373b021be..8d50a5178440 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -97,11 +97,65 @@ static int __init alloc_reserved_mem_array(void)
 	return -1;
 }
 
+/**
+ * dt_scan_reserved_mem_reg_nodes() - Store info for the "reg" defined
+ * reserved memory regions.
+ *
+ * This function is used to scan through the DT and store the
+ * information for the reserved memory regions that are defined using
+ * the "reg" property. The region node number, name, base address, and
+ * size are all stored in the reserved_mem array by calling the
+ * fdt_reserved_mem_save_node() function.
+ */
+static void __init dt_scan_reserved_mem_reg_nodes(void)
+{
+	int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
+	struct device_node *node, *child;
+	phys_addr_t base, size;
+	const __be32 *prop;
+	int len;
+
+	node = of_find_node_by_path("/reserved-memory");
+	if (!node) {
+		pr_err("Reserved memory: Did not find reserved-memory node\n");
+		return;
+	}
+
+	for_each_child_of_node(node, child) {
+		const char *uname;
+		struct reserved_mem *rmem;
+
+		if (!of_device_is_available(child))
+			continue;
+
+		prop = of_get_property(child, "reg", &len);
+		if (!prop) {
+			rmem = of_reserved_mem_lookup(child);
+			if (rmem)
+				rmem->dev_node = child;
+			continue;
+		}
+
+		uname = of_node_full_name(child);
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
  * fdt_reserved_mem_save_node() - save fdt node for second pass initialization
  */
-void __init fdt_reserved_mem_save_node(unsigned long node, const char *uname,
-				      phys_addr_t base, phys_addr_t size)
+void __init fdt_reserved_mem_save_node(struct device_node *node, const char *uname,
+				       phys_addr_t base, phys_addr_t size)
 {
 	struct reserved_mem *rmem = &reserved_mem[reserved_mem_count];
 
@@ -110,7 +164,7 @@ void __init fdt_reserved_mem_save_node(unsigned long node, const char *uname,
 		return;
 	}
 
-	rmem->fdt_node = node;
+	rmem->dev_node = node;
 	rmem->name = uname;
 	rmem->base = base;
 	rmem->size = size;
@@ -253,7 +307,7 @@ int __init __reserved_mem_alloc_size(unsigned long node, const char *uname)
 		       uname, (unsigned long)(size / SZ_1M));
 		return -ENOMEM;
 	}
-	fdt_reserved_mem_save_node(node, uname, base, size);
+	fdt_reserved_mem_save_node(NULL, uname, base, size);
 	return 0;
 }
 
@@ -273,7 +327,7 @@ static int __init __reserved_mem_init_node(struct reserved_mem *rmem)
 		reservedmem_of_init_fn initfn = i->data;
 		const char *compat = i->compatible;
 
-		if (!of_flat_dt_is_compatible(rmem->fdt_node, compat))
+		if (!of_device_is_compatible(rmem->dev_node, compat))
 			continue;
 
 		ret = initfn(rmem);
@@ -306,11 +360,6 @@ static int __init __rmem_cmp(const void *a, const void *b)
 	if (ra->size > rb->size)
 		return 1;
 
-	if (ra->fdt_node < rb->fdt_node)
-		return -1;
-	if (ra->fdt_node > rb->fdt_node)
-		return 1;
-
 	return 0;
 }
 
@@ -352,23 +401,23 @@ void __init fdt_init_reserved_mem(void)
 	if (ret)
 		pr_err("Failed to allocate memory for reserved_mem array with err: %d", ret);
 
-	fdt_scan_reserved_mem_reg_nodes();
+	dt_scan_reserved_mem_reg_nodes();
 
 	/* check for overlapping reserved regions */
 	__rmem_check_for_overlap();
 
 	for (i = 0; i < reserved_mem_count; i++) {
 		struct reserved_mem *rmem = &reserved_mem[i];
-		unsigned long node = rmem->fdt_node;
+		struct device_node *node = rmem->dev_node;
 		int len;
 		const __be32 *prop;
 		int err = 0;
 		bool nomap;
 
-		nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
-		prop = of_get_flat_dt_prop(node, "phandle", &len);
+		nomap = of_get_property(node, "no-map", NULL) != NULL;
+		prop = of_get_property(node, "phandle", &len);
 		if (!prop)
-			prop = of_get_flat_dt_prop(node, "linux,phandle", &len);
+			prop = of_get_property(node, "linux,phandle", &len);
 		if (prop)
 			rmem->phandle = of_read_number(prop, len/4);
 
@@ -384,7 +433,7 @@ void __init fdt_init_reserved_mem(void)
 		} else {
 			phys_addr_t end = rmem->base + rmem->size - 1;
 			bool reusable =
-				(of_get_flat_dt_prop(node, "reusable", NULL)) != NULL;
+				(of_get_property(node, "reusable", NULL)) != NULL;
 
 			pr_info("%pa..%pa (%lu KiB) %s %s %s\n",
 				&rmem->base, &end, (unsigned long)(rmem->size / SZ_1K),
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index 7b2a5d93d719..d69ad5bb1eb1 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -73,7 +73,6 @@ extern int early_init_dt_scan_root(void);
 extern bool early_init_dt_scan(void *params);
 extern bool early_init_dt_verify(void *params);
 extern void early_init_dt_scan_nodes(void);
-extern void fdt_scan_reserved_mem_reg_nodes(void);
 
 extern const char *of_flat_dt_get_machine_name(void);
 extern const void *of_flat_dt_match_machine(const void *default_match,
diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index 2a3178920bae..e92babd669c2 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -10,7 +10,7 @@ struct reserved_mem_ops;
 
 struct reserved_mem {
 	const char			*name;
-	unsigned long			fdt_node;
+	struct device_node		*dev_node;
 	unsigned long			phandle;
 	const struct reserved_mem_ops	*ops;
 	phys_addr_t			base;
diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index ff5683a57f77..0db0aae83102 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -362,20 +362,20 @@ static const struct reserved_mem_ops rmem_dma_ops = {
 
 static int __init rmem_dma_setup(struct reserved_mem *rmem)
 {
-	unsigned long node = rmem->fdt_node;
+	struct device_node *node = rmem->dev_node;
 
-	if (of_get_flat_dt_prop(node, "reusable", NULL))
+	if (of_get_property(node, "reusable", NULL))
 		return -EINVAL;
 
 #ifdef CONFIG_ARM
-	if (!of_get_flat_dt_prop(node, "no-map", NULL)) {
+	if (!of_get_property(node, "no-map", NULL)) {
 		pr_err("Reserved memory: regions without no-map are not yet supported\n");
 		return -EINVAL;
 	}
 #endif
 
 #ifdef CONFIG_DMA_GLOBAL_POOL
-	if (of_get_flat_dt_prop(node, "linux,dma-default", NULL)) {
+	if (of_get_property(node, "linux,dma-default", NULL)) {
 		WARN(dma_reserved_default_memory,
 		     "Reserved memory: region for default DMA coherent area is redefined\n");
 		dma_reserved_default_memory = rmem;
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index f005c66f378c..b54cf128a9d9 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -462,8 +462,8 @@ static const struct reserved_mem_ops rmem_cma_ops = {
 
 static int __init rmem_cma_setup(struct reserved_mem *rmem)
 {
-	unsigned long node = rmem->fdt_node;
-	bool default_cma = of_get_flat_dt_prop(node, "linux,cma-default", NULL);
+	struct device_node *node = rmem->dev_node;
+	bool default_cma = of_get_property(node, "linux,cma-default", NULL);
 	struct cma *cma;
 	int err;
 
@@ -473,8 +473,8 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
 		return -EBUSY;
 	}
 
-	if (!of_get_flat_dt_prop(node, "reusable", NULL) ||
-	    of_get_flat_dt_prop(node, "no-map", NULL))
+	if (!of_get_property(node, "reusable", NULL) ||
+	    of_get_property(node, "no-map", NULL))
 		return -EINVAL;
 
 	if (!IS_ALIGNED(rmem->base | rmem->size, CMA_MIN_ALIGNMENT_BYTES)) {
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index b079a9a8e087..ea1f734c8c35 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1732,12 +1732,12 @@ static const struct reserved_mem_ops rmem_swiotlb_ops = {
 
 static int __init rmem_swiotlb_setup(struct reserved_mem *rmem)
 {
-	unsigned long node = rmem->fdt_node;
+	struct device_node *node = rmem->dev_node;
 
-	if (of_get_flat_dt_prop(node, "reusable", NULL) ||
-	    of_get_flat_dt_prop(node, "linux,cma-default", NULL) ||
-	    of_get_flat_dt_prop(node, "linux,dma-default", NULL) ||
-	    of_get_flat_dt_prop(node, "no-map", NULL))
+	if (of_get_property(node, "reusable", NULL) ||
+	    of_get_property(node, "linux,cma-default", NULL) ||
+	    of_get_property(node, "linux,dma-default", NULL) ||
+	    of_get_property(node, "no-map", NULL))
 		return -EINVAL;
 
 	rmem->ops = &rmem_swiotlb_ops;
-- 
2.34.1


