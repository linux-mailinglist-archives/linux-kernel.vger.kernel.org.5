Return-Path: <linux-kernel+bounces-108249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F72880863
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F002C1F235BE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5C064C;
	Wed, 20 Mar 2024 00:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eBkPz22e"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459B918E;
	Wed, 20 Mar 2024 00:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710893163; cv=none; b=X/iwiR777lPPCbjKR8YEBft7wsYnj6zLmYHNDIYlgAwwBjLvbNMCj+YS5vFLTyzWDWg/ZjIF2Gk4fbO0cRBN7ymkeqtQbLv22ulS820UcSE6q/EVM1FHsyoEP4IfvUn9V7qG63/UUL0d3hdKsX28AwDBA1TMCGu9khvC99B17kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710893163; c=relaxed/simple;
	bh=jD14SSlcihd7H1ulYAUgfj0jcPE3SXwIMEfiqvF/DOA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=nufi6YhhkleuXiqeJEgLsG1uSMVq61DmSgullN1VmkYZbvjOxWi6aEGPLzLbojId+Nu0xCMBNpWc6pUq79F98Oy/8JPhr5cFYOFR9XS1YoKFIS8H0j4Hc+oYQj5McP36lZhufezZUbR/SEW31RhXuodXQ2oGszA+rqN6Ds1JYGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eBkPz22e; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42K00E7N015802;
	Wed, 20 Mar 2024 00:05:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=dAq
	aOTSXRNlp94sBryrgCs3OcYOIXxjtnBVhWqYUlOs=; b=eBkPz22e6AWeLaqS2hy
	kQyQPFXBzRmuvRwVWZgmmIoYdG6i0S+1rjprIzecjbyBe92Fu6Q5MoUDMnMTO5wN
	pxZYz1Y+OjXvAMdFaZIQS8nKWTLL9+WgvEYWz5k1q0hbJqkUpgfwrTJhpUHmgFg6
	XP5S5hWB4xQyPs8xpBGz3v4surGa0PtHXC5JXAsOgqx5EWoLwKfWu8EajxRNb3oI
	0LRdHziy7tN6ZRaHdTuaJD6a7ytSMj2rLQcOBjysUWyBkTZojB5kEJrnf0R3MCCj
	5QycIfIv/TvGME/8LMi6YlTkIxp38ue6dzwym/OEzkp+yWsWAkRqrQW7aArlfsWn
	7yQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wy7hy2270-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 00:05:56 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42K05ufu004964
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 00:05:56 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Mar
 2024 17:05:55 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Tue, 19 Mar 2024 17:05:55 -0700
Subject: [PATCH] MAINTAINER: Include linux-arm-msm for Qualcomm RTC patches
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240319-maintainer-msm-add-rtc-v1-1-3a4f7d41b4d4@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAGIo+mUC/x2MuwqAMAwAf0UyG2i1Pn9FHKqNmqFVUhFB/HeLw
 w033D0QSZgi9NkDQhdH3kMSnWcwbzashOySQ6EKo0rdobcczgQJ+ujROodyzlirqTFl63RFBlJ
 8CC18/+NhfN8PC1QokGgAAAA=
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        Bjorn Andersson
	<quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710893155; l=843;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=jD14SSlcihd7H1ulYAUgfj0jcPE3SXwIMEfiqvF/DOA=;
 b=anLqUUNHrYZm7sm7JcDGxkS008iejnoJVNnErJdSfQJ2vCvDZlePxrykNGQNgcbiCcjUAVhoo
 gjXyc7MjCGqBb90uei0og0jW4n8Ycup+a74Q73LgJsQnykoj1n7uQLC
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gU29Rm8geqNYXDVgaxXZzVd5rUXScDCa
X-Proofpoint-GUID: gU29Rm8geqNYXDVgaxXZzVd5rUXScDCa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=873 priorityscore=1501
 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403190187

Add Qualcomm RTC driver to the linux-arm-msm list, to ensure that
members of the Qualcomm community gets Cc'ed, to assist with reviews
etc.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 82896c3e0559..933290aad4c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2617,6 +2617,7 @@ F:	drivers/pci/controller/dwc/pcie-qcom.c
 F:	drivers/phy/qualcomm/
 F:	drivers/power/*/msm*
 F:	drivers/reset/reset-qcom-*
+F:	drivers/rtc/rtc-pm8xxx.c
 F:	drivers/spi/spi-geni-qcom.c
 F:	drivers/spi/spi-qcom-qspi.c
 F:	drivers/spi/spi-qup.c

---
base-commit: 226d3c72fcde130a99d760895ebdd20e78e02cb5
change-id: 20240319-maintainer-msm-add-rtc-60b7438d15e4

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>


