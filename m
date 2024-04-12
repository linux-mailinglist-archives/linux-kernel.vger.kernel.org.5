Return-Path: <linux-kernel+bounces-141912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D96E08A250E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 118B21C23247
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7648318B09;
	Fri, 12 Apr 2024 04:14:55 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD811B81F;
	Fri, 12 Apr 2024 04:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712895294; cv=none; b=mHJ0rXJHR5qw3t9xByAo/uNQ7sBadrVijATkbEeVRYaMs7NGlXBRUYnQxERNOiI5wZtYjzc6zK4eAa9piE+qbbEQ69+7tVq96Nljdzl1tE6eTkjgPZWaNXDCadl5mbZ1U0eXUDBB64fwMysoBubMmzSO0IPAGDkNNZffsXHzu9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712895294; c=relaxed/simple;
	bh=tDDb/tTQ4ws60s2OvSKeSyYAre0E/OFBuOxx8cOi9LM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=VBQmKcvMy8+rLOyy2rW2qXci0LG+RhX+/gLG40vW89TWKPhvy8nLYoD2si9o6dJrk8kCA4XGlwd4K0iNgse1JYXgORsC+qe/ga/0QVnbNK80qoE8kaUg4ZA9gBbq0OatpurL02Z5SABOoo8mlETI++KQYbt6PEQ9jU8Yj+rrdHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4F8001A0402;
	Fri, 12 Apr 2024 06:14:49 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1859D1A11D4;
	Fri, 12 Apr 2024 06:14:49 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 4E6D5181D0E5;
	Fri, 12 Apr 2024 12:14:47 +0800 (+08)
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
Subject: [PATCH v5 2/2] ARM: dts: imx6: exchange fallback and specific compatible string
Date: Fri, 12 Apr 2024 11:56:52 +0800
Message-Id: <1712894212-32283-3-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1712894212-32283-1-git-send-email-shengjiu.wang@nxp.com>
References: <1712894212-32283-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Exchange fallback and specific compatible string for spdif sound card.
The specific compatible string needs to be in first place, the fallback
compatible string needs to be in the end.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
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


