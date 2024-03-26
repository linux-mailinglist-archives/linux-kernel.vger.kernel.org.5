Return-Path: <linux-kernel+bounces-118656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E7788BDD3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87AAA1C39925
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9BB129E6C;
	Tue, 26 Mar 2024 09:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyJRQwgm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB79B6E61D;
	Tue, 26 Mar 2024 09:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711444842; cv=none; b=L78y/DIYWZ5OBErfV/f9X4QX3Akr3Ntx5JYd1NcoKRnrSfgaDc/uj6yHKQtNvX0/kQGkCGJ8J4T+YJ/jEmKj4v2ASNIyDtpCiWSlrfqfgMgY1B0wo1KIfWm8EBM0nmc4pPErqEiGxKwwePfgL9XgR84xIeYTnscYDeSj0djQi9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711444842; c=relaxed/simple;
	bh=0k3URFJZb18PwpzeMhJ7DF35374xGK50doG0S5Yr3LQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IZg52FCoBEj92N4QvTVQ9YswbolWcc5Qa5TBniJQmn+XApm1HidtarV7D3RbKFByFnB+w5MorGu8zNm4LYAhgKkSv2oItsK88JanFWn2AQaWLA+3ZfhkMZkUAitcbdCH8hgD0D9T0IXnP8ollnvmvkG7yA2JGTSDl5aNfVUF1EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyJRQwgm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED4F5C4AF6D;
	Tue, 26 Mar 2024 09:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711444842;
	bh=0k3URFJZb18PwpzeMhJ7DF35374xGK50doG0S5Yr3LQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=iyJRQwgmLYxeiIq5dGrRLOV4TimdM8dEwvmDWwGHb+xx+2eIOXojC8/+i7fIQq19l
	 d99tEjvL20L2Q2rznzvN5mToWt1V0mnjPm3tFm1ba3vrGQLvyG9zYv8dlB/h61bqnj
	 +joeDIt2pi+/tedCWIV62ZAo/1ydol9uyaZegm4qNf9DpGGJ1tQFZ2ktwfPxu2T24p
	 8R/KAWHPhBThbQSVZxmVpFZxuI+duNiugmr/jt809fpS3Lz0wOuZx6gf0lCzCNMVk2
	 O/VoV4zPeZVgkXCqAQIK6oosFWbE9JdJ6+9Zt5rbwbhyPJhhQUL++rgB0spw/XwjX+
	 z3WD7d4hHPJdQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DBACD11DB;
	Tue, 26 Mar 2024 09:20:41 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Tue, 26 Mar 2024 12:18:45 +0300
Subject: [PATCH v9 18/38] dt-bindings: mtd: Add ts7200 nand-controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-ep93xx-v9-18-156e2ae5dfc8@maquefel.me>
References: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
In-Reply-To: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
Cc: linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711444837; l=1633;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=bq2OLT9jIJx+y3Eu11Bq5qmV15g39ulN9ve41TDPTOE=;
 b=HDCeJdytsWnVI88zE++qKwX81j74oy2uCbPZ6UaMYOAVJiHYoTV3JPTqNgnYv01GkUTbTXf/H+AT
 ++QPQqZPBHtuWuM72zrnsPACvwLBK1m+Rf5J+rKbvVrn6Eewuy5+
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718
 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: nikita.shubin@maquefel.me

From: Nikita Shubin <nikita.shubin@maquefel.me>

Add YAML bindings for ts7200 NAND Controller.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 .../devicetree/bindings/mtd/technologic,nand.yaml  | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/technologic,nand.yaml b/Documentation/devicetree/bindings/mtd/technologic,nand.yaml
new file mode 100644
index 000000000000..f9d87c46094b
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/technologic,nand.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/technologic,nand.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Technologic Systems NAND controller
+
+maintainers:
+  - Nikita Shubin <nikita.shubin@maquefel.me>
+
+allOf:
+  - $ref: nand-controller.yaml
+
+properties:
+  compatible:
+    oneOf:
+      - const: technologic,ts7200-nand
+      - items:
+          - enum:
+              - technologic,ts7300-nand
+              - technologic,ts7260-nand
+              - technologic,ts7250-nand
+          - const: technologic,ts7200-nand
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    nand-controller@60000000 {
+        compatible = "technologic,ts7200-nand";
+        reg = <0x60000000 0x8000000>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        nand@0 {
+           reg = <0>;
+        };
+    };

-- 
2.41.0



