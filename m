Return-Path: <linux-kernel+bounces-18734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505D88261FD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 23:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1EB8282223
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 22:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E5A1097C;
	Sat,  6 Jan 2024 22:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxlhELK6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B044F107B4;
	Sat,  6 Jan 2024 22:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7bade847536so41218139f.0;
        Sat, 06 Jan 2024 14:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704580807; x=1705185607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TFJmQIFj0A0tInfs7hU9PMq1MKbXz8YKwehmuSMd3n8=;
        b=lxlhELK6jKh7qXZC1wNbRPWJW5Dp3EAxSjD9hmrGZBfsZR3cljN1kxR0rs6hygJ9cz
         qE5cI3TF5kk0Zib0uwUx/R4X0YYNidfEHZvkCgBFoJRtOsI9ezrlqTkmeWvsulgRS43M
         8jIeeTFUvXegbN8hzCeEqKvkQvxbvo4KkxhpLN74WeMRuU+GMqFoGnJ8Eyozmz0rRPp4
         7SX60BpvabW1lwRuXVSCmXT5ZBdVNWNrL5WNvEb7ArlHIOcc7bPdPIxVjiuamWOURwWM
         dPqNd8/52BRaVozE7ghycE7ZWtYdxAe5Hn/M6I0XlMBq/q9Lu9MC0xJlnZwPUQItOE4K
         TD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704580807; x=1705185607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TFJmQIFj0A0tInfs7hU9PMq1MKbXz8YKwehmuSMd3n8=;
        b=mh2ziD1TFjGLG64mCx2DBA95KGUd+ery0RijGpmWgb2eUlp8uXAgEdGBuQ4xCDH9jE
         EK3hi9NN6Jri9IoeYEv3GV+orjMNadowu0oSiLVSv0JA10wVWt0YjdGyGjs0U/toWBg7
         xzpi6GG4NyDDsolDXyprwlJRhcKxfRgfRDx1KF3t6jNdGnVf2/dgUOB+uDpPUPfYsU6z
         51SbY4o84WLELwotYbueK/9KZ3SLVtA64D+B8K4dI9EBy5HH1YTqfdvNx6YGmNujGL+r
         SKHlIGaCK0+7EK4GlWzO/x8BoUv0kjbT+PB1OD/fc2f8Vv0yiJanjNADAExtPtK627A/
         jWAg==
X-Gm-Message-State: AOJu0YzLeCvz4E6GK0xZZ3krL8gzz7//2s56xjjwJiP5qOXA5k+qh1Q4
	ppVI6Vo8wHmjIyN3n+aey4QU+iP/URSdtA==
X-Google-Smtp-Source: AGHT+IE69x8jS3gwN3hKFTtSb/EzuvmDnKpSai31R1x002W1zv0DPDc8yR+2xWlEmUylCYPANiIiNg==
X-Received: by 2002:a05:6e02:1787:b0:360:197:55d1 with SMTP id y7-20020a056e02178700b00360019755d1mr3326542ilu.23.1704580807209;
        Sat, 06 Jan 2024 14:40:07 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:af2f:17f0:33a3:d6fe])
        by smtp.gmail.com with ESMTPSA id l13-20020a056e021c0d00b0035ffe828182sm735346ilh.37.2024.01.06.14.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 14:40:06 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: linux-pm@vger.kernel.org
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Adam Ford <aford173@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: imx8mp: add HDMI power-domains
Date: Sat,  6 Jan 2024 16:39:50 -0600
Message-ID: <20240106223951.387067-3-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240106223951.387067-1-aford173@gmail.com>
References: <20240106223951.387067-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lucas Stach <l.stach@pengutronix.de>

This adds the PGC and HDMI blk-ctrl nodes providing power control for
HDMI subsystem peripherals.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  Added the fdcc to hdmi_blk_ctrl per NXP's downstream kernel guidance

     I (Adam) tried to help move this along, so I took Lucas' patch and
     attempted to apply fixes based on feedback.  I don't have
     all the history, so apologies for that.

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 76c73daf546b..d695c80e710c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -836,6 +836,23 @@ pgc_mediamix: power-domain@10 {
 							 <&clk IMX8MP_CLK_MEDIA_APB_ROOT>;
 					};
 
+					pgc_hdmimix: power-domains@14 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MP_POWER_DOMAIN_HDMIMIX>;
+						clocks = <&clk IMX8MP_CLK_HDMI_ROOT>,
+							 <&clk IMX8MP_CLK_HDMI_APB>;
+						assigned-clocks = <&clk IMX8MP_CLK_HDMI_AXI>,
+								  <&clk IMX8MP_CLK_HDMI_APB>;
+						assigned-clock-parents = <&clk IMX8MP_SYS_PLL2_500M>,
+									 <&clk IMX8MP_SYS_PLL1_133M>;
+						assigned-clock-rates = <500000000>, <133000000>;
+					};
+
+					pgc_hdmi_phy: power-domains@15 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MP_POWER_DOMAIN_HDMI_PHY>;
+					};
+
 					pgc_mipi_phy2: power-domain@16 {
 						#power-domain-cells = <0>;
 						reg = <IMX8MP_POWER_DOMAIN_MIPI_PHY2>;
@@ -1361,6 +1378,25 @@ eqos: ethernet@30bf0000 {
 				intf_mode = <&gpr 0x4>;
 				status = "disabled";
 			};
+
+			hdmi_blk_ctrl: blk-ctrl@32fc0000 {
+				compatible = "fsl,imx8mp-hdmi-blk-ctrl", "syscon";
+				reg = <0x32fc0000 0x23c>;
+				clocks = <&clk IMX8MP_CLK_HDMI_APB>,
+					 <&clk IMX8MP_CLK_HDMI_ROOT>,
+					 <&clk IMX8MP_CLK_HDMI_REF_266M>,
+					 <&clk IMX8MP_CLK_HDMI_24M>,
+					 <&clk IMX8MP_CLK_HDMI_FDCC_TST>;
+				clock-names = "apb", "axi", "ref_266m", "ref_24m", "fdcc";
+				power-domains = <&pgc_hdmimix>, <&pgc_hdmimix>,
+						<&pgc_hdmimix>, <&pgc_hdmimix>,
+						<&pgc_hdmimix>, <&pgc_hdmimix>,
+						<&pgc_hdmimix>, <&pgc_hdmi_phy>;
+				power-domain-names = "bus", "irqsteer", "lcdif",
+						     "pai", "pvi", "trng",
+						     "hdmi-tx", "hdmi-tx-phy";
+				#power-domain-cells = <1>;
+			};
 		};
 
 		aips5: bus@30c00000 {
-- 
2.43.0


