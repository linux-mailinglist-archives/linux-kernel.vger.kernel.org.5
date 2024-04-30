Return-Path: <linux-kernel+bounces-164508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7018B7E60
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB103B2109B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51D817F396;
	Tue, 30 Apr 2024 17:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZW2zi9aw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACEE17BB20;
	Tue, 30 Apr 2024 17:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714497933; cv=none; b=Pgh+Jhz/X20HHpYciTwVDnruHW8xtm/6TqkiX/VVt0wA9fPYQtJwm08/z5rXfRYuvNDaKis8Q0vCsYLlCZ6kROXJIsqEl3sIEdf9xRWpXseA/hgfPsatx8xJaY9H8MuVwOotrkmW5gHUHTkmfEcuIyUqgt2pFUBp0YkFMj4axl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714497933; c=relaxed/simple;
	bh=IX6Uu6LbP/xYgPUGwU4+kdor5cBr2FpREH4Pqv5Bpt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U/RkSZLhgvDmBs8eqBt5u4OYMXMr8Wbvl6cDQky6zKEpOLSLJfTlVvHjU441ZJj5HYCXaNNXhOwACWIHqniR1zpWdqeM+BC6KWRCP42OE5o3DrV96M2TcY/3qe+Q/ETI4hWLBOZsFjRRI9bEh6eUlcaxKPpguxrZQa+ZvtYBq2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZW2zi9aw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304B4C2BBFC;
	Tue, 30 Apr 2024 17:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714497932;
	bh=IX6Uu6LbP/xYgPUGwU4+kdor5cBr2FpREH4Pqv5Bpt8=;
	h=From:To:Cc:Subject:Date:From;
	b=ZW2zi9aw/QFN/U+x4XF2jMEe6uLT0E4Fk03Ot4pNgUejZgr2BsmK5bbp+jD7dGeJ0
	 qwb4yKTp2sXK5FHSe5iMzhKyDQSAW9kP9Zu+rqUNW3FQPh080dT8abyYoYzWHhHa2E
	 loBnWXU6yUmGXrpTWvYuY94JrGBoa6SIAwkFuxf86HQ1F8s+58rsmaLopt4j0VPGcH
	 2A/TVosB6SSIuDB+SYEYcz1c3xXDJla3Ne53yXtNpQDDS0RHJfhaDFBsPrzuwhEeW3
	 GMAFw9zn6LdZjjv6g/MNnUUEGr5de7tD4ypT7pGMHrI7eaVKv0FtMoqwZWWyvF6FKX
	 6q2uhnzckCxlw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Lee Jones <lee@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mfd: aspeed: Drop 'oneOf' for pinctrl node
Date: Tue, 30 Apr 2024 12:25:19 -0500
Message-ID: <20240430172520.535179-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The use of 'oneOf' to include 1 of 3 possible child node schemas results
in error messages containing the actual error message(s) for the correct
SoC buried in the tons of error messages from the 2 schemas that don't
apply. It also causes the pinctrl schema to be applied twice as it will
be applied when the compatible matches.

All that's really needed in the parent schema is to ensure one of the
possible compatible strings is present in the pinctrl node so that its
schema will be applied separately.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/mfd/aspeed,ast2x00-scu.yaml         | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
index 1689b986f441..86ee69c0f45b 100644
--- a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
+++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
@@ -47,10 +47,18 @@ patternProperties:
     type: object
 
   '^pinctrl(@[0-9a-f]+)?$':
-    oneOf:
-      - $ref: /schemas/pinctrl/aspeed,ast2400-pinctrl.yaml
-      - $ref: /schemas/pinctrl/aspeed,ast2500-pinctrl.yaml
-      - $ref: /schemas/pinctrl/aspeed,ast2600-pinctrl.yaml
+    type: object
+    additionalProperties: true
+    properties:
+      compatible:
+        contains:
+          enum:
+            - aspeed,ast2400-pinctrl
+            - aspeed,ast2500-pinctrl
+            - aspeed,ast2600-pinctrl
+
+    required:
+      - compatible
 
   '^interrupt-controller@[0-9a-f]+$':
     description: See Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2xxx-scu-ic.txt
-- 
2.43.0


