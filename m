Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E977DAE88
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 22:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjJ2V1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 17:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjJ2V1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 17:27:49 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792BD97;
        Sun, 29 Oct 2023 14:27:44 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 167795C00E7;
        Sun, 29 Oct 2023 17:27:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 29 Oct 2023 17:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1698614862; x=1698701262; bh=MiMFrY0ycv
        /v9l0tkVb+XyEailSufLSk/OdS3dctGAk=; b=c3iRw+Pmsqwf7u+J/yJEiWwead
        cQlCIuPoU35W/2lyt8MOcnGbsZWW7144iApXMlWGzMy5JhC0DLcicR4nPl2QPfUo
        TPWY7W+zAoDNCTG2BZXJRpOzN0y4l6OJ4pwi2683ujmyQDX+0BJwbvWIIVT2gVPp
        jc/ZWUU84X1kDWbh48fYVP7Jz9R3WmF0gv1kBJvsLt+elUJUVm0ce3wSdvZlV8OA
        cmxQtIztCISHCRzu42ZBNzSv4dsEJGhKWR3w/lKrYToThcAShBnUJdpoZftdq93z
        blrAoyIHzeuzWfLVyltQqWjRRazLsR5bBBES9rtKeUYKysL4ZjbJTfAV/JYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1698614862; x=1698701262; bh=MiMFrY0ycv/v9
        l0tkVb+XyEailSufLSk/OdS3dctGAk=; b=b0xoGx7LEl9exW66x82K8ONJK/XrK
        vATlpAvHRg+sG598kRHa1ThK792mWrchqg8I+csuI+DomRCSC21+5/7xZZXZ55Dh
        34t6u19IiEzqzc6pktDmc4wSLlm3+g854hCDFEaZZT2facXH8ZHHK39bp4f0/ZNP
        1u2n3y3mwgSRsYQFeih7Gy/eCyhb80NkLnB5NRrWb4jFQsKO1cL5X1YsFHcAfqya
        X/hu5lYw3moHBSAt5cDajVbfnDTi0CmQzhUfbRUKLf09sN6I4Txoeyr9vKttGXbg
        c1NwKNlAuZg7qx7wtqp99ZuhwbNOhpdNKRz/0jEhJThymEFbm7HSFaFgQ==
X-ME-Sender: <xms:TM4-ZRS9kAzQTuQFDk0FfjngHteVb8qjxh8e792340ZVKgDcSjNkUw>
    <xme:TM4-ZayV5lHghBSOtyOpivZIAVEDu7poySdxhJ-qwoz5oYcIaSSBo9hn7oE0ArGS9
    nF_LIKGNN1h1XGGRw>
X-ME-Received: <xmr:TM4-ZW2aliP3tUGffKD84_idaH2OmyqUvazET3SXQyGbsQEEIiN-0jIhUA17BJHF8tq7oLfIx_Zlb15d7sQz0CIg75eKIcpC4XsbrwguqprzK0rKOfSY8Kc-6-ahUt_EG3RNuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleekgddugeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeevlefhjeeuleeltedvjedvfeefteegleehueejffehgffffeekhefh
    hfekkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:TM4-ZZAaPZ2nXvvUk2R0WLf0JM7EfyP30BeIBF33qq7Lfa5_Wu8WzA>
    <xmx:TM4-Zahz5XGEfezpXiD70llcrva3fYXmN3Fd9gjhczAiOAqn-EBRxg>
    <xmx:TM4-ZdrKYXT-FayaYVLMOaytY-1LjLbK-DLzR5waqGTL__jZzGltdA>
    <xmx:Ts4-ZVTxLQM37ajUJ4r4AeLOoUHGC-VPVAun1yK3HbzI4GJJnT4SOw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Oct 2023 17:27:39 -0400 (EDT)
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
Subject: [PATCH v8 0/5] leds: Allwinner A100 LED controller support
Date:   Sun, 29 Oct 2023 16:26:54 -0500
Message-ID: <20231029212738.7871-1-samuel@sholland.org>
X-Mailer: git-send-email 2.41.0
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

This series adds bindings and a driver for the RGB LED controller found
in some Allwinner SoCs, starting with A100. The hardware in the R329 and
D1 SoCs appears to be identical.

This series was tested on the Nezha board (one onboard LED) and the
Dongshan Nezha STU board (with an external strip of 16/32/48 LEDs, also
with gaps in the LED addresses).

Changes in v8:
 - Remove redundant "Bindings" from the binding document title
 - Make the DMA channel optional; the driver now works without DMA
 - Fix spelling in the Kconfig description
 - Fix the file header comment style
 - Wrap to 100 columns instead of 80
 - Use GENMASK for register bit fields
 - Use FIELD_PREP for setting all multiple-bit register fields
 - Add and use the LEDC_CHANNELS_PER_LED macro
 - Make length and offset variables unsigned to avoid mixed signedness
 - Add __counted_by for sun50i_a100_ledc::leds
 - Move the new/existing xfer logic out of sun50i_a100_ledc_pio_xfer()
 - Get the FIFO usage from INT_STS instead of assuming it is half full
 - Make the DMA channel optional; always use PIO if it is unavailable
 - Set up DMA before triggering the LEDC transfer to avoid underrun
 - Correctly enable/disable the DRQ for each transfer
 - Use more descriptive names for variables containing register values
 - Add blank lines and comments to improve readability
 - Add a comment explaining the write to the status register
 - Remove unnecessary debugging prints
 - Use the more-idiomatic post-increment operator in for loops
 - Allow gaps in child node 'reg' values (separate max_addr/num_leds)
 - Use device-managed allocation for the DMA buffer
 - Unregister LEDs before shutting down the controller to correctly
   respect LED_RETAIN_AT_SHUTDOWN (or lack thereof)
 - Use the .remove_new platform driver hook
 - Collected tags, except Tested-by for the driver due to large changes

Changes in v7:
 - Use DEFINE_SIMPLE_DEV_PM_OPS

Changes in v6:
 - Drop the A100 DMA controller DT node patch, which was merged via a
   different series

Changes in v5:
 - A100 contains the original implementation, so use that as the base
   compatible string, and rename the binding to match
 - Add "unevaluatedProperties: false" to the child multi-led binding
 - Rename the driver R329 -> A100, since that is the actual original
   implementation

Changes in v4:
 - Use "default" instead of "maxItems" for timing properties
 - Depend on LEDS_CLASS_MULTICOLOR

Changes in v3:
 - Removed quotes from enumeration values
 - Added vendor prefix to timing/format properties
 - Renamed "format" property to "pixel-format" for clarity
 - Dropped "vled-supply" as it is unrelated to the controller hardware
 - Added vendor prefix to timing/format properties
 - Renamed "format" property to "pixel-format" for clarity
 - Dropped "vled-supply" as it is unrelated to the controller hardware
 - Changed "writesl" to "iowrite32_rep" so the driver builds on hppa

Changes in v2:
 - Fixed typo leading to duplicate t1h-ns property
 - Removed "items" layer in definition of dmas/dma-names
 - Replaced uint32 type reference with maxItems in timing properties
 - Renamed from sunxi-ledc to sun50i-r329-ledc
 - Added missing "static" to functions/globals as reported by 0day bot

Samuel Holland (5):
  dt-bindings: leds: Add Allwinner A100 LED controller
  leds: sun50i-a100: New driver for the A100 LED controller
  arm64: dts: allwinner: a100: Add LED controller node
  riscv: dts: allwinner: d1: Add LED controller node
  riscv: dts: allwinner: d1: Add RGB LEDs to boards

 .../leds/allwinner,sun50i-a100-ledc.yaml      | 137 +++++
 .../arm64/boot/dts/allwinner/sun50i-a100.dtsi |  14 +
 .../allwinner/sun20i-d1-lichee-rv-dock.dts    |  12 +
 .../boot/dts/allwinner/sun20i-d1-nezha.dts    |  13 +
 arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi  |   6 +
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    |  15 +
 drivers/leds/Kconfig                          |   9 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-sun50i-a100.c               | 580 ++++++++++++++++++
 9 files changed, 787 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/allwinner,sun50i-a100-ledc.yaml
 create mode 100644 drivers/leds/leds-sun50i-a100.c

-- 
2.41.0

