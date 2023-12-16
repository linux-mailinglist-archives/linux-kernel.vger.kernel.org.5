Return-Path: <linux-kernel+bounces-2274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F5B815A67
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 947401C21710
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D5641763;
	Sat, 16 Dec 2023 16:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4vwsXgm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287D3405C9;
	Sat, 16 Dec 2023 16:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-54f4f7e88feso2226137a12.3;
        Sat, 16 Dec 2023 08:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702744044; x=1703348844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBYs3PhPVI6eUxnSZWKmlMF4qjz6lpemR7OHeO6knFA=;
        b=X4vwsXgmJtdXN2FoJGkbpqnZwDCti0O6EOx0bwYTIR/bUATGMAXRdJvtmRSSquE8Cg
         PzjcQznfsaUL+OYvcAquvgd4wqAbvIxzAnsqttJxZhftXmBClB5jA4slHlC7qPeNLRGN
         8iJNu7oDS5yjyQ4xNMNjRrAOYmxgUhXFvwQ+SmVNesz+a9Sap3axX1E5O7ibtJeQFtiN
         XE5EkPX0ROGsI/QlTK7eXmLNZCY4oFSRUWUr0H+5SLaw16uMpbVmEgf+4aErHGvoM7yS
         XIsy6jSBT5V9XpEPaZoN7EF/8kgbNvP27/i2b0F0PgRWDIyUaOkZ3+RMdSRow6PeB1TB
         Drow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702744044; x=1703348844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBYs3PhPVI6eUxnSZWKmlMF4qjz6lpemR7OHeO6knFA=;
        b=Sq6g29FfBYJ2M/QmDSZoXCQGGmzklRkSqNf7iaF3GJeVrqUDEPo1AHncxFBZoXXmGW
         cktyNeqfHMQcemYMhk6YHmQDGtPhnXpSkEgTKgWbdwa4x96o3BT7DFzeslqHAXecDszK
         iPUdifIAJMU4hbxL6HP+WtY/ppnKQNJSFH5r9eaOt+Tpn0k1RWfg7asjsj/FgKWske7z
         pFH0wkgfQMFZwMyfDlYFVUQmjBZM20sXM7r40Tc7Xj64V6ua4zPNaZgYIKB59q5w1Cbq
         SS0ASBNLwjkAinGmS5wtwMEfV3TbguNFi9/YeYt2iiTkUilPwQ0WLu7kkBW8z3SqGzzD
         Hztw==
X-Gm-Message-State: AOJu0YxqZmKAevokw+mUo65tqe/ouvAnHxWIQhzJdO/rsnKtJn/66bYF
	S5KKK7M1WTV9O45NGbuYLw==
X-Google-Smtp-Source: AGHT+IFL//jIxTYByWAR+rnaaAeoTcePi2y7wDdwHT2lbXxpOe8v9YhxlqSjIVwsz6sRq5BVkqL4xw==
X-Received: by 2002:a17:906:3199:b0:a23:2e05:8465 with SMTP id 25-20020a170906319900b00a232e058465mr339276ejy.6.1702744044454;
        Sat, 16 Dec 2023 08:27:24 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:e807:d345:6f47:1db9])
        by smtp.gmail.com with ESMTPSA id st10-20020a170907c08a00b00a1cd0794696sm11990362ejc.53.2023.12.16.08.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 08:27:24 -0800 (PST)
From: Alex Bee <knaerzche@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andyshrk@163.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 26/27] ARM: dts: rockchip: Add HDMI node for RK3128
Date: Sat, 16 Dec 2023 17:26:37 +0100
Message-ID: <20231216162639.125215-27-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231216162639.125215-1-knaerzche@gmail.com>
References: <20231216162639.125215-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RK3128 has Innosilicon based HDMI TX controller similar to the one found in
RK3036.
Add it and the respective port nodes to the SoC device tree.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes in v2:
 - no changes

 arch/arm/boot/dts/rockchip/rk3128.dtsi | 33 ++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
index 1a3bc8b2bc6e..fb98873fd94e 100644
--- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
@@ -270,6 +270,11 @@ vop: vop@1010e000 {
 		vop_out: port {
 			#address-cells = <1>;
 			#size-cells = <0>;
+
+			vop_out_hdmi: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&hdmi_in_vop>;
+			};
 		};
 	};
 
@@ -463,6 +468,34 @@ usb2phy_otg: otg-port {
 		};
 	};
 
+	hdmi: hdmi@20034000 {
+		compatible = "rockchip,rk3128-inno-hdmi";
+		reg = <0x20034000 0x4000>;
+		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru PCLK_HDMI>, <&cru DCLK_VOP>;
+		clock-names = "pclk", "ref";
+		pinctrl-names = "default";
+		pinctrl-0 = <&hdmii2c_xfer &hdmi_hpd &hdmi_cec>;
+		power-domains = <&power RK3128_PD_VIO>;
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			hdmi_in: port@0 {
+				reg = <0>;
+				hdmi_in_vop: endpoint {
+					remote-endpoint = <&vop_out_hdmi>;
+				};
+			};
+
+			hdmi_out: port@1 {
+				reg = <1>;
+			};
+		};
+	};
+
 	timer0: timer@20044000 {
 		compatible = "rockchip,rk3128-timer", "rockchip,rk3288-timer";
 		reg = <0x20044000 0x20>;
-- 
2.43.0


