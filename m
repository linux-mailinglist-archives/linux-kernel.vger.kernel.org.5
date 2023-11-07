Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAD37E3B73
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbjKGMFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjKGMFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:05:33 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843DF10A;
        Tue,  7 Nov 2023 04:05:28 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A78islH002670;
        Tue, 7 Nov 2023 12:05:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=nM3mtK/EJZgTpkb7oMAqPCl09T/2yf37VYR5MnTqyVE=;
 b=dM1K0ijaARkqJLW6/XCrR/P7OJRhyzPuKF/Bd2rksHLOo1otjO7vURax3/3HSXRQjKF4
 0i6/dt3hXVcbTpwKgKqKKKUGcXqByMqHIuZ1f2R4pyMxWE/0TYfADXPFZJMNdb21VkMr
 ZrQ8gHbwb425gZP09D5wGEeLy66bKR3laP0dMHBcgPKgbrOGUEytTxaqX1G9eOPj+Cb4
 EECR5isZQLUeMqFWy/KZmM+cASh69CMTwPfEI//ChUR9kgZIB/5uLKwBEqx1LQxk7YrB
 bcSBuZ4GpVXiNt8PsMkVqFMp49Y0Zi2C5+1Vv/jCXyLOvYUkqf1dCatgANTGg3IxdvAq og== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u6wer3cbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Nov 2023 12:05:24 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A7C5Nam012624
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Nov 2023 12:05:23 GMT
Received: from hu-shazhuss-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 7 Nov 2023 04:05:20 -0800
From:   Shazad Hussain <quic_shazhuss@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <konrad.dybcio@linaro.org>
CC:     Shazad Hussain <quic_shazhuss@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] arm64: dts: qcom: sa8775p-ride: enable pmm8654au_0_pon_resin
Date:   Tue, 7 Nov 2023 17:35:02 +0530
Message-ID: <20231107120503.28917-1-quic_shazhuss@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0lfPR1xQ_MnSWR7YYEg7wHa1sb_HUzYQ
X-Proofpoint-GUID: 0lfPR1xQ_MnSWR7YYEg7wHa1sb_HUzYQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_01,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0 phishscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=564 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311070100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The volume down key is controlled by PMIC via the PON hardware on
sa8775p platform, so enable the same for sa8775p-ride.

Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index 9760bb4b468c..26ad05bd3b3f 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -461,6 +461,11 @@
 			  "ANALOG_PON_OPT";
 };
 
+&pmm8654au_0_pon_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
+};
+
 &pmm8654au_1_gpios {
 	gpio-line-names = "PMIC_C_ID0",
 			  "PMIC_C_ID1",
-- 
2.17.1

