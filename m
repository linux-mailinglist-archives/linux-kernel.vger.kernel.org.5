Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92D8772620
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjHGNkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbjHGNkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:40:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055F5211F;
        Mon,  7 Aug 2023 06:39:42 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 377Aqvij013535;
        Mon, 7 Aug 2023 13:39:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=uDiSjzQNMIihFZv/QwLP4mPl+WoenfpMmrIRH2Of8TY=;
 b=OO0b7yGOc8bvPaoYlSzdaij4LbwCQkXFZP0pNrN3I9448Wi+BvXz5iRjYwws9JTof1am
 mjyJ8klJpDo4+5XFLC/bikeaqiWn+xrvjBRxci3JE26k9WZXZ9YZQjJafz3QCTkRL8ZB
 DqSTr7a8sPGOmSmnOqT6Qlln1KTO0T8jUfhSlVl5/jNfl/GE7WNQ+zmEOFIiGi2OFPNH
 m/bPtt51Qd62vR/GlLbygIIwyz9LMOr0C7E9XYBNXPuELfkjb2v9XTij3kpcj1vTpn4T
 j8gX/pGpQmnWyEnEcjP9SenwMZeLP3I+tEtI9tkMdZ9uvD7egdcansoWhP47p2j7xAkI mQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s9f6pkfnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 13:39:33 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 377Dcvnt006258;
        Mon, 7 Aug 2023 13:38:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3s9fgkp5st-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 07 Aug 2023 13:38:57 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 377DcuJY006121;
        Mon, 7 Aug 2023 13:38:56 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 377Dcujp006042;
        Mon, 07 Aug 2023 13:38:56 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id EF17C1B56; Mon,  7 Aug 2023 19:08:55 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        abel.vesa@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH RESEND v2 0/9] Add pmics supported in Qualcomm's SDX75 platform
Date:   Mon,  7 Aug 2023 19:08:45 +0530
Message-Id: <1691415534-31820-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: n08tNFWXmbPzQdqq-yAaak2CnRBxBmI_
X-Proofpoint-GUID: n08tNFWXmbPzQdqq-yAaak2CnRBxBmI_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_14,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxscore=0 impostorscore=0 suspectscore=0 phishscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=713 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308070127
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes in v2:
 - Added compatible for pm7550ba for eusb2 repeater and used it in DT.
 - Addressed some minor comments from Konrad to add fixes tag, labels
   and update the labels

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


Rohit Agarwal (9):
  dt-bindings: phy: qcom,snps-eusb2-repeater: Add compatible for
    PM7550BA
  arm64: dts: qcom: sdx75: Add spmi node
  arm64: dts: qcom: Add pinctrl gpio support for pm7250b
  arm64: dts: qcom: Add pm7550ba PMIC dtsi
  arm64: dts: qcom: Add pmx75 PMIC dtsi
  ARM: dts: qcom: sdx65-mtp: Update the pmic used in sdx65
  arm64: dts: qcom: sdx75-idp: Add pmics supported in SDX75
  arm64: dts: qcom: sdx75: Add rpmhpd node
  arm64: dts: qcom: sdx75-idp: Add regulator nodes

 .../bindings/phy/qcom,snps-eusb2-repeater.yaml     |   7 +-
 arch/arm/boot/dts/qcom/qcom-sdx65-mtp.dts          |   2 +-
 arch/arm64/boot/dts/qcom/pm7250b.dtsi              |  10 +
 arch/arm64/boot/dts/qcom/pm7550ba.dtsi             |  70 +++++++
 arch/arm64/boot/dts/qcom/pmx75.dtsi                |  64 ++++++
 arch/arm64/boot/dts/qcom/sdx75-idp.dts             | 230 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sdx75.dtsi                |  74 +++++++
 7 files changed, 455 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/pm7550ba.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pmx75.dtsi

-- 
2.7.4

