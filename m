Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403D677D0EF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 19:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238847AbjHORX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 13:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238865AbjHORXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 13:23:40 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7881FF3;
        Tue, 15 Aug 2023 10:23:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1692120072; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=LjNBfpMYkJD6E8uZwt1/TWtP94oC1u2Hd52LngNilcnYVbt2GgwSL/ewtd0h4/E59d
    /J0LFgrV5uiJbUk6acV9JmcpzHDZFoSMVoFMr3qCwkYyebxE0I4e2X7wWO7pSJ+xUp4Y
    WTt+aFVa2TwtxAVO1BBUGddlF7JoXlQAWWidOtBud8tCuetpuYXApODrrvKgL+O/6vo6
    e5czqUYAUN9+9EqFNZnqCxGViRWKlRlWvIr4qp0yOCwFDJd2CKLspd/0uVZ+XVA6Et5v
    3gr6LwK/SqIlL/61paj/FZSA6V01fGlwzfnyvFT48cHJqDEY4bCdQuSHMyzNaPNdmA0b
    4SuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1692120072;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=1Tw0Ebkmty7SEImEM7L+xAczx0yUboBxaEEYcuNXidU=;
    b=odvsy4oDdj7CLks15veq3MOyYeJ9dUnSnR3Pgk544kQU+Q1gO91n8z6bfThOlS6/NI
    LUEjnfSu+81aat/I3Nxlsb0FGGpD8yWPz+LYoIUQPBmfbIkqWJb810xtNulq5PQ7yTCL
    OjAMlNUqshYQFFsoDXqlHpbkujOnBgRDFLX1C0KDPWEzIsKLbtuNi/upwLaAMvp7iUOg
    6oDT4BdebeOUhqumX6oLCNMpxgKnRbdr0SokhVMgkvhtVMODppQqzvh9z4JlpWCOjiQZ
    p6ElqAydRWl+F75sfs4axSdXBd+bZEOn2LPy1hKiER/mSJgqchk0+6Rw7te1m5qGFE/2
    2eTQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1692120072;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=1Tw0Ebkmty7SEImEM7L+xAczx0yUboBxaEEYcuNXidU=;
    b=pqbqg2TflsxNzlVhxoax2ZZp7RaF7vwTUJl73Mnap2vT9Jqhm+KAl21KpwYepwHz5S
    DpREBNTVLWMzqq8nJ4IuxAfIB3CS1Krxqh7xImg6juLWbaQUCV+DielF/BZlfbk43jDF
    TZS23t2UV8wfR5t2iBCdGKehl1GDFr8dstzBrUWTnKzrhkvwYkb19a1JOOv6IGEJFASN
    bsIHlJpHIUMM37Yo/f5DpfoQAxhy5u/M5UafHAKWIjoSesiacWTUxUyomSC7W7MH5F60
    IRxuI2nHIHRUbTiIaaCMcUayjGWDFZvTig6dLLjLF7eU1Q0h0KCG2veWtDilJQ846KHD
    eOFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1692120072;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=1Tw0Ebkmty7SEImEM7L+xAczx0yUboBxaEEYcuNXidU=;
    b=/j3lkMtCnRyTlkshS9q96+7GIS+NVM8QsLsI4SSyYDm/aRg9c5ZXVxEDwuIsrBmCgg
    4pGxTGQqGXpBt6d+rTCQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4F1mw=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.0 DYNA|AUTH)
    with ESMTPSA id v41b8bz7FHLB0YU
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 15 Aug 2023 19:21:11 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Tue, 15 Aug 2023 19:21:04 +0200
Subject: [PATCH v3 1/3] dt-bindings: leds: aw2013: Document interrupt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230815-aw2013-vio-v3-1-2505296b0856@gerhold.net>
References: <20230815-aw2013-vio-v3-0-2505296b0856@gerhold.net>
In-Reply-To: <20230815-aw2013-vio-v3-0-2505296b0856@gerhold.net>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nikita Travkin <nikita@trvn.ru>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AW2013 has an optional interrupt pin "INTN" which is used to report
completion of started operations (e.g. power up or LED breath effects).
The driver does not use it (yet) but it should be described for
completeness inside the DT schema.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 Documentation/devicetree/bindings/leds/leds-aw2013.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/leds-aw2013.yaml b/Documentation/devicetree/bindings/leds/leds-aw2013.yaml
index 08f3e1cfc1b1..a0a0dabcfbf3 100644
--- a/Documentation/devicetree/bindings/leds/leds-aw2013.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-aw2013.yaml
@@ -20,6 +20,11 @@ properties:
   reg:
     maxItems: 1
 
+  interrupts:
+    maxItems: 1
+    description: Open-drain, low active interrupt pin "INTN".
+      Used to report completion of operations (power up, LED breath effects).
+
   vcc-supply:
     description: Regulator providing power to the "VCC" pin.
 
@@ -52,6 +57,7 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
     #include <dt-bindings/leds/common.h>
 
     i2c {
@@ -61,6 +67,7 @@ examples:
         led-controller@45 {
             compatible = "awinic,aw2013";
             reg = <0x45>;
+            interrupts = <42 IRQ_TYPE_LEVEL_LOW>;
             #address-cells = <1>;
             #size-cells = <0>;
 

-- 
2.41.0

