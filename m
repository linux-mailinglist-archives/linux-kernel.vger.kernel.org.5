Return-Path: <linux-kernel+bounces-6912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E22819F42
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1BE91F28960
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D36525544;
	Wed, 20 Dec 2023 12:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O7oTOMa6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D6924B3B;
	Wed, 20 Dec 2023 12:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BK6Ta8w006990;
	Wed, 20 Dec 2023 12:40:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=iyj4LpG
	BvoGgpOi+FveMNyMIhc0+RW1fr1S9oIwjEcQ=; b=O7oTOMa6i+FaFAIX+OSomj5
	mIaMPImsTh2efCZzbZF/4ou2loJid9iSRHjlYDL0bHwnWRYcGpzvK/OkV4mXxjOJ
	H1UDc956396JtaLdzzb6reXHZKHtrYxXaEe+rdl54zGwerbGleJ8eeUHcr664+DT
	+iwdEmeTO12NXsQfXWVXqyr8lHzbs0u5cST/LaeacjTr/7OEX8DVk97wyN4q9AaF
	O0qYAOfW5pSQlZHNTob7bQ5qVmYkb4tdrD7Bxo/B7QaXtD4dcF7XkyLyqUG9IrlS
	2uarrjwbR+0rG+00OLTV2D0B2YS37NVjyX5hB/BUpR2UYpT+031PdR+QlumnNAg=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v3tmm0tve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 12:40:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BKCeqTJ025927
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 12:40:52 GMT
Received: from hu-jinlmao-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 20 Dec 2023 04:40:51 -0800
From: Mao Jinlong <quic_jinlmao@quicinc.com>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: Mao Jinlong <quic_jinlmao@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tingwei Zhang
	<quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        "Tao
 Zhang" <quic_taozha@quicinc.com>, <coresight@lists.linaro.org>
Subject: [PATCH] arm64: dts: qcom: Add coresight nodes for sm8450
Date: Wed, 20 Dec 2023 04:40:06 -0800
Message-ID: <20231220124009.16816-1-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RXBiNW-WrEXP8iFAaIfIiE_YAnReONDF
X-Proofpoint-ORIG-GUID: RXBiNW-WrEXP8iFAaIfIiE_YAnReONDF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=905 adultscore=1 malwarescore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312200089

Add coresight components on Qualcomm SM8450 Soc. The components include
TMC ETF/ETR, ETE, STM, TPDM, CTI.

Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 742 +++++++++++++++++++++++++++
 1 file changed, 742 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 1783fa78bdbc..112b5a069c94 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -285,6 +285,192 @@ CLUSTER_SLEEP_1: cluster-sleep-1 {
 		};
 	};
 
+	ete0 {
+		compatible = "arm,embedded-trace-extension";
+		cpu = <&CPU0>;
+
+		out-ports {
+			port {
+				ete0_out_funnel_ete: endpoint {
+				remote-endpoint = <&funnel_ete_in_ete0>;
+				};
+			};
+		};
+	};
+
+	ete1 {
+		compatible = "arm,embedded-trace-extension";
+		cpu = <&CPU1>;
+
+		out-ports {
+			port {
+				ete1_out_funnel_ete: endpoint {
+				remote-endpoint = <&funnel_ete_in_ete1>;
+				};
+			};
+		};
+	};
+
+	ete2 {
+		compatible = "arm,embedded-trace-extension";
+		cpu = <&CPU2>;
+
+		out-ports {
+			port {
+				ete2_out_funnel_ete: endpoint {
+				remote-endpoint = <&funnel_ete_in_ete2>;
+				};
+			};
+		};
+	};
+
+	ete3 {
+		compatible = "arm,embedded-trace-extension";
+		cpu = <&CPU3>;
+
+		out-ports {
+			port {
+				ete3_out_funnel_ete: endpoint {
+				remote-endpoint = <&funnel_ete_in_ete3>;
+				};
+			};
+		};
+	};
+
+	ete4 {
+		compatible = "arm,embedded-trace-extension";
+		cpu = <&CPU4>;
+
+		out-ports {
+			port {
+				ete4_out_funnel_ete: endpoint {
+				remote-endpoint = <&funnel_ete_in_ete4>;
+				};
+			};
+		};
+	};
+
+	ete5 {
+		compatible = "arm,embedded-trace-extension";
+		cpu = <&CPU5>;
+
+		out-ports {
+			port {
+				ete5_out_funnel_ete: endpoint {
+				remote-endpoint = <&funnel_ete_in_ete5>;
+				};
+			};
+		};
+	};
+
+	ete6 {
+		compatible = "arm,embedded-trace-extension";
+		cpu = <&CPU6>;
+
+		out-ports {
+			port {
+				ete6_out_funnel_ete: endpoint {
+				remote-endpoint = <&funnel_ete_in_ete6>;
+				};
+			};
+		};
+	};
+
+	ete7 {
+		compatible = "arm,embedded-trace-extension";
+		cpu = <&CPU7>;
+
+		out-ports {
+			port {
+				ete7_out_funnel_ete: endpoint {
+				remote-endpoint = <&funnel_ete_in_ete7>;
+				};
+			};
+		};
+	};
+
+	funnel_ete {
+		compatible = "arm,coresight-static-funnel";
+
+		out-ports {
+			port {
+				funnel_ete_out_funnel_apss: endpoint {
+					remote-endpoint =
+					<&funnel_apss_in_funnel_ete>;
+				};
+			};
+		};
+
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				funnel_ete_in_ete0: endpoint {
+					remote-endpoint =
+					<&ete0_out_funnel_ete>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				funnel_ete_in_ete1: endpoint {
+				remote-endpoint =
+					<&ete1_out_funnel_ete>;
+				};
+			};
+
+			port@2 {
+				reg = <2>;
+				funnel_ete_in_ete2: endpoint {
+				remote-endpoint =
+					<&ete2_out_funnel_ete>;
+				};
+			};
+
+			port@3 {
+				reg = <3>;
+				funnel_ete_in_ete3: endpoint {
+				remote-endpoint =
+					<&ete3_out_funnel_ete>;
+				};
+			};
+
+			port@4 {
+				reg = <4>;
+				funnel_ete_in_ete4: endpoint {
+				remote-endpoint =
+					<&ete4_out_funnel_ete>;
+				};
+			};
+
+			port@5 {
+				reg = <5>;
+				funnel_ete_in_ete5: endpoint {
+					remote-endpoint =
+					<&ete5_out_funnel_ete>;
+				};
+			};
+
+			port@6 {
+				reg = <6>;
+				funnel_ete_in_ete6: endpoint {
+					remote-endpoint =
+					<&ete6_out_funnel_ete>;
+				};
+			};
+
+			port@7 {
+				reg = <7>;
+				funnel_ete_in_ete7: endpoint {
+					remote-endpoint =
+					<&ete7_out_funnel_ete>;
+				};
+			};
+		};
+	};
+
 	firmware {
 		scm: scm {
 			compatible = "qcom,scm-sm8450", "qcom,scm";
@@ -3791,6 +3977,562 @@ data-pins {
 			};
 		};
 
+		stm@10002000 {
+			compatible = "arm,coresight-stm", "arm,primecell";
+			reg = <0x0 0x10002000 0x0 0x1000>,
+				<0x0 0x16280000 0x0 0x180000>;
+			reg-names = "stm-base", "stm-stimulus-base";
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					stm_out_funnel_in0: endpoint {
+						remote-endpoint =
+						<&funnel_in0_in_stm>;
+					};
+				};
+			};
+		};
+
+		funnel@10041000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0x0 0x10041000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@7 {
+					reg = <7>;
+					funnel_in0_in_stm: endpoint {
+						remote-endpoint =
+						<&stm_out_funnel_in0>;
+					};
+				};
+
+			};
+
+			out-ports {
+				port {
+					funnel_in0_out_funnel_qdss: endpoint {
+						remote-endpoint =
+						<&funnel_qdss_in_funnel_in0>;
+					};
+				};
+
+			};
+		};
+
+		funnel@10042000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+
+			reg = <0x0 0x10042000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@4 {
+					reg = <4>;
+					funnel_in1_in_funnel_apss: endpoint {
+						remote-endpoint =
+						<&funnel_apss_out_funnel_in1>;
+					};
+				};
+
+				port@6 {
+					reg = <6>;
+					funnel_in1_in_funnel_dl_center: endpoint {
+						remote-endpoint =
+						<&funnel_dl_center_out_funnel_in1>;
+					};
+				};
+
+			};
+
+			out-ports {
+				port {
+					funnel_in1_out_funnel_qdss: endpoint {
+						remote-endpoint =
+						<&funnel_qdss_in_funnel_in1>;
+					};
+				};
+
+			};
+		};
+
+		funnel@10045000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0x0 0x10045000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					funnel_qdss_in_funnel_in0: endpoint {
+						remote-endpoint =
+						<&funnel_in0_out_funnel_qdss>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					funnel_qdss_in_funnel_in1: endpoint {
+						remote-endpoint =
+						<&funnel_in1_out_funnel_qdss>;
+					};
+				};
+
+			};
+
+			out-ports {
+				port {
+					funnel_qdss_out_funnel_aoss: endpoint {
+						remote-endpoint =
+						<&funnel_aoss_in_funnel_qdss>;
+					};
+				};
+
+			};
+		};
+
+		replicator@10046000 {
+			compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
+			reg = <0x0 0x10046000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			in-ports {
+				port {
+					replicator_qdss_in_replicator_swao: endpoint {
+						remote-endpoint =
+						<&replicator_swao_out_replicator_qdss>;
+					};
+				};
+			};
+
+			out-ports {
+
+				port {
+					replicator_qdss_out_replicator_etr: endpoint {
+						remote-endpoint =
+						<&replicator_etr_in_replicator_qdss>;
+					};
+				};
+			};
+		};
+
+		tmc_etr: tmc@10048000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0x0 0x10048000 0x0 0x1000>;
+
+			iommus = <&apps_smmu 0x0600 0>;
+			arm,buffer-size = <0x10000>;
+
+			arm,scatter-gather;
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			in-ports {
+				port {
+					tmc_etr_in_replicator_etr: endpoint {
+						remote-endpoint =
+						<&replicator_etr_out_tmc_etr>;
+					};
+				};
+			};
+		};
+
+		replicator@1004e000 {
+			compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
+			reg = <0x0 0x1004e000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			in-ports {
+				port {
+					replicator_etr_in_replicator_qdss: endpoint {
+						remote-endpoint =
+						<&replicator_qdss_out_replicator_etr>;
+					};
+				};
+			};
+
+			out-ports {
+
+				port {
+
+					replicator_etr_out_tmc_etr: endpoint {
+						remote-endpoint =
+						<&tmc_etr_in_replicator_etr>;
+					};
+				};
+			};
+		};
+
+		funnel@10b04000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+
+			reg = <0x0 0x10b04000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@6 {
+					reg = <6>;
+					funnel_aoss_in_tpda_aoss: endpoint {
+						remote-endpoint =
+						<&tpda_aoss_out_funnel_aoss>;
+					};
+				};
+
+				port@7 {
+					reg = <7>;
+					funnel_aoss_in_funnel_qdss: endpoint {
+						remote-endpoint =
+						<&funnel_qdss_out_funnel_aoss>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					funnel_aoss_out_tmc_etf: endpoint {
+						remote-endpoint =
+						<&tmc_etf_in_funnel_aoss>;
+					};
+				};
+
+			};
+		};
+
+		tmc@10b05000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0x0 0x10b05000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			in-ports {
+				port {
+					tmc_etf_in_funnel_aoss: endpoint {
+						remote-endpoint =
+						<&funnel_aoss_out_tmc_etf>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					tmc_etf_out_replicator_swao: endpoint {
+						remote-endpoint =
+						<&replicator_swao_in_tmc_etf>;
+					};
+				};
+			};
+		};
+
+		replicator@10b06000 {
+			compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
+			reg = <0x0 0x10b06000 0x0 0x1000>;
+
+			qcom,replicator-loses-context;
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			in-ports {
+				port {
+					replicator_swao_in_tmc_etf: endpoint {
+						remote-endpoint =
+						<&tmc_etf_out_replicator_swao>;
+					};
+				};
+			};
+
+			out-ports {
+
+				port {
+					replicator_swao_out_replicator_qdss: endpoint {
+						remote-endpoint =
+						<&replicator_qdss_in_replicator_swao>;
+					};
+				};
+
+			};
+		};
+
+		tpda@10b08000 {
+			compatible = "qcom,coresight-tpda", "arm,primecell";
+
+			reg = <0x0 0x10b08000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			in-ports {
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					tpda_aoss_in_tpdm_swao_prio_0: endpoint {
+						remote-endpoint =
+						<&tpdm_swao_prio_0_out_tpda_aoss>;
+					};
+				};
+
+				port@4 {
+					reg = <4>;
+					tpda_aoss_in_tpdm_swao: endpoint {
+						remote-endpoint =
+						<&tpdm_swao_out_tpda_aoss>;
+					};
+				};
+
+			};
+
+			out-ports {
+
+				port {
+					tpda_aoss_out_funnel_aoss: endpoint {
+						remote-endpoint =
+						<&funnel_aoss_in_tpda_aoss>;
+					};
+				};
+
+			};
+		};
+
+		tpdm@10b09000 {
+			compatible = "qcom,coresight-tpdm", "arm,primecell";
+			reg = <0x0 0x10b09000 0x0 0x1000>;
+
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					tpdm_swao_prio_0_out_tpda_aoss: endpoint {
+						remote-endpoint =
+						<&tpda_aoss_in_tpdm_swao_prio_0>;
+					};
+				};
+			};
+		};
+
+		tpdm@10b0d000 {
+			compatible = "qcom,coresight-tpdm", "arm,primecell";
+			reg = <0x0 0x10b0d000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					tpdm_swao_out_tpda_aoss: endpoint {
+						remote-endpoint =
+						<&tpda_aoss_in_tpdm_swao>;
+					};
+				};
+			};
+		};
+
+		tpdm@10c28000 {
+			compatible = "qcom,coresight-tpdm", "arm,primecell";
+			reg = <0x0 0x10c28000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					tpdm_dlct_out_tpda_dl_center_26: endpoint {
+						remote-endpoint =
+						<&tpda_dl_center_26_in_tpdm_dlct>;
+					};
+				};
+			};
+		};
+
+		tpdm@10c29000 {
+			compatible = "qcom,coresight-tpdm", "arm,primecell";
+			reg = <0x0 0x10c29000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					tpdm_ipcc_out_tpda_dl_center_27: endpoint {
+						remote-endpoint =
+						<&tpda_dl_center_27_in_tpdm_ipcc>;
+					};
+				};
+			};
+		};
+
+		cti@10c2a000 {
+			compatible = "arm,coresight-cti", "arm,primecell";
+			reg = <0x0 0x10c2a000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+		};
+
+		cti@10c2b000 {
+			compatible = "arm,coresight-cti", "arm,primecell";
+			reg = <0x0 0x10c2b000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+		};
+
+		tpda@10c2e000 {
+			compatible = "qcom,coresight-tpda", "arm,primecell";
+			reg = <0x0 0x10c2e000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			in-ports {
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@1a {
+					reg = <26>;
+					tpda_dl_center_26_in_tpdm_dlct: endpoint {
+						remote-endpoint =
+						<&tpdm_dlct_out_tpda_dl_center_26>;
+					};
+				};
+
+				port@1b {
+					reg = <27>;
+					tpda_dl_center_27_in_tpdm_ipcc: endpoint {
+						remote-endpoint =
+						<&tpdm_ipcc_out_tpda_dl_center_27>;
+					};
+				};
+
+			};
+
+			out-ports {
+
+				port {
+					tpda_dl_center_out_funnel_dl_center: endpoint {
+						remote-endpoint =
+						<&funnel_dl_center_in_tpda_dl_center>;
+					};
+				};
+
+			};
+		};
+
+		funnel@10c2f000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0x0 0x10c2f000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			in-ports {
+
+				port {
+					funnel_dl_center_in_tpda_dl_center: endpoint {
+						remote-endpoint =
+						<&tpda_dl_center_out_funnel_dl_center>;
+					};
+				};
+
+			};
+
+			out-ports {
+				port {
+					funnel_dl_center_out_funnel_in1: endpoint {
+						remote-endpoint =
+						<&funnel_in1_in_funnel_dl_center>;
+					};
+				};
+
+			};
+		};
+
+		funnel@13810000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+
+			reg = <0x0 0x13810000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			in-ports {
+
+				port {
+					funnel_apss_in_funnel_ete: endpoint {
+						remote-endpoint =
+						<&funnel_ete_out_funnel_apss>;
+					};
+				};
+
+			};
+
+			out-ports {
+				port {
+					funnel_apss_out_funnel_in1: endpoint {
+						remote-endpoint =
+						<&funnel_in1_in_funnel_apss>;
+					};
+				};
+
+			};
+		};
+
+		cti@138e0000 {
+			compatible = "arm,coresight-cti", "arm,primecell";
+			reg = <0x0 0x138e0000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+		};
+
+		cti@138f0000 {
+			compatible = "arm,coresight-cti", "arm,primecell";
+			reg = <0x0 0x138f0000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+		};
+
+		cti@13900000 {
+			compatible = "arm,coresight-cti", "arm,primecell";
+			reg = <0x0 0x13900000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+		};
+
 		sram@146aa000 {
 			compatible = "qcom,sm8450-imem", "syscon", "simple-mfd";
 			reg = <0 0x146aa000 0 0x1000>;
-- 
2.41.0


