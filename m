Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A26783DF7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbjHVKbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbjHVKbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:31:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4FDE62;
        Tue, 22 Aug 2023 03:30:30 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37M4rWjt030192;
        Tue, 22 Aug 2023 10:29:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=kvYCf82jllt8N53t4jDI8+KY9HjIzpuC3xsuryVUhTw=;
 b=R+jLTWzT1h5ThemwWIwhI6Pxr2iFvF6CnuhhgharPJUDSSkcqtriRZMyx7QwU6VzQA1y
 t0R+JqI9Q3cCJQo2jsXiziz2n4KRJ1Mo90cS65UM53+WsOUE3m4pf4y3Ax01R2owKlFy
 Uhm6eGiVBpnVQbgy1uBT0zduLyPQU7punO6hz6UqHhwOlkR0tBo5f8l8GgHWqLufaGPA
 PZH9Pr3dC1L2Zo2OzUa9d+V7SWbvzSMnD9uEOsLyTqTTuqs5pMeC/KyywxScuu3ECuJW
 1hRzCnp0mow7bfZ7tDsY7qbMe3TiTry9RGu4sXYz+3Wuzzb7bqkYlLOftDwC0bpyuJy+ UQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sm6f9tq9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 10:29:53 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37MATpW2027700
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 10:29:51 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 22 Aug 2023 03:29:45 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <arnd@arndb.de>, <geert+renesas@glider.be>,
        <nfraprado@collabora.com>, <rafal@milecki.pl>, <peng.fan@nxp.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-phy@lists.infradead.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v9 0/4] Enable IPQ5332 USB2
Date:   Tue, 22 Aug 2023 15:59:11 +0530
Message-ID: <cover.1692699472.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UIdfSrUgYG6RtcvZeOvKcghm8WYQmlnD
X-Proofpoint-ORIG-GUID: UIdfSrUgYG6RtcvZeOvKcghm8WYQmlnD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_10,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=404 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308220080
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds the relevant phy and controller
DT configurations for enabling USB2 on IPQ5332

v9:
	Driver: Since the driver code has been picked up for merge,
		(https://lore.kernel.org/linux-arm-msm/169226613917.81413.1200008047604336868.b4-ty@kernel.org/)
		adding the coding style fixes alone in this patch.

		Fix line break alignment
		Remove register success print
	DTS:	usb2@8a00000 -> usb@8a00000
		regulator_fixed_5p0: s0500 -> regulator_fixed_5p0: regulator
v8:
	Driver:-
		Change commit subject and message per review comments
		Don't include of_platform.h
		Change struct initialization coding style
		GENMASK -> BIT for one of the defines
v7:
	Binding:-
		Move 'compatible' to be the first entry
		In the example have 'usb-phy' instead of 'usb2-phy'
		Add 'Reviewed-by: Krzysztof Kozlowski'
v6:
	Binding and dts:-
		Dropped the qcom,dwc3.yaml patch as it has been picked up for linux-next
		Add const to compatible, vdd-supply
		Move nodes per register address
	Driver:-
		Add vdd-supply
		Cleanup error paths in probe with dev_err_probe
v5:
	Binding and dts:-
		Fix email id
		Removed 'Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>'
		as had to change bindings file to be able to use generic phy instead of
		usb-phy

	Driver:-
		Remove unused definition
		Use generic phy instead of usb-phy
v4:
	Binding and dts:-
		Change node name (bindings & dts)
	Driver:-
		Remove unused enum
		static const for '.data'
		Error handling for devm_clk_get
v3:
	Fix bindings file based on review comments

v1:
	Cleanup DTS
	Combine driver, kconfig and makefile patches
	Remove unused functions from M31 driver
	Drop the clock driver changes

Varadarajan Narayanan (4):
  phy: qcom: m31: Fix indentation issues
  arm64: dts: qcom: ipq5332: Add USB related nodes
  arm64: dts: qcom: ipq5332: Enable USB
  arm64: defconfig: Enable M31 USB phy driver

 arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts | 23 ++++++++++++
 arch/arm64/boot/dts/qcom/ipq5332.dtsi       | 55 +++++++++++++++++++++++++++++
 arch/arm64/configs/defconfig                |  1 +
 drivers/phy/qualcomm/phy-qcom-m31.c         |  8 ++---
 4 files changed, 82 insertions(+), 5 deletions(-)

-- 
2.7.4

