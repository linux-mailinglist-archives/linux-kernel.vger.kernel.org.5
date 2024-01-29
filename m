Return-Path: <linux-kernel+bounces-42182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C1583FD94
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF112285DD1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 05:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48AD45976;
	Mon, 29 Jan 2024 05:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HuJDUIkF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1605DDD5;
	Mon, 29 Jan 2024 05:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706505155; cv=none; b=jG26JniszCtNBVFmGluekpaJcrJNtASF0RhsIJMyw2csBeKHQfaGkZpZsdYWmP9p1qUK9+OesxECxNAuchEGNDGg/wJP0ynk0i4AaILouKRfhtnYk64r7UNPE1n6n0ZudTciM94gJKOZ894W/aTJ426iHUliqJoxYe+izwGGaTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706505155; c=relaxed/simple;
	bh=Ikg5x3d/f+jULVMCH44rw4+PXLyN4ZWT9A0HMbatL0c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ufn6JVfoPMxgG9yYhMpEOPIhyIm5PTofSQY7m4a7r7ujqpXApDwNI8Uwck0/igBx72laG7GnHUc5zcdXxkpKWBZL49rX6YBkMByuaAaui4aWWNtvkcsd1WYadezDYPACSYU2eui1ePP5jFwvgjRvyRjLOEZQMMBtrXE0IiLs7II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HuJDUIkF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T4P1Ro020025;
	Mon, 29 Jan 2024 05:12:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=fzQb6bK072ThF6/59Q0ni+RYed6Os6bEI5ulHIPo1LA=; b=Hu
	JDUIkFPxVp6ue5kerX4vdEXJ4vE64aFUqK3FsGGQ9hS4jK5zYMlVy0wKLO5mP3w5
	AomfyCyRDDXBqGORMgdP4Z+xvCUoI0DAjo0VegBlDA4cRefpfjNtGxy+oTzEDsWj
	uiqu9b88mOifYURQB9qQPd3CeP7N3m8+GmSgdIZQGN/91UzS6uugd8eQ76KIl145
	9UhOcR+I7enD9rZGKL61pau22DOrGLmwpw2OuXQlQ+vfRqf4D6pniu+VrbCBjSqw
	MvawV7N3PE40L/AtkVabazoqiU6plJJ/kYxiJrBRHEhByHaB5OUmSZrDE65b9UY5
	2k10Es3pOSrQa4/B82ZQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvt272t9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 05:12:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40T5CDiI021540
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 05:12:13 GMT
Received: from hu-devipriy-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 28 Jan 2024 21:12:06 -0800
From: Devi Priya <quic_devipriy@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>, <p.zabel@pengutronix.de>,
        <richardcochran@gmail.com>, <geert+renesas@glider.be>, <arnd@arndb.de>,
        <neil.armstrong@linaro.org>, <nfraprado@collabora.com>,
        <m.szyprowski@samsung.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <quic_devipriy@quicinc.com>
Subject: [PATCH V3 7/7] arm64: defconfig: Build NSS Clock Controller driver for IPQ9574
Date: Mon, 29 Jan 2024 10:41:04 +0530
Message-ID: <20240129051104.1855487-8-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129051104.1855487-1-quic_devipriy@quicinc.com>
References: <20240129051104.1855487-1-quic_devipriy@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8euuNwnrCUEEcQYCFcC8QwIBwD6hIS8g
X-Proofpoint-ORIG-GUID: 8euuNwnrCUEEcQYCFcC8QwIBwD6hIS8g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_02,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=823
 clxscore=1015 spamscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401290035

NSSCC driver is needed to enable the ethernet interfaces and not
necessary for the bootup of the SoC, hence build it as a module.

Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 Changes in V3:
	- No change

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e6cf3e5d63c3..00e7f3112d53 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1255,6 +1255,7 @@ CONFIG_IPQ_GCC_5332=y
 CONFIG_IPQ_GCC_6018=y
 CONFIG_IPQ_GCC_8074=y
 CONFIG_IPQ_GCC_9574=y
+CONFIG_IPQ_NSSCC_9574=m
 CONFIG_MSM_GCC_8916=y
 CONFIG_MSM_MMCC_8994=m
 CONFIG_MSM_GCC_8994=y
-- 
2.34.1


