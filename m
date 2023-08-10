Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B32E776D0B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 02:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjHJAcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 20:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjHJAcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 20:32:16 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78586171D;
        Wed,  9 Aug 2023 17:32:16 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-48719fc6b18so181776e0c.1;
        Wed, 09 Aug 2023 17:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691627535; x=1692232335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AEiKUtISslzw0u4/RZ7vc8PRpS44NmY8OTpXVsqjKHA=;
        b=Yk+e3Cc63ReHF+OiwOuOdHJxxhR8F2SBFYFx5BKHEXFBg+ecQrghgvmbwkwI0xy5Wn
         PNedePPxttZlO3gUJy3+/99953huFOTG11/jBoormaZOq2JWKX6R/EXt7sJmhRm16wdd
         kFcZUDubO641EkNjMpnj24+4S6D0a6wQbJ6KbZxjhV8HiEJfVn+wRbUCp/whOLu1icm9
         4xfSXFEpWuS8/K9B88wByZhJ0Cl3WWIuRDbn6zHkP5XMC4gh2BtIV3n3l0Rsit9zS2kQ
         LLZ/0wGZjiD1xfq3QIlNr8Npjz06UfMOwutkLidgHCY9ssYWUI0KQI5TVvOywShG7saL
         BKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691627535; x=1692232335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AEiKUtISslzw0u4/RZ7vc8PRpS44NmY8OTpXVsqjKHA=;
        b=fw4Al/VF26xewz/PUkpJv0ezlul9ML8oho7QRtvxFgRF1Kav5VOmjWVTVhYBeeH6GX
         wwIgwtF9qFeZaGbDTnK/tCRg4BxLYZlerJsPuVs9q+QtVfFc5Tjb07ytOatqzbTpgzZi
         885oHfpPLJ4oo/O5IngKudQVp50RhGJSBLNXlfVIJehkwTPdFdtPJGqKGbwR6v/+PWku
         1/dRbf3xPgMlq59KjTdazbzjuzzqqga8Vyhn5xUHhLDhyPjZ7exQhk6AvwKsOof2KIst
         sLrb6qAsSn7zkywwmWqIefC2inLVTJ3EtCggbiH0uUQII8PYu0rOCbCmIfB4ApzpHA72
         /thA==
X-Gm-Message-State: AOJu0YzfVUQ46qL8jkvQQlavsJuxVv9RQjw5gqxxkfQBgNBx3RHEVHBC
        WdLWAWuM2WcEDDmz3gzcYGUPI/44j4Y3AQ==
X-Google-Smtp-Source: AGHT+IEyNAum/4L8A8X6NkPGBCyAbDeeTrV7WXo7FZrfCVifvevcs/m6iTSswbN1TGanTRR7YIEgKQ==
X-Received: by 2002:a1f:5f02:0:b0:487:110d:7177 with SMTP id t2-20020a1f5f02000000b00487110d7177mr1134379vkb.12.1691627535507;
        Wed, 09 Aug 2023 17:32:15 -0700 (PDT)
Received: from localhost.localdomain (cpe-107-15-246-199.nc.res.rr.com. [107.15.246.199])
        by smtp.gmail.com with ESMTPSA id x13-20020a0ce24d000000b0063d31b493e1sm69098qvl.99.2023.08.09.17.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 17:32:14 -0700 (PDT)
From:   John Clark <inindev@gmail.com>
To:     "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Heiko Stuebner" <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     "Thomas McKahan" <tmckahan@singleboardsolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, John Clark <inindev@gmail.com>
Subject: [PATCH] arm64: dts: rockchip: Add NanoPC T6 PCIe Ethernet support
Date:   Thu, 10 Aug 2023 00:31:56 +0000
Message-Id: <20230810003156.22123-1-inindev@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device tree entries for PCIe 2.5G Ethernet NICs

Signed-off-by: John Clark <inindev@gmail.com>
---
 .../boot/dts/rockchip/rk3588-nanopc-t6.dts    | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts
index cec126a77111..0bd80e515754 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts
@@ -115,6 +115,16 @@ vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
 		vin-supply = <&vcc4v0_sys>;
 	};
 
+	vcc_3v3_pcie20: vcc3v3-pcie20-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_3v3_pcie20";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_3v3_s3>;
+	};
+
 	vbus5v0_typec: vbus5v0-typec-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -140,6 +150,18 @@ vcc3v3_pcie30: vcc3v3-pcie30-regulator {
 	};
 };
 
+&combphy0_ps {
+	status = "okay";
+};
+
+&combphy1_ps {
+	status = "okay";
+};
+
+&combphy2_psu {
+	status = "okay";
+};
+
 &cpu_l0 {
 	cpu-supply = <&vdd_cpu_lit_s0>;
 };
@@ -391,6 +413,22 @@ i2s0_8ch_p0_0: endpoint {
 	};
 };
 
+&pcie2x1l0 {
+	reset-gpios = <&gpio4 RK_PB3 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc_3v3_pcie20>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie2_0_rst>;
+	status = "okay";
+};
+
+&pcie2x1l2 {
+	reset-gpios = <&gpio4 RK_PA4 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc_3v3_pcie20>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie2_2_rst>;
+	status = "okay";
+};
+
 &pcie30phy {
 	status = "okay";
 };
@@ -425,6 +463,14 @@ hym8563_int: hym8563-int {
 	};
 
 	pcie {
+		pcie2_0_rst: pcie2-0-rst {
+			rockchip,pins = <4 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		pcie2_2_rst: pcie2-2-rst {
+			rockchip,pins = <4 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
 		pcie_m2_0_pwren: pcie-m20-pwren {
 			rockchip,pins = <2 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
-- 
2.40.1

