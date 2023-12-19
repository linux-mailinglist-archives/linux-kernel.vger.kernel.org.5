Return-Path: <linux-kernel+bounces-5648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8027818D94
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E12B1F2522F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A92545949;
	Tue, 19 Dec 2023 17:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8lZdZ0d"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF7A3D0CD;
	Tue, 19 Dec 2023 17:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40c580ba223so60191405e9.3;
        Tue, 19 Dec 2023 09:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703005294; x=1703610094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DcvRB7T9fUAwMybq5GgUQQU8bu+Y05ebI2TjIjKog/c=;
        b=j8lZdZ0dWNbkJjNjWdpoR7Sq5N2+WsPqhjfDPTYNw0/osbeikjFrURkBs3T375koqJ
         tL2vMmY3Io5SVPXnPvsZUkkDNjYSdp8OiQXOv0SOs02pEKhj9MWwvqRNz+PVfYnWsx1y
         9a3qEcgQCr9vtcbZ30ubodk33XElhLxldhwOXSPb6uXfnQCR+61YbMerK+tN4TD+3Zok
         Et+z9dplwGUy/WxbB+lDK+wiMnC1qhUlvDR5EliQbBhomWUbD90KevryJGKSXvb5HORW
         Iiierd/i5ks57dO7Ng3LDebTD/fZYA0fsjPDMZmszgPnVkgMA0SMAl3HgLdE5j0LWGfl
         nx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703005294; x=1703610094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DcvRB7T9fUAwMybq5GgUQQU8bu+Y05ebI2TjIjKog/c=;
        b=vcR4IkPAADdwteu98XyiYq6w6p+fMTaXgklt2ZI/ZVWP/2I8wAAbpNg+TtLIVrLoRV
         oeSY6ej2j9zFVuuyeY3cDnzlR+7W66MUkLK2jSqw4SQovMk012E+d4XdyDTzT5XkRhJa
         syYeznYxsf+6akAW/asDqkIsQ2Nkp+eCK1EmewS0TPOmc4ELmBfMO4EUAw/+hgiBvHEv
         1aYViLGO+fHe6X2hSX6UkeI/6oiFAaBQ5uldo+jpfp/hUyKxdojU1qKemYg6Tmw8H0wt
         QhYWARRTHn0fimx+ChpBTurV55wkjNDSqNZxwZDxppAu/g8mjs7lI0nI1ZvXUnzTJFHd
         zyNA==
X-Gm-Message-State: AOJu0YxT059MkROAJt7v3pdPkIaMkk4Lja1yHipgbebkp1bEZqf81G3C
	u8QMsSNI6M8/DVRFhxXFdw==
X-Google-Smtp-Source: AGHT+IGrAcc7/m62H6UhRJS1mgnAg6bEsa9UDyoPGrhboqs/G4K/oMz4JwX4/2A9/ksnAk+nV2p4PQ==
X-Received: by 2002:a05:600c:354e:b0:40b:5e21:dd49 with SMTP id i14-20020a05600c354e00b0040b5e21dd49mr10028636wmq.119.1703005293973;
        Tue, 19 Dec 2023 09:01:33 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:7ae5:3e:d1c6:a138])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c354700b0040d2805d158sm3225878wmq.48.2023.12.19.09.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:01:33 -0800 (PST)
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
Subject: [PATCH v3 29/29] ARM: dts: rockchip: Enable HDMI output for XPI-3128
Date: Tue, 19 Dec 2023 18:00:59 +0100
Message-ID: <20231219170100.188800-30-knaerzche@gmail.com>
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

Add an hdmi-connector node and enable the hdmi, display-subsystem and vop
nodes.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes in v2:
 - no changes

changes in v3:
 - no changes

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


