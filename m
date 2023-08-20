Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C4A781DC1
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 14:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjHTMST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 08:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjHTMSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 08:18:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04F3EB;
        Sun, 20 Aug 2023 05:14:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74D2461337;
        Sun, 20 Aug 2023 12:14:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6527CC433CC;
        Sun, 20 Aug 2023 12:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692533647;
        bh=JobfbCNun9/CKRyR25756fW741H572o4jwNRMnpEBdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uaQRsHHdvpihZdkFmaKkGvL6GuO5xzJ19kcCAozGdotB7TyHu+7wv0sfrEeUd3p/P
         kC0aQkeztPrfvW1dn1p6HEgbv7QwXjPJSByJE+DQo/cyHoGDiTHTooRcNxOD5DBExP
         GrArCMKkTFSVqXXPg9xUXOLuhU9Cond7uxNPHnqqwhtcj0+F4oAvCqtXgIOJZyErxG
         H96/Al6d6rSjR+me62K1oenTfHPY3ZemDVxmVwj2SJ3M+R2kpxCbQ07yguZ4t3CFAZ
         lzkrBR1NcoO/aElKEUgtyG+e7m18xThaHWHFYvp8vLpUw1SAyM9AVBzOIYsArNwbLh
         YGGMDo27HJzHQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH net-next 1/3] dt-bindings: net: snps,dwmac: allow dwmac-3.70a to set pbl properties
Date:   Sun, 20 Aug 2023 20:02:11 +0800
Message-Id: <20230820120213.2054-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230820120213.2054-1-jszhang@kernel.org>
References: <20230820120213.2054-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snps dwmac 3.70a also supports setting pbl related properties, such as
"snps,pbl", "snps,txpbl", "snps,rxpbl" and "snps,no-pbl-x8".

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index a916701474dc..7626289157df 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -659,6 +659,7 @@ allOf:
               - qcom,sa8775p-ethqos
               - qcom,sc8280xp-ethqos
               - snps,dwmac-3.50a
+              - snps,dwmac-3.70a
               - snps,dwmac-4.10a
               - snps,dwmac-4.20a
               - snps,dwmac-5.20
-- 
2.40.1

