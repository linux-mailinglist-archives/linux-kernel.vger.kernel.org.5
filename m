Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2AA784010
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235455AbjHVLus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbjHVLup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:50:45 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E388E54;
        Tue, 22 Aug 2023 04:50:17 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37MBmJxE018539;
        Tue, 22 Aug 2023 11:49:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=GX9Dx4X238Po93JWCAFM59M9qdZqbmiNK78YWDcEq9E=;
 b=V43kB1SMRw6GlCjfjKE8tSaAsRXkCBLIpd6LkEpDabSkgU7jXkpRYTsOf2ebc40+iDd9
 a86ZqqD7aMgYLVvdDFoYpaBEAZq2NGJxH9phQs70HiWEm4M3Q2FiDmJcjkDzvA5iUILc
 o5wqdZhDQEDTqvLrJrLZuoEuY3yEfp/VpuqxpxHyPvjkb/hmKQ+sVLjI/ZTv1mg8MdHf
 ikozCdjbpYevi/Ty5X7SSASZ3HuS/jILsEzfMDGB4U+WENaKLFgJiXgzfT1pf71yYGyL
 U+Sk0+Jc7CqtdFofbz0lu7ny+ROW1donk/TCaPNVW8bM+azPBY7UjjllJcS1p0yXVfU4 mw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3smdhwhfsy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 11:49:17 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37MBnG2a000974
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 11:49:16 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 22 Aug 2023 04:49:13 -0700
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Komal Bajaj <quic_kbajaj@quicinc.com>
Subject: [PATCH] arm64: dts: qcom: qru1000-idp: add SDHCI for emmc
Date:   Tue, 22 Aug 2023 17:18:50 +0530
Message-ID: <20230822114850.3335-1-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: m9XpiVZyM0kbG7qeIdc8YLFbuORaSi6C
X-Proofpoint-GUID: m9XpiVZyM0kbG7qeIdc8YLFbuORaSi6C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_10,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=683 mlxscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308220089
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sdhci node for emmc in qru1000-idp.

Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qru1000-idp.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qru1000-idp.dts b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
index 2a862c83309e..672e1946eba2 100644
--- a/arch/arm64/boot/dts/qcom/qru1000-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
@@ -460,6 +460,29 @@ tenx_sp_mem: tenx-sp-buffer@800000000 {
 	};
 };

+&sdhc {
+	pinctrl-0 = <&sdc_on_state>;
+	pinctrl-1 = <&sdc_off_state>;
+	pinctrl-names = "default", "sleep";
+
+	cap-mmc-hw-reset;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	mmc-hs400-enhanced-strobe;
+
+	non-removable;
+	no-sd;
+	no-sdio;
+
+	supports-cqe;
+
+	vmmc-supply = <&vreg_l10a_2p95>;
+	vqmmc-supply = <&vreg_l7a_1p8>;
+
+	status = "okay";
+};
+
 &tlmm {
 	gpio-reserved-ranges = <28 2>;
 };
--
2.41.0

