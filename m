Return-Path: <linux-kernel+bounces-40877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E0B83E772
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B0BEB28027
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502AF6089A;
	Fri, 26 Jan 2024 23:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Tco1QsjL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6187B224CF;
	Fri, 26 Jan 2024 23:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706313358; cv=none; b=rxrhGZhxSd6DC6IBCNTs8cOj1X+rZ2gt2jqK9QXO1fXfy5Wu5rr9UxHx28kZHzfkY+MQRXaxpFZVjI5+YXer6OIb1h9ixbZVYa4F5nun+5OHgrBOUHErfgCVRDh/SPS6PnJEgbbieBIVt8U2ZwKW+32QXHst/GC+9h9hHPlNZ0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706313358; c=relaxed/simple;
	bh=dzyLzkh4N078yyTKCYTC/gXD1gm5QyH6T4MNhRf2r60=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JKR4ahfnB7WSHAxAUq+ycDJ56mz9xH5hB5lJ+MaFu90apQ70zTsHCI3/q4drCKkQIb7ARjTDeK6xdIYkZsV7L5HFz3XWSY5RNKL3wSkjgwkvP+E4lDKaQx//liu7ppPvgy6KxCntO0W6Rl0NP2RWCi+pZmohevAlCjTw7Dvnp0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Tco1QsjL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QNkFUP021405;
	Fri, 26 Jan 2024 23:55:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=68XaOo5mtlDufcCTXlMy
	lNztjt7G6G1w91QU9lahYmo=; b=Tco1QsjLrURRbbdF0B8BNcqmg3sjwJNyBOVI
	LmwLBhfz8EtNCKATOKAFJO/NOblaeF/VyhZUJdRA80i2Ls+Gk0G8zT7yuwN73R0+
	gbbJzjFni8D5YiHzQ976s5P+jSJTvuHlSo23Gk3ePJqL3iZYMRjPoWar1rows/Lt
	EE/9ffhNWIrWE7RVZp2OjS+cfi6kNo1YBKVvbeAS/7YL/fNUn5e7b598QWkNqY7/
	VQDTj2nsy2ex4hJM1KfgfzDegnnvUpz5sejqfURQBXMZeOQP1N6l2qz2Go9Bu4La
	YODDqvmo/hEFMQa/K/3My5GtTEwTr4G3OgaZ3vvlxLyOamvcmg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvhxyrhxs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 23:55:06 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40QNt5Kr010122
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 23:55:05 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 26 Jan 2024 15:55:00 -0800
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
Subject: [PATCH 10/46] nios2: reserved_mem: Implement the new processing order for reserved memory
Date: Fri, 26 Jan 2024 15:53:49 -0800
Message-ID: <20240126235425.12233-11-quic_obabatun@quicinc.com>
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
X-Proofpoint-GUID: _frN9e1ZnvTiTu7GT8d5gUZ0-Lm28G7a
X-Proofpoint-ORIG-GUID: _frN9e1ZnvTiTu7GT8d5gUZ0-Lm28G7a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 malwarescore=0 mlxscore=0 phishscore=0 adultscore=0 clxscore=1015
 mlxlogscore=639 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
early_fdt_scan_reserved_mem() because memblock allocated memory should
be already writable at this point.

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 arch/nios2/kernel/setup.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/nios2/kernel/setup.c b/arch/nios2/kernel/setup.c
index da122a5fa43b..c1d42861cc72 100644
--- a/arch/nios2/kernel/setup.c
+++ b/arch/nios2/kernel/setup.c
@@ -19,6 +19,7 @@
 #include <linux/memblock.h>
 #include <linux/initrd.h>
 #include <linux/of_fdt.h>
+#include <linux/of_reserved_mem.h>
 
 #include <asm/mmu_context.h>
 #include <asm/sections.h>
@@ -167,7 +168,8 @@ void __init setup_arch(char **cmdline_p)
 #endif /* CONFIG_BLK_DEV_INITRD */
 
 	early_init_fdt_reserve_self();
-	early_init_fdt_scan_reserved_mem();
+	early_fdt_scan_reserved_mem();
+	fdt_init_reserved_mem();
 
 	unflatten_and_copy_device_tree();
 
-- 
2.17.1


