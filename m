Return-Path: <linux-kernel+bounces-123667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA8E890C64
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DDB8B23A58
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014B913AA48;
	Thu, 28 Mar 2024 21:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="j7TuDAHn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADC0651B7;
	Thu, 28 Mar 2024 21:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711660667; cv=none; b=N5BG3kSVOBSrJX5Y3vyKQoPldqmv2De3csZ3cVsVvyzUVOLdi/c/ld3j8PcDqXa9u7LWCDd/CndSCNd9lmEjEfOcnz8qj+FWs+ekFd8wSadHz/crgX1+3LgG0xPtBnLQ3eKtEfFheRK3EBjpGyMXYXRDCPsrKGHhZlqOucBIsYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711660667; c=relaxed/simple;
	bh=CTPkNyS9uqwnsQwPplF4fbnhSrHcZu4vIu5QDeHRnDQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sL4Bd2BeFpGxKb31+9GouIsl158+s9gqbYV5e/MHBhH4OiGbbKCPo3gqBDIu6BC6dEoPwacxkap3jick4tQ63htCd/KNogi8elU5HMz5J/QMejcmpKsdM9J8tMfmNSqiSXW7yzda8cbBvVz2bGDlszzNTdMbQmfhunzv7/GiDSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=j7TuDAHn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42SKvtEP022652;
	Thu, 28 Mar 2024 21:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=MAaPSlp2TcI43aJb4KF53ZXFC2Wi5a2pJ0Qp4ANe72c=; b=j7
	TuDAHnebWZ+cS5U+NzjHvG7Kqw6Dd6nfQNumX7V6Prn7favMLlIxhg63pnQwW1qy
	cVfUHftDkXKk8pw7t3TW8XaprJhXbX+nB30gHY0XBQf7kd0qdtNojmPVqc3pn2pc
	ZO9vrGEBHTeAobqy024h3xsLwaZBADnJXvMeiRwiz1FChxoXU6LE5paWMiXMzdMD
	bvCrJ4Fr9YTIX38gxow9R8NwW8TQiqlKngI8cFzZcdl6Os40x1HRK0ghtUhliwPy
	k7r/qSyejCgKGMI2mqEpfMK02s2dpcx+2Qx1RKdSrJ5mkT3igCO0Xb3tEw7+3Jn2
	jnM9gvGLrjM+6neQrJpw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x56njhqmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 21:16:36 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42SLGZO3012363
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 21:16:35 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 14:16:32 -0700
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
Subject: [PATCH v5 3/4] of: reserved_mem: Use the unflatten_devicetree APIs to scan reserved mem. nodes
Date: Thu, 28 Mar 2024 14:15:42 -0700
Message-ID: <20240328211543.191876-4-quic_obabatun@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 6x-p6tUlPhzRdEau4XQqhhngxIyfRhkD
X-Proofpoint-GUID: 6x-p6tUlPhzRdEau4XQqhhngxIyfRhkD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_17,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=997 impostorscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403280152

The unflatten_devicetree APIs have been setup and are available to be
used by the time the fdt_init_reserved_mem() function is called.
Since the unflatten_devicetree APIs are a more efficient way of scanning
through the DT nodes, switch to using these APIs to facilitate the rest
of the reserved memory processing.

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 drivers/of/of_reserved_mem.c    | 77 +++++++++++++++++++++------------
 include/linux/of_reserved_mem.h |  2 +-
 kernel/dma/coherent.c           |  8 ++--
 kernel/dma/contiguous.c         |  8 ++--
 kernel/dma/swiotlb.c            | 10 ++---
 5 files changed, 64 insertions(+), 41 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 0aba366eba59..68d1f4cca4bb 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -99,7 +99,7 @@ static void __init alloc_reserved_mem_array(void)
 /*
  * fdt_reserved_mem_save_node() - save fdt node for second pass initialization
  */
-static void __init fdt_reserved_mem_save_node(unsigned long node, const char *uname,
+static void __init fdt_reserved_mem_save_node(struct device_node *node, const char *uname,
 					      phys_addr_t base, phys_addr_t size)
 {
 	struct reserved_mem *rmem = &reserved_mem[reserved_mem_count];
@@ -109,7 +109,7 @@ static void __init fdt_reserved_mem_save_node(unsigned long node, const char *un
 		return;
 	}
 
-	rmem->fdt_node = node;
+	rmem->dev_node = node;
 	rmem->name = uname;
 	rmem->base = base;
 	rmem->size = size;
@@ -178,11 +178,11 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
 }
 
 /*
- * __reserved_mem_check_root() - check if #size-cells, #address-cells provided
+ * __fdt_reserved_mem_check_root() - check if #size-cells, #address-cells provided
  * in /reserved-memory matches the values supported by the current implementation,
  * also check if ranges property has been provided
  */
-static int __init __reserved_mem_check_root(unsigned long node)
+static int __init __fdt_reserved_mem_check_root(unsigned long node)
 {
 	const __be32 *prop;
 
@@ -200,6 +200,29 @@ static int __init __reserved_mem_check_root(unsigned long node)
 	return 0;
 }
 
+/*
+ * __dt_reserved_mem_check_root() - check if #size-cells, #address-cells provided
+ * in /reserved-memory matches the values supported by the current implementation,
+ * also check if ranges property has been provided
+ */
+static int __init __dt_reserved_mem_check_root(struct device_node *node)
+{
+	const __be32 *prop;
+
+	prop = of_get_property(node, "#size-cells", NULL);
+	if (!prop || be32_to_cpup(prop) != dt_root_size_cells)
+		return -EINVAL;
+
+	prop = of_get_property(node, "#address-cells", NULL);
+	if (!prop || be32_to_cpup(prop) != dt_root_addr_cells)
+		return -EINVAL;
+
+	prop = of_get_property(node, "ranges", NULL);
+	if (!prop)
+		return -EINVAL;
+	return 0;
+}
+
 /**
  * fdt_scan_reserved_mem_reg_nodes() - Store info for the "reg" defined
  * reserved memory regions.
@@ -213,33 +236,38 @@ static int __init __reserved_mem_check_root(unsigned long node)
 static void __init fdt_scan_reserved_mem_reg_nodes(void)
 {
 	int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
-	const void *fdt = initial_boot_params;
+	struct device_node *node, *child;
 	phys_addr_t base, size;
 	const __be32 *prop;
-	int node, child;
 	int len;
 
-	node = fdt_path_offset(fdt, "/reserved-memory");
-	if (node < 0) {
+	node = of_find_node_by_path("/reserved-memory");
+	if (!node) {
 		pr_info("Reserved memory: No reserved-memory node in the DT\n");
 		return;
 	}
 
-	if (__reserved_mem_check_root(node)) {
+	if (__dt_reserved_mem_check_root(node)) {
 		pr_err("Reserved memory: unsupported node format, ignoring\n");
 		return;
 	}
 
-	fdt_for_each_subnode(child, fdt, node) {
+	for_each_child_of_node(node, child) {
 		const char *uname;
+		struct reserved_mem *rmem;
 
-		prop = of_get_flat_dt_prop(child, "reg", &len);
-		if (!prop)
+		if (!of_device_is_available(child))
 			continue;
-		if (!of_fdt_device_is_available(fdt, child))
+
+		prop = of_get_property(child, "reg", &len);
+		if (!prop) {
+			rmem = of_reserved_mem_lookup(child);
+			if (rmem)
+				rmem->dev_node = child;
 			continue;
+		}
 
-		uname = fdt_get_name(fdt, child, NULL);
+		uname = of_node_full_name(child);
 		if (len && len % t_len != 0) {
 			pr_err("Reserved memory: invalid reg property in '%s', skipping node.\n",
 			       uname);
@@ -269,7 +297,7 @@ int __init fdt_scan_reserved_mem(void)
 	if (node < 0)
 		return -ENODEV;
 
-	if (__reserved_mem_check_root(node) != 0) {
+	if (__fdt_reserved_mem_check_root(node) != 0) {
 		pr_err("Reserved memory: unsupported node format, ignoring\n");
 		return -EINVAL;
 	}
@@ -447,7 +475,7 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
 		       uname, (unsigned long)(size / SZ_1M));
 		return -ENOMEM;
 	}
-	fdt_reserved_mem_save_node(node, uname, base, size);
+	fdt_reserved_mem_save_node(NULL, uname, base, size);
 	return 0;
 }
 
@@ -467,7 +495,7 @@ static int __init __reserved_mem_init_node(struct reserved_mem *rmem)
 		reservedmem_of_init_fn initfn = i->data;
 		const char *compat = i->compatible;
 
-		if (!of_flat_dt_is_compatible(rmem->fdt_node, compat))
+		if (!of_device_is_compatible(rmem->dev_node, compat))
 			continue;
 
 		ret = initfn(rmem);
@@ -500,11 +528,6 @@ static int __init __rmem_cmp(const void *a, const void *b)
 	if (ra->size > rb->size)
 		return 1;
 
-	if (ra->fdt_node < rb->fdt_node)
-		return -1;
-	if (ra->fdt_node > rb->fdt_node)
-		return 1;
-
 	return 0;
 }
 
@@ -551,16 +574,16 @@ void __init fdt_init_reserved_mem(void)
 
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
 
@@ -574,7 +597,7 @@ void __init fdt_init_reserved_mem(void)
 		} else {
 			phys_addr_t end = rmem->base + rmem->size - 1;
 			bool reusable =
-				(of_get_flat_dt_prop(node, "reusable", NULL)) != NULL;
+				(of_get_property(node, "reusable", NULL)) != NULL;
 
 			pr_info("%pa..%pa (%lu KiB) %s %s %s\n",
 				&rmem->base, &end, (unsigned long)(rmem->size / SZ_1K),
diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index 4de2a24cadc9..b6107a18d170 100644
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
index 055da410ac71..22507f7d74d9 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -456,8 +456,8 @@ static const struct reserved_mem_ops rmem_cma_ops = {
 
 static int __init rmem_cma_setup(struct reserved_mem *rmem)
 {
-	unsigned long node = rmem->fdt_node;
-	bool default_cma = of_get_flat_dt_prop(node, "linux,cma-default", NULL);
+	struct device_node *node = rmem->dev_node;
+	bool default_cma = of_get_property(node, "linux,cma-default", NULL);
 	struct cma *cma;
 	int err;
 
@@ -467,8 +467,8 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
 		return -EBUSY;
 	}
 
-	if (!of_get_flat_dt_prop(node, "reusable", NULL) ||
-	    of_get_flat_dt_prop(node, "no-map", NULL))
+	if (!of_get_property(node, "reusable", NULL) ||
+	    of_get_property(node, "no-map", NULL))
 		return -EINVAL;
 
 	if (!IS_ALIGNED(rmem->base | rmem->size, CMA_MIN_ALIGNMENT_BYTES)) {
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 86fe172b5958..22cf195f652c 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1799,12 +1799,12 @@ static const struct reserved_mem_ops rmem_swiotlb_ops = {
 
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


