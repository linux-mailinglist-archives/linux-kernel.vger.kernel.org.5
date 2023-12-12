Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D299C80E08F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 01:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345622AbjLLA6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 19:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345589AbjLLA6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 19:58:12 -0500
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 82D38B3;
        Mon, 11 Dec 2023 16:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ALA6E
        1kxgqoyYdK+X/tV01Cv4nS2fQCV1ZSR7WI680E=; b=FStsEO0uHLWJqwximzbpg
        kRqRlujuNe6619REWsYePZpQ1B5Cv+psr0Gtv2/FKSQhuAcWEE1hFCb3RFGdHhY+
        fhCFztfy8uxsMWM9uogzwTROQidBzm2wdG9MYizO+tABPLpRfzdsc0UCLzwpAezZ
        ZqijZ/n1qZRMdLtZpr1DDs=
Received: from ProDesk.. (unknown [58.22.7.114])
        by zwqz-smtp-mta-g1-3 (Coremail) with SMTP id _____wDnLx3nr3dlgINjCQ--.23988S2;
        Tue, 12 Dec 2023 08:57:15 +0800 (CST)
From:   Andy Yan <andyshrk@163.com>
To:     iommu@lists.linux.dev
Cc:     heiko@sntech.de, conor+dt@kernel.org, joro@8bytes.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        robin.murphy@arm.com, will@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Andy Yan <andy.yan@rock-chips.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] dt-bindings: iommu: rockchip: Add Rockchip RK3588
Date:   Tue, 12 Dec 2023 08:57:10 +0800
Message-Id: <20231212005710.1837066-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDnLx3nr3dlgINjCQ--.23988S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7JF15GFyxXF45Jr1DGF43GFg_yoW8JF45pF
        srCryDXFyxGw1fWa9rtFn3Cr45tr4DAa1jgryaga17WFn8ta45GrnY9rn8ZF1DWFW8AFW7
        ua9rurW5A3yavrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jrcTPUUUUU=
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqBBEXmVOA5nBygAAsY
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Yan <andy.yan@rock-chips.com>

Add a Rockchip RK3588 compatible

I split it from the vop2 patch series as suggested by Heiko[0]

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[0]https://patchwork.kernel.org/project/dri-devel/patch/20231207080235.652719-1-andyshrk@163.com/

---

Changes in v2:
- Add maintainers for the iommu subsystem to cc list

 .../devicetree/bindings/iommu/rockchip,iommu.yaml     | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
index ba9124f721f1..621dde0e45d8 100644
--- a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
@@ -19,9 +19,14 @@ description: |+
 
 properties:
   compatible:
-    enum:
-      - rockchip,iommu
-      - rockchip,rk3568-iommu
+    oneOf:
+      - enum:
+          - rockchip,iommu
+          - rockchip,rk3568-iommu
+      - items:
+          - enum:
+              - rockchip,rk3588-iommu
+          - const: rockchip,rk3568-iommu
 
   reg:
     items:
-- 
2.34.1

