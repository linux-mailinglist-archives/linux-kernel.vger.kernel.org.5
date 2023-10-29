Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140AC7DAABD
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 05:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjJ2E1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 00:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjJ2E1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 00:27:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693EACC;
        Sat, 28 Oct 2023 21:27:28 -0700 (PDT)
Received: from localhost (unknown [188.24.143.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2518D6607387;
        Sun, 29 Oct 2023 04:27:27 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698553647;
        bh=aHc95vXeiD53iNm6WA6zZHpTycbLrCk2GHcf/JepTCc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eAfMhxoCssDhrVUBxoF7h+coBfWSFQ0b/VVZgHI4x6CLxCT5IRwovOcHYtFIz6Cmv
         pm9P2BJEjHQAwTHLiVX65xLCL/VjCzSCT7OcAYc8pZCj2jbn+b3VObJ9hHtQDNk+Cj
         B6Brz6BoeZbvAVlXMEBZ1BADNAwJ3+N8nAoaxqYqhTfCYpzzuANSoiPdVZKAbNupkq
         1I+NIzIq5ulExgqjFkXd4nDD4rXbOvsdkyyBAB+kiy+Lb0jnT7K6oQ8Khqo5O8YOf7
         Q2JS4LbhDORaQZWpM6hyLvJbQfyAUwZsKGWHfuh+jHWJcLvS7fMtq6zU3WEyYCwPO3
         v/ltCiFkKDHpw==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Samin Guo <samin.guo@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: [PATCH v2 03/12] dt-bindings: net: starfive,jh7110-dwmac: Drop redundant reset description
Date:   Sun, 29 Oct 2023 06:27:03 +0200
Message-ID: <20231029042712.520010-4-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029042712.520010-1-cristian.ciocaltea@collabora.com>
References: <20231029042712.520010-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reset description items are already provided by the referenced
snps,dwmac.yaml schema, hence replace them with the necessary
{min,max}Items.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 .../devicetree/bindings/net/starfive,jh7110-dwmac.yaml       | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
index cc3e1c6fc135..44e58755a5a2 100644
--- a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
@@ -46,9 +46,8 @@ properties:
     maxItems: 3
 
   resets:
-    items:
-      - description: MAC Reset signal.
-      - description: AHB Reset signal.
+    minItems: 2
+    maxItems: 2
 
   reset-names:
     items:
-- 
2.42.0

