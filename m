Return-Path: <linux-kernel+bounces-5646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE392818D8D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F33301C24D45
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7661E41C95;
	Tue, 19 Dec 2023 17:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWVyosnY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3428A4122C;
	Tue, 19 Dec 2023 17:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40c236624edso52675025e9.1;
        Tue, 19 Dec 2023 09:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703005292; x=1703610092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fkhg2+aCs7jdMgzfxvYxQH9D4wpiG0MxQ7esIiT4Fss=;
        b=HWVyosnYBT9qd7Siw2XO6SRefXBcxmMm0GWL7vf5MNPyjxV00ZX5NY3rH0uB4jMCF3
         Et98m9PSx+GQKKcUSHfGMRX6MYd7N+jvxhOzkw4XfVuxaOgb395C9dY9/aB33JBuUU7O
         W6k6fxCthPO+Kw50jBTgvvdBq+O5KyEeGtlhSmNajr7IMl81Q7EZnlJk4CWlmLTlqOIE
         MQV3v4iXZXiu+wPy2VAF0DIiAhlPvmf7OWvsylptxNP+3PXWLx2XDUMF5Kg5EznsCgkz
         /c36loJP9sDltJTCOXrYBVfycDeKjgMwL5iWb/oZXZ6UMWKTTYNE+kchNOEFkXNSAfZJ
         NJhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703005292; x=1703610092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fkhg2+aCs7jdMgzfxvYxQH9D4wpiG0MxQ7esIiT4Fss=;
        b=tEnNId9PMN/86vefeb2LtYPl/3GRM3Vv+5oVomifr6hBORSItTPWX/wtPsLRKLZJT8
         oJdeya+WFl8bjK/WK5nPG4q0WcUyr0JzxZ+MypW3I3bmmUUey/fVjVKpfdr098uYdmPn
         snlmh8EEbgNS89hTmmwlCJqXC5JFFf5VL6YFxHso3Mo32f/uozTIcenmDLYCx98qNWBr
         tKkn0DQk/sIsPgihWJyPgXEVcyikF7PwOMcLvfh8EP47IZ4/zQoOEeybLK1e2FMfmD0a
         7NuYSabjDEmcB/lv0LAjmH4l6VVqR2q10xX4WCzwtH9kgI74dyD2rmdZPHZEzSuNdAWv
         E32Q==
X-Gm-Message-State: AOJu0YxvNtm4WfVC6u1IQISBl3CYRGKgCgNZvLWOd64vI58jUzGJz12s
	aYHK4vD/K2G1IRgO3vgEGw==
X-Google-Smtp-Source: AGHT+IGcO6yQrlw/IQJbarilDOyEAsYRP2fJCi+GiVdt/rewnkpVpso4E0zT/HF1QyL68nY60lqA1A==
X-Received: by 2002:a05:600c:4710:b0:40c:6b6c:6867 with SMTP id v16-20020a05600c471000b0040c6b6c6867mr3950390wmo.178.1703005292435;
        Tue, 19 Dec 2023 09:01:32 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:7ae5:3e:d1c6:a138])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c354700b0040d2805d158sm3225878wmq.48.2023.12.19.09.01.31
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
Subject: [PATCH v3 27/29] ARM: dts: rockchip: Add display subsystem for RK3128
Date: Tue, 19 Dec 2023 18:00:57 +0100
Message-ID: <20231219170100.188800-28-knaerzche@gmail.com>
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

Add vop and display-subsystem nodes to RK3128's device tree.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes in v2:
 - no changes

changes in v3:
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


