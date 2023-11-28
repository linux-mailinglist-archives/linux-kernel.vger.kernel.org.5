Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1E17FC868
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbjK1VsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbjK1VsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:48:09 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC132B0;
        Tue, 28 Nov 2023 13:48:11 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6cd0a8bc6dcso3656354a34.2;
        Tue, 28 Nov 2023 13:48:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701208091; x=1701812891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HrJ0LHtyb46py1wsTp8nuyQVcABfVvnzMH83rgwCH3U=;
        b=wyVuby5OnCprk+IwWtJ0/yMj5YuM2QJdkcyLvk+7McIuNcjB0lGekeMuCI+VCmry7l
         b8L5ppW9uPlxfZHBgzIybAhQluMjHdjO8G3YrqHsypNYMapH07+v2PEc1X8U5ySmVxoE
         lQ+zzxkMztuB67t1emnSF3GhSS2lFtH7M7TD+kcsp9lFd/f5wb4yIm797SDfkSVpODP1
         e1dXFDr9zdfGsb4y6zEROxKhSfyPsVuS2bHB/KneZRgD5uNom56WSNUAB38pesXUUPEs
         w1ejiKUNXSPIRTL+7BRPo00HC7DT7+AoGOYbygzXrObLPhIpInTaHlyBspslFiRyZKgz
         TOSg==
X-Gm-Message-State: AOJu0YzQnqDC8ITXIYfsMwmF2N1tNWrxUA8hrXN1RH9CWxV18+64Xx83
        lmE+ZPehSRprzR4rWiVngw==
X-Google-Smtp-Source: AGHT+IHqEJJFSEStAXI4DhX5amCfCmwugJtgNaAYjJgH64aasKenmGzatAY6vvhJcfUYjyMYnWkK2w==
X-Received: by 2002:a05:6870:b619:b0:1fa:3e11:e178 with SMTP id cm25-20020a056870b61900b001fa3e11e178mr12375997oab.10.1701208091189;
        Tue, 28 Nov 2023 13:48:11 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ti3-20020a056871890300b001f9e3731545sm2765905oab.11.2023.11.28.13.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 13:48:10 -0800 (PST)
Received: (nullmailer pid 3975662 invoked by uid 1000);
        Tue, 28 Nov 2023 21:48:06 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: iio/adc: ti,palmas-gpadc: Drop incomplete example
Date:   Tue, 28 Nov 2023 15:48:02 -0600
Message-ID: <20231128214803.3975542-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The example for the TI Palmas ADC is incomplete as the binding is the
full PMIC, not just the sub-functions. It is preferred for MFD examples
to be complete in the top-level MFD device binding rather than piecemeal
in each sub-function binding.

This also fixes an undocumented (by schema) compatible warning for
'"ti,twl6035-pmic", "ti,palmas-pmic"'.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/iio/adc/ti,palmas-gpadc.yaml         | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.yaml b/Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.yaml
index 720c16a108d4..f94057d8f605 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.yaml
@@ -67,19 +67,4 @@ required:
   - compatible
   - "#io-channel-cells"
 
-examples:
-  - |
-    #include <dt-bindings/clock/mt8183-clk.h>
-    pmic {
-        compatible = "ti,twl6035-pmic", "ti,palmas-pmic";
-        adc {
-            compatible = "ti,palmas-gpadc";
-            interrupts = <18 0>,
-                         <16 0>,
-                         <17 0>;
-            #io-channel-cells = <1>;
-            ti,channel0-current-microamp = <5>;
-            ti,channel3-current-microamp = <10>;
-        };
-    };
 ...
-- 
2.42.0

