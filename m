Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC92675C55A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 13:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbjGULCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 07:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjGULAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 07:00:15 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25F01BC0;
        Fri, 21 Jul 2023 03:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1689937177; x=1721473177;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=77A3b9GULZOCaolSv78/eefyFy3DTEQEZitbAQnFINI=;
  b=h5IX9bMB77Nj/xawwe0qPuopvLR9nxvqVBIAHb+Ei4UaFMoH7ZTbz/qt
   VQSkHdvutXHzMuHotjEW62tmbzs5zgp+r3WZQe3i5jh62zOSCHC0GqGqi
   VXn3FhRGQrFXfHC7CAGEp5F4BwIRWIEB9pttN0jgz5hM+G8efTXYYjAfU
   mC5swwJA9LeaZDriWdqbzto8W7jXWqYAxRZh8yj30hjf86U7PHir+6KvE
   mJ+Sxf607+O5/ctupApkY9mJJuH3SzhbacyrFQIYtFYfF9e/bZ6RbKYwU
   m/MDWG+xCXaefuDuyYBgWTQUBUnYbtydUV3MJln0Xkn20+EeER0LLRaqf
   w==;
X-IronPort-AV: E=Sophos;i="6.01,220,1684792800"; 
   d="scan'208";a="32052494"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 21 Jul 2023 12:59:35 +0200
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.20])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id D118F280078;
        Fri, 21 Jul 2023 12:59:34 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 1/3] dt-bindings: arm: ti: Add compatible for AM642-based TQMaX4XxL SOM family and carrier board
Date:   Fri, 21 Jul 2023 12:59:00 +0200
Message-Id: <6db614465a281f802771994399ebb1040acb67bc.1689936866.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For now only the MBaX4Xx carrier board is defined.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index 577eee95c8932..ae56170bf2d25 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -72,6 +72,13 @@ properties:
           - const: phytec,am64-phycore-som
           - const: ti,am642
 
+      - description: K3 AM642 SoC on TQ-Systems TQMaX4XxL SoM
+        item:
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

