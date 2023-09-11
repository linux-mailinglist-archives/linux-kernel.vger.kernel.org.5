Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E090979B994
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354372AbjIKVxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241626AbjIKPLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:11:06 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A3BE40
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:10:58 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-502b1bbe5c3so2641966e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694445057; x=1695049857; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0gNkaBIazgKT+Y/aaQW0Dp8svWdByrrW7NRejS4t2Ug=;
        b=A5NXoSZwLCUoQ8zAjf6cEtcTmCKAuGGrtcWXWGyThsaeaB6lDRGc0WiOnJcVGtvNac
         pQlb1PQHamhoAoHdxmGotjByvy9fDDifIPJKtBrR/yU1uyoXjKcwJv6WwcXiPAbTIMGj
         DhDfSe2uFwKv6uKHuJTBU73wFIQqs5fPtTKgtfzUSGbV7D2ZTjW76CNIl/nzW4UbuzGi
         7A14BOrQv3dbWHa9d40TpmyKJNflzxG+oIgSlZ0BuitzD9PwvzDTEJ2vbRZ4vj15MZRw
         pzhswA666hpq7eQAfT84y1ewKa/5bjdef8Qal/f5szLT4I52AV24Rz59NtAGURRIDYo5
         koEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694445057; x=1695049857;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0gNkaBIazgKT+Y/aaQW0Dp8svWdByrrW7NRejS4t2Ug=;
        b=kn9JseqKdfD8whESHYlK9a63BJgezWAaAlgMw9L51MRoEBkVdKMRtcUo7FA2OkxL0J
         pWbmzaUAXp0TUBQtipZK7njpvvoPtwdO0pjbl+0ow30G+iiJe2OjERs+taw7IbeBHoh4
         nnLyqbl6wSDKT5Lja8DaO6wIXaZQ6NaiXXqzW6yDNjX9bGkGWP7vICNinZ4lkKV7Ncf8
         1c+Vp5KOlUpGwnjC9lLh1tRs8BZT/fOWYSoXbj1MglSD7YFbPAmLSCt/I9StS7o02aNK
         tX8pfJI5o4RurqWlJOZxIhf6fmHGHyiIbjBeN6XV5Qs8T1rKVezncKhOBgaEUIU15zLp
         HLoA==
X-Gm-Message-State: AOJu0Yz/+BgrKtquw1P9fzo8EjxSokON9lWECCVzbBj0vs4erEv+jfCf
        L9sSZ9nFfkLUO5evPz8HFBwJsA==
X-Google-Smtp-Source: AGHT+IGRRmd9cbWKL2C+2j8g6d3N2j7KaPpQujwQ3kO7WmwflLukyxC/cY9y2L25hhkwWSAoqRej/A==
X-Received: by 2002:a05:6512:3f12:b0:500:ae85:726a with SMTP id y18-20020a0565123f1200b00500ae85726amr9371919lfa.50.1694445056295;
        Mon, 11 Sep 2023 08:10:56 -0700 (PDT)
Received: from [10.167.154.1] (178235177061.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.61])
        by smtp.gmail.com with ESMTPSA id n4-20020a056402060400b0052a3ad836basm4681281edv.41.2023.09.11.08.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 08:10:55 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 11 Sep 2023 17:10:30 +0200
Subject: [PATCH RFT 16/20] media: venus: core: Define a pointer to
 core->res
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-topic-mars-v1-16-a7d38bf87bdb@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694445027; l=2168;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=h0rj/gVk7sNYWd0OnhVJyfmqxcpbrM1z4NX1ZnW541Y=;
 b=ZTp+yrpjwxhoaPMuA3VDx8wXXn68xxaAwLIajdjPm4nahBeYbl/yf7S7ls/PvJL8MDwmdK5Gx
 U20wG71OwSuCLVxUYbZ+B4uDxt3mZjXMOnoc1tapNNiGX8OBrhjUiUA
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make the code more concise, define a new variable 'res' pointing to
the abundantly referenced core->res.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 9a1b0be5d067..435f6f10a905 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -283,6 +283,7 @@ static irqreturn_t venus_isr_thread(int irq, void *dev_id)
 
 static int venus_probe(struct platform_device *pdev)
 {
+	const struct venus_resources *res;
 	struct device *dev = &pdev->dev;
 	struct venus_core *core;
 	int i, ret;
@@ -313,9 +314,11 @@ static int venus_probe(struct platform_device *pdev)
 	if (!core->res)
 		return -ENODEV;
 
+	res = core->res;
+
 	mutex_init(&core->pm_lock);
 
-	core->pm_ops = venus_pm_get(core->res->hfi_version);
+	core->pm_ops = venus_pm_get(res->hfi_version);
 	if (!core->pm_ops)
 		return -ENODEV;
 
@@ -323,14 +326,14 @@ static int venus_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	core->resets = devm_kcalloc(dev, core->res->resets_num, sizeof(*core->resets), GFP_KERNEL);
-	if (core->res->resets_num && !core->resets)
+	core->resets = devm_kcalloc(dev, res->resets_num, sizeof(*core->resets), GFP_KERNEL);
+	if (res->resets_num && !core->resets)
 		return -ENOMEM;
 
-	for (i = 0; i < core->res->resets_num; i++)
-		core->resets[i].id = core->res->resets[i];
+	for (i = 0; i < res->resets_num; i++)
+		core->resets[i].id = res->resets[i];
 
-	ret = devm_reset_control_bulk_get_exclusive(dev, core->res->resets_num, core->resets);
+	ret = devm_reset_control_bulk_get_exclusive(dev, res->resets_num, core->resets);
 	if (ret)
 		return ret;
 
@@ -340,7 +343,7 @@ static int venus_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	ret = dma_set_mask_and_coherent(dev, core->res->dma_mask);
+	ret = dma_set_mask_and_coherent(dev, res->dma_mask);
 	if (ret)
 		goto err_core_put;
 

-- 
2.42.0

