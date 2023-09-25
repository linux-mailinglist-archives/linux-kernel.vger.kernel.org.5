Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D028B7AD198
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjIYH0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjIYHZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:25:58 -0400
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDFEC6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 00:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1695626746; x=1698218746;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=93rMHGvdAme1AeDl4W450VE6qEyXJijOqeQ0sdUbEmo=;
        b=Kf770LpR2EWWK+zoF5BbBVNUMCl8QgfWoNZQ2JqRoQS/mtRhLaGx/PVgKf1gFcbj
        Xlg2DfQQvx+rcjaOgvRehp8sP1/MoIvvJ5deXSshcsp5wPhgDsWZ3G7cIa74XsiP
        Ji66/RQwF8TLPEIMmiuBBCMLIIerIdANgAe+IaMlTw8=;
X-AuditID: ac14000a-6d65670000001e37-4e-651135f9e358
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 60.5C.07735.9F531156; Mon, 25 Sep 2023 09:25:45 +0200 (CEST)
Received: from lws-moog.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 25 Sep
 2023 09:25:45 +0200
From:   Yannic Moog <y.moog@phytec.de>
Subject: [PATCH v2 0/2] Add support for the phyGATE-Tauri-L IoT Gateway
Date:   Mon, 25 Sep 2023 09:25:17 +0200
Message-ID: <20230925-tauri_upstream_support-v2-0-62a6dfc48e31@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN41EWUC/3WNQQ6CMBBFr0Jmbc20BCmuvIchpLaDdCE000Ikh
 Ltbce3yveS/v0Ek9hThWmzAtPjopzGDOhVgBzM+SXiXGRSqErXSIpmZfTeHmJjMq4tzCBMngbo
 3Vsm6khVCHgem3r+P8L3NPPiYJl6Pn0V+7S/ZoPyXXKRAQa5Ee3F9rZvHLQxrInt2BO2+7x+r/
 I8rvAAAAA==
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <upstream@lists.phytec.de>,
        Yannic Moog <y.moog@phytec.de>,
        Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.3
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42JZI8nAo/vTVDDVoGW9lcWaveeYLKZs2sFu
        Mf/IOVaLh1f9LVZN3cli0ffiIbPFoeYDTBabHl9jtej6tZLZ4vKuOWwWrXuPsFv83b6JxeLF
        FnGL7nfqDnweO2fdZffYtKqTzePOtT1sHpuX1Hv0d7ewetz5sZTRY+O7HUwe/X8NPD5vkgvg
        jOKySUnNySxLLdK3S+DK2LhmM3vBTvaKvXOqGxg72boYOTkkBEwkVjzazQRiCwksYZJ4s8+i
        i5ELyH7EKHH41RGwBJuAisTjF/dYQWxhAXeJthdfWLoYOThYBFQlVnZVg4R5BTwlbm/7ywZh
        C0qcnPkErIRZQFNi/S59kDCzgLzE9rdzmEHGSwh8ZpT42NTPBOKICLxgkjg27QcriMMscJlR
        4vf7NewQ1wlLtC+6BXWdrMSL871QcXmJaedeM0PYoRJHNq1mmsAoOAvJ8lkIy2chWb6AkXkV
        o1BuZnJ2alFmtl5BRmVJarJeSuomRlBkiTBw7WDsm+NxiJGJg/EQowQHs5II769nfKlCvCmJ
        lVWpRfnxRaU5qcWHGKU5WJTEee/3MCUKCaQnlqRmp6YWpBbBZJk4OKUaGEOjv5r5ct+9y/k1
        WuBhuOurIJcZz7eHeEz/tYBnf0vqvLsxbWJrDPvuuMU5HF913N6qaluddjaP7ALDnK+PZZdl
        vS98ddLOXUdnl2bE0bvrZ2lP6BSoDnysGZw77eTRo187U1gEj5e27DT51t35nmWSgvJZH9kp
        Xqk6phpe70MmVqYYXftro8RSnJFoqMVcVJwIAD2Wg2KaAgAA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The phyGATE-Tauri-L is a SBC that uses the phyCORE-i.MX8MM SoM, but has
a different carrier board.
This series adds support for the board and most of its interfaces.
Notably, RS485 support is missing.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
Changes in v2:
- change license of tauri devicetree file.
- fix devicetree style issues, no functional change

---
Yannic Moog (2):
      dt-bindings: arm: fsl: add phyGATE-Tauri-L board
      arm64: dts: freescale: add phyGATE-Tauri i.MX 8M Mini Support

 Documentation/devicetree/bindings/arm/fsl.yaml     |   4 +-
 arch/arm64/boot/dts/freescale/Makefile             |   1 +
 .../boot/dts/freescale/imx8mm-phygate-tauri-l.dts  | 489 +++++++++++++++++++++
 3 files changed, 493 insertions(+), 1 deletion(-)
---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230828-tauri_upstream_support-08fac2175150

Best regards,
-- 
Yannic Moog <y.moog@phytec.de>

