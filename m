Return-Path: <linux-kernel+bounces-142547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F9D8A2D06
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C2A0283A95
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0711953370;
	Fri, 12 Apr 2024 11:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="iS1G2RFQ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="b7R26/kx"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6241D42069;
	Fri, 12 Apr 2024 11:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712919822; cv=none; b=tEjRTDfcISdaw/KvWScDD4Q9+kYObf9C+M0J882N7rZ8owR1YQBvbgTIivwXWrrpLDmewrpPmBtlSt9fsaFhg584Oy1jVUDwxPQFiw9INGoUH2UKCvsAMVjVPHBDW+MPf2cHgMl/qJviw5GI2UjvO6MbVDCNLKUO9XmwjucTzhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712919822; c=relaxed/simple;
	bh=2TiG6IisAengvrM4yOX4huG1025pb45Hy0xgkFSuDak=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aVg/B6C7dLCvRrRuD7RRV1guox+ktQ1qkFFNmQJjjzjbYsNGzQ2fPCiRv51XWe4RzZ+sqGPgBFjSlEdtDD/zvAoRTYHm+4cfbUMKaVmPjTu1XFPf7ce7i/BRN7GTYzDBNR4HknWh/Nwf1+nta8qSIfGMnUuEMWrfhYWw0gbcMMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=iS1G2RFQ; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=b7R26/kx reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1712919816; x=1744455816;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=scQdImwClcmc50EBROn+qrN6qypN0cK/nS7ZnHeZg+Y=;
  b=iS1G2RFQ5tIkXfjFHtqXR7QRQj24pXU/e+fX+jKSqaa4z9Bi77QZ5hkW
   RqOR19Db/r6l3zhiAd9YH70VC2+KfQjsDZDxrqsbrApdRYbD187ts7xZF
   nK+0579iFzWAMgXd923x6bvNzWNE3zLNFjJY5qkDWQe8BkFT8Rd8e0uHj
   bVJhnudLpJcj0i6V49tIy9Ks43F+0WU5eBN4L/42t9ycZViQBl0gxgk5X
   KYK67iXqyzz+QeXk3quM/GP2Jwe2oWLlnjHr9jaSJEgmhmtL/x3y6Lk0K
   eihjSCVcawYEgAiK7+KgtW1axVLH6sAIdEPEf1FDHwKCWmwQ10PKkQhdo
   A==;
X-IronPort-AV: E=Sophos;i="6.07,195,1708383600"; 
   d="scan'208";a="36388726"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 12 Apr 2024 13:03:31 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 585FA16F866;
	Fri, 12 Apr 2024 13:03:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1712919807; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=scQdImwClcmc50EBROn+qrN6qypN0cK/nS7ZnHeZg+Y=;
	b=b7R26/kx6YRsYn20zRnB/zHjFopoBhsOnTAN3r9Z4YUhLUWrW3wVx9mboaa7cMIWwZsIdS
	jYtHCYnJ+sIBQUIVS6HDroQnmwodIHXU2kkijuGNJYQy2/obQbA7LopuMLD9qwYs1kfGGb
	zuQUVlCVtoGiKuZRgGBvd2IiMiIecF4cIYsjF8657CBGcuZHIGB5lpHJcwS5/VqREGpQzA
	JPLJjDbqO5Y5+Eiifxjp+xtztyB7SRIDhVbqi5YhTjmgiZs4ra/wGat5mAwWtV1uPehmkM
	8M5Q6pktAflCfhGGJ84ZVYPTLOUQfHIrP/B4Z2yS6bE+Gy3J/Cr90tCWsS+Gjw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 1/1] dt-bindings: interrupt-controller: fsl,irqsteer: Add imx8qxp support
Date: Fri, 12 Apr 2024 13:03:18 +0200
Message-Id: <20240412110318.273791-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Some SoC like i.MX8QXP use a power-domain for this IP. Add a SoC-specific
compatible, which also requires a power-domain.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
This patch replaces v1 from [1].

Changes in v2:
* Add imx8qxp specific compatible
* Require a power-domain for this SoC

[1] https://lore.kernel.org/all/20240110094338.472304-1-alexander.stein@ew.tq-group.com/
 .../interrupt-controller/fsl,irqsteer.yaml    | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
index 20ad4ad82ad6..0ce0246870c0 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
@@ -14,7 +14,9 @@ properties:
     oneOf:
       - const: fsl,imx-irqsteer
       - items:
-          - const: fsl,imx8m-irqsteer
+          - enum:
+              - fsl,imx8m-irqsteer
+              - fsl,imx8qxp-irqsteer
           - const: fsl,imx-irqsteer
 
   reg:
@@ -42,6 +44,9 @@ properties:
   clock-names:
     const: ipg
 
+  power-domains:
+    maxItems: 1
+
   interrupt-controller: true
 
   "#interrupt-cells":
@@ -72,6 +77,19 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx8qxp-irqsteer
+    then:
+      properties:
+        power-domains:
+          minItems: 1
+      required:
+        - power-domains
+
 examples:
   - |
     #include <dt-bindings/clock/imx8mq-clock.h>
-- 
2.34.1


