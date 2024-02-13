Return-Path: <linux-kernel+bounces-63372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6C2852E54
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11E081F25AFC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB382BB11;
	Tue, 13 Feb 2024 10:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LsK3/ixU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE7A2868D;
	Tue, 13 Feb 2024 10:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707821309; cv=none; b=SkC+KxSwkkE0gra8J19zrHRz4Ya9S+PYlTKaTekMq8KnMxDqX4n3b32boZRuamB+TlIECXKLf8xwPQOKGvgXdj/KWGiXgV9NNjCV17DK1sLNnKk6Mf7+gJ8kd59HOm18+WJl1GPcEh8Mf2p1ZtRF7fpPssS3QctBhLUXtZt6zWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707821309; c=relaxed/simple;
	bh=Iq0vv4d5wPhMKXpBp//amYgMlfPnZOjceKGn8fy63Fc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=GL7CQuHTg0990dc9IUbLG46ql7skweWiNKORyGKLBRJa8oYERwE0l6Iwe2kc5e9QT9VLesWDUm4oFiRGw2Kw+VN0HJkhxGeL2/CPV5VOI3HxQCV2VjsvmBiE8/kqFkRVi/pjTr8jLLHIw8hjk1xw++7a0cMf0D10Lr2tqB2eyZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LsK3/ixU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41DA9oQN022408;
	Tue, 13 Feb 2024 10:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=tF/Cst9kOePY
	crBa4SXSb3ERATMp8+lI4sdKl2P5TkU=; b=LsK3/ixUzRTqiv6KNoxiQGPbStmT
	H6KCetBUpHpG/PHkPQFB9vq2xlbU181a9HH/j5nDHidXw90PLAP1LcCRFOUoK8xe
	zvImqQqTwG2pum/kXbMR8Cd+7xeswSPqibI0EYYDSDRq5TsjivD+8KCw5ik0q+w4
	ZlOBB+aG/Jb+Rpt28d4HmE3Sk451yB1QIj64RgisuNbg49akgpbKaBXAHxCex9TN
	6HbvGmx4RHmxBWr1arCPBEU2ErNvrvdVsZVq7+Zcm/DbZx7yZTwmq6aM6Q05dK52
	IKry9hoMOnEnEA7BwExvVgYwgo+R26DW71IvgUfHyM6G6uLK/QLEC0WWag==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7hewangy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 10:48:03 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 41DAlxst032073;
	Tue, 13 Feb 2024 10:47:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3w627kvynd-1;
	Tue, 13 Feb 2024 10:47:59 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41DAlxCF032057;
	Tue, 13 Feb 2024 10:47:59 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-riteshk-hyd.qualcomm.com [10.147.241.247])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 41DAlwNQ032051;
	Tue, 13 Feb 2024 10:47:59 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2314801)
	id AD5B5617D8C; Tue, 13 Feb 2024 16:17:57 +0530 (+0530)
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
Subject: [PATCH v2 0/2] add display and panel on qcm6490 idp
Date: Tue, 13 Feb 2024 16:17:52 +0530
Message-Id: <20240213104754.8195-1-quic_riteshk@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9g8iHSKKd_gfDzI9y8EvBCqpDtbWpw5X
X-Proofpoint-ORIG-GUID: 9g8iHSKKd_gfDzI9y8EvBCqpDtbWpw5X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_05,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1015 mlxlogscore=360 priorityscore=1501
 malwarescore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402130085
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Build the Novatek NT36672E DSI Panel driver as module and enable
display subsystem on Qualcomm qcm6490 idp board.

---
This series depends on following series:
1. https://lore.kernel.org/all/20231222073135.2512313-1-quic_uchheda@quicinc.com/
   (arm64: dts: qcom: qcm6490-idp: Add support for PM7250B PMIC)
2. https://lore.kernel.org/all/20240108095902.22725-1-quic_riteshk@quicinc.com/
   (Add support for Novatek NT36672E LCD DSI panel)
3. https://lore.kernel.org/all/20240116071803.5264-1-quic_riteshk@quicinc.com/t/#u
   (drm/panel: novatek-nt36672e: Include <linux/of.h>)

v2: Fixed review comments from Dmitry and Konrad
      - moved pinctrl-names after pinctrl-0 property.
      - removed gpu disablement change after validating gpu.
      - updated commit text.
    Rebased the patch
      - rebased the patch to resolve conflicts.
---

Ritesh Kumar (2):
  arm64: defconfig: enable Novatek NT36672E DSI Panel driver
  arm64: dts: qcom: qcm6490-idp: add display and panel

 arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 92 ++++++++++++++++++++++++
 arch/arm64/configs/defconfig             |  1 +
 2 files changed, 93 insertions(+)

-- 
2.17.1


