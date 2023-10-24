Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1A27D5D2F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 23:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbjJXV0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 17:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344178AbjJXV0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 17:26:30 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C6F133
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:26:27 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c9b95943beso41592665ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698182787; x=1698787587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2dmeSI4v9358eF9Xt6D4Fy7YCDY8dJsKHs01cKRDtU=;
        b=H8ddV685psRdKA+QUvxMhpWR8rjvzBH9uZfIoIzoL7s8+9QqdqKlPrNBBpe1Ov+xV9
         8scNWvHAkBYHS22afjQ5Xs65Y0BGVEVP5jujjw8CEBkbQcL8EkXKlb3hdMEmpEZulsY8
         a8MgaRZZAjlSRdKH73R/1nhMyyvYeMV6/FQKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698182787; x=1698787587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2dmeSI4v9358eF9Xt6D4Fy7YCDY8dJsKHs01cKRDtU=;
        b=mLQl1GkIVdb0gzsMSqI6rwP1aykzK4A89ZGnOc84v9UsXActjDQLXJ67m4YBAbdPpp
         LEHJF2c5OUZ8vPmLJgb/O/nsopDgIe9wk9EXPupPCEcVy9qXzYq+YCjGXrWCLifpctZK
         mzbfwNKPYyXpnemLuOjmlgxbIGy15orfSSokOGBX63q4UwHoBxFrqOPwZcmR0xQA3+Pw
         s/0fC0Nxmnjkv6gwvEQZoFYEGvnaWAKD7NsBS+HAG5snAxKluth0zKesZ4v+/7kXY5lU
         c1emjL228E0Gs8F/j1AF3TDWuCUbgG2+Ba/UKRm0Lwm16Euzp+FevUCzdkoRnAUa/IDL
         bOaw==
X-Gm-Message-State: AOJu0YzRAuZuOqa3PyEsSswP/Hem7nCQH02pVvyCs1kFkhym81VaBoWZ
        DjNCNxOKyM1QsjcplPKFtytHOQ==
X-Google-Smtp-Source: AGHT+IHrhw2npik+3CuCrqC1k6Tl6nZchhwtz1ITQtz4ptgQ+uKtpPDikebU4ebMokZbGpKDIZRUkw==
X-Received: by 2002:a17:902:c942:b0:1c9:dcea:33e5 with SMTP id i2-20020a170902c94200b001c9dcea33e5mr14179872pla.67.1698182786986;
        Tue, 24 Oct 2023 14:26:26 -0700 (PDT)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:5a2d:c345:7f3f:d26c])
        by smtp.gmail.com with ESMTPSA id p9-20020a170902e74900b001b850c9d7b3sm7824140plf.249.2023.10.24.14.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:26:26 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>,
        =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 3/7] arm64: dts: mt8183: Add kukui katsu board
Date:   Tue, 24 Oct 2023 14:22:25 -0700
Message-ID: <20231024212618.1079676-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
In-Reply-To: <20231024212618.1079676-1-hsinyi@chromium.org>
References: <20231024212618.1079676-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

katsu is also known as ASUS Chromebook Detachable CZ1.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
v1->v2: non sku38 is sku32
---
 arch/arm64/boot/dts/mediatek/Makefile         |  2 +
 .../dts/mediatek/mt8183-kukui-katsu-sku32.dts | 40 +++++++++++++++++
 .../dts/mediatek/mt8183-kukui-katsu-sku38.dts | 44 +++++++++++++++++++
 3 files changed, 86 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku32.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku38.dts

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index e6e7592a3645..a13419e67e8e 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -36,6 +36,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-willow-sku0.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-willow-sku1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kakadu.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kakadu-sku22.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-katsu-sku32.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-katsu-sku38.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku16.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku272.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku288.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku32.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku32.dts
new file mode 100644
index 000000000000..9fa205c06c74
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku32.dts
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2023 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8183-kukui-kakadu.dtsi"
+#include "mt8183-kukui-audio-da7219-rt1015p.dtsi"
+
+/ {
+	model = "Google katsu board";
+	chassis-type = "tablet";
+	compatible = "google,katsu-sku32", "google,katsu", "mediatek,mt8183";
+};
+
+&i2c0 {
+	status = "okay";
+
+	/delete-node/touchscreen@10;
+	touchscreen1: touchscreen@5d {
+		compatible = "goodix,gt7375p";
+		reg = <0x5d>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&open_touch>;
+
+		interrupt-parent = <&pio>;
+		interrupts = <155 IRQ_TYPE_LEVEL_LOW>;
+
+		reset-gpios = <&pio 156 GPIO_ACTIVE_LOW>;
+		vdd-supply = <&lcd_pp3300>;
+	};
+};
+
+&panel {
+	compatible = "starry,2081101qfh032011-53g";
+};
+
+&qca_wifi {
+	qcom,ath10k-calibration-variant = "GO_KATSU";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku38.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku38.dts
new file mode 100644
index 000000000000..472a5a3ea25c
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku38.dts
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2023 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8183-kukui-kakadu.dtsi"
+#include "mt8183-kukui-audio-rt1015p.dtsi"
+
+/ {
+	model = "Google katsu sku38 board";
+	chassis-type = "tablet";
+	compatible = "google,katsu-sku38", "google,katsu", "mediatek,mt8183";
+};
+
+&i2c0 {
+	status = "okay";
+
+	/delete-node/touchscreen@10;
+	touchscreen1: touchscreen@5d {
+		compatible = "goodix,gt7375p";
+		reg = <0x5d>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&open_touch>;
+
+		interrupt-parent = <&pio>;
+		interrupts = <155 IRQ_TYPE_LEVEL_LOW>;
+
+		reset-gpios = <&pio 156 GPIO_ACTIVE_LOW>;
+		vdd-supply = <&lcd_pp3300>;
+	};
+};
+
+&panel {
+	compatible = "starry,2081101qfh032011-53g";
+};
+
+&qca_wifi {
+	qcom,ath10k-calibration-variant = "GO_KATSU";
+};
+
+&sound {
+	compatible = "mediatek,mt8183_mt6358_ts3a227_rt1015p";
+};
-- 
2.42.0.758.gaed0368e0e-goog

