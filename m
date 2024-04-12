Return-Path: <linux-kernel+bounces-142717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A54AE8A2F45
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 460211F22FB0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFCF82497;
	Fri, 12 Apr 2024 13:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="iIH6QKxm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="CfYTisVx"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D10181AAA;
	Fri, 12 Apr 2024 13:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712928036; cv=none; b=DmxC9VLa8VuytEek/mCFYivAYcsDlADC694jInFgUNZGkEnWIlw7aHIRMlpYOtXZpso2PX088TMUt90mome6/DG/sXliFNX/k2N8jbwYLlhOc91RMNnkstAeiDmapqJKYuXzu9zGtshTpTfAQ3CCiDBwdhcU1ALhRBBQTp5+iHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712928036; c=relaxed/simple;
	bh=/txxqYlU4j9GLPahajtTq8tdmlrsxmJZHDfp0xOA2Kk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eW1njnCQ9MAlyGyxfaC7AV//l4c9GZWrTxb0IWHU8qIcdQDseYRJDChzoI0I66hQOGbG3tNDThp0nSb0T7EegVpT5ugcHhrDhUCw69uF6m8LAmII5CvnlMvBS4P7JWx+96Tq2+gsSMwkIBKo+R3de4kO7oklRhfrv1hx/7x0iR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=iIH6QKxm; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=CfYTisVx reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1712928033; x=1744464033;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aMvVxK4NUeO+EcAGmB+Dwa/0aVRFR5DKQOjKU0G2Dag=;
  b=iIH6QKxmBPGqgoYkKZA1TYNXlNzED4GOeztt8K3kJbJ1gcGOhxgiG/gD
   /orDqGbVcETIQzF61+VoPU5R4ui20oOVRmWQ/LB6g8mx9ATFranwMVS/Q
   /hKqUV0xXEV1bbhmhVxo0HFN1Wtlqfoeb8uHmR+tTAP44oWWc6SZ5m35z
   L/hmWtT6eyWiYmKlPTQTek6Kao9DnGhdggD+VhUm/0n/bctor89l93Mf5
   tC5hRfC8AKAtVqKUGTgMDkwWyjkT+yq7GPLc+OhivGv0OgHuV2CN/ka5P
   Ns8BfsUR2XgBwtfM6B2RddqMPUXsaj7C4+cK3qjPKRwGpuK+pPZyrpGSs
   g==;
X-IronPort-AV: E=Sophos;i="6.07,196,1708383600"; 
   d="scan'208";a="36391625"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 12 Apr 2024 15:20:29 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5A234174287;
	Fri, 12 Apr 2024 15:20:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1712928025; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=aMvVxK4NUeO+EcAGmB+Dwa/0aVRFR5DKQOjKU0G2Dag=;
	b=CfYTisVx8pOM7rt+jKQ8hVvpZN3Mla3TUQipYvq+MxbYpvgC6PrmIGMS0myDHTPnzAOs45
	n3XDuIpcEx7hq5PuJs7yRVL0yI1nJdQyNzCmb7w0MzpkFa6pCkUHj9VksxKQqqYtFnfOHB
	WaCA8ZxAD+/gEuvkIC0V9hV5aMZGUAop3yY4TChbFW3hAXnBrKISIe62wQxw70gqdJfAYB
	cIsd4qlP6n3OETmfyCBe4qJ5J8W0IjzQOpQ596fhePKbcNEYxsakbU27F6tsSfzvd+uVYx
	Xrzk837JPnkkcMeuqMe6yuvtF2C78nRDR2R6dEtICVAsosqL07cGaArFEKQIgw==
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
Subject: [PATCH 1/1] arm64: dts: tqma8mnql: Add EASRC support
Date: Fri, 12 Apr 2024 15:20:21 +0200
Message-Id: <20240412132021.520666-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Enable EASRC support in tlv320aic32x4 sound card.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Note that the firmware file /lib/firmware/imx/easrc/easrc-imx8mn.bin
is needed.

 arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx.dts | 4 ++++
 arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl.dtsi       | 4 ++++
 arch/arm64/boot/dts/freescale/mba8mx.dtsi                 | 2 +-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx.dts b/arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx.dts
index 433d8bba4425..b05be5b39d45 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx.dts
@@ -74,6 +74,10 @@ &sai3 {
 		 <&clk IMX8MN_AUDIO_PLL2_OUT>;
 };
 
+&sound {
+	audio-asrc = <&easrc>;
+};
+
 &tlv320aic3x04 {
 	clock-names = "mclk";
 	clocks = <&clk IMX8MN_CLK_SAI3_ROOT>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl.dtsi
index fb24b9aa1b93..db47c718e719 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl.dtsi
@@ -52,6 +52,10 @@ &A53_0 {
 	cpu-supply = <&buck2_reg>;
 };
 
+&easrc {
+	status = "okay";
+};
+
 &flexspi {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_flexspi>;
diff --git a/arch/arm64/boot/dts/freescale/mba8mx.dtsi b/arch/arm64/boot/dts/freescale/mba8mx.dtsi
index 0dc48e514baa..daba4ba14627 100644
--- a/arch/arm64/boot/dts/freescale/mba8mx.dtsi
+++ b/arch/arm64/boot/dts/freescale/mba8mx.dtsi
@@ -157,7 +157,7 @@ reg_vcc_5v0: regulator-5v0 {
 		regulator-always-on;
 	};
 
-	sound {
+	sound: sound {
 		compatible = "fsl,imx-audio-tlv320aic32x4";
 		model = "imx-audio-tlv320aic32x4";
 		ssi-controller = <&sai3>;
-- 
2.34.1


