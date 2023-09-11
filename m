Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62DB979B8EC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245432AbjIKVJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241535AbjIKPKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:10:38 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AD9E4D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:10:32 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so12126332a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694445031; x=1695049831; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NUyRxR/Uia4+TvtVoZgzosqJP54jI70l0Rb5PTxSIO0=;
        b=Meh/e4xCpV26Fw/nFq8XX2zwuLP1q4ZYCG1BALo+J3L7bQVdN4qIrLKywp+xA/jKdo
         7RrKnS8xslS0DhkF+KwETOGxqrxyJgpP78aUNLIj0icVSPxz9G9fwTIYlMKQcYxcrI3o
         NJkgcnLnZpPuCG+945js/6V4gTiWXlTEYguALO+eiNNFFXBOGJ4oW+shjove8XLpIZ2r
         bMw0Omv7Ql3gEwwb+psYIo4PC9yYxeFZhCrMgn0Z8X67EpFf/BrTxdn9YqN1mytDsvaY
         FjRgaPdIsPrjTQSy1L9xRORXBF6Iss9nmHNK8LwQV2KFoYPZ30ifYlq1nF15B//fsiOe
         KfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694445031; x=1695049831;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NUyRxR/Uia4+TvtVoZgzosqJP54jI70l0Rb5PTxSIO0=;
        b=aQAaEH2f2X2PLYmBj9rMeArNxR50PJSY6MR0lC8ziMxvn4ejVbzqzDXo8HillOxcVK
         AAr9AgqOc7h0l7agMOMkIxUkNUn/OF39+JbiH7QFhRFEAUC+B2GGZ0AeP4hemjRJcMRj
         ll/4gjFkZi4+yTbxGsPsMKJMo0Oir+TmbBdahJrSKM481jf01hGYuZMd1g/8i/r1dXXL
         nVzCuZHQhmjmJph6mABcq4tzqne7hwLtgda0hkyJ/HFL1xDrCLOYLsENMODsXw8Q3156
         5w8wfrt0Hb1z3k4vgxUPWlk12zxQDRitQ/duNHm3GGnMFWVJ9A0ePFVixJ0sR9a6Doyw
         9+2Q==
X-Gm-Message-State: AOJu0Yz1Lw7qGe7EeAwJ9H1fJQ8/PwjRkIuLvCYuwtZ4ypvTBCLx3BH1
        sFe0HxEp6bY1vKliq6zzkN14gg==
X-Google-Smtp-Source: AGHT+IE+SVOvneVGxhxBtIgNA1anBmfCL+Ck3qG8GDP0HLi2b0fxHi9SfaS964iY6COpCxibjHNRVg==
X-Received: by 2002:a05:6402:4405:b0:52e:83d0:203e with SMTP id y5-20020a056402440500b0052e83d0203emr18329671eda.10.1694445030938;
        Mon, 11 Sep 2023 08:10:30 -0700 (PDT)
Received: from [10.167.154.1] (178235177061.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.61])
        by smtp.gmail.com with ESMTPSA id n4-20020a056402060400b0052a3ad836basm4681281edv.41.2023.09.11.08.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 08:10:30 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 11 Sep 2023 17:10:15 +0200
Subject: [PATCH RFT 01/20] media: venus: pm_helpers: Only set rate of the
 core clock in core_clks_enable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-topic-mars-v1-1-a7d38bf87bdb@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694445027; l=1871;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=i0/wTGlR4xRp/57GwLT2PI2teveudhcMu4mGxZQVimE=;
 b=qP4UIXuf88KhwG3ipF2dvMc9LqIsJxto52OAUHUVlVlc/O1A/F94OrRRd7AZqQ5j8nS2Ix201
 ucrzgifxSQHAQ4TC7i+TUdhmrViXVYE4JOUlMFtKEsYXwaV5cDRdFU+
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

Commit c22b1a29497c ("media: venus: core,pm: Vote for min clk freq
during venus boot") intended to up the rate of the Venus core clock
from the XO minimum to something more reasonable, based on the per-
SoC frequency table.

Unfortunately, it ended up calling set_rate with that same argument
on all clocks in res->clks. Fix that using the OPP API.

Fixes: c22b1a29497c ("media: venus: core,pm: Vote for min clk freq during venus boot")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/pm_helpers.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index 48c9084bb4db..2bd9c63d0253 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -41,24 +41,23 @@ static int core_clks_get(struct venus_core *core)
 static int core_clks_enable(struct venus_core *core)
 {
 	const struct venus_resources *res = core->res;
-	const struct freq_tbl *freq_tbl = core->res->freq_tbl;
-	unsigned int freq_tbl_size = core->res->freq_tbl_size;
-	unsigned long freq;
+	struct dev_pm_opp *opp;
+	unsigned long freq = 0;
 	unsigned int i;
 	int ret;
 
-	if (!freq_tbl)
-		return -EINVAL;
+	if (core->has_opp_table) {
+		opp = dev_pm_opp_find_freq_ceil(core->dev, &freq);
+		if (IS_ERR(opp))
+			return PTR_ERR(opp);
+		dev_pm_opp_put(opp);
 
-	freq = freq_tbl[freq_tbl_size - 1].freq;
+		ret = dev_pm_opp_set_rate(core->dev, freq);
+		if (ret)
+			return ret;
+	}
 
 	for (i = 0; i < res->clks_num; i++) {
-		if (IS_V6(core)) {
-			ret = clk_set_rate(core->clks[i], freq);
-			if (ret)
-				goto err;
-		}
-
 		ret = clk_prepare_enable(core->clks[i]);
 		if (ret)
 			goto err;

-- 
2.42.0

