Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8358E766AA3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235911AbjG1KaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbjG1K3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:29:52 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC9644A5;
        Fri, 28 Jul 2023 03:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690540116; x=1722076116;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HWrdd9pLnOMwuwU7EGPxFgfJcPWwAXMfj31MXLpYoBY=;
  b=qAE93su+ObBozZKN1WCVjsEoaSl3qsf+7S1d1lpyxnozFteDOwyY0lYq
   6IuvovUazXOOD5HsB9kzHXhF8uoPDQoY52NcRHEMSkJT8Vj7yfiE0kqic
   6Vm5egMF5Wago7Z4w4qOX/bgJZ8VIFtnlXuiZeak5k6R4o39nU0vO1O3X
   x39kqXX0FNmytCJcTacWoDbS76LUDVND3ttRQJAco0LjS5IF4L8m57gn8
   zOCSJmhyH/raVgANTrgfilMgV1FW+A2Ab/u4sBtMub4qgJTvgkWHq0egn
   ZpDNumGuSBYV1UY+ZZwquOnVXAnPFsY4sbgefaNNWvUAg5yz3vwZgfCDy
   g==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="238401621"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2023 03:28:35 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Jul 2023 03:28:35 -0700
Received: from che-lt-i67070.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 28 Jul 2023 03:28:30 -0700
From:   Varshini Rajendran <varshini.rajendran@microchip.com>
To:     <claudiu.beznea@microchip.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <codrin.ciubotariu@microchip.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <varshini.rajendran@microchip.com>
Subject: [PATCH v3 31/50] ASoC: dt-bindings: microchip: add sam9x7
Date:   Fri, 28 Jul 2023 15:58:28 +0530
Message-ID: <20230728102828.266861-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sam9x7 compatible in the DT documentation.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 .../bindings/sound/microchip,sama7g5-i2smcc.yaml      | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/microchip,sama7g5-i2smcc.yaml b/Documentation/devicetree/bindings/sound/microchip,sama7g5-i2smcc.yaml
index 651f61c7c25a..fb630a184350 100644
--- a/Documentation/devicetree/bindings/sound/microchip,sama7g5-i2smcc.yaml
+++ b/Documentation/devicetree/bindings/sound/microchip,sama7g5-i2smcc.yaml
@@ -24,9 +24,14 @@ properties:
     const: 0
 
   compatible:
-    enum:
-      - microchip,sam9x60-i2smcc
-      - microchip,sama7g5-i2smcc
+    oneOf:
+      - enum:
+          - microchip,sam9x60-i2smcc
+          - microchip,sama7g5-i2smcc
+      - items:
+          - enum:
+              - microchip,sam9x7-i2smcc
+          - const: microchip,sam9x60-i2smcc
 
   reg:
     maxItems: 1
-- 
2.25.1

