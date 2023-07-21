Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C0975C1B6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjGUIaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjGUI3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:29:54 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EB72D5E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:29:45 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-668704a5b5bso1502886b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689928185; x=1690532985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRGfxOjw0IcbmsCMV0/zHA7oWZTkNo2dmmtwCT8Vhjs=;
        b=WJ4fIxCIWwC/w03SXcaamhybV8KieQrq3hsGKL/F/+7w4K8NCozTrbzUfpfp0RODO6
         GUQbX5KhU1Hb6n2eh9LjMA6geGDTaATIpyKkAJ72G9tgrb+CmefEgSN/SzZKK6Q4oV2s
         q1W2mQk46S42zFNJkJIMM0CJHiV+9UEsIWNVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689928185; x=1690532985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRGfxOjw0IcbmsCMV0/zHA7oWZTkNo2dmmtwCT8Vhjs=;
        b=TInCgZD09Xwctu2ua3UeZ4NqV5iWW9Xet60o2OkbSpUx/VB2l+fGSyM1cROQLhEQle
         kTVwTntxf3EBKEim6797HqU8HQoGd53XYOODmEt2cMiTa/sUrjROWeMip4EyvSUJkJuG
         +aUDu2mS8hpCBdz0tyzqZzkJMQq3yJDkvlx1gpfYkbCjMEwRmV8KsiOmPhmJou/+zZZl
         z9PFhWG/mvwxyp+X7lECqvU4uiy9Fbbx944JL/LC4JXc1nl1cvmkhptbT91ThSwKi0Rp
         WbC+iKtQEykbQ4quJABUfAjQ9nU8xK+gNJSivbzqYgBnGbf7GYp8yjmeEWT20xd39etv
         oAgg==
X-Gm-Message-State: ABy/qLaJ4eI4PGfHIbaSUoNe5oF9ERKECJFJDWyzxI/TL2MCdnIbXUfq
        8k4Q3kwcKobFO6g7uwO5hFs01g==
X-Google-Smtp-Source: APBJJlEiBPi4j0WNe6cfbaLSyqDT+I6QoNb2wwHokr09zqnos1uSYq2GIuMgmtG+1rdaBUooxk2BfA==
X-Received: by 2002:a05:6a20:2446:b0:12f:a373:ba8d with SMTP id t6-20020a056a20244600b0012fa373ba8dmr1552049pzc.24.1689928185246;
        Fri, 21 Jul 2023 01:29:45 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:6d86:d21:714:abab])
        by smtp.gmail.com with ESMTPSA id d26-20020a63991a000000b0055fe64fd3f4sm2594382pge.9.2023.07.21.01.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 01:29:44 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2 7/7] arm64: dts: mediatek: mt6358: Merge ldo_vcn33_* regulators
Date:   Fri, 21 Jul 2023 16:28:59 +0800
Message-ID: <20230721082903.2038975-8-wenst@chromium.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230721082903.2038975-1-wenst@chromium.org>
References: <20230721082903.2038975-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ldo_vcn33_bt and ldo_vcn33_wifi regulators are actually the same
regulator, having the same voltage setting and output pin. There are
simply two enable bits that are ORed together to enable the regulator.

Having two regulators representing the same output pin is misleading
from a design matching standpoint, and also error-prone in driver
implementations.

Now that the bindings have these two merged, merge them in the device
tree as well. Neither vcn33 regulators are referenced in upstream
device trees. As far as hardware designs go, none of the Chromebooks
using MT8183 w/ MT6358 use this output.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt6358.dtsi | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt6358.dtsi b/arch/arm64/boot/dts/mediatek/mt6358.dtsi
index b605313bed99..186898f9384b 100644
--- a/arch/arm64/boot/dts/mediatek/mt6358.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6358.dtsi
@@ -304,15 +304,8 @@ mt6358_vrf18_reg: ldo_vrf18 {
 				regulator-enable-ramp-delay = <120>;
 			};
 
-			mt6358_vcn33_bt_reg: ldo_vcn33_bt {
-				regulator-name = "vcn33_bt";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3500000>;
-				regulator-enable-ramp-delay = <270>;
-			};
-
-			mt6358_vcn33_wifi_reg: ldo_vcn33_wifi {
-				regulator-name = "vcn33_wifi";
+			mt6358_vcn33_reg: ldo_vcn33 {
+				regulator-name = "vcn33";
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3500000>;
 				regulator-enable-ramp-delay = <270>;
-- 
2.41.0.487.g6d72f3e995-goog

