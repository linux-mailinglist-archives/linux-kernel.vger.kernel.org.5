Return-Path: <linux-kernel+bounces-2275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FE8815A69
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD8C71F23DB5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E097042A91;
	Sat, 16 Dec 2023 16:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ob16htJb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84C539ADF;
	Sat, 16 Dec 2023 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40c824b199fso5376535e9.1;
        Sat, 16 Dec 2023 08:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702744045; x=1703348845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3iOjCbwZExjH9kB2lsGfCX5u0yghPXFIA3BH7zrUI8=;
        b=Ob16htJbCr6zZfzQ0CQbBguVoUb6B6dcKsLpJGMRIg647BLuWhFzv11zII2A7aqgJ3
         NJz3aJzyCI1ayN8+zzl1QzxoJI3LxNpVeCiYUmaV2EltIaEZ9yjdU3K5h48rf+mQ34+Y
         OboqVgo5q05DIOSCaR0VT6JSQnM7eFRpW8SZFpQCe8IOXPIpJJKiRu2Lnu3sLTsqkvry
         +bgbhHBT4gMS9vW0bt/9B/6QBXrE4TIkSXCdCPJpzoI3V2neoz+q3/Y5IBkB8JCGQQRq
         WP9iLyjo1o/p7wD8SfNE5itA1gxeXuE8keao8fNMu79Ttm3UPO4PkgBh6QD+c9Sv8kEP
         emLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702744045; x=1703348845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3iOjCbwZExjH9kB2lsGfCX5u0yghPXFIA3BH7zrUI8=;
        b=LYiOCEW8Ja20X0jTBv9Z7AgIyzAbPlMkw17CFwVYer7ZvbDD7EH/XN07ybqx0bNWjj
         3XpJiifUlasPslD/gz2F2LDqyPvdOcml2YlxVUb3KpTqNRxzXq9sZb2zSZJgX5AVJTDQ
         6G5EFCbS4QBPDWjgUScpyBxFQqv0oSp1FU+adYr/qXvOF+c9EdzySkAufzEcc+FBegt9
         P1Nf622/uoMCQiUBU+bSO2bw4Ow5nknJpc8MfLJfq+JBztdmdUOwB6yyGxwWR7Ald2rc
         mx4fLDg7KcvMonxTR3b7nUbiKnxt2zb8C7yG0Ku6rvIPaoda6101jb3MmZhBGFtYnqzi
         LIzQ==
X-Gm-Message-State: AOJu0Yx4ZOkqUyCriTQXEyZrmKz5ERiJ9CLjV/2wk/v9SVozncUpScdm
	r8HuVwXRBzHm+eIjfi2bGw==
X-Google-Smtp-Source: AGHT+IEiefvMCshqhAareV6PB6nvkF+yNy6rY3P4T12kiqX015mu1E2d8HLFar6wnBfSX8rNq1mToA==
X-Received: by 2002:a05:600c:4ca7:b0:40c:2871:9729 with SMTP id g39-20020a05600c4ca700b0040c28719729mr7088382wmp.188.1702744045068;
        Sat, 16 Dec 2023 08:27:25 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:e807:d345:6f47:1db9])
        by smtp.gmail.com with ESMTPSA id st10-20020a170907c08a00b00a1cd0794696sm11990362ejc.53.2023.12.16.08.27.24
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
Subject: [PATCH v2 27/27] ARM: dts: rockchip: Enable HDMI output for XPI-3128
Date: Sat, 16 Dec 2023 17:26:38 +0100
Message-ID: <20231216162639.125215-28-knaerzche@gmail.com>
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

Add an hdmi-connector node and enable the hdmi, display-subsystem and vop
nodes.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes in v2:
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


