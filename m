Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5726B7DAE97
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 22:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjJ2V1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 17:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjJ2V1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 17:27:50 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75109C1;
        Sun, 29 Oct 2023 14:27:48 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id E055F5C0132;
        Sun, 29 Oct 2023 17:27:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 29 Oct 2023 17:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1698614867; x=
        1698701267; bh=iEJQRW8XFToPuwgph8rKTRMVOhjzZOWs5XTsNlQdUKI=; b=y
        ZwG9v2PoNbsKRh7ZW+9x4bEOOutmyNp4MzYot7123IKjKsPWq+yyB+NIIQA3E4mT
        8tb+G+KrTzwEnmzi375qqbwfKQ2HbFkZL4fg6DNu0Sw0fx6oV+O91LO07QED1U94
        8qHKBJE4ujEIytwIG/vpU7Oeqz2jtwqfSNh0bcf+TLYhvRwLOIbaqlsTZaaDEVHN
        eik/+xpPSNmj2/ZvKUjX4eBBzA0zwo/YA1gDF0iQpwPfcXdDNFt3KeFJsBK731BD
        umaohYZrPo+/INYurd0RbYn+hjWNpNGYS549pl6aObUT27FspDTv3L8R13Kd/M0P
        bCr2E5ght93/LdLHs3bHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698614867; x=
        1698701267; bh=iEJQRW8XFToPuwgph8rKTRMVOhjzZOWs5XTsNlQdUKI=; b=L
        dTfUGdQhJDft9NEWrDELH1Vu9ex0KCsF9nYXX9EdjiO1BcPTcRDaMwMfv78cFwGX
        ZRAKUkf71ZM2B8uZT7rmq+8Q0qXkzzORP7MMhkli5fBf8D/BBc++TIn9ivZO2qt2
        +bDX3e8dGV3OmnB2FIG5Vu0T4yF9XGDOLKqLRxaDIzBfHqXcl0AjPCnPv0eEMPXK
        nCkOiA4c/vH+l+a1SPa96XBPTbWkLlf62aTHXsV6z/qx6Ifh5Nxu3+cMNtfCb90E
        ge42fruG/LA1NBiLdXz+S2WpVLc70Mdum825/MGxB4m8t3jPFraN2tM3dSXt/kP6
        0mE5aV+NckYOO2UzSS9kg==
X-ME-Sender: <xms:U84-ZQxoUDBCivZPRjESbv7FLDcVOP6a2OjC3rDIbssneyjJTCYhWw>
    <xme:U84-ZUQxvWo-pQJJRyNJR7VrTp8pA8XQzqZ8Eoqjdnq25S_c9Cft6u5Cug83uHTIA
    ZQgysTctgVhyjCwYA>
X-ME-Received: <xmr:U84-ZSVq4cas52v1Z2dUxOSogGSwP3HXB5S_fEMPMwWWKAS7tYFc-jsV3f2_oOAeVdJH47Eo73M0OcRHE7LpTuadiQwxC8l0lY-seOLE8Q6TNiEqnVPVzZ5152h1ywfhFZVcfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleekgddugeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:U84-ZejbVmgK_6-f0CK1mc6q-y0LVEIiE_sK3FKuyuYht82_s5eQ-A>
    <xmx:U84-ZSDWsZxWvWKyzpJ4QhaRgbvXn8U7HN93QKUHnYTPP0SEO4n2fw>
    <xmx:U84-ZfKHfySLQl3Be9Fk65ORamu2ALKBRJeNsZTSySNxs-0UerfI-A>
    <xmx:U84-ZUx4tvf-bNJ3tfsG1xm7dPv_Ksg3lAkb7LE50auBY8WShxiMjQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Oct 2023 17:27:46 -0400 (EDT)
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
Subject: [PATCH v8 3/5] arm64: dts: allwinner: a100: Add LED controller node
Date:   Sun, 29 Oct 2023 16:26:57 -0500
Message-ID: <20231029212738.7871-4-samuel@sholland.org>
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

Allwinner A100 contains an LED controller. Add it to the devicetree.

Acked-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v5)

Changes in v5:
 - New patch for v5

 arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
index a3dccf193765..037750d383f8 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
@@ -273,6 +273,20 @@ i2c3: i2c@5002c00 {
 			#size-cells = <0>;
 		};
 
+		ledc: led-controller@5018000 {
+			compatible = "allwinner,sun50i-a100-ledc";
+			reg = <0x5018000 0x400>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
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
 		ths: thermal-sensor@5070400 {
 			compatible = "allwinner,sun50i-a100-ths";
 			reg = <0x05070400 0x100>;
-- 
2.41.0

