Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7565801D8E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 16:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbjLBPq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 10:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbjLBPqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 10:46:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A8F129
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 07:46:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D773EC433CC;
        Sat,  2 Dec 2023 15:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701531985;
        bh=whEVkV47vBAQ1zFS0tehUj15XN7L3r6QxlK/D9oqA80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=asKKD/k5o+McKYglU/mkm9kiYxyiM6bTAss95f6RHv3gr80nNMTbfbuTZtZDIlMtf
         A1CeM2w3k8M/To+RnJ/QBGNCQRGP7+aJltkBwezUeKjGyjUlB1A1XqNgxgcmO1AJ3I
         QeymBZPQ5sOuaqGeo6FrdeAqQYK9IPHuG2fcPSQ+SOhst7LhsweriDBb7G8H6L5/iC
         3qPStak58iYUpULhMZkV2cHfL1xpc8Y8T3BZANx2Cqs+Wts8If3O2LvdgtNMtppfAF
         sbaZ6XCl7gdVQbOE1FHhrwqq0wjDBlKKSjYiMd1GdmprZcfFE9EEwaTJmVM9RzPpFA
         g6tYTGyTctltA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: riscv: starfive: add Milkv Mars board
Date:   Sat,  2 Dec 2023 23:33:52 +0800
Message-Id: <20231202153353.635-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231202153353.635-1-jszhang@kernel.org>
References: <20231202153353.635-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for the Milkv Mars board which is
equipped with StarFive JH7110 SoC.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 Documentation/devicetree/bindings/riscv/starfive.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/starfive.yaml b/Documentation/devicetree/bindings/riscv/starfive.yaml
index cc4d92f0a1bf..b672f8521949 100644
--- a/Documentation/devicetree/bindings/riscv/starfive.yaml
+++ b/Documentation/devicetree/bindings/riscv/starfive.yaml
@@ -26,6 +26,7 @@ properties:
 
       - items:
           - enum:
+              - milkv,mars
               - starfive,visionfive-2-v1.2a
               - starfive,visionfive-2-v1.3b
           - const: starfive,jh7110
-- 
2.42.0

