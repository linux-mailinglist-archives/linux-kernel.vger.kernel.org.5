Return-Path: <linux-kernel+bounces-66684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9DC856031
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52AEB1C2247E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E622135A7F;
	Thu, 15 Feb 2024 10:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fd7E7WJk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E0D13173E;
	Thu, 15 Feb 2024 10:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993599; cv=none; b=IXLrF7xFuC00GYfyD1WQ52/UmU9P1Lo//gPkEJn8cIgdbn3n4EdGLwmGfW9mpNswTMjQ8HWTaR01AsIL7P7zwDdJI2rD8oSq4S2hhuPYOkxhsFr+slTuM42WE60NPLJv6ml/tRQz7EEg2zWNUJcRNbtWMbhE0b0qM+aTbmRUiB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993599; c=relaxed/simple;
	bh=t8bXMatBYlUJy5S0mx0nbqiMsa4qyC+vDky2PSwN7Wg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=XIXbKTKMisLm2Qf6CFePOUgK+FMPc8sjQVT6isWU8uNXxpLc4bzrLKth2v+wijNvEpvn02PpcCmxHagZbdhRKiZ5Vvk3stFMX4SxTVWRv1o+pVCf7w+5kNsiK0fssBtk1FHR+zYFqqwkK+vy6/N+FkCNAW9sseMmZ7sni/I3ySk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fd7E7WJk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41F7KtDO008705;
	Thu, 15 Feb 2024 10:39:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=fDL6ctTBT49t7F89xPo7fsaVbpPTPfKQcC8flQfsg6U=; b=fd
	7E7WJkkpsfopCda1Rk6qssr4aFABGM21stJbuzH8US0Ry1Xz+bsd8UYNojk0l6sL
	fMFZE7ZrUr7dW4M/5jR7vjRgZVWu2qVkSitv1haehP5kxAINEVnPlb8R1ZCLnAd6
	6dy4ZePNBxDfxjHpgwQg8wmcT72DgqP+fX6qg6JsjKOl5BK09DAENQtLiJrbnQfE
	Y3iLDOm+iBfQhMGy0nD+gfKxDA2HeEYzYwHJxhOAKGfVBqamPPFXyGfQNLk+d0gl
	XIgH9vVAnNvffeQprxC6kvLQRxaCEuYmA0Dto+cKGPOeNPnQhb+i8BgkoKla5sD3
	x2XtKS7SRGJIsEaM1XrQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9e4h0c45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 10:39:38 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 41FAdXKo013845;
	Thu, 15 Feb 2024 10:39:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3w627mab7c-1;
	Thu, 15 Feb 2024 10:39:33 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41FAdXhN013829;
	Thu, 15 Feb 2024 10:39:33 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-riteshk-hyd.qualcomm.com [10.147.241.247])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 41FAdXsX013825;
	Thu, 15 Feb 2024 10:39:33 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2314801)
	id DD6EB601430; Thu, 15 Feb 2024 16:09:31 +0530 (+0530)
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
Subject: [PATCH v3 1/2] arm64: defconfig: enable Novatek NT36672E DSI Panel driver
Date: Thu, 15 Feb 2024 16:09:28 +0530
Message-Id: <20240215103929.19357-2-quic_riteshk@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240215103929.19357-1-quic_riteshk@quicinc.com>
References: <20240215103929.19357-1-quic_riteshk@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zMKGOwMQv_HZRi58NyaWg-VZiQWTRGjI
X-Proofpoint-ORIG-GUID: zMKGOwMQv_HZRi58NyaWg-VZiQWTRGjI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_10,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 impostorscore=0 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxlogscore=766
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402150084
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Build the Novatek NT36672E DSI Panel driver as module
because it is used on Qualcomm qcm6490 idp board.

Signed-off-by: Ritesh Kumar <quic_riteshk@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

---
v2: Fixed review comment from Dmitry
      - updated commit text.
v3: No change
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b8adb28185ad..e1f0045a65de 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -863,6 +863,7 @@ CONFIG_DRM_PANEL_SIMPLE=m
 CONFIG_DRM_PANEL_EDP=m
 CONFIG_DRM_PANEL_ILITEK_ILI9882T=m
 CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=m
+CONFIG_DRM_PANEL_NOVATEK_NT36672E=m
 CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
 CONFIG_DRM_PANEL_SITRONIX_ST7703=m
 CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
-- 
2.17.1


