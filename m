Return-Path: <linux-kernel+bounces-2817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 509CB816258
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 22:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B600D1C2211C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 21:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E93149F95;
	Sun, 17 Dec 2023 21:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iryjYSYb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA23E49F77;
	Sun, 17 Dec 2023 21:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50e270639d9so1550155e87.3;
        Sun, 17 Dec 2023 13:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702847368; x=1703452168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEmC8yzpg0VqIzMb5nxgOtA5V+BfOBifdcCXQ6xHVfo=;
        b=iryjYSYbYP0DX/DmxzCa3kCTEutqt0G46cq6jTWg7Xyyu+jDhL8ie0RS+LBfbd5x1T
         xawtKL6XuNUU+sMSu+w+4Dr2BasvRvyhM9LSKlO7eLKYi2p8kg53jE4H1qOCcPNjWyA6
         rUzqklvajrJzGa3vLNciYpJPs3UCA2YA7BzWkXcBGqJgZLwAozmvZEFc5HtrYIYfzL+5
         0B215HNmdkrp5BauVHLVFkqT0AU3ko2jBY8USoyrLELeakJTQ4fTwuWCTyn7sWvAaTsK
         wpSM2scGyPu6seP11K2zxZHOvFvXv7GMbu5u40b7Ba3nNXLt1llVZWAvWIyMKHk90xcQ
         KrWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702847368; x=1703452168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VEmC8yzpg0VqIzMb5nxgOtA5V+BfOBifdcCXQ6xHVfo=;
        b=cFnpmFueIzJZjhFdSmHvYt/EJCxNJtE3Sq92RJ/fa5HkV5qm/ccZbUONocdIcSoxGC
         gfpmm4o2LscIhKherJiFaVyksMbziWM8o1E0jqTbTTCmSQEoQ+qDQURqfhL5c7nNZqEj
         GGcsbqx6h6HOt+zJ5aQoKfPfVbz5n/sHnobK5MwMg8kPfneGeEvC77DRQpk9fUiR2VDH
         f+SSx597URAE/k4r4ELc8iPeXBIkZOZkmZgwx4MZJlbDCkyZQRYCEGRbcJgv62hidocu
         RTi4KLGr1tt7CWONJsFcpErkrXFVNsuvZGPmqAXbFDmj4FeORS4Awo3A6+Z2eyWwBKfN
         7C5w==
X-Gm-Message-State: AOJu0YzQpaCpRp7s9XMkQpb9ckBHnHn6mfhbR5MokbCM/7A7/Dob5gQJ
	ab1z2cQTMFuFOQ83nTyXDaI=
X-Google-Smtp-Source: AGHT+IEmHz+jRu9UqOYO0LhhslWbwSbg09nII/aLGLXumsvPqPzNtDYWNyrCPwroyrvzHYdz6tqJSQ==
X-Received: by 2002:ac2:4c15:0:b0:50e:3b2a:a7ed with SMTP id t21-20020ac24c15000000b0050e3b2aa7edmr29915lfq.16.1702847367506;
        Sun, 17 Dec 2023 13:09:27 -0800 (PST)
Received: from wpc.yadro.com (188-169-139-214.dsl.utg.ge. [188.169.139.214])
        by smtp.gmail.com with ESMTPSA id vc11-20020a170907d08b00b00a1ce58e9fc7sm13316096ejc.64.2023.12.17.13.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 13:09:27 -0800 (PST)
From: Maksim Kiselev <bigunclemax@gmail.com>
To: 
Cc: Andre Przywara <andre.przywara@arm.com>,
	Maxim Kiselev <bigunclemax@gmail.com>,
	Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	John Watts <contact@jookia.org>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v6 3/3] riscv: dts: allwinner: d1: Add thermal sensor
Date: Mon, 18 Dec 2023 00:06:24 +0300
Message-Id: <20231217210629.131486-4-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231217210629.131486-1-bigunclemax@gmail.com>
References: <20231217210629.131486-1-bigunclemax@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Kiselev <bigunclemax@gmail.com>

This patch adds a thermal sensor controller node for the D1/T113s.
Also it adds a THS calibration data cell to efuse node.

Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>
---
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi      | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
index 5a9d7f5a75b4..6f5427d9cfbf 100644
--- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
@@ -166,6 +166,19 @@ gpadc: adc@2009000 {
 			#io-channel-cells = <1>;
 		};
 
+		ths: thermal-sensor@2009400 {
+			compatible = "allwinner,sun20i-d1-ths";
+			reg = <0x02009400 0x400>;
+			interrupts = <SOC_PERIPHERAL_IRQ(58) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_THS>;
+			clock-names = "bus";
+			resets = <&ccu RST_BUS_THS>;
+			nvmem-cells = <&ths_calibration>;
+			nvmem-cell-names = "calibration";
+			status = "disabled";
+			#thermal-sensor-cells = <0>;
+		};
+
 		dmic: dmic@2031000 {
 			compatible = "allwinner,sun20i-d1-dmic",
 				     "allwinner,sun50i-h6-dmic";
@@ -415,6 +428,10 @@ sid: efuse@3006000 {
 			reg = <0x3006000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+
+			ths_calibration: thermal-sensor-calibration@14 {
+				reg = <0x14 0x4>;
+			};
 		};
 
 		crypto: crypto@3040000 {
-- 
2.40.1


