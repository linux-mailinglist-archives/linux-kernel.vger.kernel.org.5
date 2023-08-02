Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08E876C922
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 11:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbjHBJO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 05:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjHBJOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:14:54 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5275F0;
        Wed,  2 Aug 2023 02:14:53 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3724AYHK008361;
        Wed, 2 Aug 2023 09:14:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=6dNhtgWHf2eSkjW5mjapZqkW+gopiY8ApfUAhMj1HaQ=;
 b=pUx5qFR2g6WbXT16W4ndtMwqUlRX1yJO3YdQ7Luuk/O0OCaLdxjq5CD9l5SuYBCTPDGT
 8AtymUMOkr0lICBK8OyWnSO8W5TmRqvLY9k9+Y6JJPLVwHlAbmp7xFQ0E/M/IIORwDYs
 PpraFjVDS5EyP36/qxJwNJJzWVESmLhN6NkVTBlW1Ea5f1+bM2l+lCigJuYJM/PxfUSI
 mNCajZz9P7AWXTG/H/Yz90KDcO49NHSL8mpsNUj27YPCQTErvQtl4io+5vRFxBV8pdBQ
 ZiJI5Unim6gv7H2E/sYy7uKzJYn1gG5kRMa0LsiLvQ2s50UQ1utaMgf3kL5VwmKgeggc KQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s72gqtdnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 09:14:50 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3729Enmj017801
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Aug 2023 09:14:49 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 2 Aug 2023 02:14:46 -0700
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Komal Bajaj <quic_kbajaj@quicinc.com>
Subject: [PATCH v6 0/6] soc: qcom: llcc: Add support for QDU1000/QRU1000
Date:   Wed, 2 Aug 2023 14:44:22 +0530
Message-ID: <20230802091429.20892-1-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FL49ibzzNEzitUySIQwucfxr63YMJDEB
X-Proofpoint-ORIG-GUID: FL49ibzzNEzitUySIQwucfxr63YMJDEB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_04,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308020082
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

Changes in v6 -
 - Changed variable name from num_cfgs to num_config as suggested by Mukesh.
 - Added a check for default llcc configuration as per suggestion from Mukesh.
 - Updated the commit summary for the third and fifth patch.
 - Fixed alignment in the fourth patch.
 - Used ARRAY_SIZE() to calculate the num_config as per suggested by Konrad.

Changes in v5 -
 - Seperated out the secure qfprom driver changes to a separate series [1].
 - Created a wrapper struct with a pointer to qcom_llcc_config and
   length of array qcom_llcc_config.
 - Added stub function for nvmem_cell_read_u8.
 - Split commit 6/6 in the previous series into two commits.

Changes in v4 -
 - Created a separate driver for reading from secure fuse region as suggested.
 - Added patch for dt-bindings of secure qfprom driver accordingly.
 - Added new properties in the dt-bindings for LLCC.
 - Implemented new logic to read the nvmem cell as suggested by Bjorn.
 - Separating the DT patches from this series as per suggestion.

Changes in v3-
 - Addressed comments from Krzysztof and Mani.
 - Using qfprom to read DDR configuration from feature register.

Changes in v2:
  - Addressing comments from Konrad.

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
 drivers/soc/qcom/llcc-qcom.c                  | 357 +++++++++++++-----
 include/linux/nvmem-consumer.h                |   6 +
 include/linux/soc/qcom/llcc-qcom.h            |   2 +-
 4 files changed, 287 insertions(+), 88 deletions(-)

--
2.41.0

