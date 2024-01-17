Return-Path: <linux-kernel+bounces-29284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FA1830C1E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60D68B23D27
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C2024A0E;
	Wed, 17 Jan 2024 17:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="c2311ITY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80908249F9;
	Wed, 17 Jan 2024 17:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705512960; cv=none; b=neJeqyDOSrwYbhLOcbgXQMudurv8++ut/f+PXugEn8xpiW7LfYG4MBkMhZGV/xaV7BMp3hMdaaGLjV3j6IUuFihRqWbqf5YiIwLKPU4p1IunkPhSiOs+sDN4h0T9+4B7u+WPV8IrCZIDyMkYI0YqhTJ1skhl2vO0iIMIKhye5I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705512960; c=relaxed/simple;
	bh=kawY1lLCz2aCx2qqQ8gP7y9X6nAMC4JCu0MdlhV8NpQ=;
	h=Received:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=i50duzHuAI21M7v8rsnliVcgOUnT1S3/KphoV9soFIiVaI5OOfw8YP7WBQcyKgfzVN0nOnb/RjhxymXCrSMZucIdREuXK+de880soOHAzRhZFC8+GI2RSZmkc0PMq1ZqoLDTUWS0bPwOFYSbQUBSoEw5IdM1lODEp2LCoYv65l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=c2311ITY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40HDK62b029941;
	Wed, 17 Jan 2024 17:35:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=kGxrLeKhAxjSlJWiYSB8dyPIF3yEHkPfJ/KCGZ5FuGU=; b=c2
	311ITYgqphCgccEBDyllS/xPOEgVlL9JeOW4Z5crP4zqsXQKRPHIvLK1XCZQYeX0
	yV8BzGF5eMHZenjGI2jtyW+wrKxKhMlqUFlNnL7cMQnckYjgrkhiB7BwIr7gtN6S
	0dLVwab1I67Gczys0eKlEb5kSRPUhpGzdFhqInaguIpLhfcqpYoWZhbQPrZbvF8V
	upQsHImgcwrngoMs1t01F3XfHXdvgll/7MgLf0LSQJtC+x4K25c0zno1n3V7OSbd
	u4IKwcLLjwyDKM5kCF2R7B8hs8T+I8LlzXLtIKrDF/kiNR3gbdj70QOz8v+EWx/o
	I8z5JoIOIl0O8dFrrnsw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vp4ak21em-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 17:35:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40HHZrsd015858
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 17:35:53 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 09:35:48 -0800
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jassisinghbrar@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_rgottimu@quicinc.com>,
        <quic_kshivnan@quicinc.com>, <quic_sibis@quicinc.com>,
        <conor+dt@kernel.org>
Subject: [RFC 7/7] arm64: dts: qcom: x1e80100: Enable LLCC/DDR dvfs
Date: Wed, 17 Jan 2024 23:04:58 +0530
Message-ID: <20240117173458.2312669-8-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240117173458.2312669-1-quic_sibis@quicinc.com>
References: <20240117173458.2312669-1-quic_sibis@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Ux-GjvOXFqndpwqTxF0gfFpY0edXZbC2
X-Proofpoint-GUID: Ux-GjvOXFqndpwqTxF0gfFpY0edXZbC2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_10,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxlogscore=556 mlxscore=0 impostorscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401170127

Enable LLCC/DDR dvfs through the Qualcomm's SCMI vendor protocol.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 48 ++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 6856a206f7fc..3dc6f32fbb4c 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -329,6 +329,54 @@ scmi_dvfs: protocol@13 {
 				reg = <0x13>;
 				#clock-cells = <1>;
 			};
+
+			scmi_vendor: protocol@80 {
+				reg = <0x80>;
+
+				memlat {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					memory@0 {
+						reg = <0x0>; /* Memory Type DDR */
+						freq-table-khz = <200000 4224000>;
+
+						monitor-0 {
+							qcom,cpulist = <&CPU0 &CPU1 &CPU2 &CPU3 &CPU4 &CPU5 &CPU6 &CPU7 &CPU8 &CPU9 &CPU10 &CPU11>;
+							qcom,cpufreq-memfreq-tbl = < 999000 547000 >,
+										   < 1440000 768000 >,
+										   < 1671000 1555000 >,
+										   < 2189000 2092000 >,
+										   < 2156000 3187000 >,
+										   < 3860000 4224000 >;
+						};
+
+						monitor-1 {
+							qcom,compute-mon;
+							qcom,cpulist = <&CPU0 &CPU1 &CPU2 &CPU3 &CPU4 &CPU5 &CPU6 &CPU7 &CPU8 &CPU9 &CPU10 &CPU11>;
+							qcom,cpufreq-memfreq-tbl = < 1440000 200000 >,
+										   < 2189000 768000 >,
+										   < 2156000 1555000 >,
+										   < 3860000 2092000 >;
+						};
+					};
+
+					memory@1 {
+						reg = <0x1>; /* Memory Type LLCC */
+						freq-table-khz = <300000 1067000>;
+
+						monitor-0 {
+							qcom,cpulist = <&CPU0 &CPU1 &CPU2 &CPU3 &CPU4 &CPU5 &CPU6 &CPU7 &CPU8 &CPU9 &CPU10 &CPU11>;
+							qcom,cpufreq-memfreq-tbl = < 999000 300000 >,
+										   < 1440000 466000 >,
+										   < 1671000 600000 >,
+										   < 2189000 806000 >,
+										   < 2156000 933000 >,
+										   < 3860000 1066000 >;
+						};
+					};
+				};
+			};
 		};
 	};
 
-- 
2.34.1


