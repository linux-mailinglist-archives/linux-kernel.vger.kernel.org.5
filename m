Return-Path: <linux-kernel+bounces-13754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0988820C17
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 18:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37E57B21538
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 17:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074CE8F6F;
	Sun, 31 Dec 2023 17:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O7/eeO/1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19828F49;
	Sun, 31 Dec 2023 17:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BVGxaBV031759;
	Sun, 31 Dec 2023 17:13:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=3o727j2
	CmpWTJWaazrQ8DTM+khCuXjkt6WTrm0HG8zk=; b=O7/eeO/1rjM51qz2+V3JKTn
	Bz1PxXsW0puUKuzXXQnTOdvi/1SPJ7L37dmJSzwqQdvPA+o+ReJmlDCwm05zlvkx
	zEPI77uqKOl1w/nalRZu1mxPpOZGD568klgmEezeeQQMCeBpXPu8vnSGGdi3+qNo
	zEBbDPB9gVIyVaqIYU/p7NLNlfICW4qSDkLzDs1MnYk9i1z4y7qitfazGEkxPYvP
	Ffm0wtxg/c1KuiM+BLxgOw88cjmD8YTCjGhHIihdFkhw2nonFvwCJyyk8uE/x338
	SkIPzsRWg/6I0Gs8nO/Zys449GasgXv7LW9alKICwWK/0xqyuXLolJe7B/P0VUA=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3va8js275q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 Dec 2023 17:13:06 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BVHD5Ni015556
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 Dec 2023 17:13:05 GMT
Received: from hu-jprakash-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 31 Dec 2023 09:12:53 -0800
From: Jishnu Prakash <quic_jprakash@quicinc.com>
To: <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <lee@kernel.org>,
        <andriy.shevchenko@linux.intel.com>, <daniel.lezcano@linaro.org>,
        <dmitry.baryshkov@linaro.org>
CC: <quic_jprakash@quicinc.com>, <lars@metafoo.de>, <luca@z3ntu.xyz>,
        <marijn.suijten@somainline.org>, <agross@kernel.org>,
        <sboyd@kernel.org>, <rafael@kernel.org>, <rui.zhang@intel.com>,
        <lukasz.luba@arm.com>, <linus.walleij@linaro.org>,
        <quic_subbaram@quicinc.com>, <quic_collinsd@quicinc.com>,
        <quic_amelende@quicinc.com>, <quic_kamalw@quicinc.com>,
        <kernel@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-arm-msm-owner@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <cros-qcom-dts-watchers@chromium.org>
Subject: [PATCH v3 0/3] iio: adc: Add support for QCOM SPMI PMIC5 Gen3 ADC
Date: Sun, 31 Dec 2023 22:42:34 +0530
Message-ID: <20231231171237.3322376-1-quic_jprakash@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: E0tpdmncC4nqJKaUgF4AC7PX4LcfbsY8
X-Proofpoint-ORIG-GUID: E0tpdmncC4nqJKaUgF4AC7PX4LcfbsY8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 mlxlogscore=871
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312310141

PMIC5 Gen3 has a similar ADC architecture to that on PMIC5 Gen2,
with all SW communication to ADC going through PMK8550 which
communicates with other PMICs through PBS. The major difference is
that the register interface used here is that of an SDAM present on
PMK8550, rather than a dedicated ADC peripheral. There may be more than one
SDAM used for ADC5 Gen3. Each ADC SDAM has eight channels, each of which may
be used for either immediate reads (same functionality as previous PMIC5 and
PMIC5 Gen2 ADC peripherals) or recurring measurements (same as PMIC5 and PMIC5
Gen2 ADC_TM functionality). In this case, we have VADC and ADC_TM functionality
combined into the same driver.

Patch 1 is a cleanup, to move the QCOM ADC dt-bindings files from
dt-bindings/iio to dt-bindings/iio/adc folder, as they are
specifically for ADC devices. It also fixes all compilation errors
with this change in driver and devicetree files and similar errors
in documentation for dtbinding check.

Patch 2 adds bindings for ADC5 Gen3 peripheral.

Patch 3 adds driver support for ADC5 Gen3.

Changes since v2:
- Reordered patches to keep cleanup change for ADC files first.
- Moved ADC5 Gen3 documentation into a separate file

Changes since v1:
- Dropped patches 1-5 for changing 'ADC7' peripheral name to 'ADC5 Gen2'.
- Addressed reviewer comments for binding and driver patches for ADC5 Gen3.
- Combined patches 8-11 into a single patch as requested by reviewers to make
  the change clearer and made all fixes required in same patch.

Jishnu Prakash (3):
  dt-bindings: iio/adc: Move QCOM ADC bindings to iio/adc folder
  dt-bindings: iio: adc: Add support for QCOM PMIC5 Gen3 ADC
  iio: adc: Add support for QCOM PMIC5 Gen3 ADC

 .../bindings/iio/adc/qcom,spmi-adc5-gen3.yaml |  212 +++
 .../bindings/iio/adc/qcom,spmi-vadc.yaml      |    4 +-
 .../bindings/mfd/qcom,spmi-pmic.yaml          |    2 +-
 .../bindings/thermal/qcom-spmi-adc-tm-hc.yaml |    2 +-
 .../bindings/thermal/qcom-spmi-adc-tm5.yaml   |    6 +-
 arch/arm64/boot/dts/qcom/pm2250.dtsi          |    2 +-
 arch/arm64/boot/dts/qcom/pm6125.dtsi          |    2 +-
 arch/arm64/boot/dts/qcom/pm6150.dtsi          |    2 +-
 arch/arm64/boot/dts/qcom/pm6150l.dtsi         |    2 +-
 arch/arm64/boot/dts/qcom/pm660.dtsi           |    2 +-
 arch/arm64/boot/dts/qcom/pm660l.dtsi          |    2 +-
 arch/arm64/boot/dts/qcom/pm7250b.dtsi         |    2 +-
 arch/arm64/boot/dts/qcom/pm8150.dtsi          |    2 +-
 arch/arm64/boot/dts/qcom/pm8150b.dtsi         |    2 +-
 arch/arm64/boot/dts/qcom/pm8150l.dtsi         |    2 +-
 arch/arm64/boot/dts/qcom/pm8916.dtsi          |    2 +-
 arch/arm64/boot/dts/qcom/pm8950.dtsi          |    2 +-
 arch/arm64/boot/dts/qcom/pm8953.dtsi          |    2 +-
 arch/arm64/boot/dts/qcom/pm8994.dtsi          |    2 +-
 arch/arm64/boot/dts/qcom/pm8998.dtsi          |    2 +-
 arch/arm64/boot/dts/qcom/pmi632.dtsi          |    2 +-
 arch/arm64/boot/dts/qcom/pmi8950.dtsi         |    2 +-
 arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi     |    2 +-
 arch/arm64/boot/dts/qcom/pmp8074.dtsi         |    2 +-
 arch/arm64/boot/dts/qcom/pms405.dtsi          |    2 +-
 .../boot/dts/qcom/qcm6490-fairphone-fp5.dts   |    4 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dts       |    2 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      |    2 +-
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi    |    4 +-
 arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi   |    2 +-
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    |    6 +-
 .../boot/dts/qcom/sm7225-fairphone-fp4.dts    |    2 +-
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts       |    8 +-
 drivers/iio/adc/Kconfig                       |   25 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/qcom-spmi-adc5-gen3.c         | 1198 +++++++++++++++++
 drivers/iio/adc/qcom-spmi-adc5.c              |    2 +-
 drivers/iio/adc/qcom-spmi-vadc.c              |    2 +-
 .../iio/adc/qcom,spmi-adc5-gen3-pm8550.h      |   50 +
 .../iio/adc/qcom,spmi-adc5-gen3-pm8550b.h     |   89 ++
 .../iio/adc/qcom,spmi-adc5-gen3-pm8550vx.h    |   22 +
 .../iio/adc/qcom,spmi-adc5-gen3-pmk8550.h     |   56 +
 .../iio/{ => adc}/qcom,spmi-adc7-pm7325.h     |    2 +-
 .../iio/{ => adc}/qcom,spmi-adc7-pm8350.h     |    2 +-
 .../iio/{ => adc}/qcom,spmi-adc7-pm8350b.h    |    2 +-
 .../iio/{ => adc}/qcom,spmi-adc7-pmk8350.h    |    2 +-
 .../iio/{ => adc}/qcom,spmi-adc7-pmr735a.h    |    2 +-
 .../iio/{ => adc}/qcom,spmi-adc7-pmr735b.h    |    2 +-
 .../iio/{ => adc}/qcom,spmi-adc7-smb139x.h    |    2 +-
 .../iio/{ => adc}/qcom,spmi-vadc.h            |   81 ++
 50 files changed, 1785 insertions(+), 51 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
 create mode 100644 drivers/iio/adc/qcom-spmi-adc5-gen3.c
 create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550.h
 create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550b.h
 create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550vx.h
 create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pmk8550.h
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm7325.h (98%)
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350.h (98%)
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350b.h (99%)
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmk8350.h (97%)
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735a.h (95%)
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735b.h (95%)
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-smb139x.h (93%)
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-vadc.h (77%)

-- 
2.25.1


