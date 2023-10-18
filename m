Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7B67CDBAC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbjJRMat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjJRMao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:30:44 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721B5A3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:30:42 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-5079f9ec8d9so5632787e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697632240; x=1698237040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hh0PaWeJhjip73nWeEJkqyL1aarHHe29wL5yfGX2sZg=;
        b=nrN5sCd9blvWho2Zh7jIZyxwZau6StAA3DM6Y8YGVL4w45W/M7hO2UaF/uJoCszaRm
         VsUQQHLeh0A3SlGlUohbxgjIU2j/Pd3xoBiKbfD6PwufQXn8ttaKjZeAY+wMyXOETIw+
         dXMC+boZeilakbZViF6rpVLWwOeMuwrM61rcAWVTNWq+i8Og2OZ7xsickJdeqzEIOQxg
         cshSAl+F6rVG6kskl2UBYnPMR8I5VcgbazW37XgD7V4lVskOwX1Tqke1Mxn2AiDnzn+X
         FadT8mEQJvtakhdxut6sZhZDtxRtAeMFSFr/o4lQvxIaR25xZ14C0erwDIgPJtdV+8r8
         Qkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697632240; x=1698237040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hh0PaWeJhjip73nWeEJkqyL1aarHHe29wL5yfGX2sZg=;
        b=k4+KHpiFEhaeZpJzrC7rCQw82zWRJengcEcFNU71GIh4K7gfx+M4xRH/x7ZD3vKrsq
         fmA3Ccg2xCZKq7LMBSjfMk6aOMxaA2Aj9S0PlS0kllASJWxb29SfMlflXpq5KUBiHHYG
         nwD3U61xroM0iF9d+s4IjOmEFmu5haTaWpSprHm1raLA7UzMVf69kj8brfZDlyE6uMPR
         866Ylhvh5upgQJQ+cOmSIUTWahDy6pebmvPVNFxlGTGyfdhIOQXedNozRdhLCzkOLEuK
         7Jdeb5T8UqET9YAMF86PGgRVxARnY7zP51P+kGxzp/4zkLskLU2eN2y1E6M+UaOoSqMR
         u/BA==
X-Gm-Message-State: AOJu0YwJm6bUht2uiiP/Bu1ziBVbXyv6lAYOtHxFOuYn6CkvfjlXbhYl
        PBmP/+MfYhFbnB9WQkSXHA3K+TLcab4=
X-Google-Smtp-Source: AGHT+IFhyR75sMhnTf2dJcPvFjgXUJkqOXxVEphSoCbAsmcTjWkSbRayCyFyqpbmIJUS6H/3AvCJrA==
X-Received: by 2002:a05:6512:b96:b0:504:879c:34ac with SMTP id b22-20020a0565120b9600b00504879c34acmr1893482lfv.31.1697632240245;
        Wed, 18 Oct 2023 05:30:40 -0700 (PDT)
Received: from debian.localdomain (mm-47-218-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.218.47])
        by smtp.googlemail.com with ESMTPSA id t8-20020ac243a8000000b005009b4d5c14sm679565lfl.265.2023.10.18.05.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:30:40 -0700 (PDT)
From:   Dzmitry Sankouski <dsankouski@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH 1/6] dt-bindings: regulator: add Samsung s2dos05 pmic
Date:   Wed, 18 Oct 2023 15:30:28 +0300
Message-Id: <20231018123033.301005-2-dsankouski@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231018123033.301005-1-dsankouski@gmail.com>
References: <20231018123033.301005-1-dsankouski@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for the s2dos05 pmic found in the Samsung S9.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---

 .../bindings/regulator/samsung,s2dos05.yaml   | 89 +++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/samsung,s2dos05.yaml

diff --git a/Documentation/devicetree/bindings/regulator/samsung,s2dos05.yaml b/Documentation/devicetree/bindings/regulator/samsung,s2dos05.yaml
new file mode 100644
index 000000000000..b53d9f5a7d38
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/samsung,s2dos05.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/samsung,s2dos05.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung s2dos05 regulator
+
+maintainers:
+  - Dzmitry Sankouski <dsankouski@gmail.com>
+
+description: |
+  The S2DOS05 is a companion power management IC for the smart phones.
+  Has 4 LDO and 1 BUCK regulators, and has capability to measure
+  current and power. Can detect short circuit on outputs.
+
+properties:
+  compatible:
+    const: samsung,s2dos05pmic
+  reg:
+    maxItems: 1
+
+  regulators:
+    type: object
+    description: List of regulators and its properties
+
+    patternProperties:
+      "^s2dos05-buck1|s2dos05-ldo[1-4]$":
+        type: object
+        $ref: "regulator.yaml#"
+        unevaluatedProperties: false
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
+    regulator@60 {
+    	compatible = "samsung,s2dos05pmic";
+    	reg = <0x60>;
+    	pinctrl-names = "default";
+    	pinctrl-0 = <&s2dos05_irq>;
+    	s2dos05,s2dos05_int = <&tlmm 0x31 0x0>;
+
+    	regulators {
+    		s2dos05_ldo1: s2dos05-ldo1 {
+    			regulator-name = "s2dos05-ldo1";
+    			regulator-min-microvolt = <0x16e360>;
+    			regulator-max-microvolt = <0x1e8480>;
+    			regulator-active-discharge = <0x1>;
+    		};
+
+    		s2dos05_ldo2: s2dos05-ldo2 {
+    			regulator-name = "s2dos05-ldo2";
+    			regulator-min-microvolt = <0x1b7740>;
+    			regulator-max-microvolt = <0x1b7740>;
+    			regulator-active-discharge = <0x1>;
+    			regulator-boot-on;
+    		};
+
+    		s2dos05_ldo3: s2dos05-ldo3 {
+    			regulator-name = "s2dos05-ldo3";
+    			regulator-min-microvolt = <0x2dc6c0>;
+    			regulator-max-microvolt = <0x2dc6c0>;
+    			regulator-active-discharge = <0x1>;
+    			regulator-boot-on;
+    		};
+
+    		s2dos05_ldo4: s2dos05-ldo4 {
+    			regulator-name = "s2dos05-ldo4";
+    			regulator-min-microvolt = <0x2932e0>;
+    			regulator-max-microvolt = <0x399a18>;
+    			regulator-active-discharge = <0x1>;
+    		};
+
+    		s2dos05_buck1: s2dos05-buck1 {
+    			regulator-name = "s2dos05-buck1";
+    			regulator-min-microvolt = <0xcf850>;
+    			regulator-max-microvolt = <0x200b20>;
+    			regulator-active-discharge = <0x1>;
+    		};
+    	};
+    };
-- 
2.39.2

