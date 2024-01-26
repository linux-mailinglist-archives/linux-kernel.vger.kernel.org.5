Return-Path: <linux-kernel+bounces-40898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3343783E7B4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC4F328D61C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93594664CC;
	Fri, 26 Jan 2024 23:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YDh/4SGd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001CC60BB4;
	Fri, 26 Jan 2024 23:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706313367; cv=none; b=Kxy17T7ZG1HQ+fA/04yWuhZhpm0crDjzH2emt/bLFap1H+Ld7jiH7S54yxj/sJ4O5tJkhAcVgMvMkqcoBq1vH6wuVYuzxC+zwAu/ksTUQeetASE4Nd+WyPQlErEvZc5kpXWFGv2IAhQlSRIOyM5LEkwA/56Q6ATald5Me8KVa8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706313367; c=relaxed/simple;
	bh=AudqulAQ60IfEtaODp3Zx8VOJIFET5JKLr5kS7oiVrw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uCsiCwO9rMhrOB2axpNDSDmBgfBPFeYLggBVovwmAeigXBBp5HowBcLLkmC5y1915z3tzt7ZNEQmajIyfFYtcvUyzWzU2wSdfjZo2pYmO+ZzUWxtWmHsUCPZuyg6Q3neXZ5+q/lIHoa8fjhvbc5zjwfCvxJ6uLfij/sFFN5rt5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YDh/4SGd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QNrM4F027772;
	Fri, 26 Jan 2024 23:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=rEH2huP6AGk9XFpyAeli
	kvp4R8pHCMfGjVuoQPZZseo=; b=YDh/4SGdUAyiP7uLcqDFOTc8Wc+f2gHwJpQi
	Vetg124F5hTd8MmzhbfZmnLPaqPpurVg1Nz2c0SAzadwsgUu+oPD3+3Enzbtstrx
	zjOmzbqHRV/Tct3yinXT5JGfBS7ZnzX6uYQ6y4ikkydS8AmESFT4zREYR/+/26FM
	9bnx0feU6k4ewYRaYNZnLYqUv/gaxcKizVpC4VgWt+mmk+Tla/tf14ACEd3kycXC
	oSYjxwnHxsO1CCRywoG+l4AT2CIXLIjVcr7TDNQwTE7dcKQxVAnfrYQc4nRfiOEx
	Diff5us3UpXIP9H9XLMy5CKr+Nbiq6lcmHZC7zTbvz7lLRAOfQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvmmmg7we-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 23:55:29 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40QNtSKh010339
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 23:55:29 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 26 Jan 2024 15:55:13 -0800
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
Subject: [PATCH 31/46] of: reserved_mem: Rename fdt_* functions to refelct use of unflattened devicetree APIs
Date: Fri, 26 Jan 2024 15:54:10 -0800
Message-ID: <20240126235425.12233-32-quic_obabatun@quicinc.com>
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
X-Proofpoint-GUID: Hr4TeDNRkurySOwvrP4x31WI9EEga49r
X-Proofpoint-ORIG-GUID: Hr4TeDNRkurySOwvrP4x31WI9EEga49r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=659
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401260176

Rename the relevant fdt_* functions to a new scheme dt_* to reflect the
use of the unflattened devicetree APIs to process the reserved memory
regions.

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 drivers/of/of_private.h         |  4 +--
 drivers/of/of_reserved_mem.c    | 64 ++++++++++++++++++++++++++++++---
 include/linux/of_reserved_mem.h |  3 ++
 3 files changed, 64 insertions(+), 7 deletions(-)

diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index f7da22108e7a..1092615faa90 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -177,7 +177,7 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
 #endif
 
 void update_reserved_mem_max_cnt(int max_count);
-void fdt_reserved_mem_save_node(struct device_node *node, const char *uname,
-				phys_addr_t base, phys_addr_t size);
+void dt_reserved_mem_save_node(struct device_node *node, const char *uname,
+			       phys_addr_t base, phys_addr_t size);
 
 #endif /* _LINUX_OF_PRIVATE_H */
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 645b02e27492..3650efab0afd 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -139,15 +139,15 @@ static void __init dt_scan_reserved_mem_reg_nodes(void)
 		size = dt_mem_next_cell(dt_root_size_cells, &prop);
 
 		if (size)
-			fdt_reserved_mem_save_node(child, uname, base, size);
+			dt_reserved_mem_save_node(child, uname, base, size);
 	}
 }
 
 /*
- * fdt_reserved_mem_save_node() - save fdt node for second pass initialization
+ * dt_reserved_mem_save_node() - save dt node for second pass initialization
  */
-void __init fdt_reserved_mem_save_node(struct device_node *node, const char *uname,
-				       phys_addr_t base, phys_addr_t size)
+void __init dt_reserved_mem_save_node(struct device_node *node, const char *uname,
+				      phys_addr_t base, phys_addr_t size)
 {
 	struct reserved_mem *rmem = &reserved_mem[reserved_mem_count];
 
@@ -299,7 +299,7 @@ int __init __reserved_mem_alloc_size(unsigned long node, const char *uname)
 		       uname, (unsigned long)(size / SZ_1M));
 		return -ENOMEM;
 	}
-	fdt_reserved_mem_save_node(NULL, uname, base, size);
+	dt_reserved_mem_save_node(NULL, uname, base, size);
 	return 0;
 }
 
@@ -436,6 +436,60 @@ void __init fdt_init_reserved_mem(void)
 	}
 }
 
+/**
+ * dt_init_reserved_mem() - allocate and init all saved reserved memory regions
+ */
+void __init dt_init_reserved_mem(void)
+{
+	int i, ret;
+
+	ret = alloc_reserved_mem_array();
+	if (ret)
+		pr_err("Failed to allocate memory for reserved_mem array with err: %d", ret);
+
+	dt_scan_reserved_mem_reg_nodes();
+
+	/* check for overlapping reserved regions */
+	__rmem_check_for_overlap();
+
+	for (i = 0; i < reserved_mem_count; i++) {
+		struct reserved_mem *rmem = &reserved_mem[i];
+		struct device_node *node = rmem->dev_node;
+		int len;
+		const __be32 *prop;
+		int err = 0;
+		bool nomap;
+
+		nomap = of_get_property(node, "no-map", NULL) != NULL;
+		prop = of_get_property(node, "phandle", &len);
+		if (!prop)
+			prop = of_get_property(node, "linux,phandle", &len);
+		if (prop)
+			rmem->phandle = of_read_number(prop, len/4);
+
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
+				(of_get_property(node, "reusable", NULL)) != NULL;
+
+			pr_info("%pa..%pa (%lu KiB) %s %s %s\n",
+				&rmem->base, &end, (unsigned long)(rmem->size / SZ_1K),
+				nomap ? "nomap" : "map",
+				reusable ? "reusable" : "non-reusable",
+				rmem->name ? rmem->name : "unknown");
+		}
+	}
+}
+
 static inline struct reserved_mem *__find_rmem(struct device_node *node)
 {
 	unsigned int i;
diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index e92babd669c2..b1f71a4894aa 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -32,6 +32,7 @@ typedef int (*reservedmem_of_init_fn)(struct reserved_mem *rmem);
 #define RESERVEDMEM_OF_DECLARE(name, compat, init)			\
 	_OF_DECLARE(reservedmem, name, compat, init, reservedmem_of_init_fn)
 
+void dt_init_reserved_mem(void);
 void fdt_init_reserved_mem(void);
 int of_reserved_mem_device_init_by_idx(struct device *dev,
 				       struct device_node *np, int idx);
@@ -47,6 +48,8 @@ struct reserved_mem *of_reserved_mem_lookup(struct device_node *np);
 #define RESERVEDMEM_OF_DECLARE(name, compat, init)			\
 	_OF_DECLARE_STUB(reservedmem, name, compat, init, reservedmem_of_init_fn)
 
+static inline void dt_init_reserved_mem(void) { }
+
 static inline void fdt_init_reserved_mem(void) { }
 
 static inline int of_reserved_mem_device_init_by_idx(struct device *dev,
-- 
2.17.1


