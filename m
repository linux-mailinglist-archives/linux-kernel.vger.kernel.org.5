Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E407E3EA3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343594AbjKGMkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235243AbjKGMif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:38:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB60C59DF;
        Tue,  7 Nov 2023 04:26:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47380C433CA;
        Tue,  7 Nov 2023 12:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699360018;
        bh=3zdn/xAE4+pyIvadW5DRQWZFaXeQ2YLq9a+v8tV8wJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LWzJzbwueqSgNSLWFf0sL5hwHpycqGDOa9pamHd4c0XloUhr95jRFrXimM0VsY7U+
         uYi3fMmcl52pqv98VTJZl3TS0ElV2Fgq1lQtKbTS3A8trcIxsjmF7RSDrqQaNl0sy7
         jJqx/0F2g0I4bWBQFPBvbDY4NlzMot9HDfNJnxCFmGv2OCPRLcXpZjoL9/RIauhU/K
         kI+RvDabXFJasJbhJkWozkilcN1SP3EdYRaa5Kpi+9hCFMP3AbgvWQmQsVfmyKo8ZQ
         0CBv1jMKxQ8mZhd0mS8PscX0GfLji19abWVvMNUfaJf3Jp3EpR4AbvZRwjW1OrDnX5
         M1WO0r4aIzR2g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chris Morgan <macromorgan@hotmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jagan@edgeble.ai, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 6.5 35/37] arm64: dts: rockchip: add USB2 to rk3588s-indiedroid
Date:   Tue,  7 Nov 2023 07:21:46 -0500
Message-ID: <20231107122407.3760584-35-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107122407.3760584-1-sashal@kernel.org>
References: <20231107122407.3760584-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.10
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

[ Upstream commit aee432b50f6e15886bddcb6f92028265db4b254e ]

Enable USB2 (EHCI and OCHI mode) support for the Indiedroid Nova. This
adds support for USB for the 4 full size USB-A ports. Note that USB 3
(the two blue full-size USB-A ports) is still outstanding, as is
support for USB on the USB-C ports. The controller is not yet supported
for these ports.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Link: https://lore.kernel.org/r/20230918173255.1325-3-macroalpha82@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../dts/rockchip/rk3588s-indiedroid-nova.dts  | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts b/arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts
index 6fecdb511061e..0ee9b562094ca 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts
@@ -753,6 +753,24 @@ &tsadc {
 	status = "okay";
 };
 
+&u2phy2 {
+	status = "okay";
+};
+
+&u2phy2_host {
+	phy-supply = <&vcc5v0_usb>;
+	status = "okay";
+};
+
+&u2phy3 {
+	status = "okay";
+};
+
+&u2phy3_host {
+	phy-supply = <&vcc5v0_usb>;
+	status = "okay";
+};
+
 &uart2 {
 	pinctrl-0 = <&uart2m0_xfer>;
 	status = "okay";
@@ -777,3 +795,19 @@ bluetooth {
 		pinctrl-names = "default";
 	};
 };
+
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host0_ohci {
+	status = "okay";
+};
+
+&usb_host1_ehci {
+	status = "okay";
+};
+
+&usb_host1_ohci {
+	status = "okay";
+};
-- 
2.42.0

