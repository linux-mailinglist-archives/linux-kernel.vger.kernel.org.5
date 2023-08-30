Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8125678DF22
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243935AbjH3TVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243418AbjH3K51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:57:27 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BE8CC2;
        Wed, 30 Aug 2023 03:57:23 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37U95bmK022981;
        Wed, 30 Aug 2023 10:57:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=6GD1xS8oDkRT5pT/QjB2C1IGjUTHDeA0RHlXdPU68kM=;
 b=ny7nYT2bLEXA15d8DpbwXP0f+7N3GzOblNcPJWYtNqcDEgf8KNbnpIYHj319Ppo6ru7a
 V9o0CYPxU+wEAVE8xjEaobvHiOayUFJQNCJdzk7cF9CbmLj1uXI3tgwrxxYz2fwU4+T3
 7sLOYb7m7tTXa8fNvfsZzwjurz7oGOYD//R112MOMV9OnJ+wlBIor7dvk0z58oLkTASb
 39x0/HffjcbTNmSabwSTvLMwhVplMiUHqrYqng3somgB6RgNt7XpBn/6gwmu9VvjFuiy
 gqt36+FGw3RGQapSjxjH0s4HgJ9m33vEJB2MQY4i01qCYEPej9oCG9BnceF21NYgHgxX Wg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ssv0y0xnb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 10:57:17 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37UAvGlo011164
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 10:57:16 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 30 Aug 2023 03:57:12 -0700
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>, <bryan.odonoghue@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Komal Bajaj <quic_kbajaj@quicinc.com>
Subject: [PATCH v8 0/6] soc: qcom: llcc: Add support for QDU1000/QRU1000
Date:   Wed, 30 Aug 2023 16:26:48 +0530
Message-ID: <20230830105654.28057-1-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: h3hRhHv8URRYBu_qtAaV45GkIWbZxVm1
X-Proofpoint-ORIG-GUID: h3hRhHv8URRYBu_qtAaV45GkIWbZxVm1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300102
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series does the following -
 * Refactor LLCC driver to support multiple configuration
 * Add stub function for nvmem_cell_read_u8
 * Add support for multi channel DDR configuration in LLCC
 * Add LLCC support for the Qualcomm QDU1000 and QRU1000 SoCs

Changes in v8 -
 - Removed macro DEF_NUM_CFG as suggested by Bryan.
 - Rebased on top of linux-next/master.
 - Link to v7: https://lore.kernel.org/all/20230810061140.15608-1-quic_kbajaj@quicinc.com/

Changes in v7 -
 - Changed the macro name as suggested by Mukesh.
 - Added NULL check for llcc cfgs as suggested by Mukesh.
 - Updated the num_config for qdu1000 to use ARRAY_SIZE().
 - Link to v6: https://lore.kernel.org/lkml/20230802091429.20892-1-quic_kbajaj@quicinc.com/

Changes in v6 -
 - Changed variable name from num_cfgs to num_config as suggested by Mukesh.
 - Added a check for default llcc configuration as per suggestion from Mukesh.
 - Updated the commit summary for the third and fifth patch.
 - Fixed alignment in the fourth patch.
 - Used ARRAY_SIZE() to calculate the num_config as per suggested by Konrad.
 - Link to v5: https://lore.kernel.org/lkml/20230724084155.8682-1-quic_kbajaj@quicinc.com/

Changes in v5 -
 - Separated out the secure qfprom driver changes to a separate series [1].
 - Created a wrapper struct with a pointer to qcom_llcc_config and
   length of array qcom_llcc_config.
 - Added stub function for nvmem_cell_read_u8.
 - Split commit 6/6 in the previous series into two commits.
 - Link to v4: https://lore.kernel.org/lkml/20230623141806.13388-1-quic_kbajaj@quicinc.com/

Changes in v4 -
 - Created a separate driver for reading from secure fuse region as suggested.
 - Added patch for dt-bindings of secure qfprom driver accordingly.
 - Added new properties in the dt-bindings for LLCC.
 - Implemented new logic to read the nvmem cell as suggested by Bjorn.
 - Separating the DT patches from this series as per suggestion.
 - Link to v3: https://lore.kernel.org/lkml/20230512122134.24339-1-quic_kbajaj@quicinc.com/

Changes in v3 -
 - Addressed comments from Krzysztof and Mani.
 - Using qfprom to read DDR configuration from feature register.
 - Link to v2: https://lore.kernel.org/lkml/20230313124040.9463-1-quic_kbajaj@quicinc.com/

Changes in v2:
  - Addressing comments from Konrad.
  - Link to v1: https://lore.kernel.org/lkml/20230313071325.21605-1-quic_kbajaj@quicinc.com/

[1] https://lore.kernel.org/linux-arm-msm/20230724082946.7441-1-quic_kbajaj@quicinc.com/


Komal Bajaj (6):
  dt-bindings: cache: qcom,llcc: Add LLCC compatible for QDU1000/QRU1000
  soc: qcom: llcc: Refactor llcc driver to support multiple
    configuration
  nvmem: core: Add stub for nvmem_cell_read_u8
  soc: qcom: Add LLCC support for multi channel DDR
  soc: qcom: llcc: Updating the macro name
  soc: qcom: llcc: Add QDU1000 and QRU1000 LLCC support

 .../devicetree/bindings/cache/qcom,llcc.yaml  |  10 +
 drivers/soc/qcom/llcc-qcom.c                  | 361 +++++++++++++-----
 include/linux/nvmem-consumer.h                |   6 +
 include/linux/soc/qcom/llcc-qcom.h            |   2 +-
 4 files changed, 291 insertions(+), 88 deletions(-)

--
2.41.0

