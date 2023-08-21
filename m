Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94EA7827F4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjHULaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbjHULap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:30:45 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508C8103;
        Mon, 21 Aug 2023 04:30:37 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LAKAq4020737;
        Mon, 21 Aug 2023 11:30:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=1f24q5oqCisOmjILlKbN9OqRliXfzdWDypVAL97mFvk=;
 b=WmEmjUijmWbp0+8fsoQtGy81CVklB5MJklaDsldVxx/wLl9VEicyujX6zUW4q+MooDJ4
 DGKXim0PDTN/36Dpg/6bsP46YSs8Iq21EM2M3VixEA+d34echdmP92qWXLMacFuUHCBz
 bfQ5t4+73nBCgawNz5VtIo9dE3Akp1k0VWbB2nnBFBwx1bq3nMacHrJglzmMQnKjhRnb
 zp4RTOJEIHETPj25m3jcvlz8ni4ugJaM6Dc2UuzH1t1hwGDnIQR6ImtkeKbxDI6suZWE
 Mdh9Zue7o3kpcla5mdJupOhFOxtnVCi9sSvEmqOo3oTWY71bi0yeiDUaZSorNsv+4Xwq Cw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sjmpxkrq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 11:30:27 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37LBUQiv029427
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 11:30:26 GMT
Received: from hu-priyjain-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Mon, 21 Aug 2023 04:30:20 -0700
From:   Priyansh Jain <quic_priyjain@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_manafm@quicinc.com>, <quic_priyjain@quicinc.com>
Subject: [PATCH 2/2] arm64: dts: qcom: Enable tsens and thermal for sa8775p SoC
Date:   Mon, 21 Aug 2023 16:59:28 +0530
Message-ID: <20230821112928.19284-3-quic_priyjain@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230821112928.19284-1-quic_priyjain@quicinc.com>
References: <20230821112928.19284-1-quic_priyjain@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Adlfl4VrDKqXyYoEWuIQI4s0ulRyrDnP
X-Proofpoint-ORIG-GUID: Adlfl4VrDKqXyYoEWuIQI4s0ulRyrDnP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_01,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 mlxlogscore=668 clxscore=1015 mlxscore=0
 adultscore=0 spamscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308210106
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tsens and thermal devicetree node for sa8775p SoC.

Signed-off-by: Priyansh Jain <quic_priyjain@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 1096 +++++++++++++++++++++++++
 1 file changed, 1096 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index b130136acffe..b9c622b3bf7e 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -2306,6 +2306,1102 @@
 
 			#freq-domain-cells = <1>;
 		};
+
+		tsens0: thermal-sensor@c222000 {
+			compatible = "qcom,sa8775p-tsens", "qcom,tsens-v2";
+			reg = <0x0C263000 0x1ff>,  /* TM */
+				<0x0C222000 0x1ff>; /* SROT */
+			#qcom,sensors = <12>;
+			interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 508 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow","critical";
+			#thermal-sensor-cells = <1>;
+		};
+
+		tsens1: thermal-sensor@c223000 {
+			compatible = "qcom,sa8775p-tsens", "qcom,tsens-v2";
+			reg = <0x0C265000 0x1ff>,  /* TM */
+				<0x0C223000 0x1ff>; /* SROT */
+			#qcom,sensors = <12>;
+			interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 509 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow","critical";
+			#thermal-sensor-cells = <1>;
+		};
+
+		tsens2: thermal-sensor@c224000 {
+			compatible = "qcom,sa8775p-tsens", "qcom,tsens-v2";
+			reg = <0x0C251000 0x1ff>,  /* TM */
+				<0x0C224000 0x1ff>; /* SROT */
+			#qcom,sensors = <13>;
+			interrupts = <GIC_SPI 572 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 609 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow","critical";
+			#thermal-sensor-cells = <1>;
+		};
+
+		tsens3: thermal-sensor@c225000 {
+			compatible = "qcom,sa8775p-tsens", "qcom,tsens-v2";
+			reg = <0x0C252000 0x1ff>,  /* TM */
+				<0x0C225000 0x1ff>; /* SROT */
+			#qcom,sensors = <13>;
+			interrupts = <GIC_SPI 573 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 610 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow","critical";
+			#thermal-sensor-cells = <1>;
+		};
+
+		thermal_zones: thermal-zones {
+			aoss-0-thermal {
+				polling-delay-passive = <0>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens0 0>;
+
+				trips {
+					aoss0_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					aoss0_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			cpu-0-0-0-thermal {
+				polling-delay-passive = <10>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens0 1>;
+
+				trips {
+					cpu000_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					cpu000_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			cpu-0-1-0-thermal {
+				polling-delay-passive = <10>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens0 2>;
+
+				trips {
+					cpu010_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					cpu010_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			cpu-0-2-0-thermal {
+				polling-delay-passive = <10>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens0 3>;
+
+				trips {
+					cpu020_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					cpu020_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			cpu-0-3-0-thermal {
+				polling-delay-passive = <10>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens0 4>;
+
+				trips {
+					cpu030_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					cpu030_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			gpuss-0-thermal {
+				polling-delay-passive = <10>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens0 5>;
+
+				trips {
+					gpuss0_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					gpuss0_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			gpuss-1-thermal {
+				polling-delay-passive = <10>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens0 6>;
+
+				trips {
+					gpuss1_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					gpuss1_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			gpuss-2-thermal {
+				polling-delay-passive = <10>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens0 7>;
+
+				trips {
+					gpuss2_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					gpuss2_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			audio-thermal {
+				polling-delay-passive = <0>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens0 8>;
+
+				trips {
+					audio_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					audio_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			camss-0-thermal {
+				polling-delay-passive = <0>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens0 9>;
+
+				trips {
+					camss0_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					camss0_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			pcie-0-thermal {
+				polling-delay-passive = <0>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens0 10>;
+
+				trips {
+					pcie0_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					pcie0_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			cpuss-0-0-thermal {
+				polling-delay-passive = <0>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens0 11>;
+
+				trips {
+					cpuss00_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					cpuss00_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			aoss-1-thermal {
+				polling-delay-passive = <0>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens1 0>;
+
+				trips {
+					aoss1_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					aoss1_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			cpu-0-0-1-thermal {
+				polling-delay-passive = <10>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens1 1>;
+
+				trips {
+					cpu001_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					cpu001_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			cpu-0-1-1-thermal {
+				polling-delay-passive = <10>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens1 2>;
+
+				trips {
+					cpu011_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					cpu011_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			cpu-0-2-1-thermal {
+				polling-delay-passive = <10>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens1 3>;
+
+				trips {
+					cpu021_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					cpu021_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			cpu-0-3-1-thermal {
+				polling-delay-passive = <10>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens1 4>;
+
+				trips {
+					cpu031_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					cpu031_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			gpuss-3-thermal {
+				polling-delay-passive = <10>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens1 5>;
+
+				trips {
+					gpuss3_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					gpuss3_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			gpuss-4-thermal {
+				polling-delay-passive = <10>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens1 6>;
+
+				trips {
+					gpuss4_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					gpuss4_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			gpuss-5-thermal {
+				polling-delay-passive = <10>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens1 7>;
+
+				trips {
+					gpuss5_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					gpuss5_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			video-thermal {
+				polling-delay-passive = <0>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens1 8>;
+
+				trips {
+					video_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					video_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			camss-1-thermal {
+				polling-delay-passive = <0>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens1 9>;
+
+				trips {
+					camss1_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					camss1_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			pcie-1-thermal {
+				polling-delay-passive = <0>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens1 10>;
+
+				trips {
+					pcie1_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					pcie1_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			cpuss-0-1-thermal {
+				polling-delay-passive = <0>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens1 11>;
+
+				trips {
+					cpuss01_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					cpuss01_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			aoss-2-thermal {
+				polling-delay-passive = <0>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens2 0>;
+
+				trips {
+					aoss2_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					aoss2_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			cpu-1-0-0-thermal {
+				polling-delay-passive = <10>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens2 1>;
+
+				trips {
+					cpu100_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					cpu100_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			cpu-1-1-0-thermal {
+				polling-delay-passive = <10>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens2 2>;
+
+				trips {
+					cpu110_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					cpu110_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			cpu-1-2-0-thermal {
+				polling-delay-passive = <10>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens2 3>;
+
+				trips {
+					cpu120_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					cpu120_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			cpu-1-3-0-thermal {
+				polling-delay-passive = <10>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens2 4>;
+
+				trips {
+					cpu130_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					cpu130_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			nsp-0-0-0-thermal {
+				polling-delay-passive = <10>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens2 5>;
+
+				trips {
+					nsp000_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					nsp000_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			nsp-0-1-0-thermal {
+				polling-delay-passive = <10>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens2 6>;
+
+				trips {
+					nsp010_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					nsp010_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			nsp-0-2-0-thermal {
+				polling-delay-passive = <10>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens2 7>;
+
+				trips {
+					nsp020_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					nsp020_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			nsp-1-0-0-thermal {
+				polling-delay-passive = <10>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens2 8>;
+
+				trips {
+					nsp100_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					nsp100_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			nsp-1-1-0-thermal {
+				polling-delay-passive = <10>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens2 9>;
+
+				trips {
+					nsp110_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					nsp110_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			nsp-1-2-0-thermal {
+				polling-delay-passive = <10>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens2 10>;
+
+				trips {
+					nsp120_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					nsp120_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			ddrss-0-thermal {
+				polling-delay-passive = <0>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens2 11>;
+
+				trips {
+					ddrss0_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					ddrss0_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			cpuss-1-0-thermal {
+				polling-delay-passive = <0>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens2 12>;
+
+				trips {
+					cpuss10_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					cpuss10_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			aoss-3-thermal {
+				polling-delay-passive = <0>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens3 0>;
+
+				trips {
+					aoss3_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					aoss3_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			cpu-1-0-1-thermal {
+				polling-delay-passive = <10>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens3 1>;
+
+				trips {
+					cpu101_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					cpu101_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			cpu-1-1-1-thermal {
+				polling-delay-passive = <10>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens3 2>;
+
+				trips {
+					cpu111_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					cpu111_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			cpu-1-2-1-thermal {
+				polling-delay-passive = <10>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens3 3>;
+
+				trips {
+					cpu121_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					cpu121_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			cpu-1-3-1-thermal {
+				polling-delay-passive = <10>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens3 4>;
+
+				trips {
+					cpu131_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					cpu131_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			nsp-0-0-1-thermal {
+				polling-delay-passive = <10>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens3 5>;
+
+				trips {
+					nsp001_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					nsp001_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			nsp-0-1-1-thermal {
+				polling-delay-passive = <10>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens3 6>;
+
+				trips {
+					nsp011_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					nsp011_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			nsp-0-2-1-thermal {
+				polling-delay-passive = <10>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens3 7>;
+
+				trips {
+					nsp021_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					nsp021_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			nsp-1-0-1-thermal {
+				polling-delay-passive = <10>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens3 8>;
+
+				trips {
+					nsp101_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					nsp101_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			nsp-1-1-1-thermal {
+				polling-delay-passive = <10>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens3 9>;
+
+				trips {
+					nsp111_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					nsp111_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			nsp-1-2-1-thermal {
+				polling-delay-passive = <10>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens3 10>;
+
+				trips {
+					nsp121_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					nsp121_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			ddrss-1-thermal {
+				polling-delay-passive = <0>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens3 11>;
+
+				trips {
+					ddrss1_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					ddrss1_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+
+			cpuss-1-1-thermal {
+				polling-delay-passive = <0>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&tsens3 12>;
+
+				trips {
+					cpuss11_alert0: trip-point0 {
+						temperature = <105000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+
+					cpuss11_alert1: trip-point1 {
+						temperature = <115000>;
+						hysteresis = <5000>;
+						type = "passive";
+					};
+				};
+			};
+		};
 	};
 
 	arch_timer: timer {
-- 
2.17.1

