Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DA27B5177
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 13:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236695AbjJBLfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 07:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjJBLfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:35:03 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778C4BF
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 04:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :mime-version:content-transfer-encoding; s=k1; bh=PVFYZy0ARB0Ir/
        opkUijq37R80R5ihV2iohA49i/p94=; b=dhgplXggEMUmtHf8YWo1fxG2khbfD1
        vANkwwzl+P9Mjv4aE0BhpYuCSI2sID79CaNcUcl1khaOVQfbWvI0niwedvS4V9qf
        rXfZ6ahhCgPAYrrAmvlgiAh6UkrSPPEj6KpHF6b33bFZTojyQiP0FNopZI9vtxYz
        SqN7Joa+czso0IIJEgwDnr2ezeRPUoTz7I82XUoaqC6aRA9nT9KzCcG6BHOCmGqw
        OLC4YjbbuwoCnmbgbhTNHiI+fbl+W1iSWfeWh8hN54g/6Rtum2j/zlAP+frtMBzG
        a+NL8d8ASaNbaL/n6MfFIOWL115gM1R8j4Ewmta7HW4KRiwdm6hyKI3A==
Received: (qmail 509107 invoked from network); 2 Oct 2023 13:34:57 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 2 Oct 2023 13:34:57 +0200
X-UD-Smtp-Session: l3s3148p1@6aK5KboGfJcujntX
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Takeshi Kihara <takeshi.kihara.df@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] arm64: dts: renesas: r8a77990: Add Ebisu-4D board support
Date:   Mon,  2 Oct 2023 13:34:41 +0200
Message-Id: <20231002113441.19571-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

Add initial support for the Renesas Ebisu-4D development board.

The Ebisu-4D board is very similar to the Ebisu board, but the memory
configuration is different.

  - The memory map of Ebisu-4D board is as follows:
      Bank0: 2 GiB RAM : 0x000048000000 -> 0x000bfffffff

  - The memory map of Ebisu board is as follows:
      Bank0: 1 GiB RAM : 0x000048000000 -> 0x0007fffffff

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[wsa: rebased]
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Resending this patch because I want to utilize all 2GB of memory on my
Ebisu. Since nobody updated U-Boot to handle different RAM sizes on
Ebisu in the last 4.5 years, let's add the Ebisu-4D as a seperate board.


 arch/arm64/boot/dts/renesas/Makefile          |  1 +
 .../boot/dts/renesas/r8a77990-ebisu-4d.dts    | 25 +++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77990-ebisu-4d.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 7114cbbd8713..ad8f13f9907a 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -55,6 +55,7 @@ dtb-$(CONFIG_ARCH_R8A77980) += r8a77980-v3hsk.dtb
 dtb-$(CONFIG_ARCH_R8A77980) += r8a77980a-condor-i.dtb
 
 dtb-$(CONFIG_ARCH_R8A77990) += r8a77990-ebisu.dtb
+dtb-$(CONFIG_ARCH_R8A77990) += r8a77990-ebisu-4d.dtb
 
 dtb-$(CONFIG_ARCH_R8A77995) += r8a77995-draak.dtb
 
diff --git a/arch/arm64/boot/dts/renesas/r8a77990-ebisu-4d.dts b/arch/arm64/boot/dts/renesas/r8a77990-ebisu-4d.dts
new file mode 100644
index 000000000000..9f5bc7a7734f
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a77990-ebisu-4d.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the Ebisu-4D board
+ *
+ * Copyright (C) 2018 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+#include "r8a77990-ebisu.dts"
+
+/ {
+	model = "Renesas Ebisu-4D board based on r8a77990";
+	compatible = "renesas,ebisu", "renesas,r8a77990";
+
+	memory@48000000 {
+		device_type = "memory";
+		/* first 128MB is reserved for secure area. */
+		reg = <0x0 0x48000000 0x0 0x78000000>;
+	};
+};
+
+&pciec0 {
+	/* Map all possible DDR as inbound ranges */
+	dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x80000000>;
+};
-- 
2.30.2

