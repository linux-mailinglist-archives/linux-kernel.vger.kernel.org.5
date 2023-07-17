Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A14756571
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjGQNs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjGQNrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:47:48 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4CF13E;
        Mon, 17 Jul 2023 06:47:41 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36HCFANQ015564;
        Mon, 17 Jul 2023 15:46:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=vSMfDNFzu4+99zvWf7Ylziy8xE7+meIevjquHFgBM4U=;
 b=3PYVlfAji+tyt9KhK3ZPksh+tgQ1B3IctqyEEg9dtIjoaIqT/3+7c9MtGndOy7tSsYB3
 7un3lZe7K66CgZoFDH9klgZc7Sw2X7tr7066+myXg3quZIwXQyI59IIq8pze0DFeqQFE
 KHoJPzn3os6ZLwlhumOBYx0M72zi4sgepsfdxdpebGuNDVsuUAwOeZLquqUURYWRgbt9
 bbCuBq5s15DyDpg0TCoHjKnlByqgrGzzZABkEDCjSSi7uA4XmPgUni+NHydc6/fCSBR+
 x+N9HsyVRR+BWHAX1UNLwe2kJzHN9NHAKClWQPPapjhphgIj8pcr9b7W8DFlp52qYfD2 NA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rw3f0tdqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 15:46:32 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E953610002A;
        Mon, 17 Jul 2023 15:46:31 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E20142248AD;
        Mon, 17 Jul 2023 15:46:31 +0200 (CEST)
Received: from localhost (10.201.22.238) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 17 Jul
 2023 15:46:31 +0200
From:   <p.paillet@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <p.paillet@foss.st.com>
Subject: [PATCH] ARM: dts: stm32: fix dts check warnings on stm32mp15-scmi
Date:   Mon, 17 Jul 2023 15:46:27 +0200
Message-ID: <20230717134627.2064553-1-p.paillet@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.22.238]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_11,2023-07-13_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pascal Paillet <p.paillet@foss.st.com>

Fix dts check warnings on stm32mp15-scmi reported by
arm,scmi.yaml.

Signed-off-by: Pascal Paillet <p.paillet@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp15-scmi.dtsi | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/st/stm32mp15-scmi.dtsi b/arch/arm/boot/dts/st/stm32mp15-scmi.dtsi
index ad2584213d99..dc3b09f2f2af 100644
--- a/arch/arm/boot/dts/st/stm32mp15-scmi.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15-scmi.dtsi
@@ -34,22 +34,21 @@ scmi_reguls: regulators {
 					#address-cells = <1>;
 					#size-cells = <0>;
 
-					scmi_reg11: reg11@0 {
+					scmi_reg11: regulator@0 {
 						reg = <0>;
 						regulator-name = "reg11";
 						regulator-min-microvolt = <1100000>;
 						regulator-max-microvolt = <1100000>;
 					};
 
-					scmi_reg18: reg18@1 {
-						voltd-name = "reg18";
+					scmi_reg18: regulator@1 {
 						reg = <1>;
 						regulator-name = "reg18";
 						regulator-min-microvolt = <1800000>;
 						regulator-max-microvolt = <1800000>;
 					};
 
-					scmi_usb33: usb33@2 {
+					scmi_usb33: regulator@2 {
 						reg = <2>;
 						regulator-name = "usb33";
 						regulator-min-microvolt = <3300000>;
-- 
2.25.1

