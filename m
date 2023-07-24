Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8484B75FAD1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 17:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjGXPcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 11:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGXPcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 11:32:23 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5151B3;
        Mon, 24 Jul 2023 08:32:21 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbc12181b6so43194705e9.2;
        Mon, 24 Jul 2023 08:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690212740; x=1690817540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TJ7QSuT9JWuSM03vOOl8cZyXJ2t2WtKznVcR/4lhGHU=;
        b=OSYHJkFkFwuVl3QaFLvyH/uqjdwvPLQtROyZjl7dyXKSNkPChyjZnI9lzAg73nVY4r
         xDPhq1tRgEQ9aQM43/vMgc3x6XbhM7cellZSn9FHRz1yrmGM3XrsZcfb4QqLDeLfj75J
         EaenoBtKF4baIDTwoAFpFXIm70er/snQWX0W3kAl0duHiTqzqDZ76hlwykl8TqL2jWGQ
         eRcrg4tmJrN6JGHOeKElGtu55QXFZpUihJf05EUFeDFCNagWmx8BYEqdIMzKfuZL6orj
         vR+bjLtPQIorpzH2RP4XoL4+UmyObluCIVDHPNux37+rrIIyZchAUepkpwTYynkMM0NQ
         7SqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690212740; x=1690817540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TJ7QSuT9JWuSM03vOOl8cZyXJ2t2WtKznVcR/4lhGHU=;
        b=GvZEkRIgEqhKJtddVxQFgVA4yjpEC7m/SpI07PSMe3TyuABp+WOt9IuvojPjA3X3vh
         tAswhcJI5nJNh91qW/qzRUp7TxC5lbzWDVxWlfvjsgyg1G3hycSBZukzRLnzkzGnlS9Z
         nkVYqZzt1w6HublJGAJAQJgyjO9/kv+YjDrfMw6jkHjUUb6VZcRHF8UzrBHEbAv1iCk4
         NA/rkFRc88BDXu5I38ohtCYxjbW8FqGEIKMyhTMUBDaJkRifHJNjp2j9KxlCmnsoXicI
         iBOgLkoFy0sQ3eBHFKGtUlcOrSEENErSrHxU7DAZ0ipH+RMxOkaDiKhV0hYzDfRddWDY
         AMAA==
X-Gm-Message-State: ABy/qLbULXMpwIBrk/kYgqGQtJfZAqVrCcyJgWZ0wusQkjw4ptNGMCkU
        wNTUezB1tC+Mm1R0wXeciAg=
X-Google-Smtp-Source: APBJJlFOq0opYqdSjOKv5ruZinb6AnGzUlq/w135XHmdyryJ8Nvx/cjLyY6HVfsUTQrbU1QIpnbDbw==
X-Received: by 2002:a7b:ca4d:0:b0:3fc:70:2f76 with SMTP id m13-20020a7bca4d000000b003fc00702f76mr8242344wml.20.1690212739464;
        Mon, 24 Jul 2023 08:32:19 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id l8-20020a7bc448000000b003fb40ec9475sm10676900wmi.11.2023.07.24.08.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 08:32:19 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 1/3] dt-bindings: nvmem: u-boot,env: Add support for u-boot,env-size
Date:   Mon, 24 Jul 2023 10:26:30 +0200
Message-Id: <20230724082632.21133-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for u-boot,env-size new property.

Permit to declare a custom size of the U-Boot env that differs than the
partition size where the U-Boot env is located.

U-Boot env is validated by calculating the CRC32 on the entire env
and in some specific case, the env size might differ from the partition
size resulting in wrong CRC32 calculation than the expected one saved at
the start of the partition.

This happens when U-Boot is compiled by hardcoding a specific env size
but the env is actually placed in a bigger partition, resulting in needing
to provide a custom value.

Declaring this property, this value will be used for NVMEM size instead of
the mtd partition.

Add also an example to make it clear the scenario of mismatched
partition size and actual U-Boot env.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../devicetree/bindings/nvmem/u-boot,env.yaml | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
index 36d97fb87865..3970725a2c57 100644
--- a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
+++ b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
@@ -44,6 +44,24 @@ properties:
   reg:
     maxItems: 1
 
+  u-boot,env-size:
+    description: |
+      Permit to declare a custom size of the U-Boot env that differs than the
+      partition size where the U-Boot env is located.
+
+      U-Boot env is validated by calculating the CRC32 on the entire env
+      and in some specific case, the env size might differ from the partition
+      size resulting in wrong CRC32 calculation than the expected one saved at
+      the start of the partition.
+
+      This happens when U-Boot is compiled by hardcoding a specific env size
+      but the env is actually placed in a bigger partition, resulting in needing
+      to provide a custom value.
+
+      Declaring this property, this value will be used for NVMEM size instead of
+      the mtd partition.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
   bootcmd:
     type: object
     description: Command to use for automatic booting
@@ -99,3 +117,32 @@ examples:
             };
         };
     };
+  - |
+    partitions {
+        compatible = "fixed-partitions";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partition@0 {
+            reg = <0x0 0xc80000>;
+            label = "qcadata";
+            read-only;
+        };
+
+        partition@c80000 {
+            label = "APPSBL";
+            reg = <0xc80000 0x500000>;
+            read-only;
+        };
+
+        partition@1180000 {
+            compatible = "u-boot,env";
+            reg = <0x1180000 0x80000>;
+
+            u-boot,env-size = <0x40000>;
+
+            mac1: ethaddr {
+                #nvmem-cell-cells = <1>;
+            };
+        };
+    };
-- 
2.40.1

