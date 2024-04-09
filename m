Return-Path: <linux-kernel+bounces-136526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4315589D524
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74DC51C2135A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF86823A3;
	Tue,  9 Apr 2024 09:08:34 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F0E7F489;
	Tue,  9 Apr 2024 09:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712653714; cv=none; b=FRVjJFFYwMvL2eY7nA5LhW0/iwjjvyWd8KwOAigguBHJDGl+yM1f0qK7ZV5akd5jHSJZUKixOuZ8u+jG1CjS5vqVH8XPLnBi/SeG/rvgEZOY78lZ9msDF0K7aScYuPksIs+XELWt54LR0qTi+4tWimFghtUWLVQhVdSf++mnfHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712653714; c=relaxed/simple;
	bh=TV/mHRHDAeKR8oNZsmgIrFOyq3YUpW9/qg1P26OXFDI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=OeVlPCmFyOwd/+piVUD+L1C6wSucTMnqrFBgHFQ5rAGh2vyoeRPnlHx8dOyc0Uhz88Xd3C1E6lZuEVpZjUkrbOYinN8OpJRCfd6zatDnI4w8xqxB4mUMElydCqPfzkITu45dli/e4IqCILn9xqaWNiO393WAIHfHwWdN0sYa5mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 36568201442;
	Tue,  9 Apr 2024 11:08:24 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F255E20077B;
	Tue,  9 Apr 2024 11:08:23 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 2473E183AD14;
	Tue,  9 Apr 2024 17:08:22 +0800 (+08)
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
Subject: [PATCH v3 2/2] ARM: dts: imx6: exchange fallback and specific compatible string
Date: Tue,  9 Apr 2024 16:50:44 +0800
Message-Id: <1712652644-28887-3-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1712652644-28887-1-git-send-email-shengjiu.wang@nxp.com>
References: <1712652644-28887-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

exchange fallback and specific compatible string for spdif sound card.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabreauto.dtsi | 4 ++--
 arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi        | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabreauto.dtsi
index 68e97180d33e..51517e27418c 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabreauto.dtsi
@@ -144,8 +144,8 @@ sound-cs42888 {
 	};
 
 	sound-spdif {
-		compatible = "fsl,imx-audio-spdif",
-			   "fsl,imx-sabreauto-spdif";
+		compatible = "fsl,imx-sabreauto-spdif",
+			     "fsl,imx-audio-spdif";
 		model = "imx-spdif";
 		spdif-controller = <&spdif>;
 		spdif-in;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi b/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi
index c6e85e4a0883..67872c16372a 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi
@@ -184,8 +184,8 @@ panel_in: endpoint {
 	};
 
 	sound-spdif {
-		compatible = "fsl,imx-audio-spdif",
-			   "fsl,imx6sx-sdb-spdif";
+		compatible = "fsl,imx6sx-sdb-spdif",
+			     "fsl,imx-audio-spdif";
 		model = "imx-spdif";
 		spdif-controller = <&spdif>;
 		spdif-out;
-- 
2.34.1


