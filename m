Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD597F71E8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345657AbjKXKo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345640AbjKXKo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:44:57 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42EF12B;
        Fri, 24 Nov 2023 02:45:01 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 04AA524E0D8;
        Fri, 24 Nov 2023 18:44:54 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 24 Nov
 2023 18:44:54 +0800
Received: from yang-virtual-machine.localdomain (113.72.144.198) by
 EXMBX171.cuchost.com (172.16.6.91) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Fri, 24 Nov 2023 18:44:52 +0800
From:   Shengyang Chen <shengyang.chen@starfivetech.com>
To:     <devicetree@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
CC:     <neil.armstrong@linaro.org>, <quic_jesszhan@quicinc.com>,
        <sam@ravnborg.org>, <airlied@gmail.com>, <daniel@ffwll.ch>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <florian.fainelli@broadcom.com>,
        <bcm-kernel-feedback-list@broadcom.com>, <eric@anholt.net>,
        <thierry.reding@gmail.com>, <changhuang.liang@starfivetech.com>,
        <keith.zhao@starfivetech.com>, <shengyang.chen@starfivetech.com>,
        <jack.zhu@starfivetech.com>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/2] dt-bindings: display: panel: raspberrypi: Add compatible property for waveshare 7inch touchscreen panel
Date:   Fri, 24 Nov 2023 18:44:50 +0800
Message-ID: <20231124104451.44271-2-shengyang.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231124104451.44271-1-shengyang.chen@starfivetech.com>
References: <20231124104451.44271-1-shengyang.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.144.198]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The waveshare 7inch touchscreen panel is a kind of raspberrypi pi
panel and it can be drived by panel-raspberrypi-touchscreen.c.
Add compatible property for it.

Signed-off-by: Keith Zhao <keith.zhao@starfivetech.com>
Signed-off-by: Shengyang Chen <shengyang.chen@starfivetech.com>
---
 .../bindings/display/panel/raspberrypi,7inch-touchscreen.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/panel/raspberrypi,7inch-touchscreen.yaml b/Documentation/devicetree/bindings/display/panel/raspberrypi,7inch-touchscreen.yaml
index 22a083f7bc8e..e4e6cb4d4e5b 100644
--- a/Documentation/devicetree/bindings/display/panel/raspberrypi,7inch-touchscreen.yaml
+++ b/Documentation/devicetree/bindings/display/panel/raspberrypi,7inch-touchscreen.yaml
@@ -22,7 +22,9 @@ description: |+
 
 properties:
   compatible:
-    const: raspberrypi,7inch-touchscreen-panel
+    enum:
+      - raspberrypi,7inch-touchscreen-panel
+      - waveshare,7inch-touchscreen-panel
 
   reg:
     const: 0x45
-- 
2.17.1

