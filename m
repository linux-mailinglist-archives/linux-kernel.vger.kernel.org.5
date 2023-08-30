Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078A678D279
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 05:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241891AbjH3DTe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 29 Aug 2023 23:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238759AbjH3DSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 23:18:55 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D009CC9;
        Tue, 29 Aug 2023 20:18:51 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 2229980C5;
        Wed, 30 Aug 2023 11:18:50 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 30 Aug
 2023 11:18:49 +0800
Received: from williamqiu-virtual-machine.starfivetech.com (171.223.208.138)
 by EXMBX168.cuchost.com (172.16.6.78) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Wed, 30 Aug 2023 11:18:49 +0800
From:   William Qiu <william.qiu@starfivetech.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-mmc@vger.kernel.org>
CC:     Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        William Qiu <william.qiu@starfivetech.com>
Subject: [PATCH v1 3/3] riscv: dts: starfive: Drop unused properties and limit frquency
Date:   Wed, 30 Aug 2023 11:18:46 +0800
Message-ID: <20230830031846.127957-4-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230830031846.127957-1-william.qiu@starfivetech.com>
References: <20230830031846.127957-1-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop unused properties and limit cclk_in to 50M, thus cancelling the
internal frequency and adopting the by-pass mode.

Signed-off-by: William Qiu <william.qiu@starfivetech.com>
---
 .../riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi | 4 ++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi                      | 2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index d79f94432b27..d1f2ec308bca 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -205,6 +205,8 @@ &i2c6 {
 
 &mmc0 {
 	max-frequency = <100000000>;
+	assigned-clocks = <&syscrg JH7110_SYSCLK_SDIO0_SDCARD>;
+	assigned-clock-rates = <50000000>;
 	bus-width = <8>;
 	cap-mmc-highspeed;
 	mmc-ddr-1_8v;
@@ -221,6 +223,8 @@ &mmc0 {
 
 &mmc1 {
 	max-frequency = <100000000>;
+	assigned-clocks = <&syscrg JH7110_SYSCLK_SDIO1_SDCARD>;
+	assigned-clock-rates = <50000000>;
 	bus-width = <4>;
 	no-sdio;
 	no-mmc;
diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index e85464c328d0..7b8e841aeef8 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -870,7 +870,6 @@ mmc0: mmc@16010000 {
 			fifo-depth = <32>;
 			fifo-watermark-aligned;
 			data-addr = <0>;
-			starfive,sysreg = <&sys_syscon 0x14 0x1a 0x7c000000>;
 			status = "disabled";
 		};
 
@@ -886,7 +885,6 @@ mmc1: mmc@16020000 {
 			fifo-depth = <32>;
 			fifo-watermark-aligned;
 			data-addr = <0>;
-			starfive,sysreg = <&sys_syscon 0x9c 0x1 0x3e>;
 			status = "disabled";
 		};
 
-- 
2.34.1

