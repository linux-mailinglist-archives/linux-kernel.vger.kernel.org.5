Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25ACE7EC1F0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 13:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343724AbjKOMOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 07:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbjKOMNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 07:13:55 -0500
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223B4123;
        Wed, 15 Nov 2023 04:13:46 -0800 (PST)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 8881020718;
        Wed, 15 Nov 2023 13:13:43 +0100 (CET)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Adrien Grassein <adrien.grassein@gmail.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 2/3] dt-bindings: display: bridge: lt8912b: Add power supplies
Date:   Wed, 15 Nov 2023 13:13:37 +0100
Message-Id: <20231115121338.22959-3-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231115121338.22959-1-francesco@dolcini.it>
References: <20231115121338.22959-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Add Lontium lt8912b power supplies.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 .../display/bridge/lontium,lt8912b.yaml       | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,lt8912b.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt8912b.yaml
index f201ae4af4fb..2cef25215798 100644
--- a/Documentation/devicetree/bindings/display/bridge/lontium,lt8912b.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt8912b.yaml
@@ -55,6 +55,27 @@ properties:
       - port@0
       - port@1
 
+  vcchdmipll-supply:
+    description: A 1.8V supply that powers the HDMI PLL.
+
+  vcchdmitx-supply:
+    description: A 1.8V supply that powers the HDMI TX part.
+
+  vcclvdspll-supply:
+    description: A 1.8V supply that powers the LVDS PLL.
+
+  vcclvdstx-supply:
+    description: A 1.8V supply that powers the LVDS TX part.
+
+  vccmipirx-supply:
+    description: A 1.8V supply that powers the MIPI RX part.
+
+  vccsysclk-supply:
+    description: A 1.8V supply that powers the SYSCLK.
+
+  vdd-supply:
+    description: A 1.8V supply that powers the digital part.
+
 required:
   - compatible
   - reg
-- 
2.25.1

