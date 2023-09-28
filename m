Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A993C7B16F0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjI1JOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjI1JO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:14:28 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE4CB7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:14:25 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c3cbfa40d6so114215515ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695892465; x=1696497265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RDsOoxZ8MQollE3UstUsPbUGe0Wmv32bkmPy0XYkX1g=;
        b=AtuFDw0AyYYcFzp7/cVk12RVv8+z2CE204roFHp3fgweqEyQMnqBk+bWrAZUaGmrDu
         Mg7I31CNnCybXBC5ZWXqdXGrw6CnCiN+Qiv1pEOAO9iZ9+n+iKwVO0/HoXHXR3mx/TiQ
         UwFBFtRvbsVoHzvj1nwOvXw79LhEUKcTncJ1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695892465; x=1696497265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RDsOoxZ8MQollE3UstUsPbUGe0Wmv32bkmPy0XYkX1g=;
        b=xSG/F0EgZSqJen4WftFb5vcWn7w6uRqmYzI73KY1AzG7ox8rsn4QP33Qjqcj9ihTZa
         sY/wLANzWx2TIF+gpFgaFARBMLJGNeGbV/aNQPUsAp+QZzg++HUHkzwSqHitJK4pl6pL
         7M2T7A2sJ7p/RQksievJ+v1tkqTc9uxOHYRdQkcUNSaP7SHl6d8r292SIMNTc08RvsYH
         hauNRot0MJmLVOL7Lw1Gh7ZTtvrH6enHUR0b8uaGGC4Mf6KRhkMI4wWc2LDEDQpQU6UX
         +mRDTho4HgPwzFRPOZWS19D9jgloaGwbOLdmPYxxudP5L13LQsY3OSyjG5I6+GgzvLvH
         WtKQ==
X-Gm-Message-State: AOJu0YxJgh8rvvkhwiNJ5uNhB1gAe5ZrR2K9FVlfiqEhbD1QIVi5Yt+F
        UFpUI1nfpENZ+p4BvZiORLp1iQ==
X-Google-Smtp-Source: AGHT+IGQLfQRO6gsAzpjJmhD3uDDJT6i1ivhb4wH5aRbZWrFU6QJUjUC4b4MjjaW5/BQCerEX2AaEw==
X-Received: by 2002:a17:902:8649:b0:1bb:9c45:130f with SMTP id y9-20020a170902864900b001bb9c45130fmr511604plt.69.1695892464799;
        Thu, 28 Sep 2023 02:14:24 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:6747:c12a:dbfd:2cc7])
        by smtp.gmail.com with ESMTPSA id f8-20020a170902860800b001bdb8c0b578sm8488024plo.192.2023.09.28.02.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 02:14:24 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH] arm64: dts: mt6358: Drop bogus "regulator-fixed" compatible properties
Date:   Thu, 28 Sep 2023 17:14:11 +0800
Message-ID: <20230928091415.3253698-1-wenst@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
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
2.42.0.582.g8ccd20d70d-goog

