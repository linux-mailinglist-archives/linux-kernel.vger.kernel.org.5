Return-Path: <linux-kernel+bounces-59998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5838F84FE5C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D9491C20A10
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377913D0CB;
	Fri,  9 Feb 2024 21:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uw+dS9PN"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676BB3B79C
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 21:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707513005; cv=none; b=l+ha/ioWSdc8//XR7f100+dBNPUeRexVKr6S6TlqRh81s73Ui883Q12RW8mCBTXJ8vwQvgC/QuHQ8rprvEzA11bvLbBlAUhNAwS5u/zrN3IINCul1WGT8e+sGH0HEBVkNJeEJY2gLlEpUakqGuzWADe6qMi+LJD57MV2Iiu3e50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707513005; c=relaxed/simple;
	bh=BxP6mknLkkhwH235J5PftaK8VpshDs1dIkEqExrl9fw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mHO6hnStztDggEocBabjKegIzkuo6wBtdi53ro5f8xo26iBbqPgnyJrcbR3YeXYKZZ5oHOWRZkj6Q6TAZiIH770ElbcN2ZJI0iX+fzHjqgmcVHe9VOfrwDBeRJtw4ohG19dLhAHeBlLF533talLI3VxplA5DkB3637I/+nDsH6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uw+dS9PN; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a26f73732c5so186402166b.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 13:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707513001; x=1708117801; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PjYVvA6/x62tiGnPrd+cF2sjnvoUPDtV+GlugrRAEGc=;
        b=uw+dS9PNWVj9wRNNOG5bzLY9bPK0Dxx+luF2Tlipv6M2tcvnsodddiOWFFWRunxwjO
         QBE4twoGsGieLmcRHnZTqYUlH+M/yNrJS4UkzYLZVBgliM4bG0xqFPd5UJsKfkeT/VFx
         k8W+9dC3fvtrd6KAy6vkoNRTAMvaMaebjp+hSxCwXKflscZrIieBzckTReamPRTfA3dU
         jYAdSpbIu+USe0eWZAOc72myx2N2NTIqg8p9iLxVS8KmHzzMfzJu6dN63oAGauX1KffV
         k2GTeJbGoC6nYPPv0exjPXAYxKs9F/bXfBOcCNSx1/bBqApMuQZNxWIM9jzKdip8zpUl
         SBQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707513001; x=1708117801;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjYVvA6/x62tiGnPrd+cF2sjnvoUPDtV+GlugrRAEGc=;
        b=tRdEElMZ5HzAC11dVU5Ml3v3UQjpcUPUWM6kq3F074AqG+BdO5vJEyuWpYwvAJJAHc
         58Mu3VV/Z+EaJGuEPvcmhxbM2jijbDR7RHzOiIbAbn7qQ3waG34AlNEEDUT5j22CtQum
         LO67Cdg1OrWgr2LRZjtJdk9Le3g/TToi/kt5kZtu8hLBFEgKzwbnFF1aKX5PVqb9GiC1
         Eeg2kqv17daR7ie69HdC7wDkn3Rn845F2g2G1wN1tyHZCcRttWGKvwakCMjrXcTF0kxT
         s2T3iI0tN1slLQV+vLFMNIHVe+80dl9Jc69hjUQCSpVJP/qKPWoFaoo0ISZq+W0ITCvq
         l+7g==
X-Gm-Message-State: AOJu0YzAYsXtVN46QokdVRwwfWXFTqGtpog+ifvpdo08cGcH9fGKHU4A
	yKi29FqwlHwXZkXg6pe+zQsXAvv8hDQpFDprHfBjevXV21aO9plZwJqybpfGkfAG2vQurJVlR4b
	X
X-Google-Smtp-Source: AGHT+IFp1PWTyLpycl+jUCQr1eGQJdI8e9Yj52cDT9vNrTaarpIUHhbVsEGxWxvBkn2tg4TGxOQwcQ==
X-Received: by 2002:a17:906:378f:b0:a3c:45e:77fa with SMTP id n15-20020a170906378f00b00a3c045e77famr152223ejc.11.1707513001665;
        Fri, 09 Feb 2024 13:10:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW3lTlfXWRs2C2UOrTagbsQew+Gmppxm8P6uAd4UeQ6vHAxDZQD/PFiYRdIu2Pvs6xsyGE5XhMSd6knHTNovwY0LdPfMydvGzPXievOL5F1E2IQvlL9loDKEaLeYW7NrSVwe4Oeknob8QeNkmGM3g5JIz+EL9mePMrikTdpopi1CPpnk8TASPJ5u+AR9r+GjjXwmT6ByDcuMXBB/AC+OKONvRvt4YvyNeYooeZDfbfteb6yfGpZvsP/N5bQCk7XsJYBxdiC+/+CiIUtqgi10pLMIOn51grS8/GvSPGknoLbjmA8alkfDSaHcKsdoOuJ+tdBvCBsVTlnk2WCBpHQaJSEru4eqiwKLcnQQI2mYfXbLxTHi+LKg2mE0idtTP7ibp2WYKb837rpctER0MHPZ8OsYBP5b5/lfa5B7CKLa5q6VRwA3YEk9zUHqCkppAQvGP24GZHNQUf01P6VOQDKYpI4aQ2CmqHlkHLnf55SzD8ZhHDhfZNsf0McnPDiYlnfreCcrw==
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id vo5-20020a170907a80500b00a3be3b27d0bsm1056517ejc.49.2024.02.09.13.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 13:10:01 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 09 Feb 2024 22:09:52 +0100
Subject: [PATCH v2 08/20] media: venus: core: Deduplicate OPP genpd names
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-topic-mars-v2-8-3dac84b88c4b@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707512985; l=2465;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=BxP6mknLkkhwH235J5PftaK8VpshDs1dIkEqExrl9fw=;
 b=2O78uSJw10ViDsWmi83rvPytRhzx7ZDuSMlLSa+Uj9Pn4gvDUJGncWd8/wYFas8VOoMyqHPLS
 ZIpmbvLgizuBUi3m3Ie3kg93LDgEy+p1MBVHqKMajDDshiuVa9awE25
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Instead of redefining the same literals over and over again, define
them once and point the reference to that definition.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 0652065cb113..83ac68f1566f 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -538,6 +538,9 @@ static const struct dev_pm_ops venus_pm_ops = {
 	SET_RUNTIME_PM_OPS(venus_runtime_suspend, venus_runtime_resume, NULL)
 };
 
+static const char * const pd_names_cx[] = { "cx", NULL };
+static const char * const pd_names_mx[] = { "mx", NULL };
+
 static const struct freq_tbl msm8916_freq_table[] = {
 	{ 352800, 228570000 },	/* 1920x1088 @ 30 + 1280x720 @ 30 */
 	{ 244800, 160000000 },	/* 1920x1088 @ 30 */
@@ -721,7 +724,7 @@ static const struct venus_resources sdm845_res_v2 = {
 	.vcodec_clks_num = 2,
 	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0", "vcodec1" },
 	.vcodec_pmdomains_num = 3,
-	.opp_pmdomain = (const char *[]) { "cx", NULL },
+	.opp_pmdomain = pd_names_cx,
 	.vcodec_num = 2,
 	.max_load = 3110400,	/* 4096x2160@90 */
 	.hfi_version = HFI_VERSION_4XX,
@@ -770,7 +773,7 @@ static const struct venus_resources sc7180_res = {
 	.vcodec_clks_num = 2,
 	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
-	.opp_pmdomain = (const char *[]) { "cx", NULL },
+	.opp_pmdomain = pd_names_cx,
 	.vcodec_num = 1,
 	.hfi_version = HFI_VERSION_4XX,
 	.vpu_version = VPU_VERSION_AR50,
@@ -827,7 +830,7 @@ static const struct venus_resources sm8250_res = {
 	.vcodec_clks_num = 1,
 	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
-	.opp_pmdomain = (const char *[]) { "mx", NULL },
+	.opp_pmdomain = pd_names_mx,
 	.vcodec_num = 1,
 	.max_load = 7833600,
 	.hfi_version = HFI_VERSION_6XX,
@@ -886,7 +889,7 @@ static const struct venus_resources sc7280_res = {
 	.vcodec_clks_num = 2,
 	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
-	.opp_pmdomain = (const char *[]) { "cx", NULL },
+	.opp_pmdomain = pd_names_cx,
 	.vcodec_num = 1,
 	.hfi_version = HFI_VERSION_6XX,
 	.vpu_version = VPU_VERSION_IRIS2_1,

-- 
2.43.0


