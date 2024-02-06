Return-Path: <linux-kernel+bounces-54341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2277E84ADE4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 06:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8990E1F250A2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35956EB7F;
	Tue,  6 Feb 2024 05:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oNSDj3oH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F59B7E78B;
	Tue,  6 Feb 2024 05:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707196731; cv=none; b=K+2bxXCHdd4ceDUcvRMFKJWZYkcnRXSRa3e1uNiyzs0AY7qvJqiZj6RY1HF7NsKJqQq8biL0B7ubZi9YYx+BM9f4parzd+0b8eEffffEqLMLUqFWu7ORJj8GGxpDUoxu5BUJljnJTNqubqZcD2qpDX3/Z+JuTXKfb/czXwid/n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707196731; c=relaxed/simple;
	bh=b9f0KafgMv3GviOTUJU6XVHmOCjmzbUoK501o8vy2+8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=htUzJ4GLFWi+5uu93vERi+qzB5blhLubCQX4HSJ9k5WIhFloo6HtnwRj6/xYlJ2YEF5fV++V61filBqQdoFDmCwJ+l0rYla+43gOM4AfVVXwjvrk2rugbWVkxPJ3+GBsAkY8Pf2n1joh6MpYGYHwMXevgetCf1coGCqhXOzjPqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oNSDj3oH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 416409ZF021498;
	Tue, 6 Feb 2024 05:18:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=fJDqfjS
	vfVJX6zShg6Wanji5jnm+HAw9wDNPWUIkw5M=; b=oNSDj3oH3g8TZA5LCLYT8mm
	YnVgTllqU5GEjLlpUxfn4RoX26uyUFQVSH9Oy2NSqcXW6IiKCyfhv/k3wVJ+lASZ
	OAT1FHguTOb5/4lY8nGO2nNboOgUz0zqBVtdpMiA9X6w3t8hwTaU5YgshXhww/EK
	QWqwK+4cQi/GYaxKOmxZVvXHCR8OhcnqV4UPGjtIUePBM8sPGMqDRVquiKEvhFxu
	y/2CSWZeuzJZSoyeEnDHAYWhiDf3LJmtRnZGZPTxC+0SHIGN/VSRSbONVlt0OjKE
	tSA5Hj+dejIfxb6Y2G1O1UjxXy8mY7mKvIyunevNytcj5HdGoMCyc05ls6725yw=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w3cafr780-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 05:18:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4165Ie6w007100
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 Feb 2024 05:18:40 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 21:18:35 -0800
From: Krishna Kurapati <quic_kriskura@quicinc.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Wesley Cheng
	<quic_wcheng@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi
	<balbi@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        Krishna Kurapati
	<quic_kriskura@quicinc.com>
Subject: [PATCH v14 0/9] Add multiport support for DWC3 controllers
Date: Tue, 6 Feb 2024 10:48:16 +0530
Message-ID: <20240206051825.1038685-1-quic_kriskura@quicinc.com>
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
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pvTZ-DUi0xef4zqhq8noVrlOdiNj-_ES
X-Proofpoint-GUID: pvTZ-DUi0xef4zqhq8noVrlOdiNj-_ES
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_18,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 clxscore=1011
 bulkscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=703 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402060035

Currently the DWC3 driver supports only single port controller which
requires at most two PHYs ie HS and SS PHYs. There are SoCs that has
DWC3 controller with multiple ports that can operate in host mode.
Some of the port supports both SS+HS and other port supports only HS
mode.

This change primarily refactors the Phy logic in core driver to allow
multiport support with Generic Phy's.

Changes have been tested on  QCOM SoC SA8295P which has 4 ports (2
are HS+SS capable and 2 are HS only capable).

Changes in v14:
Moved wrapper binding update to 5th patch in the series as it deals
with only wakeup and not enumeration. The first part of the series
deals with enumeration and the next part deals with wakeup.
Updated commit text for wrapper driver patches.
Added error checks in get_port_index and setup_irq call which were
missing in v13.
Added SOB and CDB tags appropriately for the patches.
Rebased code on top of latest usb next.
DT changes have been removed and will be sent as a seperate series.

Changes in v13:
This series is a subset of patches in v11 as the first 3 patches in v11
have been mereged into usb-next.
Moved dr_mode property from platform specific files to common sc8280xp DT.
Fixed function call wrapping, added comments and replaced #defines with
enum in dwc3-qcom for identifying IRQ index appropriately.
Fixed nitpicks pointed out in v11 for suspend-resume handling.
Added reported-by tag for phy refactoring patch as a compile error was
found by kernel test bot [1].
Removed reviewed-by tag of maintainer for phy refactoring patch as a minor
change of increasing phy-names array size by 2-bytes was done to fix
compilation issue mentioned in [1].

Changes in v12:
Pushed as a subset of acked but no-yet-merged patches of v11 with intent
of making rebase of other patches easy. Active reviewers from community
suggested that it would be better to push the whole series in one go as it
would give good clarity and context for all the patches in the series.
So pushed v13 for the same addressing comments received in v11.

Changes in v11:
Implemented port_count calculation by reading interrupt-names from DT.
Refactored IRQ handling in dwc3-qcom.
Moving of macros to xhci-ext-caps.h made as a separate patch.
Names of interrupts to be displayed on /proc/interrupts set to the ones
present in DT.

Changes in v10:
Refactored phy init/exit/power-on/off functions in dwc3 core
Refactored dwc3-qcom irq registration and handling
Implemented wakeup for multiport irq's
Moved few macros from xhci.h to xhci-ext-caps.h
Fixed nits pointed out in v9
Fixed Co-developed by and SOB tags in patches 5 and 11

Changes in v9:
Added IRQ support for DP/DM/SS MP Irq's of SC8280
Refactored code to read port count by accessing xhci registers

Changes in v8:
Reorganised code in patch-5
Fixed nitpicks in code according to comments received on v7
Fixed indentation in DT patches
Added drive strength for pinctrl nodes in SA8295 DT

Changes in v7:
Added power event irq's for Multiport controller.
Udpated commit text for patch-9 (adding DT changes for enabling first
port of multiport controller on sa8540-ride).
Fixed check-patch warnings for driver code.
Fixed DT binding errors for changes in snps,dwc3.yaml
Reabsed code on top of usb-next

Changes in v6:
Updated comments in code after.
Updated variables names appropriately as per review comments.
Updated commit text in patch-2 and added additional info as per review
comments.
The patch header in v5 doesn't have "PATHCH v5" notation present. Corrected
it in this version.

Changes in v5:
Added DT support for first port of Teritiary USB controller on SA8540-Ride
Added support for reading port info from XHCI Extended Params registers.

Changes in RFC v4:
Added DT support for SA8295p.

Changes in RFC v3:
Incase any PHY init fails, then clear/exit the PHYs that
are already initialized.

Changes in RFC v2:
Changed dwc3_count_phys to return the number of PHY Phandles in the node.
This will be used now in dwc3_extract_num_phys to increment num_usb2_phy 
and num_usb3_phy.
Added new parameter "ss_idx" in dwc3_core_get_phy_ny_node and changed its
structure such that the first half is for HS-PHY and second half is for
SS-PHY.
In dwc3_core_get_phy, for multiport controller, only if SS-PHY phandle is
present, pass proper SS_IDX else pass -1.

Tested enumeration and wakeup on all ports:

/ # lsusb
Bus 001 Device 001: ID 1d6b:0002
Bus 001 Device 018: ID 0781:5567
Bus 001 Device 020: ID 03f0:134a
Bus 002 Device 002: ID 18d1:4ee1
Bus 002 Device 001: ID 1d6b:0003
/ #
/ # dmesg | grep ports
[    0.224450] hub 1-0:1.0: 4 ports detected
[    0.230479] hub 2-0:1.0: 2 ports detecte/ #
/ #
/ # cat /proc/interrupts  |grep phy
158:          1          0          0          0          0          0          0          0       PDC 127 Edge      dp_hs_phy_1
159:          2          0          0          0          0          0          0          0       PDC 126 Edge      dm_hs_phy_1
160:          6          0          0          0          0          0          0          0       PDC 129 Edge      dp_hs_phy_2
161:          3          0          0          0          0          0          0          0       PDC 128 Edge      dm_hs_phy_2
162:          1          0          0          0          0          0          0          0       PDC 131 Edge      dp_hs_phy_3
163:          2          0          0          0          0          0          0          0       PDC 130 Edge      dm_hs_phy_3
164:          2          0          0          0          0          0          0          0       PDC 133 Edge      dp_hs_phy_4
165:          3          0          0          0          0          0          0          0       PDC 132 Edge      dm_hs_phy_4
166:          0          0          0          0          0          0          0          0       PDC  16 Level     ss_phy_1
167:          0          0          0          0          0          0          0          0       PDC  17 Level     ss_phy_2

Links to previous versions:
Link to v13: https://lore.kernel.org/all/20231007154806.605-1-quic_kriskura@quicinc.com/
Link to v12: https://lore.kernel.org/all/20231004165922.25642-1-quic_kriskura@quicinc.com/
Link to v11: https://lore.kernel.org/all/20230828133033.11988-1-quic_kriskura@quicinc.com/
Link to v10: https://lore.kernel.org/all/20230727223307.8096-1-quic_kriskura@quicinc.com/
Link to v9: https://lore.kernel.org/all/20230621043628.21485-1-quic_kriskura@quicinc.com/
Link to v8: https://lore.kernel.org/all/20230514054917.21318-1-quic_kriskura@quicinc.com/
Link to v7: https://lore.kernel.org/all/20230501143445.3851-1-quic_kriskura@quicinc.com/
Link to v6: https://lore.kernel.org/all/20230405125759.4201-1-quic_kriskura@quicinc.com/
Link to v5: https://lore.kernel.org/all/20230310163420.7582-1-quic_kriskura@quicinc.com/
Link to RFC v4: https://lore.kernel.org/all/20230115114146.12628-1-quic_kriskura@quicinc.com/
Link to RFC v3: https://lore.kernel.org/all/1654709787-23686-1-git-send-email-quic_harshq@quicinc.com/#r
Link to RFC v2: https://lore.kernel.org/all/1653560029-6937-1-git-send-email-quic_harshq@quicinc.com/#r

Harsh Agarwal (1):
  usb: dwc3: core: Refactor PHY logic to support Multiport Controller

Krishna Kurapati (8):
  dt-bindings: usb: Add bindings for multiport properties on DWC3
    controller
  usb: dwc3: core: Access XHCI address space temporarily to read port
    info
  usb: dwc3: core: Skip setting event buffers for host only controllers
  dt-bindings: usb: qcom,dwc3: Add bindings for SC8280 Multiport
  usb: dwc3: qcom: Add helper function to request wakeup interrupts
  usb: dwc3: qcom: Refactor IRQ handling in glue driver
  usb: dwc3: qcom: Enable wakeup for applicable ports of multiport
  usb: dwc3: qcom: Add multiport suspend/resume support for wrapper

 .../devicetree/bindings/usb/qcom,dwc3.yaml    |  33 ++
 .../devicetree/bindings/usb/snps,dwc3.yaml    |  13 +-
 drivers/usb/dwc3/core.c                       | 326 +++++++++++++----
 drivers/usb/dwc3/core.h                       |  19 +-
 drivers/usb/dwc3/drd.c                        |  15 +-
 drivers/usb/dwc3/dwc3-qcom.c                  | 329 ++++++++++++------
 6 files changed, 534 insertions(+), 201 deletions(-)

-- 
2.34.1


