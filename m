Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588977BB787
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 14:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbjJFM1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 08:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbjJFM1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:27:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56751EA
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 05:27:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0ECC4166B;
        Fri,  6 Oct 2023 12:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696595226;
        bh=vK2e3eQyu+2RwwEcd/fM4Ck3i9PQ2DpagYXnMZgMMks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dxk2dDWLVPcQeveUPSAdTFi42lTUudLuJqloZTONbgWb7SQLlQqEhAEuzFHDZsEVm
         /vjayuxdfMKJkf/QCedhgEPmRyhcf2bfjpEg1/l1OmVOKtvdP1QjA+havuZd0LDMwJ
         iFHK+7KKBsg0jM7Pv5rX5ZQTuckPPP3HlJlkX5U0lB0kIbAg7tn0pO2Sm7ABBMxIOR
         NyT+1hItlAyHRR9+jg6rKmaRip1cUVw9s8RZkLWl1Yl2G6+HpdBl+poX7UDEE24Dvq
         JYHFIv1aWKjR0+hUy/3Jr1WFvmPr6q9qoQtAPmoA84k5OSor4ai5CXKnRkIudgXNe3
         T4BWv7tVVaMhg==
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
        Conor Dooley <conor.dooley@microchip.com>,
        Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH v2 3/5] dt-bindings: riscv: Add Milk-V Duo board compatibles
Date:   Fri,  6 Oct 2023 20:14:47 +0800
Message-Id: <20231006121449.721-4-jszhang@kernel.org>
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

Document the compatible strings for the Milk-V Duo board[1] which uses
the SOPHGO CV1800B SoC[2].

Link: https://milkv.io/duo [1]
Link: https://en.sophgo.com/product/introduce/cv180xB.html [2]
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Chen Wang <unicorn_wang@outlook.com>
---
 Documentation/devicetree/bindings/riscv/sophgo.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/sophgo.yaml b/Documentation/devicetree/bindings/riscv/sophgo.yaml
index 8adb5f39ca53..86748c5390be 100644
--- a/Documentation/devicetree/bindings/riscv/sophgo.yaml
+++ b/Documentation/devicetree/bindings/riscv/sophgo.yaml
@@ -18,6 +18,10 @@ properties:
     const: '/'
   compatible:
     oneOf:
+      - items:
+          - enum:
+              - milkv,duo
+          - const: sophgo,cv1800b
       - items:
           - enum:
               - milkv,pioneer
-- 
2.40.1

