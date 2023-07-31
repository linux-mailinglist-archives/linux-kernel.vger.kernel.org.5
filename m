Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CC37693BC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjGaKyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjGaKyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:54:10 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829D52694
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:52:39 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe0e23a4b1so6786683e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690800757; x=1691405557;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fB3U8vshaXGTQDVy4zCZyIQDygwXYLYWLuqWZPmvE6A=;
        b=cawrlLWOIpMlWCMp3hV/w0GWzGyNJ+4BzXfUro5Ga9kDxtYP+q8BsOihYGxVHB49Qa
         qn18Yz/WhnJVrociJaEtwu2gHq5X63NkPh0LTPaCHumF5AH4JJBWhcawTKCplw7KwtX6
         tu2EDePQibknZA5FvV1sShHWA4q3WfgdBI9NifyYV90QqPMBrwajxv3BcJOLWNnfvp5U
         5lbjryLA1VufmUer+/1P9eiay6hJp8w4eM01iZ3B2Ajw2d4lEQ8Q0Yo1ZiAE2wQGHqJ2
         fkxQ5uoF3q4sEJ/gSU5c+JcePCTC9TlKCGjpbXpqg/Lp9/jU2VnbGpD8RnDJSLPwAgf0
         LJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690800757; x=1691405557;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fB3U8vshaXGTQDVy4zCZyIQDygwXYLYWLuqWZPmvE6A=;
        b=HWkt8qHqfm5LrMskvySPvThY+J6LOngRTVI8kA98eG4LZX5jYhjVEICTDykeUL1UOF
         yxk+lo6WDCd3XdriAjLhZUCwsLiHsDH9ZEB5hg+hOGN39HA3gURJdm4n3Uv0/zKXuqiA
         MsGZEW6tIPWYSLZoHjD2E5ST2q6YO/1LMeHkQI9UshjLNrqdDFMeYY/3tsO1VZrK4Fb8
         RyF1EmgbT9qSMFaZs2+98WvdUU+FLGPaiRCsxWQAjHGfsgKSWK7wH9rtlPBwGiQYFRyu
         KJjihN5U0dYKlPhZI8g6XoOpU4DT1kY5C/USxn/Q71lPcagMt2Orq1M/LI17kC0rZL+8
         OTKA==
X-Gm-Message-State: ABy/qLakl33ubS2+Ft2fRtYUJSE5zCrR6Z5IduK0HGvmDYaObFm8si17
        sjDAq9MkQPA/ZNDWwCkwgXnP+pUj6QpyJCAszQaaiw==
X-Google-Smtp-Source: APBJJlFqJY03v3hVPBUk7kCLDJ77BOkgCKN94dZ7P3pr7iS0QsyPGAj/AtcK/gqP57ki4etw525tow==
X-Received: by 2002:a05:6512:6c4:b0:4fd:c83b:a093 with SMTP id u4-20020a05651206c400b004fdc83ba093mr6483544lff.1.1690800757039;
        Mon, 31 Jul 2023 03:52:37 -0700 (PDT)
Received: from [192.168.1.101] (abyk53.neoplus.adsl.tpnet.pl. [83.9.30.53])
        by smtp.gmail.com with ESMTPSA id p13-20020a05651238cd00b004fdc7ec5cbesm2016936lft.300.2023.07.31.03.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 03:52:36 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 31 Jul 2023 12:52:21 +0200
Subject: [PATCH v2 05/10] interconnect: qcom: qcm2290: Hook up
 MAS_APPS_PROC's bus clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230726-topic-icc_coeff-v2-5-8c91c6c76076@linaro.org>
References: <20230726-topic-icc_coeff-v2-0-8c91c6c76076@linaro.org>
In-Reply-To: <20230726-topic-icc_coeff-v2-0-8c91c6c76076@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690800744; l=2199;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=wbL0knkbb9r2z/rU8oFtpvr0ZnPgIjvL/nER+Pi+b14=;
 b=F54RLC1nkOXm1+NJ9KBW35GMKssUAl/upy5JEMNXbvCl5C58zJHTCq9IxqTACqRZbGMShABx8
 F9eBe1EmhCyD8mGy/I8USvUDuSNKiMRPlF8oFfpATmduKCPgQXVzbES
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

This single node has its own clock which seems to be responsible for
transactions between CPUSS (CPU + some stuff) and the GNOC.

Define it and hook it up.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm-clocks.c | 6 ++++++
 drivers/interconnect/qcom/icc-rpm.h        | 1 +
 drivers/interconnect/qcom/qcm2290.c        | 3 +++
 3 files changed, 10 insertions(+)

diff --git a/drivers/interconnect/qcom/icc-rpm-clocks.c b/drivers/interconnect/qcom/icc-rpm-clocks.c
index 63c82a91bbc7..ac1677de7dfd 100644
--- a/drivers/interconnect/qcom/icc-rpm-clocks.c
+++ b/drivers/interconnect/qcom/icc-rpm-clocks.c
@@ -25,6 +25,12 @@ const struct rpm_clk_resource bimc_clk = {
 };
 EXPORT_SYMBOL_GPL(bimc_clk);
 
+const struct rpm_clk_resource mem_1_clk = {
+	.resource_type = QCOM_SMD_RPM_MEM_CLK,
+	.clock_id = 1,
+};
+EXPORT_SYMBOL_GPL(mem_1_clk);
+
 const struct rpm_clk_resource bus_0_clk = {
 	.resource_type = QCOM_SMD_RPM_BUS_CLK,
 	.clock_id = 0,
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index 1a26a7b82166..dc8e37c0a263 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -152,6 +152,7 @@ extern const struct rpm_clk_resource bimc_clk;
 extern const struct rpm_clk_resource bus_0_clk;
 extern const struct rpm_clk_resource bus_1_clk;
 extern const struct rpm_clk_resource bus_2_clk;
+extern const struct rpm_clk_resource mem_1_clk;
 extern const struct rpm_clk_resource mmaxi_0_clk;
 extern const struct rpm_clk_resource mmaxi_1_clk;
 extern const struct rpm_clk_resource qup_clk;
diff --git a/drivers/interconnect/qcom/qcm2290.c b/drivers/interconnect/qcom/qcm2290.c
index 3c3b24264a5b..52a6eb32e832 100644
--- a/drivers/interconnect/qcom/qcm2290.c
+++ b/drivers/interconnect/qcom/qcm2290.c
@@ -112,6 +112,9 @@ static struct qcom_icc_node mas_appss_proc = {
 	.qos.qos_mode = NOC_QOS_MODE_FIXED,
 	.qos.prio_level = 0,
 	.qos.areq_prio = 0,
+	.bus_clk_desc = &mem_1_clk,
+	.ab_coeff = 159,
+	.ib_coeff = 96,
 	.mas_rpm_id = 0,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(mas_appss_proc_links),

-- 
2.41.0

