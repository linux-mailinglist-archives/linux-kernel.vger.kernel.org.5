Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B8F7BB782
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 14:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjJFM1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 08:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjJFM1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:27:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37102C2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 05:27:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DBCAC433CC;
        Fri,  6 Oct 2023 12:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696595220;
        bh=SnqqmnuywOhmCW0NrWgiJLL8C+SD9HabtHjqFfDXRA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KtJmRO1Cou5EiBgcTPgxHF4yWrW5dQsCuOzc3NBJ/sytY3coZjSlqnwJaYftSR8c7
         2RbcSXoDWtBH/JU/0Vv+1XBJS/XocLczha3d5kPnnzAKQjdDMhkmE08ejeAW/fNTer
         B+7zdTmj/wISBxpDgLLSmQW30RcjirkDhk5DV+0eQ668kmQWp6bP5OImaXA9OCu5x7
         elML0q+1TQ6DSXYEsM5eb1Iq9lPpSTNfbFrYt9Kfkr5A1g0Nr0wqxmsBCduLzspe76
         fNOu9O2z/0AsoSH/m0DQCuxk7Teh7Uvg6CHROcN8NPvmvRJpKT8rnJ/jC65Yxbdl+C
         12L9Y4fspI3Ew==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Inochi Amaoto <inochiama@outlook.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/5] dt-bindings: interrupt-controller: Add SOPHGO CV1800B plic
Date:   Fri,  6 Oct 2023 20:14:45 +0800
Message-Id: <20231006121449.721-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231006121449.721-1-jszhang@kernel.org>
References: <20231006121449.721-1-jszhang@kernel.org>
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

Add compatible string for SOPHGO CV1800B plic.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 16f9c4760c0f..0c07e8dda445 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -65,6 +65,7 @@ properties:
       - items:
           - enum:
               - allwinner,sun20i-d1-plic
+              - sophgo,cv1800b-plic
               - sophgo,sg2042-plic
               - thead,th1520-plic
           - const: thead,c900-plic
-- 
2.40.1

