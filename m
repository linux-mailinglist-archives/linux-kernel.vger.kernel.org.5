Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEE97E93E5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 02:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbjKMBHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 20:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbjKMBHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 20:07:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0031E1FFB
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 17:07:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41267C433CB;
        Mon, 13 Nov 2023 01:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699837661;
        bh=FU5cMxpykFA89J/z1Xx5vbxIOEU9bDayGjmJTED/4UY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uQezJXBfixXFEnDr2uPowPMWRFtaZ5r1q34O5kMOfhXgqt6xRQJok/YdVKhr753Sc
         U3brf0s5laXn8qH+WlE5rwINpOTqG7YY5Gf+KvG7ZuE5RAyC4QMGnW7qPhkbtsI73i
         LOgFM2tUGynRSL8KRffQbgT3N+4ali7B0V4blEFMYQcYw6R2gfBJbjiQcU+4vHywGL
         rSuLw91jQFndlfabvrHICBhGjhAOdvNpgyWQC1JDvxgIBBNYQI/6GODycyIxNxpJWx
         hRWvuIIn2U2/HUSuhFuaw5nsb+TkehY43Oq1390yw7oCoKg0AiXMDqcPh15OhD3Sg/
         6E0laeQm1YkTw==
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
Subject: [PATCH 3/4] riscv: dts: sophgo: add reset dt node for cv1800b
Date:   Mon, 13 Nov 2023 08:55:02 +0800
Message-Id: <20231113005503.2423-4-jszhang@kernel.org>
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

Add the reset device tree node to cv1800b SoC.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
index df40e87ee063..4032419486be 100644
--- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
@@ -54,6 +54,12 @@ soc {
 		dma-noncoherent;
 		ranges;
 
+		rst: reset-controller@3003000 {
+			compatible = "sophgo,cv1800b-reset";
+			reg = <0x03003000 0x1000>;
+			#reset-cells = <1>;
+		};
+
 		uart0: serial@4140000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x04140000 0x100>;
-- 
2.42.0

