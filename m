Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CDE786B71
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240648AbjHXJSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240773AbjHXJSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:18:03 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030DA1FCF;
        Thu, 24 Aug 2023 02:17:51 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b974031aeaso100905091fa.0;
        Thu, 24 Aug 2023 02:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692868669; x=1693473469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YF81O8Mt5Rkl/ktMHxmaH5Orh769Q+vqU4LRCHQ3Fk=;
        b=Tl9QPFX515N22m7Ex9VxXevKvDzkiXgnIifitCg2QTSlRwYGArkbdhtNDM4iI+qERo
         WIlZoqN59n6Ek+I7/PnNAVIzl/g1bX5sjzudFTd53frDqiUmFKBcugRQWl3kW0P7izg1
         hz35umFY/iSKQ11pNsuCgVcbOmVbsGHNERMZj4NCeq9EA+PW6bGn8JvVEpk29jUwFIX4
         062AaQnPfchKLeHCHyJOEHFo/NBzxCai8Ii5N3Qe4v+mlIIBoTrURxNfHwxgKvsUT2a7
         XsohmTWyhbu6qwfSqH56XkvH+/SjgPAcd86A+JAHZIZQgP09uxMXo4qY6Ztjy5xeDhYH
         p2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692868669; x=1693473469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7YF81O8Mt5Rkl/ktMHxmaH5Orh769Q+vqU4LRCHQ3Fk=;
        b=ch2euIOT183vnstnqutUtvFDZ9eTo2+/nD5pjgFyCNjr8GQUsX4r4ZwBSTHQG2zb3/
         9GdB6mwoztTnmVt6KJPZlRyvMU3B5kr+R9TES7QPEiGMIgiiY0iEp3b03FxpmKQ3XB3F
         WS7gfDHGxdYyCNcnD9yj0uIln3WIW1YHTAIaIQfPuDKDy0zUkX/JUTWBjhLFfeDQmX2J
         HMNs132DZj1uU9KJUeg6o+MJL03XMQqiClCIrxP5iXBRXcVGUUeWZf0sObnbYoYyOxLA
         fR4LtKvtZSd/jtkmyMVShfLlrot04Skv9kMqDDNo6VgQ5zXuaDqHDxhtZsC9YADmNrPG
         kYRA==
X-Gm-Message-State: AOJu0YwXcFI5/AwCicN9Ck1sGU7AqBONV6ienkgE0yAj6YH4Xs+w9R9/
        LQiY8ePWaBz1g+hgYmifefRiKDiz0K2DjyQx
X-Google-Smtp-Source: AGHT+IFG6SmcW+3MfCa/fHvY4ozWTzo+LKOZsdqqPj8v9sINHle8fvnSkxtu0njV187L2cp+9GYc9Q==
X-Received: by 2002:a2e:9d08:0:b0:2b9:b4eb:c39c with SMTP id t8-20020a2e9d08000000b002b9b4ebc39cmr10679798lji.8.1692868668860;
        Thu, 24 Aug 2023 02:17:48 -0700 (PDT)
Received: from david-ryuzu.fritz.box (ip4d167053.dynamic.kabel-deutschland.de. [77.22.112.83])
        by smtp.googlemail.com with ESMTPSA id k8-20020a7bc408000000b003fe23b10fdfsm2022214wmi.36.2023.08.24.02.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 02:17:48 -0700 (PDT)
From:   David Wronek <davidwronek@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org,
        David Wronek <davidwronek@gmail.com>,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v5 2/4] arm64: dts: qcom: pm6150: Add resin and rtc nodes
Date:   Thu, 24 Aug 2023 11:15:05 +0200
Message-ID: <20230824091737.75813-3-davidwronek@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824091737.75813-1-davidwronek@gmail.com>
References: <20230824091737.75813-1-davidwronek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the RTC which is the same as on other PMICs and add the
resin child node to the PM6150 PON device, both disabled by default.

Signed-off-by: David Wronek <davidwronek@gmail.com>
Tested-by: Nikita Travkin <nikita@trvn.ru>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm6150.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm6150.dtsi b/arch/arm64/boot/dts/qcom/pm6150.dtsi
index 7d4d1f2767ed..ddbaf7280b03 100644
--- a/arch/arm64/boot/dts/qcom/pm6150.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6150.dtsi
@@ -53,6 +53,14 @@ pm6150_pwrkey: pwrkey {
 				bias-pull-up;
 				linux,code = <KEY_POWER>;
 			};
+
+			pm6150_resin: resin {
+				compatible = "qcom,pm8941-resin";
+				interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
+				debounce = <15625>;
+				bias-pull-up;
+				status = "disabled";
+			};
 		};
 
 		pm6150_temp: temp-alarm@2400 {
@@ -88,6 +96,14 @@ pm6150_adc_tm: adc-tm@3500 {
 			status = "disabled";
 		};
 
+		pm6150_rtc: rtc@6000 {
+			compatible = "qcom,pm8941-rtc";
+			reg = <0x6000>, <0x6100>;
+			reg-names = "rtc", "alarm";
+			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
+			status = "disabled";
+		};
+
 		pm6150_gpios: gpio@c000 {
 			compatible = "qcom,pm6150-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
-- 
2.42.0

