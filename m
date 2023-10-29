Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4197DAAD9
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 05:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjJ2E2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 00:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjJ2E2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 00:28:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AA31731;
        Sat, 28 Oct 2023 21:27:57 -0700 (PDT)
Received: from localhost (unknown [188.24.143.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6FE22660738D;
        Sun, 29 Oct 2023 04:27:56 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698553676;
        bh=IawNSWO2nYKHHHriF9PdoR+WZ4Zc1Xf7Yl52QH6o0QU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X8xz1amOAUhfC1grOMQOkX6TCY90OvTcGTlMMTuyLOxvgt+jCk+tlII2+qv6mUbzp
         LjSmLIKhWkpXCnWBw1q08+h8l97XkKbjXckbJTOz8mgbVsRSnXlvxVRKhAhtS03Umc
         4SLSJppYNagRnNboB8csnRcflTemiFfXMMRfLqPR8AdoUpL62eqp7y7o59elnkNZwc
         dhnnjp2a+C26/ld9tNKWr//lm0ZvAemc2RXj4BYDUgRd6CjBxlOlvuj7pO7o+L9XnH
         4diRZg6XeYYrXsy9Hp/LySve42JZFWWaFvtfevlo/im6ikISE8WvoSVm0KSbBRkiMw
         j5f2rWmemIeiQ==
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
Subject: [PATCH v2 12/12] [UNTESTED] riscv: dts: starfive: beaglev-starlight: Enable gmac
Date:   Sun, 29 Oct 2023 06:27:12 +0200
Message-ID: <20231029042712.520010-13-cristian.ciocaltea@collabora.com>
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

The BeagleV Starlight SBC uses a Microchip KSZ9031RNXCA PHY supporting
RGMII-ID.

TODO: Verify if manual adjustment of the RX internal delay is needed. If
yes, add the mdio & phy sub-nodes.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts b/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts
index 7cda3a89020a..d3f4c99d98da 100644
--- a/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts
+++ b/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts
@@ -11,3 +11,8 @@ / {
 	model = "BeagleV Starlight Beta";
 	compatible = "beagle,beaglev-starlight-jh7100-r0", "starfive,jh7100";
 };
+
+&gmac {
+	phy-mode = "rgmii-id";
+	status = "okay";
+};
-- 
2.42.0

