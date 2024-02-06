Return-Path: <linux-kernel+bounces-54832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4345784B435
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F390C28860A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F51134CDD;
	Tue,  6 Feb 2024 11:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TN+CvUFl"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41FE134CCF;
	Tue,  6 Feb 2024 11:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707220087; cv=none; b=nYnD4/aBoN+IXtrNGrFxaI986LWFIn/2rYtW22mzTLRVg8ahWU15oCLgMY8JqVT+nFEv9JoAmsNQu8fozQyn+2fkFyLPjfr44C6cNGbHiAuyIfrMoBqvHIxOG/Y991uhMwGZY+R8Z28PqVtRC4NtWwMA4zggclXKczDslvgmnsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707220087; c=relaxed/simple;
	bh=G1dDs/9WsNKUIZnIOL647TVbY+D68jj0YN44/q2g2u8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bhDIL7fjzO8NdvIegzIEGBIYjW0y4yzmlGITwiP8cbmTOM5mnD8EvRnmkBgR9qdmFtc4m2p09EO3yuEHCCPUyUfWm9tyhuroHOBMJ6ANzmbG8hiz2zFJAgmh/i6IoV3KSjJ/3Q/ybfQ33BLMhkSOG+3MlYxdCDxyFuJs+FtwtJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TN+CvUFl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4166bqKm015018;
	Tue, 6 Feb 2024 11:48:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=52Qa1Bq
	L4bQ5LnlYJ/8i2kpS256hYNChle2ib8AJ5u8=; b=TN+CvUFlYnXGKgu8mlOhFMS
	Va4eTgPmf6lLeUh+Webd0jz13UH+a7IBeN5YhcD1q838n4hblu+IZ5RVZR3hDL08
	4UA0YVswQU/sPT7qIETsssU5ITAvOdD/73P8hyZc3mWoWMeOE1MIxqZq9oMpNjiU
	DinBFCjFiVm84uFIhkiep5UOuR/qcOKTkS2Zi673aZ2eoZmMUE9XS5cZU0bKtS4Y
	r41BYe9TpASSXCj5ovCYaolC9pMBUdaVhcA7g8twqbug4reaZa+auQYuc+uMQ6Oa
	SCQ3imSdnUrgpKT4/2xzwgxJGweM0wSCRMjmAJM1cHEy00UpN/atAZltlsj9QgA=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w3cafry9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 11:48:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 416Bm03p014528
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 Feb 2024 11:48:00 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 6 Feb 2024 03:47:56 -0800
From: Krishna Kurapati <quic_kriskura@quicinc.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH 0/3] Add DT support for Multiport controller on SC8280XP
Date: Tue, 6 Feb 2024 17:17:42 +0530
Message-ID: <20240206114745.1388491-1-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QfXOg5XxQxTGf0LuP3OuexcFf9BpoDDI
X-Proofpoint-GUID: QfXOg5XxQxTGf0LuP3OuexcFf9BpoDDI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=274 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402060083

Series [1] introduces binding and driver support for DWC3 Multiport
controllers. This series adds support for tertiary controller of SC8280
and enabled multiport controller for SA8295P-ADP/ SA8540P-RIDE platforms.

Till v13 the DT was pushed along with driver code. Separate the DT changes
from driver update and pushing it as this series.

[1]: https://lore.kernel.org/all/20240206051825.1038685-1-quic_kriskura@quicinc.com/

Andrew Halaney (1):
  arm64: dts: qcom: sa8540-ride: Enable first port of tertiary usb
    controller

Krishna Kurapati (2):
  arm64: dts: qcom: sc8280xp: Add multiport controller node for SC8280
  arm64: dts: qcom: sa8295p: Enable tertiary controller and its 4 USB
    ports

 arch/arm64/boot/dts/qcom/sa8295p-adp.dts  | 49 ++++++++++++++
 arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 21 ++++++
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi    | 82 +++++++++++++++++++++++
 3 files changed, 152 insertions(+)

-- 
2.34.1


