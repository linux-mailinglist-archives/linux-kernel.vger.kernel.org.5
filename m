Return-Path: <linux-kernel+bounces-7418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEE981A7B3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 21:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8BE428666F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 20:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101624A9A8;
	Wed, 20 Dec 2023 20:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgjBIk3E"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B6548CF4;
	Wed, 20 Dec 2023 20:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40c48d7a7a7so698505e9.3;
        Wed, 20 Dec 2023 12:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703104574; x=1703709374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yT4onLSCJnRO5OsDAsoEnYosn/gTLA+uZJCYGELgzHg=;
        b=EgjBIk3EGX1vIK//UQixsKSQqlfL9c8wTIc07xiTB0xgbiAnI83CDBl4rrdQbOL70W
         AwkhexIUP/i5nZOOqtPO2tCYjZMbGTcV1E0rhCWNBkLFe6wc8jhAfdMjz57idBHY60oo
         b4Nr8DBq9fMT4cH8ILd+cWuCt4nZnKYzmGopy02l9UsZpz9Y79IuCvbUaKgCtKJa2VYl
         ZyOHh3vdnMqP6lsYDJx1e0tX7IxyEuzxuJTxRy4rChdEUJD7zLl6UfXUSN2++poH1L2L
         go20SpDqZBRVYAODSMCW/bWClEWmHCc+p23Q1M/whjbwk8EBDXca+j8FuuJeHRJU5zXk
         rlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703104574; x=1703709374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yT4onLSCJnRO5OsDAsoEnYosn/gTLA+uZJCYGELgzHg=;
        b=jbw7Da6jf310kEtoD7OWQ3dVyn/FOqrh2dP4lFrs4+EQ8KHOadAKo/ZFqqTCcfEJej
         8tbMR58E/4N+3xdY41saq5btmr3lQvyEir5vPUUwtqOaSt1XwBM9rV//5oC2y4BWEd0Y
         4vSI/p7UoOya+gNdJzObDdOoJYrTrjdnnJm78mlAIrbjpVuB17DrLNZ0l2vzkgDwgHlu
         yZ2zkcRy97DD/Stm8dRy8rXqqnUpWIsILfOIOVNWpuPAoJPKGFIyHlPe+lZuUA8NnLUD
         PSPK6KsPjTK4edozPaIgJ6ANETzpFAg4vWjhwr4H6pzryJj8Z/VMCZLJLWLjiyDRzOPG
         ZkeA==
X-Gm-Message-State: AOJu0YxAkiTnt0tdxdTj8R3NFn+r61C8EhxKE0RUhaouhTntQpEW0ziZ
	4O9kgObUGlSwvPYSKBt4Zto=
X-Google-Smtp-Source: AGHT+IEtwDmn2IbaAJwe9giXx+3hvOdMNOXDyWm03ZJR089ngNLl2e5wGYDa27uVUhlHEo6c4G1Paw==
X-Received: by 2002:a05:600c:524f:b0:40c:2822:958f with SMTP id fc15-20020a05600c524f00b0040c2822958fmr127184wmb.73.1703104574143;
        Wed, 20 Dec 2023 12:36:14 -0800 (PST)
Received: from localhost.localdomain (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id v14-20020a05600c444e00b0040c58e410a3sm8703224wmn.14.2023.12.20.12.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 12:36:13 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	wens@csie.org,
	samuel@sholland.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v5 3/3] arm64: dts: allwinner: orange-pi-one-plus: Fix ethernet
Date: Wed, 20 Dec 2023 21:35:37 +0100
Message-ID: <20231220203537.83479-4-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220203537.83479-1-jernej.skrabec@gmail.com>
References: <20231220203537.83479-1-jernej.skrabec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Orange Pi One Plus has two regulators that power the Realtek RTL8211E
PHY. According to the datasheet, both regulators need to be enabled
at the same time, or that "phy-io" should be enabled slightly earlier
than "ephy" regulator.

RTL8211E/RTL8211EG datasheet says:

  Note 4: 2.5V (or 1.8/1.5V) RGMII power should be risen simultaneously
  or slightly earlier than 3.3V power. Rising 2.5V (or 1.8/1.5V) power
  later than 3.3V power may lead to errors.

Original submission ignored these rules, so it works in some cases but
not all. On top of that, regulator voltages don't reflect actual ones
in hardware. Rework ethernet and PHY nodes to properly reflect HW.

Fixes: 7ee32a17e0d6 ("arm64: dts: allwinner: h6: orangepi-one-plus: Enable ethernet")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../allwinner/sun50i-h6-orangepi-one-plus.dts | 29 ++++++++++++++-----
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
index 29a081e72a9b..9c76eecaacce 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
@@ -12,15 +12,15 @@ aliases {
 		ethernet0 = &emac;
 	};
 
-	reg_gmac_3v3: gmac-3v3 {
+	reg_gmac_2v5: gmac-2v5 {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc-gmac-3v3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		startup-delay-us = <100000>;
+		regulator-name = "gmac-2v5";
+		regulator-min-microvolt = <2500000>;
+		regulator-max-microvolt = <2500000>;
 		enable-active-high;
 		gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>; /* PD6 */
-		vin-supply = <&reg_aldo2>;
+		off-on-delay-us = <100000>;
+		vin-supply = <&reg_vcc5v>;
 	};
 };
 
@@ -29,7 +29,6 @@ &emac {
 	pinctrl-0 = <&ext_rgmii_pins>;
 	phy-mode = "rgmii-id";
 	phy-handle = <&ext_rgmii_phy>;
-	phy-supply = <&reg_gmac_3v3>;
 	allwinner,rx-delay-ps = <200>;
 	allwinner,tx-delay-ps = <200>;
 	status = "okay";
@@ -39,5 +38,21 @@ &mdio {
 	ext_rgmii_phy: ethernet-phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
 		reg = <1>;
+		/*
+		 * The board uses 2.5V RGMII signalling. Power sequence to enable
+		 * the phy is to enable GMAC-2V5 and GMAC-3V (aldo2) power rails
+		 * at the same time and to wait 100ms. The driver enables phy-io
+		 * first. Delay is achieved with enable-ramp-delay on reg_aldo2.
+		 */
+		phy-io-supply = <&reg_gmac_2v5>;
+		ephy-supply = <&reg_aldo2>;
+
+		reset-gpios = <&pio 3 14 GPIO_ACTIVE_LOW>; /* PD14 */
+		reset-assert-us = <15000>;
+		reset-deassert-us = <40000>;
 	};
 };
+
+&reg_aldo2 {
+	regulator-enable-ramp-delay = <100000>;
+};
-- 
2.43.0


