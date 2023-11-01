Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD547DE00F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 12:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbjKALED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 07:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235080AbjKALD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 07:03:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964708F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 04:03:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F27AC433CC;
        Wed,  1 Nov 2023 11:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698836632;
        bh=O8as42x5ndOrDmGNnepxKUAmwZWt7aj9xgh7RSmq0xE=;
        h=From:Date:Subject:To:Cc:Reply-To:From;
        b=EcVPN4FC2mluKKCX1eQ7d3QqQmvsmK0A3D4RSSJrU94aT+fNNR0wZVfAfabEanq3l
         n+KQbq8ZaF3MZA3AlS7mycp1D4cCPOur3frgYVCs5PZrRYQ6i//nSQLp/lmVRbJMNr
         EpHTsMCXoNTw29VQxRCD1MivBapi3AqSOtBaev1r/yyKg70qxLI3a+QFK+ewHzUvpR
         LLg7JnxS574QJq1z0//VR8UIzI0k8V9OMJ8sJtx2kPSGYFjuVibWdj6i/+NZO+G85i
         Tu0nixkvIEWUlh5rKxWq8hSznMzip6zcwYBU5geUbcXUhdFlVcYnTT2icMui2DvQ9H
         YeIqAS6pkizKA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 56AA1C4332F;
        Wed,  1 Nov 2023 11:03:52 +0000 (UTC)
From:   Stefan Kerkmann via B4 Relay 
        <devnull+s.kerkmann.pengutronix.de@kernel.org>
Date:   Wed, 01 Nov 2023 12:03:37 +0100
Subject: [PATCH] ARM: dts: imx6q: skov: fix ethernet clock regression
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231101-v6-6-topic-imx6q-dt-v1-1-274f6c13c7d5@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAIgwQmUC/x3MMQqAMAxA0atIZgNp1QxeRRxKjZpBW1sRQby7x
 fEN/z+QJalk6KsHklyaNewFpq7Ar25fBHUqBku2MYYMXoyMZ4jqUbebD5xOtI6IpXUdzRZKGZP
 Mev/XYXzfD+iNzBhlAAAA
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Stefan Kerkmann <s.kerkmann@pengutronix.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698836631; l=1806;
 i=s.kerkmann@pengutronix.de; s=20231101; h=from:subject:message-id;
 bh=I+le/prsadbXxCLhWl2Zg97MQQpgF73MgSjiwEzuvl8=;
 b=Y+NN+IswQatXB+MvnetAR6jYvducRyXvRD32cp/WZG8JC6mjw+Is/4Ttha1e1elBXyySc2C1e
 aC/HO99jTjCDlag06tyKRjNs6anVp/TZXV/YRsW7EggaDCLAYHZlFUw
X-Developer-Key: i=s.kerkmann@pengutronix.de; a=ed25519;
 pk=tqGkJoWHUyszJPfH6R854H1WT2BhbUdJMbIrIzZCg5s=
X-Endpoint-Received: by B4 Relay for s.kerkmann@pengutronix.de/20231101 with auth_id=94
X-Original-From: Stefan Kerkmann <s.kerkmann@pengutronix.de>
Reply-To: <s.kerkmann@pengutronix.de>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Kerkmann <s.kerkmann@pengutronix.de>

A regression was introduced in the Skov specific i.MX6 flavor
reve-mi1010ait-1cp1 device tree causing the external ethernet controller
to not being selected as the clock source for the i.MX6 ethernet MAC,
resulting in a none functional ethernet interface. The root cause is
that the ethernet clock selection is now part of the clocks node, which
is overwritten in the specific device tree and wasn't updated to contain
these ethernet clocks.

Fixes: c89614079e44 ("ARM: dts: imx6qdl-skov-cpu: configure ethernet reference clock parent")
Signed-off-by: Stefan Kerkmann <s.kerkmann@pengutronix.de>
---
This patch fixes a small regression in the device tree for the Skov
specific i.MX6 flavor reve-mi1010ait-1cp1 which caused a none functional
ethernet interface.
---
 arch/arm/boot/dts/nxp/imx/imx6q-skov-reve-mi1010ait-1cp1.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-skov-reve-mi1010ait-1cp1.dts b/arch/arm/boot/dts/nxp/imx/imx6q-skov-reve-mi1010ait-1cp1.dts
index a3f247c722b4..0342a79ccd5d 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-skov-reve-mi1010ait-1cp1.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-skov-reve-mi1010ait-1cp1.dts
@@ -37,9 +37,9 @@ panel_in: endpoint {
 
 &clks {
 	assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>,
-			  <&clks IMX6QDL_CLK_LDB_DI1_SEL>;
+			  <&clks IMX6QDL_CLK_LDB_DI1_SEL>, <&clks IMX6QDL_CLK_ENET_REF_SEL>;
 	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL5_VIDEO_DIV>,
-				 <&clks IMX6QDL_CLK_PLL5_VIDEO_DIV>;
+				 <&clks IMX6QDL_CLK_PLL5_VIDEO_DIV>, <&clk50m_phy>;
 };
 
 &hdmi {

---
base-commit: 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1
change-id: 20231101-v6-6-topic-imx6q-dt-2a006e4a50f2

Best regards,
-- 
Stefan Kerkmann <s.kerkmann@pengutronix.de>

