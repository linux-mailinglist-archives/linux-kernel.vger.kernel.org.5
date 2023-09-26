Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACFF7AF089
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbjIZQVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbjIZQVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:21:03 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9785210A;
        Tue, 26 Sep 2023 09:20:56 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38QD8X7G015172;
        Tue, 26 Sep 2023 16:20:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=4egfuai/K1YaEUv09gPmcF8efD43YT+tVjuUW8tDWh4=;
 b=N4WqbL7wY3jFMqFG83ksBNFNHsVOgBMlJmT0wQp0/HULRtA9zm+AC4/stwWuWho2rhm7
 jVPDLwk01OUE0tncyka41JN5LFW7R9An/nR57zTB0IYfjMYezFv2Vo/bki3jCxMlax/h
 iDkKSFkDbhqRShNzc4LWklr7u9L8+Uv9XeZd+PgiGhHQkJ1b13Q5bvnWq28GHjV9M4uy
 d0LQM0FzlqR4f97ogv8ipXFqWND0dZ/nAubsB1/aq6IYuXDGcyYbBd0suZQ04EfPrG8L
 giHduI+Sr9IfKdFw+eVrqA2+OzubGq3NkiCFJXPyuPgJR9lgwDQZg1wuMkFmGpiEwBor Sg== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tb7re3rp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 16:20:48 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 38QGKjw5010028;
        Tue, 26 Sep 2023 16:20:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3t9s3kk6mr-1;
        Tue, 26 Sep 2023 16:20:45 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38QGKiQ7010022;
        Tue, 26 Sep 2023 16:20:44 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-nitirawa-hyd.qualcomm.com [10.213.109.152])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 38QGKiAf010021;
        Tue, 26 Sep 2023 16:20:44 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2342877)
        id E04A8601917; Tue, 26 Sep 2023 21:50:43 +0530 (+0530)
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mani@kernel.org, alim.akhtar@samsung.com, bvanassche@acm.org,
        avri.altman@wdc.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        cros-qcom-dts-watchers@chromium.org
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Nitin Rawat <quic_nitirawa@quicinc.com>
Subject: [PATCH V2 0/3] Add UFS host controller and Phy nodes for sc7280
Date:   Tue, 26 Sep 2023 21:50:39 +0530
Message-Id: <20230926162042.14180-1-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -lu74KSH2ts1NxLe9C2n0mkt1P08Xxe_
X-Proofpoint-GUID: -lu74KSH2ts1NxLe9C2n0mkt1P08Xxe_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_13,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 mlxlogscore=555 adultscore=0
 priorityscore=1501 phishscore=0 clxscore=1011 spamscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309260142
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds UFS host controller and Phy nodes for Qualcomm sc7280 SOC
and sc7280 Board.

Changes from v1:
- Addressed mani comment to separate soc and board change.
- Addressed mani comment to sort ufs node in ascending order.

Nitin Rawat (3):
  scsi: ufs: qcom: dt-bindings: Add SC7280 compatible string
  arm64: dts: qcom: sc7280: Add UFS nodes for sc7280 soc
  arm64: dts: qcom: sc7280: Add UFS nodes for sc7280 IDP board

 .../devicetree/bindings/ufs/qcom,ufs.yaml     |  2 +
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      | 19 ++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi          | 64 +++++++++++++++++++
 3 files changed, 85 insertions(+)

--
2.17.1

