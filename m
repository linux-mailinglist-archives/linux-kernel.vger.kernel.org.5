Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866D27E93EC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 02:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbjKMBJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 20:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbjKMBJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 20:09:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DC31BC0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 17:09:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E644C433C9;
        Mon, 13 Nov 2023 01:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699837767;
        bh=L5ZkrNb3URDoBLVtQbTpXvk5/4TaeCMTB1Cqnnepk28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZyYsLd4xs9jlXvllEtYeTitkoWtKWg8X2W5zxDCxDHCUVMH4qKx+UipUETexTXk2z
         TayIBz5QsWaigjp+EhQy+HnXdoPDE3iw2NbOp3lH72lFdyBrxQsTaWuDQgbg3g35f3
         PBD5oHkiWz7PFkI40HvDDQUD/HMzHklTeLAQD+MaCHkGfYCw3R+UWJtQZeJyr9rOZ4
         6mGSl+aYJdkCGnrP2fEiRPeFmjbIg9BPvsQBxl4CHlIJo86mwST/UqNu9952ffWi3y
         B/8rfCJvcEFbclweKrcW4QfKO33pQx7kUQbntnsnJS3cgtg2t1BoUyERraYHRoDjmz
         2wT/8FZdDQmjA==
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
Subject: [PATCH 2/2] riscv: dts: sophgo: set pinctrl for uart0
Date:   Mon, 13 Nov 2023 08:57:02 +0800
Message-Id: <20231113005702.2467-3-jszhang@kernel.org>
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

Although the mux function is uart by default, add it for
completeness.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts b/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
index 3af9e34b3bc7..cc10688908bc 100644
--- a/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
+++ b/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
@@ -33,6 +33,17 @@ &osc {
 	clock-frequency = <25000000>;
 };
 
+&pinctrl0 {
+	uart0_pins: uart0-pins {
+		pinctrl-single,pins = <
+			0x24 MUX_M0 /* UART0_TX */
+			0x28 MUX_M0 /* UART0_RX */
+		>;
+	};
+};
+
 &uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins>;
 	status = "okay";
 };
-- 
2.42.0

