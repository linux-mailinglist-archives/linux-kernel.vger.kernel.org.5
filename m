Return-Path: <linux-kernel+bounces-40896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A48383E7AF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3DD1C28D3F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223C465BCD;
	Fri, 26 Jan 2024 23:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GjgSbFTT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E60060B8F;
	Fri, 26 Jan 2024 23:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706313367; cv=none; b=EzVGIbfj0qC7FSXnnxN0ngLuuS9zBiGQ5sDywTxUwpOOdkT2ZU3rBA/BYRbbIW2xhdjG/GUfyYWRVY78VuzyOWDWmV2PKh5BwmWo3s6BBrFNUN+akaJ6qsMgxYWWwXfZKuAXxGQwZj7p3N3O1k5oE243+sTDn0GW3xx9N9+sPkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706313367; c=relaxed/simple;
	bh=oVNU15qC16YaS2uCRkKXpDWVLLgd3P0pIWqagmXdBMM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rCX7L3a43ewAlfN6VRhJtjbRn41i90ebDo8eOZYmTKW/Bu/xKCZsgoVFW0K6fYRjedoz5P++SD/nATjY0ck0oZK61Cava7dMJYc12KvBcbxh6PlAGanejNz8RXv5f5QzwRo/RnSF0mpCttaryt6Rkj/esnn1mL0RXxCr3rZdwyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GjgSbFTT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QNt5TQ028752;
	Fri, 26 Jan 2024 23:55:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=T3DjNUlLclRRSxUX+FF8
	745CWeIU93BibdyqAGILJoQ=; b=GjgSbFTTGQ/HN0iWI3cgW+MBA6dak3/88u13
	5ptkFzVdILA/nC4Q1LNv7vIkqlYYCgfZmmNDEUcUIp6Rc+XqK9eNZRo7C0xamKA3
	RwQY8aPOWTjF50p1EX2VKzhG3jVnJ9T7O0NUXuoFe98JXEb2SN7Nt8/4+SbCFoH2
	qR+1BY1cFoJ/VQOsouN73kpqpsniqsajlpcE5nyot4PWGNTIu9zSzYm5IOHObeSs
	E7G/2DuX/qWHYxmr8xRoM1j2/T7XPBZpWXc6sh6NCoofSiqf6iGx5M+JPURH/S7B
	syg3rbo67kG/52xFHHZp41WI5/XbIjWO7hXprQQiETO1V36u7w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vv8e89uxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 23:55:05 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40QNt43S011314
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 23:55:04 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 26 Jan 2024 15:54:59 -0800
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
Subject: [PATCH 07/46] Loongarch: reserved_mem: Implement the new processing order for reserved memory
Date: Fri, 26 Jan 2024 15:53:46 -0800
Message-ID: <20240126235425.12233-8-quic_obabatun@quicinc.com>
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
X-Proofpoint-GUID: 464t_X2bvbRs9OhyGDQ_riVstaAZ3xkC
X-Proofpoint-ORIG-GUID: 464t_X2bvbRs9OhyGDQ_riVstaAZ3xkC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=632
 impostorscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401260176

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
early_fdt_scan_reserved_mem() since memblock allocated memory should
already be writable at this point.

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 arch/loongarch/kernel/setup.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index edf2bba80130..72b164d3ace0 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -30,6 +30,7 @@
 #include <linux/dma-map-ops.h>
 #include <linux/libfdt.h>
 #include <linux/of_fdt.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/of_address.h>
 #include <linux/suspend.h>
 #include <linux/swiotlb.h>
@@ -390,8 +391,9 @@ static void __init arch_mem_init(char **cmdline_p)
 
 	check_kernel_sections_mem();
 
-	early_init_fdt_scan_reserved_mem();
+	early_fdt_scan_reserved_mem();
 
+	fdt_init_reserved_mem();
 	/*
 	 * In order to reduce the possibility of kernel panic when failed to
 	 * get IO TLB memory under CONFIG_SWIOTLB, it is better to allocate
-- 
2.17.1


