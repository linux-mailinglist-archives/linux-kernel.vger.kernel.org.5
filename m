Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819387E0C57
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 00:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjKCXgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 19:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbjKCXgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 19:36:00 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460AF10C3
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 16:35:56 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-5845213c583so1260079eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 16:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699054555; x=1699659355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wiEUlSSWbK5aXGpKKuCRTpJDpYU9/xeKROGc7SoElvk=;
        b=B6/ey8VjF83LjlQVn34uVtjab9DcyPqw+TxXsNumuvLMj+ub2Oz7xj2qz9YMX8vh5G
         59ua6kgBjCNy/uFUnRQD7XNnaJArAghsaCJ9KX5cc+2OaSu/BgqttgbM6dFIs5rxmPHK
         5qpg5SQbnH3gDMw1snuT1gZ5wVRjDX8NLcRH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699054555; x=1699659355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wiEUlSSWbK5aXGpKKuCRTpJDpYU9/xeKROGc7SoElvk=;
        b=jOOwJ1lsw2e9L2d9PFbrl4YhTeC/hoAPhTFbOB9PnUDZYqCajIU4F50nsY8bOgz9QL
         TzcWSTDOBV0SdNcJv5I14UlIPukZXv0M7YH6tQmVFBivBSee8snYlPcVdNHy3EDl8QX2
         A9vXFts0UZon8YBBjShYR1IPOmh5O2BoGchOUYtVg8Ouil1FMIP4Pw6UAkKzDxsYZBxV
         o+R6R3kCsereLJGnZ09L3gcwu4PULLDBYkI4IJExCcuPCRFS2f1ar9/gpRsJg5jcs6kz
         qeEww6nndj52qD5s6/lX6fJx7+Ux+1ekBB5cK+yLws6epZZPX45uLEupNGZYODncXaP5
         oWXw==
X-Gm-Message-State: AOJu0Yy7OAizk8kXVfcHZyVzVFklLl7YbPpOnYn+bFe+5d+lXGZ7lIuo
        Ew4lDoBx0nWVyGA/QEQVF0JTcg==
X-Google-Smtp-Source: AGHT+IGNXKE0Eqvr+nKt0x8vTGl4sK2fVjOqSWGGsG2ZJ//eLO5dLTdecPHWuOKBgiXWqY2m5Ti8SA==
X-Received: by 2002:a05:6358:e49f:b0:169:8140:adc1 with SMTP id by31-20020a056358e49f00b001698140adc1mr18817714rwb.7.1699054555121;
        Fri, 03 Nov 2023 16:35:55 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:5195:5e72:f5bb:e3f0])
        by smtp.gmail.com with ESMTPSA id jg5-20020a17090326c500b001b8b2a6c4a4sm1878114plb.172.2023.11.03.16.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 16:35:54 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        swboyd@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] arm64: dts: qcom: sa8775p: Make watchdog bark interrupt edge triggered
Date:   Fri,  3 Nov 2023 16:34:32 -0700
Message-ID: <20231103163434.6.I909b7c4453d7b7fb0db4b6e49aa21666279d827d@changeid>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231103163434.1.Ic7577567baff921347d423b722de8b857602efb1@changeid>
References: <20231103163434.1.Ic7577567baff921347d423b722de8b857602efb1@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described in the patch ("arm64: dts: qcom: sc7180: Make watchdog
bark interrupt edge triggered"), the Qualcomm watchdog timer's bark
interrupt should be configured as edge triggered. Make the change.

Fixes: 09b701b89a76 ("arm64: dts: qcom: sa8775p: add the watchdog node")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 13dd44dd9ed1..6b92f9083104 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -2235,7 +2235,7 @@ watchdog@17c10000 {
 			compatible = "qcom,apss-wdt-sa8775p", "qcom,kpss-wdt";
 			reg = <0x0 0x17c10000 0x0 0x1000>;
 			clocks = <&sleep_clk>;
-			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_EDGE_RISING>;
 		};
 
 		memtimer: timer@17c20000 {
-- 
2.42.0.869.gea05f2083d-goog

