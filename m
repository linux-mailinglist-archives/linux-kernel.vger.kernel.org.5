Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3C1761DB0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbjGYPxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjGYPxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:53:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3075691;
        Tue, 25 Jul 2023 08:53:05 -0700 (PDT)
Received: from eugen-station.. (unknown [82.76.24.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ehristev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DD2386606F9F;
        Tue, 25 Jul 2023 16:53:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690300383;
        bh=oTwjKmbIzP/ICl+gGyGP/1DH20byUoeqWEtx/veTs3o=;
        h=From:To:Cc:Subject:Date:From;
        b=JbyBladbKjcskcYcNNABx1wJ/caoCgyx6Ixz11oqpXplKT3bjW0LG8kuPflsO/Zif
         renQs/CYIAVyKv7FcLymQrorKZxhcfIkkfx0njUNVb7la5dGVo5aPfPufXc2yHMnfx
         EXFgdsmcXTtePOR1ckYdS4t7Yhx8rKW99t/WYqbKmfVnhIKCvIhk1O1aCZ9kwnZlpZ
         rk8O5CW2Cspxzdr7jaEh1AfhMmA+UnY+6J3x+m2EZjvL14jcXV/sNyt+qeP4RFAWlt
         AEZ8UVITATGZDICbwaB/RkA4wvFERFsogJ1ew6WGVnnP1s8jtfAeOrfqFAmgZ1+Vnb
         1fTcUIui7rA+w==
From:   Eugen Hristev <eugen.hristev@collabora.com>
To:     linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     david.wu@rock-chips.com, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, kernel@collabora.com,
        Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PATCH] dt-bindings: net: rockchip-dwmac: fix {tx|rx}-delay defaults in schema
Date:   Tue, 25 Jul 2023 18:52:54 +0300
Message-Id: <20230725155254.664361-1-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The defaults are specified in the description instead of being specified
in the schema.
Fix it by adding the default value in the `default` field.

Fixes: b331b8ef86f0 ("dt-bindings: net: convert rockchip-dwmac to json-schema")
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
 Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
index bb943c96c196..6d08260ad828 100644
--- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
@@ -92,12 +92,14 @@ properties:
     $ref: /schemas/types.yaml#/definitions/phandle
 
   tx_delay:
-    description: Delay value for TXD timing. Range value is 0~0x7F, 0x30 as default.
+    description: Delay value for TXD timing. Range value is 0~0x7F.
     $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0x30
 
   rx_delay:
-    description: Delay value for RXD timing. Range value is 0~0x7F, 0x10 as default.
+    description: Delay value for RXD timing. Range value is 0~0x7F.
     $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0x10
 
   phy-supply:
     description: PHY regulator
-- 
2.34.1

