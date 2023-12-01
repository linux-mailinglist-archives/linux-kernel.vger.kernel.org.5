Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0F8800C93
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 14:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379067AbjLANuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 08:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379066AbjLANuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 08:50:46 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3441700
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 05:50:51 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40b27726369so20520445e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 05:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701438650; x=1702043450; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=imJHbpmpHY3lf2HGbu59sinv7Vyx+tVX/+ka8ggTt3w=;
        b=lIYhwuqHhy4lM4pLaug/o4gq0SROltztZHZbcbsj3GvX7+eS4WA/vkfhkG1CZ7WUJ/
         oAu/4xR9oSRTZsqYMYTRQ5756DbrPcoQtx0Hmiau0MLrhNnXFEzHsxAhMxtqNSDD/pgv
         N5SuMyLK1O647aXfjvOiWCvVkspCPHeWKGZCiNY+dGVVD+28Zpnj9N5MumGL/G8R5lny
         U9k1kmxf6wi+JxYGRYc2Z4EvzhH9Uhh86QGrA5eKeiEDAgR7DF50GQK/duNTlqMUcesd
         4hiUZ04StkkgnvOrYnMdBc3bSIl+B3MKoiWnLW93OT4e4WJ2fAI+ncstHaHfGQpnUy9H
         AroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701438650; x=1702043450;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imJHbpmpHY3lf2HGbu59sinv7Vyx+tVX/+ka8ggTt3w=;
        b=D9pwBnUaLShNdVd6oh4Kag1j6BB1XlOYq/HRtNdukVqc1wkNGaG9fds8QdQHn+hwY8
         i0xQSAMXLpmNXPdA9c7QtjQCq7ulfkta5SkjF40xbcYGJSfKOUGo6h+JRNbqGlF+EIML
         zNEteSLuFodGtEGloDPR40cLjYmPhhdpOmgXkgaB6G96mPwlGua6nSRxRBBtTH/X0fDs
         R1mOyMsNJAKWEXGC6LCLofZaAxbj3cxdeS3aHOSW761Fn0RyAM6CSuJBrvNmITXnpFt2
         8SCCl3bkxnSck4T7fM0Iy7s49zTa7Ok5eHHvYCppWls9w1VyWqUa+RkhLO30PVckMEAQ
         jxtg==
X-Gm-Message-State: AOJu0Yy9uZ2OG3dUAT+Kc36syvg5+eBQLv4x/2wKBzX3ETsvzQNfPdwu
        FgzqUH6rAV4A5T07VmML8qA7RQ==
X-Google-Smtp-Source: AGHT+IEkg0ZFPXx0Eods1z6IJk2FLNB94rGE+9E2agLMYm58uuLqxXcavq5Jwr1g0gswx6fiRirHyg==
X-Received: by 2002:a05:600c:5129:b0:407:7ea1:e9a4 with SMTP id o41-20020a05600c512900b004077ea1e9a4mr417596wms.5.1701438649582;
        Fri, 01 Dec 2023 05:50:49 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id s8-20020a05600c45c800b00405c7591b09sm5539942wmo.35.2023.12.01.05.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 05:50:49 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 01 Dec 2023 14:50:42 +0100
Subject: [PATCH 2/2] arm64: dts: qcom: sm8650-qrd: enable IPA
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231201-topic-sm8650-upstream-ipa-v1-2-7e8cf7200cd2@linaro.org>
References: <20231201-topic-sm8650-upstream-ipa-v1-0-7e8cf7200cd2@linaro.org>
In-Reply-To: <20231201-topic-sm8650-upstream-ipa-v1-0-7e8cf7200cd2@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Alex Elder <elder@linaro.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=733;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=SO5EMPj5/4o5z1qixmP8r0h1as0YkIYfBDEdRiT4avc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlaeS2L0/ufnYtbrqHX19JToqOQlT0/ABu76Q3Poux
 rdLZ//iJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZWnktgAKCRB33NvayMhJ0VxaD/
 9TtFzJYHvVHWCl1or/AgZW5fHbryWqzg+TgkVYO1tthLoCMV9hxWJT+ndKEW8xwf6HpdnC3DK7G/Cm
 bSQEmrN1ElIAGYYQo8iytbDRXADUbyV2aEi6B+xf6eGf9XpuTkrAfTzGfJCWWPQF8V4W5uino3UYEq
 hM5hFwninBNa9lM5P48vNsOWvRqmxpR4yR6u6jU13+souV8+YfNC6xnAxjiYjZPOFvUCrMg1BO1T+t
 FGt97mKWL2AgGmf0fEyMxada0aB9OzFtzDHW1c6PkRI0ZbTj1bgpu5RLb7q/NGABQ0tRUnxFChijjK
 iH9Zr3lWusYNJk/eZDSbYDkshtiRXYE1hUlr4HndrNUsFwnnrcPidv1jjdZo7MrulySR+eu7Wp4VdX
 dFUYfovIimhZlj1EEn98xxjHA1Ckhqyd3qIwGLVXSonNNfWl+IyPSHoRWrbC4cIHEGFFv1PYs57qrx
 gQgv3vB6gtpSD7AdpMZzQtFAQ6G8obNBb0ncIvbOoJRTl3H/zcpam3knWHv0h03F4/5/TsvWG3rKst
 Hq5yhouOPVhei9mT9f8X5c4/+pwMvBq/iaxkrGeLtnV3omVqXS68GjSd6JzsK1me8g9KkUnE11nL2U
 61lrHX+z86pnYQA/NkbYKwdaqOaZaRlR6fJmxTBIIO6Hs3ZvQL5JGrEI5psQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable IPA on the SM8650 QRD.  The GSI firmware on this platform is
loaded by the AP.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
index e69ae61b6111..592a67a47c78 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
@@ -446,6 +446,13 @@ &gpi_dma1 {
 	status = "okay";
 };
 
+&ipa {
+	qcom,gsi-loader = "self";
+	memory-region = <&ipa_fw_mem>;
+	firmware-name = "qcom/sm8650/ipa_fws.mbn";
+	status = "okay";
+};
+
 &mdss {
 	status = "okay";
 };

-- 
2.34.1

