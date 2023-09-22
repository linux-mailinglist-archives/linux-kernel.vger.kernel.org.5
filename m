Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D6B7AB692
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 18:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjIVQ4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 12:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbjIVQ40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 12:56:26 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71E8198;
        Fri, 22 Sep 2023 09:56:19 -0700 (PDT)
Received: from [192.168.178.23] (k10064.upc-k.chello.nl [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id E0CFDD0F53;
        Fri, 22 Sep 2023 16:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1695401748; bh=X0qHRPoLMOxnQvNTYqWxzwszdU93Rpm9tgDuGSYM6ZM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=xJV5IO0BHfjForF/fu7DKg7FrKJkm3SoDR78oqY1nFNpBHWKxtrN9Grq6DAY70QM2
         +bbEfAGRzW0FgtxIrPUisiP8VqmQh0Os1Enpu0ehSHFUA/LTTHe5T0hFQ2Ofg0XNTb
         qfzd9to9qT6VgEYhomcq3w3QBNY+6CO/C/BADhF0=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Fri, 22 Sep 2023 18:55:12 +0200
Subject: [PATCH v2 1/3] dt-bindings: pinctrl: qcom,msm8226: Add blsp_i2c6
 function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230922-msm8226-i2c6-v2-1-3fb55c47a084@z3ntu.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1299; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=X0qHRPoLMOxnQvNTYqWxzwszdU93Rpm9tgDuGSYM6ZM=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlDccQAOOjIIixL9TPZtAThpL4kvoT6rE8z0wgN
 kOSnZV3YF+JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZQ3HEAAKCRBy2EO4nU3X
 Vju/D/9pwdg6ip6qbgk0hAq3itmbmv9SUJnAWCFphTCtqhgk5xBKN76Wjyjh4bMQT+F/pB/YfMJ
 rbKfqBMmYbfs4+F5QsIgxd+30V2FeQO1RMKwgtuBo6Mp9NT7xbYqxr04jlFWZO6yMhoaOmd1lLb
 T80Q8hJPfmV6z8zVVhkdPp4XMDlW1ajrp6d1L8tuVJvA7675YxQmjLCmLz2Z0FyGjRZfor0NvQs
 up68hUZYmM0AI4D0r61LcgwzEeN3PynGQEXE8WuHn0gA7ZrOhrpCmyJgkgGpWw5inR+8Qec8GwF
 l+L/OBWWs9beQk9tA9+EwMCN6AmW0NCcve4ZNzt4V2r2BJ9M+v1f3I1mptZp/Md4BlnI8fM2bKs
 G7EZBWV4faj3TBsn2DQZEXj4VicNXVSd2+YD2CMMhlRP/0+wn7aSA64RkB7zNAc2bkQKqk5EWBY
 mA0LdgyFCI8PIppNWYknLHGCR8H6yX46fQqVgjJMxPm2DzdHQFTsZtIOAWEqiA3O+1VktjB/Rb4
 Usn4xgF9iLXo82GKPKyMYSwfnjrwtMwxVeRvdgl320AB0xulF2ppYic7mYICc0WSqd643ohtf3U
 NptN3RisfPZcWBIlC3yDm6mU4eDy/EcZ/aAQTdXyas2fd7/7em/zlwsYIAYXfvnd6O/YCRlgGnO
 gQHUR/o0lF4M/Sg==
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

Add the blsp_i2c6 function that can be found on some pins.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
index 9efb76509580..a602bf0d27fb 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
@@ -67,8 +67,8 @@ $defs:
           Specify the alternative function to be configured for the specified
           pins. Functions are only valid for gpio pins.
         enum: [ gpio, cci_i2c0, blsp_uim1, blsp_uim2, blsp_uim3, blsp_uim5,
-                blsp_i2c1, blsp_i2c2, blsp_i2c3, blsp_i2c4, blsp_i2c5, blsp_spi1,
-                blsp_spi2, blsp_spi3, blsp_spi5, blsp_uart1, blsp_uart2,
+                blsp_i2c1, blsp_i2c2, blsp_i2c3, blsp_i2c4, blsp_i2c5, blsp_i2c6,
+                blsp_spi1, blsp_spi2, blsp_spi3, blsp_spi5, blsp_uart1, blsp_uart2,
                 blsp_uart3, blsp_uart4, blsp_uart5, cam_mclk0, cam_mclk1,
                 gp0_clk, gp1_clk, sdc3, wlan ]
 

-- 
2.42.0

