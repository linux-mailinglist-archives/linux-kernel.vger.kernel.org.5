Return-Path: <linux-kernel+bounces-98801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6668A877FA4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 223D1281F69
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB60F3C699;
	Mon, 11 Mar 2024 12:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="N7Y5hjW7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD6D3BB4D;
	Mon, 11 Mar 2024 12:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710158967; cv=none; b=k8+VOwZI46H5aTUndtlu8C6TxtRmbDEuU/hvpj+67B5dc4PkMaqWmoDVnRm53ywzEg8SgzC1ciqV+OZJEdY0Wpt7Cogm+TNZFzpD55ruAXK/PKqNv68LfJU2SIVnv/fge8i6R+F4UWNGeqyn8TEG144T+eZJ8cWVPEKq8gDX9/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710158967; c=relaxed/simple;
	bh=x9v2GWeFlfIHp0JNmuyrqOBpLdPgK6vBD+t0jhwe8J8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A1CxdSuwfQ1KgQNycRHlbfnvBtaDotTqtJ8yUmKZYCDcSnPA5UsX2/oc73LCtf0Cjb+9iuMuaRN5x8JR0WWV51h3ObCJsuzRh/sB81quvJNtGCEiFAImQrMO74PjkDVvFZmgbtTFeW+4Agl6QQyGnk8G0RM7vdhYur1OPhuYDQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=N7Y5hjW7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42B9hX9Q010458;
	Mon, 11 Mar 2024 12:09:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=13iRbuA
	zEN4/rqqqSsQriIM4KVRkwG/g8NSKHL4QHq4=; b=N7Y5hjW7WndvoOoRjdjHvYH
	vOHb6asCgREcCEXLq7U/XBPYyPV3VybqFIhgzsy+Chm2pvi+GpDLYaSDjRsIIZiR
	gJ9AtdyiBEWRzLvsBI/xpLJkbQSDG4hNGjNmGhV3PTzVU2KL7P4ht8VZOHnbUGIN
	QoioYOu9ziQPGw6XcCQI+jZe9BkIqzcMY9peUB6iFPei/LEv//rzwO+xgU040kK7
	UD+mIVJp0rw+6c6+QbyqRjm3aMhRSz/BpbyKgWgQyHDVDL2VKXxW0m22tsK9mVjM
	vTuBv2D7cn0GDVEZFaIYTkn8wosQTPFx3tqx9fDi6zAjX9ZQqetVmOI1nfdIJgg=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wsv208vms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 12:09:21 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42BC9Kux015880
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 12:09:20 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Mar 2024 05:09:17 -0700
From: Komal Bajaj <quic_kbajaj@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Komal Bajaj <quic_kbajaj@quicinc.com>
Subject: [PATCH 0/3] Add devicetree support of USB for QDU/QRU1000
Date: Mon, 11 Mar 2024 17:38:56 +0530
Message-ID: <20240311120859.18489-1-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.42.0
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
X-Proofpoint-GUID: 0eBu9HwON2s7TZz9RMQyRtcoa-p9CeFI
X-Proofpoint-ORIG-GUID: 0eBu9HwON2s7TZz9RMQyRtcoa-p9CeFI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=2 priorityscore=1501 mlxscore=2
 impostorscore=0 bulkscore=0 mlxlogscore=168 spamscore=2 adultscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403110091

This series adds devicetree nodes to support interconnects and usb for qdu/qru1000.
This is based on previously sent driver series[1].
[1]
https://lore.kernel.org/linux-arm-msm/20240311120215.16845-1-quic_kbajaj@quicinc.com/

Komal Bajaj (3):
  arm64: dts: qcom: qdu1000: Add USB3 and PHY support
  arm64: dts: qcom: qdu1000-idp: enable USB nodes
  arm64: dts: qcom: qru1000-idp: enable USB nodes

 arch/arm64/boot/dts/qcom/qdu1000-idp.dts |  24 +++++
 arch/arm64/boot/dts/qcom/qdu1000.dtsi    | 119 +++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/qru1000-idp.dts |  24 +++++
 3 files changed, 167 insertions(+)

--
2.42.0


