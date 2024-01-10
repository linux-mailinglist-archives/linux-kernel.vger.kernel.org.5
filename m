Return-Path: <linux-kernel+bounces-22109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF42A829956
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 590B0B2675B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02075481B7;
	Wed, 10 Jan 2024 11:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LHZTJjvn"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CB5481A4;
	Wed, 10 Jan 2024 11:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40A8gFV3025511;
	Wed, 10 Jan 2024 11:41:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=Uc6HnQG
	HRycirauuXTF2iF/cVs7k4R8jSd2350aueSQ=; b=LHZTJjvnF5eF9WA78W9G/tk
	G4WqHnz2doW6L/FV1tWXggg1qUK52NbukhBzKXA6wtYmfoWrItLqe7TcimRp9DQF
	hEu/Dimy0n8NBrFaOOuXIX8h6J3VMkZgjWebHsZhFeaNBSoYNIrsMokwnd9XEz7U
	ZV39JzazmEK766V8hQi4mBe5cM4NL6oRLNcgpHV4XBARe9MrYfcauQd3/KoBYn0+
	WPCBaqfvosyZVsbrObtAPCk26yX9zL80Nv5dpnmDxncge5Ql70dtXjdopczgnDBW
	kRmmhsgWPDmQKn2X8wUj8AcasYf8TvCg6tL1/Jn590O2pBFH8fJtveDEEmbsayA=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh85t2dvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:41:06 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40ABf5Bs018623
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:41:05 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 03:40:55 -0800
From: Luo Jie <quic_luoj@quicinc.com>
To: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <linux@armlinux.org.uk>,
        <shannon.nelson@amd.com>, <anthony.l.nguyen@intel.com>,
        <jasowang@redhat.com>, <brett.creeley@amd.com>,
        <rrameshbabu@nvidia.com>, <joshua.a.hay@intel.com>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <neil.armstrong@linaro.org>,
        <dmitry.baryshkov@linaro.org>, <nfraprado@collabora.com>,
        <m.szyprowski@samsung.com>, <u-kumar1@ti.com>,
        <jacob.e.keller@intel.com>, <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <ryazanov.s.a@gmail.com>, <ansuelsmth@gmail.com>,
        <quic_kkumarcs@quicinc.com>, <quic_suruchia@quicinc.com>,
        <quic_soni@quicinc.com>, <quic_pavir@quicinc.com>,
        <quic_souravp@quicinc.com>, <quic_linchen@quicinc.com>,
        <quic_leiwei@quicinc.com>
Subject: [PATCH net-next 00/20] net: ethernet: Add qcom PPE driver
Date: Wed, 10 Jan 2024 19:40:12 +0800
Message-ID: <20240110114033.32575-1-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: z3Hzf9LUPOgDMX764m98likxAW2pcZsy
X-Proofpoint-GUID: z3Hzf9LUPOgDMX764m98likxAW2pcZsy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=841 clxscore=1011
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100095

The PPE(packet process engine) hardware block is available in Qualcomm
IPQ chipsets that support PPE architecture, such as IPQ9574 and IPQ5332.
The PPE includes integrated ethernet MAC and PCS(uniphy), which is used
to connect with external PHY devices by PCS. The PPE also includes
various packet processing offload capabilities such as routing and
briding offload, L2 switch capability, VLAN and tunnel processing
offload.

This patch series enables support for the PPE driver which intializes
and configures the PPE, and provides various services for higher level
network drivers in the system such as EDMA (Ethernet DMA) driver or a
DSA switch driver for PPE L2 Switch, for Qualcomm IPQ SoCs.

The PPE driver provides following functions:

1. Initialize PPE device hardware functions such as buffer management,
   queue management, TDM, scheduler and clocks in order to bring up PPE
   device.

2. Register the PCS driver and uniphy raw clock provider. The uniphy
   raw clock is selected as the parent clock of the NSSCC clocks. The
   NSSCC clocks are registered by the dependent patchset at the link
   below.(Note: There are 3 PCS on IPQ9574, 2 PCS on IPQ5332 platform.)

3. Export the PPE control path API (ppe_device_ops) for use by higher
   level network drivers such as  the EDMA(Ethernet DMA) driver. The
   EDMA netdevice driver depends on this PPE driver and  registers the
   netdevices to receive and transmit packets using the ethernet ports.

4. Register debugfs file to provide access to various PPE packet counters.
   These statistics are recorded by the various HW counters, such as port
   RX/TX, CPU code and HW queue counters.

The diagram and detail introduction of PPE are described in the added file:
Documentation/networking/device_drivers/ethernet/qualcomm/ppe/ppe.rst,
which is added by the first patch.
<Documentation: networking: qcom PPE driver documentation>.

PPE driver depends on the NSSCC clock driver below, which provides the
clocks for the PPE driver.
https://lore.kernel.org/linux-arm-msm/20230825091234.32713-1-quic_devipriy@quicinc.com/
https://lore.kernel.org/linux-arm-msm/20231211-ipq5332-nsscc-v3-0-ad13bef9b137@quicinc.com/

PPE driver also depens on the device tree patch series to bring up PPE
device as below link.
https://lore.kernel.org/all/20240110112059.2498-1-quic_luoj@quicinc.com/

Lei Wei (5):
  Documentation: networking: qcom PPE driver documentation
  net: ethernet: qualcomm: Add PPE L2 bridge initialization
  net: ethernet: qualcomm: Add PPE UNIPHY support for phylink
  net: ethernet: qualcomm: Add PPE MAC support for phylink
  net: ethernet: qualcomm: Add PPE MAC functions

Luo Jie (15):
  dt-bindings: net: qcom,ppe: Add bindings yaml file
  net: ethernet: qualcomm: Add qcom PPE driver
  net: ethernet: qualcomm: Add PPE buffer manager configuration
  net: ethernet: qualcomm: Add PPE queue management config
  net: ethernet: qualcomm: Add PPE TDM config
  net: ethernet: qualcomm: Add PPE port scheduler resource
  net: ethernet: qualcomm: Add PPE scheduler config
  net: ethernet: qualcomm: Add PPE queue config
  net: ethernet: qualcomm: Add PPE service code config
  net: ethernet: qualcomm: Add PPE port control config
  net: ethernet: qualcomm: Add PPE RSS hash config
  net: ethernet: qualcomm: Export PPE function set_maxframe
  net: ethernet: qualcomm: Add PPE AC(admission control) function
  net: ethernet: qualcomm: Add PPE debugfs counters
  arm64: defconfig: Enable qcom PPE driver

 .../devicetree/bindings/net/qcom,ppe.yaml     | 1330 +++++++
 .../device_drivers/ethernet/index.rst         |    1 +
 .../ethernet/qualcomm/ppe/ppe.rst             |  305 ++
 MAINTAINERS                                   |    9 +
 arch/arm64/configs/defconfig                  |    1 +
 drivers/net/ethernet/qualcomm/Kconfig         |   17 +
 drivers/net/ethernet/qualcomm/Makefile        |    1 +
 drivers/net/ethernet/qualcomm/ppe/Makefile    |    7 +
 drivers/net/ethernet/qualcomm/ppe/ppe.c       | 3070 +++++++++++++++++
 drivers/net/ethernet/qualcomm/ppe/ppe.h       |  315 ++
 .../net/ethernet/qualcomm/ppe/ppe_debugfs.c   |  953 +++++
 .../net/ethernet/qualcomm/ppe/ppe_debugfs.h   |   25 +
 drivers/net/ethernet/qualcomm/ppe/ppe_ops.c   |  628 ++++
 drivers/net/ethernet/qualcomm/ppe/ppe_ops.h   |  256 ++
 drivers/net/ethernet/qualcomm/ppe/ppe_regs.h  | 1106 ++++++
 .../net/ethernet/qualcomm/ppe/ppe_uniphy.c    |  789 +++++
 .../net/ethernet/qualcomm/ppe/ppe_uniphy.h    |  227 ++
 include/linux/soc/qcom/ppe.h                  |  105 +
 18 files changed, 9145 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/qcom,ppe.yaml
 create mode 100644 Documentation/networking/device_drivers/ethernet/qualcomm/ppe/ppe.rst
 create mode 100644 drivers/net/ethernet/qualcomm/ppe/Makefile
 create mode 100644 drivers/net/ethernet/qualcomm/ppe/ppe.c
 create mode 100644 drivers/net/ethernet/qualcomm/ppe/ppe.h
 create mode 100644 drivers/net/ethernet/qualcomm/ppe/ppe_debugfs.c
 create mode 100644 drivers/net/ethernet/qualcomm/ppe/ppe_debugfs.h
 create mode 100644 drivers/net/ethernet/qualcomm/ppe/ppe_ops.c
 create mode 100644 drivers/net/ethernet/qualcomm/ppe/ppe_ops.h
 create mode 100644 drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
 create mode 100644 drivers/net/ethernet/qualcomm/ppe/ppe_uniphy.c
 create mode 100644 drivers/net/ethernet/qualcomm/ppe/ppe_uniphy.h
 create mode 100644 include/linux/soc/qcom/ppe.h


base-commit: a7fe0881d9b78d402bbd9067dd4503a57c57a1d9
-- 
2.42.0


