Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A51768B10
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 07:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjGaFZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 01:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjGaFZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 01:25:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE954E78;
        Sun, 30 Jul 2023 22:25:19 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36V5LNJJ026120;
        Mon, 31 Jul 2023 05:25:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=HssAU61ib+PTvjMzDcsTe8UeRTs/vXDDFjxOcWDPvoY=;
 b=eHXD6kUTXriND8iNZqT8+GfMCveTVEjMQsvPcBMdbpjzeDqR98D9Q2ZSE/hPlgcIquBW
 IjrSjcGkIxNZ3j5k+8rc2X97pJUq7POUKpn8Hq5Hp6K6MsMq8PJUQHWbEzz/3y7Kilhf
 kpa7jVnepYNcAgILQfgd5dA96HDV3CQGCT2Za22H38v25pctiLo9AdBGqCCakmFRTn7M
 +oWb9Aj0Yez1zWHdzr9UFuMV/adX5OKTfUWDv9tm+ak/OpUkK8bKqqK4/TU9fSJaSHTL
 067IhK5a8hcGcIB0iMZYweZNxjJMbt6D7P6eedzWXKcyPZ/V36SV/ezGKY2PJlasR/cy tA== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s4ugsaq0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 05:25:13 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36V5PAtb017583;
        Mon, 31 Jul 2023 05:25:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3s4uuk6gxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 31 Jul 2023 05:25:10 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36V5P9Eg017570;
        Mon, 31 Jul 2023 05:25:09 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 36V5P9iu017568;
        Mon, 31 Jul 2023 05:25:09 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id ED8441A08; Mon, 31 Jul 2023 10:55:08 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 0/4] Add the rpmhpd header in the Qualcomm SoC
Date:   Mon, 31 Jul 2023 10:55:00 +0530
Message-Id: <1690781104-2290-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XYwSgN9E--IQ8O1s9pUXHi-Vo7AOSKOq
X-Proofpoint-GUID: XYwSgN9E--IQ8O1s9pUXHi-Vo7AOSKOq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 mlxlogscore=383 malwarescore=0 clxscore=1015
 spamscore=0 priorityscore=1501 mlxscore=0 impostorscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310048
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds the rpmhpd header in all the Qualcomm SoC that has
RPMH. It also moves the the regulator levels from rpmpd to rpmhpd so
that all the new SoC should not have to define these SoC specific PD
and can savely use rpmhpd.h
It depends on the previously submitted series out of which first 2 are applied.
Now, this can only be picked after applying 3rd series, otherwise would break
dt-bindings check.

[1] https://lore.kernel.org/all/1689744162-9421-1-git-send-email-quic_rohiagar@quicinc.com/
[2] https://lore.kernel.org/all/1689840545-5094-1-git-send-email-quic_rohiagar@quicinc.com/
[3] https://lore.kernel.org/all/1690461813-22564-1-git-send-email-quic_rohiagar@quicinc.com/

Thanks,
Rohit.

Rohit Agarwal (4):
  dt-bindings: power: qcom,rpmhpd: Add the regulator levels for RPMHPD
  arm: dts: qcom: Add the rpmhpd header
  arm64: dts: qcom: Add the rpmhpd header
  dt-bindings: power: qcom,rpmpd: Remove unused SoC specific bindings

 arch/arm/boot/dts/qcom/qcom-sdx55.dtsi  |  1 +
 arch/arm/boot/dts/qcom/qcom-sdx65.dtsi  |  1 +
 arch/arm64/boot/dts/qcom/qdu1000.dtsi   |  1 +
 arch/arm64/boot/dts/qcom/sa8775p.dtsi   |  1 +
 arch/arm64/boot/dts/qcom/sc7180.dtsi    |  1 +
 arch/arm64/boot/dts/qcom/sc7280.dtsi    |  1 +
 arch/arm64/boot/dts/qcom/sc8180x.dtsi   |  1 +
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi  |  1 +
 arch/arm64/boot/dts/qcom/sdm670.dtsi    |  1 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi    |  1 +
 arch/arm64/boot/dts/qcom/sm6350.dtsi    |  1 +
 arch/arm64/boot/dts/qcom/sm8150.dtsi    |  1 +
 arch/arm64/boot/dts/qcom/sm8250.dtsi    |  1 -
 arch/arm64/boot/dts/qcom/sm8350.dtsi    |  1 -
 arch/arm64/boot/dts/qcom/sm8450.dtsi    |  1 -
 arch/arm64/boot/dts/qcom/sm8550.dtsi    |  1 -
 include/dt-bindings/power/qcom,rpmhpd.h | 26 ++++++++++
 include/dt-bindings/power/qcom-rpmpd.h  | 84 ---------------------------------
 18 files changed, 38 insertions(+), 88 deletions(-)

-- 
2.7.4

