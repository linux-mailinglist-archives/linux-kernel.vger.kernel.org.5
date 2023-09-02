Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B697908F2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 19:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjIBRdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 13:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjIBRdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 13:33:17 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FD0130;
        Sat,  2 Sep 2023 10:33:11 -0700 (PDT)
Received: from [192.168.178.23] (k10064.upc-k.chello.nl [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id A1E1ED074A;
        Sat,  2 Sep 2023 17:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1693675959; bh=MIfk0rla9KfQTZEjEKwE98+NrQUedgBa/nUkrZnJh1E=;
        h=From:Subject:Date:To:Cc;
        b=NmcejQ9HYgXVepN9sGzwVgKxPQgzvOenD1at0u6maZsjN9xfZy1FjZoVoipXdFgo/
         OAzV6UnS1YpXrTns6uD7eqAk30Fz/0wkfe11RVLqYY0B038EE1vRKmirgf4PLvP22/
         3kxkV5lv2uBH6WhZxYez0OfQiDKlFW/UizujxRr4=
From:   Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH 0/2] Add blsp1_i2c6 and blsp1_uart2 to MSM8226 SoC
Date:   Sat, 02 Sep 2023 19:32:23 +0200
Message-Id: <20230902-msm8226-i2c6-v1-0-9632b8916789@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKdx82QC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDSwMj3dziXAsjIzPdTKNkM12DNPMUc5OUxLREiyQloJaCotS0zAqwcdG
 xtbUANu7RHF4AAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=669; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=MIfk0rla9KfQTZEjEKwE98+NrQUedgBa/nUkrZnJh1E=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBk83GxgyY3Ma4897J4Cidfz0V3l6kb9UcChVj3k
 G313YhOKKeJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZPNxsQAKCRBy2EO4nU3X
 VohgEAC1SnpotLH+kqVNteXXhdKopKrL+aP54oMaNqapdrg9tPKco3VwAkElpp3y0aO4cJaqPd8
 sbrIPGVYxaCRsM48ip49yqhp9zgJOa0p2kGdnK2K5N8Js/+peJD3sJaqyG8h3RvodQDtFLzdlEP
 mj3cbSEkxGVNOP9o9qaFZ/JnXKUrmfLgXD6oxm6CJQiYul1fWPOclQrNEG+7digy0u8TraKAnsS
 Mb4OxD2xns2SravIumC5zU1YIYur+H7aUuJS7l+6hOJd4OrXaJpkSHmp2UIlrk/h5mTkCaUn9Rs
 1z+TAxhbZuDoipnC8Kuq2hGJRHxsO3oWEN0RDOe4tuuBkPuqPl59DbQEBXN7kZLVO0XzsOdOzsF
 ncgP2qDK/yJ02FDnmrApgxiuLUWmMqjXG90wu/J0C8mV8do7SM4+M+Q9hO7bPF5m/szk7EL/bH5
 34OZGHZ8qAxzyNVJhBU5GS4P9gJgg9Wwa/5o4rN2NPfVoWwgfLvKXTG50F4DZm+/xTEzRxrNaPx
 /KK78LaHoZB1biYkJ7RGjdpQMA+9Uw9y4ba/xIS2uknsqwHPU9f/TJy5PCEJp2/dUAO+ddRhbcK
 1cZBN74X30J5zwR0B/fQxat5/se0qULW9LpXhvhQFB0nPJEkOM2fXsxulg79zzzUJcNC1SpCm0u
 hI6LwcyoR7YIOLw==
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

Add the I2C bus and UART interface found on the MSM8226. For the I2C bus
we also first need to add the pinctrl function in the driver.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Luca Weiss (2):
      pinctrl: qcom: msm8226: Add blsp_i2c6 function
      ARM: dts: qcom: msm8226: Add blsp1_i2c6 and blsp1_uart2

 arch/arm/boot/dts/qcom/qcom-msm8226.dtsi | 29 +++++++++++++++++++++++++++++
 drivers/pinctrl/qcom/pinctrl-msm8226.c   |  8 ++++++--
 2 files changed, 35 insertions(+), 2 deletions(-)
---
base-commit: 7c2878be573282a9961c359b806ccf70afe1a6b6
change-id: 20230902-msm8226-i2c6-0f7d74dafa8b

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

