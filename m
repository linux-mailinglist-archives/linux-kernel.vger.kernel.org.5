Return-Path: <linux-kernel+bounces-55289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D6484BA53
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FC9928F53A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC619135418;
	Tue,  6 Feb 2024 15:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhntsEO/"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7ED1350E3;
	Tue,  6 Feb 2024 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707235031; cv=none; b=A0rqFHZDG2wmR9PaiGGTkhRT7ri7QQsyZDJLXZRPCh5Rs2wdeaOMecWztfn/v+03+UjJvku4buZjvHD1c8MQoilEOe4Tl/oZVo86kbRSrOgutpPVK03CsgL5g31aO8o70+stQth3yhmVYtbioTc9uGLVadJSdd7H/XosLrVZhXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707235031; c=relaxed/simple;
	bh=Oiqj3czgWrNk4uJ5TS5zUfoVcWpLq/UjqyArJekAES4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p43Kee+IfaWsjfOgS3aJBhnFnLXeFwsNdGbO0DXx5mjYmbahbAYdQRdGTslK4eQiOgNdMl26Q5tZkNtO5sROCW4S6F7OAwWUS4Dd/syStf+pCdWxSje/KVt8ZsylKF9/5KSN5buLGDLBlrwrYrwGzVxMgY3QK4mbC4Zr/ITt1PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhntsEO/; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5605c7b0ca2so2989637a12.3;
        Tue, 06 Feb 2024 07:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707235027; x=1707839827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=176gRZ0aHCc+EOicp7S6VeOhWY+2nPq3bOkXh2u8lps=;
        b=fhntsEO/N12eUaJA0mFmgUkqAR79krLurOv79qqLcI/WQuOXihbYc/vpb4PvSfQTHv
         n/IDumBtMurpsXo55wf+aLo/nKsPb/d7saa7POW7E1UKSB8r19LmrwuCDU69MkYfT5Qx
         csM8psYPBofjM+JKnuE4HjJVzerCoVQAkECMpm0b8TRyJlE2jQHYmweGUb9cDlk4cERf
         VX+jdZNr1SIXxLxilxSs6FgCvXPVNK7ZEP4/Lns1hkkIRN7auDfaCzCLImPjfP4QxF98
         t5/gNcg5eF/sB/GhwF7O3TdgKxJhmz1OpiCbSUakyqCRUjugssuV5xbk0qTTexqEd76i
         lSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707235027; x=1707839827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=176gRZ0aHCc+EOicp7S6VeOhWY+2nPq3bOkXh2u8lps=;
        b=D0xG8IAKXJkUifFQSIwf3GTTowod9Xj/r8Ej1W7LqD7zPkOdAsP7ZwHD/0AVaDJbti
         6wGl914RdlaXccuzHf4/qa2Cu7eqHD6MWnaLQpOPudcYqYNdUXLsPZtqgSx3ZVztpPIV
         /IugtVkHx63pspd6l0v5wDvKRq8ErolAu1xEkWzrqLY6xzUo9je2ljcGvhN0tPlb/6hL
         tGg5zcsSd7/ahRVVtwrvdUd05LqFwtIlQ0kc0bD5yUv7W1EieKAj8yTLL3w2rySO93Jh
         v9ox61QFiPmP/jzPmryNym0QygpJpD0ea432zVWa7rKzp80c55DThAkDQ0tjqOWx8jH0
         GzfQ==
X-Gm-Message-State: AOJu0Yz/4LDtYn4i+snVgiHrclWwoy/5mzBW4MVsNAeKB95v8rO1WkqR
	amJlP/+poXZrXvul2vE2yESgPmRrOBl+OIRzYx5YGsmJR6yi/Thp
X-Google-Smtp-Source: AGHT+IHowD2L078pZrH6Z28XtPQKTRBn7dWLC+bflwyhQa8IvdC7CXTzXR8mg/vSGK/VTlgBGDg1LA==
X-Received: by 2002:a05:6402:782:b0:55f:fad8:4635 with SMTP id d2-20020a056402078200b0055ffad84635mr2004248edy.27.1707235027009;
        Tue, 06 Feb 2024 07:57:07 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUsm41f/BscG3dBwm+zVkxoHmWFDl/RIP9KtOpS0zxXDaTlaiCQSIu87yTl92bZjVUaJluAg3hc0ij/4ZW58IFbdeKC9zPJjxi8rfQy1esQCG/1TVadJ9vFmauMJle6jpj0OSKTF6thdEpZfLHnWEQIwT8m9ROt/L5Ub6Sb790GeDc6Q0TfBMZOgzB9Wkf7n1yjcVwmsJ5rEiAJ6b4tuPRL2KhsYIByH7KYVg227XWh7Vxmtt9Y9KD6gqTaJBQsfZlX5URVOECy9gLVCxY8mdQD4BMjvTUJ+bGJoXRbRzajsyUYyak+0kjc7GN1H1IztvA1340t70Q8Mu2qrybgo9hsNFOEV0Z0aSrjRhN8WG8w0FR+D9JgMao+UFy99UBGQGfTyg==
Received: from xeon.. ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id ba14-20020a0564021ace00b005605716e755sm1149869edb.52.2024.02.06.07.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 07:57:06 -0800 (PST)
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
Subject: [PATCH v3 3/3] ARM: tegra: Add device-tree for LG Optimus 4X HD (P880)
Date: Tue,  6 Feb 2024 17:56:43 +0200
Message-Id: <20240206155643.28749-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240206155643.28749-1-clamor95@gmail.com>
References: <20240206155643.28749-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device-tree for LG Optimus 4X HD P880, which is a NVIDIA
Tegra30-based smartphone, originally running Android.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/boot/dts/nvidia/Makefile            |   1 +
 arch/arm/boot/dts/nvidia/tegra30-lg-p880.dts | 489 +++++++++++++++++++
 2 files changed, 490 insertions(+)
 create mode 100644 arch/arm/boot/dts/nvidia/tegra30-lg-p880.dts

diff --git a/arch/arm/boot/dts/nvidia/Makefile b/arch/arm/boot/dts/nvidia/Makefile
index f66337e5d188..96972559253c 100644
--- a/arch/arm/boot/dts/nvidia/Makefile
+++ b/arch/arm/boot/dts/nvidia/Makefile
@@ -39,6 +39,7 @@ dtb-$(CONFIG_ARCH_TEGRA_3x_SOC) += \
 	tegra30-cardhu-a02.dtb \
 	tegra30-cardhu-a04.dtb \
 	tegra30-colibri-eval-v3.dtb \
+	tegra30-lg-p880.dtb \
 	tegra30-lg-p895.dtb \
 	tegra30-ouya.dtb \
 	tegra30-pegatron-chagall.dtb
diff --git a/arch/arm/boot/dts/nvidia/tegra30-lg-p880.dts b/arch/arm/boot/dts/nvidia/tegra30-lg-p880.dts
new file mode 100644
index 000000000000..2f7754fd42a1
--- /dev/null
+++ b/arch/arm/boot/dts/nvidia/tegra30-lg-p880.dts
@@ -0,0 +1,489 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include "tegra30-lg-x3.dtsi"
+
+/ {
+	model = "LG Optimus 4X HD P880";
+	compatible = "lg,p880", "nvidia,tegra30";
+
+	aliases {
+		mmc1 = &sdmmc3; /* uSD slot */
+		mmc2 = &sdmmc1; /* WiFi */
+	};
+
+	pinmux@70000868 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&state_default>;
+
+		state_default: pinmux {
+			/* WLAN SDIO pinmux */
+			host-wlan-wake {
+				nvidia,pins = "pu4";
+				nvidia,function = "pwm1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* GNSS UART-B pinmux */
+			uartb-rxd {
+				nvidia,pins = "uart2_rxd_pc3";
+				nvidia,function = "uartb";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			uartb-txd {
+				nvidia,pins = "uart2_txd_pc2";
+				nvidia,function = "uartb";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gps-reset {
+				nvidia,pins = "kb_row7_pr7";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* MicroSD pinmux */
+			sdmmc3-clk {
+				nvidia,pins = "sdmmc3_clk_pa6";
+				nvidia,function = "sdmmc3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			sdmmc3-data {
+				nvidia,pins = "sdmmc3_cmd_pa7",
+						"sdmmc3_dat0_pb7",
+						"sdmmc3_dat1_pb6",
+						"sdmmc3_dat2_pb5",
+						"sdmmc3_dat3_pb4";
+				nvidia,function = "sdmmc3";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			microsd-detect {
+				nvidia,pins = "clk2_out_pw5";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* GPIO keys pinmux */
+			volume-up {
+				nvidia,pins = "ulpi_data6_po7";
+				nvidia,function = "spi2";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Sensors pinmux */
+			current-alert-irq {
+				nvidia,pins = "uart2_rts_n_pj6";
+				nvidia,function = "uartb";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* AUDIO pinmux */
+			sub-mic-ldo {
+				nvidia,pins = "gmi_cs7_n_pi6";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+		};
+	};
+
+	i2c@7000c400 {
+		touchscreen@20 {
+			rmi4-f11@11 {
+				syna,clip-x-high = <1110>;
+				syna,clip-y-high = <1973>;
+
+				touchscreen-inverted-y;
+			};
+		};
+	};
+
+	memory-controller@7000f000 {
+		emc-timings-0 {
+			/* SAMSUNG 1GB K4P8G304EB FGC1 533MHz */
+			nvidia,ram-code = <0>;
+
+			timing-12750000 {
+				clock-frequency = <12750000>;
+
+				nvidia,emem-configuration = < 0x00050001 0xc0000010
+					0x00000001 0x00000001 0x00000002 0x00000000
+					0x00000003 0x00000001 0x00000002 0x00000004
+					0x00000001 0x00000000 0x00000002 0x00000002
+					0x02020001 0x00060402 0x77230303 0x001f0000 >;
+			};
+
+			timing-25500000 {
+				clock-frequency = <25500000>;
+
+				nvidia,emem-configuration = < 0x00020001 0xc0000010
+					0x00000001 0x00000001 0x00000002 0x00000000
+					0x00000003 0x00000001 0x00000002 0x00000004
+					0x00000001 0x00000000 0x00000002 0x00000002
+					0x02020001 0x00060402 0x73e30303 0x001f0000 >;
+			};
+
+			timing-51000000 {
+				clock-frequency = <51000000>;
+
+				nvidia,emem-configuration = < 0x00010001 0xc0000010
+					0x00000001 0x00000001 0x00000002 0x00000000
+					0x00000003 0x00000001 0x00000002 0x00000004
+					0x00000001 0x00000000 0x00000002 0x00000002
+					0x02020001 0x00060402 0x72c30303 0x001f0000 >;
+			};
+
+			timing-102000000 {
+				clock-frequency = <102000000>;
+
+				nvidia,emem-configuration = < 0x00000001 0xc0000018
+					0x00000001 0x00000001 0x00000003 0x00000001
+					0x00000003 0x00000001 0x00000002 0x00000004
+					0x00000001 0x00000000 0x00000002 0x00000002
+					0x02020001 0x00060403 0x72430504 0x001f0000 >;
+			};
+
+			timing-204000000 {
+				clock-frequency = <204000000>;
+
+				nvidia,emem-configuration = < 0x00000003 0xc0000025
+					0x00000001 0x00000001 0x00000006 0x00000003
+					0x00000005 0x00000001 0x00000002 0x00000004
+					0x00000001 0x00000000 0x00000003 0x00000002
+					0x02030001 0x00070506 0x71e40a07 0x001f0000 >;
+			};
+
+			timing-266500000 {
+				clock-frequency = <266500000>;
+
+				nvidia,emem-configuration = < 0x00000004 0xC0000030
+					0x00000001 0x00000002 0x00000008 0x00000004
+					0x00000006 0x00000001 0x00000002 0x00000005
+					0x00000001 0x00000000 0x00000003 0x00000003
+					0x03030001 0x00090608 0x70040c09 0x001f0000 >;
+			};
+
+			timing-533000000 {
+				clock-frequency = <533000000>;
+
+				nvidia,emem-configuration = < 0x00000008 0xC0000060
+					0x00000003 0x00000004 0x00000010 0x0000000a
+					0x0000000d 0x00000002 0x00000002 0x00000008
+					0x00000002 0x00000000 0x00000004 0x00000005
+					0x05040002 0x00110b10 0x70281811 0x001f0000 >;
+			};
+		};
+	};
+
+	memory-controller@7000f400 {
+		emc-timings-0 {
+			/* SAMSUNG 1GB K4P8G304EB FGC1 533MHz */
+			nvidia,ram-code = <0>;
+
+			timing-12750000 {
+				clock-frequency = <12750000>;
+
+				nvidia,emc-auto-cal-interval = <0x001fffff>;
+				nvidia,emc-mode-1 = <0x00010022>;
+				nvidia,emc-mode-2 = <0x00020001>;
+				nvidia,emc-mode-reset = <0x00000000>;
+				nvidia,emc-zcal-cnt-long = <0x00000009>;
+				nvidia,emc-cfg-dyn-self-ref;
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
+					0x00000003 0x00000008 0x00000004 0x00000001
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
+				nvidia,emc-cfg-dyn-self-ref;
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
+					0x00000003 0x00000008 0x00000004 0x00000001
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
+					0x00000000 0x800001c5 0xe0000000 0xff00ff00 >;
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
+				nvidia,emc-cfg-dyn-self-ref;
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
+					0x00000003 0x00000008 0x00000004 0x00000001
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
+					0x00000000 0x80000287 0xe0000000 0xff00ff00 >;
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
+				nvidia,emc-cfg-dyn-self-ref;
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
+					0x00000003 0x00000008 0x00000004 0x00000001
+					0x00000002 0x000001a9 0x00000004 0x00000004
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
+					0x00000000 0x8000040b 0xe0000000 0xff00ff00 >;
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
+				nvidia,emc-cfg-dyn-self-ref;
+				nvidia,emc-cfg-periodic-qrst;
+
+				nvidia,emc-configuration =  < 0x0000000c
+					0x0000001a 0x00000008 0x00000003 0x00000005
+					0x00000004 0x00000001 0x00000006 0x00000003
+					0x00000003 0x00000002 0x00000002 0x00000000
+					0x00000001 0x00000003 0x00000001 0x0000000c
+					0x0000000a 0x00000303 0x00000000 0x000000c0
+					0x00000001 0x00000001 0x00000003 0x00000000
+					0x00000001 0x00000007 0x0000001d 0x0000001d
+					0x00000004 0x0000000b 0x00000005 0x00000001
+					0x00000002 0x00000351 0x00000004 0x00000006
+					0x00000000 0x00000000 0x00004282 0x004400a4
+					0x00008000 0x00070000 0x00070000 0x00070000
+					0x00070000 0x00070000 0x00070000 0x00070000
+					0x00070000 0x00000000 0x00000000 0x00000000
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
+					0x00000004 0x0000000e 0x00000006 0x00000001
+					0x00000002 0x00000455 0x00000000 0x00000004
+					0x00000000 0x00000000 0x00006282 0x003200a4
+					0x00008000 0x00050000 0x00050000 0x00050000
+					0x00050000 0x00050000 0x00050000 0x00050000
+					0x00050000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00060000 0x00060000 0x00060000
+					0x00060000 0x000b0220 0x0800003d 0x00000000
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
+					0x00000004 0x00000009 0x00000006 0x0000000d
+					0x00000010 0x000007df 0x00000000 0x000001f7
+					0x00000003 0x00000003 0x00000009 0x00000000
+					0x00000001 0x0000000f 0x0000004b 0x0000004b
+					0x00000008 0x0000001b 0x0000000c 0x00000001
+					0x00000002 0x000008aa 0x00000000 0x00000006
+					0x00000000 0x00000000 0x00006282 0xf0120091
+					0x00008000 0x0000000a 0x0000000a 0x0000000a
+					0x0000000a 0x0000000a 0x0000000a 0x0000000a
+					0x0000000a 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x0000000a 0x0000000a 0x0000000a
+					0x0000000a 0x00090220 0x0800003d 0x00000000
+					0x77ffc004 0x01f1f408 0x00000000 0x00000007
+					0x08000068 0x08000000 0x00000802 0x00064000
+					0x000000c0 0x000e000e 0xa0f10000 0x00000000
+					0x00000000 0x800010d9 0xe0000000 0xff00ff88 >;
+			};
+		};
+	};
+
+	sdmmc3: mmc@78000400 {
+		status = "okay";
+
+		cd-gpios = <&gpio TEGRA_GPIO(W, 5) GPIO_ACTIVE_LOW>;
+		bus-width = <4>;
+
+		vmmc-supply = <&vdd_usd>;
+		vqmmc-supply = <&vdd_1v8_vio>;
+	};
+
+	battery: battery-cell {
+		compatible = "simple-battery";
+		device-chemistry = "lithium-ion";
+		charge-full-design-microamp-hours = <2150000>;
+		energy-full-design-microwatt-hours = <8200000>;
+		operating-range-celsius = <0 45>;
+	};
+
+	gpio-keys {
+		key-volume-up {
+			label = "Volume Up";
+			gpios = <&gpio TEGRA_GPIO(O, 7) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+			debounce-interval = <10>;
+			wakeup-event-action = <EV_ACT_ASSERTED>;
+			wakeup-source;
+		};
+	};
+
+	sound {
+		compatible = "lg,tegra-audio-max98089-p880",
+			     "nvidia,tegra-audio-max98089";
+		nvidia,model = "LG Optimus 4X HD MAX98089";
+
+		nvidia,int-mic-en-gpios = <&gpio TEGRA_GPIO(I, 6) GPIO_ACTIVE_HIGH>;
+	};
+};
-- 
2.40.1


