Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB4C77BA2D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjHNNeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbjHNNeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:34:10 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0608210E4;
        Mon, 14 Aug 2023 06:34:03 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b9b5ee9c5aso67026751fa.1;
        Mon, 14 Aug 2023 06:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692020041; x=1692624841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9pjgEmaLZWbZLKm+zTsTjeEOP7/LCJvRIUhdiZyAT1I=;
        b=pV6MQqG9bmj4rwGryQS8sAmZjLuAEtSu2dmeIlWYgBxThrRxinf668n5kQZgcLQe+i
         i448GWBiO5Nh2UwtmtPjStdHCiCzrawPvCVIyL/YGG/WASGtq7/C8Im9vbevT8U3KWqa
         du1F8VjlH+cOyuOz39iOTtoNx6Fs5S8z39f4uj89GlCt6hSmmgrn0ARt2eql+Wqw1tJ8
         ooNRhDaSZs6VvyB5fSVmaiQGtx27RPbmvR61AWxd7RwfnDcx921uAfUSFCmZm4p0viur
         wc9wOksQN1ckXqCXRNaeNSplgsqW81NSpJ1vmkyVn4eqrTuUQF//oax4Iw+/DtzTXxap
         wG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692020041; x=1692624841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9pjgEmaLZWbZLKm+zTsTjeEOP7/LCJvRIUhdiZyAT1I=;
        b=FHbW4LwxPq6cau3LZqFADo3D3WrcGpFZVuCZVR0PtWzFnMR/DZfoktl2rwq+kb7ISr
         r7ghtQhHibI30w1xESaG+79f+GuGQMWGhlEpOerrahpj1rhPNGzznpbecWdOIsgAQSqI
         P7ZiDExzoaQ0JI5YWL3h0ZCQ8z3Lf1Sd9ja+D9nmXk3GtBi9EazwqZfv7+x0sw+QAH4F
         g/eiTrevHjzSfykDYzuDHTsAAi1JIfa1XHeMwbKWxYMILCuLId5Dl3BydcrmqJQywKyS
         4vo6t91SXuTD9yv68ea+Iq1/UhTq9l4/rmBhi3c1yGchwmKCC/0T4+l2zImy4Of8R5jK
         o1bA==
X-Gm-Message-State: AOJu0YyueI9KgznvZfXQHmrOjMktD5gem174T5G3CEwTC0K8+itDudUI
        Ae7rayOdytPMMlM9/cLzrDDLZit8XDhQJas=
X-Google-Smtp-Source: AGHT+IE04Os9pVpiMT8/NqYeoJXgPVFzpHjwQ1FtN9jAFrhs3SAvVlW6EoYVd4gdqzVWytycaa700A==
X-Received: by 2002:a05:6512:3984:b0:4ff:7e80:4f1d with SMTP id j4-20020a056512398400b004ff7e804f1dmr271490lfu.57.1692020040730;
        Mon, 14 Aug 2023 06:34:00 -0700 (PDT)
Received: from localhost.localdomain (mail.pulsar-telecom.ru. [94.181.180.60])
        by smtp.gmail.com with ESMTPSA id eo12-20020a056512480c00b004f858249932sm1990566lfb.90.2023.08.14.06.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 06:34:00 -0700 (PDT)
From:   Aleksandr Shubin <privatesub2@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Aleksandr Shubin <privatesub2@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Subject: [PATCH v5 3/3] riscv: dts: allwinner: d1: Add pwm node
Date:   Mon, 14 Aug 2023 16:32:18 +0300
Message-Id: <20230814133238.741950-4-privatesub2@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230814133238.741950-1-privatesub2@gmail.com>
References: <20230814133238.741950-1-privatesub2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

D1 and T113s contain a pwm controller with 8 channels.
This controller is supported by the sun20i-pwm driver.

Add a device tree node for it.

Signed-off-by: Aleksandr Shubin <privatesub2@gmail.com>
---
 arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
index 922e8e0e2c09..e24543b6aff7 100644
--- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
@@ -127,6 +127,17 @@ uart3_pb_pins: uart3-pb-pins {
 			};
 		};
 
+		pwm: pwm@2000c00 {
+			compatible = "allwinner,sun20i-d1-pwm";
+			reg = <0x02000c00 0x400>;
+			clocks = <&dcxo>,
+				 <&ccu CLK_BUS_PWM>;
+			clock-names = "hosc", "bus";
+			resets = <&ccu RST_BUS_PWM>;
+			status = "disabled";
+			#pwm-cells = <0x3>;
+		};
+
 		ccu: clock-controller@2001000 {
 			compatible = "allwinner,sun20i-d1-ccu";
 			reg = <0x2001000 0x1000>;
-- 
2.25.1

