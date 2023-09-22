Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB7C7AB687
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 18:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjIVQ4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 12:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjIVQz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 12:55:56 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD240F1;
        Fri, 22 Sep 2023 09:55:49 -0700 (PDT)
Received: from [192.168.178.23] (k10064.upc-k.chello.nl [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 26455D0F55;
        Fri, 22 Sep 2023 16:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1695401748; bh=29unbUdSjssR6lCbO5AvxRnTJpcHD6ixkyfP951p+1A=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=dribFQtzd/NL/YuUOZpxC9SpR8eStK9pkgPS23fvTeClRMap+ocvHBtPvkfMD1QE0
         wGijWEBrvCPuNBbbX7NZDmmKki3kyZJ0TeYEdplZnKlcK6DItSqYnJWkQJvQQyon5E
         r4/naM10Dk+XURR1U1hNsQyBY7zrVYrgaiNqVzwk=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Fri, 22 Sep 2023 18:55:13 +0200
Subject: [PATCH v2 2/3] pinctrl: qcom: msm8226: Add blsp_i2c6 function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230922-msm8226-i2c6-v2-2-3fb55c47a084@z3ntu.xyz>
References: <20230922-msm8226-i2c6-v2-0-3fb55c47a084@z3ntu.xyz>
In-Reply-To: <20230922-msm8226-i2c6-v2-0-3fb55c47a084@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1885; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=29unbUdSjssR6lCbO5AvxRnTJpcHD6ixkyfP951p+1A=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlDccRM6wvIdj62IgoVNumpASOZ8bPL9qMLEi9x
 lrlwGbxoFyJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZQ3HEQAKCRBy2EO4nU3X
 VjV2EADXbPS/N5evWF9YRnEQvsK2B/vTJqvNwwjN9798iJPsZ4otoQmL0NhjFpChuCAGFwq63A7
 HaPSLZT6xOhcXpTl7gIc/4ngVzbsL4F8cBz4hP/swHZs+G4HhPdBGHeCKVaYvjqAlzDhiAPgG/v
 wL0XgymSkyU4XxzUFM19ZPSP6+MJ6IKP5A/Lu5/xHBQS0hUsQ0MXGT7D04Av1lI1lPGNEgoKpcI
 ZumGd+LOCiPfccYdYkbQYWLxIM5ZDjW/JMco//AeAoMTHIPCvnQ5XYUyy5h/BurC6VLUoOLOyco
 tl0UtjCCcHVFfoyq0JC7/nQYOu7eDoRqvMGeCwBzKPgVIasuxpCTtdDHI7ifId0k7owVpwV/Cfi
 Bn6hkiQWTNHVNnKyL242nJ15SFxetMM3Dt/DimoyMYQx4fE0toVA+voZKox4BBKXyp+2zI5xtgY
 ET8TnTYvqWTlDPBPWQtUDd8ohtamlw3jPrxFX1qsMT7Juf+tP+wskBXmK94UAbMlgbdEopGRC4U
 TIiRF+4ntABRYQSuU2y4ZbD2oZmLsxPVKGKDz8PW7vX9QqVI+xBYznvmcke8Ri/C4RwGtjHg+rj
 zedm2sWKXhDrrp8SWm3nlTljEX+KdfsKKPhcYf02cstT2E2JfuSblsJ+1/fv023iVUc201bSh5K
 UsnM5H9/n/6dwcQ==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On GPIO22 and GPIO23 there is another I2C bus. Add the function for it.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/pinctrl/qcom/pinctrl-msm8226.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm8226.c b/drivers/pinctrl/qcom/pinctrl-msm8226.c
index 994619840a70..da964eebd313 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm8226.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm8226.c
@@ -336,6 +336,7 @@ enum msm8226_functions {
 	msm_mux_blsp_i2c3,
 	msm_mux_blsp_i2c4,
 	msm_mux_blsp_i2c5,
+	msm_mux_blsp_i2c6,
 	msm_mux_blsp_spi1,
 	msm_mux_blsp_spi2,
 	msm_mux_blsp_spi3,
@@ -436,6 +437,8 @@ static const char * const blsp_spi5_groups[] = {
 	"gpio16", "gpio17", "gpio18", "gpio19"
 };
 
+static const char * const blsp_i2c6_groups[] = { "gpio22", "gpio23" };
+
 static const char * const cci_i2c0_groups[] = { "gpio29", "gpio30" };
 
 static const char * const cam_mclk0_groups[] = { "gpio26" };
@@ -459,6 +462,7 @@ static const struct pinfunction msm8226_functions[] = {
 	MSM_PIN_FUNCTION(blsp_i2c3),
 	MSM_PIN_FUNCTION(blsp_i2c4),
 	MSM_PIN_FUNCTION(blsp_i2c5),
+	MSM_PIN_FUNCTION(blsp_i2c6),
 	MSM_PIN_FUNCTION(blsp_spi1),
 	MSM_PIN_FUNCTION(blsp_spi2),
 	MSM_PIN_FUNCTION(blsp_spi3),
@@ -507,8 +511,8 @@ static const struct msm_pingroup msm8226_groups[] = {
 	PINGROUP(19,  blsp_spi5, blsp_uart5, blsp_i2c5, NA, NA, NA, NA),
 	PINGROUP(20,  NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(21,  NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(22,  NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(23,  NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(22,  NA, NA, blsp_i2c6, NA, NA, NA, NA),
+	PINGROUP(23,  NA, NA, blsp_i2c6, NA, NA, NA, NA),
 	PINGROUP(24,  NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(25,  NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(26,  cam_mclk0, NA, NA, NA, NA, NA, NA),

-- 
2.42.0

