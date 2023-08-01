Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C8A76AD85
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjHAJ34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjHAJ3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:29:39 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA3630D1;
        Tue,  1 Aug 2023 02:28:22 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id D333C409EE;
        Tue,  1 Aug 2023 14:09:32 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1690880973; bh=U1j/diLakc7eeJJZQaw8z9VtEXUjEbLYHFb9kbts2CU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=LE8CRj6NMfZFcjIoDFpvmBf4LI2D559t92MvQL+hKSSbpmzMOCvgFOhMANvYDkRCz
         4sn+GF1SzJG3m+bNLm7G/rxexrhcUIX4ia9+y5YG7rvCN3WIEjK/xpw1dGHhzyfSLY
         jqkHtfAfWas4WeFVvo8UpwQi3+mz9zS3hSv2A/Kp1BWMza7t66I2RAZscv5f4zpRA7
         c2UwgVZmZzSTTE6I9RliWHQ64EoON5Z1UrsjBhQ+Lhii6HKmZgZYzjBde2Qo8o5mRw
         X71wkcIqKfXGhBFevrOZAYBAEVdbdZJOHGbUbjNFa9d6GoUFDPtEzmlDtC1+Gf9Y6v
         sMcENCOejEqsg==
From:   Nikita Travkin <nikita@trvn.ru>
Date:   Tue, 01 Aug 2023 14:09:25 +0500
Subject: [PATCH v4 1/2] dt-bindings: input: zinitix: Document touch-keys
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230801-zinitix-tkey-v4-1-b85526c5a474@trvn.ru>
References: <20230801-zinitix-tkey-v4-0-b85526c5a474@trvn.ru>
In-Reply-To: <20230801-zinitix-tkey-v4-0-b85526c5a474@trvn.ru>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Srba <Michael.Srba@seznam.cz>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>,
        Rob Herring <robh@kernel.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1461; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=U1j/diLakc7eeJJZQaw8z9VtEXUjEbLYHFb9kbts2CU=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBkyMvLhj0qHLaiJDPiczKJDfYPM5k47g/XHQZ3V
 uk96kon7ZqJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZMjLywAKCRBDHOzuKBm/
 dc8+D/9fxHBKflNDuHCnv1v7HUrFlycVR5DG8Pzf1kHdkjJ/md0OFLT9mGoJql9W/KsW8vNkvdF
 9YoZTqkQSb6k6kJgUClEfyrzaeuPFi2raiGEopNgE96BWfizcMZFuGl5j4qBMjazcQF05O7V9Se
 S4KDeZLkd7IlCSbq8uq78+pNoZ3U/WEHfiRAB+Bsc00X/9KdfipZR9eiEFMF0AuWmS43iUMX8a/
 EUsbt5gt2s6yzAXLZz671KUTN9OjHVFC/hR59HrV9lVs3U1TWpQGqHns0we4RgDdo8TeT7ZD1Ey
 JJQI7jMA22Q4VCiQjlbe4Xuwg9YFK8Q1RPWb5dwRD6gAD/E64EqqDRjEnBpXBsUu7m/Sw/v4WJH
 SB7pmce6I/00qIKXavR3vj4BlhoJJeWtL5dAPeFldD5o0R0STj6woPR/wUhJHSb1nhz+KBGVJj5
 +W/oRq6h7lgh8CAIPAWmnvK0r4issE9/QndK6V1Vp+d6+2iMiJRLBxLh6nauawGZmETjij6HTJx
 ww2cUbWreVYK5YVl+33MALUpTCia9aE0XOS5VXje7eaZNlwD/WNV5CsDF9Xr8OXxFxASuqDHOnV
 11QsZZd2bmxWDOaFljO0knJuCHCb+s1Xo8zhpRqtVzjmbIvJSLDItx/xhQSnMk9LWYOLhtv68p0
 bJrzE7cUfGBa8ew==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some configurations the touch controller can support the touch-keys.
Document the linux,keycodes property that enables those keys and
specifies the keycodes that should be used to report the key events.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 .../devicetree/bindings/input/touchscreen/zinitix,bt400.yaml   | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/zinitix,bt400.yaml b/Documentation/devicetree/bindings/input/touchscreen/zinitix,bt400.yaml
index b1507463a03e..3f663ce3e44e 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/zinitix,bt400.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/zinitix,bt400.yaml
@@ -16,6 +16,7 @@ maintainers:
 
 allOf:
   - $ref: touchscreen.yaml#
+  - $ref: ../input.yaml#
 
 properties:
   $nodename:
@@ -79,6 +80,15 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [1, 2]
 
+  linux,keycodes:
+    description:
+      This property specifies an array of keycodes assigned to the
+      touch-keys that can be present in some touchscreen configurations.
+      If the touch-keys are enabled, controller firmware will assign some
+      touch sense lines to those keys.
+    minItems: 1
+    maxItems: 8
+
   touchscreen-size-x: true
   touchscreen-size-y: true
   touchscreen-fuzz-x: true

-- 
2.41.0

