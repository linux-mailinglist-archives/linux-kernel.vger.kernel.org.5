Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA7B7761C4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbjHINyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjHINyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:54:49 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638052108;
        Wed,  9 Aug 2023 06:54:47 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 379C2kWv024607;
        Wed, 9 Aug 2023 08:54:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=JB0AZ/AXR8/rd/bfazMug5AWdtpOlH1XPhUoSyJ8lWA=; b=
        UjTM4QRFg2nM7SHoJsSIBsO528fO3R0QBeNbGcj/EE6JPM6TqwUDVnoLdtEic99M
        wLdDgrDL4AZGk6ii28/bOSni5j04UMYEGWqUCbv4z31aQGZobxTx307xFCJ1EM6E
        6sfS7KMErdcvMtNnhAyRn08weZI4/Q7oY+K9CYmnEegCZXJlvPs3/Gvnr/WhVTeM
        gsUY94fQdBO788jVU7yYJRXonbUmhErTqLEZMpDT2L4udoAuBW6Hb0GzCFUE7jRd
        KAjkKAwLOScdAgEey/wKG55PsrYOp0d+k9NoeMGhCASvnaoV8ZLosVtWj5zWKw7R
        4blUsOSZnx/QNKto5+s0nw==
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3s9juhur4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 08:54:10 -0500 (CDT)
Received: from m0077474.ppops.net (m0077474.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.22/8.17.1.22) with ESMTP id 379DnVJH001955;
        Wed, 9 Aug 2023 08:54:09 -0500
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3s9juhur4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 08:54:09 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 9 Aug
 2023 14:54:08 +0100
Received: from aus-sw-rshr002.ad.cirrus.com (141.131.215.158) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30 via Frontend Transport; Wed, 9 Aug 2023 14:54:08 +0100
Received: by aus-sw-rshr002.ad.cirrus.com (Postfix, from userid 46936)
        id 3A2594C0CD1; Wed,  9 Aug 2023 13:54:07 +0000 (UTC)
From:   James Ogletree <james.ogletree@cirrus.com>
To:     <dmitry.torokhov@gmail.com>
CC:     James Ogletree <james.ogletree@cirrus.com>,
        Fred Treven <fred.treven@cirrus.com>,
        Ben Bright <ben.bright@cirrus.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Lee Jones" <lee@kernel.org>, Eddie James <eajames@linux.ibm.com>,
        Jacky Bai <ping.bai@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        Jeff LaBundy <jeff@labundy.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Jean Delvare" <jdelvare@suse.de>, Joel Stanley <joel@jms.id.au>,
        <patches@cirrus.com>, <linux-input@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: input: cirrus,cs40l50: Support for CS40L50
Date:   Wed, 9 Aug 2023 13:53:09 +0000
Message-ID: <20230809135313.731706-2-james.ogletree@cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230809135313.731706-1-james.ogletree@cirrus.com>
References: <20230809135313.731706-1-james.ogletree@cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: beVh5qQetXHHil0yygJ6wSwAODfQ_9CY
X-Proofpoint-ORIG-GUID: bDajHZhNjbklE4dPlNtzoXg51lZi0k5R
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce device tree bindings for the initial commit
of the CS40L50 driver.

Signed-off-by: James Ogletree <james.ogletree@cirrus.com>
---
 .../bindings/input/cirrus,cs40l50.yaml        | 77 +++++++++++++++++++
 MAINTAINERS                                   |  9 +++
 2 files changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/cirrus,cs40l50.yaml

diff --git a/Documentation/devicetree/bindings/input/cirrus,cs40l50.yaml b/Documentation/devicetree/bindings/input/cirrus,cs40l50.yaml
new file mode 100644
index 000000000000..5437c6beb1b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/cirrus,cs40l50.yaml
@@ -0,0 +1,77 @@
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
+  CS40L50 is a Haptic Driver with Waveform Memory DSP
+  and Closed-Loop Algorithms
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
+  VA-supply:
+    description: Regulator for analog voltage
+
+  VP-supply:
+    description: Regulator for peak voltage
+
+  VIO-supply:
+    description: Regulator for digital IO voltage
+
+  cirrus,external-boost:
+    description:
+      Bypass the CS40L50 boost converter.
+
+      The amplifier on CS40L50 can be powered internally through the boost
+      converter, or else can be powered using an external supply. If an
+      external VA supply is used, the boost converter must be bypassed.
+    type: boolean
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - reset-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/input/input.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      cs40l50@34 {
+        compatible = "cirrus,cs40l50";
+        reg = <0x34>;
+        interrupt-parent = <&gpio>;
+        interrupts = <113 IRQ_TYPE_LEVEL_LOW>;
+        reset-gpios = <&gpio 112 GPIO_ACTIVE_LOW>;
+        VA-supply = <&dummy_vreg>;
+        VP-supply = <&dummy_vreg>;
+        VIO-supply = <&dummy_vreg>;
+        cirrus,external-boost;
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 54ef320bb689..016e5ff3b831 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2081,6 +2081,15 @@ F:	arch/arm/boot/compressed/misc-ep93xx.h
 F:	arch/arm/mach-ep93xx/
 F:	drivers/iio/adc/ep93xx_adc.c
 
+CIRRUS LOGIC HAPTICS DRIVER
+M:	James Ogletree <james.ogletree@cirrus.com>
+M:	Fred Treven <fred.treven@cirrus.com>
+M:	Ben Bright <ben.bright@cirrus.com>
+L:	patches@Qopensource.cirrus.com
+S:	Supported
+T:	git https://github.com/CirrusLogic/linux-drivers.git
+F:	Documentation/devicetree/bindings/input/cirrus,cs40l50.yaml
+
 ARM/CLKDEV SUPPORT
 M:	Russell King <linux@armlinux.org.uk>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.25.1

