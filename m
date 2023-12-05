Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F6E805B86
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345906AbjLEPIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345887AbjLEPIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:08:20 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5879CBF;
        Tue,  5 Dec 2023 07:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:subject:date:message-id:reply-to;
        bh=ipE4edW28T4DIP0GnQdi1keyJ3mpaXWRmPh06e6uG5U=; b=Lr9JeFoS+zrFPnHPDPALivXO94
        mUNh+nvr0NR8XRZUu7EweJMYRfa+QBNOs02XHOwwFk35NYr6F9j35XpoY6G8W+PVAJXzlqTi4MBtg
        ng+Iqqx0hcPsC7/RoAYaCIgcKzCv8XQ2fAg6MKus+jBfbgRe8gDJz5HWDYcSr43LXSIs=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:34220 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1rAX24-00008q-Rq; Tue, 05 Dec 2023 10:08:21 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        leoyang.li@nxp.com, robh@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, hugo@hugovil.com,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date:   Tue,  5 Dec 2023 10:08:13 -0500
Message-Id: <20231205150814.344883-3-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231205150814.344883-1-hugo@hugovil.com>
References: <20231205150814.344883-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
Subject: [PATCH v5 2/3] dt-bindings: arm: fsl: add RVE gateway board
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Add DT compatible string for RVE gateway board based on a Variscite
VAR-SOM-NANO with a NXP MX8MN nano CPU.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 32b195852a75..5b98a17b65b5 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1022,7 +1022,9 @@ properties:
 
       - description: Variscite VAR-SOM-MX8MN based boards
         items:
-          - const: variscite,var-som-mx8mn-symphony
+          - enum:
+              - rve,rve-gateway # i.MX8MN RVE Gateway Board
+              - variscite,var-som-mx8mn-symphony
           - const: variscite,var-som-mx8mn
           - const: fsl,imx8mn
 
-- 
2.39.2

