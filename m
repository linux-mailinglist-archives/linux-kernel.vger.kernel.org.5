Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B368075E25A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 16:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjGWOHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 10:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjGWOHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 10:07:36 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA60E70;
        Sun, 23 Jul 2023 07:07:34 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b703caf344so48182541fa.1;
        Sun, 23 Jul 2023 07:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690121253; x=1690726053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6gGoSMkFuHXtajQB/WUOa8a8eVkA/mLa0sBAjisK8c8=;
        b=LjKB6N787aelnjZZiFNGxyXnzk+tG5mbL3hV0YHHDsnFEKw3hj2G7a4g8gQD57GiUc
         Oe5+sNC2RwVADMycaUzNfC0hQHFQDutv/9JE+okTiSoWBSoS77XffbQVAMtWpM9LT/9G
         Gxw2Hwvj6rNSq+WZu/pVgAGxzujma/oSONbbS1S97RUA0h7ziC+ehaMiGAD+BrfsUQuT
         jA6kwYvZJmkkA2obOWvPWayX05/EpusKIqTjsESTQ8/mkyuiYCgHEui6DqHHc2QI51yv
         gRRhrM5mWrzodeH7H+CrbhUyxHT8GAZrHUPK3I52oBpn9OMsDk8TEu8I6xP8ViUnQCax
         CZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690121253; x=1690726053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6gGoSMkFuHXtajQB/WUOa8a8eVkA/mLa0sBAjisK8c8=;
        b=lhU0wYSn1gv4SjgQMzw8hlNHtwMY2Qb6lL+UwxhvYVtHaldlihEaEmGyba909O0f4F
         X+JaTYluuhYE6ufKYoYHjCHR//fWURawR3nt2jdORwW9L3yX6NLnq7AGuE0KXFbUlVZF
         /Jzfcom9a6Zqxk3Z0lVBQ5+eTn00V+Ki+v4DcYZF+C0YFZhIry/yhh23Js8v0FxM2vRz
         34saYG6Bh8jwGmwOYNUBXmKd9vsx0RXvqWWoZ59KeI/svyg9QFrk0yMfCTKw0AG/Blpa
         slXu4u0pfunLhR16giEw5TtbvePB/eddaagH9bcDN8XK0Kv2ja5+MJoOe+ojx39QcelD
         ud1g==
X-Gm-Message-State: ABy/qLb1isKhhu2yn/K0cJDIb2ZFdETfiNBythTtZtelZOm4/8+BEjqp
        6qBoHdCMszMcXusFsH/jwbahxS97y/Ogyw==
X-Google-Smtp-Source: APBJJlEPVVooZlfoEODVTjUtkTLca1nNFTXxzleHzrWBMZQvgIa66cmpIVTOf/sz95pYEnm8Jt1+xA==
X-Received: by 2002:a05:6512:2826:b0:4f8:58ae:8ea8 with SMTP id cf38-20020a056512282600b004f858ae8ea8mr4019183lfb.58.1690121252700;
        Sun, 23 Jul 2023 07:07:32 -0700 (PDT)
Received: from localhost.localdomain (ccx116.neoplus.adsl.tpnet.pl. [83.30.147.116])
        by smtp.gmail.com with ESMTPSA id o2-20020a05651238a200b004fbcd542888sm1688366lft.60.2023.07.23.07.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 07:07:32 -0700 (PDT)
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
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] drivers: soc: qcom: rpmpd: Fix MSM8976 power domains setup
Date:   Sun, 23 Jul 2023 16:06:48 +0200
Message-Id: <20230723140712.9438-2-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230723140712.9438-1-a39.skl@gmail.com>
References: <20230723140712.9438-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 drivers/soc/qcom/rpmpd.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index 3135dd1dafe0..69bc7c4d0ace 100644
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
@@ -328,6 +321,12 @@ static struct rpmpd mx_s6a_lvl_ao = {
 	.res_id = 6,
 	.key = KEY_LEVEL,
 };
+static struct rpmpd mx_s6a_vfl = {
+	.pd = { .name = "mx_vfl", },
+	.res_type = RPMPD_SMPA,
+	.res_id = 6,
+	.key = KEY_FLOOR_LEVEL,
+};
 
 static struct rpmpd mx_s7a_lvl_ao;
 static struct rpmpd mx_s7a_lvl = {
@@ -361,12 +360,6 @@ static struct rpmpd mx_rwmx0_vfl = {
 	.key = KEY_FLOOR_LEVEL,
 };
 
-static struct rpmpd mx_rwsm6_vfl = {
-	.pd = { .name = "mx_vfl", },
-	.res_type = RPMPD_RWSM,
-	.res_id = 6,
-	.key = KEY_FLOOR_LEVEL,
-};
 
 /* MD */
 static struct rpmpd md_s1a_corner_ao;
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

