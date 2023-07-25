Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99007761207
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbjGYK6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjGYK5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:57:44 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AA844BC
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 03:54:57 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36PAsQcE120221;
        Tue, 25 Jul 2023 05:54:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690282466;
        bh=9wmSZxLbupH3Gu+wa25/SrII2SpmiTYlcfLJ4uVTgmA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ihysFyV1CrdxHZTg2sLR+kFKfSAUvM7KpQquRN51XrxxKgETfIZr9baKljGaoNGnh
         eI6lUG361wQdT4lHzkgLyCxyr8tv8wZiU8ACEBq71etzeMqa9YPsLMsCRnVinnTaP2
         +zBmfqp6Q0mlxAFPkgElTO+fTXug7w47aJtgJlCs=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36PAsQgn113901
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Jul 2023 05:54:26 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 25
 Jul 2023 05:54:26 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 25 Jul 2023 05:54:26 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36PArnka091635;
        Tue, 25 Jul 2023 05:54:22 -0500
From:   Udit Kumar <u-kumar1@ti.com>
To:     <vigneshr@ti.com>, <nm@ti.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <quic_bjorande@quicinc.com>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <onrad.dybcio@linaro.org>,
        <krzysztof.kozlowski@linaro.org>, <nfraprado@collabora.com>,
        <rafal@milecki.pl>, <peng.fan@nxp.com>, <john.garry@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH 7/7] arm64: defconfig: Enable K3 RTI Watchdog
Date:   Tue, 25 Jul 2023 16:23:46 +0530
Message-ID: <20230725105346.1981285-8-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230725105346.1981285-1-u-kumar1@ti.com>
References: <20230725105346.1981285-1-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TI's K3 SOC Family has RTI (Real Time Interrupt) watchdog
timer.

This patch enables TI RTI watchdog driver to be built as module.

RTI watchdog are supported on AM62, AM62A, AM64, AM65,
J721E and J7200 TI SOC.

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 63ca68081139..dedf1bd9c29f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -690,6 +690,7 @@ CONFIG_UNIPHIER_WATCHDOG=y
 CONFIG_PM8916_WATCHDOG=m
 CONFIG_BCM2835_WDT=y
 CONFIG_BCM7038_WDT=m
+CONFIG_K3_RTI_WATCHDOG=m
 CONFIG_MFD_ALTERA_SYSMGR=y
 CONFIG_MFD_BD9571MWV=y
 CONFIG_MFD_AXP20X_I2C=y
-- 
2.34.1

