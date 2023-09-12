Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BF979CCDC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbjILKEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjILKEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:04:22 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200781BB;
        Tue, 12 Sep 2023 03:04:18 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38C9Owig019691;
        Tue, 12 Sep 2023 10:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=Vwfy73xj4x08bi6EovEZCWMmUziQqRDVN94w2xVW+ZM=;
 b=Otfp1z3rmSq4idOrAPHc3RuO4oS2xIClxsV02jf9nhli4FJupPFDPGhc9TAE82qxE6++
 8ZcmG62iIbxBoNTuEniWyK0Us5kmJihnx6Nb1rnhWsEmS8XAMczFBZ3R0Tq+ZPE57nHm
 A1pJ3TCuc6KXWWKVlTj0fI00KCovxEKgmR3pR2eEAHJ1MC7h8VcYfcXBsUvvolvmsSsi
 KfSjSWkEALBLN4T9uPDH8LPpLihqPr2ZcPvLOeMMErg7Mf8xY7qxl8PDa6OK3+Y+tCV/
 LSjn3R3ggvJQlHSH2HrpKXfFuXyd38fFl/rrNUR5jrGVlQNkpPu3SFGRQglpFJHrwU9S 5A== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t24raabnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 10:04:12 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 38CA48LZ029226;
        Tue, 12 Sep 2023 10:04:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3t0hskmrak-1;
        Tue, 12 Sep 2023 10:04:08 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38CA48w8029213;
        Tue, 12 Sep 2023 10:04:08 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 38CA481Y029208;
        Tue, 12 Sep 2023 10:04:08 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 685391D36; Tue, 12 Sep 2023 15:34:07 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@quicinc.com, Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v2 0/2] Add interconnect driver for SDX75
Date:   Tue, 12 Sep 2023 15:34:04 +0530
Message-Id: <1694513046-24064-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _sy0ssqEcNveB92pDgBVTAJPpcC8df6a
X-Proofpoint-ORIG-GUID: _sy0ssqEcNveB92pDgBVTAJPpcC8df6a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_07,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 suspectscore=0 phishscore=0
 impostorscore=0 mlxlogscore=693 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120085
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

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
 drivers/interconnect/qcom/sdx75.c                  | 1112 ++++++++++++++++++++
 drivers/interconnect/qcom/sdx75.h                  |   97 ++
 include/dt-bindings/interconnect/qcom,sdx75.h      |  102 ++
 6 files changed, 1414 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdx75-rpmh.yaml
 create mode 100644 drivers/interconnect/qcom/sdx75.c
 create mode 100644 drivers/interconnect/qcom/sdx75.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sdx75.h

-- 
2.7.4

