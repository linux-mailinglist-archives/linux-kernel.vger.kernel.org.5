Return-Path: <linux-kernel+bounces-44537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A609842369
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107191F223FC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CD667A05;
	Tue, 30 Jan 2024 11:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dqqhvpKP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE966773D;
	Tue, 30 Jan 2024 11:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706614901; cv=none; b=okUnjq9XOU8nGtpNduIifpXV0Jj1qxR/LqTA2/xo+EN13wZEdub3zfPIYHQp/+gKNHIl3sSqyxTx8DsCpnZTl1SfvevQR4lmSDyZIBofHFkX02fSUkMaZ1SMOjhAWDSmBVf7yt3ucww3lH1oet6+ZK7cSOmEZcFfTBaeOsBiG0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706614901; c=relaxed/simple;
	bh=wtaYERKeZ+R3zZ5LbShluTuKloWqQszXmSmTGmoqJ+s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YroSO2oogz7FRTRUUjvgg1N8ygG9YQUZMaP7xheQbiE8hFu9SqFF/phX2H71g4qumpk+VuSjai4SzNqAGdjkVrkXJgrKS09fHhV0CR4R7oT+iQj4pZ5jJRnCaWz3awOYanDTppqyBniDNqaPmlGb1CrJxNEz8u+h3KaYv+s2mQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dqqhvpKP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40UATr6s004965;
	Tue, 30 Jan 2024 11:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=7JXWKUW
	1E7ghsDEkZBFGU82nOmZDcd1ujbS6PKH4dAo=; b=dqqhvpKPByheIOn5/3brqza
	036hCTwaaXUAUimIBnacYUIOAPRl6yQzoYdacFPXzCdaOv1PRGuVJuws2jBjbN8M
	x2P4ecLHR2uILcNWP0TDT/dZk5i8YKS3QMFfQwI2rZ/sVJ3JpjmzEV88lUK6JEZI
	dc5o3X1SKxEf11lWJPVpdviM++YEUMnepcOU87W/bGvF/zHqXzN7EuPWIWRUXHo1
	xKTK2fszzErPzfFlAE5T0oB/lMax+b7jczOQdTCuTwiWw7FI8INhl3VY3Farr9c0
	8gVm+zN1sbeeW4Xu3LHQ4LNF/8ruY/AoHDEGMxc1K27VDncvh4vJuiquObZZoIA=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxydh04q5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 11:41:25 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40UBfOlp026860
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 11:41:24 GMT
Received: from hu-jsuraj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 30 Jan 2024 03:41:15 -0800
From: Suraj Jaiswal <quic_jsuraj@quicinc.com>
To: <quic_jsuraj@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma
	<bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "Jose
 Abreu" <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>, <netdev@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Prasad Sodagudi
	<psodagud@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>, Rob Herring
	<robh@kernel.org>
CC: <kernel@quicinc.com>
Subject: [PATCH net-next v11 0/3] Ethernet common fault IRQ support
Date: Tue, 30 Jan 2024 17:10:59 +0530
Message-ID: <20240130114102.4116046-1-quic_jsuraj@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OehGOF_7sBrjiKHDrYBag1puAl0vBB3V
X-Proofpoint-GUID: OehGOF_7sBrjiKHDrYBag1puAl0vBB3V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_05,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxscore=0 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=892
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300085

From: Suraj Jaiswal <jsuraj@codeaurora.org>

Changes since v11:
- Update debug message print

Changes since v10:
- Update commit message

Changes since v9:
- prevent race condition of safety IRQ handling

Changes since v8:
- Use shared IRQ for sfty
- update error message

Changes since v7:
- Add support of common sfty irq on stmmac_request_irq_multi_msi.
- Remove uncecessary blank line.

Changes since v6:
- use name sfty_irq instead of safety_common_irq.

Changes since v5:
- Add description of ECC, DPP, FSM

Changes since v4:
- Fix DT_CHECKER warning
- use name safety for the IRQ.

Suraj Jaiswal (3):
  dt-bindings: net: qcom,ethqos: add binding doc for safety IRQ for
    sa8775p
  arm64: dts: qcom: sa8775p: enable safety IRQ
  net: stmmac: Add driver support for common safety IRQ

 .../devicetree/bindings/net/qcom,ethqos.yaml  |  9 ++--
 .../devicetree/bindings/net/snps,dwmac.yaml   |  6 ++-
 arch/arm64/boot/dts/qcom/sa8775p.dtsi         | 10 +++--
 drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  3 ++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 41 ++++++++++++++++++-
 .../ethernet/stmicro/stmmac/stmmac_platform.c |  8 ++++
 7 files changed, 67 insertions(+), 11 deletions(-)

-- 
2.25.1


