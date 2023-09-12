Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381E679D0F2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbjILMZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234391AbjILMZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:25:23 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [5.144.164.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0055E10D7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 05:25:18 -0700 (PDT)
Received: from [192.168.2.137] (bband-dyn191.178-41-225.t-com.sk [178.41.225.191])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id D33E13F5B9;
        Tue, 12 Sep 2023 14:25:16 +0200 (CEST)
From:   Martin Botka <martin.botka@somainline.org>
Date:   Tue, 12 Sep 2023 14:25:13 +0200
Subject: [PATCH v3 2/2] arm64: dts: allwinner: h616: Add SID controller
 node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-sid-h616-v3-2-ee18e1c5bbb5@somainline.org>
References: <20230912-sid-h616-v3-0-ee18e1c5bbb5@somainline.org>
In-Reply-To: <20230912-sid-h616-v3-0-ee18e1c5bbb5@somainline.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Alan Ma <tech@biqu3d.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694521515; l=864;
 i=martin.botka@somainline.org; s=20230811; h=from:subject:message-id;
 bh=ZkRao+SoGyLWR0re//2OndxkkGjlXhC9ot4zAnROi5I=;
 b=XrAr5Dq648hOA4X5B5E+GpIsCY3dbSG7kKzZxn5+eFGBJ06i8BZkVYBTB7ZNxYw5a3l9/uoxg
 nhUy0hjKKoyBIYjT+a/XbiD8lw1Eg61oXHapvFvRFoQt4npqjPcDPA5
X-Developer-Key: i=martin.botka@somainline.org; a=ed25519;
 pk=aTCd3jmwU8GrJidWg3DSKLpdVMcpFzXzCSLXLR6NtWU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add node for the H616 SID controller

Signed-off-by: Martin Botka <martin.botka@somainline.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
index 74aed0d232a9..d549d277d972 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
@@ -133,6 +133,13 @@ ccu: clock@3001000 {
 			#reset-cells = <1>;
 		};
 
+		sid: efuse@3006000 {
+			compatible = "allwinner,sun50i-h616-sid", "allwinner,sun50i-a64-sid";
+			reg = <0x03006000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
 		watchdog: watchdog@30090a0 {
 			compatible = "allwinner,sun50i-h616-wdt",
 				     "allwinner,sun6i-a31-wdt";

-- 
2.42.0

