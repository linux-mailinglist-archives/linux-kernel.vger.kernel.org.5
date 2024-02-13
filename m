Return-Path: <linux-kernel+bounces-63373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA898852E56
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9750D28481C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4703C2D630;
	Tue, 13 Feb 2024 10:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XUJZL74b"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF41286A6;
	Tue, 13 Feb 2024 10:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707821309; cv=none; b=F2tGSv15uW40/AqLtS/DL+2mB8I3RR3TdGofl5AqQB2+ZP2n86waYdrCscwjPZFDr1aWnPYLgO3AwL72Qi85LxKN82DSSpdU7yqC1qpHkRCOr9wUJQFjTHGXTrdz4hxS6P48e3uL4GPFgd0x2XcJGermOK1rvqdY3+PHGBrCIsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707821309; c=relaxed/simple;
	bh=93QZbUDo4UsCSyB35+rCx747R+ZoUCGM9o3/sa5XjHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=sqmXegnLS4bx86qp1DW7G1Z/K4H2wC1mDvDgXEcLG+QWtXEM2Mb002I7JDycHm8E/ilrgNpaiyOVezaY/9NKENFspzPW4CkRQO1F127LdoBg8pfnkcWSiVaGugvr77vAeeVr9c1jwF/hXBXm0aAwQ9pJb8x4AyQ/aimcabvOdAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XUJZL74b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41D6OqFP031953;
	Tue, 13 Feb 2024 10:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=mR7lHYrzNqC4I4TNuy942kIzy0bpJcfNrgataXtKbdI=; b=XU
	JZL74bJiMDeFIAb/z/k+rRLy/2VQh06Rdq7LdtBce0+LSVTNLKP+e0xdottN+Esn
	Lncct+0GvE6ZK8xwN7V8PPJDlJwSAuoxM2O2MjffjYP0PKEXhaNtgD9S/DNX1Slj
	w4EWE38DRkGzhJIKy9RXk+VkiFaVmNvj7tX7IUh+Vc2Hh4jH4QductgvPJr2c8J4
	uY5GdVM8bXR1sYoHNjbKHlR56gMQ4z9pGXIO1H7kBJjzQugaPYZW+gjyNuwaa6v1
	Gwf8IHFDUFf2hYJlNYJLOx2ozz/WZ1m+dLfRTu+4LKzxGqHn11fYskqVlraZU0Mv
	F3PfG8LhOv9jBKxTbrAA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7gse2qdk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 10:48:03 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 41DAlxwI032071;
	Tue, 13 Feb 2024 10:47:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3w627kvync-1;
	Tue, 13 Feb 2024 10:47:59 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41DAlx7a032056;
	Tue, 13 Feb 2024 10:47:59 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-riteshk-hyd.qualcomm.com [10.147.241.247])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 41DAlwVE032050;
	Tue, 13 Feb 2024 10:47:59 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2314801)
	id AFA29617D8D; Tue, 13 Feb 2024 16:17:57 +0530 (+0530)
From: Ritesh Kumar <quic_riteshk@quicinc.com>
To: andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, quic_bjorande@quicinc.com,
        geert+renesas@glider.be, arnd@arndb.de, neil.armstrong@linaro.org,
        dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
        m.szyprowski@samsung.com
Cc: Ritesh Kumar <quic_riteshk@quicinc.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, quic_abhinavk@quicinc.com,
        quic_rajeevny@quicinc.com, quic_vproddut@quicinc.com
Subject: [PATCH v2 1/2] arm64: defconfig: enable Novatek NT36672E DSI Panel driver
Date: Tue, 13 Feb 2024 16:17:53 +0530
Message-Id: <20240213104754.8195-2-quic_riteshk@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240213104754.8195-1-quic_riteshk@quicinc.com>
References: <20240213104754.8195-1-quic_riteshk@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5caxxVcL-RLTLHrW03AP0ej9NayjHHS1
X-Proofpoint-ORIG-GUID: 5caxxVcL-RLTLHrW03AP0ej9NayjHHS1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_05,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 spamscore=0 clxscore=1015 phishscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=743 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402130085
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Build the Novatek NT36672E DSI Panel driver as module
because it is used on Qualcomm qcm6490 idp board.

Signed-off-by: Ritesh Kumar <quic_riteshk@quicinc.com>

---
v2: Fixed review comment from Dmitry
      - updated commit text.
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f44b3abf3cef..9bd5bfe386fa 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -862,6 +862,7 @@ CONFIG_DRM_PANEL_SIMPLE=m
 CONFIG_DRM_PANEL_EDP=m
 CONFIG_DRM_PANEL_ILITEK_ILI9882T=m
 CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=m
+CONFIG_DRM_PANEL_NOVATEK_NT36672E=m
 CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
 CONFIG_DRM_PANEL_SITRONIX_ST7703=m
 CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
-- 
2.17.1


