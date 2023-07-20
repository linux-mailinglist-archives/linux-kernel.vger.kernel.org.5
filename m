Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876E675A815
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjGTHny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjGTHnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:43:46 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2312699;
        Thu, 20 Jul 2023 00:43:28 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36K6uOrd012946;
        Thu, 20 Jul 2023 07:43:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=Eq8q5Jz/iTKpMXrgwf4Vw8JxBKKL4DTxzHKL5u7rdLo=;
 b=f7FYMox/vNVWVJuWJH3wkOwYdtN2QV7k0rDXbIf0jpNr5vXQ1ph+Y1fScBf3yrqLxa+E
 sdCKZxyEYsJw8HXSTlHXTHa3FqiStkfDh27aKgQ33fWg9oeOJ7yG8L8UhHaU7px6RilM
 9M+iqTj+STEBgvmOFeKJEo5oZnzpk8Ylez/A2mQQgGznAxzAFaIzLBWhcLqLfEXV9sHT
 lNgc/j682zrTe6JFL6fKEKT1TpiNQSb6BYXWlxYHD513k9LYo9lHWZ3Z5kdWV2UshzcO
 KY6HQiK7Dsf47QCUi3XS6CQYRR+OSwAS9bo6Y12gBCw1q6FQmCJV2oZV+iukfy4kfjqW LQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxpyqrycf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 07:43:24 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36K7hNbf031064
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 07:43:23 GMT
Received: from harihk-linux.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 20 Jul 2023 00:43:18 -0700
From:   Hariharan K <quic_harihk@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_harihk@quicinc.com>
Subject: [PATCH 0/2] Add initial support for RDP404 of IPQ5018 family
Date:   Thu, 20 Jul 2023 13:13:00 +0530
Message-ID: <20230720074302.13585-1-quic_harihk@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: itIZ6nWJqlnz_lH53Po6jF_j_ROdFE3M
X-Proofpoint-ORIG-GUID: itIZ6nWJqlnz_lH53Po6jF_j_ROdFE3M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_02,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=756 malwarescore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307200063
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the initial device tree support for the Reference Design
Platform(RDP) 404 based on IPQ5018 family of SoC. This patch
carries the support for Console UART and eMMC.

This series is based on the below series,
https://lore.kernel.org/lkml/20230720072938.315
46-1-quic_harihk@quicinc.com/

Hariharan K (2):
  dt-bindings: arm: qcom: Document MP03.1-C2 board based on IPQ5018
    family
  arm64: dts: qcom: ipq5018: add support for the RDP404 variant

 .../devicetree/bindings/arm/qcom.yaml         |  2 +
 arch/arm64/boot/dts/qcom/Makefile             |  1 +
 arch/arm64/boot/dts/qcom/ipq5018-rdp404.dts   | 49 +++++++++++++++++++
 3 files changed, 52 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/ipq5018-rdp404.dts

-- 
2.17.1

