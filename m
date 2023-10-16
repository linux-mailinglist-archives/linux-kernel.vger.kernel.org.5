Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530E27CAE51
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbjJPPzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233874AbjJPPzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:55:38 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4A783;
        Mon, 16 Oct 2023 08:55:37 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6c496719a9aso2468038a34.0;
        Mon, 16 Oct 2023 08:55:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697471736; x=1698076536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TRerAnxCUqMpLPzL2U+W33V1BBPnxzPAPP9+9Nf5S4U=;
        b=VuN3cRErX9nssesiCfgF3NKWsXv0igYvDWTULGPEmA3uOxFrSGVl3be3+ur5muFfHT
         dZayHDXcYFo3PMiUk9RzsAtziVttnN6kubzFOegFeEpyqLG0hQ7c3dFf5j1i/htY1ARI
         7vfFba7WWk+J0aGCy1SnIMT5YLrrtU8uu1lY7L6n0Akbw9rh2eGI0jIt5pwqz73aEdHC
         HD7MaeLyJQLLqck35CtKKz8BTmr8PUu+SuXqbmAbjdTM7G20j1jUeXG0o+06T26kPhIK
         8TRZl+8tL4P5coT5Fc9+zIocgIAiq2m6emBP5a7mUEMLRphWaXjdy6rAw2wSaizuP93O
         XNFQ==
X-Gm-Message-State: AOJu0Yy66ys+Kb/TZwWZdWryg5+cOP9tYkANpQvqFvW21jRdbl+VApOO
        zmxBBhYnzqcfolWQXfs5EkLLg5dyXw==
X-Google-Smtp-Source: AGHT+IEgGnWwWCwXC/MWSMrQ3hgYX6hh6hy4XAZ/g9tulnhZsn43JY8+y8s3hr3MyQ4lMPFif1ArzA==
X-Received: by 2002:a9d:685a:0:b0:6be:f8fc:8207 with SMTP id c26-20020a9d685a000000b006bef8fc8207mr4553001oto.17.1697471735915;
        Mon, 16 Oct 2023 08:55:35 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m4-20020a9d7e84000000b006c4be829aa8sm1771179otp.44.2023.10.16.08.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 08:55:35 -0700 (PDT)
Received: (nullmailer pid 2973568 invoked by uid 1000);
        Mon, 16 Oct 2023 15:55:34 -0000
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: usb: ti,tps6598x: Disallow undefined properties
Date:   Mon, 16 Oct 2023 10:55:27 -0500
Message-ID: <20231016155527.2973385-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device specific bindings should not allow undefined properties. This is
accomplished in json-schema with 'additionalProperties: false'. With this,
the 'connector' child node needs to be defined to prevent warnings.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/usb/ti,tps6598x.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
index 5497a60cddbc..6ab674dea4c6 100644
--- a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
+++ b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
@@ -32,11 +32,14 @@ properties:
     items:
       - const: irq
 
+  connector:
+    $ref: /schemas/connector/usb-connector.yaml#
+
 required:
   - compatible
   - reg
 
-additionalProperties: true
+additionalProperties: false
 
 examples:
   - |
-- 
2.42.0

