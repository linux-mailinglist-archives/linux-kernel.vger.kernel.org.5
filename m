Return-Path: <linux-kernel+bounces-148576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2529E8A84A7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE1442821C4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228191411D2;
	Wed, 17 Apr 2024 13:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SpivlUkN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B821013C3F5;
	Wed, 17 Apr 2024 13:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713360572; cv=none; b=k9r0UhQrfwFqEhRAld+aoWU53ldpM9z40caGhETBORbwEAXk6T/klUFiFvLJDXPGguazUm/jSndIMOeYQsfFkVxlw/0YXrLqVnMc+nUSVBRj4PsTwy63DKV81YaXVjPSYV7LuBxT+vRK5xJt96iimp7odvJEkxl1+pgA68hfYG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713360572; c=relaxed/simple;
	bh=gljJFEn66M8hgPTKOBSllPjFyni28a4vgRlQTT3iQzs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gyJNCMqvVgjSBZ9LPjodJI9DRWfrPnV/DsCXAulipebKxXMozpxY0q7pBVO6s2GlPQAkAbULiK04uCmsXvBJSPSKPpMU1rDK+GTpXJPhVMLgo4PCSA9/haANPbs57TaOu8H2e8lLmiSmQui5M115JwMlwtUWgjJSOKkqqgiDGag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SpivlUkN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43H6tKC9018492;
	Wed, 17 Apr 2024 13:29:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=l9zlRFE
	m3QGjLfcYxaGcKoQGUUV+ls+q1ephwRCckHE=; b=SpivlUkND+HfbBV5BnhaYAK
	G+N0hx33xpak0WzlNmm1wfWXUC0htyPLR7NPcb4ZETvbTdc2p8qp1pO1+P7pZdgC
	6ZHyGEvocv7DIR8w5Bsra/iyrica0XshYwxhDLkcwtPMAnqtR0PbJyiBj+sIXX5+
	qrnjLc1krQaPxujdUnQ48DqYt8DbZph/HahlLDlBR/zLqso6BjAbEkb26Cg6xuV1
	G6XsMoTJjDwpyBZ1x5jyb3oUk9tBcazIW21skLbxAJH1jcSQXDr2YKknZjzspyAh
	1hDrV+6CESBiOEBuNuLmLvhfEx73kF2yFQhOEG6TfZ7xBsdU8Cqq8tN9Ryp+YAA=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xj8aus2bx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 13:29:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43HDTMVV019722
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 13:29:22 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Apr 2024 06:29:16 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jassisinghbrar@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <dmitry.baryshkov@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_rgottimu@quicinc.com>,
        <quic_kshivnan@quicinc.com>, <quic_sibis@quicinc.com>,
        <conor+dt@kernel.org>, <quic_gkohli@quicinc.com>,
        <quic_nkela@quicinc.com>, <quic_psodagud@quicinc.com>
Subject: [PATCH V3 0/5] qcom: x1e80100: Enable CPUFreq
Date: Wed, 17 Apr 2024 18:58:51 +0530
Message-ID: <20240417132856.1106250-1-quic_sibis@quicinc.com>
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
X-Proofpoint-ORIG-GUID: PdTBPzOArFvI-72PPK1UpWcYdG9hHT77
X-Proofpoint-GUID: PdTBPzOArFvI-72PPK1UpWcYdG9hHT77
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_10,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=999 clxscore=1015 mlxscore=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404170092

This series enables CPUFreq support on the X1E SoC using the SCMI perf
protocol. This was originally part of the RFC: firmware: arm_scmi:
Qualcomm Vendor Protocol [1]. I've split it up so that this part can
land earlier.

V2:
* Fix series version number [Rob]
* Pickup Rbs from Dimitry and Rob.
* Use power-domain instead of clocks. [Sudeep/Ulf]
* Rename sram sub-nodes according to schema. [Dmitry]
* Use BIT() instead of manual shift. [Dmitry]
* Define RX_MBOX_CMD to account for chan calculation. [Dmitry]
* Clear the bit instead of the entire status within the spinlock. [Dmitry]
* Use dev_err_probe instead. [Dmitry]
* Drop superfluous error message while handling errors from get_irq. [Dmitry]
* Use devm_mbox_controller_register and drop remove path. [Dmitry]
* Define TX_MBOX_CMD to account for chan calculation.
* Use cpucp->dev in probe path for conformity.

RFC V1:
* Use x1e80100 as the fallback for future SoCs using the cpucp-mbox
  controller. [Krzysztoff/Konrad/Rob]
* Use chan->lock and chan->cl to detect if the channel is no longer
  Available. [Dmitry]
* Use BIT() instead of using manual shifts. [Dmitry]
* Don't use integer as a pointer value. [Dmitry]
* Allow it to default to of_mbox_index_xlate. [Dmitry]
* Use devm_of_iomap. [Dmitry]
* Use module_platform_driver instead of module init/exit. [Dmitry]
* Get channel number using mailbox core (like other drivers) and
  further simplify the driver by dropping setup_mbox func.

[1]: https://lore.kernel.org/lkml/20240117173458.2312669-1-quic_sibis@quicinc.com/#r

Other relevant Links:
https://lore.kernel.org/lkml/be2e475a-349f-4e98-b238-262dd7117a4e@linaro.org/

Sibi Sankar (5):
  dt-bindings: mailbox: qcom: Add CPUCP mailbox controller bindings
  mailbox: Add support for QTI CPUCP mailbox controller
  arm64: dts: qcom: x1e80100: Resize GIC Redistributor register region
  arm64: dts: qcom: x1e80100: Add cpucp mailbox and sram nodes
  arm64: dts: qcom: x1e80100: Enable cpufreq

 .../bindings/mailbox/qcom,cpucp-mbox.yaml     |  49 +++++
 arch/arm64/boot/dts/qcom/x1e80100.dtsi        |  91 ++++++---
 drivers/mailbox/Kconfig                       |   8 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/qcom-cpucp-mbox.c             | 188 ++++++++++++++++++
 5 files changed, 313 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml
 create mode 100644 drivers/mailbox/qcom-cpucp-mbox.c

-- 
2.34.1


