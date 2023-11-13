Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD7A7E9860
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 09:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbjKMI4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 03:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbjKMI4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 03:56:33 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85E110F5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 00:56:29 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-543923af573so6409761a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 00:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1699865788; x=1700470588; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tcn0Z6SH1iEGlywsG8bbVDvChWKOwTZ/D1g5QR3UiaQ=;
        b=REgad8FK6EdeLoY0lzZQ14XlgojkpyS8NYZbEz+wO28oJT6wVrHZQe25y63MWeLQ5u
         NjGK1P+kgcRv8Re67jDW6Hh+aEa95JCfeKumN7qgvt1tUoONwTBgdKLsvjIL+svTa37x
         W9Uh9fbXm5CpXZTRkPT0pQOIuuSLgct/KCw0N9a9/Txp/Rw0u0fLcVEYCyAz3oZaPtIK
         nnJT/65POHpfP72TFcnqeDU5CRlTr4Y5Dqo/nSij6njyw5KyEirtto6CfHWv1vOVha7N
         G/7I2/AjrzqUQhfSUWp9k/VpZ64GlUKmVuSeah3wvo8FLAiGw4iDWfnqEkIkcUupek5S
         S76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699865788; x=1700470588;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tcn0Z6SH1iEGlywsG8bbVDvChWKOwTZ/D1g5QR3UiaQ=;
        b=GKqJnoWprO+l2EwSp4Zuk3Q57fMR2DXoQNBtti/YO6PSsL1Jpbth6GTX8Y9GcJ4Gdq
         Vl5sK4Ks9vuTx4oN90HvcD+pWXVbK6cN5bzCqNEXqfPiuF1Fsz7f/sSrBwR65MrS1XnQ
         MwVXBR/UpX94POljh9BBbHgiK0SqKMBW8y7L0p2LvpaxY7IjeOXk6gtakdP8/6ZzdyrG
         9VvRNo478qXtgJ+lLcwJjb5SneAcVJiY2Qvj1JvL7BfEOkf3ckunuOIzeg+/iPp8GtFQ
         8L/h5m1OOybPxfK2OluefkaEeostZzn0RzpW0SCr+T5Ikx5U+aZ9tlRKYdO2gKMMSo2X
         XEow==
X-Gm-Message-State: AOJu0Yx77Z7K9iakCxA6afQt/ha9+7KgMOn4OK9r4SkdfHdKz/EAu5Vf
        oVkwneoiLn9z/pOJHqoZC3oMGQ==
X-Google-Smtp-Source: AGHT+IEhwVmqmIghdLy6T66Sz8mKhhL8os7HgBaLdZtnted47FjN4Yy7mcFJOKOeCFn6gDahu9TjHQ==
X-Received: by 2002:a17:906:4098:b0:9d3:608d:cdf6 with SMTP id u24-20020a170906409800b009d3608dcdf6mr4359583ejj.19.1699865788306;
        Mon, 13 Nov 2023 00:56:28 -0800 (PST)
Received: from otso.luca.vpn.lucaweiss.eu (k10064.upc-k.chello.nl. [62.108.10.64])
        by smtp.gmail.com with ESMTPSA id kk22-20020a170907767600b009c758b6cdefsm3673538ejc.128.2023.11.13.00.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 00:56:28 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Mon, 13 Nov 2023 09:56:17 +0100
Subject: [PATCH v2 06/11] remoteproc: qcom_q6v5_pas: Add SC7280 ADSP, CDSP
 & WPSS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231113-sc7280-remoteprocs-v2-6-e5c5fd5268a7@fairphone.com>
References: <20231113-sc7280-remoteprocs-v2-0-e5c5fd5268a7@fairphone.com>
In-Reply-To: <20231113-sc7280-remoteprocs-v2-0-e5c5fd5268a7@fairphone.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the ADSP, CDSP and WPSS remoteprocs found on the SC7280
SoC using the q6v5-pas driver.

This driver can be used on regular LA ("Linux Android") based releases,
however the SC7280 ChromeOS devices need different driver support due to
firmware differences.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 913a5d2068e8..a9dd58608052 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -1165,6 +1165,22 @@ static const struct adsp_data sm8550_mpss_resource = {
 	.region_assign_idx = 2,
 };
 
+static const struct adsp_data sc7280_wpss_resource = {
+	.crash_reason_smem = 626,
+	.firmware_name = "wpss.mdt",
+	.pas_id = 6,
+	.auto_boot = true,
+	.proxy_pd_names = (char*[]){
+		"cx",
+		"mx",
+		NULL
+	},
+	.load_state = "wpss",
+	.ssr_name = "wpss",
+	.sysmon_name = "wpss",
+	.ssctl_id = 0x19,
+};
+
 static const struct of_device_id adsp_of_match[] = {
 	{ .compatible = "qcom,msm8226-adsp-pil", .data = &adsp_resource_init},
 	{ .compatible = "qcom,msm8953-adsp-pil", .data = &msm8996_adsp_resource},
@@ -1178,7 +1194,10 @@ static const struct of_device_id adsp_of_match[] = {
 	{ .compatible = "qcom,qcs404-wcss-pas", .data = &wcss_resource_init },
 	{ .compatible = "qcom,sc7180-adsp-pas", .data = &sm8250_adsp_resource},
 	{ .compatible = "qcom,sc7180-mpss-pas", .data = &mpss_resource_init},
+	{ .compatible = "qcom,sc7280-adsp-pas", .data = &sm8350_adsp_resource},
+	{ .compatible = "qcom,sc7280-cdsp-pas", .data = &sm6350_cdsp_resource},
 	{ .compatible = "qcom,sc7280-mpss-pas", .data = &mpss_resource_init},
+	{ .compatible = "qcom,sc7280-wpss-pas", .data = &sc7280_wpss_resource},
 	{ .compatible = "qcom,sc8180x-adsp-pas", .data = &sm8150_adsp_resource},
 	{ .compatible = "qcom,sc8180x-cdsp-pas", .data = &sm8150_cdsp_resource},
 	{ .compatible = "qcom,sc8180x-mpss-pas", .data = &sc8180x_mpss_resource},

-- 
2.42.1

