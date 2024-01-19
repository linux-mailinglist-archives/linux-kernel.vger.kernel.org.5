Return-Path: <linux-kernel+bounces-30953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 102698326B8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 435761C23265
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840F73C482;
	Fri, 19 Jan 2024 09:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="P9L9LYVr"
Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EFA3BB5F;
	Fri, 19 Jan 2024 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705656533; cv=none; b=MK+wmcdhOiKyg+IMBnwH/5cYdQQ3rRzDXdNmnxGPeXSi4mXekISTEFN1TBXspbDCINsAScSJutuAxYssBp5QA08/UInqY6fqTmPtpKpNErRhu57CaPxeEHqFvVVY+nCrr/zZFyDsLf1Qu0lZUK1xvfZjorFsXyoZXW6n0tmhBpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705656533; c=relaxed/simple;
	bh=NcxC8z6GO97kvQskEb+Rip3DdNi//q9npBCdTx8H3wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQ6Zw7SRNm+fL5ToBHmJoMCaL2FDyBaxnRvRmSzjo2nkYgy+KMZvtTUVMSzG07pfpQndtR+yBXvuG/iXDZRSOZc2exXXtPYh2xYSL2pbYdh3bp9MOhppgPbHCbL4Hb8jtNtbMUfQuqkV7f+yEd8iPESDlj4cyi02NJgzNURdtvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=P9L9LYVr; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <othacehe@gnu.org>)
	id 1rQlB8-0000nC-Gq; Fri, 19 Jan 2024 04:28:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:References:In-Reply-To:Date:Subject:To:
	From; bh=YogRMraX+PH7K2tA18lYhHpq7iskflUUEp7H+6Cg5i8=; b=P9L9LYVrkPmrBKoQ3e5J
	oz7fd5Pu3XUiGEO5jkHsQ2lo30cUCeO3VZNV93nZwRQ0+PA8557D3xRu2tn2QNtNxcjMhzsXO8y57
	fRJsuMYTOtwKICaG6OBMxOA2RTWV+1erV504Gf7orXPP018CvTHx8n+gO/QLuuDpr0U5RvjvULG7S
	NBSAUwvCIqD8jUt6Vi/WELPAJvI8mIT2VQEs5URdyksbOlanIK0MrjH4k66nKqhQA1InodNfJQcl0
	oYF1LgadBTVZOK5IseOrMBOiIptq6npd+nA5hkhRPrkiLCwYKGHnRTHBDK+pwWkwmVioHyGu8gozh
	RlsSS3Gq+Ul9uQ==;
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
	upstream@list.phytec.de,
	Mathieu Othacehe <othacehe@gnu.org>
Subject: [PATCH v3 1/2] dt-bindings: arm: fsl: Add phyBOARD-Segin-i.MX93
Date: Fri, 19 Jan 2024 10:28:34 +0100
Message-ID: <20240119092835.21462-2-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240119092835.21462-1-othacehe@gnu.org>
References: <20240119092835.21462-1-othacehe@gnu.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for phyBOARD-Segin-i.MX93 board.

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


