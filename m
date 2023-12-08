Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15B280A6E4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574239AbjLHPJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574203AbjLHPJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:09:10 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A7C1FCF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 07:09:15 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a1e7971db2aso247513166b.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 07:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1702048154; x=1702652954; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i8hg75fxw9R+dBPdPORPMttaCUpNuozfVfSBn/F7kAo=;
        b=21gumZTlYpHHCyOvLr0xICTvdQASzRB644cNYztLQzfUSSqdgSIHTiG2DgPuVbiIYd
         Mzs9OHJva4WrAYyOrLhX5H3VKdHiSHBwtPWZHWIS61DTrJH3bny20bmnvJLMkeG4hG9p
         1EKIyznSwd8dsALeDm1WSosu/shbrLe8/RpiaJVGoPy/PLCq2stkR3gyY3PmkhDboU/o
         n54wcELF2T1j0P3w6fxZ/WnTx2a1/tcqK+Cxci28+rCKgc2+4tqeTwgyj6IPEsREvcgY
         zD3Y6jTWliGybLBU1DuoWeo9MePcbKSZrRGs7Ng4QyaQaQQXgZ0V2kZDr9zda2zDIZyi
         c9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702048154; x=1702652954;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8hg75fxw9R+dBPdPORPMttaCUpNuozfVfSBn/F7kAo=;
        b=YaO/yZIFPY6eW24phiVn2xLDktXssLbKT7eB4rU95OuC8z0/xRhaZ1RZCNpiIuA03k
         ALsQ689vs3SA/e3LnTeC1ZLJscK/IChM28MePyN5iebr+vx3O6iCJ7YOvm47d2q+jMHY
         DU09bYvTVY3BKq1u5uKXwEONLlGpjfVga3XAPk7C8o/d8e1MFZLePguQHeG9kug6SpzT
         Zx/6Tl8qTRGRAVBFUcIeKe5358xDCUs+x3evOA7duDCiugk63gen/Io368i4Qoro9+zm
         iK4IutxZa8t8n2thm7UuaB7RFjwFfqq5LkmZF0jtdLZgdL+yDVX4EmN5Xa06Tt7qAXhq
         P/jw==
X-Gm-Message-State: AOJu0Yyz8MOje4L4X40k/Onf4R2Zf0M3ReiI5o37P2ogxGDVEPBrgs0b
        uD5jwPr2nZkVHl5q9VAMl9cmWQ==
X-Google-Smtp-Source: AGHT+IHpNXHD7hMM4qjciCbNAZmxBp44HoDMbmCRqYLv3IH/ca5r9OaByDVmFwDOwqNYTv9DcdmjuQ==
X-Received: by 2002:a17:906:eecb:b0:a1d:ec18:6ada with SMTP id wu11-20020a170906eecb00b00a1dec186adamr86437ejb.104.1702048154429;
        Fri, 08 Dec 2023 07:09:14 -0800 (PST)
Received: from [192.168.55.221] (tmo-113-102.customers.d1-online.com. [80.187.113.102])
        by smtp.gmail.com with ESMTPSA id r25-20020a170906351900b00a1cc1be1146sm1096114eja.217.2023.12.08.07.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 07:09:13 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Fri, 08 Dec 2023 16:08:06 +0100
Subject: [PATCH v3 10/11] arm64: dts: qcom: qcm6490-fairphone-fp5: Enable
 various remoteprocs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231208-sc7280-remoteprocs-v3-10-6aa394d33edf@fairphone.com>
References: <20231208-sc7280-remoteprocs-v3-0-6aa394d33edf@fairphone.com>
In-Reply-To: <20231208-sc7280-remoteprocs-v3-0-6aa394d33edf@fairphone.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?utf-8?q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the ADSP, CDSP, MPSS and WPSS that are found on the SoC.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
index 9c25e28a62d9..830dee4f2a37 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
@@ -691,6 +691,26 @@ &qupv3_id_1 {
 	status = "okay";
 };
 
+&remoteproc_adsp {
+	firmware-name = "qcom/qcm6490/fairphone5/adsp.mbn";
+	status = "okay";
+};
+
+&remoteproc_cdsp {
+	firmware-name = "qcom/qcm6490/fairphone5/cdsp.mbn";
+	status = "okay";
+};
+
+&remoteproc_mpss {
+	firmware-name = "qcom/qcm6490/fairphone5/modem.mbn";
+	status = "okay";
+};
+
+&remoteproc_wpss {
+	firmware-name = "qcom/qcm6490/fairphone5/wpss.mbn";
+	status = "okay";
+};
+
 &sdc2_clk {
 	drive-strength = <16>;
 	bias-disable;

-- 
2.43.0

