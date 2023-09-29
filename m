Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05D07B3366
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 15:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbjI2NT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 09:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbjI2NT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 09:19:56 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70871B9;
        Fri, 29 Sep 2023 06:19:54 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38TAjt7S030869;
        Fri, 29 Sep 2023 13:19:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=Lf3ex/Z4ddSkjpFJQcTMl0H72jUUcDMMDlMYDUfhLfk=;
 b=mOA8E1oEJhETDoa2Ae/On8tVC3iceB+TvK/Qf1cU9JUWQdGgC3r7y0uI50mPsVp1dC01
 1dizobX2frpYQbkU1D4BNu0Z4RV1AMP+RRu9i3wSsQmzZ1M9l/IlNmBUoBj6EV6C/l3e
 BaN9R6hNg7SagNOPRXIbAkOdNgwATyffN7dfynHxNeoZJFB5WsxIgqP3R9ORPvT4wTFX
 Wvd3ylFbe8nlyZYuyx4QSSahYfPU1xHigDBOxro+hj93WBXQmrmuYNFDKx0ZoeE5i0Zg
 ARiPGkIg9gvGtCIT4sLpaZRECBIBCvDknnOL2wTVwDr7cciEamAvpF+sXAiKr2eBOdFx qQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3td3ggbq3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 13:19:43 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 38TDJdpK018488;
        Fri, 29 Sep 2023 13:19:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3t9s3m3gcg-1;
        Fri, 29 Sep 2023 13:19:39 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38TDJdPX018479;
        Fri, 29 Sep 2023 13:19:39 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-nitirawa-hyd.qualcomm.com [10.213.109.152])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 38TDJckT018463;
        Fri, 29 Sep 2023 13:19:39 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2342877)
        id 365E0571638; Fri, 29 Sep 2023 18:49:38 +0530 (+0530)
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mani@kernel.org, alim.akhtar@samsung.com, bvanassche@acm.org,
        avri.altman@wdc.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        cros-qcom-dts-watchers@chromium.org
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Nitin Rawat <quic_nitirawa@quicinc.com>
Subject: [PATCH V4 0/4] Add UFS host controller and Phy nodes for sc7280
Date:   Fri, 29 Sep 2023 18:49:32 +0530
Message-Id: <20230929131936.29421-1-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Jh7fEnqxF92lnkqc_YdicxRbjWyfARva
X-Proofpoint-ORIG-GUID: Jh7fEnqxF92lnkqc_YdicxRbjWyfARva
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_11,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=726
 priorityscore=1501 bulkscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2309290114
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds UFS host controller and Phy nodes for Qualcomm sc7280 SOC
and sc7280 Board.

Changes from v3:
- Addresses Mani comment to include interconnect entry.

Changes from v2:
- Addressed Konrad comment to update binding qcom,ufs.yaml
- Addresses mani/konrad comment to align ufs clock entry in devicetree.

Changes from v1:
- Addressed mani comment to separate soc and board change.
- Addressed mani comment to sort ufs node in ascending order.

Nitin Rawat (4):
  scsi: ufs: qcom: dt-bindings: Add SC7280 compatible string
  arm64: dts: qcom: sc7280: Add UFS nodes for sc7280 soc
  arm64: dts: qcom: sc7280: Add UFS nodes for sc7280 IDP board
  dt-bindings: ufs: qcom: Align clk binding property for Qualcomm UFS

Nitin Rawat (4):
  scsi: ufs: qcom: dt-bindings: Add SC7280 compatible string
  arm64: dts: qcom: sc7280: Add UFS nodes for sc7280 soc
  arm64: dts: qcom: sc7280: Add UFS nodes for sc7280 IDP board
  dt-bindings: ufs: qcom: Align clk binding property for Qualcomm UFS

 .../devicetree/bindings/ufs/qcom,ufs.yaml     | 18 ++---
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      | 19 ++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi          | 66 +++++++++++++++++++
 3 files changed, 95 insertions(+), 8 deletions(-)

--
2.17.1

