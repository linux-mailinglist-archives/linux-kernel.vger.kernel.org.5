Return-Path: <linux-kernel+bounces-166863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0508BA10C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 077781F22542
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A945517BB0E;
	Thu,  2 May 2024 19:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oYA0/9tt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E4615FA74;
	Thu,  2 May 2024 19:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714677880; cv=none; b=Bamv9Jw2a8PO9yCOe8u4XO/vx0d3WXK9D13tRHajOal43ydkbCeixBgXHEG74fVImm505IaF2euRhyg/IV3Hn1VXHunmhEyw8Qdm+IQz0OSUGeqpiK6fFSLEiwzzgRUkmuMN6nzG1v8lVUqTeCzl1rKwTYHPUnCmm5YXOYnu8os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714677880; c=relaxed/simple;
	bh=EAePZDF8XNyp2wRcYAYzFho1tbEySQ1YjlPF8DAs2oQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j+YcEhL3AieaPG8kyeGgZgkDLe9IeSUADxk5pjeKdX39pm9e23f+zAGMbbuH3XuxWhUSmzM3cgokCWEr68gbIQ5UO/EULYt+zIl66u51/60692soaq37mlVZsSFxVsMXPskn4taJfShxrY69ZOnjqmwu9spLA/P+WY3g3ZjXDzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oYA0/9tt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 442FIjtk017812;
	Thu, 2 May 2024 19:24:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=QcfkUQW
	3XVkXgNiqcn6ekksykSb8JLl/zC0zWaF74JY=; b=oYA0/9ttFj0OpsJB3Df0638
	o7PKyH9Bype6dkqZh4j7BvHLN1APAKHhVy2h7/Q7SC8GHL0qcc4IG9Tn9VHmnc3R
	eR4sL7lfST0XoqKUKSdHYMzVWiCPpsNBCRPXIglNnNZ0KRHNLVGcaLBZqbVbRs0J
	+mxvbETtgsuT2+cTDCtCxQFbAecodHy3Ge3qCAOnQbaSlCix3pkUCHb9PY35ceWh
	PgTegh8vMThb68I6Is6ydT/6KL5aWy7NzbgBdpJUZMKdKlrj6j97vZj4oR5N4PyS
	OpwKluPhVGMccu7SGXgioq0FqsFSDu4JgvuqVFAIDITiGBIMy7uwYsO2ZIoyZJA=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xup5kuban-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 19:24:33 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 442JOWnv030648
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 2 May 2024 19:24:32 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 2 May 2024 12:24:28 -0700
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
To: <robh@kernel.org>, <saravanak@google.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Subject: [PATCH v2] of: reserved_mem: Remove the use of phandle from the reserved_mem APIs
Date: Thu, 2 May 2024 12:24:03 -0700
Message-ID: <20240502192403.3307277-1-quic_obabatun@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: sWlefe6RoSsbVFTJpczb2FYNwjbTa6AG
X-Proofpoint-GUID: sWlefe6RoSsbVFTJpczb2FYNwjbTa6AG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-02_11,2024-05-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 impostorscore=0 spamscore=0 mlxlogscore=890 lowpriorityscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405020127

The __find_rmem() function is the only place that references the phandle
field of the reserved_mem struct. __find_rmem() is used to match a
device_node object to its corresponding entry in the reserved_mem array
using its phandle value. But, there is already a function called
of_reserved_mem_lookup() which carries out the same action using the
name of the node.

Using the of_reserved_mem_lookup() function is more reliable because
every node is guaranteed to have a name, but not all nodes will have a
phandle.

Nodes are only assigned a phandle if they are explicitly defined in the
DT using "phandle = <phandle_number>", or if they are referenced by
another node in the DT. Hence, If the phandle field is empty, then
__find_rmem() will return a false negative.

Hence, delete the __find_rmem() function and switch to using the
of_reserved_mem_lookup() function to find the corresponding entry of a
device_node in the reserved_mem array. Since the phandle field of the
reserved_mem struct is now unused, delete that as well.

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
v2:
- Addressed error found by kernel test bot:
  https://lore.kernel.org/all/202405020127.3ncxx3EI-lkp@intel.com/
- Fixed spelling error in commit text.

v1:
https://lore.kernel.org/all/20240422235243.2878536-1-quic_obabatun@quicinc.com/

 drivers/of/of_reserved_mem.c    | 22 +---------------------
 include/linux/of_reserved_mem.h |  1 -
 2 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 8236ecae2953..46e1c3fbc769 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -437,17 +437,10 @@ void __init fdt_init_reserved_mem(void)
 	for (i = 0; i < reserved_mem_count; i++) {
 		struct reserved_mem *rmem = &reserved_mem[i];
 		unsigned long node = rmem->fdt_node;
-		int len;
-		const __be32 *prop;
 		int err = 0;
 		bool nomap;
 
 		nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
-		prop = of_get_flat_dt_prop(node, "phandle", &len);
-		if (!prop)
-			prop = of_get_flat_dt_prop(node, "linux,phandle", &len);
-		if (prop)
-			rmem->phandle = of_read_number(prop, len/4);
 
 		if (rmem->size == 0)
 			err = __reserved_mem_alloc_size(node, rmem->name,
@@ -477,19 +470,6 @@ void __init fdt_init_reserved_mem(void)
 	}
 }
 
-static inline struct reserved_mem *__find_rmem(struct device_node *node)
-{
-	unsigned int i;
-
-	if (!node->phandle)
-		return NULL;
-
-	for (i = 0; i < reserved_mem_count; i++)
-		if (reserved_mem[i].phandle == node->phandle)
-			return &reserved_mem[i];
-	return NULL;
-}
-
 struct rmem_assigned_device {
 	struct device *dev;
 	struct reserved_mem *rmem;
@@ -534,7 +514,7 @@ int of_reserved_mem_device_init_by_idx(struct device *dev,
 		return 0;
 	}
 
-	rmem = __find_rmem(target);
+	rmem = of_reserved_mem_lookup(target);
 	of_node_put(target);
 
 	if (!rmem || !rmem->ops || !rmem->ops->device_init)
diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index 4de2a24cadc9..e338282da652 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -11,7 +11,6 @@ struct reserved_mem_ops;
 struct reserved_mem {
 	const char			*name;
 	unsigned long			fdt_node;
-	unsigned long			phandle;
 	const struct reserved_mem_ops	*ops;
 	phys_addr_t			base;
 	phys_addr_t			size;
-- 
2.34.1


