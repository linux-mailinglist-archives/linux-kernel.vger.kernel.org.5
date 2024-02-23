Return-Path: <linux-kernel+bounces-78112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8529860F0D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48C0FB26255
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5225D902;
	Fri, 23 Feb 2024 10:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDIAnpoM"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BCA5D73E;
	Fri, 23 Feb 2024 10:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708683448; cv=none; b=a4U1NSn9GEl/wgCZD3XZL/YlDWLTTRoOLjBIFyqgyayJSBxZTgTMql9c9Te0BLKjb+v98xIatW5okJRAk+vsHNpJe3qoNfPQTvpvUXQv5PL10P9ayMzOH16MwyZgcbjf0zbAeJY/DWAHvxqc1giDZeP3XNZuk8vOQXN/AspqE4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708683448; c=relaxed/simple;
	bh=r1avm1HU/toYNUFcWO/X2baMVifnIIcezeoOB2bpc4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kEs05AKkpoatTZkTsOG72FCDsHDWbGpEpJu2vaHZQ4SF3ip4rggQ2mMNjYT7449f0zggrHsiaGEjEZB4/DXNfiTeL2fAAI9e1knhRUBO6nUqavzcdH1WvpT8lwSyFyvluAbXBcaA4QaDx7okvsQ4Ok14b6YuS+m+8PeG92OytbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDIAnpoM; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3e891b5e4eso74029166b.0;
        Fri, 23 Feb 2024 02:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708683445; x=1709288245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SDnyKS3QNE5QbkDew8ZYn7NVYP9CWlivkQitTepgpqI=;
        b=RDIAnpoMj9nC/5C3RLiUBeW201hyV1o51zITpn5nWhfzKTkwN6ISXr5S3NsiV8S/80
         bpXCBFl0nvGqf2My+8MpsOZVRWscPbH26lxdsXzgdZpgWz3mp7i8+D/hBROGW4IXhF4r
         kqXOvG3EdQssgc0mk4pTi872ibpWKSZ/34YJgrH3u5HC6iZc1NsSzkIFb2TMbeCMZ63r
         llsG5/epn0CPg9wwpNOAntUHhY3XZmwt0jhigPcGtTe70AGeb5wdVsPZr+uL0ZTkDhSw
         3AOa+xidzeIzuhYyttc/5oycv4Vn7Xp2xJ1/8TSFyzwImDr6VUwD9vdKqPtdTDYj7rMl
         L5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708683445; x=1709288245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SDnyKS3QNE5QbkDew8ZYn7NVYP9CWlivkQitTepgpqI=;
        b=STO5UDTQZ25OY+slAkMXFL/tWmuUcNy6aYTdz4pJXN9xN/gOr8HS65FKKNK1iXe8Sj
         6RS0ZSG/Ag9/+XBbPnl8HJAAJJQPRr/NtxUVqKzXQalZlaOybPhDJ/mXmSyQ6bibQbQ6
         /ikgtJktgG/VgDUZUW9YAaHyHOE/ylVJcYMBgHFS5friaXsBiaK1yKFlVWVsN72c/dny
         TXJCDz2J5gO80bi45SnacaXtmbASW8WSE5vXKGtZxzDJzoZdbIXvvB9XsBSnqcmfA4hm
         YITYHzC/hWLhBHg5Mz+s+1qEeJpdaDdJpVkQawXRbS6a8XD9rRi/VWENMfeC9yvwkFkJ
         +v5w==
X-Forwarded-Encrypted: i=1; AJvYcCW/cQSq5U7D1HvgOB/l1SDF6D9lfNlut/wDNiUvGL7PoJJ2OvWI7feUvLvCbBSnsE4l7epsT6mRSkz1JxQ+ewSWA49q/n8nrTdg5ZbEvc7WySe6grgB1/LeydRMEQETvqjTAMF3DMZGIQ==
X-Gm-Message-State: AOJu0YzCJwSlFYjj7xtNa/wS0OHyMZVcnkwBZemFVv0Fj+eHjyMPA4ta
	YvE+4YpnJCE0Uo8vc67xI+eywXlLflFyblUbCUL1BaprAUXPKxCc
X-Google-Smtp-Source: AGHT+IGLzGErmk49F6mmcrzLRayF6ZuwlDFpL6n1RrViLMs4HRmJNjhxukyy2BSZR9VhdOsfsPpDqw==
X-Received: by 2002:a17:906:2844:b0:a3e:792f:3955 with SMTP id s4-20020a170906284400b00a3e792f3955mr972977ejc.62.1708683445424;
        Fri, 23 Feb 2024 02:17:25 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id ti7-20020a170907c20700b00a3d99dc3f3asm6667250ejc.67.2024.02.23.02.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 02:17:25 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sean Wang <sean.wang@mediatek.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 4/4] arm64: dts: mediatek: Add Cudy WR3000 V1
Date: Fri, 23 Feb 2024 11:17:09 +0100
Message-Id: <20240223101709.30072-5-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240223101709.30072-1-zajec5@gmail.com>
References: <20240223101709.30072-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

Cudy WR3000 V1 is an MT7981B (AKA Filogic 820) based wireless router. It
has 256 MiB of RAM, some LEDs & buttons and (not described yet) 4
Ethernet ports.

There is one slightly uncommon LED with a label of globe icon described
in the Quick Installation Guide as having 2 meanings:
1. "Not connected to the Internet"
2. "Connected to the Internet"

Vendor designed it to light up when some Internet-accessible IP can be
reached. This change will be follow by an attempt to define some
predefined FUNCTION for it.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V2: Reorder properties
    Describe online LED

 arch/arm64/boot/dts/mediatek/Makefile         |  1 +
 .../dts/mediatek/mt7981b-cudy-wr3000-v1.dts   | 74 +++++++++++++++++++
 2 files changed, 75 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7981b-cudy-wr3000-v1.dts

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 37b4ca3a87c9..96da4ad640aa 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -8,6 +8,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-bananapi-bpi-r64.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt7981b-cudy-wr3000-v1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7981b-xiaomi-ax3000t.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-acelink-ew-7886cax.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt7981b-cudy-wr3000-v1.dts b/arch/arm64/boot/dts/mediatek/mt7981b-cudy-wr3000-v1.dts
new file mode 100644
index 000000000000..2a988218039c
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt7981b-cudy-wr3000-v1.dts
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+
+/dts-v1/;
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+
+#include "mt7981b.dtsi"
+
+/ {
+	compatible = "cudy,wr3000-v1", "mediatek,mt7981b";
+	model = "Cudy WR3000 V1";
+
+	memory@40000000 {
+		reg = <0 0x40000000 0 0x10000000>;
+		device_type = "memory";
+	};
+
+	keys {
+		compatible = "gpio-keys";
+
+		key-wps {
+			label = "WPS";
+			gpios = <&pio 0 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_WPS_BUTTON>;
+		};
+
+		key-reset {
+			label = "RESET";
+			gpios = <&pio 1 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_RESTART>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_WAN;
+			gpios = <&pio 5 GPIO_ACTIVE_LOW>;
+		};
+
+		led-1 {
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_WLAN_2GHZ;
+			gpios = <&pio 6 GPIO_ACTIVE_LOW>;
+		};
+
+		led-2 {
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_WLAN_5GHZ;
+			gpios = <&pio 7 GPIO_ACTIVE_LOW>;
+		};
+
+		led-3 {
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_LAN;
+			gpios = <&pio 9 GPIO_ACTIVE_LOW>;
+		};
+
+		led-4 {
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_STATUS;
+			gpios = <&pio 10 GPIO_ACTIVE_LOW>;
+		};
+
+		led-5 {
+			color = <LED_COLOR_ID_BLUE>;
+			function = "wan-online";
+			gpios = <&pio 11 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
-- 
2.35.3


