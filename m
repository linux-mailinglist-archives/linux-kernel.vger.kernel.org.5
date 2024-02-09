Return-Path: <linux-kernel+bounces-59127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 498AD84F1A6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 701D81C23B59
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FD5664BF;
	Fri,  9 Feb 2024 08:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hwRfnVRm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A6426AD3;
	Fri,  9 Feb 2024 08:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707468653; cv=none; b=kmGmAju1P64rPQtOhs4nSO7rihMvzmwtPpLVU+evCh/vP/LveXJ+snoyT4w1VT2t01YN5HoBfENGcnk4iwBqaX5G9yyKofLukyw2pGFCJZwpZQupHKffS2i4IbHtilTVY+AcJ6kIfqAqvFJQ0cSrMavp2qmIyZ8OYcY17PJHchk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707468653; c=relaxed/simple;
	bh=IfoIUexxlQySeGMhV5Z1O09ANYkQ0dV1gMA3OgD7BfU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iXAB7lrXm2KR6QEXwAbaIdszD91IKp90oNbObUwM0myJzjTyymhMJCdVJnQFuhKWM8nocNyzFYjYk88uiTrIz0AwHvDggNnaJjEL1robT+crhVwsguJ8Y4NGK4XjNe0W1joTqal6wbXNPYc67I0P3uETCnxzPEZi68iGZRMPKgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hwRfnVRm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4197tcJ7005284;
	Fri, 9 Feb 2024 08:50:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=6ESa758
	O9GnnugI6OMevXdY4QAErNX5ZAA2GAjz0VS0=; b=hwRfnVRmbAS6YRIbAiNMVAO
	CbYyknyNoP1UETs+dp/J9Kiq6UwIVn96NLXGYEL8GMSmUKr7V50lZvNyc17R4586
	EaCfuuX/WS7fvPhkeZM4s+pN/aw+ITlZCphkhra0UhV7FYDY05CJtXZkqrS23oRt
	TbLi9Ur3b/kaKNi6n7Yzzd8NKK1kse+p5eNb7JtmHF8JpI7aea4QKTgiwmjWZeCc
	ntx4Pj+GBMfHy7aBRNTunz7yIQO7SU+ypRNCXA746zoDMScF8xSZzq3sn/sNe8Wc
	maQiynvrSgm5mNCHgUI5q6GBoWzf1/k7kYk/+W+4aCfte874fOJXalcl0kagWgA=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w5ef1rd3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 08:50:37 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4198oask029750
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 9 Feb 2024 08:50:36 GMT
Received: from hu-jsuraj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 9 Feb 2024 00:50:26 -0800
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
Subject: [PATCH net-next  v13 0/2] Ethernet common fault IRQ support
Date: Fri, 9 Feb 2024 14:20:10 +0530
Message-ID: <cover.1707467850.git.quic_jsuraj@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vly8mvkYUDMdMtT3HGRIA-641V9REBon
X-Proofpoint-ORIG-GUID: vly8mvkYUDMdMtT3HGRIA-641V9REBon
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_06,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 clxscore=1011 bulkscore=0 mlxlogscore=981
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402090062

Changes since v13:
- Update correct sender email

Changes since v12:
- Update correct sender email

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

Suraj Jaiswal (2):
  dt-bindings: net: qcom,ethqos: add binding doc for safety IRQ for
    sa8775p
  net: stmmac: Add driver support for common safety IRQ

 .../devicetree/bindings/net/qcom,ethqos.yaml  |  9 ++--
 .../devicetree/bindings/net/snps,dwmac.yaml   |  6 ++-
 drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  3 ++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 41 ++++++++++++++++++-
 .../ethernet/stmicro/stmmac/stmmac_platform.c |  8 ++++
 6 files changed, 61 insertions(+), 7 deletions(-)

-- 
2.25.1


