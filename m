Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C7580AA4A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574408AbjLHRN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235987AbjLHRNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:13:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB911BD0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 09:13:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C14FC433CA;
        Fri,  8 Dec 2023 17:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702055604;
        bh=8ebnwItR1hA/vG3C99K441+Vr5JnEbuXL+hnQjJvrlA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TAmcUMkQgVIofiBroeXwmP8mYZXdKSioXvQqiTLBvW9FPtTQyLwDLPGNmlvNVFqQR
         +uvda5arfvyt8eCWgXSMAye8qqDTSZ+PSAkqV9bZW28SldC4Mw0RJeD6uu91Vjcriu
         apQz1mzct1m0LYg4klTqSlxLE6qgOEHKpKekm9fZgg4X2Zh7EVsseQWYA+a6yR/TF1
         9zSisp+eO+ecV1QL2SW4sMhh42lDxErTvJ0MQZ+UB4l9Ja+swIeeXTfyFUjtrSV1Hb
         Mt1jyhNSDg3fI/xKqdCPocb/CmYyU61CqN5q/3jKVB5H2LdS812ZRlZ1R57I/HbuXA
         alZ+axg3839rw==
From:   Conor Dooley <conor@kernel.org>
To:     linux-riscv@lists.infradead.org
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH RESEND v1 7/7] riscv: dts: microchip: add missing CAN bus clocks
Date:   Fri,  8 Dec 2023 17:12:29 +0000
Message-Id: <20231208-resample-selection-3c2c8cecc489@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231208-reenter-ajar-b6223e5134b3@spud>
References: <20231208-reenter-ajar-b6223e5134b3@spud>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1347; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=RYPfJmYcs7V5ACe/34q2uMhx5X6TiyQw/MbNSCCgx2w=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKnFfhWd25pCLOOPcTcWOnLsarjXMGNLbUqY/C/Nuy4uX ksOVJ3pKGVhEONgkBVTZEm83dcitf6Pyw7nnrcwc1iZQIYwcHEKwEQazzL84f1mHnxx+6Gvt77X 30v2q376f8XhnOeVFya7hUQJGGkFrmb4H/WOae21x1cDEzZY1l1xvbswMWRqwJp1er9vPps4sey TOzMA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

The CAN controller on PolarFire SoC has an AHB peripheral clock _and_ a
CAN bus clock. The bus clock was omitted when the binding was written,
but is required for operation. Make up for lost time and add to the DT.

Fixes: 38a71fc04895 ("riscv: dts: microchip: add mpfs's CAN controllers")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/microchip/mpfs.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/mpfs.dtsi b/arch/riscv/boot/dts/microchip/mpfs.dtsi
index 266489d43912..4d70df0f908c 100644
--- a/arch/riscv/boot/dts/microchip/mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs.dtsi
@@ -416,7 +416,7 @@ i2c1: i2c@2010b000 {
 		can0: can@2010c000 {
 			compatible = "microchip,mpfs-can";
 			reg = <0x0 0x2010c000 0x0 0x1000>;
-			clocks = <&clkcfg CLK_CAN0>;
+			clocks = <&clkcfg CLK_CAN0>, <&clkcfg CLK_MSSPLL3>;
 			interrupt-parent = <&plic>;
 			interrupts = <56>;
 			status = "disabled";
@@ -425,7 +425,7 @@ can0: can@2010c000 {
 		can1: can@2010d000 {
 			compatible = "microchip,mpfs-can";
 			reg = <0x0 0x2010d000 0x0 0x1000>;
-			clocks = <&clkcfg CLK_CAN1>;
+			clocks = <&clkcfg CLK_CAN1>, <&clkcfg CLK_MSSPLL3>;
 			interrupt-parent = <&plic>;
 			interrupts = <57>;
 			status = "disabled";
-- 
2.39.2

