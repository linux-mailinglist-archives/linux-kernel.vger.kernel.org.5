Return-Path: <linux-kernel+bounces-60011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B000A84FE84
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D40F91C2210F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DBE4D134;
	Fri,  9 Feb 2024 21:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H4v71HX6"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE1A4F8A5
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 21:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707513027; cv=none; b=oo8z79izOgvqAmg7AcjtUYSyJ4DvSQiiHH0ctMYDbZYj8XNfiW9KmfcU5HwN1OC1xIUKRC71OfzBDq46tZP+u4iUVAleTORC9b84Yv23qLngfHN3f5V7M1EOnzMa1pfcN8KZWBRYAnudWXyQDd45hob6613cp4k5gQ8JYlZWuPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707513027; c=relaxed/simple;
	bh=Fz9/3nwY3iRMESW9ND892gH2ujeyGwLuBsrH62OMhc8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ktEW23ViQz2eC8f+5GVxRXtSH/e1T66jN8fGxODJkblPAEbNKT1VBUhEV0Kb9dTkSiO+gOu9GWF3KqRU7oaxN55GxhkRpP8+WPw5aPsxEMTtROtqRgLjqNvvnInLE2U2IH6BrTa5gJ8PfiflfccLr+HNcQKg2ZlF+6MMAoT3LOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H4v71HX6; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5114fa38434so1573346e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 13:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707513023; x=1708117823; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VBuTuqSBCGp1wdV2drsgjw3VLfRlaM3TQsPOZG9m4W0=;
        b=H4v71HX6mKe5gMPn+3B0kX/sDpU2QYy3U+BOFhg8E3nCKWFJo7GI1rXNMq5HiM2i7d
         TuWz1+ZSiSRbkKkfSGkbpnaruRWc8gTPTaczdVCigRJ6FdF3lsZkP55Q9xUIa6M8ml3G
         4yicNypI7/+2yaL+CigGp0DP1XZV3IOoIrqxIwZ1tcZ+6PKutB3WiNvDVrtTV0hZTbBX
         lS2OjFEDXVdBjYbmvuGVDrvrIZYcPD+1Ag82mOCenYR309KDLEKIdzDTT4B3BjQVJnyE
         Ik8Ck0JYm1NJhzH28GC+yYXc0Ocho8WnI9lOXI7q/dOL8C+ckwSEUgiOvTrgbEdAewgD
         seNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707513023; x=1708117823;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VBuTuqSBCGp1wdV2drsgjw3VLfRlaM3TQsPOZG9m4W0=;
        b=ZGp4+YIWU9vJLGhk6vIEdW8ft5opoNunFVctWXhLB7d3pWdfC1XwyIs/O2ygXL26TK
         3c3Kr91MucPPBMM/04MiLydW5EyLhYVEVJCGJ2XHccfHA5zi/603/uM0tENcWq9x7H/M
         BJYXL9ltJAwJ2Dx3PNp1cWSRcwXVzrkEmuzV8VxqgkFauxdNVlTzuwhSVaRxYcxxy5ci
         v0Jx9BmPLS9po9+EdrF3eOVwZb92n7tS5SIPLWgd2Eod+By2WEzLrI+tmNnSc3jt+72b
         91OdEY5v2SBGt04T9Lk5MgLTTu2JOasFAjQm7AewGkuv8n1p/YitxmO0wdhoKF/6pIhA
         0A/A==
X-Gm-Message-State: AOJu0YxJmtFfZcuX7GpSp1yVrMeDJtCvDcbC6ZJzUz7E6zruqW3mbvzh
	CtSjZvs2xlF7NKpMwYy2/DXdb3Rdqmp2DsSxbUW70bhsiWuK5L65qIFj5iRoioY=
X-Google-Smtp-Source: AGHT+IFmDovCNo8IXlypQCGqzNluIsgzHOnrtPCmHDEWychihLMIbm3oYmNVKBmYhUe4EhbDalBWGg==
X-Received: by 2002:ac2:42cb:0:b0:511:429e:43d4 with SMTP id n11-20020ac242cb000000b00511429e43d4mr153429lfl.11.1707513023199;
        Fri, 09 Feb 2024 13:10:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXaCO1qT04kwtps/bfEISjBC58UTjh+OzcG6dJ/58GzZqaZ4sJXT0ZCCFTSZO4GEUOoVbaCB2hkW2i+iA8G+/jiWkr6FmSe3dUxfhzl5X7XuewdWZPHq72K/dUggw9LviQbCuhILgmFoZlf/UWuAXfeE8ZB1ICSPB1DQSPE02/PsVIwmiaF0c1w2tPagVpJczZXASAWiid9Frgy5PphXUxjz0qpSZoQwm9wQXfZGyM9BwoxrbBl/rmiqovVVxw7WHtftYgYAbJm/e3I6EpSjMC8oayLxmZXCRkaryoFx2b3Un+gZZXJMd20001HWk5q76RHVB+tFrq76AlanSx2mQzoGdpyAaRD7ilmuQudlWtiep6I/mAlpnfka0U3c7oBrpsAeMD0+BLP3M/4g/KSly61ErLdj1mvdBooNXwsbIB3RW87YIbynNB6VOfB+tQJGnw0XpgpXzipH0uEuLzNSVN4HN/qo368y4TUlqYT4ULzxKZ2J8AkWThmxWTgPyZcSTmnbQ==
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id vo5-20020a170907a80500b00a3be3b27d0bsm1056517ejc.49.2024.02.09.13.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 13:10:22 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 09 Feb 2024 22:10:04 +0100
Subject: [PATCH v2 20/20] media: venus: pm_helpers: Use reset_bulk API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-topic-mars-v2-20-3dac84b88c4b@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707512986; l=3454;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Fz9/3nwY3iRMESW9ND892gH2ujeyGwLuBsrH62OMhc8=;
 b=Fd7i7FaWiwaHVHHLebF/wCA/vcsVdLEcCtmGGg18YNUn3FNRyH6lEVGWeoBqDEYk1gfz8xMJZ
 MaSw0hu4S5pCKtrocK1nPDg6flxKKaGSCbv2ywxGWlw/Sy04vZUlTz2
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

All of the resets are toggled together. Use the bulk api to save on some
code complexity.

The delay between resets is now correctly determined by the reset
framework.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c       | 15 ++++++++++-----
 drivers/media/platform/qcom/venus/core.h       |  4 ++--
 drivers/media/platform/qcom/venus/pm_helpers.c | 15 +++------------
 3 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 873affe17537..ff5601a5ce77 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -328,11 +328,16 @@ static int venus_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	for (i = 0; i < res->resets_num; i++) {
-		core->resets[i] = devm_reset_control_get_exclusive(dev, res->resets[i]);
-		if (IS_ERR(core->resets[i]))
-			return PTR_ERR(core->resets[i]);
-	}
+	core->resets = devm_kcalloc(dev, res->resets_num, sizeof(*core->resets), GFP_KERNEL);
+	if (res->resets_num && !core->resets)
+		return -ENOMEM;
+
+	for (i = 0; i < res->resets_num; i++)
+		core->resets[i].id = res->resets[i];
+
+	ret = devm_reset_control_bulk_get_exclusive(dev, res->resets_num, core->resets);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get resets\n");
 
 	ret = venus_get_resources(core);
 	if (ret)
diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 6ecaa3e38cac..2376b9cbdf2c 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -130,7 +130,7 @@ struct venus_format {
  * @pmdomains:	a pointer to a list of pmdomains
  * @opp_dl_venus: an device-link for device OPP
  * @opp_pmdomain: an OPP power-domain
- * @resets: an array of reset signals
+ * @resets: a reset_control_bulk_data array of hardware reset signals
  * @vdev_dec:	a reference to video device structure for decoder instances
  * @vdev_enc:	a reference to video device structure for encoder instances
  * @v4l2_dev:	a holder for v4l2 device structure
@@ -183,7 +183,7 @@ struct venus_core {
 	struct dev_pm_domain_list *pmdomains;
 	struct device_link *opp_dl_venus;
 	struct device *opp_pmdomain;
-	struct reset_control *resets[VIDC_RESETS_NUM_MAX];
+	struct reset_control_bulk_data *resets;
 	struct video_device *vdev_dec;
 	struct video_device *vdev_enc;
 	struct v4l2_device v4l2_dev;
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index 9df8f2292c17..170fb131cb1e 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -865,21 +865,12 @@ void vcodec_domains_put(struct venus_core *core)
 static int core_resets_reset(struct venus_core *core)
 {
 	const struct venus_resources *res = core->res;
-	unsigned int i;
 	int ret;
 
-	for (i = 0; i < res->resets_num; i++) {
-		ret = reset_control_assert(core->resets[i]);
-		if (ret)
-			goto err;
-
-		usleep_range(150, 250);
-		ret = reset_control_deassert(core->resets[i]);
-		if (ret)
-			goto err;
-	}
+	ret = reset_control_bulk_reset(res->resets_num, core->resets);
+	if (ret)
+		dev_err(core->dev, "Failed to toggle resets: %d\n", ret);
 
-err:
 	return ret;
 }
 

-- 
2.43.0


