Return-Path: <linux-kernel+bounces-94950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2491F874721
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 05:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56E251C218BE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0821804E;
	Thu,  7 Mar 2024 04:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cXFIim5K"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA7B14F70;
	Thu,  7 Mar 2024 04:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709785069; cv=none; b=lU8xXIapTr+OvnjN2AHydQl9HcQuIIuSzA1crHEwWerAGrFVEbBn6yGomFKUAy1PU5/7UNi/jaHdYLXM/pAOqTM6pDLc6Vm7ivMon1viHBhhNuCu23exze3oZc1NHVfGsvKImjWEJtB9LTHe4WE1vdUDQJdEnSRORV4m1y3rXyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709785069; c=relaxed/simple;
	bh=ZDta15m0I2nKrqcMEEmGrNUIwtazxAg/dD4fNeQZPNA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gxxIeuvBXq0c4/1HEOAKi/ZPogyClc/rY05F77BpPM4mK28eSiHHgSA6JE/mK6NOwIkxvFyhgcKR2o901pkZiw6gc2e3aItBoOC3OGyeT4QGVEKdxoi4g3Uja/e5slf9gFtPl+kVZ+rueziSFzCN/Y3AEwVx+PLXULr2FcoU5VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cXFIim5K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42745gc1013144;
	Thu, 7 Mar 2024 04:17:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=qcppdkim1; bh=VcB0Az2E5kvwEhji6bm9
	s9YDP1iRfXCtBOxnVmBp1jA=; b=cXFIim5Kkv/oZctiIiWzG9Htm60m3y8bMIr9
	sULIheQomehD8BGlC8W4vjiIt1qQfKytw5iu3+njlcE1KJ400cvEDCXmw9VttmOk
	kDtcRGy7xffcAh8VCgHq2MmLsA6yOFwayhVoppJPKayBtXD64Q4XcrKC1oP99cOB
	g93i9ThRfqMvzBMll55ng/rc+VLOk/UHZiW9rr9ieumXQpJrHEhCxxIFpGFHmdWb
	apSpNR6UK4eWNCq+32DH226w5GAsT4LsC0elo0GkOl3Pvvv/FxYbmkIhAsfYOo7u
	PRdzGpEARHWE+BYdFIjgq5H+9a169cSo+jK5B0C6pWPjFuig8g==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wq0u3ghss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 04:17:34 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 4274HU1k009261;
	Thu, 7 Mar 2024 04:17:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3wp060d47a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 04:17:30 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4274HTp3009231;
	Thu, 7 Mar 2024 04:17:29 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-mdalam-blr.qualcomm.com [10.131.36.157])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4274HTlC009224
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 04:17:29 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 466583)
	id C547D41356; Thu,  7 Mar 2024 09:47:28 +0530 (+0530)
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: andersson@kernel.org, konrad.dybcio@linaro.org, broonie@kernel.org,
        robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, manivannan.sadhasivam@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Cc: quic_mdalam@quicinc.com, quic_varada@quicinc.com,
        quic_srichara@quicinc.com
Subject: [PATCH v3 0/5] Add QPIC SPI NAND driver
Date: Thu,  7 Mar 2024 09:47:21 +0530
Message-Id: <20240307041726.1648829-1-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-ORIG-GUID: Nb7AhbZ_HhXF0o7cg6WR4083uJMMIdSB
X-Proofpoint-GUID: Nb7AhbZ_HhXF0o7cg6WR4083uJMMIdSB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_14,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=459
 lowpriorityscore=0 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403070027

v3:
* In this patch series fixes multiple things like
  added clock-name, added _alloc_controller api instead
  of alloc_master, made common apis more generic etc.

* Addressed all the comment from v2 patch series

v2: 
* https://lore.kernel.org/linux-arm-msm/20240215134856.1313239-1-quic_mdalam@quicinc.com/
* In this series of patchs we have added basic working QPIC SPI NAND
  driver with READ, WRITE, ERASE etc functionality

* Addressed all the comments given in RFC [v1] patch
 
v1:
* https://lore.kernel.org/linux-arm-msm/20231031120307.1600689-1-quic_mdalam@quicinc.com/
* Initial set of patches for handling QPIC SPI NAND.

Md Sadre Alam (5):
  spi: dt-bindings: add binding doc for spi-qpic-snand
  drivers: mtd: nand: Add qpic_common API file
  spi: spi-qpic: Add qpic spi nand driver support
  arm64: dts: qcom: ipq9574: Add SPI nand support
  arm64: dts: qcom: ipq9574: Disable eMMC node

 .../bindings/spi/qcom,spi-qpic-snand.yaml     |   83 +
 .../boot/dts/qcom/ipq9574-rdp-common.dtsi     |   43 +
 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts   |    2 +-
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         |   27 +
 drivers/mtd/nand/Makefile                     |    1 +
 drivers/mtd/nand/qpic_common.c                |  789 +++++++++
 drivers/mtd/nand/raw/qcom_nandc.c             | 1440 ++---------------
 drivers/spi/Kconfig                           |    8 +
 drivers/spi/Makefile                          |    1 +
 drivers/spi/spi-qpic-snand.c                  | 1041 ++++++++++++
 include/linux/mtd/nand-qpic-common.h          |  547 +++++++
 11 files changed, 2676 insertions(+), 1306 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml
 create mode 100644 drivers/mtd/nand/qpic_common.c
 create mode 100644 drivers/spi/spi-qpic-snand.c
 create mode 100644 include/linux/mtd/nand-qpic-common.h

-- 
2.34.1


