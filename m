Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D6680730A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442183AbjLFOuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442127AbjLFOuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:50:51 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB414D49;
        Wed,  6 Dec 2023 06:50:55 -0800 (PST)
Received: from i53875b61.versanet.de ([83.135.91.97] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1rAtEe-0002nV-3l; Wed, 06 Dec 2023 15:50:48 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, heiko@sntech.de, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        quentin.schulz@theobroma-systems.com,
        Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH] dt-bindings: PCI: dwc: rockchip: document optional pcie reference clock input
Date:   Wed,  6 Dec 2023 15:50:41 +0100
Message-Id: <20231206145041.667900-1-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@cherry.de>

On some boards the 100MHz PCIe reference clock to both controller and
devices is controllable. Add that clock to the list of clocks.

The clock is optional, so the minItems stays the same.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
index 1ae8dcfa072c..5f719218c472 100644
--- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
@@ -49,6 +49,7 @@ properties:
       - description: APB clock for PCIe
       - description: Auxiliary clock for PCIe
       - description: PIPE clock
+      - description: Reference clock for PCIe
 
   clock-names:
     minItems: 5
@@ -59,6 +60,7 @@ properties:
       - const: pclk
       - const: aux
       - const: pipe
+      - const: ref
 
   interrupts:
     items:
-- 
2.39.2

