Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31A97DAE95
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 22:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjJ2V2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 17:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjJ2V1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 17:27:52 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB97C2;
        Sun, 29 Oct 2023 14:27:50 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 8AF385C0195;
        Sun, 29 Oct 2023 17:27:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 29 Oct 2023 17:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1698614869; x=
        1698701269; bh=Uya9a1BC8Na+HTXRovX+d1wlxedeh/xYXLNyXbjnaHM=; b=y
        dWKhjeQxRnwmMJYv55er3v5Qoa0/lM+Co29bHkbHbOo2eqX17zLXz0c6s8ACNPOt
        0qCBF0sacmwhDJLgTOQlQyAk4wrtbv3gmKrTru6PTBS4mSxIEMijMu3XzW9/YF+p
        6SDXSHoliYPKpVn+XMCC3Nqlx8VhzfLLNiQVpO94Uv3x0Okvlyho8JCXvOUqsqKX
        SA0Myc/m2N3rF8FNr4W+LCQs6Hbc/CGHPM+McEdGujp+D6DSJQHIUqiVmUlZDSiM
        LiW5DxwrsERChLz9y0VW41F4J18hCep5XIPoMa5cpHWfYK2JRx3LZIq4ajef5lXm
        jPi/bCTKTgysCXR8KQxSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698614869; x=
        1698701269; bh=Uya9a1BC8Na+HTXRovX+d1wlxedeh/xYXLNyXbjnaHM=; b=J
        Nui7if+5+cA+svFA2HPLjpncsOngAA5fXHBU+hpTjvL1gooPSRfTuV+r0nWWvS+M
        qKpLy1EbVD6cXqJEEw6c6ZC1sA7VaAxlDD1oSqlXF+ghpa+BUiQmprcFrlxqXyAC
        btit2xqCA1tf0cYJYM/Xx6Dw/U7nstM6paoMw5TAB5Ii1w84ksxfFyVGawZN24w7
        Gn7G/aVi7Z07XrXA1OZvARC7xujhwuqqa/NQO5rP76s6xy/yNzUplN0un9rYP5Qm
        epUZShs5zeq1n2o5pWvWvvij5HYlAJ1bkCYtZqyWY2caSGiQ6qM4TYQCxYYnknWZ
        3i4EdgF39xfwsgVLLIWig==
X-ME-Sender: <xms:Vc4-ZapMGmXxfX_Oj8M1gU9JNMG-vj3I6z2cFhAaWuUNDHjTC8Q13Q>
    <xme:Vc4-ZYp8wQ0Bc2Xhwk4JkOsOtMC7aU8_r_0KIxLiAtWuKyiJpoFgPQGn9STfycr08
    OfAmWbX5x9dFEvfGA>
X-ME-Received: <xmr:Vc4-ZfNa3iMtXhrFO8qFyADnpe_H3GjH4JilQA8JJnXo9MZlHhK8FmHWlitpMRLOo95S1zRHfqNiHHxHIdbK8vJmyV7ZLKRXce0XipVM44qZV758nmvLg2RppDKiVi4eKYvj-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleekgddugeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:Vc4-ZZ53SuL4kuePQ3WHEzU-0MC0wuWIeOGRpNwnwNWzuVNIq0rAjA>
    <xmx:Vc4-ZZ6mGMdpMUBWjbhP8Qg9PkG33KO8nWzRRUgU_g1tLOcQByA41w>
    <xmx:Vc4-ZZiBvwkGWzK2t-Xq5a6BL6VhXSrfV3_uDlXF_iau4cSBFWdJ9Q>
    <xmx:Vc4-ZeoDlanQES7efe55ZL3DuJd6ygjMXW3uibm1aZNBQzpUGnov1g>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Oct 2023 17:27:48 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        linux-leds@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        John Watts <contact@jookia.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Trevor Woerner <twoerner@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH v8 4/5] riscv: dts: allwinner: d1: Add LED controller node
Date:   Sun, 29 Oct 2023 16:26:58 -0500
Message-ID: <20231029212738.7871-5-samuel@sholland.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231029212738.7871-1-samuel@sholland.org>
References: <20231029212738.7871-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner D1 contains an LED controller. Add its devicetree node, as
well as the pinmux used by the reference board design.

Acked-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Tested-by: Trevor Woerner <twoerner@gmail.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v5)

Changes in v5:
 - New patch for v5

 arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi      |  6 ++++++
 arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi | 15 +++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi b/arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi
index b18f368e06e0..b0fb0ea377bc 100644
--- a/arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi
@@ -58,6 +58,12 @@ i2c2_pb0_pins: i2c2-pb0-pins {
 		function = "i2c2";
 	};
 
+	/omit-if-no-ref/
+	ledc_pc0_pin: ledc-pc0-pin {
+		pins = "PC0";
+		function = "ledc";
+	};
+
 	/omit-if-no-ref/
 	uart0_pb8_pins: uart0-pb8-pins {
 		pins = "PB8", "PB9";
diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
index 5a9d7f5a75b4..a476b59ba306 100644
--- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
@@ -156,6 +156,21 @@ ccu: clock-controller@2001000 {
 			#reset-cells = <1>;
 		};
 
+		ledc: led-controller@2008000 {
+			compatible = "allwinner,sun20i-d1-ledc",
+				     "allwinner,sun50i-a100-ledc";
+			reg = <0x2008000 0x400>;
+			interrupts = <SOC_PERIPHERAL_IRQ(20) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_LEDC>, <&ccu CLK_LEDC>;
+			clock-names = "bus", "mod";
+			resets = <&ccu RST_BUS_LEDC>;
+			dmas = <&dma 42>;
+			dma-names = "tx";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		gpadc: adc@2009000 {
 			compatible = "allwinner,sun20i-d1-gpadc";
 			reg = <0x2009000 0x400>;
-- 
2.41.0

