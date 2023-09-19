Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9D97A5D6B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjISJIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjISJH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:07:56 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8B7E6;
        Tue, 19 Sep 2023 02:07:49 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c3d8fb23d9so42663215ad.0;
        Tue, 19 Sep 2023 02:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695114469; x=1695719269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NnhRGqMKJY6uMT0U4qJtmaqTBOCE6EUZnss064Sq+3E=;
        b=mFcNQGM7cJz+AeFQOXb4rNlysgvdRRgoownW0fa2nXc7e9SiwvsPhuzXw0OYFdUpdk
         lvdprzDb+DNNvcfXN+BlouEMwzHHGrax0vP7N9BrtUHIHPVHnDC/FAt5T1DWNXU9KNoZ
         EEVERZ6MoNtTRxmqmGxY20uo2KN2xqTbFT4Ui3q82aBJxWIqVID9hTIIaaH2Z9f92LGW
         MovXgxgvF3x16VKytKQrNJqThr/NO2ggnoCa/SO4P3KdtrSs/PPzRu7/QFoUCioovDrI
         W9LKNlYM8AMkYMyHt2y+25FJoJ4h0bm2QQHNY7FgrOEVfdW+ED3RWqTu3YYeOb3sT7K5
         WDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695114469; x=1695719269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NnhRGqMKJY6uMT0U4qJtmaqTBOCE6EUZnss064Sq+3E=;
        b=EQPi1AVom3aDBXteeJpgbOP+UsoxUv0W65cqzViq7maqfjBPB55mfPDjB8PUXi2dAR
         rByxTyDBKM9FFGRd2+3zpy83Gc0I7uq0t6FdBZ9HSXkq/JFWCnAr0afdCi3ukVOBLCyr
         bXJWyI1qTL0T6v8WoyePKkGxKyYJqRgnvcvc/IO00g3LrCVLs8W++hqQiq+VOtovYmR1
         6b6RGHC+h0Ak8kaUqnGTWWeSPSLOihzn1hmyJrFiRv6WFfZ45YqyTxa69CbKpnfvWs/b
         pv7F8SwPZQz+/Tgs9BKQPw2bqCFGKfv2LwjAHl3a/Rf6IZesoEzo/ypaUpQNdNEU2AKC
         Etpw==
X-Gm-Message-State: AOJu0YyMuGTlwed/KCn8cws6bHWdC2Z94Hqzy5m0vhhG8BVU7Vus949y
        g5uSiMdkO5p9sHS/knN5TV6IfGzk+Iw=
X-Google-Smtp-Source: AGHT+IGzObmJ/bbdrcKjNOqflSJNm5msY4VALGTtgmzd+ZHM9rWYiThmYNqGyN+is5H/DLJFRS9zLA==
X-Received: by 2002:a17:902:f68b:b0:1b7:e86f:7631 with SMTP id l11-20020a170902f68b00b001b7e86f7631mr12437557plg.19.1695114469235;
        Tue, 19 Sep 2023 02:07:49 -0700 (PDT)
Received: from brag-vm.localdomain ([117.243.68.251])
        by smtp.gmail.com with ESMTPSA id p6-20020a170902a40600b001bf00317a49sm9582411plq.104.2023.09.19.02.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 02:07:48 -0700 (PDT)
From:   Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: tfa9879: Convert to dtschema
Date:   Tue, 19 Sep 2023 14:37:39 +0530
Message-Id: <20230919090739.2448-1-bragathemanick0908@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the tfa9879 audio CODEC bindings to DT schema

Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
---
 .../bindings/sound/nxp,tfa9879.yaml           | 45 +++++++++++++++++++
 .../devicetree/bindings/sound/tfa9879.txt     | 23 ----------
 2 files changed, 45 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/nxp,tfa9879.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/tfa9879.txt

diff --git a/Documentation/devicetree/bindings/sound/nxp,tfa9879.yaml b/Documentation/devicetree/bindings/sound/nxp,tfa9879.yaml
new file mode 100644
index 000000000000..792494f4a2dd
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nxp,tfa9879.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/nxp,tfa9879.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP TFA9879 class-D audio amplifier
+
+maintainers:
+  - Peter Rosin <peda@axentia.se>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: nxp,tfa9879
+
+  reg:
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - '#sound-dai-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c1 {
+       #address-cells = <1>;
+       #size-cells = <0>;
+       amp: amp@6c {
+          compatible: "nxp,tfa9879";
+          reg: <0x6c>;
+          "#sound-dai-cells": <0>;
+          pinctrl-names: "default";
+          pinctrl-0: <&pinctrl_i2c1>;
+       };
+    };
+
diff --git a/Documentation/devicetree/bindings/sound/tfa9879.txt b/Documentation/devicetree/bindings/sound/tfa9879.txt
deleted file mode 100644
index 1620e6848436..000000000000
--- a/Documentation/devicetree/bindings/sound/tfa9879.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-NXP TFA9879 class-D audio amplifier
-
-Required properties:
-
-- compatible : "nxp,tfa9879"
-
-- reg : the I2C address of the device
-
-- #sound-dai-cells : must be 0.
-
-Example:
-
-&i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c1>;
-
-	amp: amp@6c {
-		#sound-dai-cells = <0>;
-		compatible = "nxp,tfa9879";
-		reg = <0x6c>;
-	};
-};
-
-- 
2.34.1

