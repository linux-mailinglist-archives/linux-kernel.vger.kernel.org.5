Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55729786E1C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 13:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238203AbjHXLjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 07:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241147AbjHXLjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:39:12 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12242198B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 04:39:10 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31aeee69de0so4393517f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 04:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1692877148; x=1693481948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F8P8h3nZuVSVyj4+1oLgR8uo687zytcW2n1CdZ9Cvp4=;
        b=TaXnMwAipQl3FDvx2v1/DbaxVtjE3A/eB5CBfKB38sg72oYcfyjq75HBS33XXqBjgg
         tBsao8CZHboV9r7Ny1vCuBTDaW8YhKOYpCg56SwTOmXMA9WC1UDSe+JuAcinEA05OtYT
         q+d9Pwe6jlVLatppHx8xpCz2fhaKbQAwez4YmAZUCfalzDhmupJ9dXX47nnoeYk6HBrH
         zGU0CF18t6QG0NbhVawJ87iAs+6gTWNf1GLzOPT8NpHI2/P3fRPPgEwtlIstQGH8m3+5
         MbCJjI0g6GZHl/ZAS+z6v7YhStvYy32PAKtEwb84X5XGtTD9x6b2tNjJODQjRKDCz4qF
         6O4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692877148; x=1693481948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F8P8h3nZuVSVyj4+1oLgR8uo687zytcW2n1CdZ9Cvp4=;
        b=cVaGpNGpyeidvFcDMIdvVxLiA3yQoUfW0M/79edhBX/awOZIB9ooo44Mub/ojgqfpR
         tuwbf1CGOJXlW6qxW0ntVP/GROzBKRZBYOFVrg5Zhd3MS1d6fYP2vTVkElVnz94QhSK9
         nRFYPBYr0MeD4uv0nkbxKo7r5N4TEzoLHak1AkDIlWlO5fhb7v17dapkxPZN3wRPtUtO
         rW6gP0vI8WcWjCZpvXbDyqXMUp8K9L2JM8mnB+XJmGuoSKYhQTTfeXnetH5ujYvp3cMf
         Dk2LpaeHGbsNRvoEdURAFukMA+q57ZV63RmyZyMXHk9Wto1yq3/2KbOD9z9GU2hRGgmm
         4KkQ==
X-Gm-Message-State: AOJu0YypevIQnKziMDvH0kMLur/5ba3KPhDjMHSAxbTpeqDu8lUXyIxB
        r5y1QzB7ADjSe5E2bUWXfYYa7A==
X-Google-Smtp-Source: AGHT+IF81gViUrBXZpO/eI+tSgih9Hhazl+rE2J3yHY4GJVD2gcN8W/qC95hqZOUuj7uCt9GFQVlUg==
X-Received: by 2002:adf:fed1:0:b0:317:5b5f:2328 with SMTP id q17-20020adffed1000000b003175b5f2328mr13269744wrs.24.1692877148524;
        Thu, 24 Aug 2023 04:39:08 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id n16-20020adfe790000000b003188358e08esm21887650wrm.42.2023.08.24.04.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 04:39:08 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] dt-bindings: hwmon: Add MAX6639
Date:   Thu, 24 Aug 2023 13:39:00 +0200
Message-ID: <20230824113901.2601238-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcello Sylvester Bauer <sylv@sylv.io>

Add binding documentation for Maxim MAX6639 fan-speed controller.

Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
Changes in V4:
- Drop property pulses-per-revolution
Changes in V3:
- Update title
- Add pulses-per-revolution, supplies & interrupts
Changes in V2:
- Update subject
- Drop blank lines
---
 .../bindings/hwmon/maxim,max6639.yaml         | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
new file mode 100644
index 000000000000..9c06a61d57c9
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/maxim,max6639.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX6639 Fan Controller
+
+maintainers:
+  - Naresh Solanki <Naresh.Solanki@9elements.com>
+
+description: |
+  The MAX6639 is a 2-channel temperature monitor with dual, automatic, PWM
+  fan-speed controller.  It monitors its own temperature and one external
+  diode-connected transistor or the temperatures of two external diode-connected
+  transistors, typically available in CPUs, FPGAs, or GPUs.
+
+  Datasheets:
+    https://datasheets.maximintegrated.com/en/ds/MAX6639-MAX6639F.pdf
+
+properties:
+  compatible:
+    enum:
+      - maxim,max6639
+
+  reg:
+    maxItems: 1
+
+  fan-supply:
+    description: Phandle to the regulator that provides power to the fan.
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      fan-controller@10 {
+        compatible = "maxim,max6639";
+        reg = <0x10>;
+      };
+    };
+...

base-commit: cb7022b8976e3c4d12cea2e7bb820a2944e2fd7b
-- 
2.41.0

