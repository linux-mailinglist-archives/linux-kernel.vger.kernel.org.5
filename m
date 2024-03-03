Return-Path: <linux-kernel+bounces-89834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936FB86F640
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 17:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B33F286644
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DED86E5F5;
	Sun,  3 Mar 2024 16:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Pn0c+Q8C"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F2B6CDD0;
	Sun,  3 Mar 2024 16:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709484842; cv=none; b=JQjZk9pR3ghvlCvPv9tXvCMwWFQurzmXjBzKpyhcSYzefPAAWj0lXMpyZ5BkXk5AEFdysmTzEmBeJRkQKexVBi74kPWdMZsBNtj0D1pfBpajkaW12WgMOaoEIAucX6cj+oyS8GIG83i5qoKvxA2x9ohXetovCRvddWVpXN0j390=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709484842; c=relaxed/simple;
	bh=8/N3Gj/spOfs2EbuZOmnJeG8C8ghAtLIJC4ToDT4m/E=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=dZO6PjXR/sIa/djk1ubmt01GJM/JRrQv5QWev0lgO2M8eLk5QdAJKbhYRSX3YWzbA+jOo1jUFhcz1W32FQ2thFvrp1Zg+F/4lWUAcStu0R2MKKIVHcPGB3rxbSfxd1GAskZb9ijdCFfH6FybVACvKewZVFf+iMC/b9b7GfRdEV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Pn0c+Q8C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 423Gj1Tj017497;
	Sun, 3 Mar 2024 16:53:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=rccwHKYFw9S2p6
	opaRP+v7Xv/6svp09OmqdR1WCeQ/w=; b=Pn0c+Q8Cmpl2FoXXybBK9e5iURJ6AW
	BEIcNv3TTLPcLibSo8O2SyRcccsWWn66aSCJ4BOeFvM2woLH8V20AFReEPBjTWcm
	Tde57r7aj4gSeNm1NCum2SS2bCjfPoD3qoff5gwziIhTCjJv12KwLbUIiDhzMrIy
	IxQMR+Frh1xfZ7cSj+0ZgiXOTUhuhzZbecSASWoH1KPiIihvZNj9j/tBd8H4jpHH
	n0x8evhKR+MvDEsTMNIvj0v/DgOuDlaCnx8z4u4UALKHp6I5CzvbU/yjtzCEGDUA
	Qhtmf7ztiypGveB4Lk2R1hYCfCT7yQ4MhmbABirvtVwfM/c9U6v6C0UA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wmsqnr6k5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 03 Mar 2024 16:53:40 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 423GrdDA013819
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 3 Mar 2024 16:53:39 GMT
Received: from robotics-lnxbld034.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 3 Mar 2024 08:53:35 -0800
From: Canfeng Zhuang <quic_czhuang@quicinc.com>
Subject: [PATCH 0/2] QCOM QRC device driver
Date: Mon, 4 Mar 2024 00:53:15 +0800
Message-ID: <20240304-qcom_qrc-v1-0-2a709f95fd61@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP2q5GUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYwMT3cLk/Nz4wqJkXXNzi2SLtMQUCwsTMyWg8oKi1LTMCrBR0bG1tQC
 LBqRWWgAAAA==
To: Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic
	<dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad
 Dybcio" <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Canfeng Zhuang <quic_czhuang@quicinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709484815; l=1352;
 i=quic_czhuang@quicinc.com; s=20240304; h=from:subject:message-id;
 bh=8/N3Gj/spOfs2EbuZOmnJeG8C8ghAtLIJC4ToDT4m/E=;
 b=VJeE976QrWPSx4VkYIK+WjoQKC8ponp4kTRDEr0jKd8Pv5B/vsQQXFsbRv6awXI7frGpSAPmY
 CkK4Xp+C+H/AW+qXC0/hQWh5iXnlSbcxuQNjLHAfY1qNp11USYpS4sy
X-Developer-Key: i=quic_czhuang@quicinc.com; a=ed25519;
 pk=uQG1beHWTQyrSp8QCUkEKgprUZM/nlhxKMyUwzilvXQ=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RLqjTnXT-Omxjwj4uXcF-z2ab9_5jVwD
X-Proofpoint-GUID: RLqjTnXT-Omxjwj4uXcF-z2ab9_5jVwD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-03_07,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0
 impostorscore=0 clxscore=1011 mlxlogscore=868 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403030142

QCOM QRC device driver is used for Robotic SDK MCU

[commit]misc: qualcomm: QRC driver for Robotic SDK MCU
This commit is used to enable robotic controller device driver.
QRC Driver support functions:
- Read data from serial device port.
- Write data to serial device port.
- Pin control reset robotic controller.

[commit]dt-bindings: misc: merge qcom,qrc
This commit is used to support qcom qrc devicetree binding.

Signed-off-by: Canfeng Zhuang <quic_czhuang@quicinc.com>
---
Canfeng Zhuang (2):
      misc: qualcomm: QRC driver for Robotic SDK MCU
      dt-bindings: misc: merge qcom,qrc

 .../devicetree/bindings/misc/qcom,qrc.yaml         |  32 ++
 drivers/misc/Kconfig                               |   1 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/qrc/Kconfig                           |  16 +
 drivers/misc/qrc/Makefile                          |   6 +
 drivers/misc/qrc/qrc_core.c                        | 336 ++++++++++++++++++++
 drivers/misc/qrc/qrc_core.h                        | 143 +++++++++
 drivers/misc/qrc/qrc_uart.c                        | 345 +++++++++++++++++++++
 8 files changed, 880 insertions(+)
---
base-commit: 805d849d7c3cc1f38efefd48b2480d62b7b5dcb7
change-id: 20240304-qcom_qrc-778c8fad8846

Best regards,
-- 
Canfeng Zhuang <quic_czhuang@quicinc.com>


