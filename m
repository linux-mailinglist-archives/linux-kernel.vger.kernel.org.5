Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD567D1CEA
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 13:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjJULzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 07:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJULzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 07:55:52 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9966FD67;
        Sat, 21 Oct 2023 04:55:50 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9ba1eb73c27so269860466b.3;
        Sat, 21 Oct 2023 04:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697889349; x=1698494149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dz6kcRDJs2sEmG1mhBttulVCf9cJKsKoCbJ9XgaIGgs=;
        b=NThi9T/NQtO+DIVymox1UIs0qdoClL1Xl1JGUVgLmmfEE7tqBqas9XXKlIpvA2S1mG
         IPYb05Jv6HDFVWVGUbsbg9LYSGyD2AQSbyAMHuzEYdvtLUj//jlwQmouIYnR3sEvEXKI
         HqPht0GDAyJKN4nRzlqsw4UF4sThwihR7woLgiG2S+ihQtijakea9eR46un4LVB7IFfi
         ouEzQ2iL/1HnRYG0Esj29eQynwwrkqrP69O+tTv/iWoW6ZCbE3u63nQfDQtqqSciUOXP
         YPVSHyyklqw8Pk2lapNryuwLF/wZvHuYsHhZRIHWNEEYqLB1417drr552VMsXQA7Ua3r
         YFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697889349; x=1698494149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dz6kcRDJs2sEmG1mhBttulVCf9cJKsKoCbJ9XgaIGgs=;
        b=GdmaRCySNRldG3vsNNp29WGIvXt/hxNWaqpw9EVtpdFjtPkJHDJCaXBk+UHOvBe776
         uxD1zoU3JZ3VTS2OCB8FYBdde7zpWui+9E1if1hRXTEhm2wExSQnp5X/aSTjx3Vg67rX
         IooT5CbvR/e8e3yrCYoQlPOKp/6aIDIOWc/oR3mjXSfU/csy7BSQyiWX1xhq7serjVID
         HbX8FGM2U+ARBK09jD4ihLdzzfoJlmEBmSJTtDPYv7N4LDyzN6rDWQsTzq85bQG1XUOx
         BoIfqYzIeLRePP9DSTdRlemEzwsIdukpXK4zoD7POFr9Pzkc7m9+WT0wltrYGWAL01Tg
         F7bA==
X-Gm-Message-State: AOJu0Yx95exTsaSuklEOIl4FMrgoSsSwDj80PeBAEE/qDv+3DfRdHu/C
        iykY/g0PGAoU1sVLU7i49hs=
X-Google-Smtp-Source: AGHT+IHkEf2EQxbrNrvaL5WKe+RLiysLnfunng5mNwk66YE9zvvl876DnFUnJ2kIn5NEnWuLkE6pUg==
X-Received: by 2002:a17:907:3688:b0:9be:2991:81fa with SMTP id bi8-20020a170907368800b009be299181famr3136291ejc.39.1697889348834;
        Sat, 21 Oct 2023 04:55:48 -0700 (PDT)
Received: from fedora.. (cpezg-94-253-130-100-cbl.xnet.hr. [94.253.130.100])
        by smtp.googlemail.com with ESMTPSA id d11-20020a170906040b00b0099bd046170fsm3502776eja.104.2023.10.21.04.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 04:55:48 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>,
        Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Subject: [PATCH v2] clk: qcom: gcc-ipq6018: add QUP6 I2C clock
Date:   Sat, 21 Oct 2023 13:55:18 +0200
Message-ID: <20231021115545.229060-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QUP6 I2C clock is listed in the dt bindings but it was never included in
the GCC driver.
So lets add support for it, it is marked as criticial as it is used by RPM
to communicate to the external PMIC over I2C so this clock must not be
disabled.

Signed-off-by: Robert Marko <robimarko@gmail.com>
Reviewed-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
---
Changes in v2:
* Mark the clock as critical
* Add comment as to why its marked as critical
* Update commit description thanks for explanation from Kathiravan

 drivers/clk/qcom/gcc-ipq6018.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq6018.c b/drivers/clk/qcom/gcc-ipq6018.c
index aa94fcb1e4aa5..e24c2c2c0db71 100644
--- a/drivers/clk/qcom/gcc-ipq6018.c
+++ b/drivers/clk/qcom/gcc-ipq6018.c
@@ -2118,6 +2118,26 @@ static struct clk_branch gcc_blsp1_qup5_spi_apps_clk = {
 	},
 };
 
+static struct clk_branch gcc_blsp1_qup6_i2c_apps_clk = {
+	.halt_reg = 0x07010,
+	.clkr = {
+		.enable_reg = 0x07010,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_blsp1_qup6_i2c_apps_clk",
+			.parent_hws = (const struct clk_hw *[]){
+					&blsp1_qup6_i2c_apps_clk_src.clkr.hw },
+			.num_parents = 1,
+			/*
+			 * RPM uses QUP6 I2C to communicate with the external
+			 * PMIC so it must not be disabled.
+			 */
+			.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_blsp1_qup6_spi_apps_clk = {
 	.halt_reg = 0x0700c,
 	.clkr = {
@@ -4274,6 +4294,7 @@ static struct clk_regmap *gcc_ipq6018_clks[] = {
 	[GCC_BLSP1_QUP4_SPI_APPS_CLK] = &gcc_blsp1_qup4_spi_apps_clk.clkr,
 	[GCC_BLSP1_QUP5_I2C_APPS_CLK] = &gcc_blsp1_qup5_i2c_apps_clk.clkr,
 	[GCC_BLSP1_QUP5_SPI_APPS_CLK] = &gcc_blsp1_qup5_spi_apps_clk.clkr,
+	[GCC_BLSP1_QUP6_I2C_APPS_CLK] = &gcc_blsp1_qup6_i2c_apps_clk.clkr,
 	[GCC_BLSP1_QUP6_SPI_APPS_CLK] = &gcc_blsp1_qup6_spi_apps_clk.clkr,
 	[GCC_BLSP1_UART1_APPS_CLK] = &gcc_blsp1_uart1_apps_clk.clkr,
 	[GCC_BLSP1_UART2_APPS_CLK] = &gcc_blsp1_uart2_apps_clk.clkr,
-- 
2.41.0

