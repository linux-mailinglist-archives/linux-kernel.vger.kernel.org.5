Return-Path: <linux-kernel+bounces-111293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA442886A4F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9445928253B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CCF3E47F;
	Fri, 22 Mar 2024 10:30:20 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE393CF72;
	Fri, 22 Mar 2024 10:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711103419; cv=none; b=T85GBQvx7V3cH64LF45ww8T/leCjQ3WsRR5ybrKPfORmjjYytzMHIv1XURe3UCC5lx7Sm79K7HIFZkbP4VnIiD648/1nHyyfkqR/KPtJ2OoAQuCejtpVLbSoKCYFJj5rMirFjCb2tUp/AgbH4mDPKBiXnRl40quZ+2D9so6OZZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711103419; c=relaxed/simple;
	bh=Cnt23ToVPq8Jje5UN2L1t7Mar8+ula74xp+z9n6Upow=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=Ud5wlblZC/aW9O7+BSZzVrDOBmSgTaS+EOATfuaYE5PElKxGLrzBr2V2rcZUurbUiHCKnc4ptTfKeBnIuDbU3KokOvUoH5S79IIYElbsC3jL9AzWlqb0Eekf0rUOlE4UltyemS2k5jgizVrJjf0sRCo8z0hoQcqHMn2c92q6O4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 83C3C2026D8;
	Fri, 22 Mar 2024 11:30:11 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 308842000EC;
	Fri, 22 Mar 2024 11:30:11 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 7D6A5180222F;
	Fri, 22 Mar 2024 18:30:09 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shengjiu.wang@gmail.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] ARM: dts: imx6sx-nitrogen6sx: drop incorrect cpu-dai property
Date: Fri, 22 Mar 2024 18:13:26 +0800
Message-Id: <1711102406-8399-3-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1711102406-8399-1-git-send-email-shengjiu.wang@nxp.com>
References: <1711102406-8399-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

drop incorrect cpu-dai property, change it to ssi-controller

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6sx-nitrogen6sx.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6sx-nitrogen6sx.dts b/arch/arm/boot/dts/nxp/imx/imx6sx-nitrogen6sx.dts
index cd9cbc9ccc9e..b82d91a7d76d 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sx-nitrogen6sx.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6sx-nitrogen6sx.dts
@@ -83,7 +83,7 @@ reg_wlan: regulator-wlan {
 	sound {
 		compatible = "fsl,imx-audio-sgtl5000";
 		model = "imx6sx-nitrogen6sx-sgtl5000";
-		cpu-dai = <&ssi1>;
+		ssi-controller = <&ssi1>;
 		audio-codec = <&codec>;
 		audio-routing =
 			"MIC_IN", "Mic Jack",
-- 
2.34.1


