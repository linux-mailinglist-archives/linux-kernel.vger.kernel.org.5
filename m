Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274F07B838C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbjJDP2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbjJDP2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:28:02 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CCBC1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 08:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :mime-version:content-transfer-encoding; s=k1; bh=AcnBMrFV/5ppKI
        SBLD04NC46x9q9bnjgHXSKraviqGo=; b=KvLtNPr5F/JBRBeo7cHBepSvPVylVr
        9pAahRco6WlblAktPCAvFqop5L5JO9xYFziGEjl4SwrHJGAAxaBCRpI5GZMm/Nhw
        Ov0a1/4Mk4jHTH3+xCwu2b+jlTKb+wTQ8GWqYuLEgsjTS0UYQdG8OTCyiW+Swtk3
        lgLesncmO9SdrR5Ovspt1Kv5kV+Ho303nTzz+K5y1g9ebQBpSJsVO9hIeNq/GKgo
        p7+wuB+GRDwN+JY/U0+7dwYe0XfkW0aB2prsD537MsvlCT58gXTgXHP+8F9BcOyq
        iecrY8IQP5OGwZlsHEN0iu6Gsl62KgH9olL9pjb3UD+rRnAgpgV/EFcw==
Received: (qmail 1221016 invoked from network); 4 Oct 2023 17:27:56 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Oct 2023 17:27:56 +0200
X-UD-Smtp-Session: l3s3148p1@UjjPpuUGDrQgAwDPXyiQAAMTeDf2RifG
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: renesas: r8a77990: document Ebisu-4D support
Date:   Wed,  4 Oct 2023 17:27:51 +0200
Message-Id: <20231004152751.3917-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document properly that Ebisu-support includes the Ebisu-4D variant, so
there won't be confusion what happened with support for this board.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Rob Herring <robh@kernel.org>
---

Changes since v1:
* fixed RTP numbers for both boards
* added Rob's ack (thanks!)

 Documentation/devicetree/bindings/soc/renesas/renesas.yaml | 2 +-
 arch/arm64/boot/dts/renesas/ebisu.dtsi                     | 2 +-
 arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts             | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
index 53b95f348f8e..6239c38d6405 100644
--- a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
+++ b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
@@ -302,7 +302,7 @@ properties:
       - description: R-Car E3 (R8A77990)
         items:
           - enum:
-              - renesas,ebisu # Ebisu (RTP0RC77990SEB0010S)
+              - renesas,ebisu # Ebisu (RTP0RC77990SEB0010S), Ebisu-4D (RTP0RC77990SEB0020S)
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
2.30.2

