Return-Path: <linux-kernel+bounces-59037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D253884F033
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 07:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D7931F251DA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 06:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6C257886;
	Fri,  9 Feb 2024 06:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pY5Qdf+4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2E75730C;
	Fri,  9 Feb 2024 06:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707459796; cv=none; b=YU32kwvZVYplhYp56IccmpphE94ieFmfK+9a0/BsvWKXqyO3nbHv4XDmbdhAXIJNzGo8sKrUYACKrvTgRqunZ5p8XY5VjQw7ev3Xs8x8edOK8RiRgol0Ie6Te7otBzqRmGP9qegkIkvlkphMZz2qdp7e0+hF4goTk30X0exC1BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707459796; c=relaxed/simple;
	bh=eMfD7O3mKBgytq6cqeXHFyoxCZgEikAzzCVwKh35KmQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MIeZCf1pC8P+3F0CIpSJ1L5Mj+SvGy8tVJEWAr2m2NF3s2UJ0cAmglq4zd1OPJJk/LVGsuboJJnSEPv+y3q0ah1rKJnfCN3zNH4XI9PuFx8gAok5p88UMTMjlkdzdbSl0TzbBt1XELlrusGLCWqx9b6oHzAPvFxZ3waVbI6DKws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pY5Qdf+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A365C43399;
	Fri,  9 Feb 2024 06:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707459796;
	bh=eMfD7O3mKBgytq6cqeXHFyoxCZgEikAzzCVwKh35KmQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pY5Qdf+47Ovvmfc1ue+PIA1/FErBGb5sLDmDbICBGVsXU3KYAfZ+gq6qb5AEA3k0Q
	 QLy+2Bw3uD/+qpQzmKPAuwRKspjuUFbvMj/Y23z6QYZaYzxgQ04wJPSv7OYdKIOo0n
	 CEs+FpS2FV+dXExXZwLFhRRFnVNDzhSbbJ9ov1GOkKvTSn7j6WQwfHywKLuwfYY10a
	 fQIh+e4HHvRR4DrqXbbmNWfv4ZcN4PQZPfQmw0vqfArfRHZJk/pvvoFOBs9LW5SvBY
	 tHmKB5nkE/JUmKtvhYdk/Mw4b9f5DH/3LsJp7uznVfFVHw6mKCsYW1OzSILo/xqz3l
	 dlvbUwjHcwAsA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6F4C4829E;
	Fri,  9 Feb 2024 06:23:16 +0000 (UTC)
From: Christoph Winklhofer via B4 Relay
 <devnull+cj.winklhofer.gmail.com@kernel.org>
Date: Fri, 09 Feb 2024 07:22:38 +0100
Subject: [PATCH v6 2/3] dt-bindings: w1: UART 1-Wire bus
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-w1-uart-v6-2-3e753c149196@gmail.com>
References: <20240209-w1-uart-v6-0-3e753c149196@gmail.com>
In-Reply-To: <20240209-w1-uart-v6-0-3e753c149196@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707459793; l=2213;
 i=cj.winklhofer@gmail.com; s=20240104; h=from:subject:message-id;
 bh=yLV7IXmfdL8oY7fuePFUPpVLjP+tA63tYbAEut11d5g=;
 b=XTioNouOeMzVmx5vfRRoH3PgXL1pxauzYWe7m/SThPOjSBgrv3cmnljAs1GxV1K98WEGdv3Bj
 CIwD0VN16oOBqW5BbyRlUAC6iejnzkjRAD9ZqtV+8AvvPRAWMV1oUSs
X-Developer-Key: i=cj.winklhofer@gmail.com; a=ed25519;
 pk=lgjGjOt7hFKJT9UXhgUyrdthxvZ7DJ5F1U/7d9qdAsk=
X-Endpoint-Received:
 by B4 Relay for cj.winklhofer@gmail.com/20240104 with auth_id=111
X-Original-From: Christoph Winklhofer <cj.winklhofer@gmail.com>
Reply-To: <cj.winklhofer@gmail.com>

From: Christoph Winklhofer <cj.winklhofer@gmail.com>

Add device tree binding for UART 1-Wire bus.

Reviewed-by: Rob Herring <robh@kernel.org>
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


