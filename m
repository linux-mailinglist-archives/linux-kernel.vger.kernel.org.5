Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7C2765A66
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 19:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjG0Rdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 13:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjG0Rdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:33:33 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEB3B5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 10:33:31 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fba03becc6so3142603e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 10:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690479210; x=1691084010;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=icO3d3uWVI1Ske0MIHcKUIP285+5TQhyvGKynKcarCg=;
        b=UghMswEkqCLq7uFW0vg1z0BCw4oUeIeSnbl7RRVXmD+R4LSrBowDwJ2xk4rBk/1c3N
         YVcSqboHoiKkB54P3hXlJZfbr6wTvzZBtZvjMump/NpjjuE2Cvb/3G2+r+2Zdib0o/O2
         EIkq5mkmozwuiBAJ7bztpa+UXln0i8suBJKJbi2VvNwlPJFYhvk+NLNPf2ecwds/QnbA
         PNSLX8ihTygl7/ACrKad7aIoL2qPhLCgtBCW2jFPYiQ91FH22K7bvs4hpkidx/mNykqf
         aJCm/sBp5AyvV+ME9S2eODDb+PPR6ID4Vn9FX54ONbs3VXRmWLe1RVDAYAYDvgpjozb4
         s2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690479210; x=1691084010;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icO3d3uWVI1Ske0MIHcKUIP285+5TQhyvGKynKcarCg=;
        b=TDUUgPsOxGuw1J00zxn2bdAlzdcZ84FYPPXh+mmHMScHGq/4BDmNJfuRhM0Ok0Pjnt
         obDbLlM9y9vvlf1XP0ptBt+TVxjHbUqKcTHvlQMtbshT2doJZzsLi7Jdh2zhVofBHV4s
         8nLNz8KDTRwinButmJcX36v0MO2Q/yj79qRBlKhF/+6XZCOM8WvllOSeqJz7I4Ngd5li
         2oSgNO6YeHV4Tc5Q7hk8l8jWsy0P0I02NXsvO3+hAKNTbSskkq0tG70NaRW7Bo1S/WQ7
         JmjiYOSgHXFREKCx3Xmm0aoJojI6Anj/Qa2AmwSRe8XShmv/bdk3C+VuZxjhNjMzPXjP
         Y9Bg==
X-Gm-Message-State: ABy/qLYgW42ljJt9AC2+R9vuXS/Rn4fDlBDg54ArnBMKJ/J5Kk76CAr4
        EwynjbWlv3ZrFJIuwuXFAreEOw==
X-Google-Smtp-Source: APBJJlENla/qWI/wubCIydlyspuaQuIsyTFQVi7DDpSPzq+fSIyNg8Oh8dUZnwie0i6o4USOpEQXOA==
X-Received: by 2002:ac2:57c8:0:b0:4fd:f6db:a7d9 with SMTP id k8-20020ac257c8000000b004fdf6dba7d9mr2060lfo.32.1690479210117;
        Thu, 27 Jul 2023 10:33:30 -0700 (PDT)
Received: from [192.168.1.101] (abxi99.neoplus.adsl.tpnet.pl. [83.9.2.99])
        by smtp.gmail.com with ESMTPSA id g4-20020a19ac04000000b004fe07f06337sm412089lfc.53.2023.07.27.10.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 10:33:28 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 27 Jul 2023 19:33:23 +0200
Subject: [PATCH v5 3/3] remoteproc: qcom: pas: Add SM6375 MPSS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230725-topic-6375_rproc-v5-3-a8e9cde56a20@linaro.org>
References: <20230725-topic-6375_rproc-v5-0-a8e9cde56a20@linaro.org>
In-Reply-To: <20230725-topic-6375_rproc-v5-0-a8e9cde56a20@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690479202; l=1570;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=sj7Uy3Esp9/kv46p/vCH0qMBjFc8YM0n5pfjJE2JRcc=;
 b=pwCv/rsLcc3qhJEeFtI+WrIDbwPG+xDQNkdjonSUEWRcDMWOxqw6LamKTxlr5pRFwGeBJZl6C
 28XhYu1QvlKCk6fdUsPaJ9if6YEffEAsLoY5D3x1lj3hPWevlUYXCJ2
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a config for the MPSS present on SM6375.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 0d58b5be9a77..1c87ae9cec9e 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -813,6 +813,21 @@ static const struct adsp_data sm6350_adsp_resource = {
 	.ssctl_id = 0x14,
 };
 
+static const struct adsp_data sm6375_mpss_resource = {
+	.crash_reason_smem = 421,
+	.firmware_name = "modem.mdt",
+	.pas_id = 4,
+	.minidump_id = 3,
+	.auto_boot = false,
+	.proxy_pd_names = (char*[]){
+		"cx",
+		NULL
+	},
+	.ssr_name = "mpss",
+	.sysmon_name = "modem",
+	.ssctl_id = 0x12,
+};
+
 static const struct adsp_data sm8150_adsp_resource = {
 		.crash_reason_smem = 423,
 		.firmware_name = "adsp.mdt",
@@ -1182,6 +1197,7 @@ static const struct of_device_id adsp_of_match[] = {
 	{ .compatible = "qcom,sm6350-mpss-pas", .data = &mpss_resource_init},
 	{ .compatible = "qcom,sm6375-adsp-pas", .data = &sm6350_adsp_resource},
 	{ .compatible = "qcom,sm6375-cdsp-pas", .data = &sm8150_cdsp_resource},
+	{ .compatible = "qcom,sm6375-mpss-pas", .data = &sm6375_mpss_resource},
 	{ .compatible = "qcom,sm8150-adsp-pas", .data = &sm8150_adsp_resource},
 	{ .compatible = "qcom,sm8150-cdsp-pas", .data = &sm8150_cdsp_resource},
 	{ .compatible = "qcom,sm8150-mpss-pas", .data = &mpss_resource_init},

-- 
2.41.0

