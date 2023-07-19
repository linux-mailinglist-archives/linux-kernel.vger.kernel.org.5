Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0A5758D07
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 07:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjGSFXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 01:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjGSFWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 01:22:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE23D2;
        Tue, 18 Jul 2023 22:22:51 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36J4ktQ9012458;
        Wed, 19 Jul 2023 05:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=9sdma6h/PNEEnVYANsAJDM7osuVLGkzVAlBbfHfhmIM=;
 b=mLbBny+xGyi9wz7iD0sFMQwlkccDX05UAIyuexphYI7obP0epjFdflwRoSixnKRjcMIj
 weuk01RU1vJH6XuBhKbvcJCpFD5wfsWJZFNoaDeMxK6csf0E4yMVH+yOVXwri+y91kLE
 2mPcn8HY8LkEr4HmIegeiYao2HGHeOF8PwDcIc4TtNEr/zxovdT443Sz7gC8mf5a55QP
 WrO6zwHozMJejb/bmAHnRgQRLTVP2q26qD9ez9y9PWZM6h0pmUvJLlNegIc/lGZxZabF
 s/vDi9iZqEXfVRnC3hEIPhUeDJElCj1aMMCWAl0Ml9Is/taAaPptU9UzWP4qzdPzjaV4 9Q== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rwxkns4fm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 05:22:47 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36J5Mixh004733;
        Wed, 19 Jul 2023 05:22:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3rumhm1bc4-1;
        Wed, 19 Jul 2023 05:22:44 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36J5Mi7d004723;
        Wed, 19 Jul 2023 05:22:44 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 36J5MiOG004720;
        Wed, 19 Jul 2023 05:22:44 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 4E32DD96; Wed, 19 Jul 2023 10:52:43 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 0/2] Introduce new generic bindings for RPMHPD
Date:   Wed, 19 Jul 2023 10:52:40 +0530
Message-Id: <1689744162-9421-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3gp-J0P94HE2AuGJsUcWgQMu40xZePOb
X-Proofpoint-GUID: 3gp-J0P94HE2AuGJsUcWgQMu40xZePOb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_02,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=369 suspectscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307190049
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series introduces a new generic bindings for Qualcomm SoCs
to be used instead of creating new SoC specific bindings each time.
The order of the bindings is kept according to the order in Qualcomm
SoC like SM8[2345]50 so that it can be reused in these SoC without
breaking the ABI.
This was suggested as per the discussions in [1].
I will create a followup series of DT updates according to the new bindings.

Separating this series from the original [1] since this involves refactoring
and no new support addition.

[1] https://lore.kernel.org/all/1689054169-10800-1-git-send-email-quic_rohiagar@quicinc.com/

Thanks,
Rohit.

Rohit Agarwal (2):
  dt-bindings: power: qcom,rpmhpd: Add Generic RPMh PD indexes
  soc: qcom: rpmhpd: Use the newly created generic RPMHPD bindings

 drivers/soc/qcom/rpmhpd.c               | 101 ++++++++++++++++----------------
 include/dt-bindings/power/qcom,rpmhpd.h |  30 ++++++++++
 2 files changed, 81 insertions(+), 50 deletions(-)
 create mode 100644 include/dt-bindings/power/qcom,rpmhpd.h

-- 
2.7.4

