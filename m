Return-Path: <linux-kernel+bounces-40910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1652A83E7CB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6C4628D4D3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F43E60DE1;
	Fri, 26 Jan 2024 23:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lywtgH4w"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE6967E79;
	Fri, 26 Jan 2024 23:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706313374; cv=none; b=EckVpCGuIEZ22nMdNVeWJpg2jTZiaL6KCX/z6iZVtKwzIYd/7L2Fp4BJ0fqs1wogf3OSeBVMmfBBAkr453rXHs8yf3peG3+iyutXGwefaPKusJ3jgIuUjLM6MpEEVxuK7MskPXyZg2MbJ8WEuUQYnnQTz+l0qCI/eJGcT9tz7l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706313374; c=relaxed/simple;
	bh=qAJ+51cbXvvCfLjg82KIFwc+7aRBvLZGpb7bO+kBVSk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lYFJ5hlSkOF0MOJa6zZeFdIEwyY5DCvt1iFG2l8oZ4oXVPclxiaCRQBUGy+3bP+ODRfglOEBrMxMOlRh/2AOSNhimrRIlTu3PVtQk3ypP8eOd67qnp2WKo5nZjJfSjjs0m7Y4TWRtOpfj9Ql4ZZZ2FitZcIUhoAJ9qcRSJsxTvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lywtgH4w; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QLidNf001840;
	Fri, 26 Jan 2024 23:55:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=JehfiXL/jESvck/dHwB/
	tjacBNHINenDJXJssZftYA0=; b=lywtgH4wOf75UMzKTOMrxUO+QQzBiVuwolYi
	4+3YY51x+Vuq9uVMWrFDeAFOgYM74dj1aDZHBX5IBmUshUpNwDMnRjq/u/yueF38
	JnBOd4pRUen/fT+EKprd54SeS0Ekj3+5wReNqHikR3Gm0O1MKUN1SbFY33yBx+E3
	mdIEJSuNc3BK12d1R5hE8wf/4W/LsFncrddpZNP9jgXxsF+t1QjJA7chRVbGWrEJ
	jZ/57DEy0G6Hv2+mN6h+ICl3dn/3FaTPsu6kUFAEmkPuFaG32QTvk8Y9PZWpfLBX
	aujNRaEOavRQ0HqyD+TKReQ51Mj2/YUS3HD7+trSOKnUxHOcaA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvgy8gq04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 23:55:32 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40QNtUwn018645
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 23:55:31 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 26 Jan 2024 15:55:17 -0800
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
Subject: [PATCH 42/46] riscv: reserved_mem: Switch fdt_init_reserved_mem() to dt_init_reserved_mem()
Date: Fri, 26 Jan 2024 15:54:21 -0800
Message-ID: <20240126235425.12233-43-quic_obabatun@quicinc.com>
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
X-Proofpoint-GUID: 7nA_V3mCURdgAzpTsaoIGUM62pOvtIbp
X-Proofpoint-ORIG-GUID: 7nA_V3mCURdgAzpTsaoIGUM62pOvtIbp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=605
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401260176

Switch from using fdt_init_reserved_mem() to dt_init_reserved_mem() to
reflect the use of the unflatten devicetree APIs to process the
reserved memory regions.

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 arch/riscv/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 0601ed1e4ce6..3abc41217ede 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -271,7 +271,7 @@ void __init setup_arch(char **cmdline_p)
 	unflatten_device_tree();
 #endif
 
-	fdt_init_reserved_mem();
+	dt_init_reserved_mem();
 	misc_mem_init();
 
 	init_resources();
-- 
2.17.1


