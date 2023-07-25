Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89E676096E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 07:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjGYFj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 01:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjGYFjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 01:39:21 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A01819B1;
        Mon, 24 Jul 2023 22:39:17 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36P5d65T059849;
        Tue, 25 Jul 2023 00:39:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690263546;
        bh=/EXsNOFgFH3u1MSZBrCxKLAc7fekFmeZSeuVT53WoU0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=YHnQRjMACmCMgt9GgVTDNDXPZd+242X/wV2gv6CVJ5p6WoYU3iaOP3neacjm4CigP
         8qI+tyXRLKNQ0V4MHMTgvsoWxlSeRF7PiF6QxejxJJcBdNhlICb6c0U3S0aVQ0fsyr
         tIRuGi+nzaHLvIdvPhKlfIeD58sGnOXVsb7nIuqM=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36P5d6Dt017701
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Jul 2023 00:39:06 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 25
 Jul 2023 00:39:06 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 25 Jul 2023 00:39:06 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36P5cu77064880;
        Tue, 25 Jul 2023 00:39:03 -0500
From:   Udit Kumar <u-kumar1@ti.com>
To:     <vigneshr@ti.com>, <nm@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Udit Kumar <u-kumar1@ti.com>, Chai Wenle <Wenle.Chai@windriver.com>
Subject: [PATCH 2/2] arm64: dts: ti: k3-j784s4-evm: Add Support for UFS peripheral
Date:   Tue, 25 Jul 2023 11:08:43 +0530
Message-ID: <20230725053843.1721028-3-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230725053843.1721028-1-u-kumar1@ti.com>
References: <20230725053843.1721028-1-u-kumar1@ti.com>
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

J784S4 EVM board has 32GB Non-Volatile UFS Memory.
So enabling UFS at board level.

UFS flash details are documented in board data sheet[1]
Section 1.2 Key Features and Interfaces.

[1] https://www.ti.com/lit/pdf/spruj62

Cc: Chai Wenle <Wenle.Chai@windriver.com>
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index 7ad152a1b90f..1e38a8f1bec5 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -430,6 +430,10 @@ &main_uart8 {
 	pinctrl-0 = <&main_uart8_pins_default>;
 };
 
+&ufs_wrapper {
+	status = "okay";
+};
+
 &fss {
 	status = "okay";
 };
-- 
2.34.1

