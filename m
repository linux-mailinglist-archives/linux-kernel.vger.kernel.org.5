Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1262D786C75
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240807AbjHXJ7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240754AbjHXJ7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:59:02 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE291984
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 02:59:00 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4ffa94a7a47so8766680e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 02:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692871139; x=1693475939;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xhj9qr6wA2akPHSa65YNjD4meHDS+0P1VytRfMyGc3Q=;
        b=pS6a55YmSTdQr/nJwGAN3HkdEcEkliowOt0rA6ZMXL3YTIVKl4wRlQK1VoNWwp5bXh
         KJV6I2vw0xxVGBSl97GJxfvvWiQUL9jlIFCq4yn7IbJHVU4Ls9RjP/ICn8fVkQDyQmrG
         QJqwcWeStGC+7qvfzzZqo/yFWOxOP34+nXn+rqeIzVesgMEtEYLsFUoN09WRsCgWxOQ4
         EYVBr5rGIKTJgq8y4YoK+3J0ZJrLDXHUv9l/2r67Vc2p0ykVLgW+gjDPaffNQmMlGX8i
         R2l+3nlXv/6WS6UdHzQFudQfgg4mQObjNyqodRRFcDYrz5BAefbl6uxX900R6oWyF4ZU
         xvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692871139; x=1693475939;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xhj9qr6wA2akPHSa65YNjD4meHDS+0P1VytRfMyGc3Q=;
        b=dD2BTt/zHcnnT+oHFOMM/9rYoVNr7KZh5TY9mfYY1DeoWxmWWnIgjBYYp74k7CFqqg
         1vGQVIE6C0Ja9IBGvsOPVUV397LlRzA0gshymLcezf7k1whRbHwBMp/N6ubFop+AiOBp
         AqhyjikftwoCEJHrmlsebC2toqFFxzybHkIbCwTfynVork7OtkWHfmbFIMPzP0tSxHsw
         4YhEDhkTTMy0IgR/feUbAt0gFwQGPBzCw7DtX/hjgbIwY/lk5LlPeoTaiQCleckfxkuy
         eO/XKLQBS2fjnQ197e3Ag6oZEpB2QyA8DItSPZpOF0wLOc4T7rLUO0jf8rO0ZMrjwPTY
         jFgQ==
X-Gm-Message-State: AOJu0Yzgxn0bDudCi+DiLfmWFTopBhpUjPt463E+59N1LmWTsXaVKeUy
        L8Nk0FcWonq1BmJ3YuFEzr9CU9opQdXkHZuxSySyDA==
X-Google-Smtp-Source: AGHT+IEbJilHQNSoGAbtW7OY7i9wd48GrUOBtKvw0bkpQWCfxlXjJ9qcrnXW6Vzdj/l1VWLWJEYTdw==
X-Received: by 2002:a05:6512:10d6:b0:4fd:c715:5667 with SMTP id k22-20020a05651210d600b004fdc7155667mr12192159lfg.20.1692871138915;
        Thu, 24 Aug 2023 02:58:58 -0700 (PDT)
Received: from [10.167.154.1] ([2a00:f41:4882:ba34:4490:938b:eab4:c5ef])
        by smtp.gmail.com with ESMTPSA id y2-20020a197502000000b0050096712dc8sm712301lfe.277.2023.08.24.02.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 02:58:58 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 24 Aug 2023 11:58:53 +0200
Subject: [PATCH 2/3] arm64: dts: qcom: sdm845-tama: Add GPIO line names for
 PMIC GPIOs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230824-topic-tama_gpio-v1-2-014e9d198dce@linaro.org>
References: <20230824-topic-tama_gpio-v1-0-014e9d198dce@linaro.org>
In-Reply-To: <20230824-topic-tama_gpio-v1-0-014e9d198dce@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692871134; l=4220;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=RfJk4m3j691N0aXP/c3pg1WYO/bCOpFVFAp7DphEu+4=;
 b=WygaPyy/GgDc3QXvnbLlYxW0h4M/YAcU/rISt0tpP6UFZ7sDwM0MoxUwMzqHZHhbnekRiF9ZM
 Jrj2t/7uP+uBFYv2pVX1ks+uKzErG3JUcwivkzNgzG4GkYV4UUoAEdO
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sony ever so graciously provides GPIO line names in their downstream
kernel (though sometimes they are not 100% accurate and you can judge
that by simply looking at them and with what drivers they are used).

Add these to the Akari, Apollo & Akatsuki DTS-es to better document
the hardware.

pm8005 and pm8998 config is common for all three boards.
Apollo has VIB_LDO_EN (replacing NC) on PMI8998_GPIO_5

Akari and Akatsuki have WLC_EN_N (replacing NC) on PMI8998_GPIO_8

Akari additionally has RSVD(WLC_EN_N) (replacing) on PMI8998_GPIO_11
which sounds a bit like a forgot-to-update-documentation, but maybe
it differs between SKUs.. Time will tell, when we get to enabling the
wireless charger.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../dts/qcom/sdm845-sony-xperia-tama-akari.dts     | 17 +++++++++++
 .../dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts  | 17 +++++++++++
 .../dts/qcom/sdm845-sony-xperia-tama-apollo.dts    | 17 +++++++++++
 .../boot/dts/qcom/sdm845-sony-xperia-tama.dtsi     | 34 ++++++++++++++++++++++
 4 files changed, 85 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akari.dts b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akari.dts
index d2cb6478a8c0..6e65909ab582 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akari.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akari.dts
@@ -16,6 +16,23 @@ &panel {
 	compatible = "sony,td4353-jdi-tama";
 };
 
+&pmi8998_gpios {
+	gpio-line-names = "NC", /* GPIO_1 */
+			  "NC",
+			  "NC",
+			  "",
+			  "NC",
+			  "NC",
+			  "",
+			  "WLC_EN_N",
+			  "NC",
+			  "NC", /* GPIO_10 */
+			  "RSVD(WLC_EN_N)",
+			  "CAM_IO_EN",
+			  "",
+			  "NC";
+};
+
 &tlmm {
 	gpio-line-names = "NC", /* GPIO_0 */
 			  "NC",
diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts
index a91712f6af28..82e59e453354 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts
@@ -44,6 +44,23 @@ &panel {
 	/delete-property/ touch-reset-gpios;
 };
 
+&pmi8998_gpios {
+	gpio-line-names = "NC", /* GPIO_1 */
+			  "NC",
+			  "NC",
+			  "",
+			  "NC",
+			  "NC",
+			  "",
+			  "WLC_EN_N",
+			  "NC",
+			  "NC", /* GPIO_10 */
+			  "NC",
+			  "CAM_IO_EN",
+			  "",
+			  "NC";
+};
+
 &pmi8998_wled {
 	status = "disabled";
 };
diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-apollo.dts b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-apollo.dts
index 52bd83d1febf..dc15ab1a2716 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-apollo.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-apollo.dts
@@ -18,6 +18,23 @@ &panel {
 	width-mm = <56>;
 };
 
+&pmi8998_gpios {
+	gpio-line-names = "NC", /* GPIO_1 */
+			  "NC",
+			  "NC",
+			  "",
+			  "VIB_LDO_EN",
+			  "NC",
+			  "",
+			  "NC",
+			  "NC",
+			  "NC", /* GPIO_10 */
+			  "NC",
+			  "CAM_IO_EN",
+			  "",
+			  "NC";
+};
+
 &tlmm {
 	gpio-line-names = "NC", /* GPIO_0 */
 			  "NC",
diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
index 7ee61b20452e..430857233967 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
@@ -524,7 +524,41 @@ &mdss_dsi0_phy {
 	status = "okay";
 };
 
+&pm8005_gpios {
+	gpio-line-names = "NC", /* GPIO_1 */
+			  "NC",
+			  "",
+			  "";
+};
+
 &pm8998_gpios {
+	gpio-line-names = "NC", /* GPIO_1 */
+			  "FOCUS_N",
+			  "",
+			  "NC",
+			  "VOL_DOWN_N",
+			  "VOL_UP_N",
+			  "SNAPSHOT_N",
+			  "NC",
+			  "FLASH_THERM",
+			  "NC", /* GPIO_10 */
+			  "LCD_ID",
+			  "RF_ID",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "", /* GPIO_20 */
+			  "NFC_CLK_REQ",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "";
+
 	focus_n: focus-n-state {
 		pins = "gpio2";
 		function = PMIC_GPIO_FUNC_NORMAL;

-- 
2.42.0

