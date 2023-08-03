Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7CC76E3C9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbjHCI60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234943AbjHCI6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:58:04 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DFC30D1
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 01:57:48 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3a5ad44dc5aso545627b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 01:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1691053067; x=1691657867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8jNn+NP9j7pIA4Gvr3RjVfWCo1xNEk9xbLxp+U9DEU=;
        b=dUCjuE/YmR0/8JPJZVzOLMSntUMrvBHBGDA65WMxmJlES6nUM2VmooTuiNK1OE1tzU
         OGO7KiY7VKkwRh1umpSTkMAtVnIx+K2N4ppj7+D3/SiDMMZnvXnwMzMq+shLT9uFC+ye
         5X27QK9DK2d49JR1JJUZFRL4LKEupHJrs3tD9Ea8tvc1cuysV9juAhWG/b5dcz75o7t2
         +aJ7K/AscsGiLN9vgISi/Ow02ITDPLV/njd6G8MUDlJsoPDl8Yx/ckP07QKMYG11AnHk
         MtqjIJbDVWa06b4Z4DDW+xgCuHWdjnGzIYq5VyfTGu6UMZcBSJnOqbCPK8XaFElkD21W
         QVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691053067; x=1691657867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8jNn+NP9j7pIA4Gvr3RjVfWCo1xNEk9xbLxp+U9DEU=;
        b=eF5ZJJiCa9W+ZgDOK6Cfi7GZx5OUKAw5xIt6FjmqdP54fD25K8V6c2jYXwpR33e99j
         SiSE8D+uj3/Kfmp7Z4FJS/Vowgeo6FrP4iaEukkTWVcDIR/RtOoL6KgEAfcY9Qds6ow/
         D/FZ97u616AFMJt3n+X0PEgk0wgYmhY9h31f0mHe5DndCeRK8rnoE/7WW9BQWTqjOvlK
         o222SP66N6IwEGmZ7sfhUaqIpQ76QpDNmfKZszUp3R0PA/DoR3ExGaI6ji/eJRmIfpsK
         Wt1qaKDZBhx/Mzf4YCE632uE9OttLXvl2vQRLWy3Bq6pZwgO7L9tefMcI42VAWyiDckZ
         AkpQ==
X-Gm-Message-State: ABy/qLYGefQdVqZzt67VXph4kx5bIbCowPj2FLi9WH12Mg0dUHJEdAHh
        It2qqj+7anSPJa+e+QkD0YmB6H52xz71dp9Aq/EJbr2IOdxk6oFJiaIFJWlkUzRH/t1oeCqs81r
        k7grYhan6fSYAif4uIECRxrsshs4TPlJoitgsClGrF8iUpa4eqg0cBHRDrrDS5hZ902azjR1Too
        D2RjBFuhwChbi5
X-Google-Smtp-Source: APBJJlHYkyaQstJnkzI/nrMEdCFBI7JwgG/Clj2L5mYZWErvDAJf7HkkrBz83mlUGVdkJrUB3++vPw==
X-Received: by 2002:a05:6358:5e0a:b0:133:a8e:6feb with SMTP id q10-20020a0563585e0a00b001330a8e6febmr8982344rwn.12.1691053067366;
        Thu, 03 Aug 2023 01:57:47 -0700 (PDT)
Received: from hsinchu15.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id i6-20020a633c46000000b0056334a7b9b2sm12941735pgn.33.2023.08.03.01.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 01:57:47 -0700 (PDT)
From:   Nylon Chen <nylon.chen@sifive.com>
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        geert+renesas@glider.be, pavel@ucw.cz, vincent.chen@sifive.com,
        nylon.chen@sifive.com, emil.renner.berthing@canonical.com,
        aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor@kernel.org, zong.li@sifive.com,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/1] riscv: dts: sifive: unleashed/unmatched: Remove PWM controlled LED's active-low properties
Date:   Thu,  3 Aug 2023 16:57:34 +0800
Message-Id: <20230803085734.340-2-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230803085734.340-1-nylon.chen@sifive.com>
References: <20230803085734.340-1-nylon.chen@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the active-low properties of the PWM-controlled LEDs in
the HiFive Unmatched device tree.

The reference is hifive-unleashed-a00.pdf[0] and hifive-unmatched-schematics-v3.pdf[1].

Link: https://sifive.cdn.prismic.io/sifive/c52a8e32-05ce-4aaf-95c8-7bf8453f8698_hifive-unleashed-a00-schematics-1.pdf [0]
Link: https://sifive.cdn.prismic.io/sifive/6a06d6c0-6e66-49b5-8e9e-e68ce76f4192_hifive-unmatched-schematics-v3.pdf [1]

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
---
 arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts | 4 ----
 arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
index 900a50526d77..7a9f336a391c 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
@@ -50,7 +50,6 @@ led-controller {
 
 		led-d1 {
 			pwms = <&pwm0 0 7812500 PWM_POLARITY_INVERTED>;
-			active-low;
 			color = <LED_COLOR_ID_GREEN>;
 			max-brightness = <255>;
 			label = "d1";
@@ -58,7 +57,6 @@ led-d1 {
 
 		led-d2 {
 			pwms = <&pwm0 1 7812500 PWM_POLARITY_INVERTED>;
-			active-low;
 			color = <LED_COLOR_ID_GREEN>;
 			max-brightness = <255>;
 			label = "d2";
@@ -66,7 +64,6 @@ led-d2 {
 
 		led-d3 {
 			pwms = <&pwm0 2 7812500 PWM_POLARITY_INVERTED>;
-			active-low;
 			color = <LED_COLOR_ID_GREEN>;
 			max-brightness = <255>;
 			label = "d3";
@@ -74,7 +71,6 @@ led-d3 {
 
 		led-d4 {
 			pwms = <&pwm0 3 7812500 PWM_POLARITY_INVERTED>;
-			active-low;
 			color = <LED_COLOR_ID_GREEN>;
 			max-brightness = <255>;
 			label = "d4";
diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
index 07387f9c135c..11f08a545ee6 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
@@ -52,7 +52,6 @@ led-controller-1 {
 
 		led-d12 {
 			pwms = <&pwm0 0 7812500 PWM_POLARITY_INVERTED>;
-			active-low;
 			color = <LED_COLOR_ID_GREEN>;
 			max-brightness = <255>;
 			label = "d12";
@@ -69,19 +68,16 @@ multi-led {
 
 			led-red {
 				pwms = <&pwm0 2 7812500 PWM_POLARITY_INVERTED>;
-				active-low;
 				color = <LED_COLOR_ID_RED>;
 			};
 
 			led-green {
 				pwms = <&pwm0 1 7812500 PWM_POLARITY_INVERTED>;
-				active-low;
 				color = <LED_COLOR_ID_GREEN>;
 			};
 
 			led-blue {
 				pwms = <&pwm0 3 7812500 PWM_POLARITY_INVERTED>;
-				active-low;
 				color = <LED_COLOR_ID_BLUE>;
 			};
 		};
-- 
2.40.1

