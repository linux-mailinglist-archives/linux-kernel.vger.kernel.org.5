Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5C07AA894
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 07:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjIVFup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 01:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjIVFui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 01:50:38 -0400
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32332C2;
        Thu, 21 Sep 2023 22:50:29 -0700 (PDT)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout2.routing.net (Postfix) with ESMTP id 574835FAFC;
        Fri, 22 Sep 2023 05:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1695361827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UoH4W3986fDzxNI5gGh01oTwLD5puh/l8B+NZqmUkdE=;
        b=Z27W9aaUiUcLJfBEEMIP/D5/ub8RhY31duqvE/rHZAwtGA7V1kEqTHc3r/2gBJ/R26Vqo+
        JUDYNOB3+Q1gmGW/cmPrlefKbY1U+38S0kbsHg89d5+sTcQTwCjq/NyxPg/Xoloo3PvUq2
        q3DSPOM2DChvt4gDwxJbvYgfS2gDUv0=
Received: from frank-G5.. (fttx-pool-217.61.149.125.bambit.de [217.61.149.125])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id 567E540625;
        Fri, 22 Sep 2023 05:50:26 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 2/4] dt-bindings: thermal: mediatek: Add LVTS thermal sensors for mt7988
Date:   Fri, 22 Sep 2023 07:50:18 +0200
Message-Id: <20230922055020.6436-3-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922055020.6436-1-linux@fw-web.de>
References: <20230922055020.6436-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: e5a5378d-0ffe-43d2-843a-7836791bd6a3
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Add sensor constants for MT7988.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
v2:
- new patch (moved from driver code to binding header)
- give sensors more meaningful names
---
 include/dt-bindings/thermal/mediatek,lvts-thermal.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/dt-bindings/thermal/mediatek,lvts-thermal.h b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
index 8fa5a46675c4..8c1fdc18cf34 100644
--- a/include/dt-bindings/thermal/mediatek,lvts-thermal.h
+++ b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
@@ -7,6 +7,15 @@
 #ifndef __MEDIATEK_LVTS_DT_H
 #define __MEDIATEK_LVTS_DT_H
 
+#define MT7988_CPU_0		0
+#define MT7988_CPU_1		1
+#define MT7988_ETH2P5G_0	2
+#define MT7988_ETH2P5G_1	3
+#define MT7988_TOPS_0		4
+#define MT7988_TOPS_1		5
+#define MT7988_ETHWARP_0	6
+#define MT7988_ETHWARP_1	7
+
 #define MT8195_MCU_BIG_CPU0     0
 #define MT8195_MCU_BIG_CPU1     1
 #define MT8195_MCU_BIG_CPU2     2
-- 
2.34.1

