Return-Path: <linux-kernel+bounces-161046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AE58B4649
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 14:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EBA2288C40
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 12:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3C74D9F9;
	Sat, 27 Apr 2024 12:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gJiA18u/"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971F8383B2
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 12:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714219275; cv=none; b=oCiikViYJY/XigyGNmr7u+3NmSyc2VtcpGQDA9kChbyxXMLDzFecAgirgJa11cv9iP8c5ZMhg4zmymk1mMhO0NF5b5arKhJA9FG2WFA/2G8XwtsaFk+wbB2PiK/vLAMWc7JkcycvzI1UDzAoLAlNNFgrdwM+zd7AmQDQEVl+OPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714219275; c=relaxed/simple;
	bh=GSvOEBFXHoGc6KMTfKG8BFzHpyuochW40eZKNzW32JE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=icswNVnZfKeorZ/R0YX/oNHR+b0wdauQnpOLU/UCHPNVqiRWm30vsdk20d/9RY/WUnRK6PnF7xshWykV1n4WXBz0DCa467Hp1lkZKTFS2WXxf1NkDnCVrvk1LUCB5UAEwB56KNDJOmo6saR79FB/IZZSnIqx4mgHtc+DGxBmi84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gJiA18u/; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-571bddddbc2so3722291a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 05:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714219271; x=1714824071; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f9f/cpW0XeI0dWmGiPWyivG3BGF1w20mveSHrB3JwLk=;
        b=gJiA18u/+S+3vteegEH924GF6v7C3y3ktEkVYZ7ddDDUUcuufQcTGOXKGD0qLn+2z6
         nU8j9EdfsTvNxkRpQSKEp39eXgei9LQyfQyZ6Gjml5waXcPF0rq4+lp8oTS7Pq9T0iD5
         aCpIfgIOMgyNy41QYvo5dhU39CcSiXPEKK5j5GQ9LdzfDlsfWsGV+T5Yc9nsVcU+pP+J
         yyP2JgfUVPRrbGVdWg3zVbieNDsltWF7tugU2JINIIWpQmL9IiHgAUJDZkG3jEVbHy59
         kYqmDSkZJWbUirbUNZgjJEiEaTARC8MjHd7bZ7yKSpWhEs6prbZZ3e6N0umtTVMN1Xwp
         ZvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714219271; x=1714824071;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f9f/cpW0XeI0dWmGiPWyivG3BGF1w20mveSHrB3JwLk=;
        b=AQvGzzwwYI58Ax5u+IVVdJa4PfmLyk4bUrSciuOBYWWsvvI9M4XJy77haG31RKkgvG
         Gc7zRykvSNWgqbjPdCw1XYs/sUhBehZIbeoKM/c9c3VtNjhsaxl4KAq+flGmcGhxGzje
         ozIK2LABUYw8yAy2ozjPRVBcS2aIIDcpZ+ntbDmp2yE1szlgn1IRErcUbP8FDzuoCgkx
         gAYXpA9EX9hcRpY9WFKy9N4PZFZtxFZA3QFx41JbzoXV6J+EXAaLx7Ps2MLLxzkhu1B3
         Zm526M5mwiloVR00skPbACtHegcNbXaiaTpfhHGkX2jJ1w6hzePKZhrwiYN6B/B8Dt5l
         kTWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXs0N9oX/XIopByj2xLh7t93YV8ItX9lBShIwqp6kvwmfsgajCcXkH4pzRpPdwhimJvs3jRimvQ5tBQasNl/CnDSjhtXo1ZJIrr//0s
X-Gm-Message-State: AOJu0Yw6kupEnWdGOzqJH1nVywof7i61yjRcW9LgCuX7q7HDZhezc9QI
	1h7xzTsNOPSqcYOEvayIv51LW8o/pVnPfr6IxcVmzqyCJefWwzCaXRXOBHxYcyQ=
X-Google-Smtp-Source: AGHT+IEbkf/8tKlHPVtR4G9yGchH56fR4TRNu2Jsq2wFBeKbdiDerOlnuxdg+wrJj8zoaoeAhM7F+w==
X-Received: by 2002:a05:6402:4344:b0:572:71b3:3c4d with SMTP id n4-20020a056402434400b0057271b33c4dmr531402edc.34.1714219270806;
        Sat, 27 Apr 2024 05:01:10 -0700 (PDT)
Received: from [192.168.114.15] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id l6-20020aa7d946000000b005723151e99asm3845314eds.95.2024.04.27.05.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 05:01:10 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Sat, 27 Apr 2024 14:01:07 +0200
Subject: [PATCH] clk: qcom: gcc-sm8450: set OPS_PARENT_ENABLE on
 gcc_sdcc2_apps_clk_src
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240427-topic-8450sdc2-v1-1-631cbb59e0e5@linaro.org>
X-B4-Tracking: v=1; b=H4sIAALpLGYC/x3MQQqAIBBA0avErBPUjKSrRAvTsWajohGBePek5
 Vv8X6FgJiywDhUyPlQohg4xDmAvE05k5LpBcqm4kgu7YyLLtJp5cVayyVuPBwrUxkGPUkZP7z/
 c9tY+2eDW3WAAAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714219268; l=1319;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=GSvOEBFXHoGc6KMTfKG8BFzHpyuochW40eZKNzW32JE=;
 b=q/ojXBP9DGmv83YzSffQUKiOa2EJtP8mw16lIw264BpFw8YFs6+27+zLYcY1F+HD5kXLfSW12
 B/uCbTFr764C9gPhETN6FppKXvJ/2yt1q8USA3shSiiagw4Q+5GUkx0
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Similar to how it works on other SoCs, the top frequency of the SDHCI2
core clock is generated by a separate PLL (peculiar design choice) that
is not guaranteed to be enabled (why does the clock framework not handle
this by default?).

Add the CLK_OPS_PARENT_ENABLE flag to make sure we're not muxing the
RCG input to a dormant source.

Fixes: db0c944ee92b ("clk: qcom: Add clock driver for SM8450")
Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/gcc-sm8450.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-sm8450.c b/drivers/clk/qcom/gcc-sm8450.c
index e86c58bc5e48..9a1d48ff22bc 100644
--- a/drivers/clk/qcom/gcc-sm8450.c
+++ b/drivers/clk/qcom/gcc-sm8450.c
@@ -935,7 +935,7 @@ static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
 		.name = "gcc_sdcc2_apps_clk_src",
 		.parent_data = gcc_parent_data_7,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_7),
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
 		.ops = &clk_rcg2_floor_ops,
 	},
 };

---
base-commit: c0b832517f627ead3388c6f0c74e8ac10ad5774b
change-id: 20240427-topic-8450sdc2-3fcfebe1e8ad

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


