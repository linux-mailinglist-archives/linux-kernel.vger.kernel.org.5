Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00B480046A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 08:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377703AbjLAHID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 02:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235194AbjLAHHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 02:07:52 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB6F1BC1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:07:55 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-53fa455cd94so164018a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701414475; x=1702019275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eaC0buh7aEVblHqvJfrsnZTUVZcIwutzgrSrvSUna1w=;
        b=fUvDD4rz8CslmK5eHEUGTZzX+fbbYy1V54JONtRotWeHBEnJnGRI/O1Iy9eDOcKw5z
         +4jJ2tDcgAkRPG1hImwF1REq69VNfJYLfpqXsviMLEu6F0qPsYcDfptCiLQ75u9fRX9S
         xJzhLCirkB2nOg7skUB40YEiibdN4I2wkPYe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701414475; x=1702019275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eaC0buh7aEVblHqvJfrsnZTUVZcIwutzgrSrvSUna1w=;
        b=NNivS3aHPh632zAYW8ezzKGdzNmRLHRLV8FuzT15sISGovCVOzYWwlWxlvrN03mWPV
         Hdf+ZF+ayW6qJj5gbAvbKiQjPdV8VGrLB1YYSmheRihz0Pum9tYK6GRMQrHloJhknCTQ
         rGM39bOMHlo+fWHY6FS3wNEBjMs0LzbK4a9ICUl6rqWxOreeRyS1K/OtjPVRBrLyS0fO
         LiGXe7ASwnlPpVHiyxsaoD3rlpaVTOkP9gl23aPFdCn7X2unjClRmgwK4IZYZvuzKZTl
         1YPpfNY1QIDLarAq1wSs8Fd2PrUqjzgwVNPTTVIx+cu6pXiZBZEAo+wPIiON6HEoJjSx
         hhZg==
X-Gm-Message-State: AOJu0YzS/2TDdIQQySZvFjWitbmIBedHkKF97xec6lEXCif7TxTX1Rzj
        fw4i4DMgSwGmvhxKgePBIxYfhQ==
X-Google-Smtp-Source: AGHT+IHT4YSH9zK0GVooFrGQk5IfvBVb8uWpQf447as3BXXX4IM+f8biPC8Li1pf69Fd6heoaLDsFA==
X-Received: by 2002:a17:90b:1e4f:b0:285:a65c:64e7 with SMTP id pi15-20020a17090b1e4f00b00285a65c64e7mr18456103pjb.18.1701414474776;
        Thu, 30 Nov 2023 23:07:54 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:720a:d435:c253:2402])
        by smtp.gmail.com with ESMTPSA id y10-20020a1709027c8a00b001cfa0c04553sm2558684pll.116.2023.11.30.23.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 23:07:54 -0800 (PST)
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
Subject: [PATCH v2 8/9] arm64: dts: mediatek: Add MT8186 Steelix platform based Rusty
Date:   Fri,  1 Dec 2023 15:07:12 +0800
Message-ID: <20231201070719.1229447-9-wenst@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231201070719.1229447-1-wenst@chromium.org>
References: <20231201070719.1229447-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT8186 Rusty, otherwise known as the Lenovo 100e Chromebook Gen 4, is an
MT8186 based laptop. It is based on the "Steelix" design. Being a laptop
instead of a convertible device, there is no touchscreen or stylus.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
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

