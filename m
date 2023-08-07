Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE18773047
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 22:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjHGUWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 16:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjHGUWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 16:22:10 -0400
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EED10EC;
        Mon,  7 Aug 2023 13:22:08 -0700 (PDT)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 3BF88207B9;
        Mon,  7 Aug 2023 22:22:06 +0200 (CEST)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jai Luthra <j-luthra@ti.com>
Subject: [PATCH v3 2/4] arm64: dts: ti: verdin-am62: Set I2S_1 MCLK rate
Date:   Mon,  7 Aug 2023 22:21:57 +0200
Message-Id: <20230807202159.13095-3-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230807202159.13095-1-francesco@dolcini.it>
References: <20230807202159.13095-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Set AUDIO_EXT_REFCLK1, used as I2S_1_MCLK on Verdin AM62 family, to 25MHz
(this is the only valid option according to TI [1]).

[1] https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1188051/am625-audio_ext_refclk1-clock-output---dts-support/4476322#4476322

Reviewed-by: Jai Luthra <j-luthra@ti.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
index 12dd1d64eac9..5db9ef2dc7e5 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
@@ -768,6 +768,11 @@ AM62X_MCU_IOPAD(0x0028, PIN_OUTPUT,       0) /* (C5) WKUP_UART0_TXD  */ /* SODIM
 	};
 };
 
+/* VERDIN I2S_1_MCLK */
+&audio_refclk1 {
+	assigned-clock-rates = <25000000>;
+};
+
 &cpsw3g {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii1>;
-- 
2.25.1

