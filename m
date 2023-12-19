Return-Path: <linux-kernel+bounces-5647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD26818D8F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FACB1F25049
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1C54205F;
	Tue, 19 Dec 2023 17:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHKcMzD5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9D241765;
	Tue, 19 Dec 2023 17:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40c48d7a7a7so45246655e9.3;
        Tue, 19 Dec 2023 09:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703005293; x=1703610093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=824x2Bpa+BljPPIuTHpPefnYLDXHrvCUJjy6fbKwCl4=;
        b=NHKcMzD5kz4JJBN9t/AiBafNPcinA9wVedX1l7eCk+auyXL/DiXTmrrM+2xPJHkw+t
         U4i6fvrCUtxdsQhLISin4vKRe5B4DsQp2uYONVoJ4/HiPUPeB2gmQz/kP+AdDPNrgrX/
         I52o995huN3kO9yPQMobuBWNzPpP5tuQxEISgGojiWsTQDHN67jY2EbRS2if7gIq0VKw
         htL7z3QJqXUfwbzzba5NcQ3mzVr1+X/bnFQkC3HZv9ZgIqurf3s2Tcp0XD8tUZsSHzeV
         HoqFW00YnsQhsVZW9iDo1KRHvERrq8FgB1enyJS2Q4O6hdZo2AsKToa07pQEsXl+ITAY
         GEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703005293; x=1703610093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=824x2Bpa+BljPPIuTHpPefnYLDXHrvCUJjy6fbKwCl4=;
        b=XkujLbyTPpx+bZ9HhaDza6E9zChuMK1KDpZIB3makN3k4335HaDrh8Gfqa2K1LSW9d
         cwHYh1xY4S6syP875dc7DrOSUFdYgUmVTuRkomfUh67Xz5ES/wey77Jn5N9GczVh5s2Y
         MdPYxco7eEGgMFeYJWAYm+yUW6oASncKtcDGH086fC+mfcelgQLlyNeHMNKV4y4luomg
         JobP7GUXnGW6KdkDHli3ZI6yHp8cd/s5cN80tdivJLimCOMvFiGDy00BSdvFeEGl/BV2
         tOLaL+qqxu7cGNmWlzSieOq7KhWTFxjfjeRRjFwqSW7WTTRJeRwtvksMgEJhdn5WmaLH
         MbEg==
X-Gm-Message-State: AOJu0YxGydSoaKW7r7Y3uyqVS1PyvdLwJ+FiVp/qSG8vBI8bWbLza5FN
	bozSNdV2zPq2h34MmVcptg==
X-Google-Smtp-Source: AGHT+IHgcqfEoRYVHjhmsr69xyQlznMp/1EOCdyz0OLbPaZ9r38nDcrP4sBWbdQwF4XoayjoM4b1fw==
X-Received: by 2002:a05:600c:4c8a:b0:40c:d3a:2447 with SMTP id g10-20020a05600c4c8a00b0040c0d3a2447mr11436802wmp.87.1703005293173;
        Tue, 19 Dec 2023 09:01:33 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:7ae5:3e:d1c6:a138])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c354700b0040d2805d158sm3225878wmq.48.2023.12.19.09.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:01:32 -0800 (PST)
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
Subject: [PATCH v3 28/29] ARM: dts: rockchip: Add HDMI node for RK3128
Date: Tue, 19 Dec 2023 18:00:58 +0100
Message-ID: <20231219170100.188800-29-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219170100.188800-1-knaerzche@gmail.com>
References: <20231219170100.188800-1-knaerzche@gmail.com>
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


