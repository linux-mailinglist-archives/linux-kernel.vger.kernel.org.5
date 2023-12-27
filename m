Return-Path: <linux-kernel+bounces-12159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C80981F0B8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 18:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85082B21C33
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74574645C;
	Wed, 27 Dec 2023 17:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="MGGM5Ac6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF46246420;
	Wed, 27 Dec 2023 17:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <othacehe@gnu.org>)
	id 1rIXPP-0004L1-ES; Wed, 27 Dec 2023 12:09:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:References:In-Reply-To:Date:Subject:To:
	From; bh=k2bv0lubVH8NsRJr5+61Oe3KPK8iIPvWwJlHbhSRxgY=; b=MGGM5Ac68d0OWhbC878t
	l6BYYiJXF/RRsYKAt432pkyjZOUmLHV6nUQ80S/MlPPfZMmHNEvnrfaRr5BFQbQWUriAdPOpy1wfm
	gZtZO8kMJsprbdeP9oJFLT+WnIyrLZ0U6FN9wT4eZpEpNUHqK1RHzPCA6ZE4b5jxopHYdzSGYuUNB
	HWkg1KqBYPTHJiJQ6Y1M4lv2DuOdlK1YINPFzlMKzV/w3OcoTB6FWCbBS/EySKOpi2SWSUyHuUaui
	vEbkHHmTAgXSQgU+RWL4e1kGSwq86wtKSR9P8Wqpk0pvf9Mqls7INTE2rKpH/HUVjLYfh0jPdq6NN
	kHjrHWibtkAj1A==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Li Yang <leoyang.li@nxp.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mathieu Othacehe <othacehe@gnu.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/2] dt-bindings: arm: fsl: Add VAR-SOM-MX93 with Symphony
Date: Wed, 27 Dec 2023 18:09:18 +0100
Message-ID: <20231227170919.8771-2-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231227170919.8771-1-othacehe@gnu.org>
References: <20231227170919.8771-1-othacehe@gnu.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Variscite i.MX93 VAR-SOM-MX93 SoM with Symphony board.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 228dcc5c7d6f..27936edfe054 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1275,6 +1275,12 @@ properties:
           - const: tq,imx93-tqma9352        # TQ-Systems GmbH i.MX93 TQMa93xxCA/LA SOM
           - const: fsl,imx93
 
+      - description: Variscite VAR-SOM-MX93 based boards
+        items:
+          - const: variscite,var-som-mx93-symphony
+          - const: variscite,var-som-mx93
+          - const: fsl,imx93
+
       - description:
           Freescale Vybrid Platform Device Tree Bindings
 
-- 
2.41.0


