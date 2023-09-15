Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF40E7A27F9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237160AbjIOUVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237432AbjIOUU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:20:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CE62D69
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:20:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBD0C433C7;
        Fri, 15 Sep 2023 20:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694809204;
        bh=+pZKuROLmBdIrfo491pE/sQfj9kOoSQEDuZxmmaZMuY=;
        h=From:To:Cc:Subject:Date:From;
        b=pLIVKgF4dnRVJLeCqx8HYhHUY8SvSrIXIlPr7f47FMgsP0kEtUjfk18z2d64X5aA9
         hsMUFqw/E+wJRjGSBFKA0Z4SsbvhvBlLGFxPRI4rZEXPAKqoIhNyI4cMsI4k3zMDVt
         +UwrH+gWKrI9VGHWH4ME8qqnwVyj26I750hiwNzIayYdenFvazGKdWFKRx8nNiCNLT
         OvOCZ7niYRmduAyapBZt/nFg3cbk4FPzF7Og+VkH3ATNbr2HCTruw/TJTvvC+bHgxT
         8ugq+sbEaBMmqWPuknw6UpgxLNKXs0O6qgXmW8D+8+qoLXA985FF3VeRiIHygwT7Dc
         lYKBGYj+eyqaQ==
Received: (nullmailer pid 4184984 invoked by uid 1000);
        Fri, 15 Sep 2023 20:20:00 -0000
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: riscv: cpus: Add missing additionalProperties on interrupt-controller node
Date:   Fri, 15 Sep 2023 15:19:36 -0500
Message-Id: <20230915201946.4184468-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
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

The "interrupt-controller" CPU child node is missing constraints on
extra properties. Add "additionalProperties: false" to fix this.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 38c0b5213736..97e8441eda1c 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -91,6 +91,7 @@ properties:
 
   interrupt-controller:
     type: object
+    additionalProperties: false
     description: Describes the CPU's local interrupt controller
 
     properties:
-- 
2.40.1

