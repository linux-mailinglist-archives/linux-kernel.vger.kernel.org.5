Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48305772D2E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjHGRmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjHGRmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:42:17 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D66AE74
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:42:15 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58960b53007so7505627b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691430134; x=1692034934;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j3yZHfkW3liJsGu+2g/OBERI8jeu8fmQFUJTPAyU4Fw=;
        b=5ONjLihZwyJZ1ST9PSkQnPmCV+PjdedUtLZQVeWd54i4/k0NAKxElTP0o38DfHyVTM
         lJY0Antl/aAQKfmyeYe2UbRmtUN0iIsbYSuDd6rRjmFmU99Mcwgf2PadUnQ1qwoA/IIh
         wh7SbOhp1f8xKBXoa5KBbdrBJRgIRZwDum1SIUc3o5yGHHvELZ5v1DU5x/TI4Sm9UNAh
         dBUGYfph8d39Em0PqOhuR4i6Cm0CVyxTEPE6hToPR+iINwbbsZessKgA3B93b7DncGfG
         1hnIjQKmAnTGmbs99s5EbzSN//2dzngsXFdsLQTppbqMsEJ6qcy7XbRiaNfT3BaS7R7M
         BhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691430134; x=1692034934;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j3yZHfkW3liJsGu+2g/OBERI8jeu8fmQFUJTPAyU4Fw=;
        b=E23h9P26F97xj9X6SpA/Q+snoU1yq92TyDdJEBI03AzOqExuU1A3PvtaN3DcOge4EK
         UmCXam+Z5zm/w3dRFO4A/R/6vwGuQpf7GLUvnssFchHS2v06vlafM/xYpqNQ7nTWOUYv
         PaYYGVDrcmuHBk5LPhrca9lij+iNdSw7tJUvpQfEJTWERjO4jC8ruhaD9XY9GgUewKDg
         nS/c81Tk8XVtTUQSGlXXu+1wOkVf4pVTYoXXKHqHSObbgOLaT8GCVfTVR/gkxRjtlGrP
         meyFf/aZ9+eyobJoXlif3VPqHqsFT8WtlqIx6w4ACwxNR+qAr9Y/U2Ajuzumf+4SkCTm
         qjSw==
X-Gm-Message-State: AOJu0YwPjCVE+6hE5naOYyhOmzkOCBW5V7jDVtawLqBY6vygBf0lEw+Z
        5RaGNff/QRj+Oj/7vnDiEH1HT6P9GqHk
X-Google-Smtp-Source: AGHT+IE7+duX24KVIi0dzvlLRonPpi02Udwbsn2dW1nnRPllxJS1t9P2UpTwOWZvaz5m31KSrVi5oSXDuBKs
X-Received: from kyletso-p620lin01.ntc.corp.google.com ([2401:fa00:fc:202:c7c:f93d:372a:1641])
 (user=kyletso job=sendgmr) by 2002:a25:bc81:0:b0:d4d:564d:8fbf with SMTP id
 e1-20020a25bc81000000b00d4d564d8fbfmr40097ybk.13.1691430134612; Mon, 07 Aug
 2023 10:42:14 -0700 (PDT)
Date:   Tue,  8 Aug 2023 01:41:58 +0800
In-Reply-To: <20230807174159.1140957-1-kyletso@google.com>
Mime-Version: 1.0
References: <20230807174159.1140957-1-kyletso@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230807174159.1140957-2-kyletso@google.com>
Subject: [PATCH v2 1/2] dt-bindings: connector: Add child nodes for multiple
 PD capabilities
From:   Kyle Tso <kyletso@google.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc:     badhri@google.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define a new optional property "capabilities" which is a child node
under connector to contain multiple USB Power Delivery capabilities.

Define a new property with pattern (e.g. caps-0, caps-1) which is a
child node under "capabilities". Each node contains PDO data of a
selectable Power Delivery capability.

Also define common properties for source-pdos, sink-pdos, and
op-sink-microwatt that can be referenced.

Signed-off-by: Kyle Tso <kyletso@google.com>
---
v1 -> v2:
- move source/sink-pdos to $defs and reference them in properties

 .../bindings/connector/usb-connector.yaml     | 80 +++++++++++++------
 1 file changed, 57 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
index 1c4d3eb87763..c6b02dbda83f 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -117,28 +117,10 @@ properties:
   # The following are optional properties for "usb-c-connector" with power
   # delivery support.
   source-pdos:
-    description: An array of u32 with each entry providing supported power
-      source data object(PDO), the detailed bit definitions of PDO can be found
-      in "Universal Serial Bus Power Delivery Specification" chapter 6.4.1.2
-      Source_Capabilities Message, the order of each entry(PDO) should follow
-      the PD spec chapter 6.4.1. Required for power source and power dual role.
-      User can specify the source PDO array via PDO_FIXED/BATT/VAR/PPS_APDO()
-      defined in dt-bindings/usb/pd.h.
-    minItems: 1
-    maxItems: 7
-    $ref: /schemas/types.yaml#/definitions/uint32-array
+    $ref: "#/$defs/source-pdos"
 
   sink-pdos:
-    description: An array of u32 with each entry providing supported power sink
-      data object(PDO), the detailed bit definitions of PDO can be found in
-      "Universal Serial Bus Power Delivery Specification" chapter 6.4.1.3
-      Sink Capabilities Message, the order of each entry(PDO) should follow the
-      PD spec chapter 6.4.1. Required for power sink and power dual role. User
-      can specify the sink PDO array via PDO_FIXED/BATT/VAR/PPS_APDO() defined
-      in dt-bindings/usb/pd.h.
-    minItems: 1
-    maxItems: 7
-    $ref: /schemas/types.yaml#/definitions/uint32-array
+    $ref: "#/$defs/sink-pdos"
 
   sink-vdos:
     description: An array of u32 with each entry, a Vendor Defined Message Object (VDO),
@@ -164,9 +146,7 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32-array
 
   op-sink-microwatt:
-    description: Sink required operating power in microwatt, if source can't
-      offer the power, Capability Mismatch is set. Required for power sink and
-      power dual role.
+    $ref: "#/$defs/op-sink-microwatt"
 
   port:
     $ref: /schemas/graph.yaml#/properties/port
@@ -228,6 +208,30 @@ properties:
       SNK_READY for non-pd link.
     type: boolean
 
+  capabilities:
+    description: A child node to contain all the selectable USB Power Delivery capabilities.
+    type: object
+
+    patternProperties:
+      "^caps-[0-9]+$":
+        description: Child nodes under "capabilities" node. Each node contains a selectable USB
+          Power Delivery capability.
+        type: object
+
+        properties:
+          source-pdos:
+            $ref: "#/$defs/source-pdos"
+
+          sink-pdos:
+            $ref: "#/$defs/sink-pdos"
+
+          op-sink-microwatt:
+            $ref: "#/$defs/op-sink-microwatt"
+
+        additionalProperties: false
+
+    additionalProperties: false
+
 dependencies:
   sink-vdos-v1: [ 'sink-vdos' ]
   sink-vdos: [ 'sink-vdos-v1' ]
@@ -235,6 +239,36 @@ dependencies:
 required:
   - compatible
 
+$defs:
+  source-pdos:
+    description: An array of u32 with each entry providing supported power
+      source data object(PDO), the detailed bit definitions of PDO can be found
+      in "Universal Serial Bus Power Delivery Specification" chapter 6.4.1.2
+      Source_Capabilities Message, the order of each entry(PDO) should follow
+      the PD spec chapter 6.4.1. Required for power source and power dual role.
+      User can specify the source PDO array via PDO_FIXED/BATT/VAR/PPS_APDO()
+      defined in dt-bindings/usb/pd.h.
+    minItems: 1
+    maxItems: 7
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
+  sink-pdos:
+    description: An array of u32 with each entry providing supported power sink
+      data object(PDO), the detailed bit definitions of PDO can be found in
+      "Universal Serial Bus Power Delivery Specification" chapter 6.4.1.3
+      Sink Capabilities Message, the order of each entry(PDO) should follow the
+      PD spec chapter 6.4.1. Required for power sink and power dual role. User
+      can specify the sink PDO array via PDO_FIXED/BATT/VAR/PPS_APDO() defined
+      in dt-bindings/usb/pd.h.
+    minItems: 1
+    maxItems: 7
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
+  op-sink-microwatt:
+    description: Sink required operating power in microwatt, if source can't
+      offer the power, Capability Mismatch is set. Required for power sink and
+      power dual role.
+
 allOf:
   - if:
       properties:
-- 
2.41.0.585.gd2178a4bd4-goog

