Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208A2791AF0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 17:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348444AbjIDP5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 11:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239766AbjIDP5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 11:57:14 -0400
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [5.144.164.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BF3CC8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 08:57:09 -0700 (PDT)
Received: from v0.lan (bband-dyn191.178-41-225.t-com.sk [178.41.225.191])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 0D0E21FBA5;
        Mon,  4 Sep 2023 17:57:07 +0200 (CEST)
From:   Martin Botka <martin.botka@somainline.org>
Date:   Mon, 04 Sep 2023 17:57:03 +0200
Subject: [PATCH 3/6] dt-bindings: opp: Add compatible for H616
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230904-cpufreq-h616-v1-3-b8842e525c43@somainline.org>
References: <20230904-cpufreq-h616-v1-0-b8842e525c43@somainline.org>
In-Reply-To: <20230904-cpufreq-h616-v1-0-b8842e525c43@somainline.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Alan Ma <tech@biqu3d.com>,
        Luke Harrison <bttuniversity@biqu3d.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rogerio Goncalves <rogerlz@gmail.com>,
        Martin Botka <martin@biqu3d.com>,
        Martin Botka <martin.botka@somainline.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693843024; l=1233;
 i=martin.botka@somainline.org; s=20230811; h=from:subject:message-id;
 bh=vkpyJtpACo5loCh7uIWuezcAm00aYr/8qEBY1Y7a4p0=;
 b=LsSyA8ltGbBj/87WeIZvhIIr7CW27Ba6QPMzBx6lX+DRdiVacfciJrzaKnjSiasT24rMfXkvF
 kHkob6+ZQ/jBcRr0WKQr0aVbKXpqug9ql3yQNGreOaV45y6DciUQFZ/
X-Developer-Key: i=martin.botka@somainline.org; a=ed25519;
 pk=aTCd3jmwU8GrJidWg3DSKLpdVMcpFzXzCSLXLR6NtWU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to add compatible for H616 to H6 cpufreq driver bindings.

Also enable opp_supported_hw property that will be needed for H616.

Signed-off-by: Martin Botka <martin.botka@somainline.org>
---
 .../bindings/opp/allwinner,sun50i-h6-operating-points.yaml          | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml b/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
index 51f62c3ae194..2fa1199f2d23 100644
--- a/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
+++ b/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
@@ -23,7 +23,10 @@ allOf:
 
 properties:
   compatible:
-    const: allwinner,sun50i-h6-operating-points
+    contains:
+      enum:
+        - allwinner,sun50i-h6-operating-points
+        - allwinner,sun50i-h616-operating-points
 
   nvmem-cells:
     description: |
@@ -47,6 +50,7 @@ patternProperties:
     properties:
       opp-hz: true
       clock-latency-ns: true
+      opp-supported-hw: true
 
     patternProperties:
       "^opp-microvolt-speed[0-9]$": true

-- 
2.42.0

