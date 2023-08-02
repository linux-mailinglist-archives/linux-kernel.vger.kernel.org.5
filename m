Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E3476D216
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbjHBPea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbjHBPd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:33:58 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007B41715;
        Wed,  2 Aug 2023 08:33:54 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 372FXePX022538;
        Wed, 2 Aug 2023 10:33:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690990420;
        bh=lfR9Qc54DfDqgwwfvP7Iv8jLZoV0ix+8M2jR1WOxcrg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=PROX8AuZ+E4Xl07qBpxGQgOxnD0nWoSmGcqHvQPTY98a7iyt3qPAZIcCYq0RNA0jV
         MwA/8Di6ECGtPAOxdWqZutahm9K8zYCQzrcLVNTY0LSvtx3PZfLLMh4RZ6JgNrCwhY
         VDIz7EuoHjZSCxDWH58mRImG/d6jy7GsXRgDVe14=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 372FXeuU120818
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Aug 2023 10:33:40 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 2
 Aug 2023 10:33:39 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 2 Aug 2023 10:33:39 -0500
Received: from lelv0327.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 372FXYq4072743;
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
Subject: [PATCH v8 6/9] ARM: dts: nspire: Use MATRIX_KEY macro for linux,keymap
Date:   Wed, 2 Aug 2023 10:33:30 -0500
Message-ID: <20230802153333.55546-7-afd@ti.com>
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

This looks better and allows us to see the row and column numbers
more easily. Switch to this macro here.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/boot/dts/nspire/nspire-clp.dts | 90 +++++++++++++++++++------
 arch/arm/boot/dts/nspire/nspire-cx.dts  | 90 +++++++++++++++++++------
 arch/arm/boot/dts/nspire/nspire-tp.dts  | 90 +++++++++++++++++++------
 3 files changed, 204 insertions(+), 66 deletions(-)

diff --git a/arch/arm/boot/dts/nspire/nspire-clp.dts b/arch/arm/boot/dts/nspire/nspire-clp.dts
index f52f38c615886..916ede0c2499c 100644
--- a/arch/arm/boot/dts/nspire/nspire-clp.dts
+++ b/arch/arm/boot/dts/nspire/nspire-clp.dts
@@ -6,32 +6,78 @@
  */
 /dts-v1/;
 
+#include <dt-bindings/input/input.h>
+
 /include/ "nspire-classic.dtsi"
 
 &keypad {
 	linux,keymap = <
-	0x0000001c 	0x0001001c 	0x00020039
-	0x0004002c 	0x00050034 	0x00060015
-	0x0007000b 	0x0008002d 	0x01000033
-	0x0101004e 	0x01020011 	0x01030004
-	0x0104002f 	0x01050003 	0x01060016
-	0x01070002 	0x01080014 	0x02000062
-	0x0201000c 	0x0202001f 	0x02030007
-	0x02040013 	0x02050006 	0x02060010
-	0x02070005 	0x02080019 	0x03000027
-	0x03010037 	0x03020018 	0x0303000a
-	0x03040031 	0x03050009 	0x03060032
-	0x03070008 	0x03080026 	0x04000028
-	0x04010035 	0x04020025 	0x04040024
-	0x04060017 	0x04080023 	0x05000028
-	0x05020022 	0x0503001b 	0x05040021
-	0x0505001a 	0x05060012 	0x0507006f
-	0x05080020 	0x0509002a 	0x0601001c
-	0x0602002e 	0x06030068 	0x06040030
-	0x0605006d 	0x0606001e 	0x06070001
-	0x0608002b 	0x0609000f 	0x07000067
-	0x0702006a 	0x0704006c 	0x07060069
-	0x0707000e 	0x0708001d 	0x070a000d
+		MATRIX_KEY(0,  0, 0x1c)
+		MATRIX_KEY(0,  1, 0x1c)
+		MATRIX_KEY(0,  2, 0x39)
+		MATRIX_KEY(0,  4, 0x2c)
+		MATRIX_KEY(0,  5, 0x34)
+		MATRIX_KEY(0,  6, 0x15)
+		MATRIX_KEY(0,  7, 0x0b)
+		MATRIX_KEY(0,  8, 0x2d)
+		MATRIX_KEY(1,  0, 0x33)
+		MATRIX_KEY(1,  1, 0x4e)
+		MATRIX_KEY(1,  2, 0x11)
+		MATRIX_KEY(1,  3, 0x04)
+		MATRIX_KEY(1,  4, 0x2f)
+		MATRIX_KEY(1,  5, 0x03)
+		MATRIX_KEY(1,  6, 0x16)
+		MATRIX_KEY(1,  7, 0x02)
+		MATRIX_KEY(1,  8, 0x14)
+		MATRIX_KEY(2,  0, 0x62)
+		MATRIX_KEY(2,  1, 0x0c)
+		MATRIX_KEY(2,  2, 0x1f)
+		MATRIX_KEY(2,  3, 0x07)
+		MATRIX_KEY(2,  4, 0x13)
+		MATRIX_KEY(2,  5, 0x06)
+		MATRIX_KEY(2,  6, 0x10)
+		MATRIX_KEY(2,  7, 0x05)
+		MATRIX_KEY(2,  8, 0x19)
+		MATRIX_KEY(3,  0, 0x27)
+		MATRIX_KEY(3,  1, 0x37)
+		MATRIX_KEY(3,  2, 0x18)
+		MATRIX_KEY(3,  3, 0x0a)
+		MATRIX_KEY(3,  4, 0x31)
+		MATRIX_KEY(3,  5, 0x09)
+		MATRIX_KEY(3,  6, 0x32)
+		MATRIX_KEY(3,  7, 0x08)
+		MATRIX_KEY(3,  8, 0x26)
+		MATRIX_KEY(4,  0, 0x28)
+		MATRIX_KEY(4,  1, 0x35)
+		MATRIX_KEY(4,  2, 0x25)
+		MATRIX_KEY(4,  4, 0x24)
+		MATRIX_KEY(4,  6, 0x17)
+		MATRIX_KEY(4,  8, 0x23)
+		MATRIX_KEY(5,  0, 0x28)
+		MATRIX_KEY(5,  2, 0x22)
+		MATRIX_KEY(5,  3, 0x1b)
+		MATRIX_KEY(5,  4, 0x21)
+		MATRIX_KEY(5,  5, 0x1a)
+		MATRIX_KEY(5,  6, 0x12)
+		MATRIX_KEY(5,  7, 0x6f)
+		MATRIX_KEY(5,  8, 0x20)
+		MATRIX_KEY(5,  9, 0x2a)
+		MATRIX_KEY(6,  1, 0x1c)
+		MATRIX_KEY(6,  2, 0x2e)
+		MATRIX_KEY(6,  3, 0x68)
+		MATRIX_KEY(6,  4, 0x30)
+		MATRIX_KEY(6,  5, 0x6d)
+		MATRIX_KEY(6,  6, 0x1e)
+		MATRIX_KEY(6,  7, 0x01)
+		MATRIX_KEY(6,  8, 0x2b)
+		MATRIX_KEY(6,  9, 0x0f)
+		MATRIX_KEY(7,  0, 0x67)
+		MATRIX_KEY(7,  2, 0x6a)
+		MATRIX_KEY(7,  4, 0x6c)
+		MATRIX_KEY(7,  6, 0x69)
+		MATRIX_KEY(7,  7, 0x0e)
+		MATRIX_KEY(7,  8, 0x1d)
+		MATRIX_KEY(7, 10, 0x0d)
 	>;
 };
 
diff --git a/arch/arm/boot/dts/nspire/nspire-cx.dts b/arch/arm/boot/dts/nspire/nspire-cx.dts
index 837dbdd9af552..96c48fc522035 100644
--- a/arch/arm/boot/dts/nspire/nspire-cx.dts
+++ b/arch/arm/boot/dts/nspire/nspire-cx.dts
@@ -6,6 +6,8 @@
  */
 /dts-v1/;
 
+#include <dt-bindings/input/input.h>
+
 /include/ "nspire.dtsi"
 
 &lcd {
@@ -45,28 +47,72 @@ &ahb_clk {
 
 &keypad {
 	linux,keymap = <
-	0x0000001c 	0x0001001c 	0x00040039
-	0x0005002c 	0x00060015 	0x0007000b
-	0x0008000f 	0x0100002d 	0x01010011
-	0x0102002f 	0x01030004 	0x01040016
-	0x01050014 	0x0106001f 	0x01070002
-	0x010a006a 	0x02000013 	0x02010010
-	0x02020019 	0x02030007 	0x02040018
-	0x02050031 	0x02060032 	0x02070005
-	0x02080028 	0x0209006c 	0x03000026
-	0x03010025 	0x03020024 	0x0303000a
-	0x03040017 	0x03050023 	0x03060022
-	0x03070008 	0x03080035 	0x03090069
-	0x04000021 	0x04010012 	0x04020020
-	0x0404002e 	0x04050030 	0x0406001e
-	0x0407000d 	0x04080037 	0x04090067
-	0x05010038 	0x0502000c 	0x0503001b
-	0x05040034 	0x0505001a 	0x05060006
-	0x05080027 	0x0509000e 	0x050a006f
-	0x0600002b 	0x0602004e 	0x06030068
-	0x06040003 	0x0605006d 	0x06060009
-	0x06070001 	0x0609000f 	0x0708002a
-	0x0709001d 	0x070a0033 	>;
+		MATRIX_KEY(0,  0, 0x1c)
+		MATRIX_KEY(0,  1, 0x1c)
+		MATRIX_KEY(0,  4, 0x39)
+		MATRIX_KEY(0,  5, 0x2c)
+		MATRIX_KEY(0,  6, 0x15)
+		MATRIX_KEY(0,  7, 0x0b)
+		MATRIX_KEY(0,  8, 0x0f)
+		MATRIX_KEY(1,  0, 0x2d)
+		MATRIX_KEY(1,  1, 0x11)
+		MATRIX_KEY(1,  2, 0x2f)
+		MATRIX_KEY(1,  3, 0x04)
+		MATRIX_KEY(1,  4, 0x16)
+		MATRIX_KEY(1,  5, 0x14)
+		MATRIX_KEY(1,  6, 0x1f)
+		MATRIX_KEY(1,  7, 0x02)
+		MATRIX_KEY(1, 10, 0x6a)
+		MATRIX_KEY(2,  0, 0x13)
+		MATRIX_KEY(2,  1, 0x10)
+		MATRIX_KEY(2,  2, 0x19)
+		MATRIX_KEY(2,  3, 0x07)
+		MATRIX_KEY(2,  4, 0x18)
+		MATRIX_KEY(2,  5, 0x31)
+		MATRIX_KEY(2,  6, 0x32)
+		MATRIX_KEY(2,  7, 0x05)
+		MATRIX_KEY(2,  8, 0x28)
+		MATRIX_KEY(2,  9, 0x6c)
+		MATRIX_KEY(3,  0, 0x26)
+		MATRIX_KEY(3,  1, 0x25)
+		MATRIX_KEY(3,  2, 0x24)
+		MATRIX_KEY(3,  3, 0x0a)
+		MATRIX_KEY(3,  4, 0x17)
+		MATRIX_KEY(3,  5, 0x23)
+		MATRIX_KEY(3,  6, 0x22)
+		MATRIX_KEY(3,  7, 0x08)
+		MATRIX_KEY(3,  8, 0x35)
+		MATRIX_KEY(3,  9, 0x69)
+		MATRIX_KEY(4,  0, 0x21)
+		MATRIX_KEY(4,  1, 0x12)
+		MATRIX_KEY(4,  2, 0x20)
+		MATRIX_KEY(4,  4, 0x2e)
+		MATRIX_KEY(4,  5, 0x30)
+		MATRIX_KEY(4,  6, 0x1e)
+		MATRIX_KEY(4,  7, 0x0d)
+		MATRIX_KEY(4,  8, 0x37)
+		MATRIX_KEY(4,  9, 0x67)
+		MATRIX_KEY(5,  1, 0x38)
+		MATRIX_KEY(5,  2, 0x0c)
+		MATRIX_KEY(5,  3, 0x1b)
+		MATRIX_KEY(5,  4, 0x34)
+		MATRIX_KEY(5,  5, 0x1a)
+		MATRIX_KEY(5,  6, 0x06)
+		MATRIX_KEY(5,  8, 0x27)
+		MATRIX_KEY(5,  9, 0x0e)
+		MATRIX_KEY(5, 10, 0x6f)
+		MATRIX_KEY(6,  0, 0x2b)
+		MATRIX_KEY(6,  2, 0x4e)
+		MATRIX_KEY(6,  3, 0x68)
+		MATRIX_KEY(6,  4, 0x03)
+		MATRIX_KEY(6,  5, 0x6d)
+		MATRIX_KEY(6,  6, 0x09)
+		MATRIX_KEY(6,  7, 0x01)
+		MATRIX_KEY(6,  9, 0x0f)
+		MATRIX_KEY(7,  8, 0x2a)
+		MATRIX_KEY(7,  9, 0x1d)
+		MATRIX_KEY(7, 10, 0x33)
+	>;
 };
 
 &vbus_reg {
diff --git a/arch/arm/boot/dts/nspire/nspire-tp.dts b/arch/arm/boot/dts/nspire/nspire-tp.dts
index f7d0faacd4ccd..235cd4264da79 100644
--- a/arch/arm/boot/dts/nspire/nspire-tp.dts
+++ b/arch/arm/boot/dts/nspire/nspire-tp.dts
@@ -6,32 +6,78 @@
  */
 /dts-v1/;
 
+#include <dt-bindings/input/input.h>
+
 /include/ "nspire-classic.dtsi"
 
 &keypad {
 	linux,keymap = <
-	0x0000001c 	0x0001001c 	0x00040039
-	0x0005002c 	0x00060015 	0x0007000b
-	0x0008000f 	0x0100002d 	0x01010011
-	0x0102002f 	0x01030004 	0x01040016
-	0x01050014 	0x0106001f 	0x01070002
-	0x010a006a 	0x02000013 	0x02010010
-	0x02020019 	0x02030007 	0x02040018
-	0x02050031 	0x02060032 	0x02070005
-	0x02080028 	0x0209006c 	0x03000026
-	0x03010025 	0x03020024 	0x0303000a
-	0x03040017 	0x03050023 	0x03060022
-	0x03070008 	0x03080035 	0x03090069
-	0x04000021 	0x04010012 	0x04020020
-	0x0404002e 	0x04050030 	0x0406001e
-	0x0407000d 	0x04080037 	0x04090067
-	0x05010038 	0x0502000c 	0x0503001b
-	0x05040034 	0x0505001a 	0x05060006
-	0x05080027 	0x0509000e 	0x050a006f
-	0x0600002b 	0x0602004e 	0x06030068
-	0x06040003 	0x0605006d 	0x06060009
-	0x06070001 	0x0609000f 	0x0708002a
-	0x0709001d 	0x070a0033 	>;
+		MATRIX_KEY(0,  0, 0x1c)
+		MATRIX_KEY(0,  1, 0x1c)
+		MATRIX_KEY(0,  4, 0x39)
+		MATRIX_KEY(0,  5, 0x2c)
+		MATRIX_KEY(0,  6, 0x15)
+		MATRIX_KEY(0,  7, 0x0b)
+		MATRIX_KEY(0,  8, 0x0f)
+		MATRIX_KEY(1,  0, 0x2d)
+		MATRIX_KEY(1,  1, 0x11)
+		MATRIX_KEY(1,  2, 0x2f)
+		MATRIX_KEY(1,  3, 0x04)
+		MATRIX_KEY(1,  4, 0x16)
+		MATRIX_KEY(1,  5, 0x14)
+		MATRIX_KEY(1,  6, 0x1f)
+		MATRIX_KEY(1,  7, 0x02)
+		MATRIX_KEY(1, 10, 0x6a)
+		MATRIX_KEY(2,  0, 0x13)
+		MATRIX_KEY(2,  1, 0x10)
+		MATRIX_KEY(2,  2, 0x19)
+		MATRIX_KEY(2,  3, 0x07)
+		MATRIX_KEY(2,  4, 0x18)
+		MATRIX_KEY(2,  5, 0x31)
+		MATRIX_KEY(2,  6, 0x32)
+		MATRIX_KEY(2,  7, 0x05)
+		MATRIX_KEY(2,  8, 0x28)
+		MATRIX_KEY(2,  9, 0x6c)
+		MATRIX_KEY(3,  0, 0x26)
+		MATRIX_KEY(3,  1, 0x25)
+		MATRIX_KEY(3,  2, 0x24)
+		MATRIX_KEY(3,  3, 0x0a)
+		MATRIX_KEY(3,  4, 0x17)
+		MATRIX_KEY(3,  5, 0x23)
+		MATRIX_KEY(3,  6, 0x22)
+		MATRIX_KEY(3,  7, 0x08)
+		MATRIX_KEY(3,  8, 0x35)
+		MATRIX_KEY(3,  9, 0x69)
+		MATRIX_KEY(4,  0, 0x21)
+		MATRIX_KEY(4,  1, 0x12)
+		MATRIX_KEY(4,  2, 0x20)
+		MATRIX_KEY(4,  4, 0x2e)
+		MATRIX_KEY(4,  5, 0x30)
+		MATRIX_KEY(4,  6, 0x1e)
+		MATRIX_KEY(4,  7, 0x0d)
+		MATRIX_KEY(4,  8, 0x37)
+		MATRIX_KEY(4,  9, 0x67)
+		MATRIX_KEY(5,  1, 0x38)
+		MATRIX_KEY(5,  2, 0x0c)
+		MATRIX_KEY(5,  3, 0x1b)
+		MATRIX_KEY(5,  4, 0x34)
+		MATRIX_KEY(5,  5, 0x1a)
+		MATRIX_KEY(5,  6, 0x06)
+		MATRIX_KEY(5,  8, 0x27)
+		MATRIX_KEY(5,  9, 0x0e)
+		MATRIX_KEY(5, 10, 0x6f)
+		MATRIX_KEY(6,  0, 0x2b)
+		MATRIX_KEY(6,  2, 0x4e)
+		MATRIX_KEY(6,  3, 0x68)
+		MATRIX_KEY(6,  4, 0x03)
+		MATRIX_KEY(6,  5, 0x6d)
+		MATRIX_KEY(6,  6, 0x09)
+		MATRIX_KEY(6,  7, 0x01)
+		MATRIX_KEY(6,  9, 0x0f)
+		MATRIX_KEY(7,  8, 0x2a)
+		MATRIX_KEY(7,  9, 0x1d)
+		MATRIX_KEY(7, 10, 0x33)
+	>;
 };
 
 / {
-- 
2.39.2

