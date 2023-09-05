Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6AF792BFD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350981AbjIERFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349993AbjIEE7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 00:59:49 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1A0CC5;
        Mon,  4 Sep 2023 21:59:46 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3854BuRM012731;
        Tue, 5 Sep 2023 04:59:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=8Pb3RG10ggqXhAPFcw8dJQlxsPCGz8Xa8WcpkLD5qBQ=;
 b=CoHmUnESUsh1AdgKMdeP7biIgEhls5+znaWgkE7CS1/fmuzaAoc58uB/WhWlaP7UY/Jk
 MckNezk6U/w4w6ftYqxtN5u348IdL5S6tpbPzXTpjb6J3nUtU5XLyXEsn0Pd4PMehqGK
 o6+i3jSSJXO02VNaDjQMN99PojgCOCrM8iu/adsSS+4OiSjgJbeeF4IyfYLVwLaiRT3s
 xWY7HAga231ZwVVWT7XH+Lovr5kUh+GoFFEDnpG0ZnhcZ8tErrBS7r/qu4Fnyqfw1/Nc
 c/GKVa6ol5hgwIoE1gGbxKO6kbIu43Ph1QB/K5Sm6aLoLOu0D9jeOGD06QBJhgBLoiQ6 Dg== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sww32r26c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 04:59:41 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3854xbFx027984;
        Tue, 5 Sep 2023 04:59:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3sux4kawce-1;
        Tue, 05 Sep 2023 04:59:37 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3854xb2q027973;
        Tue, 5 Sep 2023 04:59:37 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3854xaDd027972;
        Tue, 05 Sep 2023 04:59:37 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id D6B2C1D0C; Tue,  5 Sep 2023 10:29:35 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@quicinc.com, Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 0/2] Add interconnect driver for SDX75
Date:   Tue,  5 Sep 2023 10:29:33 +0530
Message-Id: <1693889975-19122-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: K77JBXuAtM3ObSejG8jwRzMN59v76olj
X-Proofpoint-GUID: K77JBXuAtM3ObSejG8jwRzMN59v76olj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_03,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=663 mlxscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309050043
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds interconnect driver support for SDX75 platform.

Thanks,
Rohit.

Rohit Agarwal (2):
  dt-bindings: interconnect: Add compatibles for SDX75
  interconnect: qcom: Add SDX75 interconnect provider driver

 .../bindings/interconnect/qcom,sdx75-rpmh.yaml     |  100 ++
 drivers/interconnect/qcom/Kconfig                  |    9 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/sdx75.c                  | 1134 ++++++++++++++++++++
 drivers/interconnect/qcom/sdx75.h                  |   97 ++
 include/dt-bindings/interconnect/qcom,sdx75.h      |  102 ++
 6 files changed, 1444 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdx75-rpmh.yaml
 create mode 100644 drivers/interconnect/qcom/sdx75.c
 create mode 100644 drivers/interconnect/qcom/sdx75.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sdx75.h

-- 
2.7.4

