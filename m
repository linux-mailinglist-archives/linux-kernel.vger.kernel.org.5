Return-Path: <linux-kernel+bounces-121791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF7888EDC2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E795D1F38808
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6F615217B;
	Wed, 27 Mar 2024 18:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WGUDT0JB"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB49A1514E9
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 18:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711562938; cv=none; b=ZM3trfovBvZ9Z1Y+tzlFXNbc7kqE7j20JQ78H+lMLBFzuFWN60CNdQVHNoZZupToFdlckOamd5LzoSbcMNLg66rSkj2cgTdxI5Vi6rIg7Oa0E4q51c6N1Vv/+dCP9j4Y/VI2iPpCokWB+BV8a3pX5SHvRS29mLpEdQnoKURikUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711562938; c=relaxed/simple;
	bh=eVSp2SaXb6ZPEBSHNnDQtpmgf1YsvfYEdjUHzWm3f+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cl7gHkeJkWDGr9RqRTgArTv5u5HU46dSz+UhoUq0XoVQbwtbgtkK9oU7AkStE3PHFffiQE1m9hzYv90ddsN1PlPGsdk18/v2LFoTTtVLQGExxw1Zs3cRot0sW39DeCv+GaX8N7SUvmB1/hPD5VvPQ/Qm2lkWZ97XdtkmsQF3K3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WGUDT0JB; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-515a81928a1so39925e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 11:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711562935; x=1712167735; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6wX0IpKx3jbsUc8KFF/llXZK/XjrxPJxaaSBhC3+nnU=;
        b=WGUDT0JBZguhcYWEsQyZPljvyoxw/2qMauHU4bnDXUcTFrvNco7zu+wufMKK2cDA2R
         N7ho/LKd9/XGGZBGp7iD/546lLAS184XlLREWUdNdLKnNVYMqSy3xcHh/NHVbKDM/zpE
         pRO/MJPpW76ThDlx9xDJv9/z2f/Ylwbvq4+4eQ+awRT1lt5AWW54NCu9lkGn8rftZJ0O
         k2BXYP/Nnz8GNKlqd87BM7NlUyHKdzT3WKECuLmzE+vCe6f4WeAs3YqABTeLKrhS7/Nc
         Kc4HqVQZwGV2L5/tsBsHyWuhfdHXU2BU5MVvIv4678ENkwLZSs4v66i/EDcgLU3jK5YZ
         rcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711562935; x=1712167735;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wX0IpKx3jbsUc8KFF/llXZK/XjrxPJxaaSBhC3+nnU=;
        b=C+IeJHj0XbSQj7IYseYjf2hLH+UC7FBetJ6BtMaoopqXm5u32T0Qzlc3smOJNfuURB
         FwgQmnb/fH0FkAPjk/QB5E7vIZVXmSCq3n/3H/Rwzck2pUppwWW+AqtM7M1D093/Oxqm
         2Q7sIoRBDJQEsq9bh1/mD/famkSlJnOpwzKJ14An0Mr0re1kdL/PhmFZG1wIJUs1IB2V
         EjlIkInZo9CrBf5B9ksteX51J2fQC4KzOzzZUCGwxb4i3n6GaddsF25x+OFNAkyKbDhL
         6X+t2FuVEti2DqRpqYP14DddnhsM+cqPcRJAfwPYM8CZaXbeOxlrYhXNLrs83vLfP8ul
         rong==
X-Forwarded-Encrypted: i=1; AJvYcCVILreFufC2242OUiJDKj0jjxz5UDGOuimOYM18xKrqZc+1SNo7hIN5CNpQ+PCaNLlcwrF6ulGnh1DQfl+W/YRgEoGiG4sVM1drJjFk
X-Gm-Message-State: AOJu0YxjNFRHTc6S1XXkASg+B36dy4xloUw6gMWirVzNxrqNW+IoHxna
	hV6JQPV4M7VIMExXvzE5UxjdoWlnKd0YGWOujh0cUARRUWuQwHdBOKbMPnyH2eY=
X-Google-Smtp-Source: AGHT+IHyeSfG7ShilV7TcOWI1bw67bLr5thuITdc64PT5gCyRpNSobuwZPQWecT7wRuzwik+KCUFqw==
X-Received: by 2002:ac2:4d83:0:b0:514:2f24:b0b6 with SMTP id g3-20020ac24d83000000b005142f24b0b6mr154865lfe.67.1711562935224;
        Wed, 27 Mar 2024 11:08:55 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id z2-20020a1709060be200b00a45f2dc6795sm5702733ejg.137.2024.03.27.11.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 11:08:54 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 27 Mar 2024 19:08:43 +0100
Subject: [PATCH v3 05/19] media: venus: pm_helpers: Kill dead code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-topic-mars-v3-5-79f23b81c261@linaro.org>
References: <20230911-topic-mars-v3-0-79f23b81c261@linaro.org>
In-Reply-To: <20230911-topic-mars-v3-0-79f23b81c261@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711562923; l=1555;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=eVSp2SaXb6ZPEBSHNnDQtpmgf1YsvfYEdjUHzWm3f+A=;
 b=BHWNIoTztfwsrr7RTZRtaZ/YQ1pFKmqgIum9BEIl4vsZSVPGO2xFlQP/pT4zwOeWHR1Vb+Z3r
 /McnKLl0KVYA7TIGWZo8axiTp/1+e1w90voRNu1NsVTvMWZezJg1Ik0
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

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

..2...

Get rid of such boilerplate.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/pm_helpers.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index ef4b0f0da36f..730c4b593cec 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -878,14 +878,10 @@ static int vcodec_domains_get(struct venus_core *core)
 		.pd_flags = PD_FLAG_NO_DEV_LINK,
 	};
 
-	if (!res->vcodec_pmdomains_num)
-		goto skip_pmdomains;
-
 	ret = dev_pm_domain_attach_list(dev, &vcodec_data, &core->pmdomains);
 	if (ret < 0)
 		return ret;
 
-skip_pmdomains:
 	if (!core->res->opp_pmdomain)
 		return 0;
 
@@ -928,9 +924,6 @@ static int core_resets_reset(struct venus_core *core)
 	unsigned int i;
 	int ret;
 
-	if (!res->resets_num)
-		return 0;
-
 	for (i = 0; i < res->resets_num; i++) {
 		ret = reset_control_assert(core->resets[i]);
 		if (ret)
@@ -953,9 +946,6 @@ static int core_resets_get(struct venus_core *core)
 	unsigned int i;
 	int ret;
 
-	if (!res->resets_num)
-		return 0;
-
 	for (i = 0; i < res->resets_num; i++) {
 		core->resets[i] =
 			devm_reset_control_get_exclusive(dev, res->resets[i]);

-- 
2.44.0


