Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D5A7D244B
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 18:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjJVQTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 12:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbjJVQTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 12:19:22 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBC2114;
        Sun, 22 Oct 2023 09:19:20 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-4197fa36b6aso14660461cf.3;
        Sun, 22 Oct 2023 09:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697991559; x=1698596359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=51yoIPIuPIQY2xrhDSozZ8zZaCC3jRFcHjFfojAFMEs=;
        b=BV+Qj9P+5om2F/jZ5KbjlqEYDOLuTSK0WgwgUg/Qur5EODcJjxtm1HAhHx9CGOXLIi
         hewcH22aiv9+onjJG0C+ILufwXnVivHFCcNNiAVSYGhvE+uXIb4NZ4InfQUqmX6bQK0G
         IztDEty1oaCNNzm4Hf5O14qL1rwA89Z5TpFMYZu7FIJOGrpC1HO22HwwdpOrNon73fIi
         HbwCPmMumQ+exxw8d8jrbfYMVX1a28lPaRpfuWNC5Om1UNAIqk0Xv2YBwJHYMpITapXO
         UvTq+HN9kEnIasNw9PLvqGtz3V7fOdwf9tz24FAaGqP2+vW8c4GD6gQs3ufvvHrTedSJ
         3ILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697991559; x=1698596359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=51yoIPIuPIQY2xrhDSozZ8zZaCC3jRFcHjFfojAFMEs=;
        b=Yfc/IWNsKNatA/h4I/43HEVNEZ1KucRBr1gzbF5QKcyjIlgxepOD2YOUnbapQ3xI29
         SbP5Q3ltu4RVfHs/m/SeuxcMrexI35b+OJlxy6VquT2/OVZbs0RcWg/uvsCKcG2dlK5K
         Is5v/nsSEkzNAa+rokBotq6roW2KxP9oAp3ny3N0gxi3gsG4H8kFch98m1rhrHVKn8Vk
         gZbYwXIPm/SV+SDDN54/TeCZmm62c8PGpw1r8ejCSSv5In4pD9RxOiERXK9lTwwnUC2l
         kYMzFp+O+8l7I1NCJkU9rT1EklUPFABFlkjpGFisFjKwEnHypb+HyXZHXIZF/p41mjSI
         lIiA==
X-Gm-Message-State: AOJu0Yy72MCu2hh1qa2ebHplJConPbNHGVOVZicX55X9oGP8E1R3lEi5
        991pSWWZDPD8Cz1N+JCegwA=
X-Google-Smtp-Source: AGHT+IF1J+2YfIOkfenkxN0ecNMu8q8DtSMdTCz1taKAmJyUrM2SEiQ6YiScGAphry5OBXtbcwoGVw==
X-Received: by 2002:ac8:5d44:0:b0:41c:d1e7:27b5 with SMTP id g4-20020ac85d44000000b0041cd1e727b5mr9043611qtx.25.1697991559036;
        Sun, 22 Oct 2023 09:19:19 -0700 (PDT)
Received: from aford-System-Version.lan ([2601:447:d002:5be:a07c:e734:336b:c675])
        by smtp.gmail.com with ESMTPSA id r2-20020ac85202000000b004197079f2f8sm2111177qtn.64.2023.10.22.09.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 09:19:18 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     alexander.stein@ew.tq-group.com, aford@beaconembedded.com,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] arm64: dts: imx8mp: Add NPU Node
Date:   Sun, 22 Oct 2023 11:19:10 -0500
Message-Id: <20231022161911.10792-1-aford173@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NPU is based on the Vivante GC8000 and its power-domain
is controlled my pgc_mlmix.  Since the power-domain uses
some of these clocks, setup the clock parent and rates
inside the power-domain, and add the NPU node.

The data sheet states the CLK_ML_AHB should be 300MHz for
nominal, but 800MHz clock will divide down to 266 instead.
Boards which operate in over-drive mode should update the
clocks on their boards accordingly.  When the driver loads,
the NPU numerates as:

 etnaviv-gpu 38500000.npu: model: GC8000, revision: 8002

Signed-off-by: Adam Ford <aford173@gmail.com>
---

V2:  Move the clock parent and rate assignments to the ppc_mlmix node
     since clock parents should be configured before they are used,
     and pgc_mlmix uses them first.
     Slow the clock rates down to confirm to nominal mode instead of
     overdrive mode.

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index c9a610ba4836..a18b9ba98ea2 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -887,6 +887,15 @@ pgc_mlmix: power-domain@24 {
 						clocks = <&clk IMX8MP_CLK_ML_AXI>,
 							 <&clk IMX8MP_CLK_ML_AHB>,
 							 <&clk IMX8MP_CLK_NPU_ROOT>;
+						assigned-clocks = <&clk IMX8MP_CLK_ML_CORE>,
+								  <&clk IMX8MP_CLK_ML_AXI>,
+								  <&clk IMX8MP_CLK_ML_AHB>;
+						assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_800M>,
+									 <&clk IMX8MP_SYS_PLL1_800M>,
+									 <&clk IMX8MP_SYS_PLL1_800M>;
+						assigned-clock-rates = <800000000>,
+								       <800000000>,
+								       <300000000>;
 					};
 				};
 			};
@@ -2012,6 +2021,18 @@ vpumix_blk_ctrl: blk-ctrl@38330000 {
 			interconnect-names = "g1", "g2", "vc8000e";
 		};
 
+		npu: npu@38500000 {
+			compatible = "vivante,gc";
+			reg = <0x38500000 0x200000>;
+			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk IMX8MP_CLK_NPU_ROOT>,
+				 <&clk IMX8MP_CLK_NPU_ROOT>,
+				 <&clk IMX8MP_CLK_ML_AXI>,
+				 <&clk IMX8MP_CLK_ML_AHB>;
+			clock-names = "core", "shader", "bus", "reg";
+			power-domains = <&pgc_mlmix>;
+		};
+
 		gic: interrupt-controller@38800000 {
 			compatible = "arm,gic-v3";
 			reg = <0x38800000 0x10000>,
-- 
2.40.1

