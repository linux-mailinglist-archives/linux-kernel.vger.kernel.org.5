Return-Path: <linux-kernel+bounces-40889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A41F383E7A5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A61828C9CA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90934657D0;
	Fri, 26 Jan 2024 23:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UZtyN71r"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79356087C;
	Fri, 26 Jan 2024 23:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706313365; cv=none; b=er/FiY1wndS39JrUNG6J5yLlY7ShWleqrmJkX6w14P1dKYuCurw3Kd7D/lO9DYUJINY+j3yzp5w54UP5bfS1mibblhwdu41ITix3/yPZgu80qbvL4AiBG2nU39yi/UngLXJzn0/jUTCDSOJW2r+FNspoA//VMtz2GlrY1Uzk9KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706313365; c=relaxed/simple;
	bh=mnaTXHL7qyvkBg0qOOl7qQWPWG3GB5Bnp457+ulZn3o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RpsKxeDcRnUX8sq/O1feGER3oK+2zvQT2ucjuCMNLsPZ1Vce8c9pGiZV6IWrDOmRkirH3xFC7h0b05vqMpsgtzpPp1pcm3yZCsIPjmtYhEBfktzMwrKEF9Z1JQZvXq+3T/K6i0Mfc8XoY2WxUmIBDFGzE9pWhPMO6irVZdlYDFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UZtyN71r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QNjlab020531;
	Fri, 26 Jan 2024 23:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=qI6VfLKrBrkEDM9xCiQN
	Zx23EmHN2UyOxrcxb9sAKGo=; b=UZtyN71rn7dLwmmFHoJXPMujguYOLAnW4PCx
	RElDN5UGhPa+1YZM7AnM+0WC9S4bmFQAPXfcCTR6S1e8d+nh6rWSp9o6I4uCvHYX
	e4x8BRN3v3M9Cj2ISg1pJSjllgGAXkN7H+0sfAzLcAN1vwxAfsK/xb3CDo3GagFZ
	viaFI+OiRbYEDcFYcfmdUmTUFQBKgNRm6w3dubsaNmNa92frzjf507L7/tBCavso
	e/rbHKd8lGmf4P8fvb0zV/lb2qJk1e1CMo7bb/A8vDbqUh2t3wMqnI9j4mCy3KyT
	VQCMmc4UcnQadY07eM/x0sncubgX0V10oqNXb6ip9zRxQp+uGg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vv4f9jd0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 23:55:14 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40QNtEer030740
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 23:55:14 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 26 Jan 2024 15:55:04 -0800
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
Subject: [PATCH 18/46] of: reserved_mem: Add code to dynamically allocate reserved_mem array
Date: Fri, 26 Jan 2024 15:53:57 -0800
Message-ID: <20240126235425.12233-19-quic_obabatun@quicinc.com>
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
X-Proofpoint-ORIG-GUID: eVS7f7ccMtCIjS3leU8ZnSql-wIPXqEV
X-Proofpoint-GUID: eVS7f7ccMtCIjS3leU8ZnSql-wIPXqEV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401260176

The reserved_mem array is statically allocated with a size of
MAX_RESERVED_REGIONS(64). Therefore, if the number of reserved_mem
regions exceeds this size, there will not be enough space to store
all the data.

Hence, extend the use of the static array by introducing a
dynamically allocated array based on the number of reserved memory
regions specified in the DT.

The static array is initally used to store the information for the
dynamically-placed regions. At the same time, the number of reserved
memory regions specified in the DT is counted.
The number counted is then used to dynamically allocate the memory
required for the reserved_mem array.
Afterwards, all entries from the static array is copied over to the new
allocated memory for the array, and all other statically-placed regions
are added in as well.

The static array is also marked as __initdata so that once the init
process is done running, this memory is freed back to buddy since it is
no longer used after this point.

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 drivers/of/fdt.c             | 11 ++++++--
 drivers/of/of_private.h      |  1 +
 drivers/of/of_reserved_mem.c | 52 +++++++++++++++++++++++++++++++++---
 3 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index c6e8560946f4..ebd2fa9e0114 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -613,7 +613,7 @@ void __init fdt_scan_reserved_mem_reg_nodes(void)
 static int __init fdt_scan_reserved_mem(void)
 {
 	int node, child;
-	int dynamic_nodes_cnt = 0;
+	int dynamic_nodes_cnt = 0, count = 0;
 	int dynamic_nodes[MAX_RESERVED_REGIONS];
 	const void *fdt = initial_boot_params;
 
@@ -636,6 +636,8 @@ static int __init fdt_scan_reserved_mem(void)
 		uname = fdt_get_name(fdt, child, NULL);
 
 		err = __reserved_mem_reserve_reg(child, uname);
+		if (!err)
+			count++;
 
 		/* Delay allocation of the dynamically-placed regions
 		 * until after all other statically-placed regions have
@@ -649,12 +651,17 @@ static int __init fdt_scan_reserved_mem(void)
 
 	for (int i = 0; i < dynamic_nodes_cnt; i++) {
 		const char *uname;
+		int err;
 
 		child = dynamic_nodes[i];
 		uname = fdt_get_name(fdt, child, NULL);
 
-		__reserved_mem_alloc_size(child, uname);
+		err = __reserved_mem_alloc_size(child, uname);
+		if (!err)
+			count++;
 	}
+	update_reserved_mem_max_cnt(count);
+
 	return 0;
 }
 
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 542e37a37a24..c338e1c019c7 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -176,6 +176,7 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
 }
 #endif
 
+void update_reserved_mem_max_cnt(int max_count);
 void fdt_reserved_mem_save_node(unsigned long node, const char *uname,
 			       phys_addr_t base, phys_addr_t size);
 
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index d62f1956024c..419b062cb41f 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -26,7 +26,9 @@
 
 #include "of_private.h"
 
-static struct reserved_mem reserved_mem[MAX_RESERVED_REGIONS];
+static struct reserved_mem reserved_mem_array[MAX_RESERVED_REGIONS] __initdata;
+static struct reserved_mem *reserved_mem __refdata = reserved_mem_array;
+static int total_reserved_mem_cnt = MAX_RESERVED_REGIONS;
 static int reserved_mem_count;
 
 static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
@@ -54,6 +56,46 @@ static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
 	return err;
 }
 
+void __init update_reserved_mem_max_cnt(int max_count)
+{
+	total_reserved_mem_cnt = max_count;
+}
+
+/*
+ * alloc_reserved_mem_array() - allocate memory for the reserved_mem
+ * array.
+ */
+static int alloc_reserved_mem_array(void)
+{
+	struct reserved_mem *new_array;
+	size_t alloc_size, copy_size, memset_size;
+
+	alloc_size = array_size(total_reserved_mem_cnt, sizeof(*new_array));
+	if (alloc_size == SIZE_MAX)
+		return -1;
+
+	new_array = memblock_alloc(alloc_size, SMP_CACHE_BYTES);
+	if (!new_array)
+		return -ENOMEM;
+
+	copy_size = array_size(reserved_mem_count, sizeof(*new_array));
+	if (copy_size == SIZE_MAX)
+		goto overlow_err;
+
+	memset_size = alloc_size - copy_size;
+
+	memcpy(new_array, reserved_mem, copy_size);
+	memset(new_array + reserved_mem_count, 0, memset_size);
+
+	reserved_mem = new_array;
+	return 0;
+
+overlow_err:
+	memblock_free(new_array, alloc_size);
+	total_reserved_mem_cnt = MAX_RESERVED_REGIONS;
+	return -1;
+}
+
 /*
  * fdt_reserved_mem_save_node() - save fdt node for second pass initialization
  */
@@ -62,7 +104,7 @@ void __init fdt_reserved_mem_save_node(unsigned long node, const char *uname,
 {
 	struct reserved_mem *rmem = &reserved_mem[reserved_mem_count];
 
-	if (reserved_mem_count == ARRAY_SIZE(reserved_mem)) {
+	if (reserved_mem_count == total_reserved_mem_cnt) {
 		pr_err("not enough space for all defined regions.\n");
 		return;
 	}
@@ -303,7 +345,11 @@ static void __init __rmem_check_for_overlap(void)
  */
 void __init fdt_init_reserved_mem(void)
 {
-	int i;
+	int i, ret;
+
+	ret = alloc_reserved_mem_array();
+	if (ret)
+		pr_err("Failed to allocate memory for reserved_mem array with err: %d", ret);
 
 	fdt_scan_reserved_mem_reg_nodes();
 
-- 
2.17.1


