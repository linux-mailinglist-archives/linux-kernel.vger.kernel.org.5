Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8697E780760
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 10:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358700AbjHRIoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 04:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358696AbjHRIni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 04:43:38 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [5.144.164.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A1A3AAF;
        Fri, 18 Aug 2023 01:43:34 -0700 (PDT)
Received: from v0.lan (bband-dyn221.178-41-211.t-com.sk [178.41.211.221])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 734C33F479;
        Fri, 18 Aug 2023 10:43:31 +0200 (CEST)
From:   Martin Botka <martin.botka@somainline.org>
Date:   Fri, 18 Aug 2023 10:43:16 +0200
Subject: [PATCH 1/3] dt-bindings: thermal: sun8i: Add binding for H616 THS
 controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230818-ths-h616-v1-1-0e1e058b9c7a@somainline.org>
References: <20230818-ths-h616-v1-0-0e1e058b9c7a@somainline.org>
In-Reply-To: <20230818-ths-h616-v1-0-0e1e058b9c7a@somainline.org>
To:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Alan Ma <tech@biqu3d.com>,
        Luke Harrison <bttuniversity@biqu3d.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin@biqu3d.com>,
        Martin Botka <martin.botka@somainline.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692348210; l=1243;
 i=martin.botka@somainline.org; s=20230811; h=from:subject:message-id;
 bh=C1VnYrsNtvLd+W49es4FKH+AHUilEeLhFJeqosJtqBY=;
 b=eZPyJW3Mn7LAPH1PEGpozxXO4WnCp7T7Byq9SCQ//a2uEHwUg36SWqPVkM2GaMFPEWGqXz+r1
 oPbRItHGzhVAJuajg5ZzDL6qBBAuGprKPTj9NfpBkjDu5s9r5FZKhCS
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

Add binding for H616 THS controller.

Signed-off-by: Martin Botka <martin.botka@somainline.org>
---
 .../devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml          | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
index fbd4212285e2..79692f8360f5 100644
--- a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
+++ b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
@@ -20,6 +20,7 @@ properties:
       - allwinner,sun50i-a100-ths
       - allwinner,sun50i-h5-ths
       - allwinner,sun50i-h6-ths
+      - allwinner,sun50i-h616-ths
 
   clocks:
     minItems: 1
@@ -63,6 +64,7 @@ allOf:
             enum:
               - allwinner,sun50i-a100-ths
               - allwinner,sun50i-h6-ths
+              - allwinner,sun50i-h616-ths
 
     then:
       properties:
@@ -107,6 +109,7 @@ allOf:
               - allwinner,sun50i-a100-ths
               - allwinner,sun50i-h5-ths
               - allwinner,sun50i-h6-ths
+              - allwinner,sun50i-h616-ths
 
     then:
       required:

-- 
2.41.0

