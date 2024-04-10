Return-Path: <linux-kernel+bounces-138003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 240FF89EAFD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483F01C20E2D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3A622085;
	Wed, 10 Apr 2024 06:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="d1oBC7pF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="uBLLOwZw"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E618249F7;
	Wed, 10 Apr 2024 06:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712731048; cv=none; b=HNIfphdVa136jJ1crgXHXVGsMxyTNr4hTFJ6AbNx73WXMyX/GKcxfpysJHa5WFXXICGWMaiOa/zmYdkxqltADMv9X+oMIoUvyFv7VPQKB8dCWWuUpJ2TntF0XNFsi0dmY80L44TNDaYd7xc1iwvVMjhXStNeFrOA9ge4gdcY3YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712731048; c=relaxed/simple;
	bh=HAYPiiAi4an1HSNVXQLFxn+aHj5YagTpUMtwKQLUG9k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qJcmF/5IaJ6A77308ZSramMRwxDuaBXOkTrGBhHfhsGBElKLRZTtwlxEjgfBRsXdurbyFNSBIvw9bMdJB1sgNmUejQuqi9v8wmKhk+Ysvga+n4RE/VdupmV7yqUrGHohugNTI7H2V75PBNzdv+j1L/+j0OFluKkBr6niZWt7c3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=d1oBC7pF; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=uBLLOwZw reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1712731045; x=1744267045;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LzaLHY+9fUJOo9N2tsj7/15WhP3w9UXkZ+rUZbt8k3c=;
  b=d1oBC7pFGaI50rmVWeVAXFD+bzKLqwgt7f7RRZRwmQxBtkRsfRO4pL/t
   IorbQIVMq97cIMfHnK1+aCK8nlDd9zjzw9OhXUg2hfap9hfXxpkju+d2G
   qQ+BYwSaxHWI56naDqj3LyvcjETRYGCkDjAJIQl/tCLOvv9HIEwTCAggK
   +u8z/crs8RzjOnMQC1Q6vCl3zrP5fFRNyIy9yOPrk6ASmklQN4n3av3Av
   Dfyjioqn1FmzP5WFrOWUyP0a/NVF+TMwI5cRIQNUSdh7hSPnH5gvq6dfM
   YJyV39cTZdWbD6DPWlvbsZs9EXD+r6m7lwD2G+MB67PyD0CiDEPtjXVAM
   Q==;
X-IronPort-AV: E=Sophos;i="6.07,190,1708383600"; 
   d="scan'208";a="36333793"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 10 Apr 2024 08:37:16 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B4D6B16142F;
	Wed, 10 Apr 2024 08:37:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1712731032; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=LzaLHY+9fUJOo9N2tsj7/15WhP3w9UXkZ+rUZbt8k3c=;
	b=uBLLOwZwQNqgjDuHA144zmu31c02mmGxLgWB1OcMWNxdBv5jDuKjMDKkiaxAOUWf15CrgP
	2LQIs8mNMeDZmI63o/h4e05U5SzDJ8LDh6eafdxG0ZYuSYqZR+QtKbutrDcB5hzX1V278N
	xoC0XOjgBoAsXAFu9JxAq09WSRgPHz84G7lH5V84uTOqlp0c3m05TZHyLbhw9V8uuV3Iov
	GSAFKrzQFcM7wbLbBJ/do2cW9cIIXJQKlE7qZBLzx57EHDQCsyQvtUv8LyPLmutotixNYD
	MJjsUsq6V4K0mS2QbQYu7hyAQsbR+jFwASr6SZihre4r0mXn1c/fM+mgecaBTA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] arm64: dts: imx8mp: Enable HDMI on TQMa8MPxL/MBa8MPxL
Date: Wed, 10 Apr 2024 08:37:05 +0200
Message-Id: <20240410063706.3813894-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Enable HDMI nodes and add the output connector.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 .../freescale/imx8mp-tqma8mpql-mba8mpxl.dts   | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts b/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts
index 86d3da36e4f3e..c51ed7d991d18 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts
@@ -135,6 +135,18 @@ led-2 {
 		};
 	};
 
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		label = "X44";
+		type = "a";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_tx_out>;
+			};
+		};
+	};
+
 	display: display {
 		/*
 		 * Display is not fixed, so compatible has to be added from
@@ -470,6 +482,28 @@ &gpio5 {
 			  "", "", "", "";
 };
 
+&hdmi_pvi {
+	status = "okay";
+};
+
+&hdmi_tx {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hdmi>;
+	status = "okay";
+
+	ports {
+		port@1 {
+			hdmi_tx_out: endpoint {
+				remote-endpoint = <&hdmi_connector_in>;
+			};
+		};
+	};
+};
+
+&hdmi_tx_phy {
+	status = "okay";
+};
+
 &i2c2 {
 	clock-frequency = <384000>;
 	pinctrl-names = "default", "gpio";
@@ -531,6 +565,10 @@ &i2c6 {
 	status = "okay";
 };
 
+&lcdif3 {
+	status = "okay";
+};
+
 &pcf85063 {
 	/* RTC_EVENT# is connected on MBa8MPxL */
 	pinctrl-names = "default";
-- 
2.34.1


