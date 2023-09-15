Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000267A2924
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 23:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238019AbjIOVMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 17:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238027AbjIOVMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 17:12:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C01115;
        Fri, 15 Sep 2023 14:12:08 -0700 (PDT)
Received: from localhost (89-26-75-29.dyn.cablelink.at [89.26.75.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0D09966072A7;
        Fri, 15 Sep 2023 22:12:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694812327;
        bh=7Lxtjmk1/qRcWsB4o2wXEaxqVLu5DK3Ks2Ix8VDhYnY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=nXnu/kKBknnhxvjhroSt3laffiYwhM7aUrfg3UvC39Gyx6zpOMOwSXI4KGoo0YfFt
         tD9L6Lf+gEk1Eu8PtTt5cngU53auVkaNccb5NoQuc2ILCSc+fNrq8EU4S6w9TucYEE
         9cq6TlkI7CfAk7Lo+urJ63+r1YVBzNk6cmNTvu5L2YCztjr7MdotkDPzWiROVYtK0b
         2UqiAbCEvKQnvCFPd8GB4e/JqUTumxCGrdv50DQryN/mCsqfuRUndijJqAgcKARI42
         dbuf+AOaG2iAtZEZJWjfDPAfU9sy+vRYBg03nZMWmhi8ikMX2yywjLzpI0YQvb6nTy
         YDaL5zxPg9SZw==
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
Date:   Fri, 15 Sep 2023 23:11:35 +0200
Subject: [PATCH v12 6/7] dt-bindings: media: wave5: add yaml devicetree bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230915-wave5_v12_on_media_master-v12-6-92fc66cd685d@collabora.com>
References: <20230915-wave5_v12_on_media_master-v12-0-92fc66cd685d@collabora.com>
In-Reply-To: <20230915-wave5_v12_on_media_master-v12-0-92fc66cd685d@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nas Chung <nas.chung@chipsnmedia.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jackson Lee <jackson.lee@chipsnmedia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Conor Dooley <conor+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
X-Mailer: b4 0.11.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694812307; l=2098;
 i=sebastian.fricke@collabora.com; s=linux-media; h=from:subject:message-id;
 bh=esedjOY8SBHPSIyc227QY3kx3X1eSB383IkfTQhD+aI=;
 b=rxl3rh1h5yM8veA3az7YDZOlgIGzEGmEvbUNghxisJ6Z6Rq0IZUK95mgmMNscyxIHhXDvCw9pr0z
 wAVIpt68CUCtaFBmkGiUo+we7X2tcpyPT9p5C/yIL6mlPA5fXbCs
X-Developer-Key: i=sebastian.fricke@collabora.com; a=ed25519;
 pk=pYXedPwrTtErcj7ERYeo/IpTrpe4QbJuEzSB52fslBg=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Beckett <bob.beckett@collabora.com>

Add bindings for the wave5 chips&media codec driver

Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
---
 .../devicetree/bindings/media/cnm,wave5.yaml       | 66 ++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/cnm,wave5.yaml b/Documentation/devicetree/bindings/media/cnm,wave5.yaml
new file mode 100644
index 000000000000..b8f383621805
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/cnm,wave5.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/cnm,wave5.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Chips&Media Wave 5 Series multi-standard codec IP
+
+maintainers:
+  - Nas Chung <nas.chung@chipsnmedia.com>
+  - Jackson Lee <jackson.lee@chipsnmedia.com>
+
+description: |-
+  The Chips&Media WAVE codec IP is a multi format video encoder/decoder
+
+properties:
+  compatible:
+    enum:
+        - cnm,cm521c-vpu
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: VCODEC clock
+
+  clock-names:
+    items:
+      - const: vcodec
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
+
+    description:
+      The VPU uses the SRAM to store some of the reference data instead of
+      storing it on DMA memory. It is mainly used for the purpose of reducing
+      bandwidth.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    vpu: video-codec@12345678 {
+        compatible = "cnm,cm521c-vpu";
+        reg = <0x12345678 0x1000>;
+        interrupts = <42>;
+        clocks = <&clks 42>;
+        clock-names = "vcodec";
+        sram = <&sram>;
+    };

-- 
2.25.1
