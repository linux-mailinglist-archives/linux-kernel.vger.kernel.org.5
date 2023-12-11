Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A08680C946
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 13:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234848AbjLKMQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbjLKMQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:16:25 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF5ECD;
        Mon, 11 Dec 2023 04:16:30 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BBCEnCI015819;
        Mon, 11 Dec 2023 12:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=qcppdkim1; bh=BO2E/VF
        t3fhOvyueWkwLvFoCtA2VGyW96lSGYw7jWWw=; b=MDymsoQoZuEKGX42GBgqUIe
        0Qlwyw9TgiWCO78blOvPKNteATdS09SbskeDSNWy4bapmtcO5vlC7gCfy5+9EKjo
        mHVdD9fsSgiSVvhwZCCqpAgbnLgAUz9vNsNpTQMrVKo9HfhWAAfVxSSrX3Onc5Nv
        PXIExVygSRyHw/qwh6HHVYRJw+7XFWOBAtrjP6PkS6jlu9oo1Ci+bRuQcoSer9SB
        BXknC7ebWZaLQoQA2RtFemSpHaNPYLqAhalw6HzrtZLhyRO6OW5fRgM1cgveKGHp
        nSoNKptcMJY8SV3V1x+P4QNltk7Rm41nom+9ZCOvGTjJwA9tEWymevYiYVRTAcw=
        =
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ux28s8044-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 12:16:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BBCGPXN011009
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 12:16:25 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Dec 2023 04:16:20 -0800
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH 0/4] Fix USB Interrupts on Qualcomm Platforms
Date:   Mon, 11 Dec 2023 17:46:07 +0530
Message-ID: <20231211121611.6765-1-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _KmZE37y7V9E-jBEzQNwFyNBjcs1psON
X-Proofpoint-GUID: _KmZE37y7V9E-jBEzQNwFyNBjcs1psON
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 mlxlogscore=491 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312110099
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the interrupts mentioned in most of Qualcomm platforms
are partially faulty because of following reasons:

1. hs_phy_irq mentioned on QUSB2 PHY targets is actually qusb2_phy interrupt
2. pwr_event irq is missing for many targets
3. Actual hs_phy_irq is also missing for most of the platforms

The series intends to fix these interrupts as per bindings update done in [1].

Rebased on top of wakeup interrupt fixes by Johan Hovold:
https://patchwork.kernel.org/project/linux-arm-msm/cover/20231120164331.8116-1-johan+linaro@kernel.org/

[1]: https://lore.kernel.org/all/20231211121124.4194-1-quic_kriskura@quicinc.com/

Krishna Kurapati (4):
  arm64: dts: qcom: Fix hs_phy_irq for QUSB2 targets
  arm64: dts: qcom: Fix hs_phy_irq for non-QUSB2 targets
  arm64: dts: qcom: Fix hs_phy_irq for SDM670/SDM845/SM6350
  arm64: dts: qcom: Add missing interrupts for qcs404/ipq5332

 arch/arm/boot/dts/qcom/qcom-sdx55.dtsi | 14 ++++++++-----
 arch/arm/boot/dts/qcom/qcom-sdx65.dtsi | 14 +++++++------
 arch/arm64/boot/dts/qcom/ipq5332.dtsi  |  8 ++++++--
 arch/arm64/boot/dts/qcom/ipq6018.dtsi  | 13 ++++++++++++
 arch/arm64/boot/dts/qcom/ipq8074.dtsi  | 14 +++++++++++++
 arch/arm64/boot/dts/qcom/msm8953.dtsi  |  7 +++++--
 arch/arm64/boot/dts/qcom/msm8996.dtsi  | 17 ++++++++++++----
 arch/arm64/boot/dts/qcom/msm8998.dtsi  |  7 +++++--
 arch/arm64/boot/dts/qcom/qcs404.dtsi   | 16 +++++++++++++++
 arch/arm64/boot/dts/qcom/sa8775p.dtsi  |  6 ++++++
 arch/arm64/boot/dts/qcom/sc7180.dtsi   | 14 ++++++++-----
 arch/arm64/boot/dts/qcom/sc7280.dtsi   | 12 +++++++----
 arch/arm64/boot/dts/qcom/sdm630.dtsi   | 17 ++++++++++++----
 arch/arm64/boot/dts/qcom/sdm670.dtsi   | 14 ++++++++-----
 arch/arm64/boot/dts/qcom/sdm845.dtsi   | 28 +++++++++++++++++---------
 arch/arm64/boot/dts/qcom/sm6115.dtsi   |  9 +++++++--
 arch/arm64/boot/dts/qcom/sm6125.dtsi   |  9 +++++++++
 arch/arm64/boot/dts/qcom/sm6350.dtsi   | 13 +++++++-----
 arch/arm64/boot/dts/qcom/sm6375.dtsi   | 12 ++++++-----
 arch/arm64/boot/dts/qcom/sm8150.dtsi   | 28 +++++++++++++++++---------
 arch/arm64/boot/dts/qcom/sm8250.dtsi   | 28 +++++++++++++++-----------
 arch/arm64/boot/dts/qcom/sm8350.dtsi   | 28 +++++++++++++++-----------
 arch/arm64/boot/dts/qcom/sm8450.dtsi   | 12 ++++++-----
 arch/arm64/boot/dts/qcom/sm8550.dtsi   | 12 ++++++-----
 24 files changed, 247 insertions(+), 105 deletions(-)

-- 
2.42.0

