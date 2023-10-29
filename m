Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1A47DAAC7
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 05:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjJ2E1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 00:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjJ2E1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 00:27:43 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B30C10B;
        Sat, 28 Oct 2023 21:27:38 -0700 (PDT)
Received: from localhost (unknown [188.24.143.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B04776607388;
        Sun, 29 Oct 2023 04:27:36 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698553656;
        bh=ws/tHftC6ooYXFFPrRkdjo583U1IPv/5VDVbOl/IleQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hO7JKhCfgez4T2EdD7WdvDzdPCr/74lUNLBlZiIJrZFAB1wawXL4bQeTCrsiL5oK2
         Ef/Y6mxqH+0jfzTktFf4NAqixF5R8VcduHXBNa8HanlJ9Ee+qTcgwm0K7AhyHFFk50
         xq2HZox5esJDX1w7WAVPy5G4wHEaeqO7RREU38MBxdSct1YdbILqymZ3Ckdg9ybW8e
         samRlBIopNGtUSJVE9F3pKDQ8BtRBwWKUUxN6dCOH45PlHOcB2wNbSBmoIRuixe4PD
         IKf2ch/qYB7zxV+dxuUfMYSyzOHObaGDiiCibF5A5UcNEVC7Gsr38czGoBvd9lfTRl
         QBaTfTewEIMOA==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Samin Guo <samin.guo@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: [PATCH v2 06/12] riscv: dts: starfive: jh7100: Add dma-noncoherent property
Date:   Sun, 29 Oct 2023 06:27:06 +0200
Message-ID: <20231029042712.520010-7-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029042712.520010-1-cristian.ciocaltea@collabora.com>
References: <20231029042712.520010-1-cristian.ciocaltea@collabora.com>
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

The RISC-V architecture is by default coherent, since it selects
ARCH_DMA_DEFAULT_COHERENT, but the StarFive JH7100 is not, hence provide
the dma-noncoherent property to the soc DT node.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 arch/riscv/boot/dts/starfive/jh7100.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7100.dtsi b/arch/riscv/boot/dts/starfive/jh7100.dtsi
index e68cafe7545f..06bb157ce111 100644
--- a/arch/riscv/boot/dts/starfive/jh7100.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7100.dtsi
@@ -144,6 +144,7 @@ soc {
 		interrupt-parent = <&plic>;
 		#address-cells = <2>;
 		#size-cells = <2>;
+		dma-noncoherent;
 		ranges;
 
 		clint: clint@2000000 {
-- 
2.42.0

