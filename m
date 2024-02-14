Return-Path: <linux-kernel+bounces-64793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4FA8542E9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A40D285A61
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F185125A6;
	Wed, 14 Feb 2024 06:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkD7FZ9G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D9311193;
	Wed, 14 Feb 2024 06:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707892584; cv=none; b=OFmY/CXufpSBlRsBvJg8aeP/U7auRMtbWu63J2Ft0ArZtIFp7d0wnMlNuIR4TahuAeum/53kYr8pqyfX54zQJu76oXaRIIB0npTrjQPGlkZdDCbX0na5KxekiflyLTlWD1jGKYDK9NUEGl3t84oGBgGFVtsrrd+fciaq5iS5HYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707892584; c=relaxed/simple;
	bh=eMfD7O3mKBgytq6cqeXHFyoxCZgEikAzzCVwKh35KmQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=luLtjAPRmyheptS39xCkefnWHiKBvsPRetgLWqfsp/EqXjXHsOhkIOv1Vz7xLc6TSQZHLOXOQlFROUS+IktYAmK+JP6wXNUiUvbeRtYqdN+yPoYC8L8/hR9m79EFTLWAnLE8VxenqB5iVqcyPA2Anp8YbQFhpdpu2w9IAn2sOVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkD7FZ9G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CEC07C43390;
	Wed, 14 Feb 2024 06:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707892583;
	bh=eMfD7O3mKBgytq6cqeXHFyoxCZgEikAzzCVwKh35KmQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nkD7FZ9GsL5MU5+3M1s2IwTCiv4bAdPmDDV6PpAAjtUydJ6wZhho1+vkQyVbe8IVz
	 CYlgHW6NVlzCnP0LDTCCiZ9nf+dZTpxgAdtmpHfBmcsjcy9JgmBapGJj4AC0gTc5kq
	 uw7jvJzDY1YRJr22WmdmmOfom5Y9w+cD2i1OQqqsWU3c57G9TwIObCPKu/ou/aIGnF
	 gpSIwwoHuQDr5Q/qMfgU1R+WfOghHKKhN76Pq1RGcR4gMwY2qmUtLtf7GvQnjYye35
	 XM7/p8+oq+Eb0KP/TvXzNSOP6YeAltNwkkolfX9VLHqmDbNVUw/+By1zYnmL3FPt8y
	 7XoITRFFWI4cQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2370C48BEB;
	Wed, 14 Feb 2024 06:36:23 +0000 (UTC)
From: Christoph Winklhofer via B4 Relay
 <devnull+cj.winklhofer.gmail.com@kernel.org>
Date: Wed, 14 Feb 2024 07:36:14 +0100
Subject: [PATCH v7 2/3] dt-bindings: w1: UART 1-Wire bus
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-w1-uart-v7-2-6e21fa24e066@gmail.com>
References: <20240214-w1-uart-v7-0-6e21fa24e066@gmail.com>
In-Reply-To: <20240214-w1-uart-v7-0-6e21fa24e066@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707892581; l=2213;
 i=cj.winklhofer@gmail.com; s=20240104; h=from:subject:message-id;
 bh=yLV7IXmfdL8oY7fuePFUPpVLjP+tA63tYbAEut11d5g=;
 b=92emIKE9Ak5J2oB0JGnAAtKQWiPr0DGMmL4XQKKeyWWY2JOcZvn2YQJiHdw50/TNkXo5HMTQ8
 g0MsLndArVLDR3etY1s2hi3m7fzx/hOe9lC//yYky3eadru94LnkRzY
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


