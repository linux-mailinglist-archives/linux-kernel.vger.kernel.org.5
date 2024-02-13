Return-Path: <linux-kernel+bounces-63120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B837852B2C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 480492845BC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4728C22630;
	Tue, 13 Feb 2024 08:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ewD8vTTs"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296AF225A4;
	Tue, 13 Feb 2024 08:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707812875; cv=none; b=CpI8Itg62/HOSb5gBG/TW6cfmec9r9C9fo4UVYiP8vVaI27nDFitiOWxEVlEYZlbI3FTKhu62cYyMNs3fQxFd81E+BSisfnRoilEAgJrbxXtkuXYq3qmGyQaqF2YRghKK4ltvcxumVECji7D4JZCWgRKFFFM0TmDMPUq7/otfyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707812875; c=relaxed/simple;
	bh=5BrtsPcQx+QRTJ3NMzBqp6AJkDSTp2WBQaacQu55MT0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uqXxC+os5ynsUGxgUx/h3x2oJqZYktPRAy3mEkW0lFwqYDtrIpmIpqds0KgUDXs/TMPOIWQ8qK0jD5TuLNMwFglhxBYSn8zxR8rgQssRIxHvxrya0ElFPOncnlEKLmn1qX4/mGXiyjFKja34jTIEXQewE/2LSS/8eldJnzOIUbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ewD8vTTs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41D6oG5j000796;
	Tue, 13 Feb 2024 08:27:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=GZs8MDJ
	oMB0ANV4SJ9D4KZPTcm9muUvls4lZ0YPfw+Y=; b=ewD8vTTshzv4IDBiO6zdK4o
	G1fCqzUiV4Jz2fZrbNy5WZXsb6NqamjAyGhmBmuscEah9En8M1F87aun5/UCHqYp
	cNTRWQf+cpyDpF68/6rb23OO/+YysM9DpuIzhU4uc4F4QTN20K4IIanGbLPt9s9o
	o++WwoSGg5IWiWfeEyvDiJ1PAMaqATC1F5vH4r1AtGnZyD1VQk+p2GNrzBWfph1Q
	PxYK2jnQmeuqM7gCY15Nw2Ks/ICVlqHAFOM3fa3lAd1bVQTbFeKfnGPupN5YOfKQ
	TbAh1ZYEH2DDVXboHeiGEKbXDpN2u87M95169lyVNJrbQheqONlx/T79tzbbhqg=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7gvjjgc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 08:27:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41D8Rbsb013935
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 08:27:37 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 13 Feb 2024 00:27:33 -0800
From: Krishna Kurapati <quic_kriskura@quicinc.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH v2 0/2] Add DT support for Multiport controller on SC8280XP
Date: Tue, 13 Feb 2024 13:57:22 +0530
Message-ID: <20240213082724.1789096-1-quic_kriskura@quicinc.com>
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
X-Proofpoint-GUID: NF6QisKSHEVfhYZEzNmNfrLX7oPI9jwE
X-Proofpoint-ORIG-GUID: NF6QisKSHEVfhYZEzNmNfrLX7oPI9jwE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_04,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=393 adultscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402130065

Series [1] introduces binding and driver support for DWC3 Multiport
controllers. This series adds support for tertiary controller of SC8280
and enabled multiport controller for SA8295P-ADP platform.

Till v13 the DT was pushed along with driver code. Separate the DT changes
from driver update and pushing it as this series.

Changes in v2:
SA8540 Ride related code changes have been dropped and will pushed later
due to unavailability of hardware with either Andrew or me for testing the
gpio hog changes suggested in v1.
Implemented vbus boost regulators as fixed regulators instead of modelling
their enable pins as pinctrl nodes.

Link to v1:
https://lore.kernel.org/all/20240206114745.1388491-1-quic_kriskura@quicinc.com/

[1]: https://lore.kernel.org/all/20240206051825.1038685-1-quic_kriskura@quicinc.com/

Krishna Kurapati (2):
  arm64: dts: qcom: sc8280xp: Add multiport controller node for SC8280
  arm64: dts: qcom: sa8295p: Enable tertiary controller and its 4 USB
    ports

 arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 83 ++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi   | 82 +++++++++++++++++++++++
 2 files changed, 165 insertions(+)

-- 
2.34.1


