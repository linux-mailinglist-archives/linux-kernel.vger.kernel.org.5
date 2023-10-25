Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DD17D6F0A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344969AbjJYOZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344661AbjJYOZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:25:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0837393;
        Wed, 25 Oct 2023 07:25:19 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PCxGVd032203;
        Wed, 25 Oct 2023 14:24:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=FNySmSzEC1x8I8kpUjJ2MhDQrY1CtU82LyUnuHiv+YY=;
 b=IjnBApcYAScnMo/aXyH4f3Ct1SlX7pq64NnDmlPJgkMXDiLH+kn5NQZGQU8orPQ8JpDl
 rIYFmKYbh7Nj2Jhcymou4hVyTb/p0LsnZbctUg5FBy0YgKa6kw50Fzv1bz+VJS0ia/T6
 jUyd/VeMDcGewJN0ppf+AHD9UT5k637K31A+Y9tmvDSG4HDKmzTIGeZBWlChMUzOFQuQ
 KSi24TGDtp8e46v5m11jfLMr5PlYQh6X19lKv3ZwwMUnKAAm06e93NXhIhNYtDjPuBif
 QPcTyjhSov8KfvC7XMLUTxf3kUwcLO9ZeI+6reohaYruhsw8tmqj3AvpdgE55YAgtCTD kA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3txtbf18gq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 14:24:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39PEOrJ4026720
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 14:24:53 GMT
Received: from blr-ubuntu-87.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 25 Oct 2023 07:24:46 -0700
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <catalin.marinas@arm.com>, <ulf.hansson@linaro.org>
CC:     <agross@kernel.org>, <conor+dt@kernel.org>,
        <ayan.kumar.halder@amd.com>, <j@jannau.net>,
        <dmitry.baryshkov@linaro.org>, <nfraprado@collabora.com>,
        <m.szyprowski@samsung.com>, <u-kumar1@ti.com>, <peng.fan@nxp.com>,
        <lpieralisi@kernel.org>, <quic_rjendra@quicinc.com>,
        <abel.vesa@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_tsoni@quicinc.com>,
        <neil.armstrong@linaro.org>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH 0/5] dts: qcom: Introduce SC8380XP platforms device tree
Date:   Wed, 25 Oct 2023 19:54:22 +0530
Message-ID: <20231025142427.2661-1-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Z8K8VsEBgJXTSZnnuxAbJ8eEKWND9QRK
X-Proofpoint-ORIG-GUID: Z8K8VsEBgJXTSZnnuxAbJ8eEKWND9QRK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_03,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 clxscore=1011 bulkscore=0 phishscore=0 adultscore=0
 mlxlogscore=714 spamscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250125
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the initial (clocks, pinctrl, rpmhpd, regulator, interconnect,
CPU, SoC and board compatibles) device tree support to boot to shell on the
Qualcomm SC8380XP platform, aka Snapdragon X Elite.

Dependencies:
clks: https://lore.kernel.org/lkml/20231025133320.4720-1-quic_sibis@quicinc.com/
interconnect: https://lore.kernel.org/lkml/20231025134049.9734-1-quic_sibis@quicinc.com/
llcc: https://lore.kernel.org/lkml/20231025134632.10363-1-quic_sibis@quicinc.com/
misc-bindings: https://lore.kernel.org/lkml/20231025140640.22601-1-quic_sibis@quicinc.com/ 
pinctrl: https://lore.kernel.org/lkml/20231025135058.11268-1-quic_sibis@quicinc.com/
regulators: https://lore.kernel.org/lkml/20231025135550.13162-1-quic_sibis@quicinc.com/
rpmhpd: https://lore.kernel.org/lkml/20231025135943.13854-1-quic_sibis@quicinc.com/

Release Link: https://www.qualcomm.com/news/releases/2023/10/qualcomm-unleashes-snapdragon-x-elite--the-ai-super-charged-plat

Abel Vesa (1):
  arm64: dts: qcom: sc8380xp: Add Compute Reference Device

Rajendra Nayak (4):
  dt-bindings: arm: cpus: Add qcom,oryon compatible
  dt-bindings: arm: qcom: Document SC8380XP SoC and boards
  arm64: dts: qcom: Add base SC8380XP dtsi and the QCP dts
  arm64: defconfig: Enable SC8380XP SoC base configs

 .../devicetree/bindings/arm/cpus.yaml         |    1 +
 .../devicetree/bindings/arm/qcom.yaml         |    8 +
 arch/arm64/boot/dts/qcom/Makefile             |    2 +
 arch/arm64/boot/dts/qcom/sc8380xp-crd.dts     |  423 +++
 arch/arm64/boot/dts/qcom/sc8380xp-qcp.dts     |  398 ++
 arch/arm64/boot/dts/qcom/sc8380xp.dtsi        | 3267 +++++++++++++++++
 arch/arm64/configs/defconfig                  |    3 +
 7 files changed, 4102 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sc8380xp-crd.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc8380xp-qcp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc8380xp.dtsi

-- 
2.17.1

