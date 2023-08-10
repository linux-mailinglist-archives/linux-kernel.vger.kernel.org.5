Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB68E777B6B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbjHJO4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234687AbjHJO4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:56:42 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD7126A0;
        Thu, 10 Aug 2023 07:56:40 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fe28e4671dso1548258e87.0;
        Thu, 10 Aug 2023 07:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691679399; x=1692284199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9pjgEmaLZWbZLKm+zTsTjeEOP7/LCJvRIUhdiZyAT1I=;
        b=NblbJO7/2Ss674guLQHVjj8RzFXtFbwGuEzHos0GJr94LzO88o0Iev47abuxJLfP4y
         g+8Z6r0kL6ByXiVbTnkfUkRXH+ji09/lMHqwT9cTlD4+YU3jP6SCA4O2rIcE3RtE9OGT
         +NgolV9kq/VPKDREHjuQ+7kVcLuQ7Tk662uuVQVSyUIH999syuH/Y8hicQcoFyYUlHa/
         cbGGoZSBpeE91tcpORHnz/7mU39Cn8MaztKKLtrF1NNimy6g0D6sTmd4uk/soqByzQC+
         Ws/iq/BXsn/Mhwgg7A7tz8ZgDvBRI8puL+mguwKRVo2YKgBkjQdVS8GsqDBkh6iQS0Y7
         TOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691679399; x=1692284199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9pjgEmaLZWbZLKm+zTsTjeEOP7/LCJvRIUhdiZyAT1I=;
        b=lRpK47fGx69/AY2i2Lm+kxu/PzFEwXJlaqM/0eh7FwXLyUVHGK0dMRJLIrqUu/BF4n
         Hmqa5X4dwbthLnjXuzjs6gTItR6HYl1RwuS3An7KPItDEJAJtSax9S1/fAR8H+79K1Xq
         Plcy+1QaDWBWK7I5jk3FbVfdeNKc2+HJP0ESyJfkvMyhZf8hmUhzdFr9Fp5e0gMYnvAE
         DqHFW9kz6zPdKOnKhivphVrlO+fjxAOByURvyI7u1drqaI2ZsKuPNSPWOi58oshU2l2o
         N3XBNBoJqwJioyo2wkPikDseO5U9t4UYDFEd0m8FMMvQONOKhZ7z0kBGCdiSwEodthBK
         2cAg==
X-Gm-Message-State: AOJu0YwhfH3RLNknczCXVYm1iD1zSSjSsuRWM6K4BLXmliAZKPDgQ2ao
        6SANvOVx0j4XC6rpDitdLdlsvdnKIFdGET0=
X-Google-Smtp-Source: AGHT+IGc4D1yN43d/fMmdFFXBfx2I/wJfkAD5m7dIiQY5P19trltKvl/MLc6FmifEgRKE5Q9FmWa6A==
X-Received: by 2002:a05:6512:1093:b0:4f6:1779:b1c1 with SMTP id j19-20020a056512109300b004f61779b1c1mr2878454lfg.48.1691679398692;
        Thu, 10 Aug 2023 07:56:38 -0700 (PDT)
Received: from localhost.localdomain (mail.pulsar-telecom.ru. [94.181.180.60])
        by smtp.gmail.com with ESMTPSA id p12-20020ac246cc000000b004fe0de39fddsm308496lfo.290.2023.08.10.07.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 07:56:38 -0700 (PDT)
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
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Subject: [PATCH v4 3/3] riscv: dts: allwinner: d1: Add pwm node
Date:   Thu, 10 Aug 2023 17:54:28 +0300
Message-Id: <20230810145443.1053387-4-privatesub2@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230810145443.1053387-1-privatesub2@gmail.com>
References: <20230810145443.1053387-1-privatesub2@gmail.com>
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

