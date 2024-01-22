Return-Path: <linux-kernel+bounces-32674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 286E0835EBD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D21151F2134C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF85D39FDE;
	Mon, 22 Jan 2024 09:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="cqaWZGyA"
Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E6339AF6;
	Mon, 22 Jan 2024 09:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705917217; cv=none; b=j+nsDb3TIWXBFk1T/34irSOn1BU16XhBZzSnWu8Xsr0DXhl02WPOv4228U5s+B0QxIBpDB8d0qwJIGlCk1vNrI92j15fHHiElwE/eS0itTT5AcbrY2r25qAh0VuxiglmVgP0uRN60QSD/AOtarV2fZWV77qRopQVV4sHw3i53Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705917217; c=relaxed/simple;
	bh=kJVxuLKP5/Z88ANSM4+a7AaBGp1c1zLFsdwtovKAask=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QyHSVvtFvxehd45xDT5LDe7WOM9Veju1k6cZDcYJaBBl2+2mUGDM6z0+8AqGBPTdTgT04ciMV1UI1gnd4MXeSiDCDcC91yL2omX+o1Ta5pXxmA/RdeAwJYUjAgq8o1eVBF0AW4cbRYSSuZv4Uy1B7gnHEtj/stkG/MxfqAlz4Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=cqaWZGyA; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <othacehe@gnu.org>)
	id 1rRqzl-00047v-Aj; Mon, 22 Jan 2024 04:53:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:References:In-Reply-To:Date:Subject:To:
	From; bh=Nu73J2+itShKzZjYU3N4YG8o/iU7VMkly5/BSbm9Wwc=; b=cqaWZGyAV3q2Gh9pSSEV
	04Pep/qRPrVSqFE6Xbl9MeucDfljVBU4OshfrdWqXkRxerzkRDxo5Jy38aVa37+H+sc1FTeBbpfvZ
	ktNRQrBfA6oz/dSpFENB+TncfA+3dDpb2nlyf1hn9RlmP5kSc0ZPESY0eWIOAMlUZV/McR2Hzryh3
	OBoVOdlUG97+54yJU2XtTOhMrGtvZZ4m+KAD7oEQS2nTpDwfQmV25Pw/UrvvZksAq9d8qzURKbH0M
	gg11yj2GLpsq2c4F0R3l78RL7LfL0aIXn67X4S5LccGA8g5BrGl2j5Lj2rJi0gptuhxXO36Df9oV2
	m+pi1ncqmgEdZA==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Li Yang <leoyang.li@nxp.com>,
	Primoz Fiser <primoz.fiser@norik.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Christoph Stoidner <c.stoidner@phytec.de>,
	Wadim Egorov <w.egorov@phytec.de>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mathieu Othacehe <othacehe@gnu.org>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/3] dt-bindings: arm: fsl: Add phyBOARD-Segin-i.MX93
Date: Mon, 22 Jan 2024 10:53:04 +0100
Message-ID: <20240122095306.14084-2-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240122095306.14084-1-othacehe@gnu.org>
References: <20240122095306.14084-1-othacehe@gnu.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for phyBOARD-Segin-i.MX93 board.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 228dcc5c7d6f..b6c523d02d29 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1275,6 +1275,12 @@ properties:
           - const: tq,imx93-tqma9352        # TQ-Systems GmbH i.MX93 TQMa93xxCA/LA SOM
           - const: fsl,imx93
 
+      - description: PHYTEC phyCORE-i.MX93 SoM based boards
+        items:
+          - const: phytec,imx93-phyboard-segin # phyBOARD-Segin with i.MX93
+          - const: phytec,imx93-phycore-som    # phyCORE-i.MX93 SoM
+          - const: fsl,imx93
+
       - description:
           Freescale Vybrid Platform Device Tree Bindings
 
-- 
2.41.0


