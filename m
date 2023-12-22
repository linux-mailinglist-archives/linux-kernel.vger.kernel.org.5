Return-Path: <linux-kernel+bounces-9977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 151D681CE0E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46A561C2268A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256D34CDEA;
	Fri, 22 Dec 2023 17:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQvqrBuX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AA64C3BD;
	Fri, 22 Dec 2023 17:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40d3c4bfe45so20995465e9.1;
        Fri, 22 Dec 2023 09:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703266962; x=1703871762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRLz1zrBuFNm0Af22mx0D2/7q2j0Q/CWyrbrvtrtVPY=;
        b=IQvqrBuX1Gbwts2bdRJiK0/oYpTqptzaZVw6pLSntKSCfAApvbpPz2j/nqWv9CULkg
         64u/P5KicooPaSKAgtxLJRitGT5tw1KuwVqrRq8UELJveJrMfR9jOHMGYtKBnv+nJ9Ms
         C96oInaa/4krNSR4XsKtWArJv4Bd5Z55Tt8g3G4YGClTBp214c6D3K0RD17O611M81i+
         NVKIajVhXrlE6IjM/hE2t8q9KJ5rN1G+ivn+bx7rDzSylncJ6zVqcSvXLr/RPk3Jc9jH
         pPdla6gJNf/5QQ5cTKgGxc56C7g6hhTMgHaNZGM4/AK6U0JKwstqdi/6s012AE1r/lmb
         RNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703266962; x=1703871762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gRLz1zrBuFNm0Af22mx0D2/7q2j0Q/CWyrbrvtrtVPY=;
        b=oRuMKD+5YyOuWZebNJSoOWd8hFzi0vx5j1Byg3A7mfQGkR8h+D+/R18TkQPvwG6E+k
         dtGxHdrek3ftefReU9fGVPFWXWAUHLRNtMfu7YzIX3PdePzpfW8juBUnWzT+q1380lVI
         G+0Pj7neL5kRzw9krNXFV4usxwYEkvGRVpBZ/OYcIFgp5Kap9lt0ZtI/D9RhQpTEc/rI
         HuDAqUE67v1eskWywtJNMz02QsFHEz6zq2gjbw7X000EH9/OwtMfWqn+co2srC+w5V5l
         e9uJPeqJ7pC16k3dbz7amaWTsSaYHpBvk+Ljz+t5O81Iysl96rUq97rOd87j9impjsBy
         ZOLg==
X-Gm-Message-State: AOJu0Ywz8R+2ga8tMCrZB6V6EIcuyo9cfWFfDDSLbkx+JtBOcozE3a8B
	fysssyxQwduenP98K9X2fg==
X-Google-Smtp-Source: AGHT+IEHpUVIRCbHP3AshFALoArBl6E2zYs7rd6xJQGGfnJ//3nhB9bjJ/XDbpPL3zjGmIJ8dwji1w==
X-Received: by 2002:a05:600c:a02:b0:40d:3868:6b85 with SMTP id z2-20020a05600c0a0200b0040d38686b85mr544367wmp.198.1703266962256;
        Fri, 22 Dec 2023 09:42:42 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:f3ae:2788:7e03:f44])
        by smtp.gmail.com with ESMTPSA id w10-20020adfec4a000000b00336670abdcasm4777116wrn.40.2023.12.22.09.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 09:42:41 -0800 (PST)
From: Alex Bee <knaerzche@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v4 28/29] ARM: dts: rockchip: Add HDMI node for RK3128
Date: Fri, 22 Dec 2023 18:42:19 +0100
Message-ID: <20231222174220.55249-29-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222174220.55249-1-knaerzche@gmail.com>
References: <20231222174220.55249-1-knaerzche@gmail.com>
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

changes in v3:
 - no changes

changes in v4:
 - none

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


