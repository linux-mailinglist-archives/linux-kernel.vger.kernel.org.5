Return-Path: <linux-kernel+bounces-35648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 427A48394BB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 431D7B21C00
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC3D7F7D7;
	Tue, 23 Jan 2024 16:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AZPeFiH0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7FB47A5C;
	Tue, 23 Jan 2024 16:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027664; cv=none; b=pLtzSzY/h+XFYVHKcNbHZlJ2kyi068uyhuiG2nfu/985RUeUDaohSIRPX3hX+FkuWyBwj9E8WI0eMA/LM9Wajo94z7FBmCcdYW1QE7iKTIBd4nKjF4RRRS5y5y12f0vbrYBvtZD/f7H5E3RWAmmVKFDrsJA/rXt7PtBDmEgHrvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027664; c=relaxed/simple;
	bh=bfhzVn1hP+QZBnypxJ+88hpIKpoq9xX/idRXag47xwU=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=ULpk4ChII745FCikDiGPknQpdbq5dIl1+z1c/cRehN9o8M+38HwOIOIzrHzSJQWHnOX5B1qkhmCTB+kRpwbEQMGzfGTeN6pvklgFilpO3H3KZ9ULZ16glHUZXfGhL90o7zKPef4EEHlehyUksi5LHaMzw9owbIUxJC3hT02XFsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AZPeFiH0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40NEtAdl020663;
	Tue, 23 Jan 2024 16:34:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=mGsEKb/+NbwmVL
	ChAgEgiU/b6/YVRfzxJPwJ1D6l1eQ=; b=AZPeFiH0TTDCgK624g8NfMemWaFLp9
	S1UEXxHMqlnqBbZetrxhlrUDLppvK2y72loaWhbP1WOKX5q3bUHoV+MYdPjVEi9M
	RMPEUev4PJKrFggIOnyFi2R++4otZFQ96epsXgonq9QuZv5vZzf9Bnr/YQ99kdwM
	owGrxCwV+Rk4xEoynMlIIi1gArLH90A/fQ+kwLjvSqnpvwRH/g7AqU3fNQLq8pCZ
	rZ3G7te08/PVz+7O5bVZbXiliTrgaMhFOt6owzZRWfqsjoNGCstyNUd8reS/vyv4
	emjwYpTvsDh1ora3fPAFVvnFqJT70cr1rnpWf3gzWpEFKFGh1vpnRlcA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vt388a1t0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 16:34:18 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40NGYHKF009508
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 16:34:17 GMT
Received: from hu-skakitap-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 23 Jan 2024 08:34:13 -0800
From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Subject: [PATCH 0/3] clk: qcom: gcc-sm8150: Add gcc_parents_0_ao support
Date: Tue, 23 Jan 2024 22:04:06 +0530
Message-ID: <20240123-gcc-ao-support-v1-0-6c18d5310874@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH7qr2UC/x3MMQ6AIAxA0auQzjYBlMWrGAfAil2EgBoTwt0lj
 m/4v0KhzFRgFhUyPVw4nh1qEOAPewZC3rpBSz1JpUcM3qONWO6UYr5wc9YZo8hOu4QepUw7v/9
 wWVv7AO388/xgAAAA
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ajit Pandey
	<quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Jagadeesh Kona" <quic_jkona@quicinc.com>,
        Satya Priya Kakitapalli
	<quic_skakitap@quicinc.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: d2ktCOWIBol5Uv9V6ttD2ehKIFYEKvAh
X-Proofpoint-ORIG-GUID: d2ktCOWIBol5Uv9V6ttD2ehKIFYEKvAh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_09,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=464
 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401230121

Add support for active_only parent data for gcc_parents_0
as some of the clocks under it are crtical and vote on XO
during suspend.

Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
---
Satya Priya Kakitapalli (3):
      dt-bindings: clock: qcom,gcc-sm8150: Add support for bi_tcxo_ao
      clk: qcom: gcc-sm8150: Add gcc_parents_0_ao support
      arm64: dts: qcom: sm8150: Add bi_tcxo_ao support for gcc

 Documentation/devicetree/bindings/clock/qcom,gcc-sm8150.yaml |  6 ++++--
 arch/arm64/boot/dts/qcom/sm8150.dtsi                         |  3 ++-
 drivers/clk/qcom/gcc-sm8150.c                                | 10 ++++++++--
 3 files changed, 14 insertions(+), 5 deletions(-)
---
base-commit: 774551425799cb5bbac94e1768fd69eec4f78dd4
change-id: 20240123-gcc-ao-support-dbab551ea4f0

Best regards,
-- 
Satya Priya Kakitapalli <quic_skakitap@quicinc.com>


