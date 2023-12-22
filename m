Return-Path: <linux-kernel+bounces-9976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A7C81CE0B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6719E2828DE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D704CB26;
	Fri, 22 Dec 2023 17:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJBJX406"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278814BA80;
	Fri, 22 Dec 2023 17:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33697caf9a6so423074f8f.1;
        Fri, 22 Dec 2023 09:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703266961; x=1703871761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLzYp4+k7Wco/dLyvbXtMOp2x7OPvW43+Ey3FkfhV04=;
        b=HJBJX4064ItY7m0sOVKX0/6ZuYm39OTR3kE/VOMLDktoXydxnt59RDOWeVbY+pC2yU
         +sL1u5C6qyOK85zsXLhjJDWJ2tu4Yv5VSxdTad0KXQmLrIdojGJjtHIaan5iw5DDjFTp
         0KEZXzc8zPfsDP9dWHblNRDtGujceOxS2ipDYTKCUgaGwAW6vM4fgiQVT2T3KKGy75PV
         HVomIKXlk5ghEMVQEV5nXAQpJhytmwaSOHeHfhiE9WjlzgRpIK7NecRjBxI6kz2X/cUn
         gsDfH3hXJvJ1J/i5161FkDrScTfuuT/bu6Kwp8q2Jwk6S7gdg5AdMTXSKBrYPDmtSvi6
         mbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703266961; x=1703871761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rLzYp4+k7Wco/dLyvbXtMOp2x7OPvW43+Ey3FkfhV04=;
        b=AdzPvKo8Dk1bOMzDbOq18WKMwkfrlMGMUzwksPB6imC5IiJqpphQVB4sNTctUErWvP
         xzVdAiGYBvTAUeSa0+4S6la6QrbzrTqmMEj/FuGVShu/5pZhI+SVmRGcnpBHc/rh7Nvg
         R63kTtfKckbHjxuO3cFb4yfekM6YnRdWB5YE+5s5DjgTlLjlrupjFy68ezAaJM9H5JzK
         g9zlwylgzBhb8OPxKnTKj25f61201ue/lvIhENfJ+cCIKR1onUwqVTDLXFnGbyI06NEp
         d6fYBxuDYzuVzaiiyqKytGmXfxT+HEK9Jn/5V0tSFwTww98qtbRA426AekvspdPSxYnb
         pimg==
X-Gm-Message-State: AOJu0YwWpTDnYVVG7hYh2e1CIyCJdqHEquhl0/D4+iAA7s09odR9UJzt
	Gs3HKS8RoRNsIujDpFhZ8w==
X-Google-Smtp-Source: AGHT+IGbd8E/7UYhaxEGvqWFhQLwqbcpgCocA70NL6yVomx8hW0OvFLh92M66p/2d8jdHube5d2uBA==
X-Received: by 2002:a5d:6046:0:b0:336:8d2e:77a1 with SMTP id j6-20020a5d6046000000b003368d2e77a1mr945167wrt.47.1703266961379;
        Fri, 22 Dec 2023 09:42:41 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:f3ae:2788:7e03:f44])
        by smtp.gmail.com with ESMTPSA id w10-20020adfec4a000000b00336670abdcasm4777116wrn.40.2023.12.22.09.42.40
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
Subject: [PATCH v4 27/29] ARM: dts: rockchip: Add display subsystem for RK3128
Date: Fri, 22 Dec 2023 18:42:18 +0100
Message-ID: <20231222174220.55249-28-knaerzche@gmail.com>
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

Add vop and display-subsystem nodes to RK3128's device tree.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes in v2:
 - no changes

changes in v3:
 - no changes

changes in v4:
 - none

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


