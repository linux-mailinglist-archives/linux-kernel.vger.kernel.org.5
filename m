Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951E575E373
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 18:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjGWQKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 12:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjGWQKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 12:10:17 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B258E7E;
        Sun, 23 Jul 2023 09:09:48 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-992f15c36fcso624269966b.3;
        Sun, 23 Jul 2023 09:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690128563; x=1690733363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nA1IXoblbGcTRPbYr/vN/81mKW6fq6S+ZkLioQzIX0I=;
        b=R9GX4n0zrjH/JwkSD1MhAKnxJKk82PhEclnVcHItsIu7N/Mi54J5bw3PXkY+MawXYg
         RyGa1j1bNVqcX/8yMSMolTk5n2g+21mEqtF5uWPtdfpR0MEwyQiAmdwx+1oRc+QTT2m3
         vtPsEmod1iA/M5D9c81m7WkA5MRN5up5RXn7wxtkVKR9ddhzh49ntjJwCtOmylKdvbqH
         DGGn8AR2U4dkSb0avJB0YLXEjK4BxC3q7zh1+9q85IYnNVMBfYs62yor0BnX201IVLSk
         z2tAK8ci7oCGURSXvgkzxWVlusazrL2MmqBVxnQxuQNhIbLVtHPJ3D4DNXNbKbbhcoCM
         Q/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690128563; x=1690733363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nA1IXoblbGcTRPbYr/vN/81mKW6fq6S+ZkLioQzIX0I=;
        b=JFNIQgvKkdKL/n5hyJBAHz68STG5Ys6xMCQSgmy+CdUHs6L+QS6bUpaz65WGlb7ehF
         EWCZK69qgr6qSWIr3TR0suKhk3Aov4Jw8kUQ/qUj2HS4tM+7UdkJAVF1HeTsoIc3Jk2z
         Dvcr6x7tFeVc/jniKIJXhUEMckfTtKy9Fu+i4KDmYKNOqC/ih+H0HBj7ehZ0XQ3cZLnR
         qIIP8LXpq0eBSi4eXUN4DgWxFsvvAMarafjWUrRB4KCnV6RvjuQa4zQDRv02g93x2Ew4
         DgoMyuAXuDNLP4KS2GAZemYwKW2231CS+gWc5jpv9grVL/fBXnB/7K3x2MMMIrqt4/M8
         rWMw==
X-Gm-Message-State: ABy/qLZ0ket3I/d6cCrDXt6vqjB5BwydyS1TsUho3bJZ0csYhnfwiSyx
        NXP7/zZtDSptNlNatBu85zPoYhB6ykE=
X-Google-Smtp-Source: APBJJlGcNwru9+jeQSIMste212J0qxhZOOY00CK47YlVz9kAFZHG+3jLO/MjeeU8DdbO+cTBv3rQAw==
X-Received: by 2002:a17:906:76cd:b0:993:f12a:39ce with SMTP id q13-20020a17090676cd00b00993f12a39cemr8202198ejn.15.1690128562641;
        Sun, 23 Jul 2023 09:09:22 -0700 (PDT)
Received: from localhost.localdomain (ccx116.neoplus.adsl.tpnet.pl. [83.30.147.116])
        by smtp.gmail.com with ESMTPSA id u16-20020a170906951000b0099b4d86fbccsm5425039ejx.141.2023.07.23.09.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 09:09:22 -0700 (PDT)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] drivers: soc: qcom: rpmpd: Fix MSM8976 power domains setup
Date:   Sun, 23 Jul 2023 18:08:20 +0200
Message-Id: <20230723160827.22660-2-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230723160827.22660-1-a39.skl@gmail.com>
References: <20230723160827.22660-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
---
 drivers/soc/qcom/rpmpd.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index 3135dd1dafe0..59caa4e7b99a 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
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
2.25.1

