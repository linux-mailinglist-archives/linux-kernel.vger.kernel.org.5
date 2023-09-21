Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553F77AA6A2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 03:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjIVBpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 21:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjIVBpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 21:45:02 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D78DE8;
        Thu, 21 Sep 2023 18:44:57 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38L69mkK027712;
        Thu, 21 Sep 2023 01:09:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695276588;
        bh=0FHzT/UzdC7kEsIcWXfh6Bvh6/HWCUWUejbHcTfolxI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=i0uQwQ6rNPul7aFCCNLkt/JDm17x5/TgqGPk9CCWEQtIZJSWp1FtiKf7GPHQ5TD4X
         lqSaBGu2Ge8oqdQ+byqMrxCR/L0CDNULvepUEXs2nKrMnXAaTgLj5Fe3NB5xXwfEyG
         Ma5qRVDKdKmrckukwx+FSA0CrUxTnHQZSZgK08UE=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38L69mHI031374
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Sep 2023 01:09:48 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Sep 2023 01:09:48 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Sep 2023 01:09:48 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38L69mCN009922;
        Thu, 21 Sep 2023 01:09:48 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.199])
        by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 38L69lUf007043;
        Thu, 21 Sep 2023 01:09:48 -0500
From:   MD Danish Anwar <danishanwar@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC:     <afd@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <r-gunasekaran@ti.com>, <danishanwar@ti.com>
Subject: [PATCH v2 4/4] arm64: defconfig: Enable TI_ICSSG_PRUETH
Date:   Thu, 21 Sep 2023 11:39:13 +0530
Message-ID: <20230921060913.721336-5-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921060913.721336-1-danishanwar@ti.com>
References: <20230921060913.721336-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Programmable Real-time Unit and Industrial Communication Subsystem
Gigabit (PRU_ICSSG) is a low-latency microcontroller subsystem in the TI
K3 SoCs such as AM654x, AM64x. This subsystem is provided for the use
cases like implementation of custom peripheral interfaces, offloading of
tasks from the other processor cores of the SoC, etc.

Currently AM654x-EVM uses ICSSG driver.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5f77f5d1fe94..4e6e3cefcd67 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -368,6 +368,7 @@ CONFIG_SNI_NETSEC=y
 CONFIG_STMMAC_ETH=m
 CONFIG_DWMAC_TEGRA=m
 CONFIG_TI_K3_AM65_CPSW_NUSS=y
+CONFIG_TI_ICSSG_PRUETH=m
 CONFIG_QCOM_IPA=m
 CONFIG_MESON_GXL_PHY=m
 CONFIG_AQUANTIA_PHY=y
-- 
2.34.1

