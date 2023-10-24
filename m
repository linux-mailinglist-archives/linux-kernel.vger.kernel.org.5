Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897437D4D8D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 12:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbjJXKTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 06:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbjJXKTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 06:19:16 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862FDBA
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 03:19:14 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68fb85afef4so3565853b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 03:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1698142754; x=1698747554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EJwUL7fMCKImWXLzNFL9tTBWmaxZdYaUnJ/ideRiHA=;
        b=iKK/6/mQNd3esjSDIinyY+NUQTk9iQ+aV1hZ8iTDwD5deRas+XjFSAM86+Y1gF0V0a
         Vc5q3WJJmjy/3j2MDCHXbYIvmiKitV3cgupSn0jRUmBnKTwJ2tdy5nJwMhwZNXi3E4Lt
         SLss2sYuJ5b/LwgoaW1jy6z4QtylKR2Ck2ymdkTNJJVet8EErCucjA9EkWYx9ukgOuxx
         rV8fgGMKOFWX52O7ilupm245YbQCrz0rgVEER5sCxhMp5bPUa+5Zy+cepmR5OgyEFTQL
         rpM2+PBC97xe+sk5FkjL4EbHVatH15dG+fWKDDCd+V1DeU8WUOvp47bNoPamuV4TBXr+
         ssHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698142754; x=1698747554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1EJwUL7fMCKImWXLzNFL9tTBWmaxZdYaUnJ/ideRiHA=;
        b=KWHc0LdX6qZlIQm57OUlZHhRloCfcZ5MdeZIMf+n1oyMzng0FXHydzpZjQi1A7Q5Kf
         X04dmKl/veW8cOhL+ut1xNseXG0ZwV4/je4ARubSFZ/fmjJ3k8Ocak4r3/01kfqEYcH8
         nKQEBAsRYY8peiEpKeEOh9qFqFkqbtJh0F4qkJ4nS7vYAsmY3mgpd7qQvRVQlFYVRY7p
         JQu1N9nEeOA2ON7zNH7tBhIJAHY3jMhzlY9SrLNkbU09dC9RCNlPvPhL1Pt0GX+wfOEC
         Ywu6t6xEQWT2s9BkNqrvh1oidvxvVRvImoG5wF2VTTZB6aGb52sDXIALq+g31XBU9wF2
         RECg==
X-Gm-Message-State: AOJu0YzHfj9skHVRO2Kgj9LpcslpQYwCiMeXtDTrGlhSCiQnu5a6vELN
        gMGbcAPwlqDmKKSwO64LgLD45SVC+TmAZ21tUOraXw==
X-Google-Smtp-Source: AGHT+IGn0n8dz73CI6AtHoQrYIxfI7c9vkLAlzZ9pWxQTrLebZhEJz9sMQ+fmlRVn56oH2AE68HepQ==
X-Received: by 2002:aa7:8bcf:0:b0:68e:36b1:3d7f with SMTP id s15-20020aa78bcf000000b0068e36b13d7fmr9509301pfd.18.1698142753930;
        Tue, 24 Oct 2023 03:19:13 -0700 (PDT)
Received: from hsinchu15.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id u202-20020a6279d3000000b006b3dc56c944sm7708372pfc.133.2023.10.24.03.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 03:19:13 -0700 (PDT)
From:   Nylon Chen <nylon.chen@sifive.com>
To:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, emil.renner.berthing@canonical.com,
        vincent.chen@sifive.com
Cc:     nylon.chen@sifive.com, greentime.hu@sifive.com, zong.li@sifive.com,
        nylon7717@gmail.com
Subject: [v5 1/2] riscv: dts: sifive: unleashed/unmatched: Remove PWM controlled LED's active-low properties
Date:   Tue, 24 Oct 2023 18:19:01 +0800
Message-ID: <20231024101902.6689-2-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231024101902.6689-1-nylon.chen@sifive.com>
References: <20231024101902.6689-1-nylon.chen@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
---
 arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts |  8 ++++----
 arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 12 ++++--------
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
index 900a50526d77..11e7ac1c54bb 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
@@ -49,7 +49,7 @@ led-controller {
 		compatible = "pwm-leds";
 
 		led-d1 {
-			pwms = <&pwm0 0 7812500 PWM_POLARITY_INVERTED>;
+			pwms = <&pwm0 0 7812500 0>;
 			active-low;
 			color = <LED_COLOR_ID_GREEN>;
 			max-brightness = <255>;
@@ -57,7 +57,7 @@ led-d1 {
 		};
 
 		led-d2 {
-			pwms = <&pwm0 1 7812500 PWM_POLARITY_INVERTED>;
+			pwms = <&pwm0 1 7812500 0>;
 			active-low;
 			color = <LED_COLOR_ID_GREEN>;
 			max-brightness = <255>;
@@ -65,7 +65,7 @@ led-d2 {
 		};
 
 		led-d3 {
-			pwms = <&pwm0 2 7812500 PWM_POLARITY_INVERTED>;
+			pwms = <&pwm0 2 7812500 0>;
 			active-low;
 			color = <LED_COLOR_ID_GREEN>;
 			max-brightness = <255>;
@@ -73,7 +73,7 @@ led-d3 {
 		};
 
 		led-d4 {
-			pwms = <&pwm0 3 7812500 PWM_POLARITY_INVERTED>;
+			pwms = <&pwm0 3 7812500 0>;
 			active-low;
 			color = <LED_COLOR_ID_GREEN>;
 			max-brightness = <255>;
diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
index 07387f9c135c..b328ee80693f 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
@@ -51,8 +51,7 @@ led-controller-1 {
 		compatible = "pwm-leds";
 
 		led-d12 {
-			pwms = <&pwm0 0 7812500 PWM_POLARITY_INVERTED>;
-			active-low;
+			pwms = <&pwm0 0 7812500 0>;
 			color = <LED_COLOR_ID_GREEN>;
 			max-brightness = <255>;
 			label = "d12";
@@ -68,20 +67,17 @@ multi-led {
 			label = "d2";
 
 			led-red {
-				pwms = <&pwm0 2 7812500 PWM_POLARITY_INVERTED>;
-				active-low;
+				pwms = <&pwm0 2 7812500 0>;
 				color = <LED_COLOR_ID_RED>;
 			};
 
 			led-green {
-				pwms = <&pwm0 1 7812500 PWM_POLARITY_INVERTED>;
-				active-low;
+				pwms = <&pwm0 1 7812500 0>;
 				color = <LED_COLOR_ID_GREEN>;
 			};
 
 			led-blue {
-				pwms = <&pwm0 3 7812500 PWM_POLARITY_INVERTED>;
-				active-low;
+				pwms = <&pwm0 3 7812500 0>;
 				color = <LED_COLOR_ID_BLUE>;
 			};
 		};
-- 
2.42.0

