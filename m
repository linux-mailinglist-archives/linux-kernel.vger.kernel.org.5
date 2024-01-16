Return-Path: <linux-kernel+bounces-27334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FDD82EDEF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F35C285143
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0839F1B94E;
	Tue, 16 Jan 2024 11:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="VF1Z8qQd"
Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5091B812;
	Tue, 16 Jan 2024 11:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <othacehe@gnu.org>)
	id 1rPhnO-0007Zp-E8; Tue, 16 Jan 2024 06:39:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:References:In-Reply-To:Date:Subject:To:
	From; bh=/ZQ3wluHD1LXJ5OmeEllMQ5XoD5EACpofJgC3PjE+Ps=; b=VF1Z8qQd7XGFvyVko34+
	okRnJZbMueNpJMW9RBHLz5w2NdexC/vo5CnoyLp7nl1G6ltn+TYoI7U7y3P6qf3oOWpbOcgZiQhlU
	sToArPq5wWJKrbDLzkKN4XEOaaY8JkSl53MKtrDqz7SEKZTFNi2k7ETJ1YfNwn+TAUb+JkFASpChN
	HuVJAVznQk+SPsDyKYJTkK2xZuS0jTZa6bRwVhgakDOZXqDclxJqiKrASKgg800DVTWX3a3sYERp8
	cGf7de52LqwUqdL5TTDK9hPJKauXpntp5zWZ3cTfgzy9WLmhlmXrFqgqRUuhomFlai9jbDOAGGX3B
	fuplcGE37D31oA==;
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
	Stefan Wahren <wahrenst@gmx.net>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mathieu Othacehe <othacehe@gnu.org>
Subject: [PATCH 1/2] dt-bindings: arm: fsl: Add i.MX93 PHYTEC with Segin
Date: Tue, 16 Jan 2024 12:39:38 +0100
Message-ID: <20240116113939.17339-2-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240116113939.17339-1-othacehe@gnu.org>
References: <20240116113939.17339-1-othacehe@gnu.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for i.MX93 PHYTEC with Segin board.

Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 228dcc5c7d6f..196935d3abf0 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1275,6 +1275,12 @@ properties:
           - const: tq,imx93-tqma9352        # TQ-Systems GmbH i.MX93 TQMa93xxCA/LA SOM
           - const: fsl,imx93
 
+      - description: i.MX93 PHYTEC phyBOARD-Segin
+        items:
+          - const: phytec,imx93-phycore-segin
+          - const: phytec,imx93-phycore-som
+          - const: fsl,imx93
+
       - description:
           Freescale Vybrid Platform Device Tree Bindings
 
-- 
2.41.0


