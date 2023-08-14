Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C693077BE67
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjHNQxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjHNQxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:53:02 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560A1E65
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:53:01 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51e2a6a3768so6178346a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692031980; x=1692636780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haatfWR2uR8UKXBeB48Hj2MdGE5hoyzIE8VGVa/sO+A=;
        b=szhkNJXu9OToiV4ADCf9ja5eLCw8rBbnIKMHma76H4q1V21n3n1sTJ3mVpHzlI+XtD
         R44V2g/KSFFw7+b5aqfBtZ5Dyl8FvmLC4WPiM0qx40Q94XEELabEkJ6PUAbDvTCjOY/G
         hKAWj9KT2zothD9EUkjD3yqaJXHYVDG3FJ7BTMghfsnTJiywmvB8t88/ZhErBM4S1kFR
         dhBSTv5PzP6X2+bL8vak5nTrRENSr4ANPhbLYsDOBJsRHOwSeitDgLUBfdDKr6wSb9E0
         E6NUfG3PobGSPNLw4Wmmdl7N5R+4C5zi62aeaMtRlE3ijOZv+C9gevevjPvp00i3sGmI
         9/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692031980; x=1692636780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haatfWR2uR8UKXBeB48Hj2MdGE5hoyzIE8VGVa/sO+A=;
        b=KNJPErjZ7jWMtXErj2OJLhN8Mfgj8/4TKfUrL6J5ZccqJTBi+14FD8RccxO4UEw4Q6
         Grymxab6eF7P4R8/t6T6Lz6TolmiEs5w4pwbC7LjjJ35FeEnhnlaYf0jvXkX4DdL2JwE
         Tr087i70jwg+K4t72D0rG423LHkGdCxb30CS8cz2/Vu1HiMmnAXNDq5lBzI9hZd9artj
         YxMdiN1m6ixHxsUDZIpxdk4m3uOx2GSgxL8u7Z5vFdllEnb4LIZeFvYVYg1c4flQ+MRu
         8Ts5zfWPMuXvk3gJxP2QtdJqCu/8E4QrL4oGY+oWG56oiHvKjVQkDcZpfOxG2RO+W9py
         qCvA==
X-Gm-Message-State: AOJu0YxWFwTMZd444/YG+x1FGADje3SeZDB/6y7tiLJJJsmGQr9d+N7q
        j6IKzTrb6RsUwHYmyQOBjeTQSPTWrf/GAT6Jq0Q=
X-Google-Smtp-Source: AGHT+IFGTN0bwybedF0kYZvsnqXKmAeiTwm4NXG+jR9wtB2X2AY0vc4+WXYTDxEdDactISbkdLVEpQ==
X-Received: by 2002:aa7:d8d3:0:b0:523:36cf:8bf1 with SMTP id k19-20020aa7d8d3000000b0052336cf8bf1mr7154554eds.34.1692031979764;
        Mon, 14 Aug 2023 09:52:59 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id n5-20020aa7c785000000b0052338f5b2a4sm5811267eds.86.2023.08.14.09.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 09:52:58 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 01/22] dt-bindings: nvmem: fixed-cell: add compatible for MAC cells
Date:   Mon, 14 Aug 2023 17:52:31 +0100
Message-Id: <20230814165252.93422-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
References: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

A lot of home routers have NVMEM fixed cells containing MAC address that
need some further processing. In ~99% cases MAC needs to be:
1. Optionally parsed from ASCII format
2. Increased by a vendor-picked value

There was already an attempt to design a binding for that at NVMEM
device level in the past. It wasn't accepted though as it didn't really
fit NVMEM device layer.

The introduction of NVMEM fixed-cells layout seems to be an opportunity
to provide a relevant binding in a clean way.

This commit adds a *generic* compatible string: "mac-base". As always it
needs to be carefully reviewed.

OpenWrt project currently supports ~300 home routers that have NVMEM
cell with binary-stored base MAC.T hose devices are manufactured by
multiple vendors. There are TP-Link devices (76 of them), Netgear (19),
D-Link (11), OpenMesh (9), EnGenius (8), GL.iNet (8), ZTE (7),
Xiaomi (5), Ubiquiti (6) and more. Those devices don't share an
architecture or SoC.

Another 200 devices have base MAC stored in an ASCII format (not all
those devices have been converted to DT though).

It would be impractical to provide unique "compatible" strings for NVMEM
layouts of all those devices. It seems like a valid case for allowing a
generic binding instead. Even if this binding will not be sufficient for
some further devices it seems to be useful enough as it is.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/nvmem/layouts/fixed-cell.yaml    | 26 +++++++++++++++++++
 .../bindings/nvmem/layouts/fixed-layout.yaml  | 12 +++++++++
 .../devicetree/bindings/nvmem/nvmem.yaml      |  5 +++-
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml b/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
index e698098450e1..ac2381e66027 100644
--- a/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
+++ b/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
@@ -11,6 +11,15 @@ maintainers:
   - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 
 properties:
+  compatible:
+    oneOf:
+      - const: mac-base
+        description: >
+          Cell with base MAC address to be used for calculating extra relative
+          addresses.
+          It can be stored in a plain binary format (cell length 6) or as an
+          ASCII text like "00:11:22:33:44:55" (cell length 17).
+
   reg:
     maxItems: 1
 
@@ -25,6 +34,23 @@ properties:
         description:
           Size in bit within the address range specified by reg.
 
+allOf:
+  - if:
+      required: [ compatible ]
+    then:
+      if:
+        properties:
+          compatible:
+            contains:
+              const: mac-base
+      then:
+        properties:
+          "#nvmem-cell-cells":
+            description: The first argument is a MAC address offset.
+            const: 1
+        required:
+          - "#nvmem-cell-cells"
+
 required:
   - reg
 
diff --git a/Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml
index c271537d0714..9bd34bd5af30 100644
--- a/Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml
+++ b/Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml
@@ -44,6 +44,18 @@ examples:
         #address-cells = <1>;
         #size-cells = <1>;
 
+        mac@100 {
+            compatible = "mac-base";
+            reg = <0x100 0x6>;
+            #nvmem-cell-cells = <1>;
+        };
+
+        mac@110 {
+            compatible = "mac-base";
+            reg = <0x110 0x11>;
+            #nvmem-cell-cells = <1>;
+        };
+
         calibration@4000 {
             reg = <0x4000 0x100>;
         };
diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
index 980244100690..9f921d940142 100644
--- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
@@ -49,7 +49,10 @@ properties:
 patternProperties:
   "@[0-9a-f]+(,[0-7])?$":
     type: object
-    $ref: layouts/fixed-cell.yaml
+    allOf:
+      - $ref: layouts/fixed-cell.yaml
+      - properties:
+          compatible: false
     deprecated: true
 
 additionalProperties: true
-- 
2.25.1

