Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A197C7A28
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 01:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443201AbjJLXDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 19:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443106AbjJLXDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 19:03:20 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE32513D
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 16:03:10 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c60778a3bfso13428785ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 16:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697151790; x=1697756590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFPxN5h4Yz/Kh95Kwg/dHQdP+2ryagu2J01cqKKyODk=;
        b=lYm6XMvvuI34p/F7s115FrGfqboNSfFM9IzGFXqKhIWKanwzxXtyZzN179mm/jB4c3
         AYZHGZC/ljXxOD8CNb5BcNZZhSQdSQ8hU/mkkAfs2sKbIsFoueuMKn9uTKi2f74xmp+Q
         rEt0jFXFGrjPJHR5mOWgTI4TqfXsg/yPaQ2K8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697151790; x=1697756590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EFPxN5h4Yz/Kh95Kwg/dHQdP+2ryagu2J01cqKKyODk=;
        b=n5OTJAQXLE4OErNDMzMrmW0xKNXbLTd1rSQzwgzR7PR8v93Auzhb13UGW94KxLZdwQ
         MrmTLCbX7k0xD0UpGFloJCdNToHmfx7YUrw1YupdbetU7v5AUrNzK0cg3/W1gg4cm2I/
         5aQZaoDy+F4fKaJZMPNUcm5Ytxr5wrVC+q8ZEBNdpEdQxDqoDjJwW/Mmwaq3/SSjddHC
         KyfFwVwmjN0z5k3XeF2gKlU9Qm23TLavPRGgRB8WmE0iXORHIN9SpILZaDtaUzrQenmJ
         +zCo9BKM4t+V5dtBpfwneWvZzrrIn4T06zZMHJT/uK3rscMz+bhuzzE/AKnXWOZursJy
         kDzw==
X-Gm-Message-State: AOJu0YxPmOFFI5pHTwK0NXUuvht7bQ2OQw+J4kRhnK7D6+sYece6TuN4
        4GiYoG48LQtvXOAImzQmZobgHuRnZqpLaqqsktE+WQ==
X-Google-Smtp-Source: AGHT+IEwiBTYiXyw0ylqmM0RWi8WMP5G5S+LI3ARjay2AD+Tzo7msM4hIoDmDwH8vRIRJqHScqQhSA==
X-Received: by 2002:a17:902:d481:b0:1c8:7d21:fc50 with SMTP id c1-20020a170902d48100b001c87d21fc50mr24606295plg.56.1697151789811;
        Thu, 12 Oct 2023 16:03:09 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:7397:2561:ed13:bac8])
        by smtp.gmail.com with ESMTPSA id g11-20020a1709026b4b00b001c613091aeasm2494390plt.297.2023.10.12.16.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 16:03:09 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] arm64: dts: mediatek: Add MT8186 Magneton Chromebooks
Date:   Fri, 13 Oct 2023 07:02:35 +0800
Message-ID: <20231012230237.2676469-10-wenst@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231012230237.2676469-1-wenst@chromium.org>
References: <20231012230237.2676469-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entries for the MT8186 based Chromebooks, also collectively known
as the Lenovo IdeaPad Slim 3 Chromebook (14M868). It is also based on
the "Steelix" design. Being a laptop instead of a convertible device,
there is no touchscreen or stylus, which is similar to Rusty. However
Magneton does not have ports on the right side of the device.

Three variants are listed separately. These use different touchscreen
controllers, or lack a touchscreen altogether.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/Makefile         |  3 ++
 .../mt8186-corsola-magneton-sku393216.dts     | 38 +++++++++++++++++++
 .../mt8186-corsola-magneton-sku393217.dts     | 38 +++++++++++++++++++
 .../mt8186-corsola-magneton-sku393218.dts     | 21 ++++++++++
 4 files changed, 100 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-magneton-sku393216.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-magneton-sku393217.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-magneton-sku393218.dts

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 6b05f1f2e645..7e365e9516ab 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -43,6 +43,9 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku32.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku0.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-magneton-sku393216.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-magneton-sku393217.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-magneton-sku393218.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-rusty-sku196608.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-steelix-sku131072.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-steelix-sku131073.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-magneton-sku393216.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-magneton-sku393216.dts
new file mode 100644
index 000000000000..7406e7a29fcc
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-magneton-sku393216.dts
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2022 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8186-corsola-steelix.dtsi"
+
+/ {
+	model = "Google Magneton board";
+	compatible = "google,steelix-sku393216", "google,steelix-sku393219",
+		     "google,steelix", "mediatek,mt8186";
+	chassis-type = "laptop";
+};
+
+/delete-node/ &gpio_keys;
+/delete-node/ &touchscreen;
+
+&i2c1 {
+	touchscreen: touchscreen@10 {
+		compatible = "hid-over-i2c";
+		reg = <0x10>;
+		interrupt-parent = <&pio>;
+		interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&touchscreen_pins>;
+		reset-gpios = <&pio 60 GPIO_ACTIVE_LOW>;
+		vdd-supply = <&pp3300_s3>;
+		status = "okay";
+
+		post-power-on-delay-ms = <350>;
+		hid-descr-addr = <0x0001>;
+	};
+};
+
+&usb_c1 {
+	status = "disabled";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-magneton-sku393217.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-magneton-sku393217.dts
new file mode 100644
index 000000000000..b1806e0b2782
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-magneton-sku393217.dts
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2022 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8186-corsola-steelix.dtsi"
+
+/ {
+	model = "Google Magneton board";
+	compatible = "google,steelix-sku393217", "google,steelix-sku393220",
+		     "google,steelix", "mediatek,mt8186";
+	chassis-type = "laptop";
+};
+
+/delete-node/ &gpio_keys;
+/delete-node/ &touchscreen;
+
+&i2c1 {
+	touchscreen: touchscreen@40 {
+		compatible = "hid-over-i2c";
+		reg = <0x40>;
+		interrupt-parent = <&pio>;
+		interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&touchscreen_pins>;
+		reset-gpios = <&pio 60 GPIO_ACTIVE_LOW>;
+		vdd-supply = <&pp3300_s3>;
+		status = "okay";
+
+		post-power-on-delay-ms = <450>;
+		hid-descr-addr = <0x0001>;
+	};
+};
+
+&usb_c1 {
+	status = "disabled";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-magneton-sku393218.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-magneton-sku393218.dts
new file mode 100644
index 000000000000..c70f196f115b
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-magneton-sku393218.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2022 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8186-corsola-steelix.dtsi"
+
+/ {
+	model = "Google Magneton board";
+	compatible = "google,steelix-sku393218", "google,steelix-sku393221",
+		     "google,steelix", "mediatek,mt8186";
+	chassis-type = "laptop";
+};
+
+/delete-node/ &gpio_keys;
+/delete-node/ &touchscreen;
+
+&usb_c1 {
+	status = "disabled";
+};
-- 
2.42.0.655.g421f12c284-goog

