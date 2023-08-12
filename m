Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0968A779FA6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 13:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237190AbjHLL1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 07:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237153AbjHLL1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 07:27:05 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47260110;
        Sat, 12 Aug 2023 04:27:08 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fe0d5f719dso4595001e87.2;
        Sat, 12 Aug 2023 04:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691839626; x=1692444426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+h1oifnrpXqv9m5WYHz5k9vtsNuiSUipLXcMaDZpWw=;
        b=fQuxhl31bCPGN4jJYbNx7qNvVlgI9X+s8aV+Adtt5l1oRsyHUeeTQ2TBN4Rx56myVp
         qTd1c+k6WYXf3vQAOK6sromsNMKyKqOJltr+2vdRkvQSsO01gxoVRsrJRwQuL3neGVZq
         JSm9wJ63t+yhYg3xWk3a0qy+qo9z/KWzHRrx+43IR/n0gOgGwuu3EO3V8fy/qvlBXjVU
         dgA8UAD7q26+JpdjsCk97kPt4qnr3/ZqroKhwYop8z71mTZtZueyHjj+LjQes6kL/DfL
         +ARbqoZQpVA6nqUnTLZjEL5Nk5kM+lI4j51RFJYl5+FXESgSCeTcAbkRz4gNo5LQ+Hb2
         0GXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691839626; x=1692444426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+h1oifnrpXqv9m5WYHz5k9vtsNuiSUipLXcMaDZpWw=;
        b=mCRIY/p+V87nMD0ygZZ+SeUANlibHW4P3YNQtzD8cTHOSww5q5L6sL6+XcxVQXnQtu
         7fADXyzoe3kpLYchOE5zi4D+sS/IgzXkXB2QHoZuclZ5/jegQCduWQqIIsdxw1xqt6s6
         A1jClj2BBOKdndUiG4R1Fv6RCH2I1qwbSv41qOGZWmXpfBl2RAH2mN7odITnySsluvn2
         VVy6pBKBIixitAScmNl4mM5px7DTKT+UVHoKYoT7foZx+R+7ui0HSY2QfwneMYGugYJh
         GB+5zIKm1xhaMWjFAk+xSEUhCLyP7WwX/md6Rnhs/VLII8+9kFvfJdckdEuT9B+YcR/j
         czVg==
X-Gm-Message-State: AOJu0YyylcsrWkD7Hh5A65cRTVKMq8OiQnTQ2EjNN/EPm1DajSi0cckZ
        Wq1V3jKdNzh+ScTC1F0CtDn2xTEZV9mcvQ==
X-Google-Smtp-Source: AGHT+IEHbH2+QdFr+G+1njj4ev/NPxCkrOjv2quq8rE4nGIb/Z/gHR/4Rz5DfQgyjwCDyolHnB07Hg==
X-Received: by 2002:a05:6512:12c3:b0:4fb:8bcd:acd4 with SMTP id p3-20020a05651212c300b004fb8bcdacd4mr3859532lfg.37.1691839626236;
        Sat, 12 Aug 2023 04:27:06 -0700 (PDT)
Received: from localhost.localdomain (bzd150.neoplus.adsl.tpnet.pl. [83.30.49.150])
        by smtp.gmail.com with ESMTPSA id w3-20020ac24423000000b004fe2f085d5csm1087289lfl.299.2023.08.12.04.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 04:27:05 -0700 (PDT)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v3 1/7] drivers: genpd: qcom: rpmpd: Fix MSM8976 power domains setup
Date:   Sat, 12 Aug 2023 13:24:44 +0200
Message-Id: <20230812112534.8610-2-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230812112534.8610-1-a39.skl@gmail.com>
References: <20230812112534.8610-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Downstream kernel parses resource names based on pm8950-rpm-regulator.dtsi
in such file qcom,resource-name takes three values: smpa,ldoa and clk0.
First appearance of RWSC/RWSM point to msm-4.4 kernel
which is way newer than what this platform was shipped with (msm-3.10).
For the max_state downstream code limit value to TURBO inside dts
with only one turbo_high being placed in msm-thermal bindings.
One of effects of requesting TURBO_HIGH vote is rebooting of device
which happens during voting inside WCNSS/IRIS,
this behavior was observed on LeEco S2 smartphone.
Fix regulator setup and drop unused resources.

Fixes: b1d522443b4b ("soc: qcom: rpmpd: Add rpm power domains for msm8976")
Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/genpd/qcom/rpmpd.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/genpd/qcom/rpmpd.c b/drivers/genpd/qcom/rpmpd.c
index 3135dd1dafe0..59caa4e7b99a 100644
--- a/drivers/genpd/qcom/rpmpd.c
+++ b/drivers/genpd/qcom/rpmpd.c
@@ -166,13 +166,6 @@ static struct rpmpd cx_rwcx0_vfl = {
 	.key = KEY_FLOOR_LEVEL,
 };
 
-static struct rpmpd cx_rwsc2_vfl = {
-	.pd = { .name = "cx_vfl", },
-	.res_type = RPMPD_RWSC,
-	.res_id = 2,
-	.key = KEY_FLOOR_LEVEL,
-};
-
 static struct rpmpd cx_s1a_vfc = {
 	.pd = { .name = "cx_vfc", },
 	.res_type = RPMPD_SMPA,
@@ -329,6 +322,13 @@ static struct rpmpd mx_s6a_lvl_ao = {
 	.key = KEY_LEVEL,
 };
 
+static struct rpmpd mx_s6a_vfl = {
+	.pd = { .name = "mx_vfl", },
+	.res_type = RPMPD_SMPA,
+	.res_id = 6,
+	.key = KEY_FLOOR_LEVEL,
+};
+
 static struct rpmpd mx_s7a_lvl_ao;
 static struct rpmpd mx_s7a_lvl = {
 	.pd = { .name = "mx", },
@@ -361,13 +361,6 @@ static struct rpmpd mx_rwmx0_vfl = {
 	.key = KEY_FLOOR_LEVEL,
 };
 
-static struct rpmpd mx_rwsm6_vfl = {
-	.pd = { .name = "mx_vfl", },
-	.res_type = RPMPD_RWSM,
-	.res_id = 6,
-	.key = KEY_FLOOR_LEVEL,
-};
-
 /* MD */
 static struct rpmpd md_s1a_corner_ao;
 static struct rpmpd md_s1a_corner = {
@@ -591,16 +584,16 @@ static const struct rpmpd_desc msm8953_desc = {
 static struct rpmpd *msm8976_rpmpds[] = {
 	[MSM8976_VDDCX] =	&cx_s2a_lvl,
 	[MSM8976_VDDCX_AO] =	&cx_s2a_lvl_ao,
-	[MSM8976_VDDCX_VFL] =	&cx_rwsc2_vfl,
+	[MSM8976_VDDCX_VFL] =	&cx_s2a_vfl,
 	[MSM8976_VDDMX] =	&mx_s6a_lvl,
 	[MSM8976_VDDMX_AO] =	&mx_s6a_lvl_ao,
-	[MSM8976_VDDMX_VFL] =	&mx_rwsm6_vfl,
+	[MSM8976_VDDMX_VFL] =	&mx_s6a_vfl,
 };
 
 static const struct rpmpd_desc msm8976_desc = {
 	.rpmpds = msm8976_rpmpds,
 	.num_pds = ARRAY_SIZE(msm8976_rpmpds),
-	.max_state = RPM_SMD_LEVEL_TURBO_HIGH,
+	.max_state = RPM_SMD_LEVEL_TURBO,
 };
 
 static struct rpmpd *msm8994_rpmpds[] = {
-- 
2.41.0

