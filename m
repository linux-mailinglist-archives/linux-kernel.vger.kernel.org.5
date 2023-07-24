Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDAF575EDDE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjGXIja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbjGXIjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:39:23 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3806BE4A;
        Mon, 24 Jul 2023 01:39:22 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36O7fPb2003147;
        Mon, 24 Jul 2023 08:39:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=MdybWXpnwON4r3kpNey8g0weJJhEXvuN9YA51hELc+Y=;
 b=Wv6u4f7SfB/CA3ehQnAiC+hh94NUS2QmmzhASuE9mt71Em7/7WVMzaWET0ulpXRusFKk
 0dG3F/q4OP+NhKFu7BTOW0Eedpcef9UD2G1Fc4kwOqVq8evWJCxP28Z8fE4x9fzCMnyA
 54ijMuLe3Mtm6To5jYu5tiPpMAqKpoF6ObeH4czai/4WoYtpRT/sAOutsJlRj0ZRtR/c
 QYmbvJUD5Gc8bz1/WW3Bok+W38Itm6HD4vNKChjpQJKWDhW3d+e6CdrOcesEGh5GIVt7
 fdO6Th76mgV+uJfzgrDXLGcF1z5aBKLt8jN9gd9eD++bDIm2pufcs+RTUmI1H10LYRho Fw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s062xjver-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 08:39:18 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36O8dAIF007692
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 08:39:10 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 24 Jul 2023 01:39:06 -0700
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Komal Bajaj <quic_kbajaj@quicinc.com>
Subject: [PATCH v5 0/2] nvmem: sec-qfprom: Add Qualcomm secure QFPROM support
Date:   Mon, 24 Jul 2023 14:08:47 +0530
Message-ID: <20230724083849.8277-1-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aRoFbUX8fJ04R4-d0NLqyw9FlVsDbwrE
X-Proofpoint-ORIG-GUID: aRoFbUX8fJ04R4-d0NLqyw9FlVsDbwrE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_06,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 mlxlogscore=613 phishscore=0 bulkscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307240077
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v5 -
 - Separating this from original series [1].
 - Added description of driver to secure qfprom binding.
 - Replaced pm_runtime_enable() withh devm_pm_runtime_enable().
 - Changed module license to GPL instead of GPL v2.

This series introduces a new driver for reading secure fuse region and adding
dt-bindings for same.

[1] https://lore.kernel.org/linux-arm-msm/20230623141806.13388-1-quic_kbajaj@quicinc.com/


Komal Bajaj (2):
  dt-bindings: nvmem: sec-qfprom: Add bindings for secure qfprom
  nvmem: sec-qfprom: Add Qualcomm secure QFPROM support

 .../bindings/nvmem/qcom,sec-qfprom.yaml       |  58 ++++++++++
 drivers/nvmem/Kconfig                         |  13 +++
 drivers/nvmem/Makefile                        |   2 +
 drivers/nvmem/sec-qfprom.c                    | 101 ++++++++++++++++++
 4 files changed, 174 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/qcom,sec-qfprom.yaml
 create mode 100644 drivers/nvmem/sec-qfprom.c

--
2.40.1

