Return-Path: <linux-kernel+bounces-125455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C69892661
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38978B223FE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B684313AA38;
	Fri, 29 Mar 2024 21:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QM+Pwc2s"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803E81E862;
	Fri, 29 Mar 2024 21:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711749249; cv=none; b=m9axsYNIiKyt/W6unG2hO3ovZOurbHb+XwAruut0w/AJhzoi3VWIhdDoRqVKd9c+Lrn3aZuXOUKv0Iw6y6p5ILp8BsYfy4nHEDzIKP7rcgyIVyrhq0NMv1gUANlOTi/GT4pPQzKYxrQJ/PUIrMDJffNo9rJp2NC7o+4DL2d5HTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711749249; c=relaxed/simple;
	bh=aBs1Gl5l/nMbTRC+mcVuHiYzyIsEp4vfE2N7N6KGDZ8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=eKKGP0WXseo7X0nlY2EKjOqhi52xfrMOgLTzxZQugJaQhZTjbu96RGf1SsqKxn+TDByptap40kCxFZCByN1CHX47tfEkv/zVN3UxL/IA+X3PbaHI/nC5sfmC/uRLda/JitdwY6oQNSnOv48xExDghfVxiW9BF4OAEWFZEQp270c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QM+Pwc2s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42TLMNWB003527;
	Fri, 29 Mar 2024 21:54:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=l+JCdp0zS2nex5
	0S7DCvLlV/fiJaj7p2bIfcKxqukAk=; b=QM+Pwc2sPkJrFoUBJ8SIhVc60ubcNS
	vAmc3db1cQAbSzctZaYLt1GVUFU+TECrBMbQ7Af3fHAsfxCO/a0ZD8oLRXpdACmX
	VR14qaJgXY9R9URGpFVgI1eucxU3a6uroqO7dGmXKO7a2j7JxV7nlFIQrWF9shsu
	Gj3x0m37HA3xwDE7TP3vcbNJI6gpj9owdcizXm4nLAzvJaVuMXZWHMd0zT3GafIo
	AyyUsfui4OYtqzFjVFsBbPNcB+PfDvtvg0bkmpgU4dZ4fLp6ExOo00drfSwQX/4h
	wKlo/CYY8q3b4voKnhVQ+ZnBzrrbnPQgNGHl+9xR7M2bK/6btzFMPl0w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5vn99c38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 21:54:03 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42TLs3Z8002066
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 21:54:03 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 29 Mar
 2024 14:54:00 -0700
From: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
Subject: [PATCH v4 0/5] LLCC: Support for Broadcast_AND region
Date: Fri, 29 Mar 2024 14:53:39 -0700
Message-ID: <20240329-llcc-broadcast-and-v4-0-107c76fd8ceb@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGM4B2YC/x3Nyw6CMBCF4Vchs7ZNuWl15XsYY+p0gEmg1SkYE
 8K7W1l+i/OfFRIJU4JLsYLQhxPHkNEcCsDBhZ4U+2yoTNWYujqrcURUT4nOo0uzcsErIjS2trW
 x/gh5+BLq+LtHb/fsTuKk5kHI7SmMHxJdnoxt29K2Rvc86/fC+Fjy5cg4XP/igBrjBNv2A6eJq
 XClAAAA
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        Unnathi Chalicheemala
	<quic_uchalich@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711749240; l=3642;
 i=quic_uchalich@quicinc.com; s=20240202; h=from:subject:message-id;
 bh=aBs1Gl5l/nMbTRC+mcVuHiYzyIsEp4vfE2N7N6KGDZ8=;
 b=HLS9DMMzpzHNS+JPYjVSyto+T/47v/UFtMRXceJ2EKV+rnS2YSe/YsspB6B3V/F2GlVnyFFhr
 sBbGxZbf90IC9RXlrI/Z1gN0MJYOHWf49drHdW+vzETbO/Um9MPxmlu
X-Developer-Key: i=quic_uchalich@quicinc.com; a=ed25519;
 pk=8n+IFmsCDcEIg91sUP/julv9kf7kmyIKT2sR+1yFd4A=
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1vuYOtRN4_b6Pu4u_ZC_meoW2-X6Tvw7
X-Proofpoint-GUID: 1vuYOtRN4_b6Pu4u_ZC_meoW2-X6Tvw7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxscore=0 clxscore=1011 adultscore=0 priorityscore=1501 mlxlogscore=750
 phishscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403290194

This series adds:
1. Device tree register mapping for Broadcast_AND region in SM8450,
SM8550, SM8650.
2. LLCC driver updates to reflect addition of Broadcast_AND regmap.

To support CSR programming, a broadcast interface is used to program all
channels in a single command. Until SM8450 there was only one broadcast
region (Broadcast_OR) used to broadcast write and check for status bit
0. From SM8450 onwards another broadcast region (Broadcast_AND) has been
added which checks for status bit 1.

This series updates the device trees from SM8450 onwards to have a
mapping to this Broadcast_AND region. It also updates the llcc_drv_data
structure with a regmap for Broadcast_AND region and corrects the
broadcast region used to check for status bit 1.

Changes in v4:
- Updated Devicetree patches' commit messages to make problem statement
clearer
- Resolved Konrad's comments on driver code patch
- Updated v3 changelog to include dropped R-b tag

Changes in v3:
- Removed new example in dt-bindings patch and ran 'make
DT_CHECKER_FLAGS=-m dt_binding_check'
- Dropped Krzysztof's R-b tag on dt-bindings patch
- Use of ternary operator in llcc_update_act_ctrl()
- Add comment before initialization of Broadcast_AND regmap in probe
function
- Move DeviceTree patches to the end

Changes in v2:
- Added an additional check in the case old DT files are used for
above mentioned chipsets for backwards compatibility
- Moved addition of if check in llcc_update_act_ctrl() to a separate
"Fixes" patch; not part of this series

Link to v3: https://lore.kernel.org/all/cover.1708551850.git.quic_uchalich@quicinc.com/
Link to v2: https://lore.kernel.org/all/cover.1707202761.git.quic_uchalich@quicinc.com/
Link to v1: https://lore.kernel.org/all/cover.1706296015.git.quic_uchalich@quicinc.com/

Unnathi Chalicheemala (5):
  dt-bindings: arm: msm: Add llcc Broadcast_AND register
  soc: qcom: llcc: Add regmap for Broadcast_AND region
  arm64: dts: qcom: sm8450: Add mapping to llcc Broadcast_AND region
  arm64: dts: qcom: sm8550: Add mapping to llcc Broadcast_AND region
  arm64: dts: qcom: sm8650: Add mapping to llcc Broadcast_AND region

 .../devicetree/bindings/cache/qcom,llcc.yaml  | 27 ++++++++++++++++++-
 arch/arm64/boot/dts/qcom/sm8450.dtsi          |  5 ++--
 arch/arm64/boot/dts/qcom/sm8550.dtsi          |  6 +++--
 arch/arm64/boot/dts/qcom/sm8650.dtsi          |  6 +++--
 drivers/soc/qcom/llcc-qcom.c                  | 15 ++++++++++-
 include/linux/soc/qcom/llcc-qcom.h            |  4 ++-
 6 files changed, 54 insertions(+), 9 deletions(-)

--
2.25.1

---
Unnathi Chalicheemala (5):
      dt-bindings: arm: msm: Add llcc Broadcast_AND register
      soc: qcom: llcc: Add regmap for Broadcast_AND region
      arm64: dts: qcom: sm8450: Add mapping to llcc Broadcast_AND region
      arm64: dts: qcom: sm8550: Add Broadcast_AND register in LLCC block
      arm64: dts: qcom: sm8650: Add Broadcast_AND register in LLCC block

 .../devicetree/bindings/cache/qcom,llcc.yaml       | 27 +++++++++++++++++++++-
 arch/arm64/boot/dts/qcom/sm8450.dtsi               |  5 ++--
 arch/arm64/boot/dts/qcom/sm8550.dtsi               |  6 +++--
 arch/arm64/boot/dts/qcom/sm8650.dtsi               |  6 +++--
 drivers/soc/qcom/llcc-qcom.c                       | 14 ++++++++++-
 include/linux/soc/qcom/llcc-qcom.h                 |  4 +++-
 6 files changed, 53 insertions(+), 9 deletions(-)
---
base-commit: 4535e1a4174c4111d92c5a9a21e542d232e0fcaa
change-id: 20240329-llcc-broadcast-and-eec0838308d6

Best regards,
-- 
Unnathi Chalicheemala <quic_uchalich@quicinc.com>


