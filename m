Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4820C75A8CA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjGTIKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbjGTIKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:10:00 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121F62D55;
        Thu, 20 Jul 2023 01:09:40 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36K7JcGu004934;
        Thu, 20 Jul 2023 08:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=tRpvi/fPFGhk3H9IwrUQ7f2I1D7KZTeCtv3Vgs+MIMU=;
 b=Y5t/ZM+gficynHzf3em5gipvDQLhI8UzVs5p+UmkIjWdQhVb86SdXdZxdqOvvTxsDv/3
 eRMwmRLAUrwCdG5WUazLbwenkAAEP2ooW2MJ29EQzS9YELaG+E6fen31ApL8B9e0KivA
 36U//5kSjHVlDxZS7Ka38XhNgE1F5vz3d8U0Nzto2e2zSQcqp3eu4m3vqhZduLjdp8zm
 N3H53JGeCfeYHFTHfafhOg5DBsZwBr1Y0CswutMSAJrAOKmR3CCIFMcmznrReTtObRxz
 WIXNn6LKA0m4Bz7djGuFXn33JLIaX+cHWp4NLiihngp2Xsf82znKNmxaHGlMXyzyOXBh Cg== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxexkj5ne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 08:09:37 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36K89CT5010168;
        Thu, 20 Jul 2023 08:09:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3rumhm8db7-1;
        Thu, 20 Jul 2023 08:09:12 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36K89Cdu010149;
        Thu, 20 Jul 2023 08:09:12 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 36K89Bca010145;
        Thu, 20 Jul 2023 08:09:12 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 17AD81586; Thu, 20 Jul 2023 13:39:11 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 0/4] Use generic RPMHPD bindings for some of the Qualcomm SoCs
Date:   Thu, 20 Jul 2023 13:39:01 +0530
Message-Id: <1689840545-5094-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LKSuYTx8R_KlroWiqxd3-rkvOSSwKNh7
X-Proofpoint-GUID: LKSuYTx8R_KlroWiqxd3-rkvOSSwKNh7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_02,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 mlxlogscore=388 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307200067
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series updates the devicetree file of SM8[2345]50 to use the new
generic RPMHPD bindings introduced in a previous series [1] and depends on it.

[1] https://lore.kernel.org/all/1689744162-9421-1-git-send-email-quic_rohiagar@quicinc.com/

Thanks,
Rohit.


Rohit Agarwal (4):
  arm64: dts: qcom: sm8250: Update the RPMHPD bindings entry
  arm64: dts: qcom: sm8350: Update the RPMHPD bindings entry
  arm64: dts: qcom: sm8450: Update the RPMHPD bindings entry
  arm64: dts: qcom: sm8550: Update the RPMHPD bindings entry

 arch/arm64/boot/dts/qcom/sm8250.dtsi | 77 ++++++++++++++++++------------------
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 75 ++++++++++++++++++-----------------
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 37 ++++++++---------
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 29 +++++++-------
 4 files changed, 111 insertions(+), 107 deletions(-)

-- 
2.7.4

