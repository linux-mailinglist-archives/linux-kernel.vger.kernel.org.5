Return-Path: <linux-kernel+bounces-28613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE888300BA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD3BD2835CB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEA7C133;
	Wed, 17 Jan 2024 07:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="AMvdC0ZP"
Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B31BA5E;
	Wed, 17 Jan 2024 07:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705477762; cv=none; b=bNsjJP9KTS9kOQbn8ZXDOatOSBtlzN1i/PujWoSSozRz4/n+hh4EDUe2bvB/Vm97D3jRPNZQZuAIx1Zr0B81CWAngd8kMJoL+ZMR7RV5gSE6gcMZe99uf4WfvvM8PSkVQq+y3TxfeXBMa20aSgkQcYfVBBR7787Wez5gPgXo/YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705477762; c=relaxed/simple;
	bh=2XzToVY0q4JUFU3kMeLMFuQRGZ2YIJknDuMFlolkBZA=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=Z2WIKwrHtPsAJELXv3AVnXUBpMVjWONSk6YT3IZhNJZTC/+0qVETzq/u/Oc7SYxSXl1Anye/+iQsGvTZa/c8GOiULFemrnMGLVMLwQgJuLobSC0U7CwxkKNZbJl4piHjGDwJHD6riwXzvGfyAA+o8Dk+PTEz2t5hdPCnSLA0SyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=AMvdC0ZP; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <othacehe@gnu.org>)
	id 1rQ0fn-0000gN-SA; Wed, 17 Jan 2024 02:49:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:References:In-Reply-To:Date:Subject:To:
	From; bh=/ZQ3wluHD1LXJ5OmeEllMQ5XoD5EACpofJgC3PjE+Ps=; b=AMvdC0ZPFKA1Q6evA2ht
	wwYcqtYBiPNmgwD/kSFelgFq3QZC137UqinGCRfN6cdk783BxlPqFuPJec02MJSZn8Bxq4pHqRgcI
	kyzRMdUoQ7nphMnSndkR3Dn/SCPPW+tRjDBw8VAG2oTswtCj16UG0E9zIwwJ0VstigL5H+pQfML+4
	hfbAeQV/t431ZJlKSUb01mtIOUOEovr2X6F22+KTRz+aehhCb2sRsNLp/+teh0MgUDrjqxW7WM/US
	pwsLjVltdJlxm7Qp7hAl+JuU2zB/9WneIuyTqYCjryNh7rAw0TUc7yy2K4hlNutfj44sTuzh3u4gO
	mik9BlhnWloJEg==;
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
	Stefan Wahren <wahrenst@gmx.net>,
	Christoph Stoidner <c.stoidner@phytec.de>,
	Wadim Egorov <w.egorov@phytec.de>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mathieu Othacehe <othacehe@gnu.org>
Subject: [PATCH v2 1/2] dt-bindings: arm: fsl: Add i.MX93 PHYTEC with Segin
Date: Wed, 17 Jan 2024 08:49:10 +0100
Message-ID: <20240117074911.7425-2-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240117074911.7425-1-othacehe@gnu.org>
References: <20240117074911.7425-1-othacehe@gnu.org>
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


