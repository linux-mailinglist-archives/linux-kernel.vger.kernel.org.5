Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2317E5EA8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 20:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbjKHTaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 14:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbjKHTaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 14:30:00 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB0B212F;
        Wed,  8 Nov 2023 11:29:46 -0800 (PST)
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C455566076A1;
        Wed,  8 Nov 2023 19:29:44 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699471785;
        bh=+M/XFwuoS8Bp+9J2sOkehobAagQvw9CTARjex8BHNCs=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=n1BWT2jbUaPAY0BP3M0AZ0hAPX5a+/+o0zRirCzFHoDI41TL9HwTcTJnsl2jHTK37
         fmeVD0KHpxXQVrQ8TA5MDubFZbr0Gq9CCO7EupXzfIvkDzR+9+6D/Vc9A+LoMWL89k
         3zCnr3YHLQDyI/g7f8LSlSppqxzgTDBBvgvfHbeqPnKAVGj6FJ9W+KFxGvPyCv7k7c
         rc7aN2JjKZbmgYxSggCGzLBiqLxpLqt0ppAxjQ0JtKKcLfQd8wIGCV6+v9K+Et4eQH
         Up2BxG2vGMqEwBOAP+uy1QUUcRVJYXuWJJc4KRHi5fxAwutm3s8SgsnYhNGYKY58lY
         6e2rxO2C/0cKA==
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
Date:   Wed, 08 Nov 2023 20:29:25 +0100
Subject: [PATCH v14 6/8] dt-bindings: media: wave5: add yaml devicetree bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231108-wave5-v14-rebased-v14-6-0b4af1258656@collabora.com>
References: <20231108-wave5-v14-rebased-v14-0-0b4af1258656@collabora.com>
In-Reply-To: <20231108-wave5-v14-rebased-v14-0-0b4af1258656@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Conor Dooley <conor+dt@kernel.org>,
        Nas Chung <nas.chung@chipsnmedia.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jackson Lee <jackson.lee@chipsnmedia.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Ivan Bornyakov <brnkv.i1@gmail.com>,
        Deborah Brouwer <deborah.brouwer@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        devicetree@vger.kernel.org,
        Robert Beckett <bob.beckett@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
X-Mailer: b4 0.11.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699471762; l=2060;
 i=sebastian.fricke@collabora.com; s=linux-media; h=from:subject:message-id;
 bh=MTAjIh3c6yvf57nqbdf6r3Khe9NwAJmaJM3Z3pg51fU=;
 b=NYPN04rZKIGlDUZJTXnVo7K81Xx8x0TtifT41qQCuyHNPCTqhQnrQfmNc4XgcApvNqVdkdUWzfoB
 KTCZhXnRDlRHgxD2x4TH8gjSiZBPMecp7AX0zC4f/XzJfU9zgszf
X-Developer-Key: i=sebastian.fricke@collabora.com; a=ed25519;
 pk=pYXedPwrTtErcj7ERYeo/IpTrpe4QbJuEzSB52fslBg=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Beckett <bob.beckett@collabora.com>

Add bindings for the wave5 chips&media codec driver

Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
---
 .../devicetree/bindings/media/cnm,wave521c.yaml    | 61 ++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/cnm,wave521c.yaml b/Documentation/devicetree/bindings/media/cnm,wave521c.yaml
new file mode 100644
index 000000000000..6d5569e77b7a
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/cnm,wave521c.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/cnm,wave521c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Chips&Media Wave 5 Series multi-standard codec IP
+
+maintainers:
+  - Nas Chung <nas.chung@chipsnmedia.com>
+  - Jackson Lee <jackson.lee@chipsnmedia.com>
+
+description:
+  The Chips&Media WAVE codec IP is a multi format video encoder/decoder
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - ti,k3-j721s2-wave521c
+      - const: cnm,wave521c
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: VCODEC clock
+
+  interrupts:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  sram:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      The VPU uses the SRAM to store some of the reference data instead of
+      storing it on DMA memory. It is mainly used for the purpose of reducing
+      bandwidth.
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    vpu: video-codec@12345678 {
+        compatible = "ti,k3-j721s2-wave521c", "cnm,wave521c";
+        reg = <0x12345678 0x1000>;
+        clocks = <&clks 42>;
+        interrupts = <42>;
+        sram = <&sram>;
+    };

-- 
2.25.1
