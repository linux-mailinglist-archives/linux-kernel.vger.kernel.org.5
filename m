Return-Path: <linux-kernel+bounces-159937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 596638B3683
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 736B2B22AED
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0CE145336;
	Fri, 26 Apr 2024 11:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="METmOIPG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910C313C9A7;
	Fri, 26 Apr 2024 11:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714130989; cv=none; b=b1cMT6rSTjb+HJ3CVGI1OldBr8TRxWggimd2+RYg6naSOow2iMgvsbbWeqfSVfGkYZKXmgoeYIV9t3bsSI/Edl9svtqtdXaBhZIAo/2TDKm14D4y5viWNIQnOe985bZLiXv/HADzwhGA0Zzk+X7CDnH0debIdj59G5NnB9tIRJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714130989; c=relaxed/simple;
	bh=7uH01oNQfg0uWOj1guEY3yI5YYNX3XHX79FJGcwjXt0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZUS7WsGEA0onDXD8GusOfugQ7NfW9TfrFvzDqzZrsWciKoaZZm7blwntzKDid/kjBWz4HZ8REUZibiKkmPIzG/wlPomlPuB7rI/U3rCSLhPFimrphQ7fK6qnuVfAJHZjgWD5Oor+XdJ8d68XD7AnmaPXJ4pEEvlItMtITLHhze8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=METmOIPG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43QAoBKP013574;
	Fri, 26 Apr 2024 11:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=Wg3YvD6fPxXrEy9zgAjx7T8S8noK1qDhEngP+GsQamE=; b=ME
	TmOIPGw87oZHBi5P+o+4VpLkiNyM/kNmb2CgQmVQTjbxcwITxCiOA1wUv4yGLy6S
	Cu9rXZJM7nED7HJAxZIfslFxI87hh88OWGInsXCEpClsxKejM4cf1xUWc1KPprsW
	5bH9sHEwsl8CBzLP6pj4pheFkGzW+2UX3jRoKhHbAknts9m7PSzk732fUk8ET3n9
	KVMW4ssbN9QgDy+/5AWUli/D5YKW7Z1soB/2cyKwBzhmPs11xGghi6uHiaC0Whs7
	xJwtBl5xrWOeOWph6bSLjeMOasXmO6fGU7wCKOinS7Nr9KK4/rXkefjSOS//BZfq
	Cv8qlw7wwcvFG8+AHTjA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqx03a7p8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 11:29:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43QBTfmN014242
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 11:29:41 GMT
Received: from hu-kaushalk-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 26 Apr 2024 04:29:38 -0700
From: Kaushal Kumar <quic_kaushalk@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Kaushal Kumar <quic_kaushalk@quicinc.com>
Subject: [PATCH] arm64: dts: qcom: sdx75: Add modem SMP2P node
Date: Fri, 26 Apr 2024 16:58:37 +0530
Message-ID: <20240426112837.17478-1-quic_kaushalk@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7j7PoHPOCjwMdsXJk7hWy94m3GkEGtTQ
X-Proofpoint-ORIG-GUID: 7j7PoHPOCjwMdsXJk7hWy94m3GkEGtTQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_12,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 spamscore=0 phishscore=0 mlxlogscore=623 clxscore=1011 adultscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404260076

Add SMP2P node for the SDX75 platform to communicate with the modem.

Signed-off-by: Kaushal Kumar <quic_kaushalk@quicinc.com>
---
This patch is dependent on the series published [1].

[1]: https://lore.kernel.org/all/20240426055326.3141727-1-quic_rohiagar@quicinc.com/

 arch/arm64/boot/dts/qcom/sdx75.dtsi | 35 +++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi b/arch/arm64/boot/dts/qcom/sdx75.dtsi
index 96e3eec57008..536f41f856c8 100644
--- a/arch/arm64/boot/dts/qcom/sdx75.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdx75.dtsi
@@ -406,6 +406,41 @@
 		};
 	};

+	smp2p-modem {
+		compatible = "qcom,smp2p";
+		qcom,smem = <435>, <428>;
+		interrupts-extended = <&ipcc IPCC_CLIENT_MPSS
+					     IPCC_MPROC_SIGNAL_SMP2P
+					     IRQ_TYPE_EDGE_RISING>;
+		mboxes = <&ipcc IPCC_CLIENT_MPSS
+				IPCC_MPROC_SIGNAL_SMP2P>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <1>;
+
+		smp2p_modem_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		smp2p_modem_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		ipa_smp2p_out: ipa-ap-to-modem {
+			qcom,entry-name = "ipa";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		ipa_smp2p_in: ipa-modem-to-ap {
+			qcom,entry-name = "ipa";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
 	smem: qcom,smem {
 		compatible = "qcom,smem";
 		memory-region = <&smem_mem>;
--
2.17.1


