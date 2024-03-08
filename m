Return-Path: <linux-kernel+bounces-97499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D0E876B17
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E1D0282A12
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985215B5D5;
	Fri,  8 Mar 2024 19:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VlNcHMWz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352355A7B5;
	Fri,  8 Mar 2024 19:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709925219; cv=none; b=DWD17QZYH11nfJfGKM9n+r3odSWppDpl7Rmh4W+YfXweTZ6rKVbWPV80Mg2fQJLCG16S7S/AfHiAPYsYFMlqfWUjapAoe0emYRMpzCs5w1wBkR2i/Rew5J29TKmcXdNGN+LRmbEm9kMDCBapPCCQtswamtA3claXdv0aFZ4riYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709925219; c=relaxed/simple;
	bh=ZBg0ATi8Ky7Xe/2ClyJLKrSdZy4GBkPxIy69sV6PcwY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A7vZIdyyZYfy9kcMmlsrlk7U5WWOmQEnvaYN2etqwK6YsB28GDc0XZgZxeNzhOQVxegtCemhDUbAkX50Ss8Ek5Hbe64t8MKSB4kePvMMYpa8zsvmqIkOdfWBXBBldcWrhF2IabGHjrHStHxFLXoPs+6YMsH+FIR4GwKF7o7cfR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VlNcHMWz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 428Ia6Lk014709;
	Fri, 8 Mar 2024 19:12:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=YWKo5hfeN1dHC2eJBtj7dn2Dw/vycuIkLhqrLxET/j0=; b=Vl
	NcHMWzhnGRw3cPapHCmd05saOgxIjNI4gguOzHs+BkP+PMjN2gy0LDMPMuAcxm1k
	DAeYZHE7xFaAHTeYLy9ECHFq6Xl7/BbPxiT3A2wrxR7p7iezXg56kc0htdaEIcIy
	MT0klI+jhBgwml13uz7Ots9xGmSBF4Eh1e6B2H2HmRAD7MyPM0wrLgBVo6vS8azV
	ShX3vCP2OagrF6giQEbYwCWrtR+dBMpWJxhJtXMiGVj/ef9mK03phf7pwno1rpxh
	rV9idPLzvPf/nT5C9I5Rtb6JnpVrTUlxO7+F+qj5PZrsLk2WG/Q4b9nQq0AYlLkX
	l7hCBx3CjWdPIGfOj/qg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wr82x02x9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 19:12:30 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 428JCT1w005678
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 8 Mar 2024 19:12:29 GMT
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
Subject: [PATCH v4 4/4] of: reserved_mem: Rename fdt_* functions to refelct use of unflatten_devicetree APIs
Date: Fri, 8 Mar 2024 11:12:04 -0800
Message-ID: <20240308191204.819487-5-quic_obabatun@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 5MueeBaeKBGY6HLUZEinlb4jupVVyEx9
X-Proofpoint-GUID: 5MueeBaeKBGY6HLUZEinlb4jupVVyEx9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=828 lowpriorityscore=0
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403080152

Rename the relevant fdt_* functions to a new naming scheme, dt_*, to
reflect the use of the unflatten_devicetree APIs to scan through the
reserved memory regions defined in the DT.

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 drivers/of/fdt.c                |  2 +-
 drivers/of/of_private.h         |  4 ++--
 drivers/of/of_reserved_mem.c    | 14 +++++++-------
 include/linux/of_reserved_mem.h |  4 ++--
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 11630eba965c..e51bb3aa782b 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1355,7 +1355,7 @@ void __init unflatten_device_tree(void)
 	of_alias_scan(early_init_dt_alloc_memory_arch);
 
 	unittest_unflatten_overlay_base();
-	fdt_init_reserved_mem();
+	dt_init_reserved_mem();
 }
 
 /**
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index aa8844318257..8970948e10d4 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -177,7 +177,7 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
 }
 #endif
 
-void fdt_reserved_mem_save_node(struct device_node *node, const char *uname,
-				phys_addr_t base, phys_addr_t size);
+void dt_reserved_mem_save_node(struct device_node *node, const char *uname,
+			       phys_addr_t base, phys_addr_t size);
 
 #endif /* _LINUX_OF_PRIVATE_H */
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 8d50a5178440..7d154d188a74 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -147,15 +147,15 @@ static void __init dt_scan_reserved_mem_reg_nodes(void)
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
 
@@ -307,7 +307,7 @@ int __init __reserved_mem_alloc_size(unsigned long node, const char *uname)
 		       uname, (unsigned long)(size / SZ_1M));
 		return -ENOMEM;
 	}
-	fdt_reserved_mem_save_node(NULL, uname, base, size);
+	dt_reserved_mem_save_node(NULL, uname, base, size);
 	return 0;
 }
 
@@ -391,9 +391,9 @@ static void __init __rmem_check_for_overlap(void)
 }
 
 /**
- * fdt_init_reserved_mem() - allocate and init all saved reserved memory regions
+ * dt_init_reserved_mem() - allocate and init all saved reserved memory regions
  */
-void __init fdt_init_reserved_mem(void)
+void __init dt_init_reserved_mem(void)
 {
 	int i, ret;
 
diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index e92babd669c2..dd67b9b2488e 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -32,7 +32,7 @@ typedef int (*reservedmem_of_init_fn)(struct reserved_mem *rmem);
 #define RESERVEDMEM_OF_DECLARE(name, compat, init)			\
 	_OF_DECLARE(reservedmem, name, compat, init, reservedmem_of_init_fn)
 
-void fdt_init_reserved_mem(void);
+void dt_init_reserved_mem(void);
 int of_reserved_mem_device_init_by_idx(struct device *dev,
 				       struct device_node *np, int idx);
 int of_reserved_mem_device_init_by_name(struct device *dev,
@@ -47,7 +47,7 @@ struct reserved_mem *of_reserved_mem_lookup(struct device_node *np);
 #define RESERVEDMEM_OF_DECLARE(name, compat, init)			\
 	_OF_DECLARE_STUB(reservedmem, name, compat, init, reservedmem_of_init_fn)
 
-static inline void fdt_init_reserved_mem(void) { }
+static inline void dt_init_reserved_mem(void) { }
 
 static inline int of_reserved_mem_device_init_by_idx(struct device *dev,
 					struct device_node *np, int idx)
-- 
2.34.1


