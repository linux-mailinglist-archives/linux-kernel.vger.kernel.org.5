Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0E27C84A6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjJMLie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjJMLiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:38:16 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99ADCBD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:38:10 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so3437756a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1697197089; x=1697801889; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P/sDFt5u6yywO4BpNy8pUfk7EN+/+vD5SZ2loLoo8lA=;
        b=nHbmM/vKpzvkzfMFgwkMLAHL/LKz3fEOgeIXO3ydrrNBLjCLqdODeJh9OYm7r1zw1Q
         f6hk3PTcsOsN4ZaCaw2efXsDp7ygA779oJ3wpexbkFrJztdbgy5+nsP3Dy52+UTBjWrZ
         vdN97vuA+mZY004ibWJPj3yUFRN/1Nd48tqGzGhs7CVj2nRZRWp4F8urLf10ytsOoeOO
         sFYuGr6xGfLMueEKD3qqUsUvDtSiIyRoeTp3mqZXt92FrrgWOkoiB0MbpCnieFn+ldbk
         qKezYgKec+QxBabMRAOnib9J/FemUe0BGrrShnm+sHR1cE2LDsSIY5Et8Y7hXy+CgCCY
         rrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697197089; x=1697801889;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/sDFt5u6yywO4BpNy8pUfk7EN+/+vD5SZ2loLoo8lA=;
        b=mJS6zG6B/4t0rbGQqBSkRsk+DdiMUT2y6YAzU96cq08w4cJMl1A2Y7F1chTXCVXUIC
         5ZF04hZMpP4g+vC0zOan2xg0RdrTHGX8ugettihVnvEHtXaRG2ejDp2ThS+BQWLPw7s4
         ZUHQloHX8s2G3Z2AStA3CLEIQ56VtD98z8zbhxb7dywEEE+2vx3Ju7Zwim//XVfsezDv
         exa4j+t8ZCrcJkDmelTNXANiXnDWn/gVVrrjg8MhXEbEEH7NoK4nqL8laEqODObRj1i6
         +QLCVfQriijlc0HdPxZ+vleH9Qiy7baBhAuGA4L2EiXMtHFdfO0y2Aczvfho/G8yYELP
         PSQg==
X-Gm-Message-State: AOJu0Yyej8ySIjUioV9iVCKIhLmu0MwlRw+KHMKZLwpbvTTBhJ44OcpX
        q+B2tUx+LjrjHTGHfkKPHxPqDQ==
X-Google-Smtp-Source: AGHT+IFmR+Da1OD7TXV3vp3gQFMiZH6VvNX+Av8DxmkzVtm5A0bm+pmE9h2RNaAcqybsEUeZvGqIlg==
X-Received: by 2002:a05:6402:1e89:b0:53e:12dd:b9d0 with SMTP id f9-20020a0564021e8900b0053e12ddb9d0mr5236497edf.36.1697197089101;
        Fri, 13 Oct 2023 04:38:09 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id v18-20020aa7d652000000b00533dad8a9c5sm11360772edr.38.2023.10.13.04.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 04:38:08 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Fri, 13 Oct 2023 13:38:05 +0200
Subject: [PATCH 1/3] dt-bindings: usb: fsa4480: Add data-lanes property to
 endpoint
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231013-fsa4480-swap-v1-1-b877f62046cc@fairphone.com>
References: <20231013-fsa4480-swap-v1-0-b877f62046cc@fairphone.com>
In-Reply-To: <20231013-fsa4480-swap-v1-0-b877f62046cc@fairphone.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow specifying data-lanes to reverse the SBU muxing orientation where
necessary by the hardware design.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 .../devicetree/bindings/usb/fcs,fsa4480.yaml       | 29 +++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml b/Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml
index f6e7a5c1ff0b..86f6d633c2fb 100644
--- a/Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml
+++ b/Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml
@@ -32,10 +32,37 @@ properties:
     type: boolean
 
   port:
-    $ref: /schemas/graph.yaml#/properties/port
+    $ref: /schemas/graph.yaml#/$defs/port-base
     description:
       A port node to link the FSA4480 to a TypeC controller for the purpose of
       handling altmode muxing and orientation switching.
+    unevaluatedProperties: false
+
+    properties:
+      endpoint:
+        $ref: /schemas/graph.yaml#/$defs/endpoint-base
+        unevaluatedProperties: false
+
+        properties:
+          data-lanes:
+            $ref: /schemas/types.yaml#/definitions/uint32-array
+            description:
+              Specifies how the AUX+/- lines are connected to SBU1/2.
+            oneOf:
+              - items:
+                  - const: 0
+                  - const: 1
+                description: |
+                  Default AUX/SBU layout
+                  - AUX+ connected to SBU2
+                  - AUX- connected to SBU1
+              - items:
+                  - const: 1
+                  - const: 0
+                description: |
+                  Swapped AUX/SBU layout
+                  - AUX+ connected to SBU1
+                  - AUX- connected to SBU2
 
 required:
   - compatible

-- 
2.42.0

