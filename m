Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED10977E58F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344358AbjHPPtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344324AbjHPPtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:49:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E74026B5;
        Wed, 16 Aug 2023 08:48:59 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GCn9QJ001845;
        Wed, 16 Aug 2023 15:48:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=q1VVgRd6l4S/kIJMK4NM0Qezc5H2bSqFKTnDSuMElGQ=;
 b=WPcGeruemqs3LXBqt2q2rdaFIgB0z6lZX09sDrrqQ/xRWvogXtJZ4c5/pc+MP35OYETd
 hPn08DkAMivzjN5yChTHppm/nynM1e5XgeVc/0ibkv4vG7uP9/El96816n3WSOkosHos
 hY5+pRQHFoBHAsuPTCCbpUKo+WzHbx996E3DpzuoLmu4HCUvaBnZrL5whidPLeytzaiq
 5ioVdHo2ARe7ZkDXJpQNE41VtU5Khez96bFpCDeZW5t9XFVGbIjrygg4+Gj2yhBXRchJ
 lRoOkHHe/51/9ir9qHGpwDAuwarnQBkFFXbeujQbCHdkXm0TMdm7H2GIQh0vKQ+ep1Sp MQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sg66hu8t9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 15:48:47 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 37GFmiWn002204;
        Wed, 16 Aug 2023 15:48:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3se35maye0-1;
        Wed, 16 Aug 2023 15:48:44 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37GFmi5I002198;
        Wed, 16 Aug 2023 15:48:44 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-nitirawa-hyd.qualcomm.com [10.213.109.152])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 37GFmiuv002197;
        Wed, 16 Aug 2023 15:48:44 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2342877)
        id 635D85000A7; Wed, 16 Aug 2023 21:18:43 +0530 (+0530)
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
To:     andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        agross@kernel.org, kishon@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Nitin Rawat <quic_nitirawa@quicinc.com>
Subject: [PATCH V1 0/2] Add Phy Configuration support for SC7280
Date:   Wed, 16 Aug 2023 21:18:39 +0530
Message-Id: <20230816154841.2183-1-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5seZ0W1TkW2-9uOLK8g4f9I-dyWR2hDw
X-Proofpoint-GUID: 5seZ0W1TkW2-9uOLK8g4f9I-dyWR2hDw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_15,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 mlxscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 clxscore=1011
 priorityscore=1501 malwarescore=0 impostorscore=0 mlxlogscore=672
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160137
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

Nitin Rawat (2):
  dt-bindings: phy: Add QMP UFS PHY comptible for SC7280
  phy: qcom-qmp-ufs: Add Phy Configuration support for SC7280

 .../phy/qcom,sc8280xp-qmp-ufs-phy.yaml        |   2 +
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c       | 142 ++++++++++++++++++
 2 files changed, 144 insertions(+)

--
2.17.1

