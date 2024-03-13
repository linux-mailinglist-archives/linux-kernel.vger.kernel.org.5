Return-Path: <linux-kernel+bounces-101161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A40B87A347
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D4FA1F22007
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 07:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699E71756F;
	Wed, 13 Mar 2024 07:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gIUJBfji"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449D814A8C;
	Wed, 13 Mar 2024 07:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710313979; cv=none; b=nFRBeSpkUyESWR4b4ChFzwM0/kiEbwfD+aJ/SvOlR+rJtbFdgNNAiDLIeN8OrKG0MLqrxBAQdPEdP1Zj60zhczpOYnnowPF0saiOPSSoCgk1TC+Z7Q/0Q2yr/rXEZjiznIRzBLDQSLtjIuBcHWaM4XlL7OM09m1gnqND5ifXxm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710313979; c=relaxed/simple;
	bh=oShe8btTfkGarb8alIU3sHKX1/SNy2xiqRU8KUvNtlY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jI8WgbAJ2MuQBDmHvLrqPwIz+YEXUdW/9gmw5w+NGjEgR68Gk848rvbrtztCAVr66tgrs7VygHScPvw20Od7iLBM49h+mgKXYNxRjLl7DTZEMPwfI+/CBvgzb+Pp/2XbYMN3DIWHgmoDknTDfFCmQQwoYzS8TyJ0LbnhxFN2uco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gIUJBfji; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42D6DBli013186;
	Wed, 13 Mar 2024 07:12:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=qcppdkim1; bh=S/vGuzgzFEQW92LuIB4q
	e62iy3ALlUdy+4YMMiio5Cg=; b=gIUJBfjiAUP1Ax/pUE3r0VucePzxy8IHWPki
	kFttcNLM4B4gSxzaLIdadNk1GgNVPzI3i3ia6TjcvTIDEyejf4+degfUwK9vsevn
	Vpkq0Th44su60v8LBgRw2rAkT0pFRARORhs5d3WNFs/c30NBK+WpEhqbDo/cB16X
	tlVKMky8O5dZT3OozWWUfGbyCiBYMDhpRfhwLSIywld6DaRAJ2o3n86Na/mAezwZ
	RPcKLCr00RD6GLhFup6GXCzkXkeQxPZNFc4a65Ds5hcatpSGbM9UwyiOfO1/LIJ9
	JOrxFr2T0JpDxa5S7SOt/SswJ/7TqfLsZiU83A1SA7ADBWFlLQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wu07c8rrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 07:12:53 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 42D7Couk021194;
	Wed, 13 Mar 2024 07:12:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3wrgum5nrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 13 Mar 2024 07:12:50 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42D7CoPY021170;
	Wed, 13 Mar 2024 07:12:50 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-wasimn-hyd.qualcomm.com [10.147.242.220])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 42D7CnPm021165;
	Wed, 13 Mar 2024 07:12:50 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 3944840)
	id B3C22500969; Wed, 13 Mar 2024 12:42:48 +0530 (+0530)
From: Wasim Nazir <quic_wasimn@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@quicinc.com,
        Wasim Nazir <quic_wasimn@quicinc.com>
Subject: [PATCH v3 0/3] arm64: qcom: add support for QCS8550 RB5gen2 board
Date: Wed, 13 Mar 2024 12:42:35 +0530
Message-ID: <20240313071238.3290-1-quic_wasimn@quicinc.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GhuIpg2lHgeGsOS20g8yMoizvCOA_466
X-Proofpoint-GUID: GhuIpg2lHgeGsOS20g8yMoizvCOA_466
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_06,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 mlxlogscore=746
 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403130053

RB5gen2 is Thundercomm's development platform used for IOT solutions.
It is based on Rb5gen2-SOM which is using QCOM's QCS8550 SoC.

On-board components:
- Qualcomm QCS8550 SoC
- LPDDR5, 12 GiB
- UFS3.1, 128 GiB
- USB3.1

On-board PMICs:
- PM8550VS
- PM8550VE
- PM8550
- PM8550BH
- PMK8550
- PMR735D
- PM8010

v2 -> v3:
 - Move qcs8550-rb5gen2 info after sm8550 boards in qcom.yaml
 - Link to v2 [3].

v1 -> v2:
 - Update board name from qcs8550-rb5gen2-hdk to qcs8550-rb5gen2.
 - Update SOM name to qcs8550-rb5gen2-som.
 - Remove qcm8550 from board definition.
 - Update DT files wrt board/som name changes.
 - Link to v1 [2].

This series depends on [1].

[1]: https://lore.kernel.org/all/20240308070432.28195-1-quic_tengfan@quicinc.com/
[2]: https://lore.kernel.org/all/20240202133638.4720-1-quic_wasimn@quicinc.com/
[3]: https://lore.kernel.org/all/20240304055333.15952-1-quic_wasimn@quicinc.com/

Wasim Nazir (3):
  dt-bindings: arm: qcom: Document rb5gen2 board
  arm64: dts: qcom: Add initial support for rb5gen2 SOM
  arm64: dts: qcom: Add initial support for rb5gen2 board

 .../devicetree/bindings/arm/qcom.yaml         |   7 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/qcs8550-rb5gen2-som.dtsi    | 438 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/qcs8550-rb5gen2.dts  | 136 ++++++
 4 files changed, 582 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/qcs8550-rb5gen2-som.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/qcs8550-rb5gen2.dts

--
2.43.2


