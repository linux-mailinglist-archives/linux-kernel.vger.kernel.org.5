Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D00680713B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378642AbjLFNv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378509AbjLFNv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:51:56 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440F7D44;
        Wed,  6 Dec 2023 05:52:02 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id d9443c01a7336-1d0ccda19eeso11750645ad.1;
        Wed, 06 Dec 2023 05:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701870722; x=1702475522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lm+D5jKJ17HuWeeaSzfoieBbBFG7aIweWno7P45cPZU=;
        b=C6BuFcl3wnlf0GgKMlAhHqf3iVxS/XwSHI5485/K/M4FlDk1E9DnTUnOgSfWhTCLou
         Hfe8ofl2zm6gzw4jj7m7857a/WFNC6I8KNx+y6UyIILpoUf2W8eyRHctOjo8f6edk1Md
         dtz226NhCo1jdrXFMDm2gVkUmNHiOkp+9bzgorCIFbcFHI7hWPSl/8LLQ7ETF41TQcJF
         goJNrkFYkbaM/W3TJvH/wLMz7iHG1GnhdeVREBsLVbzsqnrUsRyDv2gVvJH6XWb73xPI
         rcYH8GyiP5A/P82pyUjPHgGWPVDE66E3EdflG2lSncU3h8UUUwVsFR4ty9toMLOu2bYV
         C6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701870722; x=1702475522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lm+D5jKJ17HuWeeaSzfoieBbBFG7aIweWno7P45cPZU=;
        b=bn7VLPzMQJG4CPfcSumsQ+GJFRKre2yKZxtJyaN+XDCADo3D4MJ8tdzqguINcZmgyf
         xg/TYHYl3mOLxqQ0oYR5buWZRYhVcoS2X6ncRnHvpl8iufzQ6LQRp1fNlVw0OsATGnkO
         FxU7wuZMOqXsVooIb4SldeSmzD/4IOLnAnWngxi+3xtIGuiFjKFUefY/I9PdIcCfeesG
         d7JQAdAXdrPw+qLvvq1zv7/kdYozjQVeQSczT8hDskifVWKDvJfx1rX8mQZK3ieSN4+y
         +oGa5oc0PBLDAs4CFt6SNm/axBoibbRN3Qw76WJD0dPzzaMmbdfjajeQa+I06ISusPfQ
         ddCw==
X-Gm-Message-State: AOJu0YziKsM5elM7kJVxlJi9INCyWmlDr+L0dJ8Wf2+DCSZJilgauK4C
        Pzl3knCf8a3JplUxu+D/IBM=
X-Google-Smtp-Source: AGHT+IHGSFwRWfYX+lMdYGWOxubT0DY/bPjf6h9lituNkPiE+Arv9DNEp8vfXIzXqoEDyKmciyIYlA==
X-Received: by 2002:a17:903:1250:b0:1d0:6ffe:1e81 with SMTP id u16-20020a170903125000b001d06ffe1e81mr638593plh.100.1701870721529;
        Wed, 06 Dec 2023 05:52:01 -0800 (PST)
Received: from dawn-virtual-machine.localdomain ([183.198.59.249])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902cec800b001d0af279a1fsm5122701plg.182.2023.12.06.05.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 05:52:00 -0800 (PST)
From:   Li peiyu <579lpy@gmail.com>
To:     jic23@kernel.org
Cc:     javier.carrasco.cruz@gmail.com, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li peiyu <579lpy@gmail.com>
Subject: [PATCH v4 4/4] iio: humidity: Add TI HDC302x support
Date:   Wed,  6 Dec 2023 21:51:48 +0800
Message-Id: <20231206135148.559564-1-579lpy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206134655.559474-1-579lpy@gmail.com>
References: <20231206134655.559474-1-579lpy@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for HDC3020/HDC3021/HDC3022 humidity and
temperature sensors.

Signed-off-by: Li peiyu <579lpy@gmail.com>
---
 .../bindings/iio/humidity/ti,hdc3020.yaml     | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml

diff --git a/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml b/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml
new file mode 100644
index 000000000000..f04b09fdca5e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/humidity/ti,hdc3020.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HDC3020/HDC3021/HDC3022 humidity and temperature iio sensors
+
+maintainers:
+  - Li peiyu <579lpy@gmail.com>
+  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
+
+description:
+  https://www.ti.com/lit/ds/symlink/hdc3020.pdf
+
+  The HDC302x is an integrated capacitive based relative humidity (RH)
+  and temperature sensor.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - ti,hdc3021
+              - ti,hdc3022
+          - const: ti,hdc3020
+      - items:
+          - const: ti,hdc3020
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply: true
+
+  reg:
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
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        humidity-sensor@47 {
+            compatible = "ti,hdc3021", "ti,hdc3020";
+            reg = <0x47>;
+            vdd-supply = <&vcc_3v3>;
+        };
+    };
-- 
2.34.1

