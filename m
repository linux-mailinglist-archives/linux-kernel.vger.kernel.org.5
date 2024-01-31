Return-Path: <linux-kernel+bounces-46266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DA1843D45
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B486D29B606
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB6869DF2;
	Wed, 31 Jan 2024 10:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnvHn+gl"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E8274E0D;
	Wed, 31 Jan 2024 10:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706698338; cv=none; b=fqNIkYXgXSl9pn4Uq3X7vs7XX9I4oG77zoN6+8iXdakGwfaPijY6ZAsSWmVgBq48yKp0n5BjJKmbmgWxkaLUbKfZjvxuQxVqLZK4sTdSegHKlSbTtRf0o0t31NZznUtXvj0Aztm/bNHtz3fgqJKlPrH5yu+gRkJ6+W3nlA5PDV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706698338; c=relaxed/simple;
	bh=5Rbsf+/7ir7bv3bb//4Wsa5Q0eS1NKoaIWd6RplfjxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EFWcBLF3e+nDXwvKaoUUNhbt3O0BeucodhNJFxJ4ULuIHc7QvierM8m4mmssG50znGLvFUwjb+QTSTCk5i5fvslmYIPhfPyO4yswodzZnYTIBpQv6bgVpAWATenPbSZ0EGjGLqlgrfV2hCIBpgiVV3/6ytbaD6DEI1xYYTXSfPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnvHn+gl; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d05b06b5f9so21241211fa.3;
        Wed, 31 Jan 2024 02:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706698334; x=1707303134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Se9CfwSQUxv6KXVDhcaxPQjUC3aACwPcr2JuIZJ0gkU=;
        b=VnvHn+glIAGIKvayAGmqceWqwiY2pcue5mubY+7HcVOTg4iRsvKTZbFA2UxBOCp4al
         /eu8h2OfbLwGL9HCif41kQh2Z9cSV5cbWcqZPxeMSQs7ZYQCn+67GPZkXQeeEWdasdkx
         sUL4dNNg20dNpg69iKl6USr6rGOCsKk71aWaQTp+hiOlTkVTYPs1dR8D89u+rBSpz88l
         zkbEDYnKFFlmoWx9DfbJPAfwKg8QQfPXcGLU1t6669c1LKZoNXeEUKhxSh4CtZ19KRDr
         L82iZSYkN2M/jJ9S/4h56j/6obsYrME8xIDbhoBWlHZrprKOB+97QM63zVGwUXlabEAk
         +uYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706698334; x=1707303134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Se9CfwSQUxv6KXVDhcaxPQjUC3aACwPcr2JuIZJ0gkU=;
        b=Be56EsdFWAmdNXQhLYPPW6F28vj4bUkyP66FoIPCzSOBYIRbVz1GSKMUfAwedkoz8h
         kp1xlmW9SsW+Ae11RfYMdLZKcfgPAmnUevXC0uoxbEYSfKODA+RO9/OsElhdRvvDL/if
         9Jdp68qIUQKgBOt2rXXytyGcWrSl9QdOQLjOPfTh+1ChwifT4scl0WcivWeZNSOwAfDq
         tWvvKUFh0c5et74PIM0XYMmDZEyiiFZppOrVzPfXqQAk1htTbtUSNpfTmKhfR1JiME6g
         CfjLH15QHL0PH/PgG9rHeBpvvKvZUF4SqhKL8ZzleywxlVnrzbN9/PdwOkI7GhLu6Hcq
         eEcA==
X-Gm-Message-State: AOJu0YxJIvwx3x+OcD8PZyUpd2GBvpXg5Z8Om4/Yo5L/s0hp271PrE2A
	6HOVZJN3q3hklWsSWHc9mybZ5EOeENjT5mAXXyLJYj6IeO3bwhyR
X-Google-Smtp-Source: AGHT+IG6TqxmxQN3E3m+o5DalEVjZjMbKBum4ZJQH9W5UoPNjz6+mfAlbqyVd01YwWQ1xQ7LwUQk9A==
X-Received: by 2002:a05:651c:337:b0:2d0:494b:3d69 with SMTP id b23-20020a05651c033700b002d0494b3d69mr911092ljp.18.1706698334240;
        Wed, 31 Jan 2024 02:52:14 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWbtEMZ0Kaw3rssPQ76pyM3vdQ2KAH+Lhwv2++7PCLxHhR0q/ky3D5kpa/aMGzRZJb3LCPg6jbfShJSkfZSroDJePz5Hhzk14gp8Z+ZbDFVQWxh2854+57cJ8JFZiIqwohw8taVW/Hrah+VlaGaqu+nOq/m0QoiT5I6kyHQ6bWK1Uhq5cMArEN5ceq57QaAuRKi/H5/FAFwYpGMv1KjoirXLCk70JIw1r8ufUp9etTR+DR1zHQm72m3vNYZoNgLv9SN9EF1upTkdm0yvT1WJdb/xmv/5taOda1ZnUPUn4mrl0/97giuiw45Jg2GyzwStrtSSYzUCPgStgrODT0IQJnz7HD8Wku8uMZkseiz9ZO+h0zLRl9bGKwFdXKv+6B8jRFi9w==
Received: from xeon.. ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id f19-20020a056402195300b0055e96290001sm4753966edz.27.2024.01.31.02.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 02:52:14 -0800 (PST)
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
Subject: [PATCH v1 4/4] ARM: tegra: Add device-tree for LG Optimus 4X HD (P880)
Date: Wed, 31 Jan 2024 12:51:53 +0200
Message-Id: <20240131105153.8070-5-clamor95@gmail.com>
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

Add device-tree for LG Optimus 4X HD P880, which is a NVIDIA
Tegra30-based smartphone, orignally running Android.

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
index 000000000000..9d8eeab79cdc
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
+	compatible = "lge,p880", "nvidia,tegra30";
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
+			host_wlan_wake {
+				nvidia,pins = "pu4";
+				nvidia,function = "pwm1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* GNSS UART-B pinmux */
+			uartb_rxd {
+				nvidia,pins = "uart2_rxd_pc3";
+				nvidia,function = "uartb";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			uartb_txd {
+				nvidia,pins = "uart2_txd_pc2";
+				nvidia,function = "uartb";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gps_reset {
+				nvidia,pins = "kb_row7_pr7";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* MicroSD pinmux */
+			sdmmc3_clk {
+				nvidia,pins = "sdmmc3_clk_pa6";
+				nvidia,function = "sdmmc3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			sdmmc3_data {
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
+			microsd_detect {
+				nvidia,pins = "clk2_out_pw5";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* GPIO keys pinmux */
+			volume_up {
+				nvidia,pins = "ulpi_data6_po7";
+				nvidia,function = "spi2";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Sensors pinmux */
+			current_alert_irq {
+				nvidia,pins = "uart2_rts_n_pj6";
+				nvidia,function = "uartb";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* AUDIO pinmux */
+			sub_mic_ldo {
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
+		compatible = "lge,tegra-audio-max98089-p880",
+			     "nvidia,tegra-audio-max98089";
+		nvidia,model = "LG Optimus 4X HD MAX98089";
+
+		nvidia,int-mic-en-gpios = <&gpio TEGRA_GPIO(I, 6) GPIO_ACTIVE_HIGH>;
+	};
+};
-- 
2.40.1


