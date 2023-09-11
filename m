Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD2779B0B0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352236AbjIKVsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241536AbjIKPKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:10:39 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F05CCC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:10:34 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-500c37d479aso7366869e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694445032; x=1695049832; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cRew6Oc+xnW64sLrM5CmEZevJKHbYAda+Rz+DKx8GYY=;
        b=c8tBQ5lftp9m9akfa7mZM7dN7m4KwCVDFJq0nKOBeqKJ4yI8VZ56cjYPI7lRFJdCM2
         FKHAXbwzVjpzJJrcs7ikjGOypdQXAN1qjhL0NFep3l9fXE6K2g2IJDJndET8SnLXDyti
         4cK3YafaiDpdqvomB6SJVTcu5CR1bn7vQulcO9ozcGrPOPSGfhfg1qI1BvyJGFXA/DR4
         LWjtvSbIw4QYqDaFILNrBv08Mjl/OzNUTmdgB8xnD9KKtgJwDhr1joGVdqUKkhIQUm5w
         055VW5VDbpFLSuGBQN9gdoVFDmNtYmmaJAcZ1A/zO913FlmnZD9BXCFwsBvqgopRNx5Z
         mevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694445032; x=1695049832;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cRew6Oc+xnW64sLrM5CmEZevJKHbYAda+Rz+DKx8GYY=;
        b=CYf/NXdPGuBKF9qyuo+aPgOwzVlb/WSo7kJYlTnWBJX9R2VycsSTkybZU8HsvqFPIp
         VVyCwtV4MRp+54laE1oY7eq5fb9gR6em97t/UZ28muHhZsssT8rGr1BYJELz+nfi5dVT
         UEd6RK3PRR52nOj27rj4stgG8OH9uFkOmHKg6u7vhtuPCBjEIQX5Y8/qLaQdwYjIAnrC
         VmrHLDDctf7ovW8Xr5ogexDo+hUHcXRrmcnrwvUh54M60RDdg/RMWHUILy+OdLn2DeyR
         6o4RKqHpaHt0XuiSNdWIHDjHGSLYUejBrd3fUyYVIDEmTlorJriS+T8gch9w609khVr4
         004A==
X-Gm-Message-State: AOJu0YzBIvQkQrLsZCXfe/UmAPObSZOchvdAbtgTzbofd9v0jPdkk/Hr
        nb+Uugv048WLR67288b0rGepkw==
X-Google-Smtp-Source: AGHT+IFfkZSm2SgFnvhjGd4bD/9sLJAIYrIZkLexHdh26IJHuK5vq8c5x59Jkl+1Eo6Zxjq3cqM2ew==
X-Received: by 2002:ac2:4ac7:0:b0:4fe:3364:6c20 with SMTP id m7-20020ac24ac7000000b004fe33646c20mr7707490lfp.16.1694445032494;
        Mon, 11 Sep 2023 08:10:32 -0700 (PDT)
Received: from [10.167.154.1] (178235177061.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.61])
        by smtp.gmail.com with ESMTPSA id n4-20020a056402060400b0052a3ad836basm4681281edv.41.2023.09.11.08.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 08:10:32 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 11 Sep 2023 17:10:16 +0200
Subject: [PATCH RFT 02/20] media: venus: pm_helpers: Rename core_clks_get
 to venus_clks_get
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-topic-mars-v1-2-a7d38bf87bdb@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694445027; l=1211;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=TgOAgouGXSGMwv5uLVeiQ7fWctx4QlplbsMWieUzcN8=;
 b=FYDz7Y0MnR3QEJGVvP5GQ5j94MwMMavqPgl3u+toJr8vc2WU+Y3EduelTYlplNMbzujrBy2KX
 P8X+Ht03HPVDwOddKScyKYBxKIzjGzq4d9Kg3QwC/YQBudw6SoFLNX9
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"core" is used in multiple contexts when talking about Venus, rename
the function to save on confusion.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/pm_helpers.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index 2bd9c63d0253..e2aec0b46126 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -23,7 +23,7 @@
 
 static bool legacy_binding;
 
-static int core_clks_get(struct venus_core *core)
+static int venus_clks_get(struct venus_core *core)
 {
 	const struct venus_resources *res = core->res;
 	struct device *dev = core->dev;
@@ -294,7 +294,7 @@ static int core_get_v1(struct venus_core *core)
 {
 	int ret;
 
-	ret = core_clks_get(core);
+	ret = venus_clks_get(core);
 	if (ret)
 		return ret;
 
@@ -978,7 +978,7 @@ static int core_get_v4(struct venus_core *core)
 	const struct venus_resources *res = core->res;
 	int ret;
 
-	ret = core_clks_get(core);
+	ret = venus_clks_get(core);
 	if (ret)
 		return ret;
 

-- 
2.42.0

