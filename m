Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1F680AA36
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235889AbjLHRM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbjLHRMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:12:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C041989
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 09:13:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56995C433B9;
        Fri,  8 Dec 2023 17:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702055581;
        bh=eOwkSq/WwMGsBDJxIoKyyiwasgmQQYpNauvY4yRRwsE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KHk8a5tZwx6HzsT8T5BnndKAcsPltUq64Ek4Pr5fovixj2Aq/i9OEQXYhY+w6CuIB
         iQ713l1de5Asz5Ax4hK6RGHX7DC9QEYGeaWRNgbiDq3hDTLN7j1D5mgaj0jjqzZ7Xu
         1aB87nlMv7p+TlIYR4E4rcHY/JiUJpxGIg++fsAWcK87pRUKQYMBgZHsDiDJ5g+U8/
         GtwCtIK7kY0TJZE4KCj4b6NFP89gICI5qYZkGl0Ja20tWFXDy8Y3/wQVROVliaZjzC
         KkeyJScyQ+CQ8bkVKg1sPQwblR2SFrf4hHKg9DAsw6n0GcGtDVGerkBdQMiMAiG08l
         NfWbBDmM8zYqQ==
From:   Conor Dooley <conor@kernel.org>
To:     linux-riscv@lists.infradead.org
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH RESEND v1 2/7] dt-bindings: can: mpfs: add missing required clock
Date:   Fri,  8 Dec 2023 17:12:24 +0000
Message-Id: <20231208-palpitate-passable-c79bacf2036c@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231208-reenter-ajar-b6223e5134b3@spud>
References: <20231208-reenter-ajar-b6223e5134b3@spud>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1442; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=t/lsdJsWux+0djN2ESjLKlgMF40rkcl8R8FM1XRhzgA=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKnFfuUPWvbyRO6Tbtj3XqD4/x2h2j8HPA3+TjArX7qZR 3nqsvs/O0pZGMQ4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjCR9GaGP9yJsZf/zW2rSddd 9SykPKmwPsXIv9vR85b+VLVjN0PVQxn++zcH+hXx6GgvW2xp8sDt9Pna46/0LFtPtVv3PxGL+zW bAQA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

The CAN controller on PolarFire SoC has an AHB peripheral clock _and_ a
CAN bus clock. The bus clock was omitted when the binding was written,
but is required for operation. Make up for lost time and add it.

Cautionary tale in adding bindings without having implemented a real
user for them perhaps.

Fixes: c878d518d7b6 ("dt-bindings: can: mpfs: document the mpfs CAN controller")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/net/can/microchip,mpfs-can.yaml    | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml b/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml
index 45aa3de7cf01..05f680f15b17 100644
--- a/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml
+++ b/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml
@@ -24,7 +24,10 @@ properties:
     maxItems: 1
 
   clocks:
-    maxItems: 1
+    maxItems: 2
+    items:
+      - description: AHB peripheral clock
+      - description: CAN bus clock
 
 required:
   - compatible
@@ -39,7 +42,7 @@ examples:
     can@2010c000 {
         compatible = "microchip,mpfs-can";
         reg = <0x2010c000 0x1000>;
-        clocks = <&clkcfg 17>;
+        clocks = <&clkcfg 17>, <&clkcfg 37>;
         interrupt-parent = <&plic>;
         interrupts = <56>;
     };
-- 
2.39.2

