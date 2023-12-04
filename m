Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC39802E15
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343630AbjLDImx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 03:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234909AbjLDImk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 03:42:40 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9FAD4F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 00:42:39 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6cdde2aeb64so4132623b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 00:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701679358; x=1702284158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ljd2T3j+VnPx33d4ekX7y2D1w1JW97BW4rSuy9Dt1c=;
        b=gP3euRbGZCwntW1zC9Bwhj1piBkxvxHGyJn8R2GxW6qn3A8P6zLcxXZ7XRWnffD1tD
         qXei/XynG3toU2wxcjX19n8RzccgvBEcRc/TFCaR/K51Moy3ZmVpA7fR6PdbXh6HHcp4
         QyMJ8udBKlOT5XOokhYKisi77cdCAfGp1qLcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701679358; x=1702284158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ljd2T3j+VnPx33d4ekX7y2D1w1JW97BW4rSuy9Dt1c=;
        b=ehv2VOLX/AU6BiqmfHrHvuM0MNqnt4GWfMVWQCdwpkzJ9+UuvVKjbuuDBbsIa2fuKN
         +d3F2Ew85dtMAI4tFUrPhirw8uHC6YI9q3QWgQqOTxCX9nnn2IeAS+ST8+g+O09sVHh5
         ZuMqnIgDzloqwPlZfuaGkHOvf6pGF9Ug0zVGcGBtc97RtnzYKG+QzwVHFGkn0SzctHmH
         4/efWqsA9hvQW7Axfy+8eiMlGI5PFQDEh7gTZtuGGvrcpGoPojDdzX26M59mwo7fYp3t
         Fv46w2TTBDghWEYGzhK9p5MNuGxS+ujtWtgtG4y1mTDDK7IY5ZXyYMAqocNdDHcJ5V6Y
         iC2g==
X-Gm-Message-State: AOJu0Yx8IJVhXBd0TPu/oXDBg5baJwtz8d06laxSjoKMejCKBu9c+XXr
        3Aa5w9V26OTpiAbZ0jBSBntAYw==
X-Google-Smtp-Source: AGHT+IG/GF8Pm6cp3cedzDbB0NGJWF0gnZO6NRRQ4bKoSNmp32TEAouKqNXVEdPy5ZsKsd52VrR9qQ==
X-Received: by 2002:a05:6a20:938d:b0:18f:97c:6165 with SMTP id x13-20020a056a20938d00b0018f097c6165mr4702348pzh.98.1701679358550;
        Mon, 04 Dec 2023 00:42:38 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:6084:72e2:9ac2:f115])
        by smtp.gmail.com with ESMTPSA id p14-20020a1709028a8e00b001cfc3f73927sm7871795plo.9.2023.12.04.00.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 00:42:38 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 8/9] arm64: dts: mediatek: Add MT8186 Steelix platform based Rusty
Date:   Mon,  4 Dec 2023 16:40:10 +0800
Message-ID: <20231204084012.2281292-9-wenst@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231204084012.2281292-1-wenst@chromium.org>
References: <20231204084012.2281292-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT8186 Rusty, otherwise known as the Lenovo 100e Chromebook Gen 4, is an
MT8186 based laptop. It is based on the "Steelix" design. Being a laptop
instead of a convertible device, there is no touchscreen or stylus.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes since v2:
- Picked up Conor's ack

Changes since v1:
- Reorder SKU numbers in descending order.
- Mark missing components as disabled instead of deleting the node

 arch/arm64/boot/dts/mediatek/Makefile         |  1 +
 .../mt8186-corsola-rusty-sku196608.dts        | 26 +++++++++++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-rusty-sku196608.dts

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 7bd9471b89f9..6b05f1f2e645 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -43,6 +43,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku32.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku0.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-rusty-sku196608.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-steelix-sku131072.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-steelix-sku131073.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-tentacool-sku327681.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-rusty-sku196608.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-rusty-sku196608.dts
new file mode 100644
index 000000000000..731b0d60228d
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-rusty-sku196608.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2022 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8186-corsola-steelix.dtsi"
+
+/ {
+	model = "Google Rusty board";
+	compatible = "google,steelix-sku196609", "google,steelix-sku196608",
+		     "google,steelix", "mediatek,mt8186";
+	chassis-type = "laptop";
+};
+
+&gpio_keys {
+	status = "disabled";
+};
+
+&i2c1 {
+	status = "disabled";
+};
+
+&touchscreen {
+	status = "disabled";
+};
-- 
2.43.0.rc2.451.g8631bc7472-goog

