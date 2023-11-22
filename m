Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8657F53A2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 23:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344542AbjKVWpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 17:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344566AbjKVWox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 17:44:53 -0500
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A70F10C9;
        Wed, 22 Nov 2023 14:44:50 -0800 (PST)
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-35ba5e00dc5so1065135ab.1;
        Wed, 22 Nov 2023 14:44:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700693089; x=1701297889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dOikdkPRwRxmGwSUmHKMwAIqj7noxVlno/TgxvlhfgY=;
        b=R98wHvw1cDuPjWNZba6oGuG3/DDpF9F0qN3c92H2xxjkjUe+TW8gmZ/Se+76zmZBT3
         T+EgdHPlSl1CHt3KWZGJ3mULIrkiF20lNlNq1L3DOy/okpXarlLq4D0w5E9OfQDIf40u
         D6Wc/fLh/42sqP5N1ZcJCAlIwGyAFTCaQZ+c8DGaJbtY4V5tyLcv30BOu7TYXcWB7Qmn
         J0xM8jmts/ahFAv6rsVyMVHGELEiqYw/TePTaJNSeva91/TCZmDAyBZf5Dneb7i9Uhf8
         s7jc2Ov5UUHVezTTT9wPP7mVl7/xT/atqpl675khbP86AdJUmBI9ILC9WfRknTz7p/Bk
         o6NA==
X-Gm-Message-State: AOJu0YysIK8NoP9q9LdH+8a/XNh/VWt1bBmyoRiMiltERb9L10eaoKaK
        A/fCxxn9TPx8Cux/gQoJw/1Bq53HiA==
X-Google-Smtp-Source: AGHT+IH4xdm55rf6fjnkKmiDuqM0N+SsbGI6yZbHVZnjVfoO4fXJjJ0Pc+Q/FOVFSd++4w8z5URABw==
X-Received: by 2002:a05:6e02:4b2:b0:35a:b337:6f58 with SMTP id e18-20020a056e0204b200b0035ab3376f58mr3775500ils.16.1700693089245;
        Wed, 22 Nov 2023 14:44:49 -0800 (PST)
Received: from herring.priv ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id v11-20020a056638358b00b0043167542398sm98760jal.141.2023.11.22.14.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 14:44:48 -0800 (PST)
Received: (nullmailer pid 2810199 invoked by uid 1000);
        Wed, 22 Nov 2023 22:44:47 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: arm/calxeda: drop unneeded quotes
Date:   Wed, 22 Nov 2023 15:44:32 -0700
Message-ID: <20231122224432.2809781-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop unneeded quotes over simple string values to fix a soon to be
enabled yamllint warning:

  [error] string value is redundantly quoted with any quotes (quoted-strings)

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/calxeda/l2ecc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/calxeda/l2ecc.yaml b/Documentation/devicetree/bindings/arm/calxeda/l2ecc.yaml
index a9fe01238a88..76b65ea149b6 100644
--- a/Documentation/devicetree/bindings/arm/calxeda/l2ecc.yaml
+++ b/Documentation/devicetree/bindings/arm/calxeda/l2ecc.yaml
@@ -16,7 +16,7 @@ maintainers:
 
 properties:
   compatible:
-    const: "calxeda,hb-sregs-l2-ecc"
+    const: calxeda,hb-sregs-l2-ecc
 
   reg:
     maxItems: 1
-- 
2.42.0

