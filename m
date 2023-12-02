Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A014801A8D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 05:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjLBESL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 23:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLBESK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 23:18:10 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B083F4;
        Fri,  1 Dec 2023 20:18:16 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-423c28db22eso32820111cf.1;
        Fri, 01 Dec 2023 20:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701490695; x=1702095495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ryqd5leIKr5+NNpeF4ac+2UCs1R3lcQgyQmfCPYM6S0=;
        b=J/CdPO14apGG+XvDkfM7z1MSYysQjxBFk/BPtQ6K9FLBJC7oXti6377GYVd0Aw8XpR
         3ndU0mF8XOvk6kBXMVdbp9Uot9tqrzFSsDPztOXZ5mtORGB4cqYJOUXrxYP+K5xM/X+S
         qy3zeLuSBTxu0IluP94TQMR2xoqIbrMaajwRn5kZNl66Z1BNUWS/jGyENd9GkoTsXy5d
         6QcySqy4tFfYTNUd8VFcw4ByNaHj6JTsaayD12TWij1RcM2fdKnD9DRdrV7T2HrPyFnT
         z8tKCk2nhYjfIG1ZinvITmtF9ULBqak3+ArAb0ceYReIo6l/57bT0Pkro9wqKoe23LnT
         Zu2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701490695; x=1702095495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ryqd5leIKr5+NNpeF4ac+2UCs1R3lcQgyQmfCPYM6S0=;
        b=doXAjFoT18QWjM+HFIVS8a1oNj1gQBwm5/L7hGnYKvHUUDdTjZWLH5gf3fNMkXNrb4
         dSHeJesDDpyqiKZSYVLt12bXqyrzlztqzPz5s2CkNR2NsC504oe5sCCxMPvs4rCBs4sx
         YQq8KnRYqk8DNtA5hbPbSlb5PNqzAYTwsqCJXXmHFph1vJg0sJdFrsCYr4btbVHfMHen
         B+GYh35izZ3DzPN6OGtlqlXINZVShyZ+ra4jcOXSgbTTTdNIbEKRzUnFMWkSrI1BoEaC
         NXEpm1g63XQh3ySi8VrS28ftMs6lsL/k5nuaq3LR7MtBj15zoUIeeT8JuKOspnuNbWDg
         fQ+g==
X-Gm-Message-State: AOJu0Yw0IleKmxnxC2BybdAbFxcHr5ASFZjmkO3qlbvgETFCdl5n2Xbv
        hxL2AR4BmHohdQ+8S17TqERzIIYx4J+SYg==
X-Google-Smtp-Source: AGHT+IFqWotGFJaGkri10tZxbhpe2dQW+V6yv+vv3wEtcjJ10c72TVsKjtr/YhPP96c/L4yAipkAHQ==
X-Received: by 2002:a05:622a:514:b0:423:7255:3c7e with SMTP id l20-20020a05622a051400b0042372553c7emr861798qtx.17.1701490695022;
        Fri, 01 Dec 2023 20:18:15 -0800 (PST)
Received: from localhost.localdomain (bras-base-ktnron0692w-grc-13-174-95-13-129.dsl.bell.ca. [174.95.13.129])
        by smtp.gmail.com with ESMTPSA id g11-20020ac84dcb000000b0041818df8a0dsm2101485qtw.36.2023.12.01.20.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 20:18:14 -0800 (PST)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     jic23@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     robh+dt@kernel.org, lars@metafoo.de, conor+dt@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <alkuor@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: iio: temperature: Add AMS AS6200
Date:   Fri,  1 Dec 2023 23:16:50 -0500
Message-Id: <20231202041651.719963-1-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

as6200 is high accuracy temperature sensor of -/+ 0.4C degree
with a range between -40C to 125C degrees

Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
---
Changes in v2:
  - Add vdd-supply

 .../bindings/iio/temperature/ams,as6200.yaml  | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/ams,as6200.yaml

diff --git a/Documentation/devicetree/bindings/iio/temperature/ams,as6200.yaml b/Documentation/devicetree/bindings/iio/temperature/ams,as6200.yaml
new file mode 100644
index 000000000000..a1817795cdca
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/ams,as6200.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/temperature/ams,as6200.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMS AS6200 Temperature Sensor
+
+maintainers:
+  - Abdel Alkuor <alkuor@gmail.com>
+
+description: |
+  https://ams.com/documents/20143/36005/AS6200_DS000449_4-00.pdf
+
+properties:
+  compatible:
+    const: ams,as6200
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        temperature-sensor@48 {
+            compatible = "ams,as6200";
+            reg = <0x48>;
+            vdd-supply = <&vdd>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <17 IRQ_TYPE_EDGE_BOTH>;
+        };
+    };
+...
-- 
2.34.1

