Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74247C84D7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjJMLry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjJMLrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:47:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EFBBE;
        Fri, 13 Oct 2023 04:47:49 -0700 (PDT)
Received: from obbardc-t14.home (unknown [IPv6:2a00:23c8:b70a:ae01:c2e1:3bb7:ed5c:6a0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: obbardc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A2AC1660735A;
        Fri, 13 Oct 2023 12:47:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697197667;
        bh=7wBhq8J/K/1bY+rvYJYJn0dZJWPNRTfsi3k23DiS4JQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=auERhDk/wHm2olVXfZGaBS+q8f0ICzVsMWGOl9LcOlyjS57+Jb/4c2IDhiOxPygoW
         CWvBv3s7DV+bskN7fNyogAYvIn3RYndPReHhslD84IAO7P5A3aH22BgZB0ZQIhZoOc
         TD+nfHK/evLVd7o3yflCbfuUALEFcMPTI+9y6oBk2zKicEmiNJ6ISYTE/E0rK78k+S
         1jOT+e29BeOLL5zqBoquBPwyzDOWVfO2OCTpRDO3Ru0kqDvxe+pX4u9mBr+dxTdVts
         erM4OfVptiTR+Y2Y3rnLGYnoSQcaeAV2/Qm174hNNXTDtVFeUezgliteiAo4JM88UZ
         1yMSKDJABKlvw==
From:   Christopher Obbard <chris.obbard@collabora.com>
To:     linux-rockchip@lists.infradead.org
Cc:     kernel@collabora.com,
        Christopher Obbard <chris.obbard@collabora.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Brian Norris <briannorris@chromium.org>,
        Caleb Connolly <kc@postmarketos.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] arm64: dts: rockchip: Add i2s0-2ch-bus-bclk-off pins to RK3399
Date:   Fri, 13 Oct 2023 12:47:26 +0100
Message-ID: <20231013114737.494410-2-chris.obbard@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231013114737.494410-1-chris.obbard@collabora.com>
References: <20231013114737.494410-1-chris.obbard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0efaf8078393 ("arm64: dts: rockchip: add i2s0-2ch-bus pins on
rk3399") introduced a pinctl for i2s0 in two-channel mode. Commit
91419ae0420f ("arm64: dts: rockchip: use BCLK to GPIO switch on rk3399")
modified i2s0 to switch the corresponding pins off when idle.

Although an idle pinctrl node was added for i2s0 in 8-channel mode, a
similar idle pinctrl node for i2s0 in 2-channel mode was not added. Add
it.

Fixes: 91419ae0420f ("arm64: dts: rockchip: use BCLK to GPIO switch on rk3399")
Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
---

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 9da0b6d77c8d2..5bc2d4faeea6d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -2457,6 +2457,16 @@ i2s0_2ch_bus: i2s0-2ch-bus {
 					<4 RK_PA0 1 &pcfg_pull_none>;
 			};
 
+			i2s0_2ch_bus_bclk_off: i2s0-2ch-bus-bclk-off {
+				rockchip,pins =
+					<3 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>,
+					<3 RK_PD1 1 &pcfg_pull_none>,
+					<3 RK_PD2 1 &pcfg_pull_none>,
+					<3 RK_PD3 1 &pcfg_pull_none>,
+					<3 RK_PD7 1 &pcfg_pull_none>,
+					<4 RK_PA0 1 &pcfg_pull_none>;
+			};
+
 			i2s0_8ch_bus: i2s0-8ch-bus {
 				rockchip,pins =
 					<3 RK_PD0 1 &pcfg_pull_none>,
-- 
2.42.0

