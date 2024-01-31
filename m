Return-Path: <linux-kernel+bounces-46267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B5E843D4D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89B811C2110B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A35B78692;
	Wed, 31 Jan 2024 10:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHlziROX"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22206E2B2;
	Wed, 31 Jan 2024 10:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706698339; cv=none; b=binfHiXAUhe+vQJeFVBbX5LRkA1zhctw/mGGmJNjELXZ73thOCmdziednAO5N192uJXpXmeT115jSK5q3rYQFEHtQkuxsHMHdPl+v2JoslgFO3RDR0ip3W3lBUx/kmUxEBpSRB9q4Nq0n+dpDhmv1xCnR5IfhY2444tSLaTEX4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706698339; c=relaxed/simple;
	bh=dki0/02F5CPiXahr2kdpgHpOhHMaNK3EioGrw9d2/oQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GCOtCy7Wz5nbgoWYbS/vBf81g4V/Fg3UJE3eUkmto18E8ccVzmrklBtwyl5rIczB7eRYVsHxHQqxIIM8Zoe2iTM5qDF74tv6MNhjaqi4IDKRY2waxdlkfGDXtgBKo/yqDAaiPn1ySCTDaAc4OJxV3WmxyH+Q7CBtQ5e2rggOJ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHlziROX; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55f8abbeeddso490781a12.1;
        Wed, 31 Jan 2024 02:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706698334; x=1707303134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6fn9yYxm5bd9ZuqKk2AE5C40RNyt85+PfHDVL/Cpuw=;
        b=NHlziROXPdvUbYMRdr+x+J+4vdderXQjwMQiZoCnFd+LzWr4J7gp0mV422IWZPx27z
         dxN2VvCtBD2hRb1iqZEEl2REnmKKNxVrVjYDPOtZyKYQjzjWVolFcOggmEZdD3fBq3Yq
         zDTgWpLajBpW4YrYm/M2WXCt8UVbsxa4JvkshYYRvtrpd3QBBT53taH5xM3hKgsF6FFb
         KgMBNWKb3cxgh2UupSgu8xSjCZ0WjgQBOzhYYqGlOb+WULXosK/trSahdvENjFS7xSNw
         4GBsjvoWJgJcxVcJruvaMVlTMoPN4ruyGq1JUXUvHAbe/4Lr1JBj5a37nq54AUU7sIhv
         CYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706698334; x=1707303134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6fn9yYxm5bd9ZuqKk2AE5C40RNyt85+PfHDVL/Cpuw=;
        b=Nu012WXwMH3ouDmAs5lmJUm75j6ln360lMiPzQh/aGujRt7wpHp8JgwRJQ1Uv27LsH
         7k8TUcadgJOFj0RwqhmBewjPnx8+tGXlgQ/KtAcJzoM5jr10760/I6LHdS2m7iZpoi7w
         ri9C3fZqJI9buzWT+BfAEjhxYpS5zMLqsxCrfS8De1fkpQibr7Cm+YtYrTTKmR+dehYv
         o+5owmHZUWN5cKcubv4BvTm/ldd1MifSTvo3/iw1SbZv6YTDxTDrdNOXydBPhqM+batY
         FCh4Jsjqp4InmdVmN1h1ZO/XkIqiLQo+QDeJR/W1IKY4OkeHTavJicsBzaCyO5FXNWrJ
         ruiA==
X-Gm-Message-State: AOJu0Ywc6j4v5QewJGDgnrBk0QVisekmNHPhhyfk+AlMC798vRYLDDSt
	8FmxrU/t3AGWFcZcG88WIrD1zjSYW+2upQkky67ZwBSiVkvvqgb6
X-Google-Smtp-Source: AGHT+IEEp4xl1i8pi4UjynvjshD3iZRHhXJNcvE6XtBYG3cp+e5Zq9qNt17hLOq2ZtKo7ExDRK0Wig==
X-Received: by 2002:a05:6402:5213:b0:55f:7fe9:c567 with SMTP id s19-20020a056402521300b0055f7fe9c567mr980843edd.1.1706698333136;
        Wed, 31 Jan 2024 02:52:13 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU3Mtt6W9jFTRPKXlOWiQ3YZJoxcJf7QnIS1mAYy9zgCylyKg8NBX7+L/KAGHE1sjFCvRn2mapj2Lc8NNJ1SvOfRLBXlM15qmjG1QsTqOEiDrhi5CfS9JJZoJ5ub1RmagSVxDOeYCsAne1aWxo2+9L0MLpXjPjPLQ5Oh9yor9PcSY+9e+AisajcBau1Q9c6470Mbxi2QhlxOfMZpYwoR3mAp7AfmQQkgN4p/y8koinkxSikg64BmM7Y9v2L4oxMcjvcJ1NYVvpFiVWemlSe7Hl2hX+QVUer6zcTo52wnBbVthtRIG8vzh7jg6axNXJtiybjevwqT0vpVR5PpV+Sw4Ix6kVR12okCezelVHdJu6yC2gkGFexk8kK4Rve6LUfugz8Sw==
Received: from xeon.. ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id f19-20020a056402195300b0055e96290001sm4753966edz.27.2024.01.31.02.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 02:52:12 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kees Cook <keescook@chromium.org>,
	Maxim Schwalm <maxim.schwalm@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v1 3/4] ARM: tegra: Add device-tree for LG Optimus Vu (P895)
Date: Wed, 31 Jan 2024 12:51:52 +0200
Message-Id: <20240131105153.8070-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240131105153.8070-1-clamor95@gmail.com>
References: <20240131105153.8070-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device-tree for LG Optimus Vu P895, which is a NVIDIA
Tegra30-based smartphone, orignally running Android.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/boot/dts/nvidia/Makefile            |    1 +
 arch/arm/boot/dts/nvidia/tegra30-lg-p895.dts |  496 +++++
 arch/arm/boot/dts/nvidia/tegra30-lg-x3.dtsi  | 1821 ++++++++++++++++++
 3 files changed, 2318 insertions(+)
 create mode 100644 arch/arm/boot/dts/nvidia/tegra30-lg-p895.dts
 create mode 100644 arch/arm/boot/dts/nvidia/tegra30-lg-x3.dtsi

diff --git a/arch/arm/boot/dts/nvidia/Makefile b/arch/arm/boot/dts/nvidia/Makefile
index 60091bf7e48b..f66337e5d188 100644
--- a/arch/arm/boot/dts/nvidia/Makefile
+++ b/arch/arm/boot/dts/nvidia/Makefile
@@ -39,5 +39,6 @@ dtb-$(CONFIG_ARCH_TEGRA_3x_SOC) += \
 	tegra30-cardhu-a02.dtb \
 	tegra30-cardhu-a04.dtb \
 	tegra30-colibri-eval-v3.dtb \
+	tegra30-lg-p895.dtb \
 	tegra30-ouya.dtb \
 	tegra30-pegatron-chagall.dtb
diff --git a/arch/arm/boot/dts/nvidia/tegra30-lg-p895.dts b/arch/arm/boot/dts/nvidia/tegra30-lg-p895.dts
new file mode 100644
index 000000000000..7e7cfaabe56e
--- /dev/null
+++ b/arch/arm/boot/dts/nvidia/tegra30-lg-p895.dts
@@ -0,0 +1,496 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include "tegra30-lg-x3.dtsi"
+
+/ {
+	model = "LG Optimus Vu P895";
+	compatible = "lge,p895", "nvidia,tegra30";
+
+	pinmux@70000868 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&state_default>;
+
+		state_default: pinmux {
+			/* GNSS UART-B pinmux */
+			uartb_cts_rxd {
+				nvidia,pins = "uart2_cts_n_pj5",
+						"uart2_rxd_pc3";
+				nvidia,function = "uartb";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			uartb_rts_txd {
+				nvidia,pins = "uart2_rts_n_pj6",
+						"uart2_txd_pc2";
+				nvidia,function = "uartb";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gps_reset {
+				nvidia,pins = "spdif_out_pk5";
+				nvidia,function = "spdif";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* GPIO keys pinmux */
+			volume_up {
+				nvidia,pins = "gmi_cs7_n_pi6";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			memo_key {
+				nvidia,pins = "sdmmc3_dat1_pb6";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Sensors pinmux */
+			current_alert_irq {
+				nvidia,pins = "spi1_cs0_n_px6";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Panel pinmux */
+			panel_vdd {
+				nvidia,pins = "pbb0";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* AUDIO pinmux */
+			sub_mic_ldo {
+				nvidia,pins = "gmi_dqs_pi2";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Modem pinmux */
+			usim_detect {
+				nvidia,pins = "clk2_out_pw5";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* GPIO power/drive control */
+			drive_sdmmc4 {
+				nvidia,pins = "drive_gma",
+						"drive_gmb",
+						"drive_gmc",
+						"drive_gmd";
+				nvidia,pull-down-strength = <9>;
+				nvidia,pull-up-strength = <9>;
+				nvidia,slew-rate-rising = <TEGRA_PIN_SLEW_RATE_SLOWEST>;
+				nvidia,slew-rate-falling = <TEGRA_PIN_SLEW_RATE_SLOWEST>;
+			};
+		};
+	};
+
+	i2c@7000c400 {
+		touchscreen@20 {
+			rmi4-f11@11 {
+				syna,clip-x-high = <1535>;
+				syna,clip-y-high = <2047>;
+			};
+		};
+	};
+
+	memory-controller@7000f000 {
+		emc-timings-2 {
+			/* Hynix 1GB H9TCNNN8JDMMPR LPDDR2 533MHz */
+			nvidia,ram-code = <2>;
+
+			timing-12750000 {
+				clock-frequency = <12750000>;
+
+				nvidia,emem-configuration = < 0x00020001 0xc0000010
+					0x00000001 0x00000001 0x00000002 0x00000000
+					0x00000003 0x00000001 0x00000002 0x00000004
+					0x00000001 0x00000000 0x00000002 0x00000002
+					0x02020001 0x00060402 0x77230303 0x001f0000 >;
+			};
+
+			timing-25500000 {
+				clock-frequency = <25500000>;
+
+				nvidia,emem-configuration = < 0x00030003 0xc0000010
+					0x00000001 0x00000001 0x00000002 0x00000000
+					0x00000003 0x00000001 0x00000002 0x00000004
+					0x00000001 0x00000000 0x00000002 0x00000002
+					0x02020001 0x00060402 0x73e30303 0x001f0000 >;
+			};
+
+			timing-51000000 {
+				clock-frequency = <51000000>;
+
+				nvidia,emem-configuration = < 0x00010003 0xc0000010
+					0x00000001 0x00000001 0x00000002 0x00000000
+					0x00000003 0x00000001 0x00000002 0x00000004
+					0x00000001 0x00000000 0x00000002 0x00000002
+					0x02020001 0x00060402 0x72c30303 0x001f0000 >;
+			};
+
+			timing-102000000 {
+				clock-frequency = <102000000>;
+
+				nvidia,emem-configuration = < 0x00000003 0xc0000018
+					0x00000001 0x00000001 0x00000003 0x00000001
+					0x00000003 0x00000001 0x00000002 0x00000004
+					0x00000001 0x00000000 0x00000002 0x00000002
+					0x02020001 0x00060403 0x72430504 0x001f0000 >;
+			};
+
+			timing-204000000 {
+				clock-frequency = <204000000>;
+
+				nvidia,emem-configuration = < 0x00000006 0xc0000025
+					0x00000001 0x00000001 0x00000006 0x00000003
+					0x00000005 0x00000001 0x00000002 0x00000004
+					0x00000001 0x00000000 0x00000003 0x00000002
+					0x02030001 0x00070506 0x71e40a07 0x001f0000 >;
+			};
+
+			timing-266500000 {
+				clock-frequency = <266500000>;
+
+				nvidia,emem-configuration = < 0x00000008 0xc0000030
+					0x00000001 0x00000002 0x00000008 0x00000004
+					0x00000006 0x00000001 0x00000002 0x00000005
+					0x00000001 0x00000000 0x00000003 0x00000003
+					0x03030001 0x00090608 0x70040c09 0x001f0000 >;
+			};
+
+			timing-533000000 {
+				clock-frequency = <533000000>;
+
+				nvidia,emem-configuration = < 0x0000000f 0xc0000060
+					0x00000003 0x00000004 0x00000010 0x0000000a
+					0x0000000d 0x00000002 0x00000002 0x00000008
+					0x00000002 0x00000000 0x00000004 0x00000005
+					0x05040002 0x00110b10 0x70281811 0x001f0000 >;
+			};
+		};
+	};
+
+	memory-controller@7000f400 {
+		emc-timings-2 {
+			/* Hynix 1GB H9TCNNN8JDMMPR LPDDR2 533MHz */
+			nvidia,ram-code = <2>;
+
+			timing-12750000 {
+				clock-frequency = <12750000>;
+
+				nvidia,emc-auto-cal-interval = <0x001fffff>;
+				nvidia,emc-mode-1 = <0x00010022>;
+				nvidia,emc-mode-2 = <0x00020001>;
+				nvidia,emc-mode-reset = <0x00000000>;
+				nvidia,emc-zcal-cnt-long = <0x00000009>;
+				nvidia,emc-cfg-periodic-qrst;
+
+				nvidia,emc-configuration =  < 0x00000000
+					0x00000001 0x00000002 0x00000002 0x00000004
+					0x00000004 0x00000001 0x00000005 0x00000002
+					0x00000002 0x00000001 0x00000001 0x00000000
+					0x00000001 0x00000003 0x00000001 0x0000000b
+					0x00000009 0x0000002f 0x00000000 0x0000000b
+					0x00000001 0x00000001 0x00000002 0x00000000
+					0x00000001 0x00000007 0x00000002 0x00000002
+					0x00000003 0x00000008 0x00000004 0x00000004
+					0x00000002 0x00000036 0x00000004 0x00000004
+					0x00000000 0x00000000 0x00004282 0x007800a4
+					0x00008000 0x000fc000 0x000fc000 0x000fc000
+					0x000fc000 0x000fc000 0x000fc000 0x000fc000
+					0x000fc000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x000fc000 0x000fc000 0x000fc000
+					0x000fc000 0x00100220 0x0800201c 0x00000000
+					0x77ffc004 0x01f1f008 0x00000000 0x00000007
+					0x08000068 0x08000000 0x00000802 0x00064000
+					0x00000009 0x00090009 0xa0f10000 0x00000000
+					0x00000000 0x80000164 0xe0000000 0xff00ff00 >;
+			};
+
+			timing-25500000 {
+				clock-frequency = <25500000>;
+
+				nvidia,emc-auto-cal-interval = <0x001fffff>;
+				nvidia,emc-mode-1 = <0x00010022>;
+				nvidia,emc-mode-2 = <0x00020001>;
+				nvidia,emc-mode-reset = <0x00000000>;
+				nvidia,emc-zcal-cnt-long = <0x00000009>;
+				nvidia,emc-cfg-periodic-qrst;
+
+				nvidia,emc-configuration =  < 0x00000001
+					0x00000003 0x00000002 0x00000002 0x00000004
+					0x00000004 0x00000001 0x00000005 0x00000002
+					0x00000002 0x00000001 0x00000001 0x00000000
+					0x00000001 0x00000003 0x00000001 0x0000000b
+					0x00000009 0x00000060 0x00000000 0x00000018
+					0x00000001 0x00000001 0x00000002 0x00000000
+					0x00000001 0x00000007 0x00000004 0x00000004
+					0x00000003 0x00000008 0x00000004 0x00000004
+					0x00000002 0x0000006b 0x00000004 0x00000004
+					0x00000000 0x00000000 0x00004282 0x007800a4
+					0x00008000 0x000fc000 0x000fc000 0x000fc000
+					0x000fc000 0x000fc000 0x000fc000 0x000fc000
+					0x000fc000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x000fc000 0x000fc000 0x000fc000
+					0x000fc000 0x00100220 0x0800201c 0x00000000
+					0x77ffc004 0x01f1f008 0x00000000 0x00000007
+					0x08000068 0x08000000 0x00000802 0x00064000
+					0x0000000a 0x00090009 0xa0f10000 0x00000000
+					0x00000000 0x800001c5 0xd0000000 0xff00ff00 >;
+			};
+
+			timing-51000000 {
+				clock-frequency = <51000000>;
+
+				nvidia,emc-auto-cal-interval = <0x001fffff>;
+				nvidia,emc-mode-1 = <0x00010022>;
+				nvidia,emc-mode-2 = <0x00020001>;
+				nvidia,emc-mode-reset = <0x00000000>;
+				nvidia,emc-zcal-cnt-long = <0x00000009>;
+				nvidia,emc-cfg-periodic-qrst;
+
+				nvidia,emc-configuration =  < 0x00000003
+					0x00000006 0x00000002 0x00000002 0x00000004
+					0x00000004 0x00000001 0x00000005 0x00000002
+					0x00000002 0x00000001 0x00000001 0x00000000
+					0x00000001 0x00000003 0x00000001 0x0000000b
+					0x00000009 0x000000c0 0x00000000 0x00000030
+					0x00000001 0x00000001 0x00000002 0x00000000
+					0x00000001 0x00000007 0x00000008 0x00000008
+					0x00000003 0x00000008 0x00000004 0x00000004
+					0x00000002 0x000000d5 0x00000004 0x00000004
+					0x00000000 0x00000000 0x00004282 0x007800a4
+					0x00008000 0x000fc000 0x000fc000 0x000fc000
+					0x000fc000 0x000fc000 0x000fc000 0x000fc000
+					0x000fc000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x000fc000 0x000fc000 0x000fc000
+					0x000fc000 0x00100220 0x0800201c 0x00000000
+					0x77ffc004 0x01f1f008 0x00000000 0x00000007
+					0x08000068 0x08000000 0x00000802 0x00064000
+					0x00000013 0x00090009 0xa0f10000 0x00000000
+					0x00000000 0x80000287 0xd0000000 0xff00ff00 >;
+			};
+
+			timing-102000000 {
+				clock-frequency = <102000000>;
+
+				nvidia,emc-auto-cal-interval = <0x001fffff>;
+				nvidia,emc-mode-1 = <0x00010022>;
+				nvidia,emc-mode-2 = <0x00020001>;
+				nvidia,emc-mode-reset = <0x00000000>;
+				nvidia,emc-zcal-cnt-long = <0x0000000a>;
+				nvidia,emc-cfg-periodic-qrst;
+
+				nvidia,emc-configuration =  < 0x00000006
+					0x0000000d 0x00000004 0x00000002 0x00000004
+					0x00000004 0x00000001 0x00000005 0x00000002
+					0x00000002 0x00000001 0x00000001 0x00000000
+					0x00000001 0x00000003 0x00000001 0x0000000b
+					0x00000009 0x00000181 0x00000000 0x00000060
+					0x00000001 0x00000001 0x00000002 0x00000000
+					0x00000001 0x00000007 0x0000000f 0x0000000f
+					0x00000003 0x00000008 0x00000004 0x00000004
+					0x00000002 0x000001a9 0x00000004 0x00000006
+					0x00000000 0x00000000 0x00004282 0x007800a4
+					0x00008000 0x000fc000 0x000fc000 0x000fc000
+					0x000fc000 0x000fc000 0x000fc000 0x000fc000
+					0x000fc000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x000fc000 0x000fc000 0x000fc000
+					0x000fc000 0x00100220 0x0800201c 0x00000000
+					0x77ffc004 0x01f1f008 0x00000000 0x00000007
+					0x08000068 0x08000000 0x00000802 0x00064000
+					0x00000025 0x00090009 0xa0f10000 0x00000000
+					0x00000000 0x8000040b 0xd0000000 0xff00ff00 >;
+			};
+
+			timing-204000000 {
+				clock-frequency = <204000000>;
+
+				nvidia,emc-auto-cal-interval = <0x001fffff>;
+				nvidia,emc-mode-1 = <0x00010042>;
+				nvidia,emc-mode-2 = <0x00020001>;
+				nvidia,emc-mode-reset = <0x00000000>;
+				nvidia,emc-zcal-cnt-long = <0x00000013>;
+				nvidia,emc-cfg-periodic-qrst;
+
+				nvidia,emc-configuration =  < 0x0000000c
+					0x0000001a 0x00000008 0x00000003 0x00000005
+					0x00000004 0x00000001 0x00000006 0x00000003
+					0x00000003 0x00000002 0x00000002 0x00000000
+					0x00000001 0x00000004 0x00000001 0x0000000c
+					0x0000000a 0x00000303 0x00000000 0x000000c0
+					0x00000001 0x00000001 0x00000003 0x00000000
+					0x00000001 0x00000007 0x0000001d 0x0000001d
+					0x00000004 0x0000000b 0x00000005 0x00000004
+					0x00000002 0x00000351 0x00000005 0x00000004
+					0x00000000 0x00000000 0x00004282 0x004400a4
+					0x00008000 0x00080000 0x00080000 0x00080000
+					0x00080000 0x00072000 0x00072000 0x00072000
+					0x00072000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00080000 0x00080000 0x00080000
+					0x00080000 0x000e0220 0x0800201c 0x00000000
+					0x77ffc004 0x01f1f008 0x00000000 0x00000007
+					0x08000068 0x08000000 0x00000802 0x00064000
+					0x0000004a 0x00090009 0xa0f10000 0x00000000
+					0x00000000 0x80000713 0xe0000000 0xff00ff00 >;
+			};
+
+			timing-266500000 {
+				clock-frequency = <266500000>;
+
+				nvidia,emc-auto-cal-interval = <0x001fffff>;
+				nvidia,emc-mode-1 = <0x00010042>;
+				nvidia,emc-mode-2 = <0x00020002>;
+				nvidia,emc-mode-reset = <0x00000000>;
+				nvidia,emc-zcal-cnt-long = <0x00000018>;
+				nvidia,emc-cfg-periodic-qrst;
+
+				nvidia,emc-configuration =  < 0x0000000f
+					0x00000022 0x0000000b 0x00000004 0x00000005
+					0x00000005 0x00000001 0x00000007 0x00000004
+					0x00000004 0x00000002 0x00000002 0x00000000
+					0x00000002 0x00000005 0x00000002 0x0000000c
+					0x0000000b 0x000003ef 0x00000000 0x000000fb
+					0x00000001 0x00000001 0x00000004 0x00000000
+					0x00000001 0x00000009 0x00000026 0x00000026
+					0x00000004 0x0000000e 0x00000006 0x00000004
+					0x00000002 0x00000455 0x00000000 0x00000004
+					0x00000000 0x00000000 0x00006282 0x003200a4
+					0x00008000 0x00070000 0x00070000 0x00070000
+					0x00070000 0x00072000 0x00072000 0x00072000
+					0x00072000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00080002 0x00080002 0x00080002
+					0x00080002 0x000e0220 0x0800003d 0x00000000
+					0x77ffc004 0x01f1f008 0x00000000 0x00000007
+					0x08000068 0x08000000 0x00000802 0x00064000
+					0x00000060 0x000a000a 0xa0f10000 0x00000000
+					0x00000000 0x800008ee 0xe0000000 0xff00ff00 >;
+			};
+
+			timing-533000000 {
+				clock-frequency = <533000000>;
+
+				nvidia,emc-auto-cal-interval = <0x001fffff>;
+				nvidia,emc-mode-1 = <0x000100c2>;
+				nvidia,emc-mode-2 = <0x00020006>;
+				nvidia,emc-mode-reset = <0x00000000>;
+				nvidia,emc-zcal-cnt-long = <0x00000030>;
+				nvidia,emc-cfg-periodic-qrst;
+
+				nvidia,emc-configuration =  < 0x0000001f
+					0x00000045 0x00000016 0x00000009 0x00000008
+					0x00000009 0x00000003 0x0000000d 0x00000009
+					0x00000009 0x00000005 0x00000003 0x00000000
+					0x00000004 0x0000000a 0x00000006 0x0000000d
+					0x00000010 0x000007df 0x00000000 0x000001f7
+					0x00000003 0x00000003 0x00000009 0x00000000
+					0x00000001 0x0000000f 0x0000004b 0x0000004b
+					0x00000008 0x0000001b 0x0000000c 0x00000004
+					0x00000002 0x000008aa 0x00000000 0x00000004
+					0x00000000 0x00000000 0x00006282 0xf0120091
+					0x00008000 0x0000000c 0x0000000c 0x0000000c
+					0x0000000c 0x0000000a 0x0000000a 0x0000000a
+					0x0000000a 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x0000000c 0x0000000c 0x0000000c
+					0x0000000c 0x000c0220 0x0800003d 0x00000000
+					0x77ffc004 0x01f1f408 0x00000000 0x00000007
+					0x08000068 0x08000000 0x00000802 0x00064000
+					0x000000c0 0x000e000e 0xa0f10000 0x00000000
+					0x00000000 0x800010d9 0xe0000000 0xff00ff88 >;
+			};
+		};
+	};
+
+	battery: battery-cell {
+		compatible = "simple-battery";
+		device-chemistry = "lithium-ion";
+		charge-full-design-microamp-hours = <2080000>;
+		energy-full-design-microwatt-hours = <7700000>;
+		operating-range-celsius = <0 45>;
+	};
+
+	gpio-keys {
+		key-volume-up {
+			label = "Volume Up";
+			gpios = <&gpio TEGRA_GPIO(I, 6) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+			debounce-interval = <10>;
+			wakeup-event-action = <EV_ACT_ASSERTED>;
+			wakeup-source;
+		};
+
+		key-memo {
+			label = "Memo";
+			gpios = <&gpio TEGRA_GPIO(B, 6) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_MEMO>;
+			debounce-interval = <10>;
+			wakeup-event-action = <EV_ACT_ASSERTED>;
+			wakeup-source;
+		};
+	};
+
+	gpio-leds {
+		led-power {
+			label = "power::white";
+			gpios = <&gpio TEGRA_GPIO(R, 3) GPIO_ACTIVE_HIGH>;
+
+			linux,default-trigger = "battery-charging";
+
+			color = <LED_COLOR_ID_WHITE>;
+			function = LED_FUNCTION_CHARGING;
+		};
+	};
+
+	regulator-lcd3v {
+		gpio = <&gpio TEGRA_GPIO(BB, 0) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	sound {
+		compatible = "lge,tegra-audio-max98089-p895",
+			     "nvidia,tegra-audio-max98089";
+		nvidia,model = "LG Optimus Vu MAX98089";
+
+		nvidia,int-mic-en-gpios = <&gpio TEGRA_GPIO(I, 2) GPIO_ACTIVE_HIGH>;
+	};
+};
diff --git a/arch/arm/boot/dts/nvidia/tegra30-lg-x3.dtsi b/arch/arm/boot/dts/nvidia/tegra30-lg-x3.dtsi
new file mode 100644
index 000000000000..4254340b3a01
--- /dev/null
+++ b/arch/arm/boot/dts/nvidia/tegra30-lg-x3.dtsi
@@ -0,0 +1,1821 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <dt-bindings/input/gpio-keys.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/mfd/max77620.h>
+#include <dt-bindings/thermal/thermal.h>
+
+#include "tegra30.dtsi"
+#include "tegra30-cpu-opp.dtsi"
+#include "tegra30-cpu-opp-microvolt.dtsi"
+
+/ {
+	chassis-type = "handset";
+
+	aliases {
+		mmc0 = &sdmmc4; /* eMMC */
+		mmc1 = &sdmmc1; /* WiFi */
+
+		rtc0 = &pmic;
+		rtc1 = "/rtc@7000e000";
+
+		serial0 = &uartd; /* Console */
+		serial1 = &uartc; /* Bluetooth */
+		serial2 = &uartb; /* GPS */
+	};
+
+	/*
+	 * The decompressor and also some bootloaders rely on a
+	 * pre-existing /chosen node to be available to insert the
+	 * command line and merge other ATAGS info.
+	 */
+	chosen { };
+
+	firmware {
+		trusted-foundations {
+			compatible = "tlm,trusted-foundations";
+			tlm,version-major = <2>;
+			tlm,version-minor = <8>;
+		};
+	};
+
+	memory@80000000 {
+		reg = <0x80000000 0x40000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		linux,cma@80000000 {
+			compatible = "shared-dma-pool";
+			alloc-ranges = <0x80000000 0x30000000>;
+			size = <0x10000000>;		/* 256MiB */
+			linux,cma-default;
+			reusable;
+		};
+
+		ramoops@bed00000 {
+			compatible = "ramoops";
+			reg = <0xbed00000 0x10000>;	/* 64kB */
+			console-size = <0x8000>;	/* 32kB */
+			record-size = <0x400>;		/* 1kB */
+			ecc-size = <16>;
+		};
+
+		trustzone@bfe00000 {
+			reg = <0xbfe00000 0x200000>;	/* 2MB */
+			no-map;
+		};
+	};
+
+	vde@6001a000 {
+		assigned-clocks = <&tegra_car TEGRA30_CLK_VDE>;
+		assigned-clock-parents = <&tegra_car TEGRA30_CLK_PLL_P>;
+		assigned-clock-rates = <408000000>;
+	};
+
+	pinmux@70000868 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&state_default>;
+
+		state_default: pinmux {
+			/* WLAN SDIO pinmux */
+			sdmmc1_clk {
+				nvidia,pins = "sdmmc1_clk_pz0";
+				nvidia,function = "sdmmc1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			sdmmc1_cmd {
+				nvidia,pins = "sdmmc1_cmd_pz1",
+						"sdmmc1_dat3_py4",
+						"sdmmc1_dat2_py5",
+						"sdmmc1_dat1_py6",
+						"sdmmc1_dat0_py7";
+				nvidia,function = "sdmmc1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			wlan_reset {
+				nvidia,pins = "pv3";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			wlan_host_wake {
+				nvidia,pins = "pu6";
+				nvidia,function = "pwm3";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* GNSS UART-B pinmux */
+			gps_pwr_en {
+				nvidia,pins = "kb_row6_pr6";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gps_ldo_en {
+				nvidia,pins = "ulpi_dir_py1";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gps_clk_ref {
+				nvidia,pins = "gmi_ad8_ph0";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Bluetooth UART-C pinmux */
+			uartc_cts_rxd {
+				nvidia,pins = "uart3_cts_n_pa1",
+						"uart3_rxd_pw7";
+				nvidia,function = "uartc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			uartc_rts_txd {
+				nvidia,pins = "uart3_rts_n_pc0",
+						"uart3_txd_pw6";
+				nvidia,function = "uartc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			bt_reset {
+				nvidia,pins = "clk2_req_pcc5";
+				nvidia,function = "dap";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			bt_dev_wake {
+				nvidia,pins = "kb_row11_ps3";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			bt_host_wake {
+				nvidia,pins = "kb_row12_ps4";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			bt_pcm_dap4 {
+				nvidia,pins = "dap4_fs_pp4",
+						"dap4_din_pp5",
+						"dap4_dout_pp6",
+						"dap4_sclk_pp7";
+				nvidia,function = "i2s3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* EMMC pinmux */
+			sdmmc4_clk {
+				nvidia,pins = "sdmmc4_clk_pcc4";
+				nvidia,function = "sdmmc4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			sdmmc4_data {
+				nvidia,pins = "sdmmc4_cmd_pt7",
+						"sdmmc4_dat0_paa0",
+						"sdmmc4_dat1_paa1",
+						"sdmmc4_dat2_paa2",
+						"sdmmc4_dat3_paa3",
+						"sdmmc4_dat4_paa4",
+						"sdmmc4_dat5_paa5",
+						"sdmmc4_dat6_paa6",
+						"sdmmc4_dat7_paa7";
+				nvidia,function = "sdmmc4";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			sdmmc4_reset {
+				nvidia,pins = "sdmmc4_rst_n_pcc3";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* I2C pinmux */
+			gen1_i2c {
+				nvidia,pins = "gen1_i2c_scl_pc4",
+						"gen1_i2c_sda_pc5";
+				nvidia,function = "i2c1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+			};
+
+			gen2_i2c {
+				nvidia,pins = "gen2_i2c_scl_pt5",
+						"gen2_i2c_sda_pt6";
+				nvidia,function = "i2c2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+			};
+
+			cam_i2c {
+				nvidia,pins = "cam_i2c_scl_pbb1",
+						"cam_i2c_sda_pbb2";
+				nvidia,function = "i2c3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+			};
+
+			ddc_i2c {
+				nvidia,pins = "ddc_scl_pv4",
+						"ddc_sda_pv5";
+				nvidia,function = "i2c4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+			};
+
+			pwr_i2c {
+				nvidia,pins = "pwr_i2c_scl_pz6",
+						"pwr_i2c_sda_pz7";
+				nvidia,function = "i2cpwr";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+			};
+
+			mhl_i2c {
+				nvidia,pins = "kb_col6_pq6",
+						"kb_col7_pq7";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* GPIO keys pinmux */
+			power_key {
+				nvidia,pins = "gmi_wp_n_pc7";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			volume_down {
+				nvidia,pins = "ulpi_data3_po4";
+				nvidia,function = "spi3";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Sensors pinmux */
+			sen_vdd {
+				nvidia,pins = "spi1_miso_px7";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			proxi_vdd {
+				nvidia,pins = "spi2_miso_px1";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			sen_vio {
+				nvidia,pins = "lcd_dc1_pd2";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			nct_irq {
+				nvidia,pins = "gmi_iordy_pi5";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			bat_irq {
+				nvidia,pins = "kb_row8_ps0";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			charger_irq {
+				nvidia,pins = "gmi_cs1_n_pj2";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			mpu_irq {
+				nvidia,pins = "gmi_ad12_ph4";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			compass_irq {
+				nvidia,pins = "gmi_ad13_ph5";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			light_irq {
+				nvidia,pins = "gmi_cs4_n_pk2";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* LED pinmux */
+			backlight_en {
+				nvidia,pins = "lcd_dc0_pn6";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			flash_led_en {
+				nvidia,pins = "pbb3";
+				nvidia,function = "vgp3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			keypad_led {
+				nvidia,pins = "kb_row2_pr2",
+						"kb_row3_pr3";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* NFC pinmux */
+			nfc_irq {
+				nvidia,pins = "spi2_cs1_n_pw2";
+				nvidia,function = "spi2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			nfc_ven {
+				nvidia,pins = "spi1_sck_px5";
+				nvidia,function = "spi1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			nfc_firm {
+				nvidia,pins = "kb_row0_pr0";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* DC pinmux */
+			lcd_pwr {
+				nvidia,pins = "lcd_pwr0_pb2",
+						"lcd_pwr1_pc1";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			lcd_wr_n {
+				nvidia,pins = "lcd_wr_n_pz3";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			lcd_id {
+				nvidia,pins = "lcd_m1_pw1";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			lcd_pclk {
+				nvidia,pins = "lcd_pclk_pb3",
+						"lcd_de_pj1",
+						"lcd_hsync_pj3",
+						"lcd_vsync_pj4";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			lcd_rgb_blue {
+				nvidia,pins = "lcd_d0_pe0",
+						"lcd_d1_pe1",
+						"lcd_d2_pe2",
+						"lcd_d3_pe3",
+						"lcd_d4_pe4",
+						"lcd_d5_pe5",
+						"lcd_d18_pm2",
+						"lcd_d19_pm3";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			lcd_rgb_green {
+				nvidia,pins = "lcd_d6_pe6",
+						"lcd_d7_pe7",
+						"lcd_d8_pf0",
+						"lcd_d9_pf1",
+						"lcd_d10_pf2",
+						"lcd_d11_pf3",
+						"lcd_d20_pm4",
+						"lcd_d21_pm5";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			lcd_rgb_red {
+				nvidia,pins = "lcd_d12_pf4",
+						"lcd_d13_pf5",
+						"lcd_d14_pf6",
+						"lcd_d15_pf7",
+						"lcd_d16_pm0",
+						"lcd_d17_pm1",
+						"lcd_d22_pm6",
+						"lcd_d23_pm7";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Bridge pinmux */
+			bridge_reset {
+				nvidia,pins = "ulpi_data1_po2";
+				nvidia,function = "spi3";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			rgb_ic_en {
+				nvidia,pins = "gmi_a18_pb1";
+				nvidia,function = "uartd";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			bridge_clk {
+				nvidia,pins = "clk3_out_pee0";
+				nvidia,function = "extperiph3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			rgb_bridge {
+				nvidia,pins = "lcd_sdin_pz2",
+						"lcd_sdout_pn5",
+						"lcd_cs0_n_pn4",
+						"lcd_sck_pz4";
+				nvidia,function = "spi5";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Panel pinmux */
+			panel_reset {
+				nvidia,pins = "lcd_cs1_n_pw0";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			panel_vio {
+				nvidia,pins = "ulpi_clk_py0";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Touchscreen pinmux */
+			touch_vdd {
+				nvidia,pins = "kb_col1_pq1";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			touch_vio {
+				nvidia,pins = "spi1_mosi_px4";
+				nvidia,function = "spi2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			touch_int_n {
+				nvidia,pins = "kb_col3_pq3";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			touch_rst_n {
+				nvidia,pins = "ulpi_data0_po1";
+				nvidia,function = "spi3";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			touch_maker_id {
+				nvidia,pins = "kb_col2_pq2";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* MHL pinmux */
+			mhl_vio {
+				nvidia,pins = "pv2";
+				nvidia,function = "owr";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			mhl_rst_n {
+				nvidia,pins = "clk3_req_pee1";
+				nvidia,function = "dev3";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			mhl_int {
+				nvidia,pins = "crt_vsync_pv7";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			mhl_sel {
+				nvidia,pins = "kb_row10_ps2";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			hdmi_hpd {
+				nvidia,pins = "hdmi_int_pn7";
+				nvidia,function = "hdmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* AUDIO pinmux */
+			hp_detect {
+				nvidia,pins = "pbb6";
+				nvidia,function = "vgp6";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			hp_hook {
+				nvidia,pins = "ulpi_data4_po5";
+				nvidia,function = "ulpi";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			ear_mic_en {
+				nvidia,pins = "spi2_mosi_px0";
+				nvidia,function = "spi2";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			audio_irq {
+				nvidia,pins = "spi2_cs2_n_pw3";
+				nvidia,function = "spi3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			audio_mclk {
+				nvidia,pins = "clk1_out_pw4";
+				nvidia,function = "extperiph1";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			dap_i2s0 {
+				nvidia,pins = "dap1_fs_pn0",
+						"dap1_din_pn1",
+						"dap1_dout_pn2",
+						"dap1_sclk_pn3";
+				nvidia,function = "i2s0";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			dap_i2s1 {
+				nvidia,pins = "dap2_fs_pa2",
+						"dap2_sclk_pa3",
+						"dap2_din_pa4",
+						"dap2_dout_pa5";
+				nvidia,function = "i2s1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* MUIC pinmux */
+			muic_irq {
+				nvidia,pins = "gmi_cs0_n_pj0";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			muic_dp2t {
+				nvidia,pins = "pcc2";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			muic_usif {
+				nvidia,pins = "ulpi_stp_py3";
+				nvidia,function = "spi1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			ifx_usb_vbus_en {
+				nvidia,pins = "kb_row4_pr4";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			pcb_rev {
+				nvidia,pins = "gmi_wait_pi7",
+						"gmi_rst_n_pi4";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			jtag_rtck {
+				nvidia,pins = "jtag_rtck_pu7";
+				nvidia,function = "rtck";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Camera pinmux */
+			cam_mclk {
+				nvidia,pins = "cam_mclk_pcc0";
+				nvidia,function = "vi_alt3";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			cam_pmic_en {
+				nvidia,pins = "pbb4";
+				nvidia,function = "vgp4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			front_cam_rst {
+				nvidia,pins = "pbb5";
+				nvidia,function = "vgp5";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			front_cam_vio {
+				nvidia,pins = "ulpi_nxt_py2";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			rear_cam_rst {
+				nvidia,pins = "gmi_cs3_n_pk4";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			rear_cam_eprom_pr {
+				nvidia,pins = "gmi_cs2_n_pk3";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			rear_cam_vcm_pwdn {
+				nvidia,pins = "kb_row1_pr1";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Haptic pinmux */
+			haptic_en {
+				nvidia,pins = "gmi_ad9_ph1";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			haptic_osc {
+				nvidia,pins = "gmi_ad11_ph3";
+				nvidia,function = "pwm3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Modem pinmux */
+			cp2ap_ack1_host_active {
+				nvidia,pins = "pu5";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			cp2ap_ack2_host_wakeup {
+				nvidia,pins = "pv0";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			ap2cp_ack2_suspend_req {
+				nvidia,pins = "kb_row14_ps6";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			ap2cp_ack1_slave_wakeup {
+				nvidia,pins = "kb_row15_ps7";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			cp_kkp {
+				nvidia,pins = "kb_col0_pq0";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			cp_crash_irq {
+				nvidia,pins = "kb_row13_ps5";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			// uart-a has to be adjusted
+			ap2cp_uarta_tx_ipc {
+				nvidia,pins = "pu0";
+				nvidia,function = "uarta";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			ap2cp_uarta_rx_ipc {
+				nvidia,pins = "pu1";
+				nvidia,function = "uarta";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			fota_ap_cts_cp_rts {
+				nvidia,pins = "pu2";
+				nvidia,function = "uarta";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			fota_ap_rts_cp_cts {
+				nvidia,pins = "pu3";
+				nvidia,function = "uarta";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			modem_enable {
+				nvidia,pins = "ulpi_data7_po0";
+				nvidia,function = "hsi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			modem_reset {
+				nvidia,pins = "pv1";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			dap_i2s2 {
+				nvidia,pins = "dap3_fs_pp0",
+						"dap3_din_pp1",
+						"dap3_dout_pp2",
+						"dap3_sclk_pp3";
+				nvidia,function = "i2s2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* GPIO power/drive control */
+			drive_i2c {
+				nvidia,pins = "drive_dbg",
+						"drive_at5",
+						"drive_gme",
+						"drive_ddc",
+						"drive_ao1";
+				nvidia,high-speed-mode = <TEGRA_PIN_DISABLE>;
+				nvidia,schmitt = <TEGRA_PIN_ENABLE>;
+				nvidia,low-power-mode = <TEGRA_PIN_LP_DRIVE_DIV_1>;
+				nvidia,pull-down-strength = <31>;
+				nvidia,pull-up-strength = <31>;
+				nvidia,slew-rate-rising = <TEGRA_PIN_SLEW_RATE_FASTEST>;
+				nvidia,slew-rate-falling = <TEGRA_PIN_SLEW_RATE_FASTEST>;
+			};
+
+			drive_uart3 {
+				nvidia,pins = "drive_uart3";
+				nvidia,high-speed-mode = <TEGRA_PIN_DISABLE>;
+				nvidia,schmitt = <TEGRA_PIN_ENABLE>;
+				nvidia,low-power-mode = <TEGRA_PIN_LP_DRIVE_DIV_1>;
+				nvidia,pull-down-strength = <31>;
+				nvidia,pull-up-strength = <31>;
+				nvidia,slew-rate-rising = <TEGRA_PIN_SLEW_RATE_FASTEST>;
+				nvidia,slew-rate-falling = <TEGRA_PIN_SLEW_RATE_FASTEST>;
+			};
+
+			drive_gmi {
+				nvidia,pins = "drive_at3";
+				nvidia,high-speed-mode = <TEGRA_PIN_DISABLE>;
+				nvidia,schmitt = <TEGRA_PIN_ENABLE>;
+				nvidia,low-power-mode = <TEGRA_PIN_LP_DRIVE_DIV_1>;
+				nvidia,pull-down-strength = <31>;
+				nvidia,pull-up-strength = <31>;
+				nvidia,slew-rate-rising = <TEGRA_PIN_SLEW_RATE_FASTEST>;
+				nvidia,slew-rate-falling = <TEGRA_PIN_SLEW_RATE_FASTEST>;
+			};
+		};
+	};
+
+	uartb: serial@70006040 {
+		compatible = "nvidia,tegra30-hsuart";
+		reset-names = "serial";
+		/delete-property/ reg-shift;
+		status = "okay";
+
+		/* GNSS GSD5T */
+	};
+
+	uartc: serial@70006200 {
+		compatible = "nvidia,tegra30-hsuart";
+		reset-names = "serial";
+		/delete-property/ reg-shift;
+		status = "okay";
+
+		nvidia,adjust-baud-rates = <0 9600 100>,
+					   <9600 115200 200>,
+					   <1000000 4000000 136>;
+
+		/* AZW BCM4330B1 37.4 MHz Class 1.5 ExtLNA */
+		bluetooth {
+			compatible = "brcm,bcm4330-bt";
+			max-speed = <4000000>;
+
+			clocks = <&tegra_pmc TEGRA_PMC_CLK_BLINK>;
+			clock-names = "txco";
+
+			interrupt-parent = <&gpio>;
+			interrupts = <TEGRA_GPIO(S, 4) IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "host-wakeup";
+
+			device-wakeup-gpios = <&gpio TEGRA_GPIO(S, 3) GPIO_ACTIVE_HIGH>;
+			shutdown-gpios = <&gpio TEGRA_GPIO(CC, 5) GPIO_ACTIVE_HIGH>;
+
+			vbat-supply = <&vdd_3v3_vbat>;
+			vddio-supply = <&vdd_1v8_vio>;
+		};
+	};
+
+	uartd: serial@70006300 {
+		/delete-property/ dmas;
+		/delete-property/ dma-names;
+		status = "okay";
+
+		/* Console */
+	};
+
+	pwm@7000a000 {
+		status = "okay";
+	};
+
+	gen1_i2c: i2c@7000c000 {
+		status = "okay";
+		clock-frequency = <400000>;
+
+		/* Aichi AMI306 digital compass */
+		magnetometer@e {
+			compatible = "asahi-kasei,ak8974";
+			reg = <0x0e>;
+
+			interrupt-parent = <&gpio>;
+			interrupts = <TEGRA_GPIO(H, 5) IRQ_TYPE_EDGE_RISING>;
+
+			avdd-supply = <&vdd_3v0_sen>;
+			dvdd-supply = <&vdd_1v8_vio>;
+
+			mount-matrix = "-1",  "0",  "0",
+					"0",  "1",  "0",
+					"0",  "0", "-1";
+		};
+
+		max98089: audio-codec@10 {
+			compatible = "maxim,max98089";
+			reg = <0x10>;
+
+			clocks = <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
+			clock-names = "mclk";
+
+			assigned-clocks = <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
+			assigned-clock-parents = <&tegra_car TEGRA30_CLK_EXTERN1>;
+		};
+
+		nfc@28 {
+			compatible = "nxp,pn544-i2c";
+			reg = <0x28>;
+
+			interrupt-parent = <&gpio>;
+			interrupts = <TEGRA_GPIO(W, 2) IRQ_TYPE_EDGE_RISING>;
+
+			enable-gpios = <&gpio TEGRA_GPIO(X, 5) GPIO_ACTIVE_HIGH>;
+			firmware-gpios = <&gpio TEGRA_GPIO(R, 0) GPIO_ACTIVE_HIGH>;
+		};
+
+		imu@68 {
+			compatible = "invensense,mpu6050";
+			reg = <0x68>;
+
+			interrupt-parent = <&gpio>;
+			interrupts = <TEGRA_GPIO(H, 4) IRQ_TYPE_EDGE_RISING>;
+
+			vdd-supply = <&vdd_3v0_sen>;
+			vddio-supply = <&vdd_1v8_sen>;
+
+			mount-matrix =  "1",  "0",  "0",
+					"0",  "1",  "0",
+					"0",  "0", "-1";
+		};
+	};
+
+	gen2_i2c: i2c@7000c400 {
+		status = "okay";
+		clock-frequency = <400000>;
+
+		/* Synaptics RMI4 S3203B touchcreen */
+		touchscreen@20 {
+			compatible = "syna,rmi4-i2c";
+			reg = <0x20>;
+
+			interrupt-parent = <&gpio>;
+			interrupts = <TEGRA_GPIO(Q, 3) IRQ_TYPE_EDGE_FALLING>;
+
+			vdd-supply = <&vdd_3v0_touch>;
+			vio-supply = <&vdd_1v8_touch>;
+
+			syna,reset-delay-ms = <20>;
+			syna,startup-delay-ms = <200>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			rmi4-f01@1 {
+				reg = <0x1>;
+				syna,nosleep-mode = <1>;
+			};
+
+			rmi4-f11@11 {
+				reg = <0x11>;
+				syna,sensor-type = <1>;
+
+				syna,clip-x-low = <0>;
+				syna,clip-y-low = <0>;
+			};
+		};
+	};
+
+	cam_i2c: i2c@7000c500 {
+		status = "okay";
+		clock-frequency = <400000>;
+
+		focuser@c {
+			compatible = "dongwoon,dw9714";
+			reg = <0x0c>;
+
+			vcc-supply = <&vcc_focuser>;
+		};
+
+		camera-pmic@7d {
+			compatible = "ti,lp8720";
+			reg = <0x7d>;
+
+			enable-gpios = <&gpio TEGRA_GPIO(BB, 4) GPIO_ACTIVE_HIGH>;
+
+			vt_1v2_front: ldo1 {
+				regulator-name = "vt_1v2_dig";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+			};
+
+			vt_2v7_front: ldo2 {
+				regulator-name = "vt_2v7_vana";
+				regulator-min-microvolt = <2700000>;
+				regulator-max-microvolt = <2700000>;
+			};
+
+			vdd_2v7_rear: ldo3 {
+				regulator-name = "8m_2v7_vana";
+				regulator-min-microvolt = <2700000>;
+				regulator-max-microvolt = <2800000>;
+			};
+
+			vio_1v8_rear: ldo4 {
+				regulator-name = "vio_1v8_cam";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+			};
+
+			vcc_focuser: ldo5 {
+				regulator-name = "8m_2v8_vcm";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+			};
+
+			vdd_1v2_rear: buck {
+				regulator-name = "8m_1v2_cam";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+			};
+		};
+	};
+
+	hdmi_ddc: i2c@7000c700 {
+		status = "okay";
+		clock-frequency = <100000>;
+	};
+
+	pwr_i2c: i2c@7000d000 {
+		status = "okay";
+		clock-frequency = <400000>;
+
+		pmic: max77663@1c {
+			compatible = "maxim,max77663";
+			reg = <0x1c>;
+
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+
+			#gpio-cells = <2>;
+			gpio-controller;
+
+			system-power-controller;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&max77663_default>;
+
+			max77663_default: pinmux {
+				gpio1 {
+					pins = "gpio1";
+					function = "gpio";
+					drive-open-drain = <1>;
+				};
+
+				gpio4 {
+					pins = "gpio4";
+					function = "32k-out1";
+				};
+			};
+
+			fps {
+				fps0 {
+					maxim,fps-event-source = <MAX77620_FPS_EVENT_SRC_EN0>;
+				};
+
+				fps1 {
+					maxim,fps-event-source = <MAX77620_FPS_EVENT_SRC_EN1>;
+				};
+
+				fps2 {
+					maxim,fps-event-source = <MAX77620_FPS_EVENT_SRC_EN0>;
+				};
+			};
+
+			regulators {
+				in-sd0-supply = <&vdd_5v0_vbus>;
+				in-sd1-supply = <&vdd_5v0_vbus>;
+				in-sd2-supply = <&vdd_5v0_vbus>;
+				in-sd3-supply = <&vdd_5v0_vbus>;
+
+				in-ldo0-1-supply = <&vdd_1v8_vio>;
+				in-ldo2-supply   = <&vdd_3v3_vbat>;
+				in-ldo3-5-supply = <&vdd_3v3_vbat>;
+				in-ldo4-6-supply = <&vdd_3v3_vbat>;
+				in-ldo7-8-supply = <&vdd_1v8_vio>;
+
+				vdd_cpu: sd0 {
+					regulator-name = "vdd_cpu";
+					regulator-min-microvolt = <800000>;
+					regulator-max-microvolt = <1250000>;
+					regulator-coupled-with = <&vdd_core>;
+					regulator-coupled-max-spread = <300000>;
+					regulator-max-step-microvolt = <100000>;
+					regulator-always-on;
+					regulator-boot-on;
+
+					nvidia,tegra-cpu-regulator;
+					maxim,active-fps-source = <MAX77620_FPS_SRC_NONE>;
+				};
+
+				vdd_core: sd1 {
+					regulator-name = "vdd_core";
+					regulator-min-microvolt = <950000>;
+					regulator-max-microvolt = <1350000>;
+					regulator-coupled-with = <&vdd_cpu>;
+					regulator-coupled-max-spread = <300000>;
+					regulator-max-step-microvolt = <100000>;
+					regulator-always-on;
+					regulator-boot-on;
+
+					nvidia,tegra-core-regulator;
+					maxim,active-fps-source = <MAX77620_FPS_SRC_1>;
+				};
+
+				vdd_1v8_vio: sd2 {
+					regulator-name = "vdd_1v8_gen";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+					regulator-boot-on;
+
+					maxim,active-fps-source = <MAX77620_FPS_SRC_NONE>;
+				};
+
+				sd3 {
+					regulator-name = "vdd_ddr";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+					regulator-always-on;
+					regulator-boot-on;
+
+					maxim,active-fps-source = <MAX77620_FPS_SRC_NONE>;
+				};
+
+				ldo0 {
+					regulator-name = "avdd_pll";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+
+					maxim,active-fps-source = <MAX77620_FPS_SRC_1>;
+				};
+
+				ldo1 {
+					regulator-name = "vdd_ddr_hs";
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <1000000>;
+					regulator-always-on;
+
+					maxim,active-fps-source = <MAX77620_FPS_SRC_NONE>;
+				};
+
+				avdd_3v3_periph: ldo2 {
+					regulator-name = "avdd_usb";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+
+					maxim,active-fps-source = <MAX77620_FPS_SRC_NONE>;
+				};
+
+				vdd_usd: ldo3 {
+					regulator-name = "vdd_sdmmc3";
+					regulator-min-microvolt = <3000000>;
+					regulator-max-microvolt = <3000000>;
+					regulator-always-on;
+
+					maxim,active-fps-source = <MAX77620_FPS_SRC_NONE>;
+				};
+
+				ldo4 {
+					regulator-name = "vdd_rtc";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+					regulator-always-on;
+					regulator-boot-on;
+
+					maxim,active-fps-source = <MAX77620_FPS_SRC_0>;
+				};
+
+				vcore_emmc: ldo5 {
+					regulator-name = "vdd_ddr_rx";
+					regulator-min-microvolt = <2850000>;
+					regulator-max-microvolt = <2850000>;
+					regulator-always-on;
+					regulator-boot-on;
+
+					maxim,active-fps-source = <MAX77620_FPS_SRC_0>;
+				};
+
+				avdd_1v8_hdmi_pll: ldo6 {
+					regulator-name = "avdd_osc";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+					regulator-boot-on;
+
+					maxim,active-fps-source = <MAX77620_FPS_SRC_NONE>;
+				};
+
+				vdd_1v2_mhl: ldo7 {
+					regulator-name = "vdd_1v2_mhl";
+					regulator-min-microvolt = <1050000>;
+					regulator-max-microvolt = <1250000>;
+
+					maxim,active-fps-source = <MAX77620_FPS_SRC_NONE>;
+				};
+
+				ldo8 {
+					regulator-name = "avdd_dsi_csi";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+
+					maxim,active-fps-source = <MAX77620_FPS_SRC_NONE>;
+				};
+			};
+		};
+
+		fuel-gauge@36 {
+			compatible = "maxim,max17043";
+			reg = <0x36>;
+
+			interrupt-parent = <&gpio>;
+			interrupts = <TEGRA_GPIO(S, 0) IRQ_TYPE_EDGE_FALLING>;
+
+			monitored-battery = <&battery>;
+			power-supplies = <&max8971>;
+
+			maxim,alert-low-soc-level = <10>;
+			wakeup-source;
+		};
+
+		power-sensor@40 {
+			compatible = "ti,ina230";
+			reg = <0x40>;
+
+			vs-supply = <&vdd_3v0_sen>;
+		};
+
+		nct72: temperature-sensor@4c {
+			compatible = "onnn,nct1008";
+			reg = <0x4c>;
+
+			interrupt-parent = <&gpio>;
+			interrupts = <TEGRA_GPIO(I, 5) IRQ_TYPE_EDGE_FALLING>;
+
+			vcc-supply = <&vdd_3v0_sen>;
+			#thermal-sensor-cells = <1>;
+		};
+	};
+
+	i2c-mhl {
+		compatible = "i2c-gpio";
+
+		sda-gpios = <&gpio TEGRA_GPIO(Q, 7) (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&gpio TEGRA_GPIO(Q, 6) (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+
+		i2c-gpio,delay-us = <5>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	spi@7000dc00 {
+		status = "okay";
+		spi-max-frequency = <25000000>;
+
+		/* DSI bridge */
+	};
+
+	pmc@7000e400 {
+		status = "okay";
+		nvidia,invert-interrupt;
+		nvidia,suspend-mode = <2>;
+		nvidia,cpu-pwr-good-time = <2000>;
+		nvidia,cpu-pwr-off-time = <200>;
+		nvidia,core-pwr-good-time = <3845 3845>;
+		nvidia,core-pwr-off-time = <0>;
+		nvidia,core-power-req-active-high;
+		nvidia,sys-clock-req-active-high;
+		core-supply = <&vdd_core>;
+
+		i2c-thermtrip {
+			nvidia,i2c-controller-id = <4>;
+			nvidia,bus-addr = <0x1c>;
+			nvidia,reg-addr = <0x41>;
+			nvidia,reg-data = <0x02>;
+		};
+	};
+
+	hda@70030000 {
+		status = "okay";
+	};
+
+	ahub@70080000 {
+		/* HIFI CODEC */
+		i2s@70080300 {		/* i2s0 */
+			status = "okay";
+		};
+
+		/* BASEBAND */
+		i2s@70080500 {		/* i2s2 */
+			status = "okay";
+		};
+
+		/* BT SCO */
+		i2s@70080600 {		/* i2s3 */
+			status = "okay";
+		};
+	};
+
+	sdmmc1: mmc@78000000 {
+		status = "okay";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		assigned-clocks = <&tegra_car TEGRA30_CLK_SDMMC1>;
+		assigned-clock-parents = <&tegra_car TEGRA30_CLK_PLL_C>;
+		assigned-clock-rates = <50000000>;
+
+		max-frequency = <50000000>;
+		keep-power-in-suspend;
+		bus-width = <4>;
+		non-removable;
+
+		mmc-pwrseq = <&brcm_wifi_pwrseq>;
+		vmmc-supply = <&vdd_3v3_vbat>;
+		vqmmc-supply = <&vdd_1v8_vio>;
+
+		/* BCM4330B1 37.4 MHz Class 1.5 ExtLNA */
+		wifi@1 {
+			compatible = "brcm,bcm4329-fmac";
+			reg = <1>;
+
+			interrupt-parent = <&gpio>;
+			interrupts = <TEGRA_GPIO(U, 6) IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "host-wake";
+		};
+	};
+
+	sdmmc4: mmc@78000600 {
+		status = "okay";
+		bus-width = <8>;
+
+		non-removable;
+		mmc-ddr-1_8v;
+
+		vmmc-supply = <&vcore_emmc>;
+		vqmmc-supply = <&vdd_1v8_vio>;
+	};
+
+	/* Micro USB */
+	usb@7d000000 {
+		compatible = "nvidia,tegra30-udc";
+		status = "okay";
+		dr_mode = "peripheral";
+	};
+
+	usb-phy@7d000000 {
+		status = "okay";
+		dr_mode = "peripheral";
+		nvidia,hssync-start-delay = <0>;
+		nvidia,xcvr-lsfslew = <2>;
+		nvidia,xcvr-lsrslew = <2>;
+		vbus-supply = <&avdd_3v3_periph>;
+	};
+
+	/* PMIC has a built-in 32KHz oscillator which is used by PMC */
+	clk32k_in: clock-32k {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "pmic-oscillator";
+	};
+
+	gps_refclk: clock-gps {
+		compatible = "fixed-clock";
+		clock-frequency = <26000000>;
+		clock-accuracy = <100>;
+		#clock-cells = <0>;
+	};
+
+	gps_osc: clock-gps-osc-gate {
+		compatible = "gpio-gate-clock";
+		enable-gpios = <&gpio TEGRA_GPIO(H, 0) GPIO_ACTIVE_HIGH>;
+		clocks = <&gps_refclk>;
+		#clock-cells = <0>;
+	};
+
+	cpus {
+		cpu0: cpu@0 {
+			cpu-supply = <&vdd_cpu>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
+		};
+		cpu1: cpu@1 {
+			cpu-supply = <&vdd_cpu>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
+		};
+		cpu2: cpu@2 {
+			cpu-supply = <&vdd_cpu>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
+		};
+		cpu3: cpu@3 {
+			cpu-supply = <&vdd_cpu>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		key-power {
+			label = "Power";
+			gpios = <&gpio TEGRA_GPIO(C, 7) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
+			debounce-interval = <10>;
+			wakeup-event-action = <EV_ACT_ASSERTED>;
+			wakeup-source;
+		};
+
+		key-volume-down {
+			label = "Volume Down";
+			gpios = <&gpio TEGRA_GPIO(O, 4) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+			debounce-interval = <10>;
+			wakeup-event-action = <EV_ACT_ASSERTED>;
+			wakeup-source;
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		led-keypad {
+			label = "keypad::white";
+			gpios = <&gpio TEGRA_GPIO(R, 2) GPIO_ACTIVE_HIGH>;
+
+			color = <LED_COLOR_ID_WHITE>;
+			function = LED_FUNCTION_KBD_BACKLIGHT;
+		};
+	};
+
+	opp-table-actmon {
+		/delete-node/ opp-625000000;
+		/delete-node/ opp-667000000;
+		/delete-node/ opp-750000000;
+		/delete-node/ opp-800000000;
+		/delete-node/ opp-900000000;
+	};
+
+	opp-table-emc {
+		/delete-node/ opp-625000000-1200;
+		/delete-node/ opp-625000000-1250;
+		/delete-node/ opp-667000000-1200;
+		/delete-node/ opp-750000000-1300;
+		/delete-node/ opp-800000000-1300;
+		/delete-node/ opp-900000000-1350;
+	};
+
+	brcm_wifi_pwrseq: pwrseq-wifi {
+		compatible = "mmc-pwrseq-simple";
+
+		clocks = <&tegra_pmc TEGRA_PMC_CLK_BLINK>;
+		clock-names = "ext_clock";
+
+		reset-gpios = <&gpio TEGRA_GPIO(V, 3) GPIO_ACTIVE_LOW>;
+		post-power-on-delay-ms = <300>;
+		power-off-delay-us = <300>;
+	};
+
+	vdd_5v0_vbus: regulator-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vdd_3v3_vbat: regulator-vbat {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_vbat";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&vdd_5v0_vbus>;
+	};
+
+	vdd_3v0_sen: regulator-sen3v {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_3v0_sensor";
+		regulator-min-microvolt = <3000000>;
+		regulator-max-microvolt = <3000000>;
+		regulator-boot-on;
+		gpio = <&gpio TEGRA_GPIO(X, 7) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply = <&vdd_3v3_vbat>;
+	};
+
+	vdd_3v0_proxi: regulator-proxi {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_3v0_proxi";
+		regulator-min-microvolt = <3000000>;
+		regulator-max-microvolt = <3000000>;
+		regulator-boot-on;
+		gpio = <&gpio TEGRA_GPIO(X, 1) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply = <&vdd_3v3_vbat>;
+	};
+
+	vdd_1v8_sen: regulator-sen1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_1v8_sensor";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		gpio = <&gpio TEGRA_GPIO(D, 2) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply = <&vdd_3v3_vbat>;
+	};
+
+	vcc_3v0_lcd: regulator-lcd3v {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_3v0_lcd";
+		regulator-min-microvolt = <3000000>;
+		regulator-max-microvolt = <3000000>;
+		regulator-boot-on;
+		vin-supply = <&vdd_3v3_vbat>;
+	};
+
+	iovcc_1v8_lcd: regulator-lcd1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "iovcc_1v8_lcd";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		gpio = <&gpio TEGRA_GPIO(Y, 0) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply = <&vdd_3v3_vbat>;
+	};
+
+	vio_1v8_mhl: regulator-mhl1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "vio_1v8_mhl";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		gpio = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply = <&vdd_3v3_vbat>;
+	};
+
+	vdd_3v0_touch: regulator-touchpwr {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_3v0_touch";
+		regulator-min-microvolt = <3000000>;
+		regulator-max-microvolt = <3000000>;
+		regulator-boot-on;
+		gpio = <&gpio TEGRA_GPIO(Q, 1) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply = <&vdd_3v3_vbat>;
+	};
+
+	vdd_1v8_touch: regulator-touchvio {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_1v8_touch";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		gpio = <&gpio TEGRA_GPIO(X, 4) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply = <&vdd_3v3_vbat>;
+	};
+
+	vcc_1v8_gps: regulator-gps {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_1v8_gps";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		gpio = <&gpio TEGRA_GPIO(Y, 1) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply = <&vdd_3v3_vbat>;
+	};
+
+	vio_1v8_front: regulator-frontvio {
+		compatible = "regulator-fixed";
+		regulator-name = "vt_1v8_cam_vio";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&gpio TEGRA_GPIO(Y, 2) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply = <&vdd_3v3_vbat>;
+	};
+
+	sound {
+		nvidia,audio-routing =
+			"Headphone Jack", "HPL",
+			"Headphone Jack", "HPR",
+			"Int Spk", "SPKL",
+			"Int Spk", "SPKR",
+			"Earpiece", "RECL",
+			"Earpiece", "RECR",
+			"INA1", "Mic Jack",
+			"MIC1", "MICBIAS",
+			"MICBIAS", "Internal Mic 1",
+			"MIC2", "Internal Mic 2";
+
+		nvidia,i2s-controller = <&tegra_i2s0>;
+		nvidia,audio-codec = <&max98089>;
+
+		nvidia,hp-det-gpios = <&gpio TEGRA_GPIO(BB, 6) GPIO_ACTIVE_LOW>;
+		nvidia,mic-det-gpios = <&gpio TEGRA_GPIO(O, 5) GPIO_ACTIVE_HIGH>;
+		nvidia,ext-mic-en-gpios = <&gpio TEGRA_GPIO(X, 0) GPIO_ACTIVE_HIGH>;
+		nvidia,coupled-mic-hp-det;
+
+		clocks = <&tegra_car TEGRA30_CLK_PLL_A>,
+			 <&tegra_car TEGRA30_CLK_PLL_A_OUT0>,
+			 <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
+		clock-names = "pll_a", "pll_a_out0", "mclk";
+
+		assigned-clocks = <&tegra_car TEGRA30_CLK_EXTERN1>,
+				  <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
+
+		assigned-clock-parents = <&tegra_car TEGRA30_CLK_PLL_A_OUT0>,
+					 <&tegra_car TEGRA30_CLK_EXTERN1>;
+	};
+
+	thermal-zones {
+		/*
+		 * NCT72 has two sensors:
+		 *
+		 *	0: internal that monitors ambient/skin temperature
+		 *	1: external that is connected to the CPU's diode
+		 *
+		 * Ideally we should use userspace thermal governor,
+		 * but it's a much more complex solution. The "skin"
+		 * zone exists as a simpler solution which prevents
+		 * this device from getting too hot from a user's
+		 * tactile perspective. The CPU zone is intended to
+		 * protect silicon from damage.
+		 */
+
+		skin-thermal {
+			polling-delay-passive = <1000>; /* milliseconds */
+			polling-delay = <5000>; /* milliseconds */
+
+			thermal-sensors = <&nct72 0>;
+
+			trips {
+				trip0: skin-alert {
+					/* throttle at 50C until temperature drops to 49.8C */
+					temperature = <50000>;
+					hysteresis = <200>;
+					type = "passive";
+				};
+
+				trip1: skin-crit {
+					/* shut down at 60C */
+					temperature = <60000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&trip0>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&actmon THERMAL_NO_LIMIT
+								  THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu-thermal {
+			polling-delay-passive = <1000>; /* milliseconds */
+			polling-delay = <5000>; /* milliseconds */
+
+			thermal-sensors = <&nct72 1>;
+
+			trips {
+				trip2: cpu-alert {
+					/* throttle at 75C until temperature drops to 74.8C */
+					temperature = <75000>;
+					hysteresis = <200>;
+					type = "passive";
+				};
+
+				trip3: cpu-crit {
+					/* shut down at 90C */
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map1 {
+					trip = <&trip2>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&actmon THERMAL_NO_LIMIT
+								  THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+	};
+};
-- 
2.40.1


