Return-Path: <linux-kernel+bounces-126670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D796893B41
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A470EB2188B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 13:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A61B3F9F5;
	Mon,  1 Apr 2024 13:11:56 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3233B3F8C0;
	Mon,  1 Apr 2024 13:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711977115; cv=none; b=srvVbGJWYpXJtaixnz+NYwNZp91CoPUhQxmqXmPPVqVsEvWG1f3lI3yUpVTN31suYKPKHRQujBsvMZKvdvhg2SKQchCHAA/g8iuJSuS4qLNCL9vxetMksRsXAORBwJ9lKASVG9slIQBde+N50ktICi+kpOtJmyE1sG3vZlcvkro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711977115; c=relaxed/simple;
	bh=Cnt23ToVPq8Jje5UN2L1t7Mar8+ula74xp+z9n6Upow=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=azwAOGDcsJRNPyB/mNjYqJegDw0XbOhgEFTlQUwVxasgvw3XOOz85KaxxTILoPDAOF6HO1GURVtER6Z2QrdNccUuu3D5O/7ylpYFcy1Dx5d8DYW3xsTXYHAdi09fT5QXK5uAiRmFxEoXS4uxO136QPyX5+RrwcrfOn9r9Soojsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C4A43200120;
	Mon,  1 Apr 2024 15:11:46 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 79897201BED;
	Mon,  1 Apr 2024 15:11:46 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 654BD1802183;
	Mon,  1 Apr 2024 21:11:44 +0800 (+08)
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
Subject: [PATCH v2 1/2] ARM: dts: imx6sx-nitrogen6sx: drop incorrect cpu-dai property
Date: Mon,  1 Apr 2024 20:54:15 +0800
Message-Id: <1711976056-19884-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1711976056-19884-1-git-send-email-shengjiu.wang@nxp.com>
References: <1711976056-19884-1-git-send-email-shengjiu.wang@nxp.com>
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


