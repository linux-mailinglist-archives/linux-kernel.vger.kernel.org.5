Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E55D7C6BDD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378165AbjJLLD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347210AbjJLLDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:03:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CBBE9;
        Thu, 12 Oct 2023 04:03:17 -0700 (PDT)
Received: from localhost (dynamic-002-247-255-251.2.247.pool.telefonica.de [2.247.255.251])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BD5CA6607342;
        Thu, 12 Oct 2023 12:03:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697108596;
        bh=3IBNmgNSjLBe+41FoTO/Yu/kCxc8MxQ85xcHsJpioWg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=LzxB/ajIMQSfxtNw8E2NI2uITSgDafgG+P0IAZ519x9yks79zFo18yKnPU0/EUCSa
         jLeajxYV7sKlIGaIh8QqfBJuy4cY6wi9zY5pfM4EOszNRyJH2PwPiKHhmch3QMN0yq
         uNNCC4PvhtDTIIrSmZmrvqDGLLGFYFis2EGWK82efa+BaOlkmHPi6a/XpuOGGlpKJ7
         FEJ4wMvtAD2d2BL0dXaNcPI3yMvfARUGU6OEuRY7zxmMQXD+PPq2ZgivwzYZE9FjI9
         OV/u11oIgOfzCusdz+YWENBPUnzvXw40i4S5W8FsC24BEzMaSSOpT2LdNaQBYFVF2x
         5l0Sl7K0wX+6g==
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
Date:   Thu, 12 Oct 2023 13:01:04 +0200
Subject: [PATCH v13 6/8] media: dt-bindings: wave5: add Chips&Media 521c codec
 IP support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230929-wave5_v13_media_master-v13-6-5ac60ccbf2ce@collabora.com>
References: <20230929-wave5_v13_media_master-v13-0-5ac60ccbf2ce@collabora.com>
In-Reply-To: <20230929-wave5_v13_media_master-v13-0-5ac60ccbf2ce@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jackson Lee <jackson.lee@chipsnmedia.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nas Chung <nas.chung@chipsnmedia.com>,
        Fabio Estevam <festevam@gmail.com>
Cc:     linux-media@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        linux-kernel@vger.kernel.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        kernel@collabora.com, Robert Beckett <bob.beckett@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Darren Etheridge <detheridge@ti.com>
X-Mailer: b4 0.11.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697108536; l=1984;
 i=sebastian.fricke@collabora.com; s=linux-media; h=from:subject:message-id;
 bh=k/Ho+ZvJoCouf5wFCVjx83CbzUbCzzLnzkHkqDw/UIo=;
 b=pvcmVfRNEaByRT0iocDsV6kYIBaV58qwnc8SsnVCzM20tcbC1t+uw1duNDMYcV1UrojKQNC7R2wD
 /14WSznQCK5c2lugQYzV9ytiiMrf/jWtb/gfejT4z0GZsu0NlHe0
X-Developer-Key: i=sebastian.fricke@collabora.com; a=ed25519;
 pk=pYXedPwrTtErcj7ERYeo/IpTrpe4QbJuEzSB52fslBg=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Beckett <bob.beckett@collabora.com>

Add bindings for the chips&media wave5 codec driver

Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
---
 .../devicetree/bindings/media/cnm,wave5.yaml       | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/cnm,wave5.yaml b/Documentation/devicetree/bindings/media/cnm,wave5.yaml
new file mode 100644
index 000000000000..b31d34aec05b
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/cnm,wave5.yaml
@@ -0,0 +1,60 @@
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
+description:
+  The Chips&Media WAVE codec IP is a multi format video encoder/decoder
+
+properties:
+  compatible:
+    enum:
+      - cnm,cm521c-vpu
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
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    vpu: video-codec@12345678 {
+        compatible = "cnm,cm521c-vpu";
+        reg = <0x12345678 0x1000>;
+        clocks = <&clks 42>;
+        interrupts = <42>;
+        sram = <&sram>;
+    };

-- 
2.25.1
