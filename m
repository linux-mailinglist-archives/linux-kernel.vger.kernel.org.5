Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2471777008
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 08:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbjHJGMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 02:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbjHJGMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 02:12:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BAA1704;
        Wed,  9 Aug 2023 23:12:08 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37A5RghO018215;
        Thu, 10 Aug 2023 06:12:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=ivjs0RgVDCAq46FdFyRRuW6DlopFL5lGEQGZdoxAPrc=;
 b=VO3rK8KlII2NJSXct0HKksQ+3xZMfNAwd/J6AXQH2HHLfzDggOkql24A3BKxkmVUBohp
 I1+Zjr5A1WJNRwKqWvAPS1Jbe9cA0dk8P8NhpGfWxnhYFUreJK8J08xGpJ86Zq5yltJY
 IkfL0nSv1HoiJv6YcmiOnqsudvQ0vh0WYD3G9zXx5p8S7PUBBtAIKZ3pmEetHAvhbU0Y
 gSHCSLa1Q77A5SOXF8e2dw3VAiNJajGsbhwsWT9LOFtge+GFCNI4cZPBmh27TJ1eROyj
 EI/x5yepaZqLPnU9dMjG5bAl2X+4RASYOjpucO+GPpVczNv3g3hu7KiEy0XpIHewbT3F mg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sc1ny2yne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 06:12:00 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37A6C03g022037
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 06:12:00 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 9 Aug 2023 23:11:56 -0700
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Komal Bajaj <quic_kbajaj@quicinc.com>
Subject: [PATCH 0/6] soc: qcom: llcc: Add support for QDU1000/QRU1000
Date:   Thu, 10 Aug 2023 11:41:34 +0530
Message-ID: <20230810061140.15608-1-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QwbCeHzHojJljBtO7uqoqUQjzbjZYlWS
X-Proofpoint-ORIG-GUID: QwbCeHzHojJljBtO7uqoqUQjzbjZYlWS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_05,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308100051
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
 drivers/soc/qcom/llcc-qcom.c                  | 363 +++++++++++++-----
 include/linux/nvmem-consumer.h                |   6 +
 include/linux/soc/qcom/llcc-qcom.h            |   2 +-
 4 files changed, 293 insertions(+), 88 deletions(-)

--
2.41.0

