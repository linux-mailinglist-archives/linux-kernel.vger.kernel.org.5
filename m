Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF037A137A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 04:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjIOCCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 22:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjIOCCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 22:02:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E691AE;
        Thu, 14 Sep 2023 19:02:11 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38F1lw0j000746;
        Fri, 15 Sep 2023 02:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=6jnMxarFbc3pbuWYtBOShNsQn87H8L5UY6WSmh2yF9I=;
 b=bB525QjlHqm6bcBl0h5gW6/LIIHVUitvDAktvX1z8v3llgZUi33Swe7rej9pYAKvUcY/
 0vSXCyq9iNyazv56E5fGOZbY7AdIZlfKjEVWEdla23Y+e+LcFncM742h669BB2iPPMHv
 vdW9iKXdxuLq5jmnNH/VvhGPaE4kC1ECCPhH4UqJSeuYSKu2Dor/YFGvoY9g76+5HAeb
 KPL+kv7e8vF9fHqNdgX0JAcEnGHrNbbQa0OY949CtaQrMVsERBqs4kNgVHGooo2qm9EL
 eq1osMZviqTNJrj6TWdGIkxrMt764TabTb6pXT6kt4h41maT9L6DjoEs+mAcPUrbMYGH 6g== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t4dvrg0s7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 02:02:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38F223AO022075
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 02:02:04 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 14 Sep 2023 19:01:56 -0700
From:   Tengfei Fan <quic_tengfan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <djakov@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_tsoni@quicinc.com>, <quic_shashim@quicinc.com>,
        <quic_kaushalk@quicinc.com>, <quic_tdas@quicinc.com>,
        <quic_tingweiz@quicinc.com>, <quic_aiquny@quicinc.com>,
        <kernel@quicinc.com>, Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH v2 0/2] interconnect: qcom: Add SM4450 interconnect
Date:   Fri, 15 Sep 2023 10:01:27 +0800
Message-ID: <20230915020129.19611-1-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5mVtAShBtkzfptwlrHSe61OL4M4GOo7A
X-Proofpoint-GUID: 5mVtAShBtkzfptwlrHSe61OL4M4GOo7A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_02,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 mlxscore=0 adultscore=0 mlxlogscore=708 malwarescore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150016
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SM4450 interconnect provider driver for support enable uart console.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
This patch series depends on "[PATCH v2 0/4] clk: qcom: Add support for
GCC and RPMHCC on SM4450"
https://lore.kernel.org/linux-arm-msm/20230909123431.1725728-1-quic_ajipan@quicinc.com/

v1 -> v2:
  - remove DISP related paths
  - make compatible and data of of_device_id in one line
  - add clock patch series dependence
  - redo dt_binding_check

previous discussion here:
[1] https://lore.kernel.org/linux-arm-msm/20230908064427.26999-1-quic_tengfan@quicinc.com/

Tengfei Fan (2):
  dt-bindings: interconnect: Add Qualcomm SM4450
  interconnect: qcom: Add SM4450 interconnect provider driver

 .../interconnect/qcom,sm4450-rpmh.yaml        |  133 ++
 drivers/interconnect/qcom/Kconfig             |    9 +
 drivers/interconnect/qcom/Makefile            |    2 +
 drivers/interconnect/qcom/sm4450.c            | 1817 +++++++++++++++++
 drivers/interconnect/qcom/sm4450.h            |  152 ++
 .../dt-bindings/interconnect/qcom,sm4450.h    |  163 ++
 6 files changed, 2276 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm4450-rpmh.yaml
 create mode 100644 drivers/interconnect/qcom/sm4450.c
 create mode 100644 drivers/interconnect/qcom/sm4450.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sm4450.h


base-commit: 98897dc735cf6635f0966f76eb0108354168fb15
-- 
2.17.1

