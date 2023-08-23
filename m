Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B564785424
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235347AbjHWJcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235116AbjHWJbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:31:16 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6224461B4;
        Wed, 23 Aug 2023 02:18:16 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37N7Mmwf019703;
        Wed, 23 Aug 2023 09:18:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=regJct096Fmi2bn8PvXQq0GlUsAVo2IwLQJ1kIczaD4=;
 b=a/horabiDg00k2PDk2Bh6h38I0LMhJh/wQvfla3YOxh423sPlxp0G9KRLQkM+uJygjig
 F9uhpzHsiBzIxucsfgHycuokOotXqUuZVgIF7qzP3A2hKQhYHvIKEkXKYUuMxNbZ1DHE
 cxGHEiIwMWOVx3q1muhC3e19Dyubt5flrLVJHVXKxTENWzlKhtyxoj0z/6hKWc9DXl7n
 IdHfaiGS4edCfp7t9h7VpIFCfMrwsQZVKyQ8p2mEG/leG6abPq8hTk/7f9fKhyJXa3Nn
 UwJe1Pw5hizGOJn3LCusxJvCyxE9y/Y3aOworDyaWvCZ70qEMLWUc1dGC/VLffljD/kl Bg== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sn25vhn08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 09:18:04 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 37N9I0pO018288;
        Wed, 23 Aug 2023 09:18:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3sjptkpxt4-1;
        Wed, 23 Aug 2023 09:18:00 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37N9I0fJ018283;
        Wed, 23 Aug 2023 09:18:00 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-nitirawa-hyd.qualcomm.com [10.213.109.152])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 37N9Hxdw018282;
        Wed, 23 Aug 2023 09:18:00 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2342877)
        id 355535000AA; Wed, 23 Aug 2023 14:47:59 +0530 (+0530)
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Nitin Rawat <quic_nitirawa@quicinc.com>
Subject: [PATCH V3 0/2] Add Phy Configuration support for SC7280
Date:   Wed, 23 Aug 2023 14:47:55 +0530
Message-Id: <20230823091757.31311-1-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hdGhXtUqK1Bbj9kPlU9cH3ASHLT4a0s4
X-Proofpoint-GUID: hdGhXtUqK1Bbj9kPlU9cH3ASHLT4a0s4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_06,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=920
 phishscore=0 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308230084
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds Phy configuration support for Qualcomm SC7280 SOC.

Changes from V2:
- Addressed Vinod comment to replace upper case character with lower case

Changes from V1:
- Addressed dmitry's comment to align sc7280 register arrays in sorted order
- Addressed konrad & vinod's comment to align phy compatible in sorted order

Nitin Rawat (2):
  dt-bindings: phy: Add QMP UFS PHY comptible for SC7280
  phy: qcom-qmp-ufs: Add Phy Configuration support for SC7280

 .../phy/qcom,sc8280xp-qmp-ufs-phy.yaml        |   2 +
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c       | 142 ++++++++++++++++++
 2 files changed, 144 insertions(+)

--
2.17.1

