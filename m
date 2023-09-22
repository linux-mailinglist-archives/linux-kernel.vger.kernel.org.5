Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5171F7AAC33
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjIVILr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbjIVIL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:11:26 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71923172E;
        Fri, 22 Sep 2023 01:11:19 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38M3Q0Kl013675;
        Fri, 22 Sep 2023 10:11:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type; s=selector1; bh=MTu0R7MXciBuzjCEVdjU
        /QJRAV5+/VKJ/ZcovBKuFoA=; b=0DzImxo/0qhlvZmuMhJ6Ucv9NGKVv0xCVhvy
        /++pSMJoyvdI4kLNruWLB9ZTn4a6LuUpUt9XyXDmcaGT4PuUQoUteEOipi52Ik3t
        BUesQDqbncfRU1JtM5GtURESM4+ZnplqMG1xB2k/l72iq41xa3PFyyNadmw3mtCh
        ZwA+8Pye7kzRXNeRNXjLn+hJ5uBBNqZdrkSjDlOgiZqr41O80ArsG1Hy9TOm/Nxn
        ejkP+RQzrafVJe5m4fJyMn2f/fElJJuLEJ/kWiwHeQhBO66NCqK/6clC2rdfgn2c
        KcgNeUlI7eOKbywk7rEwIlPs0IL2N8LuTH+Bn3N1qoRGwawTYg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t8tt7j9ju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 10:11:02 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3230A10005F;
        Fri, 22 Sep 2023 10:11:02 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2B31021230D;
        Fri, 22 Sep 2023 10:11:02 +0200 (CEST)
Received: from localhost (10.201.21.122) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 10:11:01 +0200
From:   Alexandre Torgue <alexandre.torgue@foss.st.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] arm64: dts: st: enable secure arm-wdt watchdog on stm32mp257f-ev1
Date:   Fri, 22 Sep 2023 10:10:55 +0200
Message-ID: <20230922081055.6242-3-alexandre.torgue@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230922081055.6242-1-alexandre.torgue@foss.st.com>
References: <20230922081055.6242-1-alexandre.torgue@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.21.122]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_06,2023-09-21_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the watchdog and define the default timeout to 32 seconds.

Signed-off-by: Lionel Debieve <lionel.debieve@foss.st.com>
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
index 6c3b83c2b48f..85891124a3a9 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
@@ -63,6 +63,11 @@
 	status = "okay";
 };
 
+&arm_wdt {
+	timeout-sec = <32>;
+	status = "okay";
+};
+
 &usart2 {
 	pinctrl-names = "default", "idle", "sleep";
 	pinctrl-0 = <&usart2_pins_a>;
-- 
2.17.1

