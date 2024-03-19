Return-Path: <linux-kernel+bounces-106994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD71D87F66F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1555FB2209B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 04:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A203309E;
	Tue, 19 Mar 2024 04:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Egad0TXy"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AFD33C8;
	Tue, 19 Mar 2024 04:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710823070; cv=none; b=B7uSuY753U0WueQqrl8GNLn/Eu8VypzpORMkfF+rHmwvCDeToy97dZKVO2dJf4fbAlrQXQmJLKDaPxCGG4FanLImSoYLU/39y53VtCId/tw+J4Pv2LHyR9SlIosT56E8Geb3srGUiCEtM3JrdDFYhGDi/cZWQKgYhspjYsGk1ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710823070; c=relaxed/simple;
	bh=XgiakMU/yke0dBSW7Efj78RIcJqajJPIfxw61UYoO/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AD8Lv11JJoqaGilMaoM/Rn//xNixVbZioVBSqtZNvfc4pJWlJZcK/wLM10ievCCAZQKpnfHdWckkIUS/eS+yJpTJzvVO6LGgtsrvuo4uopfwJ2LlPMBi1lL3Tf6IAX/60rb9Oxztx/1ehUpPolzbBtFV1rG4IlV97ybQOve3jCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Egad0TXy; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 2FB9787861;
	Tue, 19 Mar 2024 05:37:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1710823066;
	bh=tTy0PISPhjnCVtI3dg8qFbwt0Otn6OSKuuXvqA5RIDw=;
	h=From:To:Cc:Subject:Date:From;
	b=Egad0TXy6JER5nEk/H/Yr92GHdOnkAJ2NYcdkUeb6ku1I7OqIeI+uI67mYZqDFepF
	 zOnbNa0S/77CrqGhG/TtSy3zXzKNSK7N28OYmX+tKp0srYzCLBi7n17KKizho1yUvr
	 /dM/2el4b84RMMS9qZArPG1MnbOtOtS8AZsww5vI8hiBFpOrvS984roGrH2JvmuYmC
	 sfnBiRzKBnXgCUgAPh+C1P0Hh6SfqnJeIcAj9GLkS1X10p5niTWQbdY2Hldj3fLlCi
	 QbEccNwx9EwrxziGxkU4sJOuudXr6LzyGKwiPI+7IiSIajxF4/HRitZfb7Z58iPSDz
	 l9ftpSWVXyRvw==
From: Marek Vasut <marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marex@denx.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	NXP Linux Team <linux-imx@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@dh-electronics.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mp: Describe CSI2 GPIO expander on i.MX8MP DHCOM PDK3 board
Date: Tue, 19 Mar 2024 05:37:09 +0100
Message-ID: <20240319043733.134728-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The production PDK3 carrier board rev.200 contains additional GPIO
expander to control power and reset signals for each CSI2 plug
separately. Describe this expander in the carrier board DT. The
label is used by sensor DTOs to reference the expander and its
signals.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Marek Vasut <marex@denx.de>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: kernel@dh-electronics.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk3.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk3.dts b/arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk3.dts
index b749e28e5ede5..ac7ec7533a3c8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk3.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk3.dts
@@ -167,6 +167,16 @@ sgtl5000: codec@a {
 				VDDIO-supply = <&reg_vdd_3p3v_awo>;
 			};
 
+			csi2exp: gpio@24 {
+				compatible = "nxp,pca9570";
+				reg = <0x24>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-line-names =
+					"CSI2_#RESET", "CSI2_#PWDN",
+					"CSI_#PWDN", "CSI_#RESET";
+			};
+
 			typec@3d {
 				compatible = "nxp,ptn5150";
 				reg = <0x3d>;
-- 
2.43.0


