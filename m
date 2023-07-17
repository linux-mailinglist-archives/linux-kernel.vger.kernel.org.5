Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1784756696
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjGQOil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGQOik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:38:40 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EE11705
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:38:29 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51e590a8ab5so6150848a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689604708; x=1692196708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5jvKHaT3vughoaStmuT2QRmed9/KJPScQvPNG1Af6IA=;
        b=fDMBBuAqGrXdanhKgy6Kj3GaF1Cbqu1dNoGYEDHeKeBS9YmvhkOOIUL5/2NzBS36S1
         WqJw1NB91/SMUgiN22Uplk0IO8CA2OuWwa61zWXHSt24c/mL4SVm6C45zrfXWHhu8SI0
         pg49mrC9JHQRSFP+cus/9EjsKqUan3J/yXTh8XkurcA21iYrWGkaPqfIku5FOd7UWWEA
         RC6ARNL95Do+TOB7Ry6xoVGuiepCmhvvxzaQFCWmdxxxSrv0+v9NAcph5wWD1behtrAg
         0cMOr4fDZg7RbucNpjLvMObhWZXxRCn4vAcRhh+TUGQ8liu6Aw2ox/jBkCN2TtSDBkkj
         5Ugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689604708; x=1692196708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5jvKHaT3vughoaStmuT2QRmed9/KJPScQvPNG1Af6IA=;
        b=QGJq0k/fqbWpPGwTGKHhb3Tb3JUacnELwmVhRmbgOwZomwmkElGTPhe0BJAnlSA7ON
         mUplvX9ltfqJ5DhuJLPtkAW/nMYFrC6G6kcIjEmXyaQnJzQrjON/G6UNms5boSI5mAnB
         9/4xdQ/TA4rrjNHRl2qEK6cUK956XgIMrs+DedoXjGBFNWAg0cuIIkkug4akZprHCb6W
         tM5Tws9GHBwXHrmrGLMo7ApvfHMXPJIy9ycEbqcbZPSN8+BhYtvFQaWe3RJBFI5eq9cu
         4FlgYndne/UGHp0i1ilv3SsoNWHCErd77a+C/A0UQbgQt0fR43cW3M3DM3KBeExroLOs
         D4mw==
X-Gm-Message-State: ABy/qLanp59iSb1cp4sV7MpPfdbUIryrOxFdi1bsdKw2l+D4TYYHpmAJ
        8nDk/nkrsvycYMRVKBAlpT1dSQ==
X-Google-Smtp-Source: APBJJlHuDUBK5cwmhawGBolzcDQMvMHj53vUDDbfyeMPmszGPef9RxkAxivjFmjVxv7aIFk1NoOooQ==
X-Received: by 2002:a17:906:151:b0:991:d2a8:6588 with SMTP id 17-20020a170906015100b00991d2a86588mr12500412ejh.51.1689604707729;
        Mon, 17 Jul 2023 07:38:27 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id qx21-20020a170906fcd500b009937e7c4e54sm9264078ejb.39.2023.07.17.07.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 07:38:26 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] arm64: dts: qcom: sm8450-hdk: add other analogue microphones
Date:   Mon, 17 Jul 2023 16:38:24 +0200
Message-Id: <20230717143824.203352-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add proper audio routes for onboard analogue microphones: AMIC[1345].
Use also new DAPM input widget (TX SWR_INPUTn) for them, not the
deprecated ADC one.  Change is not compatible with older kernels not
having the new SWR_INPUTn input widget.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on ASoC driver changes:
https://lore.kernel.org/alsa-devel/20230717140138.201745-1-krzysztof.kozlowski@linaro.org/T/#t
This patch should wait till respective ASoC changes got merged.
---
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
index bd5e8181f2aa..9bd1ef401ca3 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
@@ -915,14 +915,23 @@ &sound {
 			"SpkrRight IN", "WSA_SPK2 OUT",
 			"IN1_HPHL", "HPHL_OUT",
 			"IN2_HPHR", "HPHR_OUT",
+			"AMIC1", "MIC BIAS1",
 			"AMIC2", "MIC BIAS2",
-			"VA DMIC0", "MIC BIAS1",
-			"VA DMIC1", "MIC BIAS1",
-			"VA DMIC2", "MIC BIAS3",
-			"TX DMIC0", "MIC BIAS1",
-			"TX DMIC1", "MIC BIAS2",
-			"TX DMIC2", "MIC BIAS3",
-			"TX SWR_ADC1", "ADC2_OUTPUT";
+			"AMIC3", "MIC BIAS3",
+			"AMIC4", "MIC BIAS3",
+			"AMIC5", "MIC BIAS4",
+			"VA DMIC0", "MIC BIAS3",
+			"VA DMIC1", "MIC BIAS3",
+			"VA DMIC2", "MIC BIAS1",
+			"VA DMIC3", "MIC BIAS1",
+			"TX DMIC0", "MIC BIAS3",
+			"TX DMIC1", "MIC BIAS3",
+			"TX DMIC2", "MIC BIAS1",
+			"TX DMIC3", "MIC BIAS1",
+			"TX SWR_INPUT0", "ADC1_OUTPUT",
+			"TX SWR_INPUT1", "ADC2_OUTPUT",
+			"TX SWR_INPUT2", "ADC3_OUTPUT",
+			"TX SWR_INPUT3", "ADC4_OUTPUT";
 
 	wcd-playback-dai-link {
 		link-name = "WCD Playback";
-- 
2.34.1

