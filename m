Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F561752EA0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 03:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbjGNBiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 21:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjGNBiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 21:38:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D872D61;
        Thu, 13 Jul 2023 18:38:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8529F61BB8;
        Fri, 14 Jul 2023 01:38:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4F8C433CA;
        Fri, 14 Jul 2023 01:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689298681;
        bh=ZCtk/JiU9swJ+bePtmvtWrQdxyBhpSeCtAN3ecv4HUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A0K+HtJDDCdq80eVoRo+GkyLE+/9F6xazEDDQC2KTgSI7y2DWuOi7c/y3FAz0g8A8
         kLPIeeyFWCAv8DzyjQENzBj0jH5InVUpWg/d+sC/8Qjc+dYnT+3EjOtivMZrvheFkG
         e/snkUhNmISUVLLUUIAslN/CGdwcAPI4a4DJ/B9HuC/K0hzoSVem9Au6ctjdgGPOsZ
         6rH6J2Sg4m/70vWF6wiUNd3erF7w8EGF2Ipt8/pcav6VQjzcpS5Sz97aUdN5vt6ouI
         5lfWHL8Ba6YwdZe8RvioFzhBq8R25nk86SivsZtR9wS28qJcMnYdXnQorjCJhjsw5s
         kkqyhECfAng0w==
Received: by mercury (Postfix, from userid 1000)
        id CDBC61067680; Fri, 14 Jul 2023 03:37:58 +0200 (CEST)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Gerald Loacker <gerald.loacker@wolfvision.net>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 02/19] dt-bindings: display: st7789v: add Inanbo T28CP45TN89
Date:   Fri, 14 Jul 2023 03:37:39 +0200
Message-Id: <20230714013756.1546769-3-sre@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230714013756.1546769-1-sre@kernel.org>
References: <20230714013756.1546769-1-sre@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible value for Inanbo t28cp45tn89 and make reset GPIO non
mandatory, since it might not be connected to the CPU.

Reviewed-by: Michael Riesch <michael.riesch@wolfvision.net>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 .../devicetree/bindings/display/panel/sitronix,st7789v.yaml  | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml b/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
index fa6556363cca..75e935f0547b 100644
--- a/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
+++ b/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
@@ -15,7 +15,9 @@ allOf:
 
 properties:
   compatible:
-    const: sitronix,st7789v
+    enum:
+      - inanbo,t28cp45tn89-v17
+      - sitronix,st7789v
 
   reg: true
   reset-gpios: true
@@ -33,7 +35,6 @@ properties:
 required:
   - compatible
   - reg
-  - reset-gpios
   - power-supply
 
 unevaluatedProperties: false
-- 
2.40.1

