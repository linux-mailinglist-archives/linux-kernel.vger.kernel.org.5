Return-Path: <linux-kernel+bounces-40895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 966F283E7AC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC4FC1C28BD2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2F465BBE;
	Fri, 26 Jan 2024 23:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EU3S0Dqq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B2360BB8;
	Fri, 26 Jan 2024 23:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706313367; cv=none; b=ZfzXP6QPo11GitPeA598g99RKxjbX8cDTZ0XIddWDlD03/NUV22q9LM81RQuAOVkTSxK//fRAQBeDNXRsrP7JME7xWOCoc8ALW4EB6X/dTuxTbcDBfCXhYSLVT0a/uGdv2wvQP/hlyNY+6hXECTGbUcRZX9mwAsWfn1uIckGIt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706313367; c=relaxed/simple;
	bh=brbafm8zG5bEO6ZEygmDVNrOQ4rLu6L3K3hY55OGH6g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u4KLdEukLznMCzZSLKLCHftVJM1XUILkuicpK4HxznOk/KEZYtFpOMv8U5yQc28nChqPw6IerYcxuyTOTzViy9rXrK8LX3KcV33UyYT/1EPnA/M4JHVwEMXwDR/uQ5ZacK6wn2zULL/5jJhZo9T8s8vLgJgXd6GjPW+OqKMtTsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EU3S0Dqq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QN0apG024428;
	Fri, 26 Jan 2024 23:55:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=Jx5Ie+iX+zXFm/ozaDr+
	RC/Fds5b7kbGceiUXNurK/w=; b=EU3S0DqqbCzdko0yxhM17OuvDNhJjjbAibGR
	dGTZf3seauf4BuQi859+zBathzf7d5gV2AatItu4iG0y43j+zUyGDEKFwsUfX/Ym
	YFWSxM6VWzcxv4eLctUcXl79b1p+4HcZptVGwgH7tnJVfm0Jby+s6GHu5wUIYVe5
	MPT26aP1v1vwmWVv8XuM154iypbNnZcVOpMAMb+x+UGaZG4xji6WfG/ODwIQwj9k
	rh1EpXkk20Hg2A8eCjQ8pgFiWjoqVi6tyNccLj7JG+HBqjcPXP9Eay1akU6Ptj/2
	ArHCeB8QukOTqT/BdDDQ1KL0u0GB4+/4fGgM/ZKRrUBej2tj0Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvjx88dn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 23:55:28 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40QNtRhM031159
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 23:55:28 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 26 Jan 2024 15:55:11 -0800
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
Subject: [PATCH 29/46] xtensa: resrved_mem: Move fdt_init_reserved_mem() below unflatten_device_tree()
Date: Fri, 26 Jan 2024 15:54:08 -0800
Message-ID: <20240126235425.12233-30-quic_obabatun@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 9v-ytk88Is-UUgQjGm6F456kfs80pTZy
X-Proofpoint-GUID: 9v-ytk88Is-UUgQjGm6F456kfs80pTZy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 mlxlogscore=820 lowpriorityscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401260176

The unflattened devicetree structure is available to be used not long
after the page tables have been set up on most architectures, and is
available even before that on other architectures.

Hence, move the call to fdt_init_reserved_mem() to after
unflatten_device_tree() is called so that the reserved memory nodes can
be accessed using the unflattened device tree APIs.

Using the unflattened devicetree APIs is more efficient than using the
flattened devicetree APIs.

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 arch/xtensa/kernel/setup.c | 2 ++
 arch/xtensa/mm/init.c      | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
index bdec4a773af0..cb2fb993de76 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -25,6 +25,7 @@
 #include <linux/cpu.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
+#include <linux/of_reserved_mem.h>
 
 #if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_DUMMY_CONSOLE)
 # include <linux/console.h>
@@ -357,6 +358,7 @@ void __init setup_arch(char **cmdline_p)
 	kasan_init();
 	unflatten_and_copy_device_tree();
 
+	fdt_init_reserved_mem();
 #ifdef CONFIG_SMP
 	smp_init_cpus();
 #endif
diff --git a/arch/xtensa/mm/init.c b/arch/xtensa/mm/init.c
index ed3dd5f67b4a..e205a89a2097 100644
--- a/arch/xtensa/mm/init.c
+++ b/arch/xtensa/mm/init.c
@@ -26,7 +26,6 @@
 #include <linux/nodemask.h>
 #include <linux/mm.h>
 #include <linux/of_fdt.h>
-#include <linux/of_reserved_mem.h>
 #include <linux/dma-map-ops.h>
 
 #include <asm/bootparam.h>
@@ -49,7 +48,6 @@ void __init bootmem_init(void)
 	memblock_reserve(0, PHYS_OFFSET ? PHYS_OFFSET : 1);
 
 	early_fdt_scan_reserved_mem();
-	fdt_init_reserved_mem();
 
 	if (!memblock_phys_mem_size())
 		panic("No memory found!\n");
-- 
2.17.1


