Return-Path: <linux-kernel+bounces-49910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D08847147
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 279C9B275DB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AEE47779;
	Fri,  2 Feb 2024 13:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Eq7Sz2Fz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABD31E4A6;
	Fri,  2 Feb 2024 13:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706881039; cv=none; b=Oa+Xo8bcA+8wSMTYXRrI4sjrCfz64pQ3aF7N1AegeVn1dt62pW1NkbZ4mynrKPjOq6kfX/rDt5+WanaXhW63NjiQ9NbJe6RbxbjBSsNdDDeUm+8X76ELmqQ9jXglgKN0Ja9YZXt/SyCZW8Vx1Lim29ERVlmAPKRI7hHnBEruXSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706881039; c=relaxed/simple;
	bh=zPr0j07wzlxYUc4wbPkXJJM/g853nHeIX7XjpjWIotE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XlrBhLmlJ3eLMnysPV8GefoNvwra3mRSoGmC1HuXfwAFYQSJ+gMCXRPnNQmQJMRIpPuPNeVPSy+8dtSqAYkyk8dwZuEuqkFZzWxhGky3ygq58mqctHVENgoz+wcDuOgvLUDLLHiPV2sdM0/4yWwiTcfwoKZhR+BKZBHaTFp3vxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Eq7Sz2Fz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 412C0eYG028446;
	Fri, 2 Feb 2024 13:37:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=qcppdkim1; bh=JyxZZ6KysSj3z8pO1U55
	+GkfvnayjzIgpnHVsrTRDkE=; b=Eq7Sz2Fz6Eqcwo+7IXCsL/cQAcZttSRj9aUq
	1V4WVRtK6+oFAJBlWOYq4hzww4pryj5L7YQ0EMozeSnJlgyz737Ftiq21f3aqZ1g
	tSvmyAviyl1BblMhX6jwlpitiw7dj2Y6LGxoj9r6a9P/Jcvb0OCbpKs2RY6AD+Jc
	eEBVaAbvl+c6wi4dy6Eqh8WoTT34O83MkX0ZdkPdMQW6Baqp46llWw8Ki2UQ0Exb
	IJ5lpamdoX88oOuqcBa6oLCjSIXO1EylIcK5ClIcrj1K6KU/VxmipPoyzk3Phklq
	wsDrzYdGHlbSaDnVf7BZNz1glsU8Epfj1n26CAASftOZHVAg9A==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w1019r68g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 13:37:14 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 412DajZf017958;
	Fri, 2 Feb 2024 13:36:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3vvtwm3wsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 02 Feb 2024 13:36:45 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 412Daj5G017935;
	Fri, 2 Feb 2024 13:36:45 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-wasimn-hyd.qualcomm.com [10.147.242.220])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 412Dajbr017929;
	Fri, 02 Feb 2024 13:36:45 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 3944840)
	id CB09D500945; Fri,  2 Feb 2024 19:06:43 +0530 (+0530)
From: Wasim Nazir <quic_wasimn@quicinc.com>
To: andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@quicinc.com,
        Wasim Nazir <quic_wasimn@quicinc.com>
Subject: [PATCH 0/3] arm64: qcom: add support for QCS8550 RB5gen2 HDK board
Date: Fri,  2 Feb 2024 19:06:35 +0530
Message-ID: <20240202133638.4720-1-quic_wasimn@quicinc.com>
X-Mailer: git-send-email 2.43.0
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
X-Proofpoint-ORIG-GUID: eOtz-nuEMX6Ll-BXgjVS8fwM2kgjSl_3
X-Proofpoint-GUID: eOtz-nuEMX6Ll-BXgjVS8fwM2kgjSl_3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=544 clxscore=1015 adultscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402020100

RB5gen2-HDK is Thundercomm's development platform used for IOT solutions.
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

This series depends on [1].

[1]: https://lore.kernel.org/all/20240119100621.11788-1-quic_tengfan@quicinc.com/


Wasim Nazir (3):
  dt-bindings: arm: qcom: Document rb5gen2-hdk board
  arm64: dts: qcom: Add initial support for rb5gen2 SOM
  arm64: dts: qcom: Add initial support for rb5gen2 HDK board

 .../devicetree/bindings/arm/qcom.yaml         |   9 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/qcs8550-rb5gen2-hdk.dts     | 136 ++++++
 arch/arm64/boot/dts/qcom/qcs8550-rb5gen2.dtsi | 438 ++++++++++++++++++
 4 files changed, 584 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/qcs8550-rb5gen2-hdk.dts
 create mode 100644 arch/arm64/boot/dts/qcom/qcs8550-rb5gen2.dtsi

--
2.43.0


