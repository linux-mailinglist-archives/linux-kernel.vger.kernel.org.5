Return-Path: <linux-kernel+bounces-40293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB6883DDD3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBA6F285A30
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285D31CF83;
	Fri, 26 Jan 2024 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGGvY1pP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683821D6B6;
	Fri, 26 Jan 2024 15:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283760; cv=none; b=GyAYnzivuqvbgBpAbFUwOvXP1j+/sZoJ1O0Cq2X0j8nzfs7W1K+Rh3669fQ/+2kOOr/rhxOawA2iQC46NWptMU8ezpzfEJfe6z8tdqFXWu03EUTsHwi+rd5lJBsxBHf5Oyn9F+ocmZdk2eeTN++MyAVpjIx8S+2YIwYXyUZ8z/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283760; c=relaxed/simple;
	bh=j7kg4OW3stO0a0Rhrj5rPyzjiIHhByWYlqg9lIpQeFE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GzmEXMlSuhNhYaJ2nG+MI9yzQs7Vwzu7ol1lO0xkYrnBJSz1/1DYat0NfgqDW0tDbY0GEyKSEapMFTIL4N0so5MEoKtxIEzGN6g40NBo0Fo5skSysYeDEHtqPx6wXJWCtckeayl3ksDAPysGabFR5IoOOH3kcUvpbs43DOx+FPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGGvY1pP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1812C433A6;
	Fri, 26 Jan 2024 15:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706283759;
	bh=j7kg4OW3stO0a0Rhrj5rPyzjiIHhByWYlqg9lIpQeFE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CGGvY1pPmaWMCNT0aVZ+Ne0eDgORjopdvYtTLGjjkkSttw6fJc7qw64D/7Q8iVzI3
	 YhUrHfwAhT75EsixtZQPIMfN9EsdVvjQrp28bylh2WryvbtjfoCwfr22T2anmRuROM
	 ffhgM8BDVgN0SDUXlc3vfo02l1tvcQEsqoPif8ghx0gPT3kcS/YTC8ZT5P+o/OHE0X
	 ZOKvKtDveig718HNERgxi95yuCVJizLX+0MQdZvWe4ULsVP6ZwOUy/dPN0mw8y2xUR
	 wMFWzLsQgHvxXNPt3XNyFIi6K7g5UeCW2LrYATWw/Eqa6cLROUdyS/7WbMrXGjg+/A
	 A21g/n+RD2kkw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC033C47422;
	Fri, 26 Jan 2024 15:42:38 +0000 (UTC)
From: Christoph Winklhofer via B4 Relay
 <devnull+cj.winklhofer.gmail.com@kernel.org>
Date: Fri, 26 Jan 2024 16:42:03 +0100
Subject: [PATCH v5 1/3] dt-bindings: w1: UART 1-Wire bus
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-w1-uart-v5-1-1d82bfdc2ae9@gmail.com>
References: <20240126-w1-uart-v5-0-1d82bfdc2ae9@gmail.com>
In-Reply-To: <20240126-w1-uart-v5-0-1d82bfdc2ae9@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706283756; l=2169;
 i=cj.winklhofer@gmail.com; s=20240104; h=from:subject:message-id;
 bh=6G/O3RQhJBa6H7bxdkEx4ZF0RVzUsR6wnjgliJTkxTc=;
 b=8EBH0eB1bmYrw9pWFYUe3ET8nSh9gzPNqef6h3tiSQSwzO/UwuX95TVcC31bhoxJox0hjwluT
 6z2ft6UEl63DE9jJEkR//Uql5L4ZXwM8HqLBchdtWMMocJXhj1TcqVr
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
 Documentation/devicetree/bindings/w1/w1-uart.yaml | 60 +++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/Documentation/devicetree/bindings/w1/w1-uart.yaml b/Documentation/devicetree/bindings/w1/w1-uart.yaml
new file mode 100644
index 000000000000..7173820c78f9
--- /dev/null
+++ b/Documentation/devicetree/bindings/w1/w1-uart.yaml
@@ -0,0 +1,60 @@
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
+  reset-bps:
+    default: 9600
+    description:
+      The baud rate for the 1-Wire reset and presence detect.
+
+  write-0-bps:
+    default: 115200
+    description:
+      The baud rate for the 1-Wire write-0 cycle.
+
+  write-1-bps:
+    default: 115200
+    description:
+      The baud rate for the 1-Wire write-1 and read cycle.
+
+required:
+  - compatible
+
+additionalProperties:
+  type: object
+
+examples:
+  - |
+    serial {
+        onewire {
+            compatible = "w1-uart";
+        };
+    };

-- 
2.43.0


