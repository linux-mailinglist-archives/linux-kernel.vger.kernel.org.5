Return-Path: <linux-kernel+bounces-105581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC4787E0B7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 23:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FFFB1F214C5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 22:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BD12557A;
	Sun, 17 Mar 2024 22:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPkQszlq"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBBC23746;
	Sun, 17 Mar 2024 22:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710714745; cv=none; b=Kdp+nc+KZqHiuUq/vFKr07ckciY65kn42/rD9TnPbi1U9dKq+93CIfuvr/N5t3+S37Ig/Y4eJ/WZ3C6jTwgAvbW/gp9g4GmCFGIZrtwoWLS97Oqus+/nPAbd0hIm8VvQGZW44Nsyd6D+NE6nArXJdkVBhsSylmtdSZWQsQHXVmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710714745; c=relaxed/simple;
	bh=9yzyrDN81BQBeuzAcXfPQr71wFGa6jCxRAxxbexBciM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xdoe+1tE9uUFVJi2XoPLWmz0LMhqkjFP80DZAgFVhOPL+y0d75BYaMFpsS7qytRp57D3di7x8UZyE7v0SY4TbWz3A6TcqimhQt/i51xoMDQZg8WOMr6uahZbD/vKSOTihsTwnxPb7PI6Wpu5qQwcbnVUjExxi8a+sIQSzdm7Dhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPkQszlq; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-513e6778112so559186e87.1;
        Sun, 17 Mar 2024 15:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710714742; x=1711319542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQKJEwfEplP6JjgBfQ2Wo7rsgECn3udsg3gjV1fc2yY=;
        b=EPkQszlqfujHbczaHsYw+L26YaY5umJdWTANfsB3u/ahEwI4mbe3TTvO+RXgVyDSOK
         dNCTFEI7af8xXzvFUfCQpksvtbtH7RMYbVLlT+9sWyHCnP5M+QyWeH5prTGJV3ZXCBMs
         8quKISIlstgoOJ3Uh/wae/zRXjDgvQi1+Cfhm3nft+4WCHSnRabhXyMC3+Btr9hN23vp
         i9i3++uZSd2zMFQH1cOiAqPIRWkgZ9ME3DFxeb4g/GpGpSIrNJnr2cmi6DyRxgVMT/wf
         QML8FfoYExaLokU20kpiqv/AU5eFJtXoCu4VRAPSshWgPbwx6KuGy7SL4NUXrLE4To/L
         xqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710714742; x=1711319542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQKJEwfEplP6JjgBfQ2Wo7rsgECn3udsg3gjV1fc2yY=;
        b=wvPv8zZQzx7hmepdhR1yRTPAMoY1xmCZUY2qBor2zSSM5gqsG0FoRMUuTkQLsTD4rU
         aMHUwVDgXcw3LDBKexDnVmU4d4c2SI66VUrvCGxUr58qOTue+vdqv2cjCdyn//+pbYbq
         B+ePyjbGLc1qGYfzNsdik2cGOISs/7jsPFsjvItjAZX0n2yYQTXiAqUHxfttBAWnbZ8i
         MbsnyNsTHJkl6j82socEb/fpHIpBhL4SG9XiVNKB6P+vAiQvOp8mmMJi5HIrCoPRqmDd
         9RasHfU0C8rUQc4gXqa1PCElgkmxBwMrcQBwEAOyT1IcTsJ0NIgRtn30OBDsijeKnOQp
         f3uw==
X-Forwarded-Encrypted: i=1; AJvYcCWIJIKqRBH1yRteBUjJB741La1Uz7kKj+O7RyfR6uXC9xtw8gMJIFDoZZHrzcQOISCM46qIDYYi6mvJyVfbCtEKgvKZdxQjY6j/8AJyIRuY+TeKXr8RDnhqkO/cA4VYi/Krj2DOhozr9w==
X-Gm-Message-State: AOJu0Yx1fLLjjk1MvcN84QTTtkzB29DqdgeyHdOfLVMgqE8J0HO4lPLr
	Lo1SGNBQ/CY+mAT1W2hD2YbLqYB9kLFKSThmrMvCF7q2vIgjJ5Tk
X-Google-Smtp-Source: AGHT+IEwNc4ima+GSWJaUtWXJEWy0YYhhPyRNlX/kRbMLWlU4kdKjBgpLrJ6aPAuwYLXcwpcIHprDQ==
X-Received: by 2002:ac2:4992:0:b0:513:d827:89e1 with SMTP id f18-20020ac24992000000b00513d82789e1mr3167796lfl.26.1710714742102;
        Sun, 17 Mar 2024 15:32:22 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id x5-20020ac259c5000000b0051322c11100sm1366981lfn.221.2024.03.17.15.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 15:32:21 -0700 (PDT)
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
Subject: [PATCH V3 4/4] arm64: dts: mediatek: Add Cudy WR3000 V1
Date: Sun, 17 Mar 2024 23:32:06 +0100
Message-Id: <20240317223206.22033-5-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240317223206.22033-1-zajec5@gmail.com>
References: <20240317223206.22033-1-zajec5@gmail.com>
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

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V2: Reorder properties
    Describe online LED
V3: Use LED_FUNCTION_WAN_ONLINE (present in torvalds/linux.git)

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
index 000000000000..54101cc08a25
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
+			function = LED_FUNCTION_WAN_ONLINE;
+			gpios = <&pio 11 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
-- 
2.35.3


