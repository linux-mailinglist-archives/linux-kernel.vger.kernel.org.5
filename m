Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4029F7E93E6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 02:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbjKMBHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 20:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbjKMBHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 20:07:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED897259D
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 17:07:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6946C433CC;
        Mon, 13 Nov 2023 01:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699837664;
        bh=UhAD3REvQmN6OP/l2BKhCL7Kmd6UirEftGJf0TofIdk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y6uMoOfYrKHbDT9xNVOIrXAwjAY43Ti2zC6vtPyKcRWafuAZjfKl6WmszSJQYykgw
         2e0Yzh5UwKRsaPVpDNNdaMWZyYD2zNAb2kQycdaM6oNPdpuu/GHIoM3ZDJVWneYJ6p
         jZjB1fFrmEFRN2OTgxnpZ9jb39mUe2a69KzqXquh4iXUBEIUDAjvZMsJVgPabVhmjH
         PqpjoutGlz4Xi9No7OQtLnlD5h0F0SKVX3XyF/S3pPXA7jdIEF7xXRm+sI89cinVJG
         fTXhBwwvfs4kZwxhkfl5XUpCSW63h91O82PyDqEVqzYID1bCs6/wLY/Rk1YOW+OLcf
         rSD4k41qZCW0A==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH 4/4] riscv: dts: sophgo: add reset phandle to all uart nodes
Date:   Mon, 13 Nov 2023 08:55:03 +0800
Message-Id: <20231113005503.2423-5-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231113005503.2423-1-jszhang@kernel.org>
References: <20231113005503.2423-1-jszhang@kernel.org>
MIME-Version: 1.0
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

Although, the resets are deasserted by default. Add them for
completeness.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
index 4032419486be..e04df04a91c0 100644
--- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/reset/sophgo,cv1800b-reset.h>
 
 / {
 	compatible = "sophgo,cv1800b";
@@ -65,6 +66,7 @@ uart0: serial@4140000 {
 			reg = <0x04140000 0x100>;
 			interrupts = <44 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&osc>;
+			resets = <&rst RST_UART0>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			status = "disabled";
@@ -75,6 +77,7 @@ uart1: serial@4150000 {
 			reg = <0x04150000 0x100>;
 			interrupts = <45 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&osc>;
+			resets = <&rst RST_UART1>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			status = "disabled";
@@ -85,6 +88,7 @@ uart2: serial@4160000 {
 			reg = <0x04160000 0x100>;
 			interrupts = <46 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&osc>;
+			resets = <&rst RST_UART2>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			status = "disabled";
@@ -95,6 +99,7 @@ uart3: serial@4170000 {
 			reg = <0x04170000 0x100>;
 			interrupts = <47 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&osc>;
+			resets = <&rst RST_UART3>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			status = "disabled";
@@ -105,6 +110,7 @@ uart4: serial@41c0000 {
 			reg = <0x041c0000 0x100>;
 			interrupts = <48 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&osc>;
+			resets = <&rst RST_UART4>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			status = "disabled";
-- 
2.42.0

