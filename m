Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11207FE9E1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 08:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234962AbjK3Hok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 02:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbjK3Hkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 02:40:42 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA77DD66
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 23:40:48 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6cdd9c53282so606024b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 23:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701330048; x=1701934848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IkpXrLW2063q1m94Ct7XMex/vBu1O/g0kp41KKzoVbE=;
        b=kSrfJDXcZgZPd9dhXdowCD0y7Hcm82RjcPf0aeWhlCvwG3mkDCQ0/tXE35oqR9eteM
         aYytM+1yFqlyRlj+zvfjl5+fXBCFeu+nc4waINDp8gN388vY3fwhYm0k2rbQJ/lAkXRE
         DMWt++HMCTGwMuW3vKCQOK9/pKV3pm7l6z6Fo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701330048; x=1701934848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IkpXrLW2063q1m94Ct7XMex/vBu1O/g0kp41KKzoVbE=;
        b=wa1wAGZ1O/TxuFK5ioyj59wom2fjt/B7cw3b7hNAYLwqMzpGezZOwlskJGl4Q+P7ag
         LoMs6HW9lqJn3vOHKg4Us77U7gKZf6X10SkSGrAL2OGdGK+n3FlUOLUDTpal1ZjDl2Pr
         73+OGQp0DHyXZMT4IhcSrd0MohnC2lkmrmZfnitmrTGXSAVcV//RO9XboNni4PZENw7U
         3e0VE2L/02iBAH+KNq6r8U+/k32JV5OnCmHkqTyJeQUhMF3WDUkLNceNy3OfIGo6ZRRe
         dA19XG/bVW598IA8cYc1WPqgITB5C3tTc3eTArXaXtCXw8ED7DRulgrgoGrY1XoKgdGl
         9Vcw==
X-Gm-Message-State: AOJu0YyIovPl1xH3ccdWOYzEeGuSr42wxEoqiqHaBuECQeBaNeFR+HsY
        CS5MLtmWhHz6W+28/Z+ZlwjlTA==
X-Google-Smtp-Source: AGHT+IHBrA2Ajkr3pUowl6+raRAc06e8yaFp0DgaWh6/FLZNLmhoUFHQvZ6F8XtSp7ig/5Si9AoLdw==
X-Received: by 2002:a05:6a00:6c85:b0:6cd:edef:4b02 with SMTP id jc5-20020a056a006c8500b006cdedef4b02mr313263pfb.26.1701330048161;
        Wed, 29 Nov 2023 23:40:48 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:7c8f:dafd:65c3:2bcf])
        by smtp.gmail.com with ESMTPSA id p35-20020a634f63000000b005bd3f34b10dsm612870pgl.24.2023.11.29.23.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 23:40:47 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 2/3] arm64: dts: mt6358: Drop bogus "regulator-fixed" compatible properties
Date:   Thu, 30 Nov 2023 15:40:30 +0800
Message-ID: <20231130074032.913511-3-wenst@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231130074032.913511-1-wenst@chromium.org>
References: <20231130074032.913511-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whether a regulator under the MT6358 PMIC is a fixed regulator or not is
derived from the node name. Compatible string properties are not used.
This causes validation errors after the regulator binding is converted
to DT schema.

Drop the bogus "regulator-fixed" compatible properties from the PMIC's
regulator sub-nodes.

Fixes: 9f8872221674 ("arm64: dts: mt6358: add PMIC MT6358 related nodes")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt6358.dtsi | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt6358.dtsi b/arch/arm64/boot/dts/mediatek/mt6358.dtsi
index 186898f9384b..ad5e4022e06d 100644
--- a/arch/arm64/boot/dts/mediatek/mt6358.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6358.dtsi
@@ -128,7 +128,6 @@ mt6358_vibr_reg: ldo_vibr {
 			};
 
 			mt6358_vrf12_reg: ldo_vrf12 {
-				compatible = "regulator-fixed";
 				regulator-name = "vrf12";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <1200000>;
@@ -136,7 +135,6 @@ mt6358_vrf12_reg: ldo_vrf12 {
 			};
 
 			mt6358_vio18_reg: ldo_vio18 {
-				compatible = "regulator-fixed";
 				regulator-name = "vio18";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
@@ -153,7 +151,6 @@ mt6358_vusb_reg: ldo_vusb {
 			};
 
 			mt6358_vcamio_reg: ldo_vcamio {
-				compatible = "regulator-fixed";
 				regulator-name = "vcamio";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
@@ -168,7 +165,6 @@ mt6358_vcamd_reg: ldo_vcamd {
 			};
 
 			mt6358_vcn18_reg: ldo_vcn18 {
-				compatible = "regulator-fixed";
 				regulator-name = "vcn18";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
@@ -176,7 +172,6 @@ mt6358_vcn18_reg: ldo_vcn18 {
 			};
 
 			mt6358_vfe28_reg: ldo_vfe28 {
-				compatible = "regulator-fixed";
 				regulator-name = "vfe28";
 				regulator-min-microvolt = <2800000>;
 				regulator-max-microvolt = <2800000>;
@@ -193,7 +188,6 @@ mt6358_vsram_proc11_reg: ldo_vsram_proc11 {
 			};
 
 			mt6358_vcn28_reg: ldo_vcn28 {
-				compatible = "regulator-fixed";
 				regulator-name = "vcn28";
 				regulator-min-microvolt = <2800000>;
 				regulator-max-microvolt = <2800000>;
@@ -218,7 +212,6 @@ mt6358_vsram_gpu_reg: ldo_vsram_gpu {
 			};
 
 			mt6358_vxo22_reg: ldo_vxo22 {
-				compatible = "regulator-fixed";
 				regulator-name = "vxo22";
 				regulator-min-microvolt = <2200000>;
 				regulator-max-microvolt = <2200000>;
@@ -234,7 +227,6 @@ mt6358_vefuse_reg: ldo_vefuse {
 			};
 
 			mt6358_vaux18_reg: ldo_vaux18 {
-				compatible = "regulator-fixed";
 				regulator-name = "vaux18";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
@@ -249,7 +241,6 @@ mt6358_vmch_reg: ldo_vmch {
 			};
 
 			mt6358_vbif28_reg: ldo_vbif28 {
-				compatible = "regulator-fixed";
 				regulator-name = "vbif28";
 				regulator-min-microvolt = <2800000>;
 				regulator-max-microvolt = <2800000>;
@@ -280,7 +271,6 @@ mt6358_vemc_reg: ldo_vemc {
 			};
 
 			mt6358_vio28_reg: ldo_vio28 {
-				compatible = "regulator-fixed";
 				regulator-name = "vio28";
 				regulator-min-microvolt = <2800000>;
 				regulator-max-microvolt = <2800000>;
@@ -288,7 +278,6 @@ mt6358_vio28_reg: ldo_vio28 {
 			};
 
 			mt6358_va12_reg: ldo_va12 {
-				compatible = "regulator-fixed";
 				regulator-name = "va12";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <1200000>;
@@ -297,7 +286,6 @@ mt6358_va12_reg: ldo_va12 {
 			};
 
 			mt6358_vrf18_reg: ldo_vrf18 {
-				compatible = "regulator-fixed";
 				regulator-name = "vrf18";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
@@ -333,7 +321,6 @@ mt6358_vldo28_reg: ldo_vldo28 {
 			};
 
 			mt6358_vaud28_reg: ldo_vaud28 {
-				compatible = "regulator-fixed";
 				regulator-name = "vaud28";
 				regulator-min-microvolt = <2800000>;
 				regulator-max-microvolt = <2800000>;
-- 
2.43.0.rc2.451.g8631bc7472-goog

