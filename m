Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5CD7857AD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbjHWML3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbjHWML1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:11:27 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1070F10F3;
        Wed, 23 Aug 2023 05:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1692792664; x=1724328664;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YVITlqeGYIzryVLMxGAyiSvKa8LWeUqjnXV4AfTC5Hk=;
  b=hggQLCbC1Ur3otmLwp8pQfWnzhilpzMwpxs/YXI3YM6a37kEVvKmLCYQ
   p9/dwg4VtqZezIDO1Ep8mEwpCFKmUA6hNRBrX9SS8Uc7DBudIBqNAOVpo
   F8qwbsC7nrkDhwJ3oCeoLMKXdl+lr59WkCpwdDlmBadKBvOvQsNA2thY+
   7Z/JJqYgWj3O80KyDer0JxaotbR1QWVT3nZuuEnqIFMdDib7vt3iLF36q
   fodthrrPc6/ZaYYT6mu803OQfhT4y/vXkxyiHNIf+KKVcgFAnMgoRt92Y
   qUZFGXlf3coxXmg3Q0Utz56NK5Wn624Ssg3lYMt3CVPwZbrlyh5PDf3D0
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,195,1684792800"; 
   d="scan'208";a="32586565"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 23 Aug 2023 14:10:01 +0200
Received: from herburgerg-w2.tq-net.de (herburgerg-w2.tq-net.de [10.122.52.145])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 8B109280087;
        Wed, 23 Aug 2023 14:10:01 +0200 (CEST)
From:   Gregor Herburger <gregor.herburger@ew.tq-group.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Subject: [PATCH 4/6] dt-bindings: arm: fsl: Add TQ-Systems LS1088 based boards
Date:   Wed, 23 Aug 2023 14:09:50 +0200
Message-Id: <20230823120952.317740-5-gregor.herburger@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823120952.317740-1-gregor.herburger@ew.tq-group.com>
References: <20230823120952.317740-1-gregor.herburger@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TQMLS1088a uses a common board layout with TQMLS1043A/TQMLS1046A.
MBLS10XXA is a starterkit baseboard usable for these SOMs.

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

