Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A37F7CAE56
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjJPPzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbjJPPzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:55:52 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B372111;
        Mon, 16 Oct 2023 08:55:47 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1e9b6f39f9eso3097736fac.2;
        Mon, 16 Oct 2023 08:55:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697471747; x=1698076547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cgg87UtHLQSkOjF6qYscbrH//xUG/ckxVIjIUjvA1MY=;
        b=tF4WT/OhFhMmbRjJUOwdOpZADQ8OPgsC+4//rzklDcjwGWsOSBMTbDGHFk0kFxODbs
         iXO9V8IY6s8o76Dc/vavW8NnprsolxEB96ZiQcgMJKvLUNX+uzO5rEhPRukhvYfel2Ss
         jkYlH0G/6ZYAKR/dlHDxqhSRaySUICjWek/lk7XzNCZZUIMO3C/Y+4vKALWs0410p6Tz
         W6L2Jp2+6mTJIbqfQEdZQ56bG6bpiSlEraGHCO2OEBAPmD72RP5H/zAHiXVdAhqo9Vz5
         5h572zbgemQW1FiXUWaJbPYE4pbRK0Fk7UqhljVXMqE1kBrR+FBU/C3dHUMOvsITBcmN
         4m+g==
X-Gm-Message-State: AOJu0YzYqT+lzFYzRZfTrwXChdnicrXEdVCKBpGd4lLFvPkZ1+iCnSyd
        115/LonSV10pDVMmYZxHOqQZaMCHEg==
X-Google-Smtp-Source: AGHT+IEhXJUrH9v8yxiSiKeQiTvgOpLixLv+sbC3kQX+HSssbbmD5xZc3smlDM78rj8uIg0UwK4IOw==
X-Received: by 2002:a05:6870:e9aa:b0:1d0:dc5b:d67 with SMTP id r42-20020a056870e9aa00b001d0dc5b0d67mr43388511oao.42.1697471746716;
        Mon, 16 Oct 2023 08:55:46 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id eb37-20020a056870a8a500b001e9ce1b5e8fsm1728717oab.15.2023.10.16.08.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 08:55:45 -0700 (PDT)
Received: (nullmailer pid 2973814 invoked by uid 1000);
        Mon, 16 Oct 2023 15:55:44 -0000
From:   Rob Herring <robh@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: soundwire: Add reference to soundwire-controller.yaml schema
Date:   Mon, 16 Oct 2023 10:55:37 -0500
Message-ID: <20231016155537.2973625-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The soundwire-controller.yaml schema already defines the form for devices
in child nodes, so there's no need to do the same in the QCom controller
binding. Add a $ref to the soundwire-controller.yaml schema and drop the
child node schema.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/soundwire/qcom,soundwire.yaml       | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml b/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml
index 7d60a9654912..3591c8c49bfe 100644
--- a/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml
+++ b/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml
@@ -209,17 +209,6 @@ properties:
   label:
     maxItems: 1
 
-patternProperties:
-  "^.*@[0-9a-f],[0-9a-f]$":
-    type: object
-    additionalProperties: true
-    description:
-      Child nodes for a standalone audio codec or speaker amplifier IC.
-      It has RX and TX Soundwire secondary devices.
-    properties:
-      compatible:
-        pattern: "^sdw[0-9a-f]{1}[0-9a-f]{4}[0-9a-f]{4}[0-9a-f]{2}$"
-
 required:
   - compatible
   - reg
@@ -240,7 +229,10 @@ oneOf:
   - required:
       - qcom,ports-sinterval
 
-additionalProperties: false
+allOf:
+  - $ref: soundwire-controller.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.42.0

