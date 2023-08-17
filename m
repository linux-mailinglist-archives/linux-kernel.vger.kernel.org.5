Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEEF77F26C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349095AbjHQIri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349126AbjHQIrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:47:20 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FAD2D54
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:47:18 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9db1de50cso112258601fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692262036; x=1692866836;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SXF4axVpfnQZc7HkPv4M23jcSW6Nad8x6FO/hELVXtk=;
        b=KeIwL005L17wegB+Rg1vq36NSvJ6orUxFS95TrJKtFt0WopjBMrkC2I9ew/rEi7E1I
         IbpYd8g8w51ay3on0+Ph5E/y4Wx7qWrEldrKjVvtDI6A+Q7K966co2Z/VWVPipN0TE1j
         7Dm5yu0cFvKEPz69yC7JoZgxj7DXJx1zBkDQvjHmVRJTgW+pZMBWBRAVfEPKYe/Lu1RU
         SxDj299nvRwZToxlg3MkNk1eqLWefvUmGjSkM9mEh0paGpnbOxgRLF2bFLf0N6jHTBES
         NN0otveHFhX5FrgPp5TDiFn8r7/NQrJVkO5BMK9WwWySTU+ZykgDMniRbhrOrqtWMvMZ
         nXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692262036; x=1692866836;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXF4axVpfnQZc7HkPv4M23jcSW6Nad8x6FO/hELVXtk=;
        b=eBpp8aqC5zL7vEyECCPAf6MJevgGqTQS5Bl7CZuTPS6wXdNoY6qNOJRVDkZkciFlw0
         e41Hsy81piJ7AWeylw87rrj5pGoqQnl5h2gl9czTZ78Por/EYJ6t9Uyi2ag+7vRx5r4A
         f0KQE0inc80ZtlIh3YFx3u1eQJMp2bmEJKFYUXcmjUVi1xGhvCLr3nucdgTBWK11dQTZ
         XbHXuUBVQGPx4Gyzx3y0tav76jKayjyfDbqaTV1ReKaySTqa1Qe2XFKoXZaU4WtDnXvU
         ytTSp8EtNTw53Cd+9rsN6Eb0B6TDCQqj3gcLXmEVHBVAJLUS9YNMmDIu+dgnROojrR5w
         otNA==
X-Gm-Message-State: AOJu0YxJdKGfgHjSany8gpRqbhCtyyHpi4Hh9fMRyzJA0wo0iA0Xtln3
        DYSMGr3OC7M1w72hwRmNd93ItrUfktU+W+wBN7vUBQ==
X-Google-Smtp-Source: AGHT+IGUj/Sv4paGAaaX/Q/Q7T03J3gNmD7uJDqF9K5ZNUJ4tATH1mj/PmpsxJmzY/OMsosj/MzEtw==
X-Received: by 2002:a2e:b0f3:0:b0:2b9:da28:c50b with SMTP id h19-20020a2eb0f3000000b002b9da28c50bmr3225704ljl.16.1692262036566;
        Thu, 17 Aug 2023 01:47:16 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id m9-20020a05600c280900b003fe539b83f2sm2117285wmb.42.2023.08.17.01.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 01:47:16 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 17 Aug 2023 10:47:07 +0200
Subject: [PATCH v3 2/2] arm64: dts: qcom: sm8550-qrd: add bluetooth support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230817-topic-sm8550-upstream-bt-v3-2-33f386e7b461@linaro.org>
References: <20230817-topic-sm8550-upstream-bt-v3-0-33f386e7b461@linaro.org>
In-Reply-To: <20230817-topic-sm8550-upstream-bt-v3-0-33f386e7b461@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1926;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=D7aZpsjhqSnrGCoPxr9KqIQ7RDCz7MWCm6a1lxWx+G8=;
 b=owEBbAKT/ZANAwAKAXfc29rIyEnRAcsmYgBk3d6Rsd8ebRrEgKtaCrex40rwVc3bUy0nhP687qtd
 vuul2RWJAjIEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZN3ekQAKCRB33NvayMhJ0ZijD/
 Ys94Bicb0tFRMwM26BCYz+CWFe8dlaNeiaMRvWNYE6DKuxuL5w2iQF6uoOcmvR6dL3TdBgIInxU405
 Iqhw8EZVUta7/LewC61vkiaDyIDTviaF9OiWMMLpdy9UAAR8Z+lGg8f+atIce1fQZGURRvr7tTXQUH
 mPNpROztR2ovjWrxFBdOqpnL592qGJzNuxnCTphj1ckmSBa+/kEIKI6m4harOIU0XhG2Bo74z70FQB
 4WOXrdhz9tb0oKKbd8Uzcnd2nKPEblnip6n7fdhAuYMsTZkxQivF9qER2IFVajMfvjdfMqn/0PBOdp
 WzJiCpU1OZWZKIirY1kQO9pA9IuH9392GtM6hYpeng87JvI8co2tnkiyZM0RQMYG1onjSoRuQXkGWC
 s1NYY6A9RsL/5ExaORMs/XTFTg+alV6FafK98pIzYTFyWZ3ddxs0pgLpQne1d9U7+QM+WN0Whkp1As
 cP2bou1wgiqAnHU2prdkz5hm79/f8G3Co10ha7BBX+xDxgia3UJWPpdI2hctZpgxqpZCcex+1QgshK
 KUQLXCQQzFdg/uH6ONq1qGJ79PYhXe7c1nvlliFn+6bD+x+OOhed3C229UTMgWISpiAh5LBf3/1IpV
 dCrAPFoEbIS1R0A4zieM65pbeVdaBxp2agT+DirVl8jfvP7XizS9EzgzoA
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

