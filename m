Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448D180E2AA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 04:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345841AbjLLDSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 22:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbjLLDSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 22:18:47 -0500
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B46CD;
        Mon, 11 Dec 2023 19:18:53 -0800 (PST)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1rCtI7-0002gF-1h;
        Tue, 12 Dec 2023 03:18:40 +0000
Date:   Tue, 12 Dec 2023 03:18:37 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Daniel Golle <daniel@makrotopia.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        "Garmin.Chang" <Garmin.Chang@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: [PATCH v5 2/5] dt-bindings: reset: mediatek: add MT7988 ethwarp
 reset IDs
Message-ID: <a60f5b5ed58626f3dbac1eab8a5845c3ce9bd17c.1702350213.git.daniel@makrotopia.org>
References: <152b256d253508cdc7514c0f1c5a9324bde83d46.1702350213.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152b256d253508cdc7514c0f1c5a9324bde83d46.1702350213.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset ID for ethwarp subsystem allowing to reset the built-in
Ethernet switch of the MediaTek MT7988 SoC.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v5: add this patch to replace use of ti,syscon-reset in v1~v4

 include/dt-bindings/reset/mediatek,mt7988-resets.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 include/dt-bindings/reset/mediatek,mt7988-resets.h

diff --git a/include/dt-bindings/reset/mediatek,mt7988-resets.h b/include/dt-bindings/reset/mediatek,mt7988-resets.h
new file mode 100644
index 0000000000000..4933019713672
--- /dev/null
+++ b/include/dt-bindings/reset/mediatek,mt7988-resets.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2023 Daniel Golle <daniel@makrotopia.org>
+ * Author: Daniel Golle <daniel@makrotopia.org>
+ */
+
+#ifndef _DT_BINDINGS_RESET_CONTROLLER_MT7988
+#define _DT_BINDINGS_RESET_CONTROLLER_MT7988
+
+/* ETHWARP resets */
+#define MT7988_ETHWARP_RST_SWITCH		0
+
+#endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT7988 */
-- 
2.43.0
