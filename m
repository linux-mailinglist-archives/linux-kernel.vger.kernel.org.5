Return-Path: <linux-kernel+bounces-90069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F8C86F9C3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 06:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81905B20C56
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 05:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8A3DF71;
	Mon,  4 Mar 2024 05:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YASgxzAg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE6FC2C4;
	Mon,  4 Mar 2024 05:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709531637; cv=none; b=R44ksZnbivZVXW0lt65OaSc+987oQRjYHxVuiCRZ8DRSRvU8mn5h/I8Ni5lWWw8UBN8RuJh4DyVEwLtlLtBlTbCofoTertsw/1YVbGqopBK4myqB5Gja46490Ok8/g3s3sMaaGDKQpfSI1Vw0HyUPtyb7CPm4CZ/mFN6J5Im1N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709531637; c=relaxed/simple;
	bh=cXWBfwlxuJAj0jL1HGZC8UaFHLZLGppJZ2bEL+NQH14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ICvO2D3tcD+oxgeVnCGNlSZ5UeWyomtB7gOJ4wUG0N5yj6lexjBFZsiz8s2A2w+RQ9agrZVSm3c5TpuHXgvf+u+jAArK8n7uDH82KE8O4OZWP8by0uX5grqnttiDLiUhy/vaC+DPP427Hkjmeigqi5JENxc4FcIaaesNHYNAToM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YASgxzAg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4245MLU4001401;
	Mon, 4 Mar 2024 05:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=qcppdkim1; bh=6Sqwzv7znzrMn4zPRPwy
	YvyWRsFApx42RpVbA3uYIic=; b=YASgxzAgDqoUIh2dagzOjQmS7LDO31BSHmFk
	V8H6NHuKqjW6Js7kIUZMYpFKD5TorhbbzvJm6BI0llNEeN9ajtcC/DcyfCjP8Yk8
	7h+BPEbAz1zGP+sL97hg45Dihwczq/ceyeEXQ3oGIVOEBUmK5HviH1p6gVw9num4
	L1tB+eiCezcxeKUpCN1wmVPoOtns1x38Mghu0e0Ua4SIUcUFUivDr5cANkPFGFQx
	Ke//0JIwWE+JNGRRtHAivevBod8nttZ9HO52qCvsGXKT+ByONFLaW2519Pv88LXh
	8sRdfd11yUeeXLKD/WOebbNQZ+QDA0hG1ki3Wb/D15fpCaidKg==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wmsqnry6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 05:53:51 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 4245rlv7007938;
	Mon, 4 Mar 2024 05:53:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3wkw6kx58x-1;
	Mon, 04 Mar 2024 05:53:47 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4245rltD007916;
	Mon, 4 Mar 2024 05:53:47 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-wasimn-hyd.qualcomm.com [10.147.242.220])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 4245rknC007912;
	Mon, 04 Mar 2024 05:53:47 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 3944840)
	id C01A3500946; Mon,  4 Mar 2024 11:23:45 +0530 (+0530)
From: Wasim Nazir <quic_wasimn@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@quicinc.com,
        Wasim Nazir <quic_wasimn@quicinc.com>
Subject: [PATCH v2 0/3] arm64: qcom: add support for QCS8550 RB5gen2 board
Date: Mon,  4 Mar 2024 11:23:30 +0530
Message-ID: <20240304055333.15952-1-quic_wasimn@quicinc.com>
X-Mailer: git-send-email 2.43.2
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
X-Proofpoint-ORIG-GUID: 7iqzTHfaEl-XyOmsswgDNfbuJzi6ep5r
X-Proofpoint-GUID: 7iqzTHfaEl-XyOmsswgDNfbuJzi6ep5r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_02,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=787 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403040042

RB5gen2 is Thundercomm's development platform used for IOT solutions.
It is based on Rb5gen2-SOM which is using QCOM's QCS8550 SoC.

On-board components:
- Qualcomm QCS8550 SoC
- LPDDR5, 12 GiB
- UFS3.1, 128 GiB
- USB3.1

On-board PMICs:
- PM8550VS
- PM8550VE
- PM8550
- PM8550BH
- PMK8550
- PMR735D
- PM8010

v1 -> v2:
 - Update board name from qcs8550-rb5gen2-hdk to qcs8550-rb5gen2.
 - Update SOM name to qcs8550-rb5gen2-som.
 - Remove qcm8550 from board definition.
 - Update DT files wrt board/som name changes.
 - Link to v1 [2].

This series depends on [1].

[1]: https://lore.kernel.org/all/20240301134113.14423-1-quic_tengfan@quicinc.com/
[2]: https://lore.kernel.org/all/20240202133638.4720-1-quic_wasimn@quicinc.com/

Wasim Nazir (3):
  dt-bindings: arm: qcom: Document rb5gen2 board
  arm64: dts: qcom: Add initial support for rb5gen2 SOM
  arm64: dts: qcom: Add initial support for rb5gen2 board

 .../devicetree/bindings/arm/qcom.yaml         |   7 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/qcs8550-rb5gen2-som.dtsi    | 438 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/qcs8550-rb5gen2.dts  | 136 ++++++
 4 files changed, 582 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/qcs8550-rb5gen2-som.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/qcs8550-rb5gen2.dts

--
2.43.2


