Return-Path: <linux-kernel+bounces-18635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2124826054
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 17:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5090928398E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 16:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84083C144;
	Sat,  6 Jan 2024 16:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZ/9496T"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17DC846F;
	Sat,  6 Jan 2024 16:02:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3CC08C433C9;
	Sat,  6 Jan 2024 16:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704556947;
	bh=CyM+dK81AY1GNze7Q8lQ3o9F39LiJRzCOqn3mymlsFA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HZ/9496TlKf4v2wV7fF+9NcTM9dHMCQXAcuuMIVE4Hf2npLU+aBIP13h7taxNKweL
	 CdBEFlAlaZessnSINFRDXLEXwctVsGzcWGMAculhsm6vtjTiTHDUipkb6xgi63pg2z
	 pNRoe7lzUz9ymDNXH9gpEKGTqgplPrQUKUl4l1kIQ0jbqhk0JSJZrd0G/BRoke5+NU
	 MLN1GZmBLM6PDKBqTV4l0ZhSUFIiOBeDR94sZqC8oEySftYvX+Pi+jeTObESrVheVm
	 fNMa3xdj5rbU8lLOKm/hmRpjdAyD6wlKo1RJfDYaUo1g81NydRk0ocL0sIjzSZg0af
	 ZpNv5IRQIpJDA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221D4C47079;
	Sat,  6 Jan 2024 16:02:27 +0000 (UTC)
From: Christoph Winklhofer via B4 Relay
 <devnull+cj.winklhofer.gmail.com@kernel.org>
Date: Sat, 06 Jan 2024 17:02:24 +0100
Subject: [PATCH v4 1/3] dt-bindings: w1: UART 1-Wire bus
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240106-w1-uart-v4-1-7fe1378a8b3e@gmail.com>
References: <20240106-w1-uart-v4-0-7fe1378a8b3e@gmail.com>
In-Reply-To: <20240106-w1-uart-v4-0-7fe1378a8b3e@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704556945; l=2346;
 i=cj.winklhofer@gmail.com; s=20240104; h=from:subject:message-id;
 bh=GIA/37nqwlMBtA6FnEHKs8XRjdXS3bL5cBDD0chGbYE=;
 b=M9HnA7l2nrFyCHwVTBHbWDWAg2k8moEEOvGkn+dsZ/9+/tDbjI2gkLt8m2R2tMuZtV1oBBsEM
 fwu0Ljq8EFNCw9b3ffM+i852WMaMePLLihudoO6BHBUfjhd9wuHthLd
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
 Documentation/devicetree/bindings/w1/w1-uart.yaml | 62 +++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/Documentation/devicetree/bindings/w1/w1-uart.yaml b/Documentation/devicetree/bindings/w1/w1-uart.yaml
new file mode 100644
index 000000000000..6b90693b2ca0
--- /dev/null
+++ b/Documentation/devicetree/bindings/w1/w1-uart.yaml
@@ -0,0 +1,62 @@
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
+  reset-speed:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 9600
+    description: |
+      The baud rate for the 1-Wire reset and presence detect.
+
+  touch_0-speed:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 115200
+    description: |
+      The baud rate for the 1-Wire write-0 cycle (touch bit 0).
+
+  touch_1-speed:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 115200
+    description: |
+      The baud rate for the 1-Wire write-1 and read cycle (touch bit 1).
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


