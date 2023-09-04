Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70271791172
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 08:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345916AbjIDGhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 02:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjIDGhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 02:37:11 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AA2E6;
        Sun,  3 Sep 2023 23:37:08 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3845Fdmq001539;
        Mon, 4 Sep 2023 06:36:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=89RcUyhMnjJtUWMhoDWPC9MHW8icZsJddUJgR+8CO1M=;
 b=I6Q38rg0qEfpr2X74sfE3RYhYJDNF2tpIA/WmSNGv8x8ExhNZmXe/6jxdlHFQHoiQMtV
 ZLakxu2ocbhmOBYdGvtKZxPZRdX5Z4T7Iid2ai4IUsMBRfpLR4wyxuVLUbm9zS+FxQRv
 KKYZJSeMDarW1F0EkzV/rwr4UjB/uwRCXe/lpQfg8Om1SJAPGxZDYlwAjHtsVmN87Wl3
 TnRfP5MqC63pP3DWwnM5dTnBDCqCuaErXQ4BJFvuo27r1w4UDQy7IrmPpf6y4DjY+N36
 TAauTNXwBgS27v7XTjlqadr9M+d5P+FS9PgiBqn09UAsoby0E+1/vGd/gj0kXlvkf/Br 0A== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3suwtptvay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Sep 2023 06:36:57 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3846auZP020199
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Sep 2023 06:36:56 GMT
Received: from nsekar-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Sun, 3 Sep 2023 23:36:51 -0700
From:   Nitheesh Sekar <quic_nsekar@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
CC:     Nitheesh Sekar <quic_nsekar@quicinc.com>
Subject: [PATCH V4 0/4] Enable IPQ5018 USB2 support
Date:   Mon, 4 Sep 2023 12:06:31 +0530
Message-ID: <20230904063635.24975-1-quic_nsekar@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3o6eI6TC6fHZ4viJ27ev_LGJ3bJVEiP9
X-Proofpoint-GUID: 3o6eI6TC6fHZ4viJ27ev_LGJ3bJVEiP9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_03,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 mlxlogscore=492
 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309040059
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds the relevant phy and controller
DT configurations for enabling USB2 host mode support
on IPQ5018.

Tested with a USB Mass storage device.

Depends on:
Link: https://lore.kernel.org/linux-arm-msm/20230831030503.17100-1-quic_nsekar@quicinc.com/

[V4]:
	Add C99 initializers.
	Write 0 register values.

[V3]:
	Incorporated review comments with respect to
	naming USB related device tree nodes,
	dropped the 0 dealy inits and added the static const
	type for m31_ipq5018_regs.
	Sorted nodes in	board specific device tree file.

[V2]:
	Incorporated review comments regarding splitting the
	series as per subsytem, device tree naming conventions
	and ordereing of the nodes.

Nitheesh Sekar (4):
  dt-bindings: phy: qcom,m31: Add IPQ5018 compatible
  phy: qcom-m31: Add compatible, phy init sequence for IPQ5018
  arm64: dts: qcom: ipq5018: Add USB related nodes
  arm64: dts: qcom: ipq5018: Enable USB

 .../bindings/phy/qcom,ipq5332-usb-hsphy.yaml  |  4 +-
 .../arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts | 12 +++++
 arch/arm64/boot/dts/qcom/ipq5018.dtsi         | 54 +++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-m31.c           | 51 ++++++++++++++++++
 4 files changed, 120 insertions(+), 1 deletion(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

