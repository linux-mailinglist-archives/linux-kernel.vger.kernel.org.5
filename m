Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252B87E93EA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 02:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjKMBJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 20:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbjKMBJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 20:09:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0691BC0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 17:09:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71F6C433CB;
        Mon, 13 Nov 2023 01:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699837765;
        bh=eM8d9IMh9iQd7b2YIyNC18c8crry0l3aFLLjrqGpruk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O6rb0rquzaUvuzBIP52vidXntbBi5DW5ejXnhTOUBEwOPsf8ZN5BMhV8fR34Lx5ip
         5JkRoKxH41DzNnuB04HSXBupca8B9hDi3cuIWjczJ6JO9eqnJQjjOKE5KAzpzEwBuE
         qdHLIdJgAiRr+fpy1YJIYi9/snJYD66jf17nwDh0zfWscpB/IrbuKSo0AqTX7GqCZT
         mfPbCUYYhl+XKOfLGNeWMs4YC3IJh+ZPH27RTLGyIJ+H5rB9fan8N90hM5IGyKWU45
         0DiSQnTobBsQZMU/NTDqwFFaG2iLFJdsVVA/szOWrjgG6Jx3PKHUTUWDkV7EpLP0Tu
         epwC5wBII2xww==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH 1/2] riscv: dts: cv1800b: add pinctrl node for cv1800b
Date:   Mon, 13 Nov 2023 08:57:01 +0800
Message-Id: <20231113005702.2467-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231113005702.2467-1-jszhang@kernel.org>
References: <20231113005702.2467-1-jszhang@kernel.org>
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

Add the reset device tree node to cv1800b SoC reusing the
pinctrl-single driver.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/boot/dts/sophgo/cv-pinctrl.h | 19 +++++++++++++++++++
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 10 ++++++++++
 2 files changed, 29 insertions(+)
 create mode 100644 arch/riscv/boot/dts/sophgo/cv-pinctrl.h

diff --git a/arch/riscv/boot/dts/sophgo/cv-pinctrl.h b/arch/riscv/boot/dts/sophgo/cv-pinctrl.h
new file mode 100644
index 000000000000..ed78b6fb3142
--- /dev/null
+++ b/arch/riscv/boot/dts/sophgo/cv-pinctrl.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides constants for pinctrl bindings for Sophgo CV* SoC.
+ *
+ * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
+ */
+#ifndef _DTS_RISCV_SOPHGO_CV_PINCTRL_H
+#define _DTS_RISCV_SOPHGO_CV_PINCTRL_H
+
+#define MUX_M0		0
+#define MUX_M1		1
+#define MUX_M2		2
+#define MUX_M3		3
+#define MUX_M4		4
+#define MUX_M5		5
+#define MUX_M6		6
+#define MUX_M7		7
+
+#endif
diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
index e04df04a91c0..7a44d8e8672b 100644
--- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
@@ -6,6 +6,8 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/reset/sophgo,cv1800b-reset.h>
 
+#include "cv-pinctrl.h"
+
 / {
 	compatible = "sophgo,cv1800b";
 	#address-cells = <1>;
@@ -55,6 +57,14 @@ soc {
 		dma-noncoherent;
 		ranges;
 
+		pinctrl0: pinctrl@3001000 {
+			compatible = "pinctrl-single";
+			reg = <0x3001000 0x130>;
+			#pinctrl-cells = <1>;
+			pinctrl-single,register-width = <32>;
+			pinctrl-single,function-mask = <0x00000007>;
+		};
+
 		rst: reset-controller@3003000 {
 			compatible = "sophgo,cv1800b-reset";
 			reg = <0x03003000 0x1000>;
-- 
2.42.0

