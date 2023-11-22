Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A90E7F539E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 23:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235176AbjKVWou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 17:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344536AbjKVWoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 17:44:38 -0500
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B63E1B9;
        Wed, 22 Nov 2023 14:44:33 -0800 (PST)
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7a683bd610dso7796739f.1;
        Wed, 22 Nov 2023 14:44:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700693072; x=1701297872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AsulCrhxZ7G9yLtOFYjz5J3XHpWYX0HKpY0GS2vn+G4=;
        b=SDLAq9M8cOeIgcAD/Ac8mjKiJbypnvCijoxe+//28TP6RolCxSk5x+Xx2SP0uE3tf4
         ARewSCbKj3PO/uss6Z7xl7Rg3ocs7rX9ToizeKcHOszRhOo38WzEmnUoPf5vz4d0nfvz
         sPx/CedYYvYdla5V/aCj2Pp/d2RuYiomREujxdohQYukgJthLjhEsw9LrSdrYE1P/edm
         POus1Ir2q+pzkTqMMSD03AoubDK6VXN5dHUri8tLF1/HFBDBDwgKRfnYTWhVOP0EGK5r
         JyN2MFeijchlkSytGfS2V1rzp6ioiTdNt+Ve5UKsgREDEeCD9ERR50gdxdM28H4AKN6D
         j9ew==
X-Gm-Message-State: AOJu0YxQmz8kQ/1j3StFrFWbLfJEYo72B2a4rQmwkNw0/6AYqdY/JxDO
        kmki2VbDcUnIM7MvYMyZRA==
X-Google-Smtp-Source: AGHT+IFrSfixUsrmT9b6CuYsw86rvPA+WGQxs4IHWd430ncNwPXZe4MqVFGDBRB1XpkPGggXgrT7hg==
X-Received: by 2002:a05:6e02:1786:b0:35c:21a7:ded7 with SMTP id y6-20020a056e02178600b0035c21a7ded7mr1673761ilu.24.1700693072307;
        Wed, 22 Nov 2023 14:44:32 -0800 (PST)
Received: from herring.priv ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id l16-20020a92d950000000b0035b120fe6f2sm177284ilq.67.2023.11.22.14.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 14:44:31 -0800 (PST)
Received: (nullmailer pid 2809718 invoked by uid 1000);
        Wed, 22 Nov 2023 22:44:30 -0000
From:   Rob Herring <robh@kernel.org>
To:     Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: gpio: brcmstb: drop unneeded quotes
Date:   Wed, 22 Nov 2023 15:44:24 -0700
Message-ID: <20231122224424.2809523-1-robh@kernel.org>
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
 Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml b/Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml
index 4a896ff7edc5..a1e71c974e79 100644
--- a/Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml
@@ -72,7 +72,7 @@ required:
   - reg
   - gpio-controller
   - "#gpio-cells"
-  - "brcm,gpio-bank-widths"
+  - brcm,gpio-bank-widths
 
 additionalProperties: false
 
-- 
2.42.0

