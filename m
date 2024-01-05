Return-Path: <linux-kernel+bounces-17603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48ED3825002
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAAEA287C0F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE1924B50;
	Fri,  5 Jan 2024 08:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhvb/brI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C3921A17;
	Fri,  5 Jan 2024 08:27:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51EA0C433C9;
	Fri,  5 Jan 2024 08:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704443225;
	bh=G8eLuVwnsvFwn4kF39vSmn4oX45xzBPrmGlnzDyCVrY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lhvb/brIwBcIhUY6hJTYMUIz9BRxjoZkiCe4osmeqKEovt4N/1yvHnpZ/muqgJkSY
	 OPJiUewPw7bk42vS3BiOEMHosaFmoaEB+umU1f+gRyOwkxlprKXLhgXHErbzUeFAUJ
	 LPXx0NnBkgv3bTuZSHdCGLJ8rjwraZXD+5DWGWijGXPq/hlPw4C/LPtD8x0i7wMwId
	 IwUx9ubh4M/OsTdtIk2e7JOgAuE+fA/6k0Q7kiCD/JMZaPqrzh2AvO7ZPxJpVxqg9C
	 fwFG6JLrbVdiAkyUX1YAmUYBOK6JpQWiirIrQPg6qbSSxieoRltLhqf3TukB7wAoFG
	 AjoZOdwVcDDSQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37030C4707B;
	Fri,  5 Jan 2024 08:27:05 +0000 (UTC)
From: Christoph Winklhofer via B4 Relay
 <devnull+cj.winklhofer.gmail.com@kernel.org>
Date: Fri, 05 Jan 2024 09:26:42 +0100
Subject: [PATCH v3 1/3] dt-bindings: w1: UART 1-Wire bus
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240105-w1-uart-v3-1-8687093b2e76@gmail.com>
References: <20240105-w1-uart-v3-0-8687093b2e76@gmail.com>
In-Reply-To: <20240105-w1-uart-v3-0-8687093b2e76@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Christoph Winklhofer <cj.winklhofer@gmail.com>, 
 Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704443222; l=1794;
 i=cj.winklhofer@gmail.com; s=20240104; h=from:subject:message-id;
 bh=mQ67z9MozxmHEO1WDHe54CopgfQx4fCTtQWX0na1aCg=;
 b=YhCSSb9LicuB5pF3Y8aRvjUrvBF+D+7RDn+7/rpIYWGgWQXV0ZCJP8J7JZAQBxe2GaRDaukJT
 sgYnkIn+mVzD/FS0UCXTrBJQa9HuNDU8HweE3rd1VxvxnxdwwBqqAy4
X-Developer-Key: i=cj.winklhofer@gmail.com; a=ed25519;
 pk=lgjGjOt7hFKJT9UXhgUyrdthxvZ7DJ5F1U/7d9qdAsk=
X-Endpoint-Received:
 by B4 Relay for cj.winklhofer@gmail.com/20240104 with auth_id=111
X-Original-From: Christoph Winklhofer <cj.winklhofer@gmail.com>
Reply-To: <cj.winklhofer@gmail.com>

From: Christoph Winklhofer <cj.winklhofer@gmail.com>

Add device tree binding for UART 1-Wire bus.

Signed-off-by: Christoph Winklhofer <cj.winklhofer@gmail.com>
---
 Documentation/devicetree/bindings/w1/w1-uart.yaml | 44 +++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/devicetree/bindings/w1/w1-uart.yaml b/Documentation/devicetree/bindings/w1/w1-uart.yaml
new file mode 100644
index 000000000000..93d83c42c407
--- /dev/null
+++ b/Documentation/devicetree/bindings/w1/w1-uart.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/w1/w1-uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: UART 1-Wire Bus
+
+maintainers:
+  - Christoph Winklhofer <cj.winklhofer@gmail.com>
+
+description: |
+  UART 1-wire bus. Utilizes the UART interface via the Serial Device Bus
+  to create the 1-Wire timing patterns.
+
+  The UART peripheral must support full-duplex and operate in open-drain
+  mode. The timing patterns are generated by a specific combination of
+  baud-rate and transmitted byte, which corresponds to a 1-Wire read bit,
+  write bit or reset pulse.
+
+  The default baud-rate for reset and presence detection is 9600 and for
+  a 1-Wire read or write operation 115200. In case the actual baud-rate
+  is different from the requested one, the transmitted byte is adapted
+  to generate the 1-Wire timing patterns.
+
+  https://www.analog.com/en/technical-articles/using-a-uart-to-implement-a-1wire-bus-master.html
+
+
+properties:
+  compatible:
+    const: w1-uart
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    serial {
+      onewire {
+        compatible = "w1-uart";
+      };
+    };

-- 
2.43.0


