Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570907B58D6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 19:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238582AbjJBRAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238552AbjJBRAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:00:14 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46CDC4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 10:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :mime-version:content-transfer-encoding; s=k1; bh=t+zSPF3hzzUuEg
        cciilWdlzYm3kdo1yKdJ3sF92td0Y=; b=eas1VW/0YnbzNJr4nUhbX8/XUjsuXI
        ViM/5YCkBBt1JiZEFfTgCThoeIxfFawM//x5ALHS7JT2ejl4qPnN10Lynhn4ohvO
        0TREt5DdirL5e1VikD9/dtoWqJMSD9DoC/7+4k4TonoxtKuveJCaqWgu61tZB/Fh
        SSFa17q0VJuANqZKEWkv58aY553ZbWQ3lI8YEOWkH66DRiZ2+6FRYLBws1SomGbY
        Axh5+N4OybKJcUGkPYn0tZHZsuBw3cQBTg7rUb/QfFFyVb3wI9Xi7vl4VBtW52yf
        TQCVV3QTHwYS1bLiix3mIY8PF5P5jFmyUwHTC3LrcZlqov5c1CXo0TKA==
Received: (qmail 591902 invoked from network); 2 Oct 2023 19:00:07 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 2 Oct 2023 19:00:07 +0200
X-UD-Smtp-Session: l3s3148p1@ce+DtL4G6OsujntX
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: renesas: r8a77990: document Ebisu-4D support
Date:   Mon,  2 Oct 2023 18:59:57 +0200
Message-Id: <20231002165957.11388-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document properly that Ebisu-support includes the Ebisu-4D variant, so
there won't be confusion what happened with support for this board.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Documentation/devicetree/bindings/soc/renesas/renesas.yaml | 2 +-
 arch/arm64/boot/dts/renesas/ebisu.dtsi                     | 2 +-
 arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts             | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
index 53b95f348f8e..af80358b5fd3 100644
--- a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
+++ b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
@@ -302,7 +302,7 @@ properties:
       - description: R-Car E3 (R8A77990)
         items:
           - enum:
-              - renesas,ebisu # Ebisu (RTP0RC77990SEB0010S)
+              - renesas,ebisu # Ebisu/Ebisu-4D (RTP0RC77990SEB0010S)
           - const: renesas,r8a77990
 
       - description: R-Car D3 (R8A77995)
diff --git a/arch/arm64/boot/dts/renesas/ebisu.dtsi b/arch/arm64/boot/dts/renesas/ebisu.dtsi
index bbc29452d1be..f1a5778ef115 100644
--- a/arch/arm64/boot/dts/renesas/ebisu.dtsi
+++ b/arch/arm64/boot/dts/renesas/ebisu.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree Source for the Ebisu board
+ * Device Tree Source for the Ebisu/Ebisu-4D board
  *
  * Copyright (C) 2018 Renesas Electronics Corp.
  */
diff --git a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
index 9da0fd08f8c4..d5ac34a966f6 100644
--- a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree Source for the Ebisu board with R-Car E3
+ * Device Tree Source for the Ebisu/Ebisu-4D board with R-Car E3
  *
  * Copyright (C) 2018 Renesas Electronics Corp.
  */
-- 
2.35.1

