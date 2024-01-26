Return-Path: <linux-kernel+bounces-40908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 133CF83E7C7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 446C31C2867D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DFD60EE5;
	Fri, 26 Jan 2024 23:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RmmbaUVy"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709E367738;
	Fri, 26 Jan 2024 23:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706313373; cv=none; b=Xyze42t5lQXY96lEFXfWm84cDuWRQ8V1/i8sG/1b08v5H2zU3o4R+KogmbnvdClerUShJa/IECn0JgW0V8Bis7Y1+C+04KRMeyM+JHO0KRQb4IVjQ8dwvvB7DB+V+UOwd+ROcdNhBe3ueDGZBk2ztwIXANkxqMdddrHJtHr3wdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706313373; c=relaxed/simple;
	bh=J6pPkakqNv2daF3IrtDrH+SZuJ5STbJAmAJQb9x5eQs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c0m4Pd2w22ZM3pp/ittvv50hTCBp6DvpRQtlQPUGdMRfeOwdP4qU9M9a348Ql++g7U6Z158u8xGNVYC8zkodq7ALnQaW6VOUCOOlXr+sjbplZljEJct7zJqJ1qOZ5DWPa2nCPR2915GbYs5bbtSj3ZcyKI29XsNUfIDT8Z/THbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RmmbaUVy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QNB7D6025095;
	Fri, 26 Jan 2024 23:55:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=T0h3z+K0rtV4faDRf1fw
	pDX6H/a9sME2F2MHueBtAkE=; b=RmmbaUVyx/q9+lpQdKFEpD7F9RBa31grZwM4
	a1vOIo5ZwdhfYOGAJ7VqIWhJTlugUNN/K+t1J3pqPDTgNToWpskXROE1XHkNSaKr
	xXozjbugETFrj743VUsC07jm7XmtddlX5jtPXwANWBV+22zCZvDeH6SgFirrRhan
	c6j4ksO2ci2aB82i2/yXaz4xpmHV1MIjSTtIbs7jtSxvT8i+HX/h2D908zon3BUv
	UC1h6s7BrRTeqQVjq5rQGSZf2IJoaV0uZzED/fjZZJh0Pv3Q1TU2MktVcbBxXx+S
	MvUcqOz+ST7vkCOK6E2pC7B6xpXNLgnOanGeJJC4H5FtMD2Klg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvfc8h025-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 23:55:32 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40QNtUwj018645
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 23:55:31 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 26 Jan 2024 15:55:16 -0800
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
Subject: [PATCH 41/46] powerpc: reserved_mem: Switch fdt_init_reserved_mem() to dt_init_reserved_mem()
Date: Fri, 26 Jan 2024 15:54:20 -0800
Message-ID: <20240126235425.12233-42-quic_obabatun@quicinc.com>
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
X-Proofpoint-GUID: DPuu-JorzJSPhOkMbk7tfX3FU2687aOJ
X-Proofpoint-ORIG-GUID: DPuu-JorzJSPhOkMbk7tfX3FU2687aOJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=661
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401260176

Switch from using fdt_init_reserved_mem() to dt_init_reserved_mem() to
reflect the use of the unflatten devicetree APIs to process the
reserved memory regions.

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 arch/powerpc/kernel/setup-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 96bd4c964943..fdb7cb8235d0 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -891,7 +891,7 @@ void __init setup_arch(char **cmdline_p)
 	/* Unflatten the device-tree passed by prom_init or kexec */
 	unflatten_device_tree();
 
-	fdt_init_reserved_mem();
+	dt_init_reserved_mem();
 
 	/*
 	 * Initialize cache line/block info from device-tree (on ppc64) or
-- 
2.17.1


