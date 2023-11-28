Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77727FB1A5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 06:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343639AbjK1FxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 00:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343636AbjK1FxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 00:53:16 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFD4D5D;
        Mon, 27 Nov 2023 21:53:18 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AS5rDNq077397;
        Mon, 27 Nov 2023 23:53:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701150793;
        bh=i1CJqPlkWwulo6tpKksz+1AbJFicgkH7QGxR5iIc7fo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=SgDd9qXCdH5XtvQUcv17/XGObPqH7Z6P+nRHmloKvwQjNxJbog5LyfHz8530sc44s
         kH1QneuFR+LIq/mC788D5/7be6JdzbXO6uR+6Aeo/oX3XDeyGqAab0E3YD+FTMMr0c
         ztnotsu2EaZMh0RuBeRPqqQ6CDDqFPnL8RYKl4DQ=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AS5rDpR006281
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Nov 2023 23:53:13 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 Nov 2023 23:53:13 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 Nov 2023 23:53:13 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AS5qUuL104118;
        Mon, 27 Nov 2023 23:53:08 -0600
From:   Neha Malcom Francis <n-francis@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <a-nandan@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <eblanc@baylibre.com>, <jneanne@baylibre.com>,
        <aseketeli@baylibre.com>, <jpanis@baylibre.com>, <u-kumar1@ti.com>,
        <j-luthra@ti.com>, <vaishnav.a@ti.com>, <hnagalla@ti.com>,
        <devarsht@ti.com>, <n-francis@ti.com>
Subject: [PATCH v8 7/7] DONOTMERGE: arm64: defconfig: Enable TPS6594 PMIC for J7 devices
Date:   Tue, 28 Nov 2023 11:22:30 +0530
Message-ID: <20231128055230.342547-8-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128055230.342547-1-n-francis@ti.com>
References: <20231128055230.342547-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

J7 (J721E-EVM, J721E-SK, J721S2, AM68-SK, J784S4, AM69-SK) devices use
TPS6594x PMIC (interfaced over I2C) to power the SoC and various other
peripherals on the board [1].

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 arch/arm64/configs/defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b60aa1f89343..682251135267 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -727,7 +727,7 @@ CONFIG_MFD_SEC_CORE=y
 CONFIG_MFD_SL28CPLD=y
 CONFIG_RZ_MTU3=y
 CONFIG_MFD_TPS65219=y
-CONFIG_MFD_TPS6594_I2C=m
+CONFIG_MFD_TPS6594_I2C=y
 CONFIG_MFD_TI_AM335X_TSCADC=m
 CONFIG_MFD_ROHM_BD718XX=y
 CONFIG_MFD_WCD934X=m
-- 
2.34.1

