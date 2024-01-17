Return-Path: <linux-kernel+bounces-29277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DB8830C05
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C51B21C215D7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D55E2263E;
	Wed, 17 Jan 2024 17:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MUzzw116"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F80A22615;
	Wed, 17 Jan 2024 17:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705512930; cv=none; b=ioGrsxZXDo0lCVxwDjvHIQb6UaCFFfEaPzxdgocozA/VV2BJ2g6cz+R//uNYscZKiFnK045seMZ9bvOJeGupRQiuLTEBWjiWw+HzuM5fizwI+0eyhkrGkG7Zc8EpmQ0qml5/V0PnxUCg2b3ZLKPHU44MZhGz9obqG5l7SEKEdvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705512930; c=relaxed/simple;
	bh=/1Kqm2lSPbaEzEFnLl/baHfDDbMZGtr3vQCqFOfX6Lk=;
	h=Received:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-QCInternal:X-Proofpoint-Virus-Version:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details; b=R8z+5ZCuESTTJ4E33pBUaLPUE4LCRn/qoKzPJFPfPTbR1+5/UaDzq6yMWEVZHJJgZQJsSC8O38ZtC54zQccznwncTNnfBLtVM8WY0HWhGhAGw/kQ77X/jgpXxmhfV2NVUB8jAoGWN7n+g7mjpw9s+/G7HkmNm8Yd7Ma7QKSTIy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MUzzw116; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40HEr64l013711;
	Wed, 17 Jan 2024 17:35:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=9uvD2xA
	mOI88ZwP7f+C9FKSk+aNZxYI49Ff+IV//g3o=; b=MUzzw116AaxCgqMRd82oM3r
	ZjV9UvRv4T4aU8rApzadY8gsylByEWj/uWEpFRADjNQu/MHSyeDSFAK3+9l7Skq7
	ZDB4KRQn+cDVOAwQDwaKvF9SD/bZdB7Cd6mwzxDDAKA8C4yQ4a6HPzy+H3ZvRsVZ
	j7FJVJI67YGqaLUfzcwev5HCfKP2q8q/I4YgURwiIank5Q5DKi2hdGxbMBUkzgZ0
	pqbo5Ao7cEiUj6w8GIA1jSZHqRfGTZoY6/hLjOlv5ZJQ9FxzV3Lhz2AyO2IPg+sz
	2L42COCZU/oJp6nTaigLefXjflwAYVPiktVZ7mBcqDP30+webFbwEOLfiVP59mQ=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vp8gwhhs3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 17:35:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40HHZJv5005468
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 17:35:19 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 09:35:15 -0800
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jassisinghbrar@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_rgottimu@quicinc.com>,
        <quic_kshivnan@quicinc.com>, <quic_sibis@quicinc.com>,
        <conor+dt@kernel.org>
Subject: [RFC 0/7] firmware: arm_scmi: Qualcomm Vendor Protocol
Date: Wed, 17 Jan 2024 23:04:51 +0530
Message-ID: <20240117173458.2312669-1-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dEjj_PROBZyYwT8VWUwqWpOgsz2Mdbso
X-Proofpoint-ORIG-GUID: dEjj_PROBZyYwT8VWUwqWpOgsz2Mdbso
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_10,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxscore=0 clxscore=1011 priorityscore=1501 mlxlogscore=690 bulkscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401170127

This patch series introduces the Qualcomm SCMI Vendor protocol and adds a
client driver that interacts with the vendor protocol and passes on the
required tuneables to start various features running on the SCMI controller.

The series specifically enables (LLCC/DDR) dvfs on X1E80100 SoC by passing
several tuneables including the IPM ratio (Instructions Per Miss),
cpu frequency to memory/bus frequency tables, CPU mapping to the vendor
protocol which in turn will enable the memory latency governor running
on the SCMI controller.

Depends on:
limits changed notification v2: https://patchwork.kernel.org/project/linux-arm-msm/cover/20240117104116.2055349-1-quic_sibis@quicinc.com/
Turbo support: https://patchwork.kernel.org/project/linux-arm-msm/cover/20240117110443.2060704-1-quic_sibis@quicinc.com/

Shivnandan Kumar (2):
  firmware: arm_scmi: Add QCOM vendor protocol
  soc: qcom: Utilize qcom scmi vendor protocol for bus dvfs

Sibi Sankar (5):
  dt-bindings: mailbox: qcom: Add CPUCP mailbox controller bindings
  mailbox: Add support for QTI CPUCP mailbox controller
  arm64: dts: qcom: x1e80100: Add cpucp mailbox and sram nodes
  arm64: dts: qcom: x1e80100: Enable cpufreq
  arm64: dts: qcom: x1e80100: Enable LLCC/DDR dvfs

 .../bindings/mailbox/qcom,cpucp-mbox.yaml     |  51 ++
 arch/arm64/boot/dts/qcom/x1e80100.dtsi        | 101 ++++
 drivers/firmware/arm_scmi/Kconfig             |  11 +
 drivers/firmware/arm_scmi/Makefile            |   1 +
 drivers/firmware/arm_scmi/qcom_scmi_vendor.c  | 160 ++++++
 drivers/mailbox/Kconfig                       |   8 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/qcom-cpucp-mbox.c             | 265 ++++++++++
 drivers/soc/qcom/Kconfig                      |  10 +
 drivers/soc/qcom/Makefile                     |   1 +
 drivers/soc/qcom/qcom_scmi_client.c           | 486 ++++++++++++++++++
 include/linux/qcom_scmi_vendor.h              |  36 ++
 12 files changed, 1132 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml
 create mode 100644 drivers/firmware/arm_scmi/qcom_scmi_vendor.c
 create mode 100644 drivers/mailbox/qcom-cpucp-mbox.c
 create mode 100644 drivers/soc/qcom/qcom_scmi_client.c
 create mode 100644 include/linux/qcom_scmi_vendor.h

-- 
2.34.1


