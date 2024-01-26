Return-Path: <linux-kernel+bounces-40890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E31E383E7A8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 733AB28D047
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2B365BB0;
	Fri, 26 Jan 2024 23:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Q9MFmI/0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1A260891;
	Fri, 26 Jan 2024 23:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706313365; cv=none; b=EgXJtVkDIK8TljsU4MOiK//eUG5tCY2KdQFPfjRRGxB6357/2AraSKvA9cVLeLj9G9e2pZHJFBY50bkVtDezPGzsorsflCSE3M3wjDHvHrwigdFWp5c4iD40yKtyTyiFbhNaNiQ94dT3pcBsl15HLVxm0uYLRK7Sx6yyMnuQrLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706313365; c=relaxed/simple;
	bh=NjEBBPmts20IxnmpGdS5v6kjIG4dAFLZZeM15CX6CZE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QMpq7L/v2/3a5WJjikxuTcy4gtM9CnJY58UXRBceOtGG4MaJxAdtwt1T6Xfrz6vqEymF77PjSdKmP6DUFSf6Hr7ce9s/aUF3kkl1ocF0CBl8kfd8u7iYIlq/ovasY0b4D2ePsL1kl2TliYhzWFG4Hg4sGuDLD5GtfrAE3+GeSw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Q9MFmI/0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QNt2ql006015;
	Fri, 26 Jan 2024 23:55:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=kZa2Pe53+6g14o/QY6sX
	E+C2csDopSUWS/8cevqSYa0=; b=Q9MFmI/0qU7Eq7vCH9+LsoEjT4jkmvBEFP2b
	V18Uay8A2aX+UFs/VwyhFxWowzM3v8cV5nhv+GwYFeaOiirDeMnz9s5XRgGatEzH
	5F8/c3YnxJDch0cP5O9Njt2C0LGiXnQHSZXn3NDNrFvDeSVnOUxhozcWHu+OKdQs
	juoHbzv2Kc2xncvwVClwqNQBCTPdhJuSuO4glagnQ2jfkG1ip9IZbMuNijR0S8qM
	3Wv9mwMv3F6tfydwy5ofXznCETy3pZ64cQgVItgWKDHz0exYXfNaKmSjJvlgRbDd
	yn4jEw320ZG8nha5IDM/fruFWxh735g9QGqsClRIp3EpkLWc2g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vv4f9jd0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 23:55:02 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40QNt1JV009985
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 23:55:01 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 26 Jan 2024 15:54:57 -0800
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
Subject: [PATCH 02/46] of: reserved_mem: Introduce new early reserved memory scan function
Date: Fri, 26 Jan 2024 15:53:41 -0800
Message-ID: <20240126235425.12233-3-quic_obabatun@quicinc.com>
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
X-Proofpoint-ORIG-GUID: U2-fU3rRD1n6fc8VYjNIwksODXsmUq9K
X-Proofpoint-GUID: U2-fU3rRD1n6fc8VYjNIwksODXsmUq9K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=452 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401260176

Introduce new reserved memory scan function called
early_fdt_scan_reserved_mem() which is a clone of the original
early_init_fdt_scan_reserved_mem() function, but does not call
fdt_init_reserved_mem() at the end.

This will allow architectures to separate the first stage of the
reserved memory processing which is done by
early_init_fdt_scan_reserved_mem() from the second stage of the reserved
memory processing which is done by fdt_init_reserved_mem().

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 drivers/of/fdt.c       | 27 +++++++++++++++++++++++++++
 include/linux/of_fdt.h |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index d02884ec0b6b..6bda033936af 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -711,6 +711,33 @@ void __init early_init_fdt_scan_reserved_mem(void)
 	fdt_init_reserved_mem();
 }
 
+/**
+ * early_fdt_scan_reserved_mem() - create reserved memory regions
+ *
+ * This function grabs memory from early allocator for device exclusive use
+ * defined in device tree structures. It should be called by arch specific code
+ * once the early allocator (i.e. memblock) has been fully activated.
+ */
+void __init early_fdt_scan_reserved_mem(void)
+{
+	int n;
+	u64 base, size;
+
+	if (!initial_boot_params)
+		return;
+
+	fdt_scan_reserved_mem();
+	fdt_reserve_elfcorehdr();
+
+	/* Process header /memreserve/ fields */
+	for (n = 0; ; n++) {
+		fdt_get_mem_rsv(initial_boot_params, n, &base, &size);
+		if (!size)
+			break;
+		memblock_reserve(base, size);
+	}
+}
+
 /**
  * early_init_fdt_reserve_self() - reserve the memory used by the FDT blob
  */
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index 7b2a5d93d719..9b849c5c3917 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -63,6 +63,7 @@ extern int early_init_dt_scan_memory(void);
 extern void early_init_dt_check_for_usable_mem_range(void);
 extern int early_init_dt_scan_chosen_stdout(void);
 extern void early_init_fdt_scan_reserved_mem(void);
+extern void early_fdt_scan_reserved_mem(void);
 extern void early_init_fdt_reserve_self(void);
 extern void early_init_dt_add_memory_arch(u64 base, u64 size);
 extern u64 dt_mem_next_cell(int s, const __be32 **cellp);
@@ -88,6 +89,7 @@ extern void early_get_first_memblock_info(void *, phys_addr_t *);
 static inline void early_init_dt_check_for_usable_mem_range(void) {}
 static inline int early_init_dt_scan_chosen_stdout(void) { return -ENODEV; }
 static inline void early_init_fdt_scan_reserved_mem(void) {}
+static inline void early_fdt_scan_reserved_mem(void) {}
 static inline void early_init_fdt_reserve_self(void) {}
 static inline const char *of_flat_dt_get_machine_name(void) { return NULL; }
 static inline void unflatten_device_tree(void) {}
-- 
2.17.1


