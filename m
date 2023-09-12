Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE6779D0F1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbjILMZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235102AbjILMZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:25:23 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F73210DC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 05:25:18 -0700 (PDT)
Received: from [192.168.2.137] (bband-dyn191.178-41-225.t-com.sk [178.41.225.191])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 4EEB13F5C7;
        Tue, 12 Sep 2023 14:25:16 +0200 (CEST)
From:   Martin Botka <martin.botka@somainline.org>
Date:   Tue, 12 Sep 2023 14:25:12 +0200
Subject: [PATCH v3 1/2] dt-bindings: nvmem: SID: Add binding for H616 SID
 controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-sid-h616-v3-1-ee18e1c5bbb5@somainline.org>
References: <20230912-sid-h616-v3-0-ee18e1c5bbb5@somainline.org>
In-Reply-To: <20230912-sid-h616-v3-0-ee18e1c5bbb5@somainline.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Alan Ma <tech@biqu3d.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694521515; l=1027;
 i=martin.botka@somainline.org; s=20230811; h=from:subject:message-id;
 bh=1jMnpDdkp6KPQZuwmTj68b4NuaIjnRfs7Don6TWW4G4=;
 b=J8dj4lQj/lhG/fni06UPK7S8zEi/zaAQ9NYDRQTk4/C+LRz45lqwR5Z19vprDG4pnuAcvKzpM
 S6OeysOSUBDDHoowVtyio6W7rCmuYT8qxnJosQz8asVpIGIpUww7wee
X-Developer-Key: i=martin.botka@somainline.org; a=ed25519;
 pk=aTCd3jmwU8GrJidWg3DSKLpdVMcpFzXzCSLXLR6NtWU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for the SID controller found in H616 SoC

Signed-off-by: Martin Botka <martin.botka@somainline.org>
---
 Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml b/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
index 296001e7f498..0928ec408170 100644
--- a/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
+++ b/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
@@ -23,7 +23,9 @@ properties:
       - const: allwinner,sun20i-d1-sid
       - const: allwinner,sun50i-a64-sid
       - items:
-          - const: allwinner,sun50i-a100-sid
+          - enum:
+              - allwinner,sun50i-a100-sid
+              - allwinner,sun50i-h616-sid
           - const: allwinner,sun50i-a64-sid
       - const: allwinner,sun50i-h5-sid
       - const: allwinner,sun50i-h6-sid

-- 
2.42.0

