Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0D176CB1C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 12:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjHBKkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 06:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234112AbjHBKj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 06:39:58 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D682698;
        Wed,  2 Aug 2023 03:37:13 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3724GarS019619;
        Wed, 2 Aug 2023 09:59:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=5eTpmONcBo3GEGn6wgonDswT4n/j7veFZCTezLSb4n4=;
 b=MVRLWfFSkOWFu+G2RMGKQrA6PWzzjhYbXaBPE0cuUo0ubt/QA81KKk6e1O2B2Jg6Tnoe
 zTgcmH8GGPavMScB6Tm/wv8ZnDYggYAhXiOecCyDEbyHO9jd1rsEnKCqg7ckzGSW/1aP
 GQ9Sby0U1TgF3fpvzfVLOYW6ybRPKOy+8gUCf46apjbHGMLRuxqEk9J+sUNTuFIqDZNH
 9i6TEMRiL8InYHnC5uNy9EtU3GvTDuqwfApCeLuXTbBQkGrksvuQ5JgaSd6fXqMOPPjT
 U/0bgC7X6C4ogwYn48g+qLp/+x9XDnCdRVb0tpCGb9bI1ceV/1+aLXMdrSiD8Fic0niU pA== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s72gqtgu1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 09:59:38 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3729xSTq006598;
        Wed, 2 Aug 2023 09:59:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3s4uuke0yy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 02 Aug 2023 09:59:28 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3729xSlb006582;
        Wed, 2 Aug 2023 09:59:28 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3729xRXs006577;
        Wed, 02 Aug 2023 09:59:28 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 1B3701A80; Wed,  2 Aug 2023 15:29:27 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 0/8] Add pmics supported in Qualcomm's SDX75 platform
Date:   Wed,  2 Aug 2023 15:29:18 +0530
Message-Id: <1690970366-30982-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: poTegrWN7F4gIugSYV6V-Ts9SYrc3PkN
X-Proofpoint-ORIG-GUID: poTegrWN7F4gIugSYV6V-Ts9SYrc3PkN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_05,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=339 adultscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308020089
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series add support of pmics that are found in SDX75 platform and
add the corresponding regulators in the IDP platform as well.
It also parallely updates the pmic found in SDX65 to PM7250b and add pinctrl
support for the same pmic chip.
This series is based on the new header inclusion[1] and movement of the
regulators level from rpmpd to rpmhpd[2].
This series can be picked after successfully picking [2] and [3] as [1] has
already been applied.

[1] https://lore.kernel.org/all/1689744162-9421-1-git-send-email-quic_rohiagar@quicinc.com/
[2] https://lore.kernel.org/all/1690781104-2290-1-git-send-email-quic_rohiagar@quicinc.com/
[3] https://lore.kernel.org/all/1690461813-22564-1-git-send-email-quic_rohiagar@quicinc.com/

Thanks,
Rohit.

Rohit Agarwal (8):
  arm64: dts: qcom: sdx75: Add spmi node
  arm64: dts: qcom: Add pinctrl gpio support for pm7250b
  arm64: dts: qcom: Add PMIC pm7550ba dtsi
  arm64: dts: qcom: Add PMIC pmx75 dtsi
  ARM: dts: qcom: sdx65-mtp: Update the pmic used in sdx65
  arm64: dts: qcom: sdx75-idp: Add pmics supported in SDX75
  arm64: dts: qcom: sdx75: Add rpmhpd node
  arm64: dts: qcom: sdx75-idp: Add regulator nodes

 arch/arm/boot/dts/qcom/qcom-sdx65-mtp.dts |   2 +-
 arch/arm64/boot/dts/qcom/pm7250b.dtsi     |  10 ++
 arch/arm64/boot/dts/qcom/pm7550ba.dtsi    |  70 ++++++++++
 arch/arm64/boot/dts/qcom/pmx75.dtsi       |  64 ++++++++++
 arch/arm64/boot/dts/qcom/sdx75-idp.dts    | 205 ++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sdx75.dtsi       |  74 +++++++++++
 6 files changed, 424 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/qcom/pm7550ba.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pmx75.dtsi

-- 
2.7.4

