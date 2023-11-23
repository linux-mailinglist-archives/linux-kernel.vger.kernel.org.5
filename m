Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B247F606E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345535AbjKWNiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345501AbjKWNh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:37:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452001B3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:38:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6FEC433C7;
        Thu, 23 Nov 2023 13:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700746685;
        bh=MT6oWZWBbySd/bCRRRjnP/MchEhM4olMaAyFtTUdpCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uTOK77TuCBkGedL2lsDha1qAEjPwTsuWBvtYcX+YZtvynUSxRyVL1nE9soPgqo9jG
         4BBD3BS7STDI2SKGDeLvUKNQCnVVoiXQVXazOoobwIMleUPV9Buplj6TCgGO4YAVAQ
         M89CYNGdX5gPZbDgYuaTR45BZlfTPrOtLJx1JojXZ9k/wTcZnLWlD5+HRyhV5+BwSF
         qCuW6kFlo6qLwbkM0lM+ciie+/YYwBZQQeroIRqv2m1S1gzA3lRTf1WC4h4X9gNt4q
         SvamQg6ODrOFiKDgfhwz209pL/8h6SOHvfMD+hEf1XCRUHyRofFYhyun0TOLH6muYp
         qxFW/Fpesct4g==
From:   Michael Walle <mwalle@kernel.org>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Xinlei Lee <xinlei.lee@mediatek.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, Michael Walle <mwalle@kernel.org>
Subject: [PATCH 1/4] dt-bindings: display: mediatek: dsi: add compatible for MediaTek MT8195
Date:   Thu, 23 Nov 2023 14:37:46 +0100
Message-Id: <20231123133749.2030661-2-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123133749.2030661-1-mwalle@kernel.org>
References: <20231123133749.2030661-1-mwalle@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible string for MediaTek MT8195 SoC, using the same DSI
block as the MT8183.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 .../devicetree/bindings/display/mediatek/mediatek,dsi.yaml    | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml
index 537e5304b730..4a7a9ff21996 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml
@@ -35,6 +35,10 @@ properties:
           - enum:
               - mediatek,mt6795-dsi
           - const: mediatek,mt8173-dsi
+      - items:
+          - enum:
+              - mediatek,mt8195-dsi
+          - const: mediatek,mt8183-dsi
 
   reg:
     maxItems: 1
-- 
2.39.2

