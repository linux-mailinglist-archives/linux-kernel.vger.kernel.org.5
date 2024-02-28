Return-Path: <linux-kernel+bounces-84485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 864E886A74C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 04:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6C9A1C25BC3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B6220B21;
	Wed, 28 Feb 2024 03:46:00 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5EF20326;
	Wed, 28 Feb 2024 03:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709091959; cv=none; b=YW4ON3dAmqITyUnizmxTEHD21BaEKdhgotNDcel9oEssU6vj9yHomNCDt/6gWQT1xZQwuZL7KtpFklf5n3wtJ0IWTAn2NZdv4DiND2lknuxwpNYo/45aPO0xBQRX0aiIzjTfSu3BMx0M4q8qxvn2VMldNOKw2woDuGfRPhlLeDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709091959; c=relaxed/simple;
	bh=o9AKhhrUjjEa9ygiLSi6bumMhk18O6Eq1q+lO8hXIks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Hr3B6jb/qnYBM98mxuwi0rMl4o1xMAPXRWITBR0xYZKfPhuWFW/9XJTZIKwkM1FILfFPn/hlnI66dnpZzI6csRC7KQvfOc6fULoBwJbtzomZTq7Pl+TaaoW7lWdTldCkw5LpgChT//0rgH+i1yuR08KSW2DlRjSeSQAiM7B+x0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 115B2201345;
	Wed, 28 Feb 2024 04:45:51 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CB1112008BE;
	Wed, 28 Feb 2024 04:45:50 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 23DA6183487A;
	Wed, 28 Feb 2024 11:45:49 +0800 (+08)
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
Subject: [PATCH v3 2/3] arm64: dts: imx8mp-evk: Add HDMI audio sound card support
Date: Wed, 28 Feb 2024 11:30:12 +0800
Message-Id: <1709091013-14026-3-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1709091013-14026-1-git-send-email-shengjiu.wang@nxp.com>
References: <1709091013-14026-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

AUD2HTX works as the cpu dai in HDMI audio sound card.
This sound card only support playback/output.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Acked-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index f87fa5a948cc..0fc6c0d21cd6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -138,6 +138,13 @@ simple-audio-card,codec {
 
 	};
 
+	sound-hdmi {
+		compatible = "fsl,imx-audio-hdmi";
+		model = "audio-hdmi";
+		audio-cpu = <&aud2htx>;
+		hdmi-out;
+	};
+
 	reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -191,6 +198,10 @@ &A53_3 {
 	cpu-supply = <&reg_arm>;
 };
 
+&aud2htx {
+	status = "okay";
+};
+
 &eqos {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_eqos>;
-- 
2.34.1


