Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B2B79A47A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbjIKH3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 03:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbjIKH3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:29:07 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE172CF5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 00:28:52 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-401f68602a8so44722475e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 00:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694417331; x=1695022131; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N2ERWb9EP2wbLVPEmQQJrogyBK+euZUPANjJZI/IjIk=;
        b=b1nnKXDmMLG95KDdf05pGtNLCDPhx1512Bg2o7GAr3reEiNIL66Ntdc+6+mEJqz/cB
         7puyOZma33lafvnnRnkEwx+tPTSeHt0tNTSUrHgh6KBuWk1hYuGZprErnCn1355tG4Ay
         X2gspWnLaHViYA/ORB2lEPBfZhcmv6LLF6V+NeHMIpUoMNwUcmjfrr/HG9NAvP65nLA1
         ZM2lPXj/9iUe1zuUvh4TZcX94a6rVqfvQf5cQrxlHJM9UPxmccR4XjvewHz62cLIuV4c
         CHRaNDdqX0uMFWmsdPPbyALLTkhBHMveMVY9u490STiiTEhcZq+cS9t8ziUie3GjjQg/
         PSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694417331; x=1695022131;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2ERWb9EP2wbLVPEmQQJrogyBK+euZUPANjJZI/IjIk=;
        b=mURT/nKklkjhJtIhfovKFaL4j3yGcQ/sJdfm5bCy8ZLnyVXxNxn3IpBDvfJdsE61Fq
         jeCZozwyTogPrzRex0j7d5gITM5UuKnqh35eUydqrUJSwapssiubZNr/qQ6XQVjOl3mX
         MeDjjfdXggN0M0kcwcsYto4yLzK/Oec4h5IQcwusK9U6Y3oRSMDOskrza9XulSzBunL/
         +Jk9PG/ukoFQUqzj7WFN9EL1f1CV1Tl8PCLdbQJuQRJuTn6JmD4/gpEl6hOOYVyCKXgI
         3kiGw7U1DscN/2S+N2I7joRmBBiZyokeQ26pYSrRRARiq2Tiy9HSjepZCpFHnJpbDQFm
         LWHA==
X-Gm-Message-State: AOJu0YwXH/aXjeR68gGl8J0hhUqCsptXU5FnqFl2u4lzr+EfsbQtJRs4
        gpf/nWl0tjkIU9FddSMapsz5fg==
X-Google-Smtp-Source: AGHT+IEDXyRveRYDT8DWyZrzv+jc25qYJbZxtmrgzcoHngd66DHeaSr99XU9qrRdI0C0KSARbPGaow==
X-Received: by 2002:a5d:5103:0:b0:319:731f:748c with SMTP id s3-20020a5d5103000000b00319731f748cmr7222888wrt.34.1694417331293;
        Mon, 11 Sep 2023 00:28:51 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id c17-20020adfed91000000b0031779a6b451sm9250075wro.83.2023.09.11.00.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 00:28:50 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 11 Sep 2023 09:28:47 +0200
Subject: [PATCH v4 2/2] arm64: dts: qcom: sm8550-qrd: add bluetooth support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-topic-sm8550-upstream-bt-v4-2-a5a428c77418@linaro.org>
References: <20230911-topic-sm8550-upstream-bt-v4-0-a5a428c77418@linaro.org>
In-Reply-To: <20230911-topic-sm8550-upstream-bt-v4-0-a5a428c77418@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1993;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ry788gkwGyMiucuT9UDQVWPWstQIHueAK1m9wMljm1o=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBk/sGvC4CADHe3m/AYFjlwujZVWROkmob76NT7SCEc
 QWwZUDyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZP7BrwAKCRB33NvayMhJ0Y+AD/
 9cRhy01hAqGDrbGBY2f/9f/nbv9qAVAODSwCL59hy+9Fs+xgzd8PxhSo7BPz4XjuoFbrWJGjGiBAbS
 xjDMv520nUpAM/F/PT93ewCCDMrx9mS/j1Gb/aXKi/jOZVkxTTEvygln48n0I2pQawbZDDutCzgfob
 DPIj+rbfVLYP0eMB5Ik/OFBtRpJ5IcMKpqNVS4bKJRBT3GCVwDhIqfFAlWvhgPe7ikat97JmVbGxcb
 6CV2xpySToO5xghJ+r8+fbhNbxAQKg4pNVJv45ek1Z1H+RcE9qZutv6I9SwRWgOU+C8s/QhNqgSLwi
 Z4hyj7qJtlsQsK4qmt4aRrNfJ6fPpOIxnzN4P0hb58A7hatXPSbWApiiL4ZvIdytb+tuXWhEeyAPaS
 2zUhbnoC81ADuWAJU7aXZCuYkc0+wAUkTBu5dKNLxjco23kTc0+llIPQmt6vkpj5f5AdmJtRDRweZw
 0sPYjzcDXwgQT1BgBtjGt7Gbr/Tf9/3d/FgGYs2A8Fi50lGIfDWiLzvKnD75+YYn8OplK8PWmATYlW
 XzhsSOh4bQq+QPx8oJer1b3p6XIka7e8o0GNhPgQRJbzcYVN341zUwTNfflsiUBhUz4MO5ZO9+4bJ6
 x8Cp2B0hb2mLYP1uhlc88C/pD6Unua0wO/UvqvbPq5V/A+BNzhDGpW+Vhmqg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the WCN7850 bluetooth over the UART14 link.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 43 +++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
index 2c09ce8aeafd..a17c9f4f713f 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
@@ -23,6 +23,7 @@ / {
 
 	aliases {
 		serial0 = &uart7;
+		serial1 = &uart14;
 	};
 
 	wcd938x: audio-codec {
@@ -765,6 +766,10 @@ &qupv3_id_0 {
 	status = "okay";
 };
 
+&qupv3_id_1 {
+	status = "okay";
+};
+
 &remoteproc_adsp {
 	firmware-name = "qcom/sm8550/adsp.mbn",
 			"qcom/sm8550/adsp_dtb.mbn";
@@ -842,6 +847,21 @@ wcd_tx: codec@0,3 {
 &tlmm {
 	gpio-reserved-ranges = <32 8>;
 
+	bt_default: bt-default-state {
+		bt-en-pins {
+			pins = "gpio81";
+			function = "gpio";
+			drive-strength = <16>;
+			bias-disable;
+		};
+
+		sw-ctrl-pins {
+			pins = "gpio82";
+			function = "gpio";
+			bias-pull-down;
+		};
+	};
+
 	sde_dsi_active: sde-dsi-active-state {
 		pins = "gpio133";
 		function = "gpio";
@@ -883,6 +903,29 @@ &uart7 {
 	status = "okay";
 };
 
+&uart14 {
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,wcn7850-bt";
+
+		vddio-supply = <&vreg_l15b_1p8>;
+		vddaon-supply = <&vreg_s4e_0p95>;
+		vdddig-supply = <&vreg_s4e_0p95>;
+		vddrfa0p8-supply = <&vreg_s4e_0p95>;
+		vddrfa1p2-supply = <&vreg_s4g_1p25>;
+		vddrfa1p9-supply = <&vreg_s6g_1p86>;
+
+		max-speed = <3200000>;
+
+		enable-gpios = <&tlmm 81 GPIO_ACTIVE_HIGH>;
+		swctrl-gpios = <&tlmm 82 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-0 = <&bt_default>;
+		pinctrl-names = "default";
+	};
+};
+
 &ufs_mem_hc {
 	reset-gpios = <&tlmm 210 GPIO_ACTIVE_LOW>;
 	vcc-supply = <&vreg_l17b_2p5>;

-- 
2.34.1

