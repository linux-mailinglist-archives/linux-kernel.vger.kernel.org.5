Return-Path: <linux-kernel+bounces-455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAEA81415E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 06:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4EF7B22306
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 05:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F4D6AD9;
	Fri, 15 Dec 2023 05:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R2F2SG2a"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43531D266;
	Fri, 15 Dec 2023 05:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BF3lJnQ016521;
	Fri, 15 Dec 2023 05:38:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=lHZOFCL
	1XMoQlQectvGN5zz3xe/B+fTXqI7DHa4UZJk=; b=R2F2SG2aMQVwlziWh/P05E5
	HlwyTXQf10NbdjPDspS0T7Bao/tGPiks9Ve1IFP/cAciQ5E1EJZRZORQJoLr/SMv
	mLl6JqXs3wuH/NPf1zBOfZ5ZfrRTeSwLcQCKo0nlugd/6821qLAdN7QdaIoszlxA
	Vu32e94Th6Jhr87ffmO1VTb3Os3P6Q9ne/HX+ubMEO2fYJkS8GAgKmRnn5p5OGXS
	rtTSLs6f+NuslBN5MeORR9cxXd2jG6VxW1Tt+3EdOzUdFfL2xGxOx2wdh08QMtyf
	R8OHG6VwV7TRXlV3GkN1ArG5cBwFW7Cu3WhSaqv74AZRCmEmAT5AKT0vVypZPyA=
	=
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v0a37h05t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 05:38:08 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BF5c7WR018937
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 05:38:07 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 21:38:04 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v1 0/2] Add LDO5 MP5496 regulator
Date: Fri, 15 Dec 2023 11:07:02 +0530
Message-ID: <cover.1702618483.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UrMv3_maKsm-_WwdHQaTCaE89Y4obiAI
X-Proofpoint-ORIG-GUID: UrMv3_maKsm-_WwdHQaTCaE89Y4obiAI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=231 adultscore=0 spamscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312150033

Splitting the earlier patchset https://lore.kernel.org/linux-arm-msm/cover.1701160842.git.varada@hu-varada-blr.qualcomm.com/
and including the dt-bindings update (per https://lore.kernel.org/linux-arm-msm/e6f77480-749b-4ffb-93dd-764451e3f5fb@linaro.org/).
Had to split since the regulator driver change and the USB driver
change were dependent. If the USB driver change gets merged before
the regulator driver change it could break the kernel boot up.

The earlier patch ec4f047679d5, incorrectly used 'l2'
as the vdda-pll-supply. However, 'l5' is the correct
ldo that supplies power to the USB PHY.

Following checks passed:
make W=1 ARCH=arm64 -j 16 CHECK_DTBS=y DT_SCHEMA_FILES=qcom dtbs_check
make W=1 ARCH=arm64 -j 16 DT_CHECKER_FLAGS='-v -m' dt_binding_check DT_SCHEMA_FILES=qcom

Varadarajan Narayanan (2):
  regulator: qcom_smd: Add l2, l5 sub-node to mp5496 regulator
  regulator: qcom_smd: Add LDO5 MP5496 regulator

 .../devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml   | 2 +-
 drivers/regulator/qcom_smd-regulator.c                          | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.34.1


