Return-Path: <linux-kernel+bounces-103444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 505BC87BF6D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E07631F232A6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC2471741;
	Thu, 14 Mar 2024 15:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="IGPAsmka";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="hn+BT1yA"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F2871732;
	Thu, 14 Mar 2024 15:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710428406; cv=none; b=pGnPh9+glEH6nvryWq/CTZ1hooyFgoD9XYwRayHB3u8MoOOHh/yf2LBiLLWckSKKKEl0+hjl69I8EU5c8DXrnhCGAIPh8V25z1WrGi1d4bylOvDJX1QMzxt1dJviSpVQEfQa+lFXeTMtOrix73xtV7bMARok/ZKdBXGaB8raEyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710428406; c=relaxed/simple;
	bh=5mrcYhUAuS8aHhbp+4i2PfKP1o71+XwEUwhBGn4mANw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DISLOm7xsMxB1qGn7OFSoOST0cN4sZxMdszoHGumxMkAbgRUXU4rsB9IZ1g5OcuL/McQA9fdxEh2++LeP8OlOrG8JUUEmA7kl+W6AUM88LWfH0C4FbDY8qVw8CILapAg7PeJD6wFpHjFPr9pB5II2KYMIE1Sla9zt/ajIPKXruc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=IGPAsmka; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=hn+BT1yA reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1710428403; x=1741964403;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=X86tydP3lQzpr8Ze9mLK2TNuTfB1VCl0UWZMPMko9c8=;
  b=IGPAsmkaBrCSopFoKVNWslZ0fTBvXHLI6rbdwOI32cN6ai+Iwu7bBjlS
   1j/cfh9j3LTj2PxyBDM8uWMPSrWoiCk/RapIaBN3qoyqAlnqEKmkm+aEE
   qPJ8hYD9CN0n88XaEpWX8MMc/trLynEmE2Qoz6p0++r99yv8SfDIu4LJ0
   i1LQO0p5568S4MEOUUxjeDKFX6GD7Euc47QFmnXOcyLTgigVFU3OXQDbl
   jBi1zbui/D7VJhq1yUgYBoWl03yi3qX+ZDv2zAlfCXNE7cI70rDdZI0Qi
   ydmFaIgyuXX8jOJiLtIl6K27W5CJAxyH3fOJxewkHwH1UNJJnrXhq7+fL
   w==;
X-IronPort-AV: E=Sophos;i="6.07,125,1708383600"; 
   d="scan'208";a="35916670"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 14 Mar 2024 16:00:00 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 72D0116FB2A;
	Thu, 14 Mar 2024 15:59:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1710428396; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=X86tydP3lQzpr8Ze9mLK2TNuTfB1VCl0UWZMPMko9c8=;
	b=hn+BT1yA0G4BV4/sU+yZ4GiwUyBiwwnNIGDOjgGdJb5KHAtP0ubJrUwEqyG/8e6w9G3nsZ
	26lqIJLLfEDp+l2cwZWlMAuP4uzthvGYt5X3F13M5FMY7FIA9S5/f/L6qPWYvIEZRzh5Mm
	foCuNDfYgU8O4jj/dJMEJ4IM3X87fI+2IfyTPXj3JxDR+0xp/sfuST4UltH0LGwjucsrk8
	H1l18SWE8fJ1sX5Ur74Kf8JWjDS5nPAJK+VzFwudvIabGIzEnfGR3G0t31aZUWoITUYIsT
	ZJsQNZS41oCTipaINvMADsawJRcwhAV35wHL/fNtj8zWpxwXb69fEhssqBt/cw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] dt-bindings: soc: imx: fsl,imx-anatop: add imx6q regulators
Date: Thu, 14 Mar 2024 15:59:53 +0100
Message-Id: <20240314145953.2957313-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

imx6q has additional regulators compared to imx6ul. Add them to the list
of allowed patterns.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Commit 465c7756d1ff ("dt-bindings: soc: imx: fsl,imx-anatop: add binding")
only added regulators for imx6ul. I'm not sure if this warrants a Fixes
tag.

 Documentation/devicetree/bindings/soc/imx/fsl,imx-anatop.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx-anatop.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx-anatop.yaml
index 5a59e3470510..c4ae4f28422b 100644
--- a/Documentation/devicetree/bindings/soc/imx/fsl,imx-anatop.yaml
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx-anatop.yaml
@@ -43,7 +43,7 @@ properties:
     $ref: /schemas/thermal/imx-thermal.yaml
 
 patternProperties:
-  "regulator-((3p0)|(vddcore)|(vddsoc))$":
+  "regulator-((1p1)|(2p5)|(3p0)|(vddcore)|(vddpu)|(vddsoc))$":
     type: object
     unevaluatedProperties: false
     $ref: /schemas/regulator/anatop-regulator.yaml
-- 
2.34.1


