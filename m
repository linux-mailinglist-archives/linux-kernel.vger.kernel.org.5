Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3972D78C6A3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236608AbjH2N7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236625AbjH2N7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:59:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D166EF7;
        Tue, 29 Aug 2023 06:59:19 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37TBvbRQ009117;
        Tue, 29 Aug 2023 13:58:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=h6LCmQBCZjYiUZTFKUb5sVImFewIAym44AztjmzSBYw=;
 b=VEZuhekY3A7olexkjpPob2/b7VKY0q1TdBD+TWahZZbzPCk2ENCg5NfJtzSV9uFEbjOx
 v+OADOmNkhhYcn7Qvk/oGGdHaT8fDD/wsCZgPqJMrIx30PD3tnUaQJfkDlQiIgGMY7gY
 8Ts03ESPBWKA5eK11yptmaN7F9biIzmYBqXDbDXZQStz1iTdU43crrSmoREO6bybrs5G
 PKiKft+de7whVH8lBH5ytkrQI+wtDxJQwMSVtF7qIcqXcBw0N0TLzElVtZ3wP2sUo4YC
 Q98/4FgaSwow84HTGxZrLIyxXx4M9WMaRrc+6fw6BDr1sZ0saMp9QYYlNtDFaxFJGudt bg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ss4wq1k32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 13:58:54 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37TDwqFV001896
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 13:58:52 GMT
Received: from hu-ipkumar-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 29 Aug 2023 06:58:45 -0700
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
To:     <robert.marko@sartura.hr>, <luka.perkov@sartura.hr>,
        <quic_ipkumar@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <nfraprado@collabora.com>,
        <rafal@milecki.pl>, <peng.fan@nxp.com>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     <quic_varada@quicinc.com>
Subject: [PATCH 2/9] phy: qcom: uniphy: Rename ipq4019 USB phy driver to UNIPHY driver
Date:   Tue, 29 Aug 2023 19:28:11 +0530
Message-ID: <20230829135818.2219438-3-quic_ipkumar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829135818.2219438-1-quic_ipkumar@quicinc.com>
References: <20230829135818.2219438-1-quic_ipkumar@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SqdI_HzsLN3j1btFwZkiniH7JqPuL-Rl
X-Proofpoint-ORIG-GUID: SqdI_HzsLN3j1btFwZkiniH7JqPuL-Rl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_11,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 mlxscore=0 adultscore=0
 mlxlogscore=927 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UNIPHY / Combo PHY used on various qualcomm SoC's are very similar to
ipq4019 PHY. Hence renaming this driver to uniphy driver and can be
used for other SoC's which are having the similar UNIPHY.

Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
---
 MAINTAINERS                                                | 7 ++++---
 drivers/phy/qualcomm/Kconfig                               | 7 ++++---
 drivers/phy/qualcomm/Makefile                              | 2 +-
 .../qualcomm/{phy-qcom-ipq4019-usb.c => phy-qcom-uniphy.c} | 0
 4 files changed, 9 insertions(+), 7 deletions(-)
 rename drivers/phy/qualcomm/{phy-qcom-ipq4019-usb.c => phy-qcom-uniphy.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index ff1f273b4f36..7f4553c1a69a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17774,13 +17774,14 @@ F:	Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
 F:	drivers/mailbox/qcom-ipcc.c
 F:	include/dt-bindings/mailbox/qcom-ipcc.h
 
-QUALCOMM IPQ4019 USB PHY DRIVER
+QUALCOMM UNIPHY DRIVER
 M:	Robert Marko <robert.marko@sartura.hr>
 M:	Luka Perkov <luka.perkov@sartura.hr>
+M:	Praveenkumar I <quic_ipkumar@quicinc.com>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/phy/qcom-usb-ipq4019-phy.yaml
-F:	drivers/phy/qualcomm/phy-qcom-ipq4019-usb.c
+F:	Documentation/devicetree/bindings/phy/qcom,uniphy.yaml
+F:	drivers/phy/qualcomm/phy-qcom-uniphy.c
 
 QUALCOMM IPQ4019 VQMMC REGULATOR DRIVER
 M:	Robert Marko <robert.marko@sartura.hr>
diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
index d891058b7c39..e6981bc212b3 100644
--- a/drivers/phy/qualcomm/Kconfig
+++ b/drivers/phy/qualcomm/Kconfig
@@ -28,12 +28,13 @@ config PHY_QCOM_EDP
 	  Enable this driver to support the Qualcomm eDP PHY found in various
 	  Qualcomm chipsets.
 
-config PHY_QCOM_IPQ4019_USB
-	tristate "Qualcomm IPQ4019 USB PHY driver"
+config PHY_QCOM_UNIPHY
+	tristate "Qualcomm UNIPHY driver"
 	depends on OF && (ARCH_QCOM || COMPILE_TEST)
 	select GENERIC_PHY
 	help
-	  Support for the USB PHY-s on Qualcomm IPQ40xx SoC-s.
+	  Enable this driver to support the Qualcomm UNIPHY found in various
+	  Qualcomm chipsets.
 
 config PHY_QCOM_IPQ806X_SATA
 	tristate "Qualcomm IPQ806x SATA SerDes/PHY driver"
diff --git a/drivers/phy/qualcomm/Makefile b/drivers/phy/qualcomm/Makefile
index ffd609ac6233..7460e1a427d2 100644
--- a/drivers/phy/qualcomm/Makefile
+++ b/drivers/phy/qualcomm/Makefile
@@ -2,7 +2,7 @@
 obj-$(CONFIG_PHY_ATH79_USB)		+= phy-ath79-usb.o
 obj-$(CONFIG_PHY_QCOM_APQ8064_SATA)	+= phy-qcom-apq8064-sata.o
 obj-$(CONFIG_PHY_QCOM_EDP)		+= phy-qcom-edp.o
-obj-$(CONFIG_PHY_QCOM_IPQ4019_USB)	+= phy-qcom-ipq4019-usb.o
+obj-$(CONFIG_PHY_QCOM_UNIPHY)		+= phy-qcom-uniphy.o
 obj-$(CONFIG_PHY_QCOM_IPQ806X_SATA)	+= phy-qcom-ipq806x-sata.o
 obj-$(CONFIG_PHY_QCOM_M31_USB)		+= phy-qcom-m31.o
 obj-$(CONFIG_PHY_QCOM_PCIE2)		+= phy-qcom-pcie2.o
diff --git a/drivers/phy/qualcomm/phy-qcom-ipq4019-usb.c b/drivers/phy/qualcomm/phy-qcom-uniphy.c
similarity index 100%
rename from drivers/phy/qualcomm/phy-qcom-ipq4019-usb.c
rename to drivers/phy/qualcomm/phy-qcom-uniphy.c
-- 
2.34.1

