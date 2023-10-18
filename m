Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71CC7CE5A1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344713AbjJRR6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjJRR6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:58:00 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1726F1A5;
        Wed, 18 Oct 2023 10:57:55 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39I5YN73000966;
        Wed, 18 Oct 2023 12:57:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=H+80OU+pcRCGUJGQ7e1Oq+LdlTP+ByWSg2j/cCkDTOA=; b=
        em8qZT+/0ZN01Ykkg4/uAvcYopIy68gtIlo2kwn2BiMXERRqmCPJrovKK66oJ4cV
        Lv4s4YVx/Vz8m57pG7ppFoH3N5HbQB08uDp5H+zqGO/wG/rP0hM75IB6iZ6HEqsw
        pizkxzyVd04mWeeRr8vYb2sk8rgstq9zvtrVsb3qLEovveUPWBrwYhM7Sf9SU0Qe
        e6kt+7OUkQxoeoi9QrHQAvG7crPS33qFKRUYmHsSaarfMapVxoqV4o8OcbWWX7Ae
        NuDN43SU9ArDlrjlV7XlV7lvxqTPNKYEMNn448kJptwaY26JHfbsLMq/Y2VYfZKk
        +PdP5HeLCvZdrAW3IEQlbA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3tqrcw6n6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 12:57:45 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Wed, 18 Oct
 2023 18:57:42 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Wed, 18 Oct 2023 18:57:42 +0100
Received: from aus-sw-rshr002.ad.cirrus.com (aus-sw-rshr002.ad.cirrus.com [141.131.145.53])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6C23E458;
        Wed, 18 Oct 2023 17:57:41 +0000 (UTC)
From:   James Ogletree <james.ogletree@opensource.cirrus.com>
CC:     James Ogletree <james.ogletree@cirrus.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Fred Treven <fred.treven@cirrus.com>,
        Ben Bright <ben.bright@cirrus.com>,
        <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/4] dt-bindings: input: cirrus,cs40l50: Add initial DT binding
Date:   Wed, 18 Oct 2023 17:57:22 +0000
Message-ID: <20231018175726.3879955-2-james.ogletree@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231018175726.3879955-1-james.ogletree@opensource.cirrus.com>
References: <20231018175726.3879955-1-james.ogletree@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: sU0DX1RCCJ29jjm70lmFSYZjVuF3i3t5
X-Proofpoint-ORIG-GUID: sU0DX1RCCJ29jjm70lmFSYZjVuF3i3t5
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Ogletree <james.ogletree@cirrus.com>

The CS40L50 is a haptic driver with waveform memory,
integrated DSP, and closed-loop algorithms.

Add a YAML DT binding document for this device.

Signed-off-by: James Ogletree <james.ogletree@cirrus.com>
---
 .../bindings/input/cirrus,cs40l50.yaml        | 70 +++++++++++++++++++
 MAINTAINERS                                   |  8 +++
 2 files changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/cirrus,cs40l50.yaml

diff --git a/Documentation/devicetree/bindings/input/cirrus,cs40l50.yaml b/Documentation/devicetree/bindings/input/cirrus,cs40l50.yaml
new file mode 100644
index 000000000000..6a5bdafed56b
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/cirrus,cs40l50.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/cirrus,cs40l50.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic CS40L50 Advanced Haptic Driver
+
+maintainers:
+  - James Ogletree <james.ogletree@cirrus.com>
+
+description:
+  CS40L50 is a haptic driver with waveform memory,
+  integrated DSP, and closed-loop algorithms.
+
+properties:
+  compatible:
+    enum:
+      - cirrus,cs40l50
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  va-supply:
+    description: Power supply for internal analog circuits.
+
+  vp-supply:
+    description: Power supply for always-on circuits.
+
+  vio-supply:
+    description: Power supply for digital input/output.
+
+  vamp-supply:
+    description: Power supply for the Class D amplifier.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - reset-gpios
+  - vp-supply
+  - vio-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      haptic-driver@34 {
+        compatible = "cirrus,cs40l50";
+        reg = <0x34>;
+        interrupt-parent = <&gpio>;
+        interrupts = <113 IRQ_TYPE_LEVEL_LOW>;
+        reset-gpios = <&gpio 112 GPIO_ACTIVE_LOW>;
+        vp-supply = <&vreg>;
+        vio-supply = <&vreg>;
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 046ff06ff97f..28f0ca9324b3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4963,6 +4963,14 @@ F:	sound/pci/hda/cs*
 F:	sound/pci/hda/hda_cs_dsp_ctl.*
 F:	sound/soc/codecs/cs*
 
+CIRRUS LOGIC HAPTIC DRIVERS
+M:	James Ogletree <james.ogletree@cirrus.com>
+M:	Fred Treven <fred.treven@cirrus.com>
+M:	Ben Bright <ben.bright@cirrus.com>
+L:	patches@opensource.cirrus.com
+S:	Supported
+F:	Documentation/devicetree/bindings/input/cirrus,cs40l50.yaml
+
 CIRRUS LOGIC DSP FIRMWARE DRIVER
 M:	Simon Trimmer <simont@opensource.cirrus.com>
 M:	Charles Keepax <ckeepax@opensource.cirrus.com>
-- 
2.25.1

