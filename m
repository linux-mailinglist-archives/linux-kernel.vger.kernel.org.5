Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6857798F9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 22:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbjHKU62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbjHKU60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:58:26 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9907EE77
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 13:58:25 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9cbaee7a9so37794731fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 13:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691787503; x=1692392303;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VflrdiVnGg345uIFqnoO6TkGpXhpklE8gdXZdL1DyS4=;
        b=RtFpgzn2Kei7bNCcR3S0d0ve9sB4Y1yaUu9cN4/HQp/thC0tYVFevISPV1RlHdvasu
         H4MQBTKYZYIGtZp6FBF6JMhO2p44jH0jM2HbPn2aI9Cj8PDAo+PO0xFPg1RQ4r6P4oyd
         stUh4DQWWxxUDph8oDknytAKgNE4Guz8StIoF9v79KJv91ooBRGEtTADokcMoZcY4wQc
         bcMza1tdXDWs6EJmBpCE0rsBfndfTwlP5KZNT9dR8QsIhcD9WCAr5Dmo9rnCujrKi+go
         lfk9VjBysBJzffvWKTRdydY4IMAv+aEXqIDMw3PqHFRJMY98cr+ciKOINpnYg6HeOe95
         F/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691787503; x=1692392303;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VflrdiVnGg345uIFqnoO6TkGpXhpklE8gdXZdL1DyS4=;
        b=etCmCITH/6gONssKsCmhncZe/sbQlzRV51MZ3UL6xGVFDjaEjYJ5b4opxB9L9CYwHm
         hkwbHe9kWyMt0H5eTUCluj9F6Ay3PboW3blZO/o6lEilse4Gmulwd/joDRMJ5DjZV+rQ
         cf+JDAybf2csS7U2eSwDCegGwfXQ/vF4/+CjbtY5Wc+DMP7VHt6EbXtvj+Ug4HG5gNOJ
         hXsggaO2VEwsHSHpkW2O4uXhCWl/HmjMibd/xLesLDmRGiQAVi0it66oP7OCwq8YCJac
         tSl0nzZmCLVuOmYMOGZhJK394LBmmIDNwu6gezXALvm2WlC5v3bJlNUkwZH7ZT2Bz8dP
         goIg==
X-Gm-Message-State: AOJu0Yy2tpAr0lfSwP+09sgKWUgPKHsDrR9L5p46/g0FHz5EOxTCuKw0
        FBVK6y8h2bFBifjAJv0w7PtmGWv95MHtcRpQzrc=
X-Google-Smtp-Source: AGHT+IGSc6jrJjAJTlyy+ZL/rqPh2gMcEam0xvCk0Hpxzu2QlIG+CFvudTY3BT2QSbhopD0EE1ompQ==
X-Received: by 2002:a2e:98ca:0:b0:2b7:2ea:33c3 with SMTP id s10-20020a2e98ca000000b002b702ea33c3mr2816669ljj.22.1691787503491;
        Fri, 11 Aug 2023 13:58:23 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id d14-20020a2e360e000000b002b9e65912cesm981931lja.140.2023.08.11.13.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 13:58:23 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 11 Aug 2023 22:58:22 +0200
Subject: [PATCH RFT] arm64: dts: qcom: sc7280: Add missing LMH interrupts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-topic-7280_lmhirq-v1-1-c262b6a25c8f@linaro.org>
X-B4-Tracking: v=1; b=H4sIAO2g1mQC/x2N0QrCMAwAf2Xk2ULaMlr8FRHpumgDtZupijD27
 ws+3sFxG3QSpg7nYQOhL3demoI9DZBLag8yPCuDQ+cxWmvey8rZBBfxVp+F5WUIQ5rd6NHHANp
 NqZOZJLVctGyfWlWuQnf+/UeX674ff2Um+XgAAAA=
To:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691787502; l=1411;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=fcwFE3MuiwWl8M7cstcsljKLN5V51Tw/EmSIoXqMVYg=;
 b=MPZz0y4EKr2WdEJ1t/CExMXJmhXYVZM2UiJofYktHs0ihvjUk5YvDN6MEa/ofFalD0w+LuXR8
 bI8mOtsMR4iC07lAW6FWXHk2S71eAhrlAdWdrwwx/Dm2Vdz0b7PUGZp
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hook up the interrupts that signal the Limits Management Hardware has
started some sort of throttling action.

Fixes: 7dbd121a2c58 ("arm64: dts: qcom: sc7280: Add cpufreq hw node")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
test case:

- hammer the CPUs (like compile the Linux kernel)
- watch -n1 "cat /proc/interrupts | grep dcvsh"
- the numbers go up up up up -> good
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 925428a5f6ae..76ed32c8d6f7 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -5363,6 +5363,14 @@ cpufreq_hw: cpufreq@18591000 {
 			reg = <0 0x18591000 0 0x1000>,
 			      <0 0x18592000 0 0x1000>,
 			      <0 0x18593000 0 0x1000>;
+
+			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "dcvsh-irq-0",
+					  "dcvsh-irq-1",
+					  "dcvsh-irq-2";
+
 			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
 			clock-names = "xo", "alternate";
 			#freq-domain-cells = <1>;

---
base-commit: 21ef7b1e17d039053edaeaf41142423810572741
change-id: 20230811-topic-7280_lmhirq-e07ad2530387

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

