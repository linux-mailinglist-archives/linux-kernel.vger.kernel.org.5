Return-Path: <linux-kernel+bounces-59991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C1684FE46
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F39822842F4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6B039AC2;
	Fri,  9 Feb 2024 21:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QGtjMtJ0"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A8F2E63C
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 21:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707512993; cv=none; b=SCULKsc0zh6Qmj74jYi37yztN893yFZ9LZ8NgfWOAiipfjH6uQ/p/oluAtddDj3xgZd0HUjwK1cnaher1Gw5+akcufDmHJL5rTkklJjHcSwNYFLn+58enqt2eQYlDGpys5IJ4135K4YJa9+7IQlT1jJRkGnutd7gHViepjN71KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707512993; c=relaxed/simple;
	bh=lb27xhI4gdBF4UHcwKFr8ScxLgxp1+CafppHA2L6fhU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q4MSu2JaNaMOFDlAPx3HKsGE5BewrVAVMuSBI2GOBdfdSBWVQ+jQKGurILfr/AyV5G9jPyKK6PnBZ+NMqvuX3jJm05KnQUssE/XmhDs8oRD+L7qakTpfdsxyqx2HZG8RFMAmQCCrmRRpHat+g4f84b+AmIKNH1V2gPf5wLUgAIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QGtjMtJ0; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5116bf4dcf4so1706036e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 13:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707512989; x=1708117789; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YqgwRixA6ApDI8sPrNg91MKVrvVSPJRcKUUS08MgCmY=;
        b=QGtjMtJ0N3qkuPeXYlY1zXVgAtpVw/3TTvcuYClM0TT44kKkWufABtzkJR+pHgcyIp
         HTatj9O+aHcJfUIU2QgbNbFOwO4JSTAazNmV5Zs7v0CP/EyFPBjpC3sj3qSjJ4tv5616
         kZ0NBKhNkgImDZTsbz9wE6TLpc/Mp6rlbazFgyaEFuHkqzP2W/SWEMvDZqobfTqIV3vK
         yZzGl3s8Ls1rAp8w8wvxieEb4I4USp1rmGbvLDSrQpNbf0kcbCPtdyXSlGeZGt75FkDc
         UkOugIAZolzL3YmR7TBZUz05ZylThbageeBG5MiMpUm6t8t2ydgNOIjZSvlmuWK4t5RZ
         4EbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707512989; x=1708117789;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YqgwRixA6ApDI8sPrNg91MKVrvVSPJRcKUUS08MgCmY=;
        b=THAcBk8cyL7QMMqHPtZc/HTknvuipFa7XZoGT8bHCyAU474oPPWTAS5mEH1NGjFl3J
         XuMn2liHUSrhZnh/29xsu/u23JFG9WT/bgP2OOHd56W3O3AcTVsvjGmZOfMhDmKfMn6z
         KrFyRDy+3hGX+tpRbs61dVrLbDE4sQ+yRmiFWo0g53Cbv+ShirIO4Ix3Mbisdlihs/jM
         pWwp8cJL1uAk6UXHD98MPBj/KkIjzi8Bx0I6bICwdFMbuKInClJ40ICdDLk9BKL0FT/Q
         hgu3RGDEmEulXpdn2pQI3vEhREzyfawfG0jHlY/4FGvKTHsBZ4iVZIi+AtzO23bXE2dx
         URHQ==
X-Gm-Message-State: AOJu0YxrayKosOLrWvWXURZfa9gBNulQKee1Zr3qcm50E1K4vGCgvwxM
	4mfJGIXjXHPHuRl+avVop1ZHkCns3udpqbmTCYF1Y+fcDfNX/7ODepzVU9tlNhI=
X-Google-Smtp-Source: AGHT+IFIqd7UT5C7l2jMBJF05GfGoDqK+2W7pPUhWPkwx1CTkOTNg8Cw2D6fa2Sge1IUZ96uK0/t/Q==
X-Received: by 2002:a05:6512:1251:b0:510:c55:a3f5 with SMTP id fb17-20020a056512125100b005100c55a3f5mr168236lfb.23.1707512989482;
        Fri, 09 Feb 2024 13:09:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVJl+AqbHTvF3WV8vFVVntucZdXXlMJ4ZHb58tZF7FmHOj+rbFcNR6L01/SUIw8W0HtYlS7C8YqV1sr1qGzI+g86in6mo68AsjTEScsXBPRvnEJsUOaYfXNYSwT/H9mUR3PUDBezQumpTWbyiBd2ZUGLXzLQ8sIgv793E27kK5dhP+vNkKXtCasPgGZDfEbTWz7UIrQTFQmv3Y94TvNQtRB270pT0L/z66uersi1ac175Q3orb5WYdurbV57NQVyopgi5EtzSmtezdsKhHeJUfFUX4vI8cYjYOdJF4B5MR2WZy1ntAV/sLt68kCfnG8UAj5dsXmZ2vc+aapy/HOP2tg/lnTvkncMuKRCQsz29mVl9Up434qQO3jFC2prJi7T6gN2GVKuqlHGTBWv6ibfEKLnoqT7VshfFBWKAj0b6xA0x9IKv0IFm1QCdkaZKlM/4I1thxBZsgqgFRK5m8ir9tXIUFobZcMAvHWaaqSnoh9Nlqr0ow9i4EdT+KkUk0LSwNVjQ==
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id vo5-20020a170907a80500b00a3be3b27d0bsm1056517ejc.49.2024.02.09.13.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 13:09:49 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 09 Feb 2024 22:09:45 +0100
Subject: [PATCH v2 01/20] media: venus: pm_helpers: Only set rate of the
 core clock in core_clks_enable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-topic-mars-v2-1-3dac84b88c4b@linaro.org>
References: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
In-Reply-To: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Dikshita Agarwal <quic_dikshita@quicinc.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 Stanimir Varbanov <stanimir.varbanov@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707512985; l=1871;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=lb27xhI4gdBF4UHcwKFr8ScxLgxp1+CafppHA2L6fhU=;
 b=+y8UnWj7pBxnLDQzTuFCX0qHqfFWaIW8ltcFXMCcilkClq26ATIQQ8zPa741OTNWGh2ip2q7E
 FIadbLDch+AANPvAZz2qy+xxWDyEljuOMqEfsjrjCuhKguAPfK83x5U
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

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
index 502822059498..8bd0ce4ce69d 100644
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
2.43.0


