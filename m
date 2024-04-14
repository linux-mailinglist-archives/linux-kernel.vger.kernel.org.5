Return-Path: <linux-kernel+bounces-144355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 282368A44EB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 21:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDD13281590
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 19:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F88136E38;
	Sun, 14 Apr 2024 19:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jj/ysOKE"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B8D136652;
	Sun, 14 Apr 2024 19:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713123124; cv=none; b=R0LFOi/6DA70IhVQL8dXITZUhFqGi+a4nzip7SmCPy9rqSYK9KufAQ1vh0Ne2p6yReYpNPef8WKXgs8sGDvhI5J+Shfl+MHWYp1C0l6a2ecERwvmEdp3Dju8xuvA5EPzvkvSO49FW/Igqnoeiz39/ssLgbT8iDaCaPeEP4FqiRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713123124; c=relaxed/simple;
	bh=4qi9K81fBTQFNUBuQvIz2uLcfeMp8NME1IBqS4x5PpA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=CYvAFiIq08jyy+7HN6yhlzQdvykcBY9TbgdBcypXV4DoqY8Xu7r3AQnKNoCsDU/qSZJzzN27feQrrQifJ4hjZaj6ws4GlhaJsGwpRv+p7zUWg4+z8r6uavYGmaEiuO9AuWnPctGZU7M1SACRogsXZkclMqgCRpGqDB9PzPm5ONU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jj/ysOKE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43EJVeWR002957;
	Sun, 14 Apr 2024 19:31:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=HEkEWqXU9HyoEZ
	1EXeA+w0WswwWoARenxErZN6nxiXA=; b=jj/ysOKENEkBXsLqKxkOnaA//u3iNz
	7jsLMjd4WD2RdvMwlk0VOlJ4DOlI8rqDtdPYRBqzQshuOnO3ZFsJWAWaMhN9cS40
	yiOMhzNawjHRq/B4pjmRnUkijRfQ1XUPZHCJpsWm33qww0rtfI5AvUrlmATArN9E
	+gT9kGO62GkiQeRjwr6xoJSSkvUnxa7v6PaSTy88YnxOhp++AYx0kj7fNxsqe+f3
	5ZiMlFvlU5ch1hPl/xtrRoMw6+LzI9aIWSXq/RrW2wTesE1Ec8zSd+DP/RJaHUlA
	Bwr7lufJABV0gPXOVNRw+7INx5rS0VqucoHF+H+HP878i1TWuxco94rA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xfk7q25r4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Apr 2024 19:31:40 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43EJVc7s023182
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Apr 2024 19:31:39 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 14 Apr 2024 12:30:29 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
Subject: [PATCH v2 0/4] Implement vendor resets for PSCI SYSTEM_RESET2
Date: Sun, 14 Apr 2024 12:30:23 -0700
Message-ID: <20240414-arm-psci-system_reset2-vendor-reboots-v2-0-da9a055a648f@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM8uHGYC/5WOQW7CQAxFr4JmjSt7JpmorLhHhVDwmOJFMjBOI
 xDK3RtoN0gsYPn+4r1/dSZFxdxqcXVFRjXN/Qx+uXB8aPtvAU0zO48+EFKEtnRwNFawiw3SbYu
 YDB5G6VMuUGSX82DAHNpU1ZGxQTe7jkX2er53vjYzH9SGXC737Ei39b/gqxcLIwECRto1DeMnV
 bg+/Shrzx+cu1vyzxfwHV/ilGIItW8TPfURNW/9C1xF8lQH8Q++zTRNv87HLft8AQAA
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Andy Yan
	<andy.yan@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Mark
 Rutland" <mark.rutland@arm.com>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>
CC: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Melody Olvera
	<quic_molvera@quicinc.com>,
        Shivendra Pratap <quic_spratap@quicinc.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Elliot Berman <quic_eberman@quicinc.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kg2BFjUc4jt8afvcNHaVvokvjVTadHNp
X-Proofpoint-ORIG-GUID: kg2BFjUc4jt8afvcNHaVvokvjVTadHNp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-14_08,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404140142

The PSCI SYSTEM_RESET2 call allows vendor firmware to define additional
reset types which could be mapped to the reboot argument.

Setting up reboot on Qualcomm devices can be inconsistent from chipset
to chipset.  Generally, there is a PMIC register that gets written to
decide the reboot type. There is also sometimes a cookie that can be
written to indicate that the bootloader should behave differently than a
regular boot. These knobs evolve over product generations and require 
more drivers. Qualcomm firmwares are beginning to expose vendor
SYSTEM_RESET2 types to simplify driver requirements from Linux.

Add support in PSCI to statically wire reboot mode commands from
userspace to a vendor reset and cookie value using the device tree. The
DT bindings are similar to reboot mode framework except that 2
integers are accepted (the type and cookie). Also, reboot mode framework
is intended to program, but not reboot, the host. PSCI SYSTEM_RESET2
does both. I've not added support for reading ACPI tables since I don't
have any device which provides them + firmware that supports vendor
SYSTEM_RESET2 types.

Previous discussions around SYSTEM_RESET2:
- https://lore.kernel.org/lkml/20230724223057.1208122-2-quic_eberman@quicinc.com/T/
- https://lore.kernel.org/all/4a679542-b48d-7e11-f33a-63535a5c68cb@quicinc.com/

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
Changes in v2:
- Fixes to schema as suggested by Rob and Krzysztof
- Add qcm6490 idp as first Qualcomm device to support
- Link to v1: https://lore.kernel.org/r/20231117-arm-psci-system_reset2-vendor-reboots-v1-0-03c4612153e2@quicinc.com

Changes in v1:
- Reference reboot-mode bindings as suggeted by Rob.
- Link to RFC: https://lore.kernel.org/r/20231030-arm-psci-system_reset2-vendor-reboots-v1-0-dcdd63352ad1@quicinc.com

---
Elliot Berman (4):
      dt-bindings: power: reset: Convert mode-.* properties to array
      dt-bindings: arm: Document reboot mode magic
      firmware: psci: Read and use vendor reset types
      arm64: dts: qcom: Add PSCI SYSTEM_RESET2 types for qcm6490-idp

 Documentation/devicetree/bindings/arm/psci.yaml    | 38 ++++++++-
 .../bindings/power/reset/nvmem-reboot-mode.yaml    |  4 +
 .../devicetree/bindings/power/reset/qcom,pon.yaml  |  4 +
 .../bindings/power/reset/reboot-mode.yaml          | 12 ++-
 .../bindings/power/reset/syscon-reboot-mode.yaml   |  4 +
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts           |  5 ++
 drivers/firmware/psci/psci.c                       | 90 ++++++++++++++++++++++
 7 files changed, 153 insertions(+), 4 deletions(-)
---
base-commit: b5d2afe8745bf3eef5a59a13313798d24f2af983
change-id: 20231016-arm-psci-system_reset2-vendor-reboots-cc3ad456c070

Best regards,
-- 
Elliot Berman <quic_eberman@quicinc.com>


