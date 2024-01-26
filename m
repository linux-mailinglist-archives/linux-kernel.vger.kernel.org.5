Return-Path: <linux-kernel+bounces-40915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA2083E7D8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C9F81F21B9F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5035581AB6;
	Fri, 26 Jan 2024 23:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iacufijZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D0B7CF2C;
	Fri, 26 Jan 2024 23:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706313381; cv=none; b=l4cY4EX3f/HXSBHBcAOAPQLjEQ2GvcsDVriF8wEFcT6eX9D2yBI42tfXS/DQ66jrPHhQE70dJlC8yMnl2WEArvnC+jegwPrKvWHAlX9mTgZIsaf2dDOX4R7vcX8QDxjmtCEpEGFwBTIu9K2sb3FMG7rgBZAP+5MZwzMOyfwSJY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706313381; c=relaxed/simple;
	bh=7lFV26PM2LNr4+1qOoEgiZTR9wLGkj9SedRT9qVyNgg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tVH+tKOXigRdmr5Zxfp4q3OFgpqbA7e0JLwR7GQJLGyQspWk9e4qN8jCxUmDp+5Nb9DwI74PcvfGagGuepT5vdvKjBEHS8TDwQA/CFIVvgd6NxXGQi+YUJw0Y+nGjiiuwWKh1anFD/+1KIgvieiQhPw/KXU/fUVVg5rFXitKl1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iacufijZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QNmXdJ023210;
	Fri, 26 Jan 2024 23:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=shZIVqJkSo6fGcUiuMy2
	RrxMhrTh4VJfidj0yenmhxo=; b=iacufijZSTVqNAHOqawI8GQa9ys6DIbEHhqM
	3EH/z5A8BLI5Y4mWDp8N+C43muOSfgu0Ip7f7cjx7KMZkZ8yD/fS7PiKEDBHv88+
	nziYnkQbWc1P+HFbyDIN+zbaIcp0ZwCPnTY71cLbccF5PGOB5pSMyrtODARzbMor
	ACO0paQeHoXKpZak/W0n82JKEbs1bJB8lXVz8UZ3JHHQtGCayM/PPF1pPWd2Car3
	XBdCJvqsv8vL70PM4jLqLeuZRFAAv42uK8gUYSihBqF6sIvoTuB0rj1zVc7LocCV
	jzPFyvWa29Jmu3YOQKVDXcKZMGhW2vTAb9u7txuvn23Prvag9Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvjbg8g0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 23:55:30 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40QNtTDH031191
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 23:55:30 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 26 Jan 2024 15:55:15 -0800
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
Subject: [PATCH 38/46] mips: reserved_mem: Switch fdt_init_reserved_mem() to dt_init_reserved_mem()
Date: Fri, 26 Jan 2024 15:54:17 -0800
Message-ID: <20240126235425.12233-39-quic_obabatun@quicinc.com>
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
X-Proofpoint-GUID: Q9e2HJHeUEGizgm_DG731AghkXl7Ufp7
X-Proofpoint-ORIG-GUID: Q9e2HJHeUEGizgm_DG731AghkXl7Ufp7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 mlxlogscore=693 phishscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401260176

Switch from using fdt_init_reserved_mem() to dt_init_reserved_mem() to
reflect the use of the unflatten devicetree APIs to process the
reserved memory regions.

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 arch/mips/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index eeafc3abcb96..8d2aaa96d3c3 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -671,7 +671,7 @@ static void __init arch_mem_init(char **cmdline_p)
 	mips_parse_crashkernel();
 	device_tree_init();
 
-	fdt_init_reserved_mem();
+	dt_init_reserved_mem();
 	/*
 	 * In order to reduce the possibility of kernel panic when failed to
 	 * get IO TLB memory under CONFIG_SWIOTLB, it is better to allocate
-- 
2.17.1


