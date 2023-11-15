Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D61E7EC962
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbjKORIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjKORIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:08:42 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793DE18E;
        Wed, 15 Nov 2023 09:08:38 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507a0907896so9851831e87.2;
        Wed, 15 Nov 2023 09:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700068117; x=1700672917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrrnyZWXKRYwxEi6KzPQsaUn7ssz3ZkVcCNWua0g1gk=;
        b=ICccXjMGfVDPQIcwGj2A9/AhcC2P8D3mMC6bf9AZM0hrS8wgeXDBCpqZcjf9Wvts4Q
         6HYO+mOmoxax36BBhJ8DHshTYZDJLx5TdNklTBFblheJs+umPfsVY5RSTQ3SHL0ZsbYI
         fWFW4w5sqrc/XSPeKV7jIouC7zdp6R+NLyqXczON/RAufeI39fafV3UttJYftwgvydQP
         +7XXozJTU6baUDzC9QYL0WxaUJx79W80CjmJfCAi2v6UeRiGo/6ziglwNdltzoKGRaF/
         J4AGDYQQv5ajkuuXwQqkiyvx0s4wPuG2pqSTurAGgVIzFdBwCUGUiFU0VIW8HlQXkRwr
         XE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700068117; x=1700672917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qrrnyZWXKRYwxEi6KzPQsaUn7ssz3ZkVcCNWua0g1gk=;
        b=kvWuygiIPIPXD+bnyVkEs561Tmnw4wUBkcdVd6Wvz2tIM9TL4PKraYnVm/SKQ0juNV
         ZxhDSs4ozgontaNunrlTYQpaAVmD55kqQBnEI2JyY0d383lP8vzlmd3C1s7HPc9197C1
         LUQc6uIaYr4PLhlnUSw9TgZ8a0Vb1fFcEYiLo4iwZ6+pYbttmnpQbQsN+R1Rv/LQuTN3
         4m1HzqnP/rbqdJrOfx/N6GWbY/q/KOxD5+YY7OEtMtoHJX536PgSxpjJp9Hj4Ms/kHNP
         hMzZw3e0ECt4epmvCE4oPDFZ2db0j0egLr5GNtfZ3fzPgPWD7F4MrqptM58IU90m/8KE
         FN5w==
X-Gm-Message-State: AOJu0Yz1iGHpeFepfMOc6xaF3hHNqfXGUxsQPbBYoKwJfissHVj2sRk7
        15s26oba9RtsQLR68A0189SRZ5+klUg=
X-Google-Smtp-Source: AGHT+IHjYmYAyWSklZ6ETDi2sPgxaQ6mYTB3sSCXAji4FRfCH+gnQeBjUJaOorAg8+7gl6sydUVAhg==
X-Received: by 2002:a05:6512:6d5:b0:507:b19e:90cc with SMTP id u21-20020a05651206d500b00507b19e90ccmr11643551lff.40.1700068116383;
        Wed, 15 Nov 2023 09:08:36 -0800 (PST)
Received: from ALPER-PC.. ([178.233.24.52])
        by smtp.gmail.com with ESMTPSA id o1-20020adfeac1000000b0032dab20e773sm11077833wrn.69.2023.11.15.09.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 09:08:35 -0800 (PST)
From:   Alper Nebi Yasak <alpernebiyasak@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>, linux-clk@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: [PATCH v2 2/2] arm64: dts: mediatek: mt8173: Fix timer 13 MHz clock description
Date:   Wed, 15 Nov 2023 20:06:25 +0300
Message-ID: <20231115170825.908640-2-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115170825.908640-1-alpernebiyasak@gmail.com>
References: <20231115170825.908640-1-alpernebiyasak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A previous patch fixes an issue with the mt8173-infracfg clock driver
when working as a module, but has the side effect of skipping set up of
CLK_INFRA_CLK_13M in that case. This clock is used by the timer device.

Similar to the MT8183, MT8192, MT8195 and MT8186 cases [1], change the
input clock of the timer block a fixed factor divide-by-2 clock that
takes the 26 MHz oscillator as its input.

Also remove the RTC clock from the timer node while we're here. According
to commit 59311b19d7f63 ("clocksource/drivers/timer-mediatek: Add system
timer bindings") it is no longer used.

[1] https://lore.kernel.org/all/20221201084229.3464449-1-wenst@chromium.org/

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---
Tested on a MT8173 Chromebook. But I'm not sure I understand all of
this, so review with a pinch of salt.

Do we need to remove CLK_INFRA_CLK_13M from mt8173-infracfg after this?

Changes in v2:
- Add this patch

 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index c47d7d900f28..9062ca124d69 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -244,6 +244,15 @@ psci {
 		cpu_on	 = <0x84000003>;
 	};
 
+	clk13m: fixed-factor-clock-13m {
+		compatible = "fixed-factor-clock";
+		#clock-cells = <0>;
+		clocks = <&clk26m>;
+		clock-div = <2>;
+		clock-mult = <1>;
+		clock-output-names = "clk13m";
+	};
+
 	clk26m: oscillator0 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -530,8 +539,7 @@ timer: timer@10008000 {
 				     "mediatek,mt6577-timer";
 			reg = <0 0x10008000 0 0x1000>;
 			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_LOW>;
-			clocks = <&infracfg CLK_INFRA_CLK_13M>,
-				 <&topckgen CLK_TOP_RTC_SEL>;
+			clocks = <&clk13m>;
 		};
 
 		pwrap: pwrap@1000d000 {
-- 
2.42.0

