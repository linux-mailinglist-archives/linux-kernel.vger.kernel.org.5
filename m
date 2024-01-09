Return-Path: <linux-kernel+bounces-21389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42863828E7F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D51A0287B68
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFB83D96A;
	Tue,  9 Jan 2024 20:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/FKH6/I"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1D43D546;
	Tue,  9 Jan 2024 20:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d88fff7faso35372185e9.3;
        Tue, 09 Jan 2024 12:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704832065; x=1705436865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ewVP7rZY9cEuaCQr23qe+i/CcrhN+qIG+I5XvERPbuQ=;
        b=E/FKH6/ItDeS8Zx5IQ7iSs2SIUi985JCP8EUEXlesHYxq/KZgA7GGtItwYKwJTaoT3
         PiGwOX/rF8PYupHZaRFr9KvPWrewzGCDXudD9i+fsUfewSLoEEtGDQvxCaTqjmnFSbHa
         cqI/PtnOUciqm+fB97BOSXxguAy8kIqI+kp79dXfjd5Lkjd+rpZF2PxT2MLSagwIeRo4
         xpebjPipQL7GSolFpGT7GdcjvSb0vyEeWGz3zZnSlfLA1Xo17vmnijrwfN8UGxz0x7R0
         2T1LXhDQj1xQOZ7Wp1caS2Srq9b23yRyTLELDkU2jE9Q17hL+emuc7Ac/TANbBD7mKlW
         iAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704832065; x=1705436865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ewVP7rZY9cEuaCQr23qe+i/CcrhN+qIG+I5XvERPbuQ=;
        b=ka3+38vL3cikZ94W7YxxHMuAAI0oZgnmRbGX0YpdGSoWOJjfO8wlL7UYJHFjD5eTo+
         koqyyCRr/4QXhHAT82qMDIsru/ma1MOtnT1rHs5CcHaXu1JEbrpKBDHyagbXBRKJA38A
         vZ3G6czUUvJMviKU9sgWAHtu3D9SBZSa7Pj92V0D1qGmyXfdveobrKvGPC7oHmHmLNf3
         Ap4IzxrFqMzYGrQuPbar5jz78WgWI0I2elhRptpFo0f+HsmIS0f7hZufzTAQvjSaznDi
         XY0Zt5mSb5F2YMc47guu1HUyozS1PS1/VE6+GRgE1OlEXfLwPhw1SiuajUhYXzC9bqIl
         fHxg==
X-Gm-Message-State: AOJu0YyP/CDMMVYve/+18mRfyez50GqByr5QcFhDUvoZaCkBNiQHagn6
	uh4eQ21Dck44ZWcRcnbgxvI=
X-Google-Smtp-Source: AGHT+IEWNvxc3df+X58TgBYuCL+DhXU6PLckB+Fh6CRFLXqYc7DishxyjF53akilpHK0KkJW3TwJeg==
X-Received: by 2002:a1c:740e:0:b0:40e:52ec:3500 with SMTP id p14-20020a1c740e000000b0040e52ec3500mr240247wmc.100.1704832064797;
        Tue, 09 Jan 2024 12:27:44 -0800 (PST)
Received: from apple.sigmaris.info ([2a02:8010:6606:0:b44b:4534:eb6e:83b7])
        by smtp.gmail.com with ESMTPSA id je4-20020a05600c1f8400b0040e38b7cfdasm16073665wmb.4.2024.01.09.12.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 12:27:44 -0800 (PST)
From: Hugh Cole-Baker <sigmaris@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: John Clark <inindev@gmail.com>,
	Thomas McKahan <tmckahan@singleboardsolutions.com>,
	Hugh Cole-Baker <sigmaris@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: rockchip: enable NanoPC-T6 MiniPCIe power
Date: Tue,  9 Jan 2024 20:27:28 +0000
Message-Id: <20240109202729.54292-1-sigmaris@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NanoPC-T6 has a Mini PCIe slot intended to be used for a 4G or LTE
modem. This slot has no PCIe functionality, only USB 2.0 pins are wired
to the SoC, and USIM pins are wired to a SIM card slot on the board.
Define the 3.3v supply for the slot so it can be used.

Signed-off-by: Hugh Cole-Baker <sigmaris@gmail.com>
---
Changes from v1:
Renamed pinctrl label to pin_4g_lte_pwren, as labels should start with
alphanumeric characters, and starting with a numeric character is a
syntax error.

v1: https://lore.kernel.org/linux-rockchip/20240107223714.8158-1-sigmaris@gmail.com/

 .../boot/dts/rockchip/rk3588-nanopc-t6.dts      | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts
index d7722772ecd8..7e9613f079fa 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts
@@ -159,6 +159,18 @@ vcc3v3_pcie30: vcc3v3-pcie30-regulator {
 		regulator-max-microvolt = <3300000>;
 		vin-supply = <&vcc5v0_sys>;
 	};
+
+	vdd_4g_3v3: vdd-4g-3v3-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio4 RK_PC6 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pin_4g_lte_pwren>;
+		regulator-name = "vdd_4g_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
 };
 
 &combphy0_ps {
@@ -504,6 +516,10 @@ pcie_m2_1_pwren: pcie-m21-pwren {
 	};
 
 	usb {
+		pin_4g_lte_pwren: 4g-lte-pwren {
+			rockchip,pins = <4 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
 		typec5v_pwren: typec5v-pwren {
 			rockchip,pins = <1 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
@@ -884,6 +900,7 @@ &uart2 {
 };
 
 &u2phy2_host {
+	phy-supply = <&vdd_4g_3v3>;
 	status = "okay";
 };
 
-- 
2.39.3 (Apple Git-145)


