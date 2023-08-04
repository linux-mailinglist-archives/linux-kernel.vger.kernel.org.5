Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4066B770249
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjHDNum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbjHDNu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:50:26 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EDA1994
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 06:50:23 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe4cdb72b9so1647455e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 06:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691157022; x=1691761822;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ukcL+6odfb1FFYIkWIv0OQk72o2fTIvHxVA78LrZQtE=;
        b=vGda7p81GqHiR+qtqDS8bCRcL7vF/bVymUQAHZpG+53cfIrfPbH7ONrw8Bw5hZSb5J
         n6GDOaAlbnuX9/1Au4Wq1TpJUQs58Y38/MbtZyYgWvPNYN9t6LbnM9QJORPWwpyEc8yi
         UoessiuldhM1j2+6zn2k0ACoqIQlGJcxnY9LJc5nfZ66aVwEhafRyDcReofeLbihNMgO
         4Z9xwi+zFuNltTx5lh7kZiPrbjpRR+WMiK8m/eKinMy1+6mYtkcxmxbkEUGF5hOTrA7f
         dK3hj8+EgyysU2AD3M8kFGr5msyCOWbtzunQAIdl5PsyE613OHxqtfoN5ArWTTNdj1yP
         U8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691157022; x=1691761822;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukcL+6odfb1FFYIkWIv0OQk72o2fTIvHxVA78LrZQtE=;
        b=YPFH60Pk/R+ouK5UFCQL+wk3wHw3Q30DQh7QAyIFsRDiw3zThNj15gmFX2aOyg7aB1
         Z9ohte7Ijcfsc5W9sOpHlC+UzBBem3A0eQLLFBzguudQJeFR0apFVRG/s1xO/H81i5sj
         WsJu9e4ZfpJstr1lr0Dv5MIEJ3D5iY3YQNjV2ymwjpwqkQbmkYpD8SBUww6yqzSv1lrC
         W6s/Wqsr0UCu96BJAKXQh2KAaSdStCXgXHL8t1XpysPfaVb5e+HoQ854jJlTQ1iAVdAx
         n5YWdjAmxImiiAAfGeQxBh6VLK1gb+qlTTqNd9Z5RoZnVoSCGltJU/mmrqwSkW7WDad+
         1F/A==
X-Gm-Message-State: AOJu0Yyd34iYOcKDVIr83Pb92fGrqKKHnkLg3KMmYIMIIAuptkAOl/jQ
        c2PRg5Ej1AyIqpeBTcF2LwzBaA==
X-Google-Smtp-Source: AGHT+IHqV+Yo5HvNtyM7QPTWXzBAXAWYv24S6GAlI+HjEhfCLaYShG+3Rjjv5X3ZB/nwbzzEzY3Dwg==
X-Received: by 2002:a05:600c:2255:b0:3fb:b008:1ff6 with SMTP id a21-20020a05600c225500b003fbb0081ff6mr1611819wmm.0.1691157022052;
        Fri, 04 Aug 2023 06:50:22 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id u25-20020a7bcb19000000b003fe1cac37d8sm6894793wmj.11.2023.08.04.06.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 06:50:21 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 04 Aug 2023 15:50:10 +0200
Subject: [PATCH 4/4] arm64: dts: qcom: sm8550-qrd: add orientation gpio
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230804-topic-sm8550-upstream-type-c-orientation-v1-4-36dd3edec7bf@linaro.org>
References: <20230804-topic-sm8550-upstream-type-c-orientation-v1-0-36dd3edec7bf@linaro.org>
In-Reply-To: <20230804-topic-sm8550-upstream-type-c-orientation-v1-0-36dd3edec7bf@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=699;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=PgRVPE+sttPCsO3i6Si4QDJqPDiuAM0EzLTcJZd3VKY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkzQIYYmczdV+OIzmHi1D8WSPn1fn/O3VPLkAQcZtm
 FYFCwe2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZM0CGAAKCRB33NvayMhJ0R03EA
 CDre8ntJmi2BpNmhQ+svCFicfZVV/zzlmR3t1hUBND1kN6Ht3bmIZvq4LGTR/bq7JXLVP2ef9Pc3Rb
 ISqqu0DvqKs5Zxj/U9NcMRt1ZWh2YsKvhzx/FtgaU3ysRvkGL1wykhN9mVxCCEm/7nY327TLfWDY8y
 oym2IPMNoz/6RWAwbfm0UV1WH4UpViXGk9+NoDDiFI4zaHxXRqzFEy74i2wZSlBafP1kt7/bHC8BVD
 7JfLW2XIC1XCmAhTR3dMvxcdh8s1LxOdpDRGqGAnv7ofNu1xYrFnWky60GYhqS1BsTPuM5jEt1y3Ui
 kjkDqbZzQTz/DD+Dcbph0XCc0nyBAf218unohsXmzkKA0sJauo6+d+z70MvO1pxYUC+Uonac8uxTjZ
 gnSSyzaCEE9uSfyDAh2++2wkQu/ozYpB1B8V6wYA6ehAHNLXR7xrYD/cHUwpWSGcAODvOguRlKSQwy
 /kMSeAtXPNwFo0iIVIPyv0bNB2gwCc2KWXA5guFDDhE8x7QyM/rYfkIJd1n/oWn+hUU1ZqklRLUoIe
 Ms56mvZ2l8q3V0Cdw1j/Hb5WtM4OtUpcblAfBuFigNCOHnnWaF1K2XBEGPG4fvg/WB6//NOF8PlTJC
 PCcOL1f2zxN4ASWP8gk8kA7B0ZjDPBm/yVIr0BMHrpG63HH3cI05Ak7MhSgQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specify orientation GPIO to the PMIC GLINK node.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
index 2c09ce8aeafd..950dfbf73410 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
@@ -75,6 +75,7 @@ pmic-glink {
 		compatible = "qcom,sm8550-pmic-glink", "qcom,pmic-glink";
 		#address-cells = <1>;
 		#size-cells = <0>;
+		orientation-gpios = <&tlmm 11 GPIO_ACTIVE_HIGH>;
 
 		connector@0 {
 			compatible = "usb-c-connector";

-- 
2.34.1

