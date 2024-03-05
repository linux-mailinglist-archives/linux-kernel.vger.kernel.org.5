Return-Path: <linux-kernel+bounces-92727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EA08724FD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1C7C28C07B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0619E125C9;
	Tue,  5 Mar 2024 16:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ldwkflPv"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCC6D268;
	Tue,  5 Mar 2024 16:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709657906; cv=none; b=eaJ6qn3fo8cUSTX6BbaOHsiVeLMgOeozdzp9YrZ3Xh0/DMxGKhsY/qgilgNGhN/0E3j5oPkhjYQAOfWDi6FKeN3FzK6IB8J4VQmJoyHAyTonB3p6JHWa18Hdii3uoCw2YtiD8cVjSCt3r6p59KQxqX3DVtm48ZnWFP2pj9vg2A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709657906; c=relaxed/simple;
	bh=Dbene+JorLqbq3nZB9Olrm3SKJvTPOQ5KM0W99aqTcw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cCmw5uC8+H8nODDVncRvdEgXprce3we1ah9/QfEVST3FhlgNCjI0WGJzw9/ZRWQUtUFklpa/VwyAB+SUWeJnB+3dxmvvXs05BqJkc7w5mUVsdrgR98idmYYls6mee8EHSdnZaeMu4Hx8B3BW0C/oFCXj6pBabV20gfHA5hLYJ6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ldwkflPv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 425DlDGp015519;
	Tue, 5 Mar 2024 16:58:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=kOc4mqW7YqT2IuvMfdIuROMR2Y3JLVuf7pv+QEnyKJA=; b=ld
	wkflPvMNeMySBy4sXWklzfreoNf63GQosctJsOYWtu6qa1UBB+ylYHjhCGKjuduD
	FnxymjUfg5Vkn241FPhki3CeVhxA2zuVRsdFCE2xceI9F7RuSN2HBhCgrdkcHMUd
	w8Ksm5muoeD1UlX9WxlCcXesYU2UsHqvkrGBcGKgwOBDoZPPb2cTT5FnB8DrWhku
	K2Wuh80OVzliDvzGo8PuMDi/RWz+TyBKxUlmCvN2Ud7i4FA9Z/1VTu/l9U5eLGdz
	AIxuY6riTmoGVwSUEdwzHG89uDsvGNwkIkhcmEJJZ+WYdQQkLdfPEoJrTrav3klM
	9v3cull930UUqhl26Dew==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wp04612rf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 16:58:06 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 425Gw4hl022108
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Mar 2024 16:58:04 GMT
Received: from sriramd-linux.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 5 Mar 2024 08:57:57 -0800
From: Sriram Dash <quic_sriramd@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <quic_wcheng@quicinc.com>,
        <Thinh.Nguyen@synopsys.com>, <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_psodagud@quicinc.com>,
        <quic_nkela@quicinc.com>, <manivannan.sadhasivam@linaro.org>,
        <ulf.hansson@linaro.org>, <sudeep.holla@arm.com>,
        <quic_shazhuss@quicinc.com>
Subject: [RFC 0/3] Enable firmware-managed USB resources on Qcom targets
Date: Tue, 5 Mar 2024 22:27:35 +0530
Message-ID: <1709657858-8563-1-git-send-email-quic_sriramd@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: f2fMK1kDVeAoNQXzg53S1juzVV-xWszD
X-Proofpoint-GUID: f2fMK1kDVeAoNQXzg53S1juzVV-xWszD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_14,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=934
 bulkscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2403050136

Some target systems allow multiple resources to be managed by firmware.
On these targets, tasks related to clocks, regulators, resets, and
interconnects can be delegated to the firmware, while the remaining
responsibilities are handled by Linux.

To support the management of partial resources in Linux and leave the rest
to firmware, multiple power domains are introduced. Each power domain can
manage one or more resources, depending on the specific use case.

These power domains handle SCMI calls to the firmware, enabling the
activation and deactivation of firmware-managed resources.

The driver is responsible for managing multiple power domains and
linking them to consumers as needed. Incase there is only single
power domain, it is considered to be a standard GDSC hooked on to
the qcom dt node which is read and assigned to device structure
(by genpd framework) before the driver probe even begins.

fw-managed dt property allows the driver to determine whether
device resources are managed by Linux or firmware, ensuring
backward compatibility.

Establish the channel and domain mapping for the power domains to connect
with firmware, enabling the firmware to handle the assigned resources.
Since these delegated resources will remain invisible to the operating
system, ensure that any references to them are removed.

Sriram Dash (3):
  dt-bindings: usb: qcom,dwc3: Add support for multiple power-domains
  USB: dwc3: qcom: Add support for firmware managed resources
  arm64: dts: qcom: sa8775p-ride: Enable support for firmware managed
    resources

 .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml        |  74 ++++--
 .../bindings/phy/qcom,usb-snps-femto-v2.yaml       |  49 +++-
 .../devicetree/bindings/usb/qcom,dwc3.yaml         |  37 ++-
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts          |  96 +++++--
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c            | 290 ++++++++++++++++-----
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c      | 213 ++++++++++++---
 drivers/usb/dwc3/dwc3-qcom.c                       | 259 +++++++++++++-----
 7 files changed, 801 insertions(+), 217 deletions(-)

-- 
2.7.4


