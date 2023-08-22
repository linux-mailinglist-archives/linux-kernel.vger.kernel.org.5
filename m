Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0125E783C14
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbjHVIqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbjHVIqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:46:23 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1DEE58
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:45:59 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68a410316a2so1325137b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692693958; x=1693298758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlF1u7hcM0QcOf0dBRcVX4obCkl3j7F2WIt5v6FZgoU=;
        b=mhxuhaGqh88+7Ene1JAl6kiwkMKSUNbySevMtCh45aHQzwcstAH3Zxc0tfaKCOyV1g
         ZwwqbRmdYMX9iHwcax5SYaE3jG5u3ApPmK4LhMkh2aWnTo/Z5esP4OgtPTiTgS/X4fM8
         loOv7lDpdU/vDqg55o1JV3nZuZZRDW4GO7AWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692693958; x=1693298758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hlF1u7hcM0QcOf0dBRcVX4obCkl3j7F2WIt5v6FZgoU=;
        b=A3CVa5z8W4sZajVrfHf3XtCWxB15AauwU8AnKfYVUj5ycKWqlBnCAoLOgyBDAM/vNC
         77RtqV7ZEnDJWSfQ3hVhLsLy2iCf6rvKXdlVIjwJksUhasKnu/+yibH5POQylBOoAKrT
         nurxCwVxVJnoHgL6+U4ggiv6RsIrX4omrc/eIy4SjoUxGgUOBbPVKV6DH4+3sF5Bta5m
         cdWRPPqt1DK3UGFZLMQgV7OdQ22mg8cWt59MO9uYRpNf0Ksf3npL9FJaycppsl6WPiZ+
         tlnFRSo6V8yYaHOemO/TSc9wltDQkx48fnlCCvUbhdHrKSse0wi4doSyJWq2aq/QUf6Y
         Szgg==
X-Gm-Message-State: AOJu0YyMXy1Hvbg5Vd8Ak11Yw0hQ/lz9pqKEC9z2vnvoMdIuItXlfbfn
        159wImMdo2Nguu9YuktqSl4KSw==
X-Google-Smtp-Source: AGHT+IHjB5kNMo/7EJRgipMgtPWyKH6stKI6IA+7/JLvg5/DHP/HLoq+swtjIZEl1DUHRTjCliTjJQ==
X-Received: by 2002:a05:6a20:7347:b0:140:6979:2952 with SMTP id v7-20020a056a20734700b0014069792952mr7772550pzc.47.1692693957871;
        Tue, 22 Aug 2023 01:45:57 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:e619:3fa0:1a90:6bb0])
        by smtp.gmail.com with ESMTPSA id s26-20020aa78d5a000000b00666b012baedsm7304790pfe.158.2023.08.22.01.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 01:45:57 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 11/11] arm64: dts: mediatek: mt8183-kukui: Add PMIC regulator supplies
Date:   Tue, 22 Aug 2023 16:45:19 +0800
Message-ID: <20230822084520.564937-12-wenst@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230822084520.564937-1-wenst@chromium.org>
References: <20230822084520.564937-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMIC regulator node is missing regulator supplies. Now that the
binding supports them, add all the power rail supplies. Most of them
are fed from a system-wide semi-regulated power rail. A couple LDOs
are fed from the PMIC's own buck regulator outputs.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index 6ce16a265e05..d48c66cc8c18 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -103,6 +103,14 @@ pp3300_alw: regulator6 {
 		regulator-max-microvolt = <3300000>;
 	};
 
+	/* system wide semi-regulated power rail from charger */
+	reg_vsys: regulator-vsys {
+		compatible = "regulator-fixed";
+		regulator-name = "vsys";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	reserved_memory: reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -404,6 +412,26 @@ &mt6358codec {
 	Avdd-supply = <&mt6358_vaud28_reg>;
 };
 
+&mt6358regulator {
+	vsys-ldo1-supply = <&reg_vsys>;
+	vsys-ldo2-supply = <&reg_vsys>;
+	vsys-ldo3-supply = <&reg_vsys>;
+	vsys-vcore-supply = <&reg_vsys>;
+	vsys-vdram1-supply = <&reg_vsys>;
+	vsys-vgpu-supply = <&reg_vsys>;
+	vsys-vmodem-supply = <&reg_vsys>;
+	vsys-vpa-supply = <&reg_vsys>;
+	vsys-vproc11-supply = <&reg_vsys>;
+	vsys-vproc12-supply = <&reg_vsys>;
+	vsys-vs1-supply = <&reg_vsys>;
+	vsys-vs2-supply = <&reg_vsys>;
+	vs1-ldo1-supply = <&mt6358_vs1_reg>;
+	vs2-ldo1-supply = <&mt6358_vdram1_reg>;
+	vs2-ldo2-supply = <&mt6358_vs2_reg>;
+	vs2-ldo3-supply = <&mt6358_vs2_reg>;
+	vs2-ldo4-supply = <&mt6358_vs2_reg>;
+};
+
 &mt6358_vgpu_reg {
 	regulator-min-microvolt = <625000>;
 	regulator-max-microvolt = <900000>;
-- 
2.42.0.rc1.204.g551eb34607-goog

