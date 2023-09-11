Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E77C79BFA8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357694AbjIKWFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241555AbjIKPKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:10:44 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43692CCC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:10:39 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-52a1ce529fdso6050105a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694445037; x=1695049837; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hB07AWQ6+/HjqLThhLj5XIDObxfEfer4Yjs2PDgZbco=;
        b=ZOtQyqzyDIvSBpOgiZn5wCN03fcMB8DKKexIkzt9gck0m4rhhhRweF+RLj+E1x22b0
         W7HTTlJx9v73qxNjbP4ARBv8I6j2nnXKPllW0xMgQ+HZ4HL0XNtKfm4CFi0gE31dmSp4
         zdxnYymR6lcOQwNj0Hqg05RxA8xM0qHorJY4Vlp7uS53wpywrg93uT0fC5ndfp/K4iI5
         ep9jV30RkrC5j3AJFzrmgI62IxTAHcjLDnNsZg1E8BdX+b6tliC/h2X7i1ss8XP70NWV
         NjAJ3ozguAZdqlaV5LELJY3LgGJPBO8jH3t3y+D2zNCwP8M5lbtNE808bhdwumgTSsax
         oFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694445037; x=1695049837;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hB07AWQ6+/HjqLThhLj5XIDObxfEfer4Yjs2PDgZbco=;
        b=Z4iso+CA5OkeDApHYeH8aC1NcZbEttWdgiHT/Xl0qadsR7K9mZ9aEeYvWxlCtF2Nxi
         NlQrn5g3ZPSbWfDKopbHQOgRpC96esEKgO+Y+u9ESIsOeHvJ+MGUJO8pHsqWVHYUzX3p
         ActtjurhCzynz0xlvfTSZ6nicVRJsOOpFFwvi4shsk2bh1+GrCDSunsCzQP2W/WcFDp2
         mBcwhtIGG/y8WrjhuYdphODfzU/hulWWu566I7IfgNnQG1ie2M+Dm8AdnlRH+kYNL4F8
         e0JEOkfkLbm2/AaP6f0l06K50sOeEP15JnaTQv101gUwK/wWwkpVkVtSqnSMZhNBEC8c
         34UA==
X-Gm-Message-State: AOJu0YwQ7fgRjdfCAm2eblOXXbQqM00jUE8k5LPNwO3A+L0Ls/N8vh2b
        lv+QsjAQWXCueOXjxLiExo9pzQ==
X-Google-Smtp-Source: AGHT+IHJPABWpI7Eq8rnPAY/s+Tohmf2Ji1RKKVtBhUqvuYbf4fo8qwJMluBqGhBSsrvs20bqX1bFg==
X-Received: by 2002:a05:6402:8c3:b0:522:20a0:7eb8 with SMTP id d3-20020a05640208c300b0052220a07eb8mr7959403edz.33.1694445037678;
        Mon, 11 Sep 2023 08:10:37 -0700 (PDT)
Received: from [10.167.154.1] (178235177061.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.61])
        by smtp.gmail.com with ESMTPSA id n4-20020a056402060400b0052a3ad836basm4681281edv.41.2023.09.11.08.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 08:10:37 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 11 Sep 2023 17:10:19 +0200
Subject: [PATCH RFT 05/20] media: venus: pm_helpers: Kill dead code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-topic-mars-v1-5-a7d38bf87bdb@linaro.org>
References: <20230911-topic-mars-v1-0-a7d38bf87bdb@linaro.org>
In-Reply-To: <20230911-topic-mars-v1-0-a7d38bf87bdb@linaro.org>
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694445027; l=2141;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=QMvOYSIDhNKQG6pzBZaUv6e9JhH/er8ZMPeUWk6srGI=;
 b=XK0JQo551H+KBf+i/fiVuIM7cxliwEN1dSWCIJuOIUFCAvdHNT1EBk3XeoIB/hy/oghd/Gh6b
 LIBRGGfXgMcCgxb3Vkt4cp666O9latCD1vNrsCFGEnccpEky0ql/Vv1
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A situation like:

if (!foo)
	goto bar;

for (i = 0; i < foo; i++)
	...1...

bar:
	...2...

is totally identical to:

for (i = 0; i < 0; i++) // === if (0)
	...1...

...2...

Get rid of such boilerplate.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/pm_helpers.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index 9bedb3bc7223..f5130aa3ddfc 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -875,9 +875,6 @@ static int vcodec_domains_get(struct venus_core *core)
 	struct device *pd;
 	unsigned int i;
 
-	if (!res->vcodec_pmdomains_num)
-		goto skip_pmdomains;
-
 	for (i = 0; i < res->vcodec_pmdomains_num; i++) {
 		pd = dev_pm_domain_attach_by_name(dev,
 						  res->vcodec_pmdomains[i]);
@@ -886,7 +883,6 @@ static int vcodec_domains_get(struct venus_core *core)
 		core->pmdomains[i] = pd;
 	}
 
-skip_pmdomains:
 	if (!core->res->opp_pmdomain)
 		return 0;
 
@@ -922,16 +918,12 @@ static void vcodec_domains_put(struct venus_core *core)
 	const struct venus_resources *res = core->res;
 	unsigned int i;
 
-	if (!res->vcodec_pmdomains_num)
-		goto skip_pmdomains;
-
 	for (i = 0; i < res->vcodec_pmdomains_num; i++) {
 		if (IS_ERR_OR_NULL(core->pmdomains[i]))
 			continue;
 		dev_pm_domain_detach(core->pmdomains[i], true);
 	}
 
-skip_pmdomains:
 	if (!core->has_opp_table)
 		return;
 
@@ -945,9 +937,6 @@ static int core_resets_reset(struct venus_core *core)
 	unsigned int i;
 	int ret;
 
-	if (!res->resets_num)
-		return 0;
-
 	for (i = 0; i < res->resets_num; i++) {
 		ret = reset_control_assert(core->resets[i]);
 		if (ret)
@@ -970,9 +959,6 @@ static int core_resets_get(struct venus_core *core)
 	unsigned int i;
 	int ret;
 
-	if (!res->resets_num)
-		return 0;
-
 	for (i = 0; i < res->resets_num; i++) {
 		core->resets[i] =
 			devm_reset_control_get_exclusive(dev, res->resets[i]);

-- 
2.42.0

