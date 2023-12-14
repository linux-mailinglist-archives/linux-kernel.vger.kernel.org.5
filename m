Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A7A8132F9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573476AbjLNOXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573436AbjLNOX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:23:29 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A301C9C;
        Thu, 14 Dec 2023 06:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1702563813; x=1734099813;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GuTsEbsrgq1gO61F1rlbCZQ+oOYllzhwEJYqGvGdEg4=;
  b=e7EtUyn7gjK8abNQ2hUHxKalezKhquAVsmgWddlozqbAJiouPb3DDbk+
   s1+RYTiUuoo+RaEF5/IZTQBS5D8EgqvuDUJ85gYchiPA4OHI8me1cRbWv
   XxgdyPAcIkOD/luABk8hD/6+aib/4dqmfADidQmyqbUOxtbcgPcsZYBQz
   WWNM/EQCJP0XEdytO2V/OaQPIeeJE1eOyfZqE+BNU4w9KqyVOVZ870z94
   eWhUBDz+IVk3PSA5CGyUuwNcH7XLFZ7sEnfl9jIYAN+d99KX4AZgOVZ+R
   BN8iMJh5KKuLcPY2/gtz3YVxUt36sjgfg9eoBTmr9zdQ8vWE7JgfjPUIU
   Q==;
X-IronPort-AV: E=Sophos;i="6.04,275,1695679200"; 
   d="scan'208";a="34512085"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 14 Dec 2023 15:23:30 +0100
Received: from steina-w.tq-net.de (steina-w.tq-net.de [10.123.53.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id E3706280084;
        Thu, 14 Dec 2023 15:23:29 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marek Vasut <marex@denx.de>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/4] arm64: dts: imx: add imx8dxp support
Date:   Thu, 14 Dec 2023 15:23:24 +0100
Message-Id: <20231214142327.1962914-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214142327.1962914-1-alexander.stein@ew.tq-group.com>
References: <20231214142327.1962914-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX 8DualXPlus is a dual (2x) Cortex-A35 processor with powerful
graphic and multimedia features. This patch adds the SoC dtsi, based on
imx8qxp removing the additional CPU cores. Peripherals are identical.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/imx8dxp.dtsi | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dxp.dtsi

diff --git a/arch/arm64/boot/dts/freescale/imx8dxp.dtsi b/arch/arm64/boot/dts/freescale/imx8dxp.dtsi
new file mode 100644
index 0000000000000..a8f7352332c05
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8dxp.dtsi
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017-2019 NXP
+ */
+
+/dts-v1/;
+
+#include "imx8qxp.dtsi"
+
+/delete-node/ &A35_2;
+/delete-node/ &A35_3;
+
+&thermal_zones {
+	cpu0-thermal {
+		cooling-maps {
+			map0 {
+				cooling-device =
+				<&A35_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+				<&A35_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+			};
+		};
+	};
+};
-- 
2.34.1

