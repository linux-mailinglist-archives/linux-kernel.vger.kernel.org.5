Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67A97F188A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 17:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbjKTQW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 11:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjKTQWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 11:22:54 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5003093;
        Mon, 20 Nov 2023 08:22:50 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6ce2b6cb933so2725400a34.0;
        Mon, 20 Nov 2023 08:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700497368; x=1701102168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KX9CLwN26iToqKb73jn+BjvpZIdQqDvo/75oK/Q93bw=;
        b=hUiq19g2vcufwo+VAhH/nWkhRNU/XPFIX8DAsnKXTfw/hKslGxiwRGE2Jh4J0ZxkUj
         RCm5CpzjhBFHwzuoGuEfp9UhuPByDEssTz/lBv+UCbf4OYzc2R2zlf16mDDIHpulDWqh
         WXBUVpgcUOSaRIaGsbLLtbPNJLJfo58f+NIWGU9YWxFcGSQkgT4I2E/OGtmuNjQarmVD
         thdLTLus572TlnVcMkgWKoDW/FkPjeg3qibWNoUzL681l5gf2BSodUU3VmDblIWgBc2p
         8BYbmxzmGrdiurKLJp9dGJQbnn6nA9NNDXmgXflt3RSYhsOyTL4eiR16bxD3IRK3nMxd
         ULGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700497368; x=1701102168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KX9CLwN26iToqKb73jn+BjvpZIdQqDvo/75oK/Q93bw=;
        b=CB+7PM/7j2TdJVjk946AFnmMpy/glaInOQUqzhIcA5oX/2cK4aplf6Bnpk1XS96+eu
         INZc3puqqN1nwG+QPDMZHlMvhgaJfkC3t/kJC3beeqwBuPOL9Q/KEPO7YlUPhvsOS3MP
         +w8bmbEppdd15yTUdNak6KZnVoqqq8cudu7yxyWnskxL61TVF0GBauG6jN+AUpJFAdXY
         sPvqlF4IBUX1rt3YujswJZURXmZCswuEf8n77dE2baNOEvHw/hZak4v6p9pyHSjiXcM+
         NMyI6lrIy/qy1Cc1tzcVeRCJaSjFhhlEpH7pPPCk3wD37Sfk2JTOcPcnVNPJfTz5WB2A
         2EXA==
X-Gm-Message-State: AOJu0Yx23P+nX6hKk22YGIgUOzw8+MwE+NXwKIsLokDiT+BC05IW/vug
        0tdRvDsmQzLGP4JUFi423Xq8KXD1vMk=
X-Google-Smtp-Source: AGHT+IH/2OyWscjqAAksdhRQNOC4OIoyyN9RuP98a7Vj+dPJakNfOV1ajfMkDjXARNt4yZcnpyz/5Q==
X-Received: by 2002:a05:6830:14c2:b0:6d6:53fe:2181 with SMTP id t2-20020a05683014c200b006d653fe2181mr8180371otq.26.1700497367786;
        Mon, 20 Nov 2023 08:22:47 -0800 (PST)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id z13-20020a0cfc0d000000b00677fb605c8csm2549561qvo.55.2023.11.20.08.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 08:22:46 -0800 (PST)
From:   Trevor Woerner <twoerner@gmail.com>
To:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH] arm64: rockchip: dts: rk3308-rock-pi-s add gpio-line-names
Date:   Mon, 20 Nov 2023 11:22:32 -0500
Message-ID: <20231120162232.27653-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.41.0.327.gaa9166bcc0ba
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add names to the pins of the general-purpose expansion header as given in the
Radxa GPIO page[1] following the conventions in the kernel documentation[2] to
make it easier for users to correlate the pins with functions when using
utilities such as gpioinfo.

[1] https://wiki.radxa.com/RockpiS/hardware/gpio
[2] Documentation/devicetree/bindings/gpio/gpio.txt

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 .../boot/dts/rockchip/rk3308-rock-pi-s.dts    | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts b/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts
index e9810d2f0407..f2d7251de298 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts
@@ -250,3 +250,61 @@ &usb20_otg {
 &wdt {
 	status = "okay";
 };
+
+&gpio0 {
+	gpio-line-names =
+	/* GPIO0_A0 - A7 */
+	"", "", "", "", "", "", "", "",
+	/* GPIO0_B0 - B7 */
+	"", "", "", "header1-pin3 [GPIO0_B3]", "header1-pin5 [GPIO0_B4]",
+	"", "", "header1-pin11 [GPIO0_B7]",
+	/* GPIO0_C0 - C7 */
+	"header1-pin13 [GPIO0_C0]", "header1-pin15 [GPIO0_C1]", "", "", "",
+	"", "", "",
+	/* GPIO0_D0 - D8 */
+	"", "", "", "", "", "", "", "";
+};
+
+&gpio1 {
+	gpio-line-names =
+	/* GPIO1_A0 - A7 */
+	"", "", "", "", "", "", "", "",
+	/* GPIO1_B0 - B7 */
+	"", "", "", "", "", "", "", "",
+	/* GPIO1_C0 - C7 */
+	"", "", "", "", "", "", "header1-pin21 [GPIO1_C6]",
+	"header1-pin19 [GPIO1_C7]",
+	/* GPIO1_D0 - D8 */
+	"header1-pin23 [GPIO1_D0]", "header1-pin24 [GPIO1_D1]", "", "", "",
+	"", "", "";
+};
+
+&gpio2 {
+	gpio-line-names =
+	/* GPIO2_A0 - A7 */
+	"header1-pin10 [GPIO2_A0]", "header1-pin8 [GPIO2_A1]", "", "",
+	"header1-pin7 [GPIO2_A4]", "header1-pin12 [GPIO2_A5]",
+	"header2-pin46 [GPIO2_A6]", "header1-pin22 [GPIO1_A7]",
+	/* GPIO2_B0 - B7 */
+	"header2-pin45 [GPIO2_B0]", "header1-pin18 [GPIO2_B1]",
+	"header1-pin16 [GPIO2_B2]", "header2-pin44 [GPIO2_B3]",
+	"header2-pin43 [GPIO2_B4]", "header2-pin28 [GPIO2_B5]",
+	"header2-pin30 [GPIO2_B6]", "header2-pin32 [GPIO2_B7]",
+	/* GPIO2_C0 - C7 */
+	"header2-pin34 [GPIO2_C0]", "", "", "", "", "", "", "",
+	/* GPIO2_D0 - D8 */
+	"", "", "", "", "", "", "", "";
+};
+
+&gpio3 {
+	gpio-line-names =
+	/* GPIO3_A0 - A7 */
+	"", "", "", "", "", "", "", "",
+	/* GPIO3_B0 - B7 */
+	"", "", "header2-pin42 [GPIO3_B2]", "header2-pin41 [GPIO3_B3]",
+	"header2-pin40 [GPIO3_B4]", "header2-pin39 [GPIO3_B5]", "", "",
+	/* GPIO3_C0 - C7 */
+	"", "", "", "", "", "", "", "",
+	/* GPIO3_D0 - D8 */
+	"", "", "", "", "", "", "", "";
+};
-- 
2.41.0.327.gaa9166bcc0ba

