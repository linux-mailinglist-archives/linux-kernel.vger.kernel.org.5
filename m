Return-Path: <linux-kernel+bounces-14024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1698821701
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 05:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 041A81C210DC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 04:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298136ADB;
	Tue,  2 Jan 2024 04:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/CQ5Mxa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C91F46BC;
	Tue,  2 Jan 2024 04:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-28c0536806fso6607274a91.0;
        Mon, 01 Jan 2024 20:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704170785; x=1704775585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tfJIsodrpZIIAMpybgAC7qz4iEokdxJ5UnhS1fS4za0=;
        b=L/CQ5Mxa45NpAQKv6K2fJpcEZJFsC6dLhOgi++gLvj7gGlBVIXofwflELjsvdGO+ro
         kEuIvUNldCHAVrEDvzo77wVJ9nFM04AGywo24j2QEkvGJkJNETgrxGVY3GIi0S0ysomG
         +kiItPtIWUKVdv7h0KtHbCv02gmS+YSGlV+sm7XDDtbjvQdMFnopdhh/ITT2iSbBmbBA
         19/S6G7bHtRJKpjSpNGsQBU27qNhefh3+CcSNs8sZNTYcXYsbmOX68OV+5K2JZsDVtfR
         RXU0t3OxrBMIihXL1VJQvgN2uqBHToZy8xX27W4jU3hEBVggJkMdA2Gjp9MIEqT8F/h+
         6W5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704170785; x=1704775585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tfJIsodrpZIIAMpybgAC7qz4iEokdxJ5UnhS1fS4za0=;
        b=ehbsX+5um0GH6kmNzZirkiOB4OqeccZtV4xXQs/DTutiiRUu0bXSAV9YqDioLs7biC
         IlP/74assQbpcySG2G77IX2MQ3nZ49mmtt1JErYpOFH1jZkoOKLQK0DPJe+1pXbMCtxo
         aGhYL3ovoJeXwsfSI5UiMU3cbxyXFJ4FolhIbZZiqmc5NQcvceVhEttoxlEYY926qEXT
         pna6O7/xPnPhqbNA20wniw4BQbe2Inf1QpT3NHq1lUfV8ym1wwUKeylx0p0m0xh++IYR
         5tXBWH7yKucRTKKngkA93FQ5dJLr56t73GdUfwWrbo8bgWEgGquoLE+NPw8KQmvEJFhZ
         gxNg==
X-Gm-Message-State: AOJu0YzEaLZc8ndQQ1dTpY+GbYIOkk/CFfzxYDVPWdU7ylJF/KtbcDdG
	LEuIpLvIsQVHbfATSUE17yM=
X-Google-Smtp-Source: AGHT+IHqRXcCWjxv7N4EPqiNsAsagi/uGM9jN5nqeDXbh3ZChgvTzpXvqFuFgkHctP21eOphDhuWJQ==
X-Received: by 2002:a17:90b:1b41:b0:28c:2e37:bd97 with SMTP id nv1-20020a17090b1b4100b0028c2e37bd97mr7354431pjb.80.1704170784753;
        Mon, 01 Jan 2024 20:46:24 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id d21-20020a17090abf9500b0028c2b2b76c0sm17308392pjs.22.2024.01.01.20.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 20:46:24 -0800 (PST)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@aj.id.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/5] ARM: dts: aspeed: Harma: Add spi-gpio
Date: Tue,  2 Jan 2024 12:44:09 +0800
Message-Id: <20240102044409.3810873-6-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240102044409.3810873-1-peteryin.openbmc@gmail.com>
References: <20240102044409.3810873-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add spi-gpio for tpm device.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 36aad01dda20..25ae044cd176 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -28,6 +28,8 @@ aliases {
 		i2c29 = &imux29;
 		i2c30 = &imux30;
 		i2c31 = &imux31;
+
+		spi1 = &spi_gpio;
 	};
 
 	chosen {
@@ -67,6 +69,25 @@ led-2 {
 			gpios = <&gpio0 124 GPIO_ACTIVE_HIGH>;
 		};
 	};
+
+	spi_gpio: spi-gpio {
+		status = "okay";
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-sck = <&gpio0 ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
+		gpio-mosi = <&gpio0 ASPEED_GPIO(Z, 4) GPIO_ACTIVE_HIGH>;
+		gpio-miso = <&gpio0 ASPEED_GPIO(Z, 5) GPIO_ACTIVE_HIGH>;
+		num-chipselects = <1>;
+		cs-gpios = <&gpio0 ASPEED_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
+
+		tpmdev@0 {
+			compatible = "tcg,tpm_tis-spi";
+			spi-max-frequency = <33000000>;
+			reg = <0>;
+		};
+	};
 };
 
 // HOST BIOS Debug
-- 
2.25.1


