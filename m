Return-Path: <linux-kernel+bounces-2273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28471815A66
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3DCB1F23DAE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECC240C1F;
	Sat, 16 Dec 2023 16:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmHbQRHi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D493FB28;
	Sat, 16 Dec 2023 16:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50dfac6c0beso2049402e87.2;
        Sat, 16 Dec 2023 08:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702744044; x=1703348844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hsk09sD/JLCR2XzE8w6SDzRrfieu6a8GLQCzTQyHXNU=;
        b=UmHbQRHiBqsmz6rv68has3iNL+fLsZ9Dg2eq3izLeazy7g86CbGog6ROe4hYN/RJXE
         9XIeSQznefCbjJ4POnU2yGG/abb0oC469on+51pnuFfK9gYrjyRU5dj4WeVqat2GUsD8
         PrJcBaNAJlTtwUa/FIuFq/tja1FYrBQpctOWBzynnU/ezoVKUzDAgtS9efWs/BGvTSYQ
         8yzx7Xsxhc3bcF0sTNQk1desbZT0AwUI82E6zKHH5s/mgmfbOFOA1oqgr3dIRcKCjozc
         rdhqUpgM2Ja2/Z6bHJeIe+IGy6LmA6EiRPq4eL9yZtVPVSZh5QQWO7qyYTyKeRI89SXy
         eASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702744044; x=1703348844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hsk09sD/JLCR2XzE8w6SDzRrfieu6a8GLQCzTQyHXNU=;
        b=ND1xKsgCZNJxa6wH6SVqVJ6pKbQduDyJbHO1RscSHhR3t4WSgfjIijI+lrQokhfyfe
         O+V4+KcJWy1z7WwssLV7wnJnpkvoQ/ocTb6v8loJszsZ5NMJ+93J/CVu0dNbvBWlTlcu
         EUbDcgWCctorcIoVrsrMIAm6tYwZ7KYjbTQGloS/LpHgWt81K6m1KPexyi97DCgkmOWE
         jT+iVHO1/so5+ybWfaVWJ3zP42Es5Wmml0s6i0Pl/+b95qBaXu/3zHdQ9wyO+vHIJ7u6
         2yMAOxvCqdSB31+doqZVNuwMpczL+CTRN8D7FzAtxz86Rfug180RChcI02fdT3E5aDvR
         +DZw==
X-Gm-Message-State: AOJu0YzZybyaInWfRpaF6+KQIOBW33pdyU69v78uF97LygzOT/Ea24l6
	jji66KDW9Ckti1zOHUhSNg==
X-Google-Smtp-Source: AGHT+IFQnfl2cq6EqsmtxXsPX3+nF6bpvttzxEQVr2y36+9o0INXQQPP8fOuEmzzU29lPjunAhL3Kg==
X-Received: by 2002:a05:6512:3b0d:b0:50e:d07:597c with SMTP id f13-20020a0565123b0d00b0050e0d07597cmr5112150lfv.66.1702744043722;
        Sat, 16 Dec 2023 08:27:23 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:e807:d345:6f47:1db9])
        by smtp.gmail.com with ESMTPSA id st10-20020a170907c08a00b00a1cd0794696sm11990362ejc.53.2023.12.16.08.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 08:27:23 -0800 (PST)
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
Subject: [PATCH v2 25/27] ARM: dts: rockchip: Add display subsystem for RK3128
Date: Sat, 16 Dec 2023 17:26:36 +0100
Message-ID: <20231216162639.125215-26-knaerzche@gmail.com>
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

Add vop and display-subsystem nodes to RK3128's device tree.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes in v2:
 - no changes

 arch/arm/boot/dts/rockchip/rk3128.dtsi | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
index e2264c40b924..1a3bc8b2bc6e 100644
--- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
@@ -115,6 +115,12 @@ opp-1200000000 {
 		};
 	};
 
+	display_subsystem: display-subsystem {
+		compatible = "rockchip,display-subsystem";
+		ports = <&vop_out>;
+		status = "disabled";
+	};
+
 	gpu_opp_table: opp-table-1 {
 		compatible = "operating-points-v2";
 
@@ -246,6 +252,27 @@ power-domain@RK3128_PD_GPU {
 		};
 	};
 
+	vop: vop@1010e000 {
+		compatible = "rockchip,rk3126-vop";
+		reg = <0x1010e000 0x300>;
+		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru ACLK_LCDC0>, <&cru DCLK_VOP>,
+			 <&cru HCLK_LCDC0>;
+		clock-names = "aclk_vop", "dclk_vop",
+			      "hclk_vop";
+		resets = <&cru SRST_VOP_A>, <&cru SRST_VOP_H>,
+			 <&cru SRST_VOP_D>;
+		reset-names = "axi", "ahb",
+			      "dclk";
+		power-domains = <&power RK3128_PD_VIO>;
+		status = "disabled";
+
+		vop_out: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
 	qos_gpu: qos@1012d000 {
 		compatible = "rockchip,rk3128-qos", "syscon";
 		reg = <0x1012d000 0x20>;
-- 
2.43.0


