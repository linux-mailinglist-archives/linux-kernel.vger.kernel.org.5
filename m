Return-Path: <linux-kernel+bounces-40876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D65EA83E761
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B0891F21FA1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370A05D725;
	Fri, 26 Jan 2024 23:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IJXMEjF7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6192D50A83;
	Fri, 26 Jan 2024 23:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706313358; cv=none; b=KdI51lKKwe4k26wtZD0Ysz+1m50CMxZowGDZhk7m/UDDP//9yo/o/S2fiYWogTux6O9Kj+FHRAeLV2+171peq0oBByT1ptHsVeKZFlw3CL46p1YklMF+2MU7AIwd684azkCrAqjdKytaFYigl9h4ZvarX9+VoZeJbatfX5pxqgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706313358; c=relaxed/simple;
	bh=ZNkzYdVcT9Nj04++eh+mZpfKJlksh208udi2p7YM9nc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WVA18zHQQBxUrRaLWXxN4MLnarfPZLRShPJu7yngPmm7V7pSoM4qzfX3nMD1t9FiLxYi27s5ZIusDbHlN0aClfPr/2Y6zlD0g0//ribXEyC9zKYrywO4oPVP7n7RHTy91lYGTnZXRpw6l//ZA/Hp7OO3p5Mg6Sxc6GCQpA9rTs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IJXMEjF7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QNlaNo008339;
	Fri, 26 Jan 2024 23:55:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=mLHtTIAeQUQkSAuDL0y5
	SXd0co7k212sKGf9Z9Z0dkk=; b=IJXMEjF7Uf9M13f2zhf24fnDEdGz2TWFg1C5
	ytslMBmKHiRRUvHPq06O45ipCWGpxlwUfB4Dv3sf5zUPN+ndYcyKVOmjrFiWKC6r
	o7XiAe0hkK19QXXrUsT3cTKZ1cYyEiJGzmyCz74ABN0HqWcDYNQLa4KKXtmwWuCh
	O1JgwtOXbb9vrjsAsTiFsICD5YYNhV9pmkYnacNM+rs3Khz5HUvTgFnw4M+ZSRRM
	b/p7WJUZHsoYlTVjOgi41oE8jv1u1kJEu5UkJmIOWuokC+3EWaprIpKm96qnibae
	rzYFMeidAiXuzQfim+ZBE7j2EseLOpc59QoIIqIp3uh8LiDDgQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vv6c8j5x3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 23:55:06 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40QNt5Vs018478
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 23:55:05 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 26 Jan 2024 15:55:01 -0800
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
Subject: [PATCH 11/46] openrisc: reserved_mem: Implement the new processing order for reserved memory
Date: Fri, 26 Jan 2024 15:53:50 -0800
Message-ID: <20240126235425.12233-12-quic_obabatun@quicinc.com>
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
X-Proofpoint-GUID: VfDk2Qj4FCxoMOSbNRk_TB2J9m4IVAI3
X-Proofpoint-ORIG-GUID: VfDk2Qj4FCxoMOSbNRk_TB2J9m4IVAI3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=638
 priorityscore=1501 bulkscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 spamscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2401260176

Call early_fdt_scan_reserved_mem() in place of
early_init_fdt_scan_reserved_mem() to carry out the first stage of the
reserved memory processing only.

The early_fdt_scan_reserved_mem() function is used to scan through the
DT and mark all the reserved memory regions as reserved or nomap as
needed, as well as allocate the memory required by the
dynamically-placed
reserved memory regions.

The second stage of the reserved memory processing is done by
fdt_init_reserved_mem(). This function is used to store the information
of the statically-placed reserved memory nodes in the reserved_mem
array as well as call the region specific initialization function on all
the stored reserved memory regions.

The call to fdt_init_reserved_mem() is placed right after
early_fdt_scan_reserved_mem() because memblock allocated memory should
already be writable at this point.

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 arch/openrisc/kernel/setup.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
index 9cf7fb60441f..2c7059a0484b 100644
--- a/arch/openrisc/kernel/setup.c
+++ b/arch/openrisc/kernel/setup.c
@@ -31,6 +31,7 @@
 #include <linux/serial.h>
 #include <linux/initrd.h>
 #include <linux/of_fdt.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/of.h>
 #include <linux/device.h>
 
@@ -86,7 +87,8 @@ static void __init setup_memory(void)
 #endif /* CONFIG_BLK_DEV_INITRD */
 
 	early_init_fdt_reserve_self();
-	early_init_fdt_scan_reserved_mem();
+	early_fdt_scan_reserved_mem();
+	fdt_init_reserved_mem();
 
 	memblock_dump_all();
 }
-- 
2.17.1


