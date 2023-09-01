Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3237978FABC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345132AbjIAJ1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjIAJ1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:27:24 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F310C0;
        Fri,  1 Sep 2023 02:27:21 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3815m105016623;
        Fri, 1 Sep 2023 09:27:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=Zg2MWfqN7Pcfm2hQ4pZceklCJaXO378OfpNJX9rJTTI=;
 b=oRNEoXPA/x9YMgfW0ZWsamuu6y9OeC2lnlBQ0frWAQ3qcxbAVd11sve+V45Pk3eHaAFY
 RWwBxqZ4B8zRsMBHdYMNQ7LG3qE66Z2tMyF5RJRI6RbTNRD23TK85lNQVGq0V7MpIWDJ
 yf9slpVylvSDfhGPJDwqPIMSYN4y7MGV724NxDzmhqt8SLHyAOgE7SNy31dZFzoMREgx
 57K2DsEcb3lcst0JXtLelWrx0UpFDtor2bggR7wBstIPTnTN+Ev24WK0d1cIlIW2iYD9
 BPcI/vl6IEQP6ZbfKGDQU4120f4Ikk/IFOPWhJVcXUv7E/Z+IKF7wl2qjMNHNT0Sm6Xy 4Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3stpy9bbtj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 09:27:07 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3819R73W012793
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 1 Sep 2023 09:27:07 GMT
Received: from nsekar-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Fri, 1 Sep 2023 02:27:01 -0700
From:   Nitheesh Sekar <quic_nsekar@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
CC:     Nitheesh Sekar <quic_nsekar@quicinc.com>
Subject: [PATCH V3 0/4] Enable IPQ5018 USB2 support
Date:   Fri, 1 Sep 2023 14:56:41 +0530
Message-ID: <20230901092645.20522-1-quic_nsekar@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: B-nw8qZPApb2xiHqbgwGj_Qm_vzJAiB3
X-Proofpoint-GUID: B-nw8qZPApb2xiHqbgwGj_Qm_vzJAiB3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_07,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 mlxlogscore=526 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309010088
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds the relevant phy and controller
DT configurations for enabling USB2 host mode support
on IPQ5018.

Tested with a USB Mass storage device.

Depends on:
Link: https://lore.kernel.org/linux-arm-msm/20230831030503.17100-1-quic_nsekar@quicinc.com/

[V3]:
	Incorporated review comments with respect to
	naming USB related device tree nodes,
	dropped the 0 dealy inits and added the static const
	type for m31_ipq5018_regs.
	Sorted nodes in	board specific device tree file.

[V2]:
	Incorporated review comments regarding splitting the
	series as per subsytem, device tree naming conventions
	and ordereing of the nodes.

Nitheesh Sekar (4):
  dt-bindings: phy: qcom,m31: Add IPQ5018 compatible
  phy: qcom-m31: Add compatible, phy init sequence for IPQ5018
  arm64: dts: qcom: ipq5018: Add USB related nodes
  arm64: dts: qcom: ipq5018: Enable USB

 .../bindings/phy/qcom,ipq5332-usb-hsphy.yaml  |  4 +-
 .../arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts | 12 +++++
 arch/arm64/boot/dts/qcom/ipq5018.dtsi         | 54 +++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-m31.c           | 49 +++++++++++++++++
 4 files changed, 118 insertions(+), 1 deletion(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

