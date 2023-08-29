Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980ED78C183
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbjH2J3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234991AbjH2J3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:29:15 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6F5CD7;
        Tue, 29 Aug 2023 02:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1693301346; x=1724837346;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=AKC9UAXsbaWgxqf5Ai9kerBdK6HkSBULPzncS9YmhjM=;
  b=h0YCSq2SOqJ3vCSTLI8qpaG+JJnIOR3aUfMAkmmA4Ylvdp4Bmn1Wr+kl
   5CjkJquT/9nz2FdUnFQGN4b8EK4h1WZaTOapswKnlLJiSWslGriirBqWh
   LyD2oannJwSnKML0ZcXb6h526cR3tc3Kfi0XBKnCoDN1p2Ps/cIyfHEPj
   jRpMaQxh2q86rL0bMujqunrK+/q1DraIBkER6846PXcwSd4FsnRLrg+zn
   KMhdu2W3ZuM4KrmIjWbci9hUHGCu9uH25c/pM3m1w2wW0k6uS3wUQ3vZL
   2rH9f0Qe1QSTThPIkH4/BNTY8joT+w5CeiT5RH08d9aBmfw8uBWl71V35
   g==;
X-IronPort-AV: E=Sophos;i="6.02,210,1688421600"; 
   d="scan'208";a="32672406"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 29 Aug 2023 11:27:25 +0200
Received: from [127.0.1.1] (herburgerg-w2.tq-net.de [10.122.52.145])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 009B6280087;
        Tue, 29 Aug 2023 11:27:24 +0200 (CEST)
From:   Gregor Herburger <gregor.herburger@ew.tq-group.com>
Date:   Tue, 29 Aug 2023 11:27:00 +0200
Subject: [PATCH v2 4/6] dt-bindings: arm: fsl: Add TQ-Systems LS1088 based
 boards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230829-for-ml-tqmls10xxa-v2-test-v2-4-b1da63785b25@ew.tq-group.com>
References: <20230829-for-ml-tqmls10xxa-v2-test-v2-0-b1da63785b25@ew.tq-group.com>
In-Reply-To: <20230829-for-ml-tqmls10xxa-v2-test-v2-0-b1da63785b25@ew.tq-group.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com,
        gregor.herburger@ew.tq-group.com,
        Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693301244; l=1034;
 i=gregor.herburger@ew.tq-group.com; s=20230829; h=from:subject:message-id;
 bh=Llu8MwMjW2yE/j1JvHqemXp1rSTQnNxIiZRoUcz0BPM=;
 b=vH0Hxm2O6MZb5jQive1hQGxwt+WsGZl/52JhXh1taJQ2OuCQEEjP2DaqNOpI19jt659W0xoKF
 k4qePAJ0Cq8ANwhtUZaWWB2JKvbc6t8eutSD7wBWJV5Si44o9QgYSpp
X-Developer-Key: i=gregor.herburger@ew.tq-group.com; a=ed25519;
 pk=+eRxwX7ikXwazcRjlOjj2/tbDmfVZdDLoW+xLZbQ4h4=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TQMLS1088a uses a common board layout with TQMLS1043A/TQMLS1046A.
MBLS10XXA is a starterkit baseboard usable for these SOMs.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 55e8279d834b..509ba52aa3cf 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1418,6 +1418,13 @@ properties:
               - fsl,ls1088a-rdb
           - const: fsl,ls1088a
 
+      - description: TQ-Systems LS1088A based Boards
+        items:
+          - enum:
+              - tq,ls1088a-tqmls1088a-mbls10xxa
+          - const: tq,ls1088a-tqmls1088a
+          - const: fsl,ls1088a
+
       - description: LS2080A based Boards
         items:
           - enum:

-- 
2.34.1

