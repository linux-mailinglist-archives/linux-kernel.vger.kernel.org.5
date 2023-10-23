Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246987D2E17
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbjJWJWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbjJWJVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:21:44 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B448810D3;
        Mon, 23 Oct 2023 02:21:40 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39N8Mr5o029770;
        Mon, 23 Oct 2023 09:21:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=4+tRrjJHW/bnHCSG3tKfhqziZi7X03Kxepqnry+DFSc=;
 b=e7H46TRXMqYfDXMEDU99U/Hs/0InS3KfetgoRNVQ73E2F5WiwgDfwBF/PX0Hk0I3AiT8
 lqAHp/oFVej6Pqmf3hRojCyo0Q/AICK87vphBShjdKXp9AKGAatYaaazFKDgt+HEqdSY
 D0UZbWomDm+H5V5l7Nw7fLpYien3UQnmck7pjC5EK7wgC7jke9g92kbPS0ZhmdenLr4b
 NyiOsOQala9wpSHakQG0KeypnIhGfFdxPX+jdtrr8mnfd+WKvOOk3CWsZZuuS6HeInlb
 edxJGNbJvcKQeUSjwapycjk9I7iqfrcYI0YjGmps17bLVBDiW39/fKxCuEUv+ytFzfbJ Lw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tv6873krx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 09:21:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39N9LZYg018595
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 09:21:36 GMT
Received: from zhenhuah-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 23 Oct 2023 02:21:30 -0700
From:   Zhenhua Huang <quic_zhenhuah@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        <quic_tingweiz@quicinc.com>,
        Zhenhua Huang <quic_zhenhuah@quicinc.com>
Subject: [PATCH v1 5/5] arm64: dts: qcom: sm8250: Add memory dump node
Date:   Mon, 23 Oct 2023 17:20:57 +0800
Message-ID: <1698052857-6918-6-git-send-email-quic_zhenhuah@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1698052857-6918-1-git-send-email-quic_zhenhuah@quicinc.com>
References: <1698052857-6918-1-git-send-email-quic_zhenhuah@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KE3nraj1n_KaN-1mmnFlERsTbk5orANf
X-Proofpoint-ORIG-GUID: KE3nraj1n_KaN-1mmnFlERsTbk5orANf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_06,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=744 impostorscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310230080
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device node for memory dump on sm8250. Usage of memory dump
is to populate configuration in reserved memory, allowing
firmware to do the dump accordingly.

Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index a4e58ad..d379524 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -674,6 +674,11 @@
 		reg = <0x0 0x80000000 0x0 0x0>;
 	};
 
+	mem-dump {
+		compatible = "qcom,mem-dump";
+		memory-region = <&dump_mem>;
+	};
+
 	pmu {
 		compatible = "arm,armv8-pmuv3";
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
@@ -851,6 +856,13 @@
 			reg = <0x0 0x8bf00000 0x0 0x4600000>;
 			no-map;
 		};
+
+		dump_mem: mem-dump-region {
+			compatible = "shared-dma-pool";
+			size = <0 0x2800000>;
+			alloc-ranges = <0x0 0x00000000 0x0 0xffffffff>;
+			reusable;
+		};
 	};
 
 	smem {
@@ -5424,6 +5436,25 @@
 			};
 		};
 
+		sram@146bf000 {
+			compatible = "qcom,sm8250-imem", "syscon", "simple-mfd";
+			reg = <0 0x146bf000 0 0x1000>;
+			ranges = <0 0 0x146bf000 0x1000>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			mem-dump-table@10 {
+			    compatible = "qcom,qcom-imem-mem-dump-table";
+			    reg = <0x10 0x8>;
+			};
+
+			mem-dump-table-size@724 {
+				compatible = "qcom,qcom-imem-mem-dump-table-size";
+				reg = <0x724 0x8>;
+			};
+		};
+
 		apps_smmu: iommu@15000000 {
 			compatible = "qcom,sm8250-smmu-500", "qcom,smmu-500", "arm,mmu-500";
 			reg = <0 0x15000000 0 0x100000>;
-- 
2.7.4

