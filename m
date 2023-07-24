Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D41E75E79C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjGXB3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjGXB2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:28:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BD349D0;
        Sun, 23 Jul 2023 18:25:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B6BD60F02;
        Mon, 24 Jul 2023 01:24:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94032C433C7;
        Mon, 24 Jul 2023 01:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690161869;
        bh=4R0+W1fgg+0tYuNuTNsVnNDYQV9lCk4hbYmh/NN+z4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ju7n9ywQnq4KoyJsr5ckiwJ8ci3jRD4a4fdkjcJv+APlDYPXiA3WFusirBsfo/Xfc
         C0zwOvEkZYbvcQiObGUqq2oelPioGcUEkoBd08TB42YhG/LUhMv7gkBU/5VSXsZ9Cv
         nHzFdY14bDInXzeNkfaHR+JotB8fYFVItTOYChCa3mjaOhDdHc/075/SKZ3RgMVZLT
         eDlKdyXs68p3kRoN8KJ8+mZvJklf2Ic5prc2vqVla4Q7CAMrnbTx+d1Cw2jcex3CNk
         Ve4Zl2fqHawDbyN/MNKNs6PBH+8f3K2VEkl0puWfKx2T+gvG4ex/IvhQSpaIwK3/AK
         7J6usvhwx/4HQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, kernel@pengutronix.de,
        robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 06/22] ARM: dts: imx6dl: prtrvt, prtvt7, prti6q, prtwd2: fix USB related warnings
Date:   Sun, 23 Jul 2023 21:24:03 -0400
Message-Id: <20230724012419.2317649-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724012419.2317649-1-sashal@kernel.org>
References: <20230724012419.2317649-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.186
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksij Rempel <o.rempel@pengutronix.de>

[ Upstream commit 1d14bd943fa2bbdfda1efbcc080b298fed5f1803 ]

Fix USB-related warnings in prtrvt, prtvt7, prti6q and prtwd2 device trees
by disabling unused usbphynop1 and usbphynop2 USB PHYs and providing proper
configuration for the over-current detection. This fixes the following
warnings with the current kernel:
 usb_phy_generic usbphynop1: dummy supplies not allowed for exclusive requests
 usb_phy_generic usbphynop2: dummy supplies not allowed for exclusive requests
 imx_usb 2184200.usb: No over current polarity defined

By the way, fix over-current detection on usbotg port for prtvt7, prti6q
and prtwd2 boards. Only prtrvt do not have OC on USB OTG port.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx6dl-prtrvt.dts   |  4 ++++
 arch/arm/boot/dts/imx6qdl-prti6q.dtsi | 11 ++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6dl-prtrvt.dts b/arch/arm/boot/dts/imx6dl-prtrvt.dts
index 5ac84445e9cc1..90e01de8c2c15 100644
--- a/arch/arm/boot/dts/imx6dl-prtrvt.dts
+++ b/arch/arm/boot/dts/imx6dl-prtrvt.dts
@@ -126,6 +126,10 @@
 	status = "disabled";
 };
 
+&usbotg {
+	disable-over-current;
+};
+
 &vpu {
 	status = "disabled";
 };
diff --git a/arch/arm/boot/dts/imx6qdl-prti6q.dtsi b/arch/arm/boot/dts/imx6qdl-prti6q.dtsi
index 19578f660b092..70dfa07a16981 100644
--- a/arch/arm/boot/dts/imx6qdl-prti6q.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-prti6q.dtsi
@@ -69,6 +69,7 @@
 	vbus-supply = <&reg_usb_h1_vbus>;
 	phy_type = "utmi";
 	dr_mode = "host";
+	disable-over-current;
 	status = "okay";
 };
 
@@ -78,10 +79,18 @@
 	pinctrl-0 = <&pinctrl_usbotg>;
 	phy_type = "utmi";
 	dr_mode = "host";
-	disable-over-current;
+	over-current-active-low;
 	status = "okay";
 };
 
+&usbphynop1 {
+	status = "disabled";
+};
+
+&usbphynop2 {
+	status = "disabled";
+};
+
 &usdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc1>;
-- 
2.39.2

