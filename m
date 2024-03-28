Return-Path: <linux-kernel+bounces-123668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C639B890C69
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D0C6B23F0C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DA813B7A4;
	Thu, 28 Mar 2024 21:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OeMPOJvM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3137D13B592;
	Thu, 28 Mar 2024 21:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711660671; cv=none; b=lTV0ude8MzVqSWuNZyDUd3EbjvHGG/olUco5wGpB6mbPqAOtfkQDIgX1AEqp5DJOYtGtuMvyKpsKkaYBGDKsnIzG0B/WMB/16rIR5DdNPYelYbOqNoMEbl1G01q21KoH3COIk34/IOJUCnwf0NaXVBOUUAn0M9ndd7Y/Ba++9/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711660671; c=relaxed/simple;
	bh=lLggCMkacyFIKiAwDIxS1YmwOfm04H26CBHH8Ka7iog=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HYsOHsFKir2dtGPfi71uHiy/kQc0hrpL7AIRj2fwks17bINYvxmIGQr9WEb4E6+7sTItBLf1Q9CH1TlVRxiV6VZDe9m7tcEF1dpcx9JzmWeI6qzz52Jx4nddYv14deg+L901JV++atxpDm/7cYEdJC/Hj8cmPB1zRau8I2D0rT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OeMPOJvM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42SKDfJ2016218;
	Thu, 28 Mar 2024 21:16:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=+MY78+lW5U3e/L0EKh1VpFdXxuRr29FRbMT8d19Xzfo=; b=Oe
	MPOJvMA5uIvef9XtZKoKUZBkeDjx8zjlNZRdLblLc7IrarXR3aYl/Dxj51MJvChl
	QnHYk1qX3PPjAWfSvGdnUTzJjFBrEIO4Pqjgo3LGUPDyUXl0yZpzRJjfbdeUT6wn
	o07DUiFxcnsjVaUbrazufs12vnd6qU0+xLQ+LTjjLyr5JJZu2TMdsI73ErQbgEwU
	7Nd8sEhpBRHcSNpKX5YGKEA74iIx5eyo19QTTo1Wso0VijSyY3EftG7ppjcCVtUQ
	+2F4FQL/++dg5+cZBQw22NP7uXq3VwD/igjVCBShyerX6UkoLJaB3FPd2YZH1ROq
	yw6nZmH8JET4jaJEr5MQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x54r6275n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 21:16:36 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42SLGY8p032402
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 21:16:35 GMT
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
Subject: [PATCH v5 2/4] of: reserved_mem: Add code to dynamically allocate reserved_mem array
Date: Thu, 28 Mar 2024 14:15:41 -0700
Message-ID: <20240328211543.191876-3-quic_obabatun@quicinc.com>
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
X-Proofpoint-GUID: oXCDOQgYN7dmB4uBe8RxCQGEXTK2cGvB
X-Proofpoint-ORIG-GUID: oXCDOQgYN7dmB4uBe8RxCQGEXTK2cGvB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_17,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403280152

The reserved_mem array is statically allocated with a size of
MAX_RESERVED_REGIONS(64). Therefore, if the number of reserved_mem
regions exceeds this size, there will not be enough space to store
all the data.

Hence, extend the use of the static array by introducing a
dynamically allocated array based on the number of reserved memory
regions specified in the DT.

On architectures such as arm64, memblock allocated memory is not
writable until after the page tables have been setup. Hence, the
dynamic allocation of the reserved_mem array will need to be done only
after the page tables have been setup.

As a result, a temporary static array is still needed in the initial
stages to store the information of the dynamically-placed reserved
memory regions because the start address is selected only at run-time
and is not stored anywhere else.
It is not possible to wait until the reserved_mem array is allocated
because this is done after the page tables are setup and the reserved
memory regions need to be initialized before then.

After the reserved_mem array is allocated, all entries from the static
array is copied over to the new array, and the rest of the information
for the statically-placed reserved memory regions are read in from the
DT and stored in the new array as well.

Once the init process is completed, the temporary static array is
released back to the system because it is no longer needed. This is
achieved by marking it as __initdata.

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 drivers/of/of_reserved_mem.c | 58 +++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 4 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index db991de16cc0..0aba366eba59 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -27,7 +27,9 @@
 
 #include "of_private.h"
 
-static struct reserved_mem reserved_mem[MAX_RESERVED_REGIONS];
+static struct reserved_mem reserved_mem_array[MAX_RESERVED_REGIONS] __initdata;
+static struct reserved_mem *reserved_mem __refdata = reserved_mem_array;
+static int total_reserved_mem_cnt = MAX_RESERVED_REGIONS;
 static int reserved_mem_count;
 
 static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
@@ -55,6 +57,45 @@ static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
 	return err;
 }
 
+/*
+ * alloc_reserved_mem_array() - allocate memory for the reserved_mem
+ * array using memblock
+ *
+ * This function is used to allocate memory for the reserved_mem array
+ * according to the total number of reserved memory regions defined in
+ * the DT.
+ * After the new array is allocated, the information stored in the
+ * initial static array is copied over to this new array and the new
+ * array is used from this point on.
+ */
+static void __init alloc_reserved_mem_array(void)
+{
+	struct reserved_mem *new_array;
+	size_t alloc_size, copy_size, memset_size;
+
+	alloc_size = array_size(total_reserved_mem_cnt, sizeof(*new_array));
+	if (alloc_size == SIZE_MAX)
+		pr_err("Failed to allocate memory for reserved_mem array with err: %d", -EOVERFLOW);
+
+	new_array = memblock_alloc(alloc_size, SMP_CACHE_BYTES);
+	if (!new_array)
+		pr_err("Failed to allocate memory for reserved_mem array with err: %d", -ENOMEM);
+
+	copy_size = array_size(reserved_mem_count, sizeof(*new_array));
+	if (copy_size == SIZE_MAX) {
+		memblock_free(new_array, alloc_size);
+		total_reserved_mem_cnt = MAX_RESERVED_REGIONS;
+		pr_err("Failed to allocate memory for reserved_mem array with err: %d", -EOVERFLOW);
+	}
+
+	memset_size = alloc_size - copy_size;
+
+	memcpy(new_array, reserved_mem, copy_size);
+	memset(new_array + reserved_mem_count, 0, memset_size);
+
+	reserved_mem = new_array;
+}
+
 /*
  * fdt_reserved_mem_save_node() - save fdt node for second pass initialization
  */
@@ -63,7 +104,7 @@ static void __init fdt_reserved_mem_save_node(unsigned long node, const char *un
 {
 	struct reserved_mem *rmem = &reserved_mem[reserved_mem_count];
 
-	if (reserved_mem_count == ARRAY_SIZE(reserved_mem)) {
+	if (reserved_mem_count == total_reserved_mem_cnt) {
 		pr_err("not enough space for all defined regions.\n");
 		return;
 	}
@@ -220,7 +261,7 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
 int __init fdt_scan_reserved_mem(void)
 {
 	int node, child;
-	int dynamic_nodes_cnt = 0;
+	int dynamic_nodes_cnt = 0, count = 0;
 	int dynamic_nodes[MAX_RESERVED_REGIONS];
 	const void *fdt = initial_boot_params;
 
@@ -243,6 +284,8 @@ int __init fdt_scan_reserved_mem(void)
 		uname = fdt_get_name(fdt, child, NULL);
 
 		err = __reserved_mem_reserve_reg(child, uname);
+		if (!err)
+			count++;
 		/*
 		 * Save the nodes for the dynamically-placed regions
 		 * into an array which will be used for allocation right
@@ -257,11 +300,16 @@ int __init fdt_scan_reserved_mem(void)
 	}
 	for (int i = 0; i < dynamic_nodes_cnt; i++) {
 		const char *uname;
+		int err;
 
 		child = dynamic_nodes[i];
 		uname = fdt_get_name(fdt, child, NULL);
-		__reserved_mem_alloc_size(child, uname);
+
+		err = __reserved_mem_alloc_size(child, uname);
+		if (!err)
+			count++;
 	}
+	total_reserved_mem_cnt = count++;
 	return 0;
 }
 
@@ -494,6 +542,8 @@ void __init fdt_init_reserved_mem(void)
 {
 	int i;
 
+	alloc_reserved_mem_array();
+
 	fdt_scan_reserved_mem_reg_nodes();
 
 	/* check for overlapping reserved regions */
-- 
2.34.1


