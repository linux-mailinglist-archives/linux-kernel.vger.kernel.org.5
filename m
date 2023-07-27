Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744EF7654CD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 15:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbjG0NVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 09:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjG0NVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 09:21:33 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29096271D;
        Thu, 27 Jul 2023 06:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1690464090; x=1722000090;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yLo9F0Lr6izjUbXtfJOKO7CgcAALSdCDeTkHvKXEYVo=;
  b=WQPO8UQYq4f80OEaSV9v04rjV7p0oROWlmoVjyj2CK+EyMzeIO8eYUWc
   WNPAH+fam0EuHXDFfHRjMcPa/Uj5U4x0Bh71v/y6q4GySRG3bw3XhYDI/
   lRrJBB1mIvvQUfvDa/kjxkIBp2BmO3pUT4OZH6adnWrWaMantuQR04LND
   EuaNa/l5hKeKQNZs68+Sda4OurVVLrR58VgtlD+kpfeiDJHqMRWjvzBE3
   XdgDJuG7fS/qTzwJAhtQRxOcLx9uh/MbFGS3IYNEdMFrQqBod85GZwOAG
   KTMXOxvijE4C6SyIrfbubiUJovn4CPep0X+o9h/HVyTQcVv0UNOyAFBYJ
   A==;
X-IronPort-AV: E=Sophos;i="6.01,234,1684792800"; 
   d="scan'208";a="32156709"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 27 Jul 2023 15:21:28 +0200
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.20])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 1BC35280075;
        Thu, 27 Jul 2023 15:21:28 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v3 1/3] dt-bindings: arm: ti: Add compatible for AM642-based TQMaX4XxL SOM family and carrier board
Date:   Thu, 27 Jul 2023 15:21:18 +0200
Message-Id: <e4283d6af59c77d2f690e070eb948dd9142a2276.1690463382.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For now only the MBaX4Xx carrier board is defined.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---

v3: add Acked-by from v2
v2: fix typo in "items" key

 Documentation/devicetree/bindings/arm/ti/k3.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index 577eee95c8932..5ca6af492507e 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -72,6 +72,13 @@ properties:
           - const: phytec,am64-phycore-som
           - const: ti,am642
 
+      - description: K3 AM642 SoC on TQ-Systems TQMaX4XxL SoM
+        items:
+          - enum:
+              - tq,am642-tqma6442l-mbax4xxl # MBaX4XxL base board
+          - const: tq,am642-tqma6442l
+          - const: ti,am642
+
       - description: K3 AM654 SoC
         items:
           - enum:
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

