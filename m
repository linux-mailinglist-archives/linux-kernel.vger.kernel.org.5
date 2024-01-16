Return-Path: <linux-kernel+bounces-27206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C3982EC2F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D65241F241C9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C137918AF0;
	Tue, 16 Jan 2024 09:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dw6Hht2u"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCF017599;
	Tue, 16 Jan 2024 09:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40G7wGle005409;
	Tue, 16 Jan 2024 09:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=Rq4fNMe7g9Bt
	EEZjkFMy3VQE+20Z3tr4nJBVwjyKBpw=; b=dw6Hht2ubOPdi4wJ8RDSO6GXX0P2
	eQvn0YYp0esJN2TOny2Ss8w+V/zzD4pLP4ZilDnJ9GZVlJxJvE/SNg9gFE0bBL4o
	1QemqgeM+wv+FP+eIyeA1RAkkdoKomwBchdjYQInozqGCQWwts/RqruaVmylv5TN
	MX9+V2mRAO18rXoM9O2JyaPKYo2bL58ZvDSvkd8YhBIlgevw16/DTRDSyeG2qQJ8
	rRTwLcphYaxlo2VCIdWaOLk5mjqT85N+08Lwiy0ST0hnLGCeCCO7FbnHVnBEr/9T
	fI2kMsNppCWyjVtwK1443vCcqU4j6a6V7ifcE2mUF2EQIZqMsUUio/sd4w==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vnnvbg6wd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 09:49:45 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 40G9nfsQ006268;
	Tue, 16 Jan 2024 09:49:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3vkkkkmget-1;
	Tue, 16 Jan 2024 09:49:41 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40G9nf67006248;
	Tue, 16 Jan 2024 09:49:41 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-riteshk-hyd.qualcomm.com [10.147.241.247])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 40G9neZN006245;
	Tue, 16 Jan 2024 09:49:41 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2314801)
	id A07605001D5; Tue, 16 Jan 2024 15:19:39 +0530 (+0530)
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
Subject: [PATCH 0/2] add display and panel on qcm6490 idp
Date: Tue, 16 Jan 2024 15:19:33 +0530
Message-Id: <20240116094935.9988-1-quic_riteshk@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HRrq2nv_P1V7tI2I_KG7GbIdw3N1wUt0
X-Proofpoint-ORIG-GUID: HRrq2nv_P1V7tI2I_KG7GbIdw3N1wUt0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 mlxlogscore=350 lowpriorityscore=0 mlxscore=0
 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1011 spamscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401160077
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
---

Ritesh Kumar (2):
  arm64: defconfig: enable Novatek NT36672E DSI Panel driver
  arm64: dts: qcom: qcm6490-idp: add display and panel

 arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 100 +++++++++++++++++++++++
 arch/arm64/configs/defconfig             |   1 +
 2 files changed, 101 insertions(+)

-- 
2.17.1


