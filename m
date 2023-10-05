Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCCB7BA612
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbjJEQXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242594AbjJEQVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:21:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FF3448E;
        Thu,  5 Oct 2023 09:11:12 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:4c53:5fd0:f25b:b0dd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AA09A6607333;
        Thu,  5 Oct 2023 17:11:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696522271;
        bh=I2txkEvnu/MKP501CqRC09fArHHso7r5qQlX44V5U/4=;
        h=From:To:Cc:Subject:Date:From;
        b=bja4xJPCXX+3IjNN6av+ZzwBFfbJqowvhnre7vfnPmbr3LwXnl86b2trfV77Edku7
         RiNYy+MxmW8sRPseLaP0qV48GMJ8Nnqt6m0B1agC15rOJz486V+EafHO3f/mQaYW2D
         ZGOI9rDm2THSEjkMUgb9qfeRLdvmKGOzb3AX6Ea65/7BZia2MhiivbUoynANJFJJBD
         nXiPXEYxZEm8aoKgAQB44NVpTjbW604g/ENWh3C4fJpBPG8JxObpP2A5S6KViJBN/e
         1hku+vbu/6UwTTEhndHSKxjc0mGRJew0sro4jzUs62nuxuG34Z4AqnmRV7BDqq2kxs
         VKrlPelRRA5vQ==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        heiko@sntech.de
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v2] dt-bindings: media: rockchip: Add resets property into decoder node
Date:   Thu,  5 Oct 2023 18:11:07 +0200
Message-Id: <20231005161107.269303-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RK3588 AV1 decoder hardware block have resets lines and driver code
already suppport it.
Update yaml file to be aligned with this feature.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
version 2:
- Add description for resets lines
 Documentation/devicetree/bindings/media/rockchip-vpu.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
index 772ec3283bc6..c57e1f488895 100644
--- a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
+++ b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
@@ -68,6 +68,13 @@ properties:
   iommus:
     maxItems: 1
 
+  resets:
+    items:
+      - description: AXI reset line
+      - description: AXI bus interface unit reset line
+      - description: APB reset line
+      - description: APB bus interface unit reset line
+
 required:
   - compatible
   - reg
-- 
2.39.2

