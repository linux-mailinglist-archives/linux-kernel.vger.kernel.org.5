Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA08768745
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 21:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjG3TDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 15:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjG3TDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 15:03:07 -0400
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BE9A8;
        Sun, 30 Jul 2023 12:03:00 -0700 (PDT)
Received: from localhost.localdomain (unknown [109.229.201.16])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 8427A160182;
        Sun, 30 Jul 2023 21:02:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1690743778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6I5dY1NDAxP3uueqRntXqaNhJKdf+j54GnkWtVAQikQ=;
        b=hFrusvsMKQ98O5mhlAvxGyQOMQ7JGoQZt0fCOPWSGpBRTjbb4p78UFG8U9uHSUn/QLMn69
        Upn62YFUYCWRyGjJ7mVRZUlxCQYX/wcC0lhJbOgRwiP33dxhwFkfljjX3sWUvQ3xPw2KML
        i5QePacRD2EVHePQW15ipRsd5QadHOk=
From:   David Heidelberg <david@ixit.cz>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, - <kernel@puri.sm>
Cc:     =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        David Heidelberg <david@ixit.cz>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] dt-bindings: sound: gtm601: convert to YAML
Date:   Sun, 30 Jul 2023 22:02:41 +0300
Message-Id: <20230730190243.113105-1-david@ixit.cz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_DYNAMIC,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert GTM601 binding to the YAML format.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
v3:
 - incorporated feedback from Krzysztof
v2:
 - add #sound-dai-cells
 - put kernel@puri.sm into maintainers

 .../devicetree/bindings/sound/gtm601.txt      | 19 ----------
 .../bindings/sound/option,gtm601.yaml         | 37 +++++++++++++++++++
 2 files changed, 37 insertions(+), 19 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/gtm601.txt
 create mode 100644 Documentation/devicetree/bindings/sound/option,gtm601.yaml

diff --git a/Documentation/devicetree/bindings/sound/gtm601.txt b/Documentation/devicetree/bindings/sound/gtm601.txt
deleted file mode 100644
index efa32a486c4a..000000000000
--- a/Documentation/devicetree/bindings/sound/gtm601.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-GTM601 UMTS modem audio interface CODEC
-
-This device has no configuration interface. The sample rate and channels are
-based on the compatible string
-	"option,gtm601" = 8kHz mono
-	"broadmobi,bm818" = 48KHz stereo
-
-Required properties:
-
-  - compatible : one of
-	"option,gtm601"
-	"broadmobi,bm818"
-
-
-Example:
-
-codec: gtm601_codec {
-	compatible = "option,gtm601";
-};
diff --git a/Documentation/devicetree/bindings/sound/option,gtm601.yaml b/Documentation/devicetree/bindings/sound/option,gtm601.yaml
new file mode 100644
index 000000000000..9a70d20eb30d
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/option,gtm601.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/option,gtm601.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GTM601 UMTS modem audio interface CODEC
+
+maintainers:
+  - kernel@puri.sm
+
+description: >
+  This device has no configuration interface. The sample rate and channels are
+  based on the compatible string
+
+properties:
+  compatible:
+    oneOf:
+      - items:  # 48 kHz stereo
+          - const: broadmobi,bm818
+          - const: option,gtm601
+      - const: option,gtm601  # 8 kHz mono
+
+  '#sound-dai-cells':
+    const: 0
+
+allOf:
+  - $ref: dai-common.yaml#
+
+additionalProperties: false
+
+examples:
+  - |
+    codec {
+        compatible = "option,gtm601";
+        #sound-dai-cells = <0>;
+    };
-- 
2.40.1

