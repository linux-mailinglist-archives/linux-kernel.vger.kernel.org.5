Return-Path: <linux-kernel+bounces-156160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE2D8AFEAA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EC581C21E24
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F72613F459;
	Wed, 24 Apr 2024 02:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="c94bLqho"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9606986254;
	Wed, 24 Apr 2024 02:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713926805; cv=none; b=hZebW3C7Fx5vYrSBL5TXCgWUyNr8/qpI3oMHrrcmkEnJz9cSeR269ZclbdeS5v+eEJw/E9aFJuu114Sq7YT/83JaQwF+16YwGt5cZWKXb2Rv0srGmfYD+LZHEfQ6wCinSZkj05r82ibZc6HUcW9T2iZUOsTk2m9E9FlPVTXnyww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713926805; c=relaxed/simple;
	bh=B+Pn0gOtxhGeCEHnNekUBZjSFIs4P8XCtSNIQ6xwPIg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YOjx5A4VVbl+FWt18+xYxaQgkkcLoPHSuBECgjOGf312n5SUMsPnVZOM27q5YQzSY0T/IK4BOkpILEA5FIsBAsfkB22NpEQ/l9Z2/QPE2hx58sI6hgGe5fi/XnXKQmEYIDon+vA9ZE+hqIGSzJFCm/hh4mfyZpnNvzk8YFLP660=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=c94bLqho; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O0jU81032028;
	Wed, 24 Apr 2024 02:46:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=F8dBvrR
	T5yNcZEShq0vi19neAkhbVLY5pR1KfJgS0uc=; b=c94bLqhoSVAHD4JGuFkjBWa
	Cso9SMO9BHZtQbsef57Ya/XXKNAxn2oyvuhG5Z8DsTM8dxvo65lJyIWGuAiqHzgg
	9smGAQW/I19Ho6dtkNkASLYyBB5+icmsjXvbIhBqAl0Ho5PC06ClH361r11+sPLF
	/edkLSmxWlqvq417uF7DE6sbuVLlKbidvxHlhWCHoVpnsv2sU45m0lvweCbsJjmC
	TOot+G2MGUC9PUsgjcuSIFQkymMuvNqolnEH6cGnQZ69I0NlkKUWIP1mauebS7M3
	0rRy4MFytc/b2rBv4bHsJhRhaUfi65Gh2w3ODhDbtS4IdJsSOBxxe9pQIZ5UReQ=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xp978txju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 02:46:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43O2kRUY028884
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 02:46:27 GMT
Received: from tengfan-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 23 Apr 2024 19:46:21 -0700
From: Tengfei Fan <quic_tengfan@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <dmitry.baryshkov@linaro.org>
CC: <keescook@chromium.org>, <tony.luck@intel.com>, <gpiccoli@igalia.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <kernel@quicinc.com>, Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH v7 0/4] arm64: qcom: add AIM300 AIoT board support
Date: Wed, 24 Apr 2024 10:45:04 +0800
Message-ID: <20240424024508.3857602-1-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-ORIG-GUID: lbnOJrSONMIP5zb8s4LY8hDxYuTJ0fBI
X-Proofpoint-GUID: lbnOJrSONMIP5zb8s4LY8hDxYuTJ0fBI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_20,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=999 adultscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240011

Add AIM300 AIoT support along with usb, ufs, regulators, serial, PCIe,
and PMIC functions.
AIM300 Series is a highly optimized family of modules designed to
support AIoT applications. It integrates QCS8550 SoC, UFS and PMIC
chip etc.
Here is a diagram of AIM300 AIoT Carrie Board and SoM
 +--------------------------------------------------+
 |             AIM300 AIOT Carrier Board            |
 |                                                  |
 |           +-----------------+                    |
 |power----->| Fixed regulator |---------+          |
 |           +-----------------+         |          |
 |                                       |          |
 |                                       v VPH_PWR  |
 | +----------------------------------------------+ |
 | |                          AIM300 SOM |        | |
 | |                                     |VPH_PWR | |
 | |                                     v        | |
 | |   +-------+       +--------+     +------+    | |
 | |   | UFS   |       | QCS8550|     |PMIC  |    | |
 | |   +-------+       +--------+     +------+    | |
 | |                                              | |
 | +----------------------------------------------+ |
 |                                                  |
 |                    +----+          +------+      |
 |                    |USB |          | UART |      |
 |                    +----+          +------+      |
 +--------------------------------------------------+
The following functions have been verified:
  - uart
  - usb
  - ufs
  - PCIe
  - PMIC
  - display
  - adsp
  - cdsp
  - tlmm

Documentation for qcs8550[1] and sm8550[2]
[1] https://docs.qualcomm.com/bundle/publicresource/87-61717-1_REV_A_Qualcomm_QCS8550_QCM8550_Processors_Product_Brief.pdf
[2] https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/Snapdragon-8-Gen-2-Product-Brief.pdf

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---

v6 -> v7:
  - correct typos in the commit message
  - move mdss_dsi0, mdss_dsi0_phy, pcie0_phy, pcie1_phy and usb_dp_qmpphy
    vdda supply to qcs8550-aim300.dtsi
  - move the perst and wake gpio settings of pcie0 and pcie1 to
    qcs8550-aim300.dtsi
  - move the clock frequency settings of pcie_1_phy_aux_clk, sleep_clk
    and xo_board to qcs8550-aim300.dtsi
  - verified with dtb check, and result is expected, because those
    warnings are not introduced by current patch series.
    arch/arm64/boot/dts/qcom/sm8550.dtsi:3037.27-3092.6: Warning
    (avoid_unnecessary_addr_size): /soc@0/display-subsystem@ae00000/dsi@ae96000: unnecessary
    #address-cells/#size-cells without "ranges" or child "reg" property
    arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dtb:
    phy@1c0e000: clock-output-names: ['pcie1_pipe_clk'] is too short
        from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-pcie-phy.yaml#
    arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dtb: phy@1c0e000: #clock-cells:0:0: 1 was expected
        from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-pcie-phy.yaml#

v5 -> v6:
  - move qcs8550 board info bebind sm8550 boards info in qcom.yaml

v4 -> v5:
  - "2023-2024" instead of "2023~2024" for License
  - update patch commit message to previous comments and with an updated
    board diagram
  - use qcs8550.dtsi instead of qcm8550.dtsi
  - remove the reserved memory regions which will be handled by
    bootloader
  - remove pm8550_flash, pm8550_pwm nodes, Type-C USB/DP function node,
    remoteproc_mpss function node, audio sound DTS node, new patch will
    be updated after respective team's end to end full verification
  - address comments to vph_pwr, move vph_pwr node and related
    references to qcs8550-aim300-aiot.dts
  - use "regulator-vph-pwr" instead of "vph_pwr_regulator"
  - add pcie0I AND pcie1 support together
  - the following patches were applied, so remove these patches from new
    patch series:
      - https://lore.kernel.org/linux-arm-msm/20240119100621.11788-3-quic_tengfan@quicinc.com
      - https://lore.kernel.org/linux-arm-msm/20240119100621.11788-4-quic_tengfan@quicinc.com
  - verified with dtb check, and result is expected, because those
    warnings are not introduced by current patch series.
    DTC_CHK arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dtb
    arch/arm64/boot/dts/qcom/sm8550.dtsi:3015.27-3070.6: Warning
    (avoid_unnecessary_addr_size): /soc@0/display-subsystem@ae00000/dsi@ae96000: unnecessary
    #address-cells/#size-cells without "ranges" or child "reg" property
    arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dtb:
    opp-table: opp-75000000:opp-hz:0: [75000000, 0, 0, 75000000, 0, 0, 0, 0] is too long
        from schema $id: http://devicetree.org/schemas/opp/opp-v2.yaml#
    arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dtb:
    opp-table: opp-150000000:opp-hz:0: [150000000, 0, 0, 150000000, 0, 0, 0, 0] is too long
        from schema $id: http://devicetree.org/schemas/opp/opp-v2.yaml#
    arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dtb:
    opp-table: opp-300000000:opp-hz:0: [300000000, 0, 0, 300000000, 0, 0, 0, 0] is too long
        from schema $id: http://devicetree.org/schemas/opp/opp-v2.yaml#
    arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dtb:
    opp-table: Unevaluated properties are not allowed ('opp-150000000', 'opp-300000000', 'opp-75000000' were unexpected)
        from schema $id: http://devicetree.org/schemas/opp/opp-v2.yaml#

v3 -> v4:
  - use qcm8550.dtsi instead of qcs8550.dtsi, qcs8550 is a QCS version
    of qcm8550, another board with qcm8550 will be added later
  - add AIM300 AIoT board string in qcom.yaml file
  - add sm8550 and qcm8550 fallback compatible
  - add qcm8550 SoC id
  - add reserved memory map codes in qcm8550.dtsi
  - pm8010 and pmr73d are splited into carrier board DTS file. Because
    the regulators which in pm8550, pm8550ve and pm8550vs are present
    on the SoM. The regulators which in pm8010 and pmr73d are present
    on the carrier board.
  - stay VPH_PWR at qcs8550-aim300.dtsi file
      VPH_PWR is obtained by vonverting 12v voltage into 3.7 voltage
      with a 3.7v buck. VPH_PWR is power supply for regulators in AIM300
      SOM. VPH_PWR regulator is defined in AIM300 SOM dtsi file.

v2 -> v3:
  - introduce qcs8550.dtsi
  - separate fix dtc W=1 warning patch to another patch series

v1 -> v2:
  - merge the splited dts patches into one patch
  - update dts file name from qcom8550-aim300.dts to qcs8550-aim300 dts
  - drop PCIe1 dts node due to it is not enabled
  - update display node name for drop sde characters

previous discussion here:
[1] v6 RESEND: https://lore.kernel.org/linux-arm-msm/20240401093843.2591147-1-quic_tengfan@quicinc.com
[2] v6: https://lore.kernel.org/linux-arm-msm/20240308070432.28195-1-quic_tengfan@quicinc.com
[3] v5: https://lore.kernel.org/linux-arm-msm/20240301134113.14423-1-quic_tengfan@quicinc.com
[4] v4: https://lore.kernel.org/linux-arm-msm/20240119100621.11788-1-quic_tengfan@quicinc.com
[5] v3: https://lore.kernel.org/linux-arm-msm/20231219005007.11644-1-quic_tengfan@quicinc.com
[6] v2: https://lore.kernel.org/linux-arm-msm/20231207092801.7506-1-quic_tengfan@quicinc.com
[7] v1: https://lore.kernel.org/linux-arm-msm/20231117101817.4401-1-quic_tengfan@quicinc.com

Tengfei Fan (4):
  dt-bindings: arm: qcom: Document QCS8550 SoC and the AIM300 AIoT board
  arm64: dts: qcom: qcs8550: introduce qcs8550 dtsi
  arm64: dts: qcom: add base AIM300 dtsi
  arm64: dts: qcom: aim300: add AIM300 AIoT

 .../devicetree/bindings/arm/qcom.yaml         |   8 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/qcs8550-aim300-aiot.dts     | 343 +++++++++++++++
 arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi  | 403 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/qcs8550.dtsi         | 169 ++++++++
 5 files changed, 924 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dts
 create mode 100644 arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/qcs8550.dtsi


base-commit: a59668a9397e7245b26e9be85d23f242ff757ae8
-- 
2.25.1


