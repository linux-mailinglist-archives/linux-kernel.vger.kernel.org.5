Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075FB7D0012
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345316AbjJSQ5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235372AbjJSQ5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:57:40 -0400
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2C5132;
        Thu, 19 Oct 2023 09:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1697734655; bh=L4bDVsBHKN7+RRja9G15OQB01q7fFAPLNARB2e5JiEM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=S/Z1qBaWPanzT6m/mu6sXMK3jBV4hUsI6ZH4fMLpzTgW4WZV81ZObNpmUmWyK6uyT
         gVXWPPThGXXkOroDuFJTN54tifrTwyVmgEnFwr3y0YlwxG3gBrI06yjGJCCKOysp7K
         h7A4imdONbKMP7GJFtmBGpsu1O/oj/NIisGJPsYw=
From:   =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Ondrej Jirman <megi@xff.cz>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [RESEND PATCH v3 1/4] dt-bindings: mfd: rk8xx: Deprecate rockchip,system-power-controller
Date:   Thu, 19 Oct 2023 18:57:23 +0200
Message-ID: <20231019165732.3818789-2-megi@xff.cz>
In-Reply-To: <20231019165732.3818789-1-megi@xff.cz>
References: <20231019165732.3818789-1-megi@xff.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megi@xff.cz>

Deprecate support for this property in favor of standard
system-power-controller one.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 Documentation/devicetree/bindings/mfd/rockchip,rk805.yaml | 3 +++
 Documentation/devicetree/bindings/mfd/rockchip,rk808.yaml | 3 +++
 Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml | 3 +++
 Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml | 3 +++
 Documentation/devicetree/bindings/mfd/rockchip,rk818.yaml | 3 +++
 5 files changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk805.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk805.yaml
index 4992f71b6fc3..ec5e0fadef95 100644
--- a/Documentation/devicetree/bindings/mfd/rockchip,rk805.yaml
+++ b/Documentation/devicetree/bindings/mfd/rockchip,rk805.yaml
@@ -42,9 +42,12 @@ properties:
 
   rockchip,system-power-controller:
     type: boolean
+    deprecated: true
     description:
       Telling whether or not this PMIC is controlling the system power.
 
+  system-power-controller: true
+
   wakeup-source:
     type: boolean
     description:
diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk808.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk808.yaml
index f5908fa01a61..f1364c66cd62 100644
--- a/Documentation/devicetree/bindings/mfd/rockchip,rk808.yaml
+++ b/Documentation/devicetree/bindings/mfd/rockchip,rk808.yaml
@@ -37,9 +37,12 @@ properties:
 
   rockchip,system-power-controller:
     type: boolean
+    deprecated: true
     description:
       Telling whether or not this PMIC is controlling the system power.
 
+  system-power-controller: true
+
   wakeup-source:
     type: boolean
     description:
diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
index 7fb849ac74a7..382bb2f87a54 100644
--- a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
+++ b/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
@@ -37,9 +37,12 @@ properties:
 
   rockchip,system-power-controller:
     type: boolean
+    deprecated: true
     description:
       Telling whether or not this PMIC is controlling the system power.
 
+  system-power-controller: true
+
   wakeup-source:
     type: boolean
     description:
diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
index 269fb85b2027..92b1592e8942 100644
--- a/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
+++ b/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
@@ -38,9 +38,12 @@ properties:
 
   rockchip,system-power-controller:
     type: boolean
+    deprecated: true
     description:
       Telling whether or not this PMIC is controlling the system power.
 
+  system-power-controller: true
+
   wakeup-source:
     type: boolean
     description:
diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk818.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk818.yaml
index b57c4b005cf4..038804ff708d 100644
--- a/Documentation/devicetree/bindings/mfd/rockchip,rk818.yaml
+++ b/Documentation/devicetree/bindings/mfd/rockchip,rk818.yaml
@@ -37,9 +37,12 @@ properties:
 
   rockchip,system-power-controller:
     type: boolean
+    deprecated: true
     description:
       Telling whether or not this PMIC is controlling the system power.
 
+  system-power-controller: true
+
   wakeup-source:
     type: boolean
     description:
-- 
2.42.0

