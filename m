Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685067FA4A4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbjK0P3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbjK0P3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:29:22 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E24C186
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:29:16 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-54b0073d50fso3929789a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701098954; x=1701703754; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9K/KL6rUHA7mDcBMrrqIFDkXaVSeDD2iYf5D2W8YBIg=;
        b=ZZ/sWaZI91cn1stFMgzEBqD3hhfdzFKBLXod2X9G3e3GUxuxKZj00W4r6znSgu0Zu7
         Ons5FJ1oO/huV2y5FPjELEz9MhxwFMja7t4rvJ3jRd/4oPJQ4gAISzOhZKBN4Sa+aqMo
         cfO2DzCzy18IY04a17QovuWsPKt0pWpC9dm+Tio/e0bFVxnBr6AknsVBIjtCVTpMQaYL
         LPfC3lyMXJj3h9sruotnyCm22zdbHOihqx/t2JxIFXyb3lqawB9/leJRil5YE3KIg3xd
         IRtFlKY52kCOtGLWaWC39/e7hmlOGdqKNP+ToULCy2Cxus7O7Qht+MNCOLI4z+8iak2Z
         R5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701098954; x=1701703754;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9K/KL6rUHA7mDcBMrrqIFDkXaVSeDD2iYf5D2W8YBIg=;
        b=Xa8ymy9xW8uA8TFYi1Nz6TYdIGyIvjfZ7ILfPA0sHo9lbJnMW3TuPPLs3WlLRp7nAq
         rhStVeTBrkZJ/XMwQJpPbnptFxXkpC23JEpkCLUvzvmHWDX65ROrDdYvaJMeaf+1OMc2
         bOLoSw9cZ8fGiLLnaI4iExln0bIdQKwuVGNcL0OZx9afoxgKXM3lyvQMH1NsO0J0CHFH
         M0sf1YTW4KFu8KhauceDBtOCIVBg4fjl0pjsd7494LmcwhFDUni7AYXXYxuARWMNqb0H
         th49SVjqOs4mc61NgkcFfKmOZUrOcjQEo11o5BoDFqG7TufsnZ2g5nRpiPGNr5gxVOVX
         HCXA==
X-Gm-Message-State: AOJu0YweCN58p8EeUk2zhQyWKRgcJVNjhTEfWVmN0jA1X0nuPDS09wdM
        aQ90OhM73jbr0reUGTcEoLDiig==
X-Google-Smtp-Source: AGHT+IEIiagBs4pKlQcv6cU58laBuVympuk9luCBlm1ZQI6HobNWAnEpM0jGc9hClEDNkc6Pr54I+w==
X-Received: by 2002:a50:c04a:0:b0:53d:d913:d3cb with SMTP id u10-20020a50c04a000000b0053dd913d3cbmr9226012edd.28.1701098954710;
        Mon, 27 Nov 2023 07:29:14 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id e7-20020a056402104700b00542db304680sm5321002edu.63.2023.11.27.07.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 07:29:14 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 27 Nov 2023 16:28:47 +0100
Subject: [PATCH v2 07/12] arm64: dts: qcom: sc7280: Add the missing MDSS
 icc path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231125-topic-rb1_feat-v2-7-979b28f35e4a@linaro.org>
References: <20231125-topic-rb1_feat-v2-0-979b28f35e4a@linaro.org>
In-Reply-To: <20231125-topic-rb1_feat-v2-0-979b28f35e4a@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        cros-qcom-dts-watchers@chromium.org
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701098925; l=1493;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=RpzLMWuMbYjvqQjs1yjMVMPj1VmkWicMXA9dO0pSXPQ=;
 b=R55EDfVA3vNj1gKF5/rCo8RrwCBiKh1MWLkiyJUgCpQVrEUf8nd/J8yIoPfGKZI92hXoMX4hD
 5r03X65uJfzC/GqWapMJgl2lg6iTLvi+NlygsZ5KcTfiGZHefthMnG8
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MDSS, aside from the MDP-MEM path, also requires the CPU-DISP_CFG one.
Failing to provide it may result in register accesses failing and that's
never good.

Add the missing path.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 04bf85b0399a..41d327b1f1b6 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -15,6 +15,7 @@
 #include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interconnect/qcom,icc.h>
 #include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interconnect/qcom,sc7280.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -3958,8 +3959,12 @@ mdss: display-subsystem@ae00000 {
 			interrupt-controller;
 			#interrupt-cells = <1>;
 
-			interconnects = <&mmss_noc MASTER_MDP0 0 &mc_virt SLAVE_EBI1 0>;
-			interconnect-names = "mdp0-mem";
+			interconnects = <&mmss_noc MASTER_MDP0 QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
+					 &cnoc2 SLAVE_DISPLAY_CFG QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "mdp0-mem",
+					     "cpu-cfg";
 
 			iommus = <&apps_smmu 0x900 0x402>;
 

-- 
2.43.0

