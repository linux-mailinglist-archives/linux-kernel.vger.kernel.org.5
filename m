Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13AA67742C7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbjHHRuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbjHHRtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:49:53 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2267A26E75;
        Tue,  8 Aug 2023 09:22:09 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 378D1god092296;
        Tue, 8 Aug 2023 08:01:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691499702;
        bh=R3zerq9nODVi0XA4kBDsD9dXj9JRrwEm+jQuwFr4OMU=;
        h=From:To:CC:Subject:Date;
        b=ol7xLBKPWOauOoiOAyflqQtRIH4WTX4CrPbhTZ4aRo4MDKLu/y/Q0jmkaQxTQd6F7
         OJUAVZKXAPidQOKG+1Azkj+HJdBOQZ2PF11oDgINhgrh97b7/Y3/iNvWVvRPamfIkN
         lmXCSPTraJEjlqrOzW5VHcxtSYHqEikyXdBz7zNw=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 378D1g6k089299
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Aug 2023 08:01:42 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Aug 2023 08:01:41 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Aug 2023 08:01:41 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 378D1fD8019028;
        Tue, 8 Aug 2023 08:01:41 -0500
Received: from localhost (uda0501179.dhcp.ti.com [172.24.227.217])
        by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 378D1fDA012689;
        Tue, 8 Aug 2023 08:01:41 -0500
From:   MD Danish Anwar <danishanwar@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>
CC:     Peng Fan <peng.fan@nxp.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, <srk@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, MD Danish Anwar <danishanwar@ti.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: [PATCH v4] arm64: defconfig: Enable TI PRUSS
Date:   Tue, 8 Aug 2023 18:31:31 +0530
Message-ID: <20230808130131.3081482-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Programmable Realtime Unit - Industrial Communication Subsystem
(PRU-ICSS) known as PRUSS, is a low-latency microcontroller subsystem
used for industrial networking and other hard real-time functions in
the TI K3 SoCs such as AM654x, AM64x.

AM654x-EVM, AM64xx-EVM, and iot2050 use the PRUSS driver.

Reviewed-by: Christian Gmeiner <christian.gmeiner@gmail.com>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>

Changes from v3 to v4:
*) Rebased on the latest next-20230808 linux-next.
*) Modified commit-message to add details on PRUSS driver and the SoCs
   supported. (address comments from v2 - Konard's and v3 - Nishanth's)

v3: https://lore.kernel.org/all/20230807105919.2611138-1-danishanwar@ti.com/
v2: https://lore.kernel.org/all/20230804061811.3999129-1-danishanwar@ti.com/
v1: https://lore.kernel.org/all/20230419095051.3269777-1-danishanwar@ti.com/

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index bf13d5c46578..0aecdf43a5d1 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1339,6 +1339,7 @@ CONFIG_ARCH_TEGRA_186_SOC=y
 CONFIG_ARCH_TEGRA_194_SOC=y
 CONFIG_ARCH_TEGRA_234_SOC=y
 CONFIG_TI_SCI_PM_DOMAINS=y
+CONFIG_TI_PRUSS=m
 CONFIG_ARM_IMX_BUS_DEVFREQ=y
 CONFIG_ARM_IMX8M_DDRC_DEVFREQ=m
 CONFIG_ARM_MEDIATEK_CCI_DEVFREQ=m
-- 
2.34.1

