Return-Path: <linux-kernel+bounces-35649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A152F8394BF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27A92B225B5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AEC7FBA2;
	Tue, 23 Jan 2024 16:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="glfyhxMp"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646AA7F7F2;
	Tue, 23 Jan 2024 16:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027668; cv=none; b=daYc++zKYIXSL2MFxRp6f9pE901eS8hc1vhC0PNSdB6d7cnm7VQ4VmzafN8vTrsFKqMWRKPet5l1jRr3w3FaDyHlAq7OqY4hOhK6xDo5UrXYQSf7mExxJfRX/vlfWLoFWi58r3OyqCZEd+Ff+QaOUikPgjY2d5d9u1J+x1eblhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027668; c=relaxed/simple;
	bh=KxN756DeJsfc6YQ6TJ7W5IqUjfslmNr7er9kVgHeBWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=CEubGiZH7R5H5YxJpNiFdYu/thaCs7MjG2OcyQ3WMsq1sywgp96u0wScVZsMjCubP8A/77XEPIh/JgBy5wTvns+7QmGhd4jsZA4H/gT7OUI2XD5uFouq7pNYg03brV65f5iWu3xMO+y79YPcKagev/6ERJo5rmvXCFVKb7pPyRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=glfyhxMp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40NFHBKR032667;
	Tue, 23 Jan 2024 16:34:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=L9nBsqcN1Oeng0YIoxdyXgUf7YDDIJZxAgl2Q7Hd+4k
	=; b=glfyhxMpMw0Anl2LBXImjuGc3sqkyyc2D5MbIEMPKLnf6prXI1XQ7OEGJP/
	v57PSZcnfBL/c8s7BmSC0upqZvY6wkUASODPxa0Tqt8mRSf1+HXrNHB+M1UileAH
	1dweFgJhtz7hod6pIDu684RUuc6Cu37klLx5SDysSye/YiCB9pZVYlYnfuPbTsKD
	nbUeexR5DXKaNoTID7uXObWDISUwP83P+TyXQb/VkwpHu5BlZ2tQ4kl7HPmxjNqL
	w/MgBqbncP/3e0HBN01SP+axVnvxtEonTd0R/VC2H4FRjcfTcck+VJgZiCWQ/dk3
	ZFnqlWByss+ByiVKTsG44sLCSbQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vt388a1t6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 16:34:23 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40NGYMVc022882
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 16:34:22 GMT
Received: from hu-skakitap-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 23 Jan 2024 08:34:18 -0800
From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Date: Tue, 23 Jan 2024 22:04:07 +0530
Subject: [PATCH 1/3] dt-bindings: clock: qcom,gcc-sm8150: Add support for
 bi_tcxo_ao
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240123-gcc-ao-support-v1-1-6c18d5310874@quicinc.com>
References: <20240123-gcc-ao-support-v1-0-6c18d5310874@quicinc.com>
In-Reply-To: <20240123-gcc-ao-support-v1-0-6c18d5310874@quicinc.com>
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
X-Proofpoint-GUID: -d4FLvqLdrFjj8EwY_SEMzWzZowBDmjT
X-Proofpoint-ORIG-GUID: -d4FLvqLdrFjj8EwY_SEMzWzZowBDmjT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_09,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=871
 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1011 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401230121

Add support for bi_tcxo_ao, this allows to put an active only vote on
the critical clocks.

Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
---
 Documentation/devicetree/bindings/clock/qcom,gcc-sm8150.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sm8150.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sm8150.yaml
index 58ccb7df847c..17e29e9bbc11 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-sm8150.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sm8150.yaml
@@ -23,11 +23,13 @@ properties:
   clocks:
     items:
       - description: Board XO source
+      - description: Board XO active only source
       - description: Sleep clock source
 
   clock-names:
     items:
       - const: bi_tcxo
+      - const: bi_tcxo_ao
       - const: sleep_clk
 
 required:
@@ -46,9 +48,9 @@ examples:
     clock-controller@100000 {
       compatible = "qcom,gcc-sm8150";
       reg = <0x00100000 0x1f0000>;
-      clocks = <&rpmhcc RPMH_CXO_CLK>,
+      clocks = <&rpmhcc RPMH_CXO_CLK>, <&rpmhcc RPMH_CXO_CLK_A>,
                <&sleep_clk>;
-      clock-names = "bi_tcxo", "sleep_clk";
+      clock-names = "bi_tcxo", "bi_tcxo_ao", "sleep_clk";
       #clock-cells = <1>;
       #reset-cells = <1>;
       #power-domain-cells = <1>;

-- 
2.25.1


