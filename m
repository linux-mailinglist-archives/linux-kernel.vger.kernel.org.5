Return-Path: <linux-kernel+bounces-60227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 468A58501A3
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 02:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 791BB1C24866
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89373987C;
	Sat, 10 Feb 2024 01:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3utzR6G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAB71EB49;
	Sat, 10 Feb 2024 01:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707528082; cv=none; b=NPwUlyt/0Pw//beu/Erpa1nQ+e8AGRuMOjRswjOXISTjDUQ/A8zssWeii6K221KsoVRslf/MosLx5bdB9x/K+fhFIdWI1ARd/z8reihfic4nCt3aWgcJtRRj8MBErkwoSxJrW6Q7h2jbPOxdWscpX4ClV+0DM8nbF8CNcMoB0ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707528082; c=relaxed/simple;
	bh=846piNiruTJJrhtvDrc/878qsoiMsQ4DPuFKb/McImk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k9boHElh3ZaFL3CrYbVRLCsIXK+tWLs+zN8IUKaRVjZ69zOcnrrconHn9V3/cLImXu9g5f68fuZ2vr2Gd8hQkmaoasyjfmQN+FH33KUQBpZw6f8D/hNnjA1DJ+P27kArsEXAFQ9eNNcJnWvVcVXHLb7vfYBtiP2dg1A1tJ4H9XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3utzR6G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762D4C433B2;
	Sat, 10 Feb 2024 01:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707528081;
	bh=846piNiruTJJrhtvDrc/878qsoiMsQ4DPuFKb/McImk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I3utzR6G/mxyIligztfZ6ILng8kHl1jIeMoHwddL3VdV7jLsOIxs5RtOo0V4Ve6HW
	 ynIRXay+2mC4SVqO/Zvt0da4P5EGB1cdBddSz5sLMYCuzK2VORjSKG+pq4AjybvMDY
	 e7E2liqVGEm22imF0Rr+SOVnOiZDAn8+mEmGDuUza5DzwQCjoe2kO0P985c2wf57If
	 WJk7QfTgEdVZxO9pDcRJsLlzc+erRVnHtXFxLQcRW9NmZwUvjOt4+8B8JhFe1JjmVd
	 g7LsSFK1x2ADRcmE1rKoVlvXKdyx6a/L9jtAZyd4edeFJkYoeNCn7t2uLIbDa6OBpE
	 12BGWVCRTwqeA==
Received: by mercury (Postfix, from userid 1000)
	id E37461068E28; Sat, 10 Feb 2024 02:21:15 +0100 (CET)
From: Sebastian Reichel <sre@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 06/14] dt-bindings: soc: imx: fsl,imx-iomuxc-gpr: add imx6
Date: Sat, 10 Feb 2024 02:18:10 +0100
Message-ID: <20240210012114.489102-7-sre@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240210012114.489102-1-sre@kernel.org>
References: <20240210012114.489102-1-sre@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatibles used by different i.MX6 variants to the i.MX IOMUX
Controller GPR binding.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 .../bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml
index 1da1b758b4ae..6f229ffe20a5 100644
--- a/Documentation/devicetree/bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml
@@ -16,6 +16,24 @@ description:
 properties:
   compatible:
     oneOf:
+      - items:
+          - const: fsl,imx6q-iomuxc-gpr
+          - const: syscon
+          - const: simple-mfd
+      - items:
+          - enum:
+              - fsl,imx6sl-iomuxc-gpr
+              - fsl,imx6sll-iomuxc-gpr
+              - fsl,imx6ul-iomuxc-gpr
+          - const: fsl,imx6q-iomuxc-gpr
+          - const: syscon
+      - items:
+          - enum:
+              - fsl,imx6sx-iomuxc-gpr
+              - fsl,imx7d-iomuxc-gpr
+          - const: fsl,imx6q-iomuxc-gpr
+          - const: syscon
+          - const: simple-mfd
       - items:
           - const: fsl,imx8mq-iomuxc-gpr
           - const: syscon
-- 
2.43.0


