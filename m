Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD41774FB2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 02:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjHIAIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 20:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjHIAIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 20:08:10 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B47810F7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 17:08:09 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9aa1d3029so99849321fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 17:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691539687; x=1692144487;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=whUPxLA5sv9BT7SZ99FkH9H53omaSas9KjQfVA2RxFo=;
        b=H1YGXKDkX56XBS9H1+KUnGOHGXQ5LEG4Jn1ndw13KjHYThgtkv3o7GdNdesOWaI4Ea
         wJgB/MIGIEfFxzN5p1D3gLx3KLZj1RkJz4Svtg1oqgvJqWR58DEdILgBqirefuEyxPAH
         s91RD/RhJkslbCRudlEE+CX1CQAP+JFtj3kW2Jppq2QWLkYfDwOz64T7akGXqy2k5XA9
         mS6C9tXmlfG1kGMNQnR0lZWd4ql+F/mzQDtlj8H/68+I34a4gHd3aLxIaqNbVHdOoyBt
         zwRTcD2VkrKTV4PuGrFE+f5XysfVNYAkdgBtbXJWbeVgqe3TPCvNTO3Kz8XLFNQjy36t
         /EPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691539687; x=1692144487;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=whUPxLA5sv9BT7SZ99FkH9H53omaSas9KjQfVA2RxFo=;
        b=H+Xq3pcLB6B+cvcHHT8z90xgCaUFCaPZJ5cIRwxVcy4z9mJ4uMpCQ+pm6ifFo6ZsjH
         N19u1RMN7+ARXWLhE5g23NJzQHZro7BRzwVpvzKDtrpgSOL+HwGq8OaD3Bzo/FOAI/qF
         7fUgNX8ReJRrIm3VgkQpSIwlA0VjsRtXypk7YpfXI/wxWH7nhmejQMfgQhWJ2xjjVD8M
         xEZyWQbTQCsUB0DUen/XlB+8OcSLB40wX7oXceesIQB223dlok5wQtNubotHQpa5FGNV
         ZiLARcvPkyP9waxVS5JzyrZgeprJyL1OtDWRjFrGDAFPUoEqhgW0dho3cKdFrl8SOxFn
         Ddiw==
X-Gm-Message-State: AOJu0Yyoee/AN9o7rc0Vg4NqslukHEzp8tDIr4q6uxNCnCz9ewiVNr5I
        M6aPJiWfS1z99tVbjFniaGrsEA==
X-Google-Smtp-Source: AGHT+IF6wOBbVR/5X3/2aZWTpIb8sAiSLWI6c3djMlk5ShI9auLR7FWOHleDKZdQmTFKl/Jf5ZPJoQ==
X-Received: by 2002:a2e:8603:0:b0:2b8:4079:fd9d with SMTP id a3-20020a2e8603000000b002b84079fd9dmr716607lji.29.1691539687455;
        Tue, 08 Aug 2023 17:08:07 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id p3-20020a2ea403000000b002b9db7df0dasm2486737ljn.8.2023.08.08.17.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 17:08:06 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 09 Aug 2023 02:07:59 +0200
Subject: [PATCH] cpufreq: blocklist more Qualcomm platforms in
 cpufreq-dt-platdev
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230809-topic-cpufreq_qcom_block-v1-1-624acbcefa5c@linaro.org>
X-B4-Tracking: v=1; b=H4sIAN7Y0mQC/x2NUQrCMBAFr1L228C2FWm9ikhJthu7GJN0Y0Uov
 bvBz3kwb3YorMIFrs0Oyh8pkmKF9tQALTY+2MhcGTrsehxwNO+UhQzlzSuv00rpNbmQ6GlGHuz
 5gm2Ps4eqO1vYOLWRlnoQtxDqmJW9fP+92/04fnpZHgp/AAAA
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691539686; l=1782;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=B4WkHxvkE88pk6XjVqrE6l91KsV3HxOgV2ktEzPupnY=;
 b=EnEzaQo30ZHYJcTKwJJLZyGse4i6KIv2hTXlIc5V7ulesvFn4SqfEABFj5cdPVxrKzpHtzS3C
 u+uhgKbGB0BDG7BGd8TMlOyUV2IZIlTxIMtx7ZwHBRGSKNE/zcaki5x
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All Qualcomm platforms utilizing the qcom-cpufreq-hw driver have no
business in using cpufreq-dt. Prevent that from happening.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index adb3579a1fee..fb2875ce1fdd 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -144,14 +144,18 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "qcom,apq8096", },
 	{ .compatible = "qcom,msm8996", },
 	{ .compatible = "qcom,msm8998", },
+	{ .compatible = "qcom,qcm2290", },
 	{ .compatible = "qcom,qcs404", },
+	{ .compatible = "qcom,qdu1000", },
 	{ .compatible = "qcom,sa8155p" },
 	{ .compatible = "qcom,sa8540p" },
+	{ .compatible = "qcom,sa8775p" },
 	{ .compatible = "qcom,sc7180", },
 	{ .compatible = "qcom,sc7280", },
 	{ .compatible = "qcom,sc8180x", },
 	{ .compatible = "qcom,sc8280xp", },
 	{ .compatible = "qcom,sdm845", },
+	{ .compatible = "qcom,sdx75", },
 	{ .compatible = "qcom,sm6115", },
 	{ .compatible = "qcom,sm6350", },
 	{ .compatible = "qcom,sm6375", },
@@ -159,6 +163,8 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "qcom,sm8150", },
 	{ .compatible = "qcom,sm8250", },
 	{ .compatible = "qcom,sm8350", },
+	{ .compatible = "qcom,sm8450", },
+	{ .compatible = "qcom,sm8550", },
 
 	{ .compatible = "st,stih407", },
 	{ .compatible = "st,stih410", },

---
base-commit: 71cd4fc492ec41e4acd85e98bbf7a13753fc1e03
change-id: 20230809-topic-cpufreq_qcom_block-9e8a460130df

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

