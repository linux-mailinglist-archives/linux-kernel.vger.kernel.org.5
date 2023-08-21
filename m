Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA36782683
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 11:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbjHUJtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 05:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbjHUJtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 05:49:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68849A9;
        Mon, 21 Aug 2023 02:49:52 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37L8wSiW014830;
        Mon, 21 Aug 2023 09:49:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=FDN+u2Bx3hkkBprQZ2n88cSyQE8Gk0JVqhSE2T0qpvU=;
 b=T6wDWjuVsU8tahAU8xirAprzovT0ZqzI0C8mPWwRLW9U1+tBnSAt+LK9vMQPXEP3Bmmu
 +gSMH9IxGHo2/5wvL5mqgw/iQ9yrMw5kgJKAN9DMsBExWn1ygsKA4nCyK7pcJbpEt7lO
 OlRbz4isrb4plrJKXgeSQ2gQpiG3P1ktygEmLiLwfktaPiaJmPA3oIoHEE0kEcKbuI/p
 OkZkRL7ONdEezeds9s3NAex4sQ03XIRLsQ8pI5EsHDisVsim+FPO5DZRKf/NH5A2ctKN
 VQWyWUF62DHrZoPD4C3ROA0wWuZ5tHNnVew030uwjtBdI0DVkqcsMhGaOkIJBmcHHLcE fg== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sjnu138ke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 09:49:43 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 37L9ne1C026922;
        Mon, 21 Aug 2023 09:49:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3sjptkfk09-1;
        Mon, 21 Aug 2023 09:49:40 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37L9ndO1026917;
        Mon, 21 Aug 2023 09:49:40 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-nitirawa-hyd.qualcomm.com [10.213.109.152])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 37L9ndp1026916;
        Mon, 21 Aug 2023 09:49:39 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2342877)
        id ED4A45013BF; Mon, 21 Aug 2023 15:19:38 +0530 (+0530)
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
To:     mani@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, alim.akhtar@samsung.com,
        bvanassche@acm.org, robh+dt@kernel.org, avri.altman@wdc.com,
        cros-qcom-dts-watchers@chromium.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Nitin Rawat <quic_nitirawa@quicinc.com>
Subject: [PATCH V1 0/2] Add UFS host controller and Phy nodes for sc7280
Date:   Mon, 21 Aug 2023 15:19:35 +0530
Message-Id: <20230821094937.13059-1-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: u35YAbqCjCS75SvJjRsOFGtLUiXlWzqW
X-Proofpoint-GUID: u35YAbqCjCS75SvJjRsOFGtLUiXlWzqW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_01,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 impostorscore=0 clxscore=1011 mlxlogscore=518 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308210089
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds UFS host controller and Phy nodes for Qualcomm SC7280 SOC.

This patch is dependent on below patch-
"dt-bindings: phy: Add QMP UFS PHY comptible for SC7280"
(https://lore.kernel.org/lkml/481ac6b3-1dda-1e9e-7339-e39a17d2eed9@linaro.org/)

Nitin Rawat (2):
  scsi: ufs: qcom: dt-bindings: Add SC7280 compatible string
  arm64: dts: qcom: sc7280: Add UFS host controller and phy nodes

 .../devicetree/bindings/ufs/qcom,ufs.yaml     |  2 +
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      | 19 ++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi          | 64 +++++++++++++++++++
 3 files changed, 85 insertions(+)

--
2.17.1

