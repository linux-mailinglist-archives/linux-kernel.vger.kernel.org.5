Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A137BC786
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 14:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343973AbjJGMcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 08:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343882AbjJGMcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 08:32:46 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294FEAB
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 05:32:45 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32483535e51so2975829f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 05:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696681963; x=1697286763; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ui2K7IYfOEP4ZAXSYN4qDSqnIw2SbkMwzdxm8a4gliE=;
        b=OXK7R9Lld8qoecBJVQWZb3iUkMUMp1DdG+dP598CApfQCEidMnBiivh/170P+9k2ci
         TMi+C7X3thumggf/elT7jpP1FIHSCe4KlVXW4sppZqwV+e2e+qFGaFbeDqM3iUrRved1
         8XV7w0qXiGEciaKJphltzxLugNdBX2sS+Y6Lqx2LVzXDlGKRUT+Xky3nfnDavm+Vdq/f
         ls//0OSVjUE5iHgifdl01vy7w9tyzL8JgP3pDQ9Raw9hzBMq+YkC8flisNW4fmPveaYj
         o3BzHx1Xhg4EaRlwNaZ1jQA55cwX83KPQg2zIzOxKc9kqSDljSI1rBScj7/XYdQDrf4t
         Xsug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696681963; x=1697286763;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ui2K7IYfOEP4ZAXSYN4qDSqnIw2SbkMwzdxm8a4gliE=;
        b=ud4FW0cPuSOAHxxPVae1dPnS71+cDEBAi3WuG19j4TciDgV6Dkj9BYvMzRhO8F2ZOT
         +vJb9RfIUByeGzNKtTSQCntzHNFVgcPEFUhiq07RZI+bkLQJLz7VQzGAkuBzzATdnVMz
         Qq4pC796SVJEqhAGFDmFZpKKUL4HSNvNkVTxKiiI51RAGLvZ6r+IaddKYBS4ypqUXzzh
         c1O26+U54GwwWRlwlIe741JesSSixyTcUZUqsSbRuTsxqSNCQOzZawe/c0zUzEgB1nM+
         xp3ej2d8gnKTqmkRmSYWnAfxL4Q1yeTH4bqD2CSwjvQZw87kQWkDEYZlR7A67lpEJyhv
         Z+bA==
X-Gm-Message-State: AOJu0YzLRBNxmpS6kyGYsF7E6fNUCb0WUusGhjsv1O+bsA35uhw7wyHI
        7sJBGNrfRclQ4VyBXErDPiAKRF+NMo43ueaKfq8=
X-Google-Smtp-Source: AGHT+IFqgk6CsahpjNDJ9Dc+3DmVjLj8OZUN0a1F3YtOpRVagyq7b3cXtik8grvzFs6sgB8k62lJlQ==
X-Received: by 2002:a05:6000:1008:b0:31a:ed75:75df with SMTP id a8-20020a056000100800b0031aed7575dfmr9497356wrx.15.1696681963532;
        Sat, 07 Oct 2023 05:32:43 -0700 (PDT)
Received: from [192.168.1.2] (c-21d3225c.014-348-6c756e10.bbcust.telenor.se. [92.34.211.33])
        by smtp.gmail.com with ESMTPSA id c9-20020a2e9d89000000b002b6ffa50896sm1144130ljj.128.2023.10.07.05.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 05:32:43 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 07 Oct 2023 14:32:40 +0200
Subject: [PATCH] ARM: dts: ixp4xx: Add USRobotics USR8200 device tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231007-ixp4xx-usr8200-v1-1-aded3d6ff6f1@linaro.org>
X-B4-Tracking: v=1; b=H4sIAOdPIWUC/x3MQQqAIBBA0avErBMms7CuEi0sx5qNhVII4t2Tl
 m/xf4ZIgSnC3GQI9HLky1d0bQP7afxBgm01SJQ9Tt0kON0qJfHEoCWi2KRCbUe3GztAje5AjtM
 /XNZSPmPN2/lgAAAA
To:     Howard Harte <hharte@magicandroidapps.com>,
        Linus Walleij <linusw@kernel.org>,
        Krzysztof Halasa <khalasa@piap.pl>
Cc:     Imre Kaloz <kaloz@openwrt.org>, Ted Hess <thess@kitschensync.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a USRobotics NAS/Firewall/router that has been supported
by OpenWrt in the past. It had dedicated users so let's get it
properly supported.

Some debugging and fixing was provided by Howard Harte.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/intel/ixp/Makefile               |   3 +-
 .../intel/ixp/intel-ixp42x-usrobotics-usr8200.dts  | 229 +++++++++++++++++++++
 2 files changed, 231 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/intel/ixp/Makefile b/arch/arm/boot/dts/intel/ixp/Makefile
index 1a25ce3cf84f..ab8525f1ea1d 100644
--- a/arch/arm/boot/dts/intel/ixp/Makefile
+++ b/arch/arm/boot/dts/intel/ixp/Makefile
@@ -16,4 +16,5 @@ dtb-$(CONFIG_ARCH_IXP4XX) += \
 	intel-ixp43x-gateworks-gw2358.dtb \
 	intel-ixp42x-netgear-wg302v1.dtb \
 	intel-ixp42x-arcom-vulcan.dtb \
-	intel-ixp42x-gateway-7001.dtb
+	intel-ixp42x-gateway-7001.dtb \
+	intel-ixp42x-usrobotics-usr8200.dtb
diff --git a/arch/arm/boot/dts/intel/ixp/intel-ixp42x-usrobotics-usr8200.dts b/arch/arm/boot/dts/intel/ixp/intel-ixp42x-usrobotics-usr8200.dts
new file mode 100644
index 000000000000..90fd51b36e7d
--- /dev/null
+++ b/arch/arm/boot/dts/intel/ixp/intel-ixp42x-usrobotics-usr8200.dts
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Device Tree file for the USRobotics USR8200 firewall
+ * VPN and NAS. Based on know-how from Peter Denison.
+ *
+ * This machine is based on IXP422, the USR internal codename
+ * is "Jeeves".
+ */
+
+/dts-v1/;
+
+#include "intel-ixp42x.dtsi"
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "USRobotics USR8200";
+	compatible = "usr,usr8200", "intel,ixp42x";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x4000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8";
+		stdout-path = "uart1:115200n8";
+	};
+
+	aliases {
+		/* These are switched around */
+		serial0 = &uart1;
+		serial1 = &uart0;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		ieee1394_led: led-1394 {
+			label = "usr8200:green:1394";
+			gpios = <&gpio0 0 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+		usb1_led: led-usb1 {
+			label = "usr8200:green:usb1";
+			gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+		usb2_led: led-usb2 {
+			label = "usr8200:green:usb2";
+			gpios = <&gpio0 2 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+		wireless_led: led-wireless {
+			/*
+			 * This LED is mounted inside the case but cannot be
+			 * seen from the outside: probably USR planned at one
+			 * point for the device to have a wireless card, then
+			 * changed their mind and didn't mount it, leaving the
+			 * LED in place.
+			 */
+			label = "usr8200:green:wireless";
+			gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+		pwr_led: led-pwr {
+			label = "usr8200:green:pwr";
+			gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+
+		button-reset {
+			wakeup-source;
+			linux,code = <KEY_RESTART>;
+			label = "reset";
+			gpios = <&gpio0 12 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	soc {
+		bus@c4000000 {
+			flash@0,0 {
+				compatible = "intel,ixp4xx-flash", "cfi-flash";
+				bank-width = <2>;
+				/* Enable writes on the expansion bus */
+				intel,ixp4xx-eb-write-enable = <1>;
+				/* 16 MB of Flash mapped in at CS0 */
+				reg = <0 0x00000000 0x1000000>;
+
+				partitions {
+					compatible = "redboot-fis";
+					/* Eraseblock at 0x0fe0000 */
+					fis-index-block = <0x7f>;
+				};
+			};
+			rtc@2,0 {
+				/* EPSON RTC7301 DG DIL-capsule */
+				compatible = "epson,rtc7301dg";
+				/*
+				 * These timing settings were found in the boardfile patch:
+				 * IXP4XX_EXP_CS2 = 0x3fff000 | IXP4XX_EXP_BUS_SIZE(0) | IXP4XX_EXP_BUS_WR_EN |
+				 *                  IXP4XX_EXP_BUS_CS_EN | IXP4XX_EXP_BUS_BYTE_EN;
+				 */
+				intel,ixp4xx-eb-t1 = <0>; // no cycles extra address phase
+				intel,ixp4xx-eb-t2 = <0>; // no cycles extra setup phase
+				intel,ixp4xx-eb-t3 = <15>; // 15 cycles extra strobe phase
+				intel,ixp4xx-eb-t4 = <3>; // 3 cycles extra hold phase
+				intel,ixp4xx-eb-t5 = <15>; // 15 cycles extra recovery phase
+				intel,ixp4xx-eb-cycle-type = <0>; // Intel cycle
+				intel,ixp4xx-eb-byte-access-on-halfword = <0>;
+				intel,ixp4xx-eb-mux-address-and-data = <0>;
+				intel,ixp4xx-eb-ahb-split-transfers = <0>;
+				intel,ixp4xx-eb-write-enable = <1>;
+				intel,ixp4xx-eb-byte-access = <1>;
+				/* 512 bytes at CS2 */
+				reg = <2 0x00000000 0x0000200>;
+				reg-io-width = <1>;
+				native-endian;
+				/* FIXME: try to check if there is an IRQ for the RTC? */
+			};
+		};
+
+		pci@c0000000 {
+			status = "okay";
+
+			/*
+			 * Taken from USR8200 boardfile from OpenWrt
+			 *
+			 * We have 3 slots (IDSEL) with partly swizzled IRQs on slot 16.
+			 * We assume the same IRQ for all pins on the remaining slots, that
+			 * is what the boardfile was doing.
+			 */
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0xf800 0 0 7>;
+			interrupt-map =
+			/* IDSEL 14 used for "Wireless" in the board file */
+			<0x7000 0 0 1 &gpio0 7  IRQ_TYPE_LEVEL_LOW>, /* INT A on slot 14 is irq 7 */
+			/* IDSEL 15 used for VIA VT6307 IEEE 1394 Firewire */
+			<0x7800 0 0 1 &gpio0 8  IRQ_TYPE_LEVEL_LOW>, /* INT A on slot 15 is irq 8 */
+			/* IDSEL 16 used for VIA VT6202 USB 2.0 4+1 */
+			<0x8000 0 0 1 &gpio0 11 IRQ_TYPE_LEVEL_LOW>, /* INT A on slot 16 is irq 11 */
+			<0x8000 0 0 2 &gpio0 10 IRQ_TYPE_LEVEL_LOW>, /* INT B on slot 16 is irq 10 */
+			<0x8000 0 0 3 &gpio0 9  IRQ_TYPE_LEVEL_LOW>; /* INT C on slot 16 is irq 9 */
+		};
+
+		gpio@c8004000 {
+			/* Enable clock out on GPIO 15 */
+			intel,ixp4xx-gpio15-clkout;
+		};
+
+		/* EthB WAN */
+		ethernet@c8009000 {
+			status = "okay";
+			queue-rx = <&qmgr 3>;
+			queue-txready = <&qmgr 20>;
+			phy-mode = "rgmii";
+			phy-handle = <&phy9>;
+
+			mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				phy9: ethernet-phy@9 {
+					reg = <9>;
+				};
+
+				/* The switch uses MDIO addresses 16 thru 31 */
+				switch@16 {
+					compatible = "marvell,mv88e6060";
+					reg = <16>;
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+							label = "lan1";
+						};
+
+						port@1 {
+							reg = <1>;
+							label = "lan2";
+						};
+
+						port@2 {
+							reg = <2>;
+							label = "lan3";
+						};
+
+						port@3 {
+							reg = <3>;
+							label = "lan4";
+						};
+
+						port@5 {
+							/* Port 5 is the CPU port according to the MV88E6060 datasheet */
+							reg = <5>;
+							phy-mode = "rgmii-id";
+							ethernet = <&ethc>;
+							label = "cpu";
+							fixed-link {
+								speed = <100>;
+								full-duplex;
+							};
+						};
+					};
+				};
+			};
+		};
+
+		/* EthC LAN connected to the Marvell DSA Switch */
+		ethc: ethernet@c800a000 {
+			status = "okay";
+			queue-rx = <&qmgr 4>;
+			queue-txready = <&qmgr 21>;
+			phy-mode = "rgmii";
+			fixed-link {
+				speed = <100>;
+				full-duplex;
+			};
+		};
+	};
+};

---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230919-ixp4xx-usr8200-b2408d6fcad5

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

