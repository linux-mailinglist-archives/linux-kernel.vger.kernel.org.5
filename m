Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3FF79EADC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241315AbjIMOTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241297AbjIMOTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:19:09 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF4E5BA3;
        Wed, 13 Sep 2023 07:11:07 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DBe3Cl017669;
        Wed, 13 Sep 2023 14:11:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=2Vvyz3kaBR5K9Mp05wf4x59Bwusl+MEdOtqRu7dB39g=;
 b=ovFsknzEC/G1nM8AGwgRFO3ZzNkt7GFbTG+o1w1sV6XX0BOMTYddjDI0/L7Y8mtLasp4
 Jflpq4rwnN67+M0cqkagWqQjcYwc0Pxf1BjetgE2bMVXf/Rdo5Gmq4PoV7nqnY0yvMhA
 o5xbNENw4j47UioVeIwD6i3zB+yA3GvoHuYsXZ405AltrTJxYuQejsA/zaafGHqmGY40
 wPiWq8UW5Re7WHgEogqkpu8zPc/C0QafJR0lTqktWOyJLzqbRDDgWbAQCIDjXdEMhL2L
 cO8eCbBm7k+TR52PKrj95L4RSpMTJOnzBd9mETzwCRjukXHJjDpxMQFKxobdU4H1VXgO /A== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t314chhh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 14:11:02 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 38DEAwSN007638;
        Wed, 13 Sep 2023 14:10:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3t0hskt7mn-1;
        Wed, 13 Sep 2023 14:10:58 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38DEAwR4007624;
        Wed, 13 Sep 2023 14:10:58 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 38DEAwFb007620;
        Wed, 13 Sep 2023 14:10:58 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 71BED1D52; Wed, 13 Sep 2023 19:40:57 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@quicinc.com, Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v3 0/2] Add interconnect driver for SDX75
Date:   Wed, 13 Sep 2023 19:40:54 +0530
Message-Id: <1694614256-24109-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KDkr9WnQBeOnhZtwmHZfYZk9z3KoZ3Pm
X-Proofpoint-ORIG-GUID: KDkr9WnQBeOnhZtwmHZfYZk9z3KoZ3Pm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_07,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=727 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309130115
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes in v3:
 - Removed the unnecessary declaration of a struct from patch 2/2
 - Collected the reviewed by tag

Changes in v2:
 - Updated the bindings to merge the if clauses and updated the maintainer.
 - Updated the drivers file to a latest template to add the missing const
   keyword.
 - Rebased on v6.6-rc1

This series adds interconnect driver support for SDX75 platform.

Thanks,
Rohit.

Rohit Agarwal (2):
  dt-bindings: interconnect: Add compatibles for SDX75
  interconnect: qcom: Add SDX75 interconnect provider driver

 .../bindings/interconnect/qcom,sdx75-rpmh.yaml     |   92 ++
 drivers/interconnect/qcom/Kconfig                  |    9 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/sdx75.c                  | 1107 ++++++++++++++++++++
 drivers/interconnect/qcom/sdx75.h                  |   97 ++
 include/dt-bindings/interconnect/qcom,sdx75.h      |  102 ++
 6 files changed, 1409 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdx75-rpmh.yaml
 create mode 100644 drivers/interconnect/qcom/sdx75.c
 create mode 100644 drivers/interconnect/qcom/sdx75.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sdx75.h

-- 
2.7.4

