Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696CD7AFFCE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjI0JWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjI0JV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:21:58 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31233B3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 02:21:56 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9b2a3fd5764so399462066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 02:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695806515; x=1696411315; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TWm1kTvALKqdp6UrH/Oz1h9cS//ES9dxbJ1u6BdZbf0=;
        b=aYm77+pgt9sRW24bzYX6DSPiLTVr/ZKs3rbG1pFv3rcr0Kqu5LnPgjynRKQ338EK07
         M2hq85dZ5sqkyrz7wzm6t5O671jtdNHOR/SB1A6to46YHNLSg/uj/hJv307bkdlDeWog
         apPoaresBhc2zcDOHpbjnBNj04pZyyoaLRKgNriov9m2g3Z/6ulxDk5+Zv05JljRWm90
         +cJplgYhuDrEMKzeYlZhV6S2aNGd03ZVII14GSBgVGH1PclA+xpYi9/R/7QPG80/7vzp
         xRdUsn4bWQPS5oVVNiYlpdf/So0s94RW3sU/5rJU2mX4VO0wVkVz2sy+aRtjwpUHSXDf
         4R1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695806515; x=1696411315;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWm1kTvALKqdp6UrH/Oz1h9cS//ES9dxbJ1u6BdZbf0=;
        b=P+E9XC6tPEmd5/CVhGLAXH8obJaU4GIPNoRD1rkXBSiwqUaKAYu0JIQ6FptuSy+Ex9
         jv1p9RwZBZEnY4uwQV2V8VGUK4+tvp5f+yRWHDfxLj15PigTi6e3RUEynL3F64u8al7o
         B2Uz1euCnzqU2e2KYtldL0KSjTxcFl+92x9DDYaTRt24yk0h3khGsv/VriTcyxFG7ksh
         dD0aupYC5hZ4g/7v0cZbiPqLpnw3ZaTMuTzRqswj9Mz/5S/DLMU2Y1hFBbrVOwQes/eS
         pWWV30WvA4TaLkIA8Gif5gRn7L1CxCkIIB4z70mfG637VwcO42io2P4f1ktmnvsYxFV1
         Fdww==
X-Gm-Message-State: AOJu0YxHxfwGJi2WgRNiccD2x9bLorKzrMvh/uNzjpqQBn20mlL0g47/
        sRNbvkVsxLdBWhFyBxRYoIEu7g==
X-Google-Smtp-Source: AGHT+IGuhunRQjEcowCkdHaMAAcBPnbycL1eQFuP09gaEtEPVWkMveTm1Vx4nab6bUsiXM7tdLsg7A==
X-Received: by 2002:a17:907:25ca:b0:9ae:3a60:570a with SMTP id ae10-20020a17090725ca00b009ae3a60570amr1474637ejc.18.1695806515299;
        Wed, 27 Sep 2023 02:21:55 -0700 (PDT)
Received: from [10.167.154.1] (178235177023.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.23])
        by smtp.gmail.com with ESMTPSA id qq23-20020a17090720d700b00993664a9987sm8948574ejb.103.2023.09.27.02.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 02:21:55 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 27 Sep 2023 11:21:43 +0200
Subject: [PATCH 4/4] arm64: dts: qcom: sm6375-pdx225: Add USBPHY regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230927-topic-6375_stuff-v1-4-12243e36b45c@linaro.org>
References: <20230927-topic-6375_stuff-v1-0-12243e36b45c@linaro.org>
In-Reply-To: <20230927-topic-6375_stuff-v1-0-12243e36b45c@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695806508; l=1124;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=kfCuRxKJPakhy+dYlGoAXo1GkhMTh9kKuB4nSV7OqPc=;
 b=FuuOXXR8da7l+sqQespL/53ZTFiJLfX0apJEbsmRKQvBt3KRNjOex63DWBneGsx5rHUmRe2w0
 HzhTEyMSqe9AnEsXtuECV+oBhyDJ0y7j7aI491pxM6ZHl0ZxXbZgERg
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

To make dtbs_check happy and the software more aware of what's going
on, describe the HSUSB PHY's regulators and tighten up VDDA_PLL to match.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
index bbec7aee60be..0ce4fa8de8b0 100644
--- a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
+++ b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
@@ -243,8 +243,8 @@ pm6125_l6: l6 {
 		};
 
 		pm6125_l7: l7 {
-			regulator-min-microvolt = <720000>;
-			regulator-max-microvolt = <1050000>;
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <880000>;
 		};
 
 		pm6125_l8: l8 {
@@ -430,6 +430,9 @@ &usb_1_dwc3 {
 };
 
 &usb_1_hsphy {
+	vdda-pll-supply = <&pm6125_l7>;
+	vdda18-supply = <&pm6125_l10>;
+	vdda33-supply = <&pmr735a_l7>;
 	status = "okay";
 };
 

-- 
2.42.0

