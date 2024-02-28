Return-Path: <linux-kernel+bounces-84484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C6686A74A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 04:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34462B23BB5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D04208CF;
	Wed, 28 Feb 2024 03:45:59 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F24200D9;
	Wed, 28 Feb 2024 03:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709091958; cv=none; b=RZc87D7ayZ7TWvW6J1eWNGIti7rquy2NjCkLsJPUVbcKpZtdvox6ipxBcASG1hGTE++TijBTJ6t3BuCyTCUXkR5ORi7zULowSi366SxJAIii1HDepmIVYOjXK16wDo3A1qPLCMln5PZGQf5YPJVghgOaVT4m1JDVQ5aMi0TO3mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709091958; c=relaxed/simple;
	bh=Bl6rPM0HshEr0zUSycYE2FZ028iFBKDgUFeyLWaVT1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=UR/jNFHDOt+S2vFR1cIu7VnlXuXOpfGh9yyjNnUN5JmsuJVDB1GLNgK8AtbEHFl80IOrKR7+uWczKFgGYFkqeYrqrMdqXjHRlgrZ2ytny5hHdneg8mWsWMI7p2CeQ6SJ/R1MIzPsM1tkyVpD9Xn7Xq3bIErMK6+Ya0Soot4CrzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CBB422008AD;
	Wed, 28 Feb 2024 04:45:49 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 948472004CF;
	Wed, 28 Feb 2024 04:45:49 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id E17D4183AC0B;
	Wed, 28 Feb 2024 11:45:47 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: shengjiu.wang@gmail.com
Subject: [PATCH v3 1/3] arm64: dts: imx8mp: Add AUD2HTX device node
Date: Wed, 28 Feb 2024 11:30:11 +0800
Message-Id: <1709091013-14026-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1709091013-14026-1-git-send-email-shengjiu.wang@nxp.com>
References: <1709091013-14026-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The AUD2HTX is a digital module that provides a bridge between
the Audio Subsystem and the HDMI RTX Subsystem. This
module includes intermediate storage to queue SDMA transactions
prior to being synchronized and passed to the HDMI
RTX Subsystem over the Audio Link.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 9ab9c057f41e..721ab630d895 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1513,6 +1513,16 @@ micfil: audio-controller@30ca0000 {
 					status = "disabled";
 				};
 
+				aud2htx: aud2htx@30cb0000 {
+					compatible = "fsl,imx8mp-aud2htx";
+					reg = <0x30cb0000 0x10000>;
+					interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_AUD2HTX_IPG>;
+					clock-names = "bus";
+					dmas = <&sdma2 26 2 0>;
+					dma-names = "tx";
+					status = "disabled";
+				};
 			};
 
 			sdma3: dma-controller@30e00000 {
-- 
2.34.1


