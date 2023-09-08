Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F9A798277
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 08:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239059AbjIHGkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 02:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbjIHGkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 02:40:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A6E19AE;
        Thu,  7 Sep 2023 23:39:58 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3885sAZd026937;
        Fri, 8 Sep 2023 06:39:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=wro9AWz/3p2dkhYkvJP1gfJOelyWXLN5gL3qRQHbAqE=;
 b=cqlBjy3wpDiJwlfofoLfCjdujTnJE4PFiGx4eVVPzjkJ9Eoi6Fc7EKpGU9B1KC0qk2MU
 JqtgfvXfUsPzkOPiD7pCWRy/3whTdOznUV4XSH9034XEjhlB3KpIHgbyDVAcYNjkr3nL
 qu9lC6ryy5KRKJiyFhqy/4Oty49mflxPVe+FN2Deox42Dhem6aZrAO6Fm2VJY41dD22G
 IaHPXfAkNTrM2zFfumzysDJ97WPzZBXIo9egxLm4+Vev4gPQVKQ2nNUNSFeaCtq4aI5c
 dbDZFRfJ1B1QmbIfkWKWvftvlLwtowW8ItdQx1uzh3VFPDGcrTc0uRsWkRe6tqmzTIRV lw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sy951ju28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 06:39:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3886dG90001917
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 8 Sep 2023 06:39:16 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 7 Sep 2023 23:39:07 -0700
From:   Tengfei Fan <quic_tengfan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linus.walleij@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <arnd@arndb.de>, <geert+renesas@glider.be>,
        <nfraprado@collabora.com>, <rafal@milecki.pl>, <peng.fan@nxp.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_tsoni@quicinc.com>,
        <quic_shashim@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_tdas@quicinc.com>, <quic_tingweiz@quicinc.com>,
        <quic_aiquny@quicinc.com>, <kernel@quicinc.com>,
        Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH 0/3] pinctl: qcom: Add SM4450 pinctrl driver
Date:   Fri, 8 Sep 2023 14:38:40 +0800
Message-ID: <20230908063843.26835-1-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gknkUBEFCS5J9aIGeaFM6Y70JQRnfEj5
X-Proofpoint-ORIG-GUID: gknkUBEFCS5J9aIGeaFM6Y70JQRnfEj5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=624 priorityscore=1501 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080060
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Sm4450 pinctrl driver for support enable uart console.

Tengfei Fan (3):
  dt-bindings: pinctrl: qcom: Add SM4450 pinctrl
  pinctrl: qcom: Add SM4450 pinctrl driver
  arm64: defconfig: Enable pinctrl for SM4450

 .../bindings/pinctrl/qcom,sm4450-tlmm.yaml    |  129 ++
 arch/arm64/configs/defconfig                  |    1 +
 drivers/pinctrl/qcom/Kconfig.msm              |    8 +
 drivers/pinctrl/qcom/Makefile                 |    1 +
 drivers/pinctrl/qcom/pinctrl-sm4450.c         | 1528 +++++++++++++++++
 5 files changed, 1667 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sm4450.c


base-commit: a47fc304d2b678db1a5d760a7d644dac9b067752
-- 
2.17.1

