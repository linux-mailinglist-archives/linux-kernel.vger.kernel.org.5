Return-Path: <linux-kernel+bounces-9978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D882D81CE0F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D88288196
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8C84CE18;
	Fri, 22 Dec 2023 17:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNrsA2GV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A615D4C618;
	Fri, 22 Dec 2023 17:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-336897b6bd6so1795736f8f.2;
        Fri, 22 Dec 2023 09:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703266963; x=1703871763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSehpxE7VFQUy0YWI/0+kwR1zv6c+kt9jZ6SUI8YNPA=;
        b=DNrsA2GV7j+BqN527P2MlgiifrPCHya3w1+jh2y07aAM/BmAX34bI4La17bjdnv3Ye
         uOy/4XTkjudE8DRnGqQavrNYuQHMqmWYuQ74WsKIWS6tSYTy18BLMZARmj78a84PvJpT
         H2eSMZjy6mPF4YVlpO5uEtWpwQcJiJFamrDDfGEH4yDW2sC6gQTzqIY9F2O2n8K9tiFa
         suHr0s8VyRWaX6W7KYUjl3v+VvtpYAE96O7mkPI0P176AXL5O7ZiBXh45XKb2X46cF/o
         mHjyvBdA+Qen16fNd2+/XHR4g2Tz78kQWpRK+I9sHzhoRftHyYc1/QeFCoNskKyPWKJi
         Xjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703266963; x=1703871763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSehpxE7VFQUy0YWI/0+kwR1zv6c+kt9jZ6SUI8YNPA=;
        b=LyYmfZvcx1P4htsmcZrbzM7x6EKXeR8vRSO5nJ8sW3FNPyLYHoy9BUC7fHIwFsddJ0
         i6v28pnWTFbkVCbViUONrVGfWneGILIemToFhFeeClWsLGQA7+XKRBIbAQArRNuW6gcf
         F7GvvQi2EZvNES3BvvrwofliLr0zFHp7AraCwVJ+sMgzE/FW9El+jeh8VASSUGrETrZO
         2RaQYqKDXN7NUsSlIpf7gNvvQThS5/jGglpaQ2mwUGgk8Wo7SjcXtPTBRP8i7PHn/yOh
         Q7HD99ANxcLIXaYx0RIbhwD127Oh2fxrrG/biSEsx6uRVIttfAGClSRKAEghQkjyI9EA
         vgJw==
X-Gm-Message-State: AOJu0Yz1/Oh++PjHnEotwmA51rDSVl3aT0F7eXajfCCGWavj8QKw0Aaj
	8R8ADgZxE3pe4v/f+MhqjA==
X-Google-Smtp-Source: AGHT+IGLyV7PwzD0uMRgFbjueBNdwVNWCv/14yX+9ci/Je+qQb52KMqiGZ6KKsCnxRVJYWwB1HUPrw==
X-Received: by 2002:adf:ed47:0:b0:332:e337:7c5f with SMTP id u7-20020adfed47000000b00332e3377c5fmr904774wro.61.1703266963000;
        Fri, 22 Dec 2023 09:42:43 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:f3ae:2788:7e03:f44])
        by smtp.gmail.com with ESMTPSA id w10-20020adfec4a000000b00336670abdcasm4777116wrn.40.2023.12.22.09.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 09:42:42 -0800 (PST)
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
Subject: [PATCH v4 29/29] ARM: dts: rockchip: Enable HDMI output for XPI-3128
Date: Fri, 22 Dec 2023 18:42:20 +0100
Message-ID: <20231222174220.55249-30-knaerzche@gmail.com>
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

Add an hdmi-connector node and enable the hdmi, display-subsystem and vop
nodes.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes in v2:
 - no changes

changes in v3:
 - no changes

changes in v4:
 - none

 .../arm/boot/dts/rockchip/rk3128-xpi-3128.dts | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3128-xpi-3128.dts b/arch/arm/boot/dts/rockchip/rk3128-xpi-3128.dts
index 03a97881519a..21c1678f4e91 100644
--- a/arch/arm/boot/dts/rockchip/rk3128-xpi-3128.dts
+++ b/arch/arm/boot/dts/rockchip/rk3128-xpi-3128.dts
@@ -47,6 +47,17 @@ dc_5v: dc-5v-regulator {
 		regulator-boot-on;
 	};
 
+	hdmi-connnector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_connector_out>;
+			};
+		};
+	};
+
 	/*
 	 * This is a vbus-supply, which also supplies the GL852G usb hub,
 	 * thus has to be always-on
@@ -239,6 +250,10 @@ &cpu0 {
 	cpu-supply = <&vdd_arm>;
 };
 
+&display_subsystem {
+	status = "okay";
+};
+
 &emmc {
 	bus-width = <8>;
 	vmmc-supply = <&vcc_io>;
@@ -328,6 +343,16 @@ &gpu {
 	status = "okay";
 };
 
+&hdmi {
+	status = "okay";
+};
+
+&hdmi_out {
+	hdmi_connector_out: endpoint {
+		remote-endpoint = <&hdmi_connector_in>;
+	};
+};
+
 &mdio {
 	phy0: ethernet-phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
@@ -423,3 +448,7 @@ &usb2phy_host {
 &usb2phy_otg {
 	status = "okay";
 };
+
+&vop {
+	status = "okay";
+};
-- 
2.43.0


