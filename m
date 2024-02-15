Return-Path: <linux-kernel+bounces-66687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 203B7856045
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE3C4B37FB5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CBB13667A;
	Thu, 15 Feb 2024 10:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="p1zwR6i9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E5113173F;
	Thu, 15 Feb 2024 10:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993600; cv=none; b=J7kJCPaN0YBugHhPFTBRLu83S9YXlnj4l2lzxBf4PtuK4xjFAgJybF9Qw6jHLBCXHlinPL9jlM0pndShBGQpS1rKHZbPyXWPZJHPRSHZSUxB77mN6gJRyhcDUP2+LIH69z1WOm8+0HC5yeEDBPClG9Ydo9h0DDh/1Gc7XrAebfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993600; c=relaxed/simple;
	bh=3DRaxfRX0WV3VdMSyOsaAEEh1cKEYJFdFUbwZW6uKk8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=RgrRTsW58U2+GFeGg+3OLOzoqChEh0grxc8SppdQGaZakCDd3wq4C/lMExLp/fK9xl76OfdELPtwiZMMjXFDb+4bzjTvBtQqsqz8GbJuA0bNKz26XV00OcltbrGTPgxh7bSNTrIu21gR6ZfWoUWptvaNPRcKqzAwCHw2+c1hgIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=p1zwR6i9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41F7KNij007372;
	Thu, 15 Feb 2024 10:39:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=hHFw//1+BQxq
	kGcqXGiC1LeRSZmYFGoSjsSnWsluyxI=; b=p1zwR6i9D6H0tToMffAhgxkl9TQM
	VqB7jP8mOsT3HwuYb/opfpe6PdakTOlb2EzbbOU8Ap8ka53YD/V5Z5rOjp5E4lqE
	UgwmgP82sPqyF2CYt2vSazVzyTABtMEDX2ym4xW+mDYUunNxLVHmy9zRXSLLjFae
	VNY7CONXg10uc4dvKcxeklrFpV+LGb1e0OsQOAVJgJRlbD6YU86CBZiS0pxhiiwe
	OsByPZ7OnTCLFj1uH/fLSwOCX2wNfsjK25s5X6Fp78uBqAV2dFppxHLwCCEM8Lt1
	AZQTWEF5wB90cf+6WAoUYjZagxl7bs3r676+/098XcACY3vjJb2yVLVR1w==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9e4h0c46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 10:39:38 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 41FAdXVg013844;
	Thu, 15 Feb 2024 10:39:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3w627mab7d-1;
	Thu, 15 Feb 2024 10:39:33 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41FAdXrX013828;
	Thu, 15 Feb 2024 10:39:33 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-riteshk-hyd.qualcomm.com [10.147.241.247])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 41FAdXDW013824;
	Thu, 15 Feb 2024 10:39:33 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2314801)
	id DBCB860142D; Thu, 15 Feb 2024 16:09:31 +0530 (+0530)
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
Subject: [PATCH v3 0/2] add display and panel on qcm6490 idp
Date: Thu, 15 Feb 2024 16:09:27 +0530
Message-Id: <20240215103929.19357-1-quic_riteshk@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vsqQs8P2CNeXpdR6YUEChV7Oz-n1HAYM
X-Proofpoint-ORIG-GUID: vsqQs8P2CNeXpdR6YUEChV7Oz-n1HAYM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_10,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 impostorscore=0 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxlogscore=615
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402150084
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
v3: Fixed review comments from Dmitry
      - renamed panel supply to regulator-lcd-disp-bias.
      - moved backlight as per sort order.
---

Ritesh Kumar (2):
  arm64: defconfig: enable Novatek NT36672E DSI Panel driver
  arm64: dts: qcom: qcm6490-idp: add display and panel

 arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 92 ++++++++++++++++++++++++
 arch/arm64/configs/defconfig             |  1 +
 2 files changed, 93 insertions(+)

-- 
2.17.1


