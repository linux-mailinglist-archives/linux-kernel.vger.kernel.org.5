Return-Path: <linux-kernel+bounces-59989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D42BE84FE40
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49FC7B28E08
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1AB38DE4;
	Fri,  9 Feb 2024 21:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jeQTS7zH"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243E53715E
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 21:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707512984; cv=none; b=PghDS0gS7goCJgWfjbak2m976nF8FuAhrgIAeomRBRaVBeA9phYA8/7d0+jxfCTXrlCzKaO77QgP9+9eUavKPltDjFGQuwmll6rdT7ddYCx5uSvpUwrEm5Gko0n9Av0KKLDZ1GqQGZKQlZyE6wgQGFDaAtm6WF1zVnHvL8C0hGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707512984; c=relaxed/simple;
	bh=3dtrntbOogwjknLFZqca+wBqcS9QWbQOd9iEEJQfOvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K4xie+nhftRiqFkOn8CCWBLOgOxvYeNdKPGBKmxSn+edW2iCQJutvlTLk7FwTrk89Mbjc87vjGpFZlKm2X+9SX+M0jxwJ+LuEC1F0MnBXgVu4I12cF+ICgh7wBkNxg1sdjQIG6vNhoOZuQuGpc//xLFQn56HwlxCcyCOa0bvSCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jeQTS7zH; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a2f79e79f0cso203924166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 13:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707512981; x=1708117781; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AK+SsOpDJXwjdmEkPZAy2mx09ivoS/IARlVKsNVFoYA=;
        b=jeQTS7zHWPv38FopjG+9xEU7NXUJTRnWiMmMtBlWShKAwVVWJo/v+f5OG+u6zr0PNv
         AKI0SiJnfQEDHSizuZNKZmgVUnUPKObzI1Lj+n04LfAtQVLL85H/d4jNIJxNM+M7gWsj
         nOpN/5kbUpnUGG2/ZBJmC7g+ecKXbXHp0jbQ5mkPR6/QzJl/cOeCl2CS/cz1XVoien/M
         nuihrMoR3wUQt+MHZaBys3hZR+83Z8DS1zc9pZm9AdA4/PCQsaYzhPm6tQwouYnEyeUX
         fVL7xU9gbGft5RsqZaYKzPjRRZFqrKtxuiHkPbw/1x+VCAJIi3RVpxWrLgjnzwe7UdQM
         GYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707512981; x=1708117781;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AK+SsOpDJXwjdmEkPZAy2mx09ivoS/IARlVKsNVFoYA=;
        b=H0RpnEHZbqyrksD/ajeIce/xwKGorpi0sIWidjpJvm8BLkomI4XW7ZRUi4bERjFSZY
         VEy8/vXb/W7VApo82sErozGeFA1gsdCEbVFLNySwBFYIZLtAbShnHczENqIaxapQEZYw
         jllh788+r4swIV/PER12X2prNaddgMdZ6Fd8ssKyAAEyxEPLkO4894g5xukyRYx7/F6T
         781aEr2w4a1dQKRmlThl679d98OBInMi9KHLyDrPlUT9LkmlYmJ50i9CReFETTZLij6U
         uANTJz7weZBHz9dT55gwUSyeiifQoGQkq2bCr2NQmpZzA1dK4pAoIcykPIbG98sBo1bz
         mSFg==
X-Forwarded-Encrypted: i=1; AJvYcCW5Q2EQHafIkHjAvg1GWkq+OhWC36uQvnSMI2Wz2cUXVfvO7VM7K1MUpRd9Rp64tsFivI8ulU68MVGsRLMT6kkLAvQXI5PAkzO57z9R
X-Gm-Message-State: AOJu0Ywm+WGN3ff80I529POjWOu6pbIRwxTmfm6Ot14ZnNUGI3n+r2jC
	poItrBjkGsdYsjiFt0FYZYESpAeHYh5n1Em4vQJM4O2mFhpiU/CM5bPNazKGWLU=
X-Google-Smtp-Source: AGHT+IGmfZtnTZIBlUrbT3fuej5FpmCrMGimcOsSa8hOCIdSo3pqehnzc0VUDzvdrwtLzsrv9pDwdw==
X-Received: by 2002:a17:906:f857:b0:a38:9623:7d42 with SMTP id ks23-20020a170906f85700b00a3896237d42mr241809ejb.14.1707512981437;
        Fri, 09 Feb 2024 13:09:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXeIK/Uo211/Ztmg10f505GpkvgNc6F3KNIEaUOa0+sXCI7QQmSxzjhJFx9UQGPCy1O0Xktwt4Fyzk/RtnrcP9r23Pm6NR3QFVAqEeTtIOfYRaGUbJdLRJbGKSbBLNhdMJDeP2iOR8k8Vx4ivqHcil67j79CS18mt9hv9aYP71EK9dviZd67QkyUzdbrXVRxWXf/YkMmUdAHAogG8rk9LwfpbaIaBudwp/taafrz11AIRiI2tw2w/yhCUg58t9PjW5q+CFyIsmtj3y3j9mdh1O5SGhRMcCS74uhg26sxf+agKV4PoRx2Hwoz55ovDAJtxmLcFjySYdy9PpPVsddz255uoWvCu2YFqtLqgraCKx2Y3s2UB0zhGOVU4s9MhXIYXuq820KUvVeR1qe26P4/TCtoHOxeeIbOl6+i6wf83iD9YZgBtyMKvuNkMDlP+sF8+tQ42kag397A9OlLkT0p2dlOr0YMIsbDbsJTlTfLqOJPx8vdo3NIwTVMxvUlYLtOnwPSA==
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id cw3-20020a170907160300b00a381ca0e589sm1108516ejd.22.2024.02.09.13.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 13:09:41 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 09 Feb 2024 22:09:26 +0100
Subject: [PATCH v2 05/20] media: venus: pm_helpers: Kill dead code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-topic-mars-v2-5-fa090d7f1b91@linaro.org>
References: <20230911-topic-mars-v2-0-fa090d7f1b91@linaro.org>
In-Reply-To: <20230911-topic-mars-v2-0-fa090d7f1b91@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707512970; l=1555;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=3dtrntbOogwjknLFZqca+wBqcS9QWbQOd9iEEJQfOvA=;
 b=MvZNyCayLpQ1eIqz3XUVZ9mwJU8luMw6v0iR3z8H9iZIfFa4j1t1dj3qCHyw62OM9lh70rmwU
 PItjvQKkgcIAaCHrnrwcrpNj9Syd5Oj0llgBrrzy7OK6uSJYxEJ2d/k
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
index 1ba65345a5e2..7193075e8c04 100644
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
2.43.0


