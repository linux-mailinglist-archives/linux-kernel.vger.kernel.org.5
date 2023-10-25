Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F361E7D63EC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbjJYHtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbjJYHs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:48:57 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58751987
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:47:52 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c501bd6ff1so74960621fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698220071; x=1698824871; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jj4pz0oGfmPVPfNg2jwUiWOZqvX5coSUC0JrIQ/a0Sk=;
        b=bPhSL1lXAE9ESHglhdZK8usADSKw2XoBCY0e97N9IS8Tjda/b458C0/kBaeIPCpjEA
         44iG/tYIcFAX2CMGFfr8elRjMH+4APUYot24FU1NPiXnOnTZdETVY3cdqeVAcohV30EJ
         FjOqVwqbrl1gqvyKHmtroYKvJa95/cIDgBGb7y3DS9Ip1ffoe7AsCnQhZtajcKUuygEz
         SaKexzxZZ8W42BuSRhEuhEVqwQP6bCxNL7M8WJeElbCIlMdLa+scmUXS6ADAZouOmLHV
         vP+53S2oGOwUrhUP28splDoYfROb65Az1iurzaZ1vNPemB7/QfDnDk67VGWd5Q5hnhs1
         kTiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698220071; x=1698824871;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jj4pz0oGfmPVPfNg2jwUiWOZqvX5coSUC0JrIQ/a0Sk=;
        b=LJPMOxWm3NkbaYU34OKiDW0Z6yhCLRBg//dx31buHHdKyLKHefEDqurkjppw+qITmG
         kdSgJHF93HvgxArk0I3FeuJFc04pNhJscSVPVCj2o1+0I2d1kONsniyE2iKDKRGoPfm7
         pVb4j4vVpUoFeidbOH7ZnVvpm6HsompCIZG9J6zZ7DENZi4OWNkAHvQeTkNF0dKEG9TO
         tgi2CkYAKIgK/NHLtl7punvXa84UOpvh7kTx/lbB3R13UKG7SOGQpX4T/+8I6KiSTtkm
         I8rsudbr7SUCkYjBvlmqn3nv9Jt5u/PFjZ9g20U8joCWnv9oPsDLLY1RpOR8+UHZAx7E
         LTvw==
X-Gm-Message-State: AOJu0Ywpb0qI2o3Vt6va/2EFbqI0rxxHMCOTeKJGJJrkwvpXSKWYLKXy
        slNgmjK684WnxMLFNpvVNnAcSQ==
X-Google-Smtp-Source: AGHT+IFSLbdPQDsrOI/shGAo1alPAyWTvDpY4OX5UPeuRHnB3yNOMI3Te0oUBDJrrPl/bAjj+yJY+w==
X-Received: by 2002:a2e:7309:0:b0:2bc:bf29:18d3 with SMTP id o9-20020a2e7309000000b002bcbf2918d3mr10546345ljc.31.1698220070751;
        Wed, 25 Oct 2023 00:47:50 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id p5-20020a05600c358500b004053a6b8c41sm13900970wmq.12.2023.10.25.00.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 00:47:50 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 25 Oct 2023 09:47:43 +0200
Subject: [PATCH RFC 3/8] arm64: dts: qcom: pm8550ve: make PMK8550VE SID
 configurable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-topic-sm8650-upstream-dt-v1-3-a821712af62f@linaro.org>
References: <20231025-topic-sm8650-upstream-dt-v1-0-a821712af62f@linaro.org>
In-Reply-To: <20231025-topic-sm8650-upstream-dt-v1-0-a821712af62f@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1332;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=9AfhwZbOwPbHkV0DH8+zQiI7Q8OXt1Nt+WaoZknvl8o=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlOMggfwKzrWnDOnmkS98Z9938l3bvDH57RmLuttHz
 X/dXr2yJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTjIIAAKCRB33NvayMhJ0a84D/
 9V70T6FRaRZQ4GMQNJvbk/jb150QGBziH2Z5mW2gXiWvOBJa7Izm4fVPBwkzrI3TyZ3SJsoRxYeXFS
 jtAV+RU+lt8GR7Ec7M+DAa0p9dWWtxU5kQ6iY8P8TavGQEcpX7hlzTy59JPCLWRkn6T0gf2F3m1cbJ
 fZyYCl2Z8GDQFBajPkbm+TaItRXAbaYLNAjK1Dm918zNf2X2iFIfi6NdJW8fCjvOXs7oAbjKctvtLy
 8qgqBmCjYAaKq2mBnDqttwRkTH4NQB8G7AnGJdkjiNtnr3YyuMCahZSNxWvbLAJOJ9P1+AkHBAiKmB
 7nz05DoFe5VwfzcOLD+mksVru/yGEBv8AnuZYcIhoCNtwcEVraelneb7QONGaMrtVAim48JO2I1fqZ
 X68ornkO41VcOJ4sNxzCAfRzZw/GSppAGf4UUqZPPySuAz7JoD1k/xy+PRWQ+vd9FF2zsW900y9lja
 z9IjqF08KtnBgTpASFzCZunv16D69/y8HnEz5Lqu5IRr+azXJoEBEe9glJey6wr2x5XLgVDAYfp+Gx
 ahI6AWsCXTh0VUWHGtfkYl5wIiVg14jLUz7jQQehmlk00NChaOzmViNB2aVDDayDmkGxrLx2oy8ltE
 CmY2sjibyOVsBFcTLo2I57YuxHp6WL6F8ixWbaWwOEhVlf67bX3Fxj4lxVZA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pm8550ve can be found with a different SID on SM8650 platforms,
make it configurable.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm8550ve.dtsi | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pm8550ve.dtsi b/arch/arm64/boot/dts/qcom/pm8550ve.dtsi
index c47646a467be..fbd8a386cef2 100644
--- a/arch/arm64/boot/dts/qcom/pm8550ve.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8550ve.dtsi
@@ -6,6 +6,11 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
 
+/* (Sadly) this PMIC can be configured to be at different SIDs */
+#ifndef PMK8550VE_SID
+	#define PMK8550VE_SID 5
+#endif
+
 / {
 	thermal-zones {
 		pm8550ve-thermal {
@@ -33,16 +38,16 @@ trip1 {
 
 
 &spmi_bus {
-	pm8550ve: pmic@5 {
+	pm8550ve: pmic@PMK8550VE_SID {
 		compatible = "qcom,pm8550", "qcom,spmi-pmic";
-		reg = <0x5 SPMI_USID>;
+		reg = <PMK8550VE_SID SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
 		pm8550ve_temp_alarm: temp-alarm@a00 {
 			compatible = "qcom,spmi-temp-alarm";
 			reg = <0xa00>;
-			interrupts = <0x5 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			interrupts = <PMK8550VE_SID 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
 			#thermal-sensor-cells = <0>;
 		};
 

-- 
2.34.1

