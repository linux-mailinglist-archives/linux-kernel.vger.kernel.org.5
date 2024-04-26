Return-Path: <linux-kernel+bounces-159533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E913E8B2FDF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26D1E1C21B31
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC1C13A89E;
	Fri, 26 Apr 2024 05:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AQYQ8xT1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F251513A3EF;
	Fri, 26 Apr 2024 05:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714110819; cv=none; b=KVSk/jUY1zwOiISevATg8JNFJfRD/8iKkxwlp5m96H+MHWL0vASGRXZV03UmjFeuochLRNHY6ch7GtuOFCw/QFrTH0DGz/gfcLDgY80kcaweLRGXwgqX70BJg/25HxznwEuwF2SqaylXA+4X4Ib7XcgaWlIeXYelSiiBzzYak+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714110819; c=relaxed/simple;
	bh=MCnGY0c3dpitORd+a6OSnBfTRNG9RcfjvF3wfkk+qxM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q8AUqBsarTuGqzHxYdGisJTjtoo2YKJe7xBMO97DAMmyfdKmMRywlmzO7EKceJAsNDS7++5dwFCuAbzXFwqITDXKri/PLo6uob6P1cG7SJmXe6yyP2lDPsfn0udOdUKPGQ6CjixMbtr2a1jvP0F1DSDzOTQDV48qsxbLA2djejE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AQYQ8xT1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43Q5iWfi002491;
	Fri, 26 Apr 2024 05:53:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=qcppdkim1; bh=d57somguSp5P4bbEo03J
	M4yz7plk+g1rTAQTnQFCORU=; b=AQYQ8xT1xmKSoN6JI1znGzaSjfqolQ0FUcrU
	+cHAEantZghnKAuHYcbSXr4tvPZ5jxfxQ2YFmeas8hEE7W6LWB6sV93rG5lPAS5T
	j91Jirsypp9Qk/EAxGDX9s9wQyvbUdnmwgkceZOnF1ERz7Xdl595DRYFPOHthUlm
	xwjDVGGP73Wl6sH3DyPn1T2B97FbNd70ydPR/5w9lZZtJvgh5RYIUuv9MF0y9GC6
	a5xPzGlpE+mIt2rMHrEkJBc/St9p1kIyIVQoptYQMecRyhv14KalWNjm0tx4913x
	3+Mn03m3UzKYHde9V8FU7E8LT/8gw2AZPDuaJYqIuW4rxBTZLQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xr1ne8suw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 05:53:33 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43Q5rT0e002280;
	Fri, 26 Apr 2024 05:53:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3xm6smm8s8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 05:53:29 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43Q5rTLn002260;
	Fri, 26 Apr 2024 05:53:29 GMT
Received: from hu-devc-hyd-u20-c-new.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.147.246.70])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 43Q5rSAt002253
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 05:53:29 +0000
Received: by hu-devc-hyd-u20-c-new.qualcomm.com (Postfix, from userid 3970568)
	id 9CCA220FFA; Fri, 26 Apr 2024 11:23:27 +0530 (+0530)
From: Rohit Agarwal <quic_rohiagar@quicinc.com>
To: andersson@kernel.org, konrad.dybcio@linaro.org,
        manivannan.sadhasivam@linaro.org, jassisinghbrar@gmail.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        lee@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@quicinc.com,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 0/6] Add some devicetree node for SDX75
Date: Fri, 26 Apr 2024 11:23:20 +0530
Message-Id: <20240426055326.3141727-1-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-ORIG-GUID: QyFH59i0u9_X9kuLgzEczXNB8X85v05y
X-Proofpoint-GUID: QyFH59i0u9_X9kuLgzEczXNB8X85v05y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_06,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=855 malwarescore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404260034

Hi,

This series add some basic DT nodes on Qcom's SDX75 SoC that are required
for different subsystems.

Thanks,
Rohit.

Rohit Agarwal (6):
  dt-bindings: mailbox: qcom-ipcc: Document the SDX75 IPCC
  dt-bindings: mfd: qcom,tcsr: Add compatible for SDX75
  dt-bindings: soc: qcom,aoss-qmp: Document the SDX75 AOSS channel
  arm64: dts: qcom: sdx75: Add IPCC node
  arm64: dts: qcom: sdx75: Add TCSR register space
  arm64: dts: qcom: sdx75: Add AOSS node

 .../bindings/mailbox/qcom-ipcc.yaml           |  1 +
 .../devicetree/bindings/mfd/qcom,tcsr.yaml    |  1 +
 .../bindings/soc/qcom/qcom,aoss-qmp.yaml      |  1 +
 arch/arm64/boot/dts/qcom/sdx75.dtsi           | 26 +++++++++++++++++++
 4 files changed, 29 insertions(+)

-- 
2.25.1


