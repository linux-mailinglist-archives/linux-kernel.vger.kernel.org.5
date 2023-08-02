Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1751676D212
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbjHBPeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbjHBPd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:33:57 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FBD1705;
        Wed,  2 Aug 2023 08:33:53 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 372FXefa105667;
        Wed, 2 Aug 2023 10:33:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690990420;
        bh=UlgZ9mh/TQXjrPnI4EOKK2y/wyh25m7X4j+urTjLbV4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=r+lVEohgcTsoWTn7afJfkQEeb+kp+FnS1BKf8vD9roAq1Bx4a28Mc8Ss7xAr/tPuc
         y4CCagM1RdJkF2YOHCIauiJaKZRhcc2bR+9OW+8cmxoeLFaQB6MwPsDOCoU6+ZUlW6
         Uw9hX9vTlnE9gMA13OG7IVyTn/+KP+UKyNToIbtU=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 372FXeoL120822
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Aug 2023 10:33:40 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 2
 Aug 2023 10:33:40 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 2 Aug 2023 10:33:40 -0500
Received: from lelv0327.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 372FXYq5072743;
        Wed, 2 Aug 2023 10:33:39 -0500
From:   Andrew Davis <afd@ti.com>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Tang <dt.tangr@gmail.com>,
        Fabian Vogt <fabian@ritter-vogt.de>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v8 7/9] ARM: dts: nspire: Remove file name from the files themselves
Date:   Wed, 2 Aug 2023 10:33:31 -0500
Message-ID: <20230802153333.55546-8-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230802153333.55546-1-afd@ti.com>
References: <20230802153333.55546-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

File names inside the file does not add much and just makes it
difficult to move the files, often the file name is not updated
and becomes wrong. Remove them.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/boot/dts/nspire/nspire-classic.dtsi | 2 --
 arch/arm/boot/dts/nspire/nspire-clp.dts      | 3 +--
 arch/arm/boot/dts/nspire/nspire-cx.dts       | 3 +--
 arch/arm/boot/dts/nspire/nspire-tp.dts       | 3 +--
 arch/arm/boot/dts/nspire/nspire.dtsi         | 2 --
 5 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/nspire/nspire-classic.dtsi b/arch/arm/boot/dts/nspire/nspire-classic.dtsi
index 01e1bb7c3c6cb..a6e9cbf51524d 100644
--- a/arch/arm/boot/dts/nspire/nspire-classic.dtsi
+++ b/arch/arm/boot/dts/nspire/nspire-classic.dtsi
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- *  linux/arch/arm/boot/nspire-classic.dts
- *
  *  Copyright (C) 2013 Daniel Tang <tangrs@tangrs.id.au>
  */
 
diff --git a/arch/arm/boot/dts/nspire/nspire-clp.dts b/arch/arm/boot/dts/nspire/nspire-clp.dts
index 916ede0c2499c..c5773f770fd49 100644
--- a/arch/arm/boot/dts/nspire/nspire-clp.dts
+++ b/arch/arm/boot/dts/nspire/nspire-clp.dts
@@ -1,9 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- *  linux/arch/arm/boot/nspire-clp.dts
- *
  *  Copyright (C) 2013 Daniel Tang <tangrs@tangrs.id.au>
  */
+
 /dts-v1/;
 
 #include <dt-bindings/input/input.h>
diff --git a/arch/arm/boot/dts/nspire/nspire-cx.dts b/arch/arm/boot/dts/nspire/nspire-cx.dts
index 96c48fc522035..29f0181e5b385 100644
--- a/arch/arm/boot/dts/nspire/nspire-cx.dts
+++ b/arch/arm/boot/dts/nspire/nspire-cx.dts
@@ -1,9 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- *  linux/arch/arm/boot/nspire-cx.dts
- *
  *  Copyright (C) 2013 Daniel Tang <tangrs@tangrs.id.au>
  */
+
 /dts-v1/;
 
 #include <dt-bindings/input/input.h>
diff --git a/arch/arm/boot/dts/nspire/nspire-tp.dts b/arch/arm/boot/dts/nspire/nspire-tp.dts
index 235cd4264da79..3f0107f1c2c7b 100644
--- a/arch/arm/boot/dts/nspire/nspire-tp.dts
+++ b/arch/arm/boot/dts/nspire/nspire-tp.dts
@@ -1,9 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- *  linux/arch/arm/boot/nspire-tp.dts
- *
  *  Copyright (C) 2013 Daniel Tang <tangrs@tangrs.id.au>
  */
+
 /dts-v1/;
 
 #include <dt-bindings/input/input.h>
diff --git a/arch/arm/boot/dts/nspire/nspire.dtsi b/arch/arm/boot/dts/nspire/nspire.dtsi
index 9587e1ebeb931..aecaca5ee1ebb 100644
--- a/arch/arm/boot/dts/nspire/nspire.dtsi
+++ b/arch/arm/boot/dts/nspire/nspire.dtsi
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- *  linux/arch/arm/boot/nspire.dtsi
- *
  *  Copyright (C) 2013 Daniel Tang <tangrs@tangrs.id.au>
  */
 
-- 
2.39.2

