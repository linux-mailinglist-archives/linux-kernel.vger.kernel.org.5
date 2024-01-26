Return-Path: <linux-kernel+bounces-40912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E995F83E7CD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19D6B1C28A67
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F88D73168;
	Fri, 26 Jan 2024 23:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oNDfq1XY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A6F6A01B;
	Fri, 26 Jan 2024 23:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706313376; cv=none; b=KArjsh2ywKkUSvxlD9I4ZU+/JIXxQXe65RC/+4GyjFke0cWzoOp2mcht2g6jzV1Kw2jKuCBhrW+80rbJGSSVD3qaj65FnCpjEIenHe/WA1s7/Lat/bzRaUdJgoOouPuu+/Sm0f5sxY3gHc7x2NuB3rVqtOa/ahkE1eXe8nRj2EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706313376; c=relaxed/simple;
	bh=P1AkFxQdbHcnFpiYveH/lqCbOhuQDolNZukNjttahTM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=py3KojrCoDhWpCK3T+VqTKt88AJJ5znVZDd1hZYm5qDFUsSY1tPMbzrN+XYeVKiT0WcXIPsnp65lIDxqkdhC8J5WzfOSjGoiyH/AYZmGd8OYeJ4OfiKLBl1hmhRmF8pOjAOEsFYcBQDtdNErZM2sTziluaMnkoCrjbMjmgfr0tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oNDfq1XY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QNBGT1012061;
	Fri, 26 Jan 2024 23:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=SJ2uVxsVzF+RZp0UyxD5
	o7P5HuGaB56FNfvEAgO0PZI=; b=oNDfq1XYRkEu/t8bLl0QBHNmiWLwXtCFkH4z
	R1oEi3uV6zK9BDHhkLAPWuraRI4ztGytg2l7J0ttyGGDXnSLxwXp5B8zuPDfjkOT
	IwzcoFSMoqDz6AnUomoYTR7HO86jqFrqRvaoyi1yEXyDnwQaEVS/M/0/gN3xCmAD
	Zn68V5Hcxse4FZgRRRPME8WijeXz39V19ejoqTtyImHFdbwpW5ziRy5T88D/MKeU
	C5+xRiwYZ2vhJYzj8/l3tvCBDjkSnzXrPLJzLi6IwMfqi+ESa3Q2lJqZY9KcqW9n
	YnZU/l8XiSXe23OAYljeb0fo0GvkkG15U8f0Qd6r+DT9SfpghQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvjbg8g0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 23:55:30 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40QNtTDZ010350
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 23:55:29 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 26 Jan 2024 15:55:12 -0800
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
Subject: [PATCH 30/46] of: reserved_mem: Add code to use unflattened DT for reserved_mem nodes
Date: Fri, 26 Jan 2024 15:54:09 -0800
Message-ID: <20240126235425.12233-31-quic_obabatun@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240126235425.12233-1-quic_obabatun@quicinc.com>
References: <20240126235425.12233-1-quic_obabatun@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oCU4TW6ixTZQc4WOuFDNAARpo2_btXl0
X-Proofpoint-ORIG-GUID: oCU4TW6ixTZQc4WOuFDNAARpo2_btXl0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 mlxlogscore=752 phishscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401260176

The unflattened devicetree APIs are available to be used not long after
the processing is done for the reserved memory regions on some
architectures, and is available even before that on other architectures.
Therefore, use the unflattened devicetree APIs to process and store
information for the reserved memory regions.

Using the unflattened devicetree APIs is more efficient than using the
flattened devicetree APIs.

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 drivers/of/fdt.c                | 49 ----------------------
 drivers/of/of_private.h         |  4 +-
 drivers/of/of_reserved_mem.c    | 74 ++++++++++++++++++++++++++-------
 include/linux/of_fdt.h          |  1 -
 include/linux/of_reserved_mem.h |  2 +-
 kernel/dma/coherent.c           |  4 +-
 kernel/dma/contiguous.c         |  8 ++--
 kernel/dma/swiotlb.c            | 10 ++---
 8 files changed, 72 insertions(+), 80 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index ebd2fa9e0114..2bc01ffdabfe 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -558,55 +558,6 @@ static int __init __reserved_mem_check_root(unsigned long node)
 	return 0;
 }
 
-/*
- * Save the reserved_mem reg nodes in the reserved_mem array
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
-	if (__reserved_mem_check_root(node) != 0) {
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
 /*
  * fdt_scan_reserved_mem() - scan a single FDT node for reserved memory.
  */
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index c338e1c019c7..f7da22108e7a 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -177,7 +177,7 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
 #endif
 
 void update_reserved_mem_max_cnt(int max_count);
-void fdt_reserved_mem_save_node(unsigned long node, const char *uname,
-			       phys_addr_t base, phys_addr_t size);
+void fdt_reserved_mem_save_node(struct device_node *node, const char *uname,
+				phys_addr_t base, phys_addr_t size);
 
 #endif /* _LINUX_OF_PRIVATE_H */
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 419b062cb41f..645b02e27492 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -96,11 +96,58 @@ static int alloc_reserved_mem_array(void)
 	return -1;
 }
 
+/*
+ * Save the reserved_mem reg nodes in the reserved_mem array
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
+	if (node < 0) {
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
 
@@ -109,7 +156,7 @@ void __init fdt_reserved_mem_save_node(unsigned long node, const char *uname,
 		return;
 	}
 
-	rmem->fdt_node = node;
+	rmem->dev_node = node;
 	rmem->name = uname;
 	rmem->base = base;
 	rmem->size = size;
@@ -252,7 +299,7 @@ int __init __reserved_mem_alloc_size(unsigned long node, const char *uname)
 		       uname, (unsigned long)(size / SZ_1M));
 		return -ENOMEM;
 	}
-	fdt_reserved_mem_save_node(node, uname, base, size);
+	fdt_reserved_mem_save_node(NULL, uname, base, size);
 	return 0;
 }
 
@@ -272,7 +319,7 @@ static int __init __reserved_mem_init_node(struct reserved_mem *rmem)
 		reservedmem_of_init_fn initfn = i->data;
 		const char *compat = i->compatible;
 
-		if (!of_flat_dt_is_compatible(rmem->fdt_node, compat))
+		if (!of_device_is_compatible(rmem->dev_node, compat))
 			continue;
 
 		ret = initfn(rmem);
@@ -305,11 +352,6 @@ static int __init __rmem_cmp(const void *a, const void *b)
 	if (ra->size > rb->size)
 		return 1;
 
-	if (ra->fdt_node < rb->fdt_node)
-		return -1;
-	if (ra->fdt_node > rb->fdt_node)
-		return 1;
-
 	return 0;
 }
 
@@ -351,23 +393,23 @@ void __init fdt_init_reserved_mem(void)
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
 
@@ -383,7 +425,7 @@ void __init fdt_init_reserved_mem(void)
 		} else {
 			phys_addr_t end = rmem->base + rmem->size - 1;
 			bool reusable =
-				(of_get_flat_dt_prop(node, "reusable", NULL)) != NULL;
+				(of_get_property(node, "reusable", NULL)) != NULL;
 
 			pr_info("%pa..%pa (%lu KiB) %s %s %s\n",
 				&rmem->base, &end, (unsigned long)(rmem->size / SZ_1K),
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index 9b85bbc5d9f5..fb7b437141bd 100644
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
index ff5683a57f77..5ab26fe11c29 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -362,9 +362,9 @@ static const struct reserved_mem_ops rmem_dma_ops = {
 
 static int __init rmem_dma_setup(struct reserved_mem *rmem)
 {
-	unsigned long node = rmem->fdt_node;
+	struct device_node *node = rmem->dev_node;
 
-	if (of_get_flat_dt_prop(node, "reusable", NULL))
+	if (of_get_property(node, "reusable", NULL))
 		return -EINVAL;
 
 #ifdef CONFIG_ARM
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
2.17.1


