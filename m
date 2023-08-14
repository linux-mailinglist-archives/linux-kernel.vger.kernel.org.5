Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2373477B35F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbjHNIHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbjHNIHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:07:13 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [IPv6:2001:4b7a:2000:18::162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD4EA6;
        Mon, 14 Aug 2023 01:07:10 -0700 (PDT)
Received: from [192.168.2.137] (bband-dyn221.178-41-211.t-com.sk [178.41.211.221])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 514261F540;
        Mon, 14 Aug 2023 10:07:08 +0200 (CEST)
From:   Martin Botka <martin.botka@somainline.org>
Date:   Mon, 14 Aug 2023 10:07:04 +0200
Subject: [PATCH v5 2/4] dt-bindings: arm: sunxi: Add BigTreeTech boards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230814-b4-cb1-v5-2-92135086dee4@somainline.org>
References: <20230814-b4-cb1-v5-0-92135086dee4@somainline.org>
In-Reply-To: <20230814-b4-cb1-v5-0-92135086dee4@somainline.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev,
        Andre Przywara <andre.przywara@arm.com>,
        Alan Ma <tech@biqu3d.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin@biqu3d.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Martin Botka <martin.botka@somainline.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692000426; l=1182;
 i=martin.botka@somainline.org; s=20230811; h=from:subject:message-id;
 bh=qtqWQccplJuFFEgG0lgMMMT5+E2RuoC7YtAGYvsMFyc=;
 b=DoPds3Cj5GLOvwXsztjCtAmOkVbKYKP7s7zzhU1WPHOKDoZBeyAD/DTzDbM9Q06D3wBxyqx8x
 M+LYi36USiXC/723xkRkAA+D/7lroNcu8pU6gqtVWsp3ufAY4mtZFgX
X-Developer-Key: i=martin.botka@somainline.org; a=ed25519;
 pk=aTCd3jmwU8GrJidWg3DSKLpdVMcpFzXzCSLXLR6NtWU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add name & compatible for BigTreeTech Manta boards and
BigTreeTech Pi

Signed-off-by: Martin Botka <martin.botka@somainline.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index ee8fdd2da869..b90d2a7dbe2d 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -151,6 +151,17 @@ properties:
           - const: roofull,beelink-x2
           - const: allwinner,sun8i-h3
 
+      - description: BigTreeTech Manta M4/8P
+        items:
+          - const: bigtreetech,cb1-manta
+          - const: bigtreetech,cb1
+          - const: allwinner,sun50i-h616
+
+      - description: BigTreeTech Pi
+        items:
+          - const: bigtreetech,pi
+          - const: allwinner,sun50i-h616
+
       - description: Chuwi V7 CW0825
         items:
           - const: chuwi,v7-cw0825

-- 
2.41.0

