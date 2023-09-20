Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5F67A7318
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbjITGs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbjITGsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:48:23 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B518983;
        Tue, 19 Sep 2023 23:48:17 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38K5dbLc011120;
        Wed, 20 Sep 2023 06:48:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=OoTk4EpIvXR/4iXXm5sbZdCaYwGn+wysCrh/xfEvj0k=;
 b=m0TzpoyKFp5CTXGJnWTBkvHorWN4NK9/fLCw432Us6Y1Mfchosq8TWiN6EHYDGCB6lwc
 FyDyxf7VS55WkRI+RBEygj8giuUPnTbeOGPvcEksCqY00XR/gAvYmXuMGRf/ap4bQnk5
 ZFL7MVnaBUh+nZPKrqzuEDYeJfd6O0sHOryu/9AxxbN6KGErQS86olZRChH2vuNsQO+y
 WJacFcfreS/SK7f6R+aJhO/8x54qo3yA3cQc8v6i2WqNPuVG2hJ56vRO3dPByL+eUgJO
 I27gcCxNGg7MUsG1/51o1Jdn47jdQQc7rYWV45ZRswBQWXVyY8J1u7fAFtDJxtlexk/8 WA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t78upjdqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 06:48:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38K6mBUO008083
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 06:48:11 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 19 Sep 2023 23:48:03 -0700
From:   Tengfei Fan <quic_tengfan@quicinc.com>
To:     <andersson@kernel.org>, <agross@kernel.org>,
        <konrad.dybcio@linaro.org>, <linus.walleij@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_tsoni@quicinc.com>, <quic_shashim@quicinc.com>,
        <quic_kaushalk@quicinc.com>, <quic_tdas@quicinc.com>,
        <quic_tingweiz@quicinc.com>, <quic_aiquny@quicinc.com>,
        <quic_ajipan@quicinc.com>, <kernel@quicinc.com>,
        Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH v3 0/2] pinctl: qcom: Add SM4450 pinctrl driver
Date:   Wed, 20 Sep 2023 14:47:37 +0800
Message-ID: <20230920064739.12562-1-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7i9y5HiOYbaQTJgM5t4Ack8U9365Oncc
X-Proofpoint-ORIG-GUID: 7i9y5HiOYbaQTJgM5t4Ack8U9365Oncc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_02,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=768 suspectscore=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309200054
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Sm4450 pinctrl driver for support enable uart console.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
v2 -> v3:
  - update example pieces
  - update gpio pins pattern

v1 -> v2:
  - update right platform name
  - update gpio-reserved-ranges have right maxItems
  - update gpio-line-names have right maxItems
  - add min/maxItems for pins properties
  - redo dt_binding_check check
  - delete reserved gpios setting
  - combine separate pinctrl functions

previous discussion here:
[1] v1: https://lore.kernel.org/linux-arm-msm/20230915015808.18296-1-quic_tengfan@quicinc.com
[2] v2: https://lore.kernel.org/linux-arm-msm/20230908063843.26835-1-quic_tengfan@quicinc.com

Tengfei Fan (2):
  dt-bindings: pinctrl: qcom: Add SM4450 pinctrl
  pinctrl: qcom: Add SM4450 pinctrl driver

 .../bindings/pinctrl/qcom,sm4450-tlmm.yaml    |  151 +++
 drivers/pinctrl/qcom/Kconfig.msm              |    8 +
 drivers/pinctrl/qcom/Makefile                 |    1 +
 drivers/pinctrl/qcom/pinctrl-sm4450.c         | 1013 +++++++++++++++++
 4 files changed, 1173 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sm4450.c


base-commit: dfa449a58323de195773cf928d99db4130702bf7
-- 
2.17.1

