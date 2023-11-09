Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3DE7E669F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbjKIJXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbjKIJXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:23:37 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498371A8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 01:23:34 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9dd3f4a0f5aso99652266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 01:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1699521813; x=1700126613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eNQIp/KBXkssBnXnURnyXEtwPP/esZe3h0yYIlPjhVo=;
        b=eOaLlZmgZ43wYgk2ruMRhebXYpyIQ7XB4SRsMaBi6YL/6ZTQcH99pW/YABiy7Sp5jZ
         1ZdudT7FgqCm2LLATi+sOemtp/XHipyJaHDct+mwwMPzXLI1pPvsm+8sPfeRQhD3DlfT
         FPa+jLxskb5kvEPFGJlBHnlwXXZfDz6lzZHgQfodEj2J0MTPnsmDfxMI9mx++Guuma86
         PmTAvBZVy09qZlKPbQY4K1yrhrfXyGX38ef+NHsA0W91UyDwjZ5VxO761yzNv8teeAYV
         H6ML3jcX+/fHPMp1fVujCzMyymb/nUDCKyhNal4zeG2jMSMGgzBU1dCSXCLPbeNuWMcu
         2+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699521813; x=1700126613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eNQIp/KBXkssBnXnURnyXEtwPP/esZe3h0yYIlPjhVo=;
        b=N7aEBnx7VYb4Vt0EQF84lotsXXoVQyQpw+3veB2qP5tb9jguahOdVEt0A5/v/ciHFo
         w+k+jjc7Mrpn+R3z55TYsrpYGospjYBY2EdnIGNUrP+N8QMdzyjQUQVVerPB5ufr1POZ
         PJNUVjTQauGjb0K2UlkHTONVBxNSU2+Gv/RBRdsnXoybXZrT0GHK1iu7uaYPnFVBMQ5w
         xzo6uxUVJe77PacybwMz2GAbnAFk5FV9VHnAuT6majdKuA5rZD4kLWs5WuTC9fhmxYLa
         g9w9FJxefWYDLtl/gvc7o7DcxdO/Qex0ez3OTUkluIwm+OKzaLOIIBr6xyg6wgHxoLYw
         E0qQ==
X-Gm-Message-State: AOJu0YzVUnXm/mLZINzqDFicMlwfeqoYXEjH4o4e1fcWIKJQ4opU5+ws
        wjy5+/Qr7NrfmVwYyR3qTql3EA==
X-Google-Smtp-Source: AGHT+IH4me2HKSYcglcNZV5PHQM7TvfR+M1iz+M5Q/szKPL4PSN4JIOUc+KCQ7mA3sUCi/3NYyrCPw==
X-Received: by 2002:a17:907:d1d:b0:9bf:4e0b:fb11 with SMTP id gn29-20020a1709070d1d00b009bf4e0bfb11mr3964112ejc.8.1699521812481;
        Thu, 09 Nov 2023 01:23:32 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id c7-20020a7bc847000000b0040836519dd9sm1453917wml.25.2023.11.09.01.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 01:23:32 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
To:     Peter Rosin <peda@axentia.se>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     robh@kernel.org, Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <naresh.solanki@9elements.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v5 1/2] dt-bindings: i2c: pca954x: Add custom properties for MAX7357
Date:   Thu,  9 Nov 2023 09:23:26 +0000
Message-ID: <20231109092328.3238241-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Maxim Max7357 has a configuration register to enable additional
features. These features aren't enabled by default & its up to
board designer to enable the same as it may have unexpected side effects.

These should be validated for proper functioning & detection of devices
in secondary bus as sometimes it can cause secondary bus being disabled.

Add booleans for:
 - maxim,isolate-stuck-channel
 - maxim,send-flush-out-sequence
 - maxim,preconnection-wiggle-test-enable

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in V4:
- Drop max7358.
Changes in V3:
- Update commit message
Changes in V2:
- Update properties.
---
 .../bindings/i2c/i2c-mux-pca954x.yaml         | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
index 2d7bb998b0e9..9aa0585200c9 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
@@ -71,6 +71,23 @@ properties:
     description: A voltage regulator supplying power to the chip. On PCA9846
       the regulator supplies power to VDD2 (core logic) and optionally to VDD1.
 
+  maxim,isolate-stuck-channel:
+    type: boolean
+    description: Allows to use non faulty channels while a stuck channel is
+      isolated from the upstream bus. If not set all channels are isolated from
+      the upstream bus until the fault is cleared.
+
+  maxim,send-flush-out-sequence:
+    type: boolean
+    description: Send a flush-out sequence to stuck auxiliary buses
+      automatically after a stuck channel is being detected.
+
+  maxim,preconnection-wiggle-test-enable:
+    type: boolean
+    description: Send a STOP condition to the auxiliary buses when the switch
+      register activates a channel to detect a stuck high fault. On fault the
+      channel is isolated from the upstream bus.
+
 required:
   - compatible
   - reg
@@ -95,6 +112,19 @@ allOf:
         "#interrupt-cells": false
         interrupt-controller: false
 
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - maxim,max7357
+    then:
+      properties:
+        maxim,isolate-stuck-channel: false
+        maxim,send-flush-out-sequence: false
+        maxim,preconnection-wiggle-test-enable: false
+
 unevaluatedProperties: false
 
 examples:

base-commit: 9b156db7e479ac996ae9dc93a0cce3b3df3d0307
-- 
2.41.0

