Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2C8777FC4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbjHJSAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235570AbjHJSAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:00:05 -0400
Received: from honk.sigxcpu.org (honk.sigxcpu.org [24.134.29.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9132D10D;
        Thu, 10 Aug 2023 11:00:04 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 4B04CFB02;
        Thu, 10 Aug 2023 19:59:59 +0200 (CEST)
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UX7kzxiMNBjw; Thu, 10 Aug 2023 19:59:58 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Peng Fan <peng.fan@nxp.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        kernel@puri.sm, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        David Heidelberg <david@ixit.cz>,
        Sherry Sun <sherry.sun@nxp.com>
Subject: [PATCH v2 1/4] dt-bindings: sound: gtm601: Add description
Date:   Thu, 10 Aug 2023 19:59:49 +0200
Message-Id: <6904cc6d877d28d92e9f9fa9f1bdc404614d9734.1691684726.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1691684726.git.agx@sigxcpu.org>
References: <cover.1691684726.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows to us to document the channel and sampling
rate requirements.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/sound/option,gtm601.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/option,gtm601.yaml b/Documentation/devicetree/bindings/sound/option,gtm601.yaml
index 69c2ccc79dc5..ff813d97fc59 100644
--- a/Documentation/devicetree/bindings/sound/option,gtm601.yaml
+++ b/Documentation/devicetree/bindings/sound/option,gtm601.yaml
@@ -16,10 +16,12 @@ description: >
 properties:
   compatible:
     oneOf:
-      - items:  # 48 kHz stereo
+      - description: Broadmobi BM818 (48Khz stereo)
+        items:
           - const: broadmobi,bm818
           - const: option,gtm601
-      - const: option,gtm601  # 8 kHz mono
+      - description: GTM601 (8kHz mono)
+        const: option,gtm601
 
   '#sound-dai-cells':
     const: 0
-- 
2.40.1

