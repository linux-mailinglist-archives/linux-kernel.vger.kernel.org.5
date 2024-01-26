Return-Path: <linux-kernel+bounces-40905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F5A83E7B9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93BADB298C9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0DE67E68;
	Fri, 26 Jan 2024 23:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RcS0XWtL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F23063130;
	Fri, 26 Jan 2024 23:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706313369; cv=none; b=pYyBcPg3j3bjDnUghSv+0psnFvhlnFPi6rrvoWM9srG3XGIxUAeIF22VHGziXdtbbt2oB7UOe0F1DTGMOZq4yiD3zkFWpf9eRHE1XWPZVomJTYx0teJ+BdyIvB9LjFPWYwmyCsWlCJZerjp+pp5NhZrVGNrEsmtaYhywhTM9c28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706313369; c=relaxed/simple;
	bh=4kE40rentgCzKkOcqUeGGTq5KdPNr9+7RUBnuYinc/A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jrU2vIiUKCDzlR4LKJCwwX/1npydzPGqYRkna0ok2Hjt920gBB6reOuvW/SMgPFAk6DKuVWX3MSt8BK9rGc8QAGdXA/4Tha65qQoHK0jyyWy+4SPQdlaFOX1sVJn6s8NS403Dk4DZUPW/o3TIzZe1YUYXtWQ93zXTZFDEoWUSFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RcS0XWtL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QMoBpP016990;
	Fri, 26 Jan 2024 23:55:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=NSJIpzRt23eV6cwLNaH4
	bWRVS5c+2PsTe/XQM/ncC7Q=; b=RcS0XWtL768b2HlqXCg7qaVbfuHia+Sf8KoG
	sWcFqfiCM3xJY5b+Khh5WynJO8LX4v/KWbzbd4FCNC9ix8FVIMOo7KyEouGl3VQN
	XAUcfzS1HINpNPhxgaCDvMpiTG2DkR86j4M553RtOy76u94Q+E5UkKU1zje5J7TD
	NA9tDxQGLL1UXvjURO9pndNsONKVY/2EZx+Yoy8zgpNPFln1CFi0iVclYI75cw7T
	/pGtpruHJhQYqtSHLNylDrubfKSGQo5cF/JaNnvsHHwHT9xUxz3ks9N5H+30bF6b
	3AkNx3rwQYvBf3RIC3CuaeA2bQ9joJqsW96ypEbDOB6HgBujlw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvfc8h027-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 23:55:33 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40QNtUwp018645
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 23:55:32 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 26 Jan 2024 15:55:20 -0800
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
Subject: [PATCH 46/46] of: reserved_mem: Delete the fdt_init_reserved_mem() function
Date: Fri, 26 Jan 2024 15:54:25 -0800
Message-ID: <20240126235425.12233-47-quic_obabatun@quicinc.com>
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
X-Proofpoint-GUID: 2QLwr9m8kGb_VZUlrTBCN69DQQNWIECu
X-Proofpoint-ORIG-GUID: 2QLwr9m8kGb_VZUlrTBCN69DQQNWIECu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=449
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401260176

Delete the fdt_init_reserved_mem() function as all architectures have
been switched to using dt_init_reserved_mem(), which is basically a copy
of the function, but uses the unflatten devicetree APIs instead of the
fdt APIs.

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 drivers/of/of_reserved_mem.c    | 54 ---------------------------------
 include/linux/of_reserved_mem.h |  3 --
 2 files changed, 57 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 3650efab0afd..3d1ab2325217 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -382,60 +382,6 @@ static void __init __rmem_check_for_overlap(void)
 	}
 }
 
-/**
- * fdt_init_reserved_mem() - allocate and init all saved reserved memory regions
- */
-void __init fdt_init_reserved_mem(void)
-{
-	int i, ret;
-
-	ret = alloc_reserved_mem_array();
-	if (ret)
-		pr_err("Failed to allocate memory for reserved_mem array with err: %d", ret);
-
-	dt_scan_reserved_mem_reg_nodes();
-
-	/* check for overlapping reserved regions */
-	__rmem_check_for_overlap();
-
-	for (i = 0; i < reserved_mem_count; i++) {
-		struct reserved_mem *rmem = &reserved_mem[i];
-		struct device_node *node = rmem->dev_node;
-		int len;
-		const __be32 *prop;
-		int err = 0;
-		bool nomap;
-
-		nomap = of_get_property(node, "no-map", NULL) != NULL;
-		prop = of_get_property(node, "phandle", &len);
-		if (!prop)
-			prop = of_get_property(node, "linux,phandle", &len);
-		if (prop)
-			rmem->phandle = of_read_number(prop, len/4);
-
-		err = __reserved_mem_init_node(rmem);
-		if (err != 0 && err != -ENOENT) {
-			pr_info("node %s compatible matching fail\n",
-				rmem->name);
-			if (nomap)
-				memblock_clear_nomap(rmem->base, rmem->size);
-			else
-				memblock_phys_free(rmem->base,
-						   rmem->size);
-		} else {
-			phys_addr_t end = rmem->base + rmem->size - 1;
-			bool reusable =
-				(of_get_property(node, "reusable", NULL)) != NULL;
-
-			pr_info("%pa..%pa (%lu KiB) %s %s %s\n",
-				&rmem->base, &end, (unsigned long)(rmem->size / SZ_1K),
-				nomap ? "nomap" : "map",
-				reusable ? "reusable" : "non-reusable",
-				rmem->name ? rmem->name : "unknown");
-		}
-	}
-}
-
 /**
  * dt_init_reserved_mem() - allocate and init all saved reserved memory regions
  */
diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index b1f71a4894aa..dd67b9b2488e 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -33,7 +33,6 @@ typedef int (*reservedmem_of_init_fn)(struct reserved_mem *rmem);
 	_OF_DECLARE(reservedmem, name, compat, init, reservedmem_of_init_fn)
 
 void dt_init_reserved_mem(void);
-void fdt_init_reserved_mem(void);
 int of_reserved_mem_device_init_by_idx(struct device *dev,
 				       struct device_node *np, int idx);
 int of_reserved_mem_device_init_by_name(struct device *dev,
@@ -50,8 +49,6 @@ struct reserved_mem *of_reserved_mem_lookup(struct device_node *np);
 
 static inline void dt_init_reserved_mem(void) { }
 
-static inline void fdt_init_reserved_mem(void) { }
-
 static inline int of_reserved_mem_device_init_by_idx(struct device *dev,
 					struct device_node *np, int idx)
 {
-- 
2.17.1


