Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8857908EA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 19:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjIBRcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 13:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjIBRcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 13:32:46 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D025A4;
        Sat,  2 Sep 2023 10:32:42 -0700 (PDT)
Received: from [192.168.178.23] (k10064.upc-k.chello.nl [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 4073AD0764;
        Sat,  2 Sep 2023 17:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1693675960; bh=29unbUdSjssR6lCbO5AvxRnTJpcHD6ixkyfP951p+1A=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=jniO2c/id9WRq0ST9jXwjuxGLn6z9r95u3jYdW40Uggp50sfJVDKyrQoos0Sc+wY1
         z/fY3wllu6+KvUMfxEufOswPbkTv8NVNp1sqB2Dvnr8GSkVZPtvDgkI7pr5s3ztTaX
         YjLueZebKmuXjRdY9L2vxd1dyub0Ul83ZA4zKQas=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Sat, 02 Sep 2023 19:32:24 +0200
Subject: [PATCH 1/2] pinctrl: qcom: msm8226: Add blsp_i2c6 function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230902-msm8226-i2c6-v1-1-9632b8916789@z3ntu.xyz>
References: <20230902-msm8226-i2c6-v1-0-9632b8916789@z3ntu.xyz>
In-Reply-To: <20230902-msm8226-i2c6-v1-0-9632b8916789@z3ntu.xyz>
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
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBk83G1izVHNETlovIhCBg9yuJuS/VWWe7y/qoD+
 Y0bxBzruKWJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZPNxtQAKCRBy2EO4nU3X
 Vq9cD/9W2tmntRL/M3zo7gNixWZzbIZqVRJibbPPBBmtJkAKx65I/EwqqgLwi2AE6FSVC5SC6IO
 VGU93GmywZ8Dz+H34dFCicEWy9Xj/XP1pn4/+9JQFKIw42pcOG0DZlsQe+tVQGjywvUSgrK2u5a
 r56FF2FJyWhrPfZMef2FBpSfTCdIi7mcFLxIRNA2wMflY3R7A5PPho6GLVoUuaqnNSijprcCl6R
 ycl/r10Jw+gGOZc2hvZr7BRXEI2SgUpJikJdQ6KmDmeKLsysqBrTJj0bGupCNhRa+msWntqwtOS
 w9NgthxkX52ezoLOPnSzewxe1V0NNBFvHb1fFw1/pZHJjLAar+WlZmyKkS+CO2FtZYLeUfZX3Aj
 sSW1mbAl2t6o2fm3COSy3Y2Oa0yTcZpa/xGg/JEqt0eG2EDgakcAo6J9dcxRXZ84Qubc8mQw8eN
 I9SU40mJv/TWoioiVFch2xSqjpd8CCoeZwo9vZeGhPzxTCAA9TLmJTXmFsssYo7xrwP8dTOevdA
 GrQA7DtjqcabKBl1+7bNHPsZw+zJpSFWuheJilY26rK/MXjaYGRGgHlcH+7X9nuxSk+Ag1OgByL
 hYGvhGngYraT4gRCV8GlBliLV9OTIyLzZYyzdDinOres5GPO4hI81BEUtoi3DcAXUSA6BXaOPLU
 PeL7kfJzXbPEzVA==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

