Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714F377617F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbjHINoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjHINoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:44:20 -0400
Received: from TWMBX02.aspeed.com (mail.aspeedtech.com [211.20.114.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678371986;
        Wed,  9 Aug 2023 06:44:17 -0700 (PDT)
Received: from TWMBX02.aspeed.com (192.168.0.24) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 9 Aug
 2023 21:44:17 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Aug 2023 21:44:17 +0800
From:   Dylan Hung <dylan_hung@aspeedtech.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     <kobedylan@gmail.com>, <BMC-SW@aspeedtech.com>,
        Jeremy Kerr <jk@codeconstruct.com.au>
Subject: [PATCH v2] ARM: dts: pinctrl-aspeed-g6: Add I3C1 and I3C2 control pins
Date:   Wed, 9 Aug 2023 21:44:13 +0800
Message-ID: <20230809134413.3614535-1-dylan_hung@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: Fail (TWMBX02.aspeed.com: domain of dylan_hung@aspeedtech.com
 does not designate 192.168.10.10 as permitted sender)
 receiver=TWMBX02.aspeed.com; client-ip=192.168.10.10;
 helo=localhost.localdomain;
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_FAIL,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl support for the I3C1 and I3C2 pins.

Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
Reviewed-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
changes in v2:
There are no code or message changes in v2. This commit is being made as
a standalone patch separate from the original patch series, as the other
patches from the original series are no longer necessary.
 
 arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi
index 7cd4f075e325..289668f051eb 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi
@@ -297,6 +297,16 @@ pinctrl_i2c9_default: i2c9_default {
 		groups = "I2C9";
 	};
 
+	pinctrl_i3c1_default: i3c1_default {
+		function = "I3C1";
+		groups = "I3C1";
+	};
+
+	pinctrl_i3c2_default: i3c2_default {
+		function = "I3C2";
+		groups = "I3C2";
+	};
+
 	pinctrl_i3c3_default: i3c3_default {
 		function = "I3C3";
 		groups = "I3C3";
-- 
2.25.1

