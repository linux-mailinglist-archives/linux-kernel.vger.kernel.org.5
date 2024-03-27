Return-Path: <linux-kernel+bounces-121794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5752588EDCA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDAB21F39612
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7594814F124;
	Wed, 27 Mar 2024 18:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W+BBciU/"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C2C152525
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 18:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711562944; cv=none; b=XyAkwT2qYsksUoV8Ij4CsfgTVvUdPHmaoI6ZQyv0/+xTLaroaE2VS6BsAaaqetu+EZfy1j5rRRpQwOEh5ZvVJch1DC/mQk63UoKrFO4j4uQ0L/90yMhAr0OSc72/jAOMoa3uwegoJmQWUlVWViil5uRCwoKEwPu7HT0dJAroetA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711562944; c=relaxed/simple;
	bh=9GQzIJs6byPQfUBP/1zw0u8rZrLZ3CXA+a/XNH00r2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mcFTNwXl4rctpNRYPP0uFVTi6RqqNdBhchSVQbRvuk6VUP38Ng8KK5At1QQEgJQhtspQvps60vLfgYNjysH0Qyec5nK3cB70WWrcYSIaqjDdVzk4mw482UEp0Xo7sD/UumxSufrsxGaduwB6qkcxEiQDbSkzMp8bpSz3tvESomY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W+BBciU/; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so1998783a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 11:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711562940; x=1712167740; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+RKGFKd/nh2wuvJYyEzPyLuatA0djI0PTARmRoGHA9E=;
        b=W+BBciU/ulYc9YXgbtc5+pURAjbXRRFaXRrWb7ux5os5AkjlW6Aim4YvEGtRuKzDU9
         uy3IMhiAzEv7LMXMAFHddDZ0fk6tS3TVk+p++TqSFPymboj1Y8q3O3/rwCThI4zCuUK4
         p815Q0wHYjunXgg+9lQirn4XpE5j1LcRjg26mewAA7hqD/X7rLl5VXxkpr1tthP3QBQp
         LONR2B4rxYR4EWEA0gFhX8U28wV0/nHbAAF4HBjGoeeMUTvoogw3Ia4/Uq/sS4Qc7xJF
         diXOPFhUuy2iuIG0xpmFVM48lXGb8FBD+RkWXYfVwY7e4Udv1fUwepS5+4G9tPN2rWib
         LPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711562940; x=1712167740;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+RKGFKd/nh2wuvJYyEzPyLuatA0djI0PTARmRoGHA9E=;
        b=wlzjUICZpN5b+mzdjO0QqT1r4V2ok7smQXgFuTRxAjOK5ykdwF5qE3o0xG1YbEp9bl
         NroR9cx33tJVwbVltnwkavBiaE39eYSRtdhmS+xhjGLpvVxvPaWZfR1GxxvUACmWZgMT
         Jz0z/EfyV2MpmPqXMlCWzxvtvjJyHbrPC/qmOPaSMXTd45tBasi0AZVjn3ZNh+PmD4rh
         HXzcvcCswdyOQ+BG3nulevEkPA3AuMcdAJkRifxf1Ll3SEP8MALRV2iSGia70u/yvVnn
         PYxLVedjcmrc6Zxh+/P1+mnb2QSlC9h7S2Q/C7qVZ5bMOTEkiLl6PTjSeL+XshzAWMDV
         xG3A==
X-Forwarded-Encrypted: i=1; AJvYcCVI992VUNMr6vLGOd4Fvf3RhQlixjdmPAVgAxLYIDrUBzqKE4riNyzcXaTBKxOxz2ma8xs5j3dDCBLfoQzVMTUUk8rImTdwD9dJ8oLC
X-Gm-Message-State: AOJu0Yxl/CgJwWNUVAK14Bmczse+MpImhiAz5BweySworB2qTxi9fbez
	ZVvRInw8iEbN6OaraRnZ7fkO0I4EWzzB855q/FxHKtmGYchgZR5Abh+k+Aro9W8=
X-Google-Smtp-Source: AGHT+IF8em4aTF+mqWJPqPmN0a0sKq0NkhDYuNS1awWjIcgY3l/wCITySnO09ip0NjjG7gMF79n9pw==
X-Received: by 2002:a17:907:7dab:b0:a46:87bc:6f95 with SMTP id oz43-20020a1709077dab00b00a4687bc6f95mr41973ejc.20.1711562940775;
        Wed, 27 Mar 2024 11:09:00 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id z2-20020a1709060be200b00a45f2dc6795sm5702733ejg.137.2024.03.27.11.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 11:09:00 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 27 Mar 2024 19:08:46 +0100
Subject: [PATCH v3 08/19] media: venus: core: Get rid of vcodec_num
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-topic-mars-v3-8-79f23b81c261@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711562924; l=3452;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=9GQzIJs6byPQfUBP/1zw0u8rZrLZ3CXA+a/XNH00r2M=;
 b=2wczzaBnZhVoe2Wd/KIeFXeXGdfSdJYsCfKZM4wWQADLgdzHlap80f/liwqeNFPnLggf6EWeG
 2Cg51BSWGKfAm1heyYTNL5FvruHn+hijThaXHCtmLys3DHA0erj00XY
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

That field was only introduced to differentiate between the legacy and
non-legacy SDM845 binding. Get rid of it.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c       | 5 -----
 drivers/media/platform/qcom/venus/core.h       | 1 -
 drivers/media/platform/qcom/venus/pm_helpers.c | 2 +-
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 5e7cb54e6088..26a0c264685a 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -651,7 +651,6 @@ static const struct venus_resources sdm660_res = {
 	.vcodec0_clks = { "vcodec0_core" },
 	.vcodec1_clks = { "vcodec0_core" },
 	.vcodec_clks_num = 1,
-	.vcodec_num = 1,
 	.max_load = 1036800,
 	.hfi_version = HFI_VERSION_3XX,
 	.vmem_id = VIDC_RESOURCE_NONE,
@@ -725,7 +724,6 @@ static const struct venus_resources sdm845_res_v2 = {
 	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0", "vcodec1" },
 	.vcodec_pmdomains_num = 3,
 	.opp_pmdomain = pd_names_cx,
-	.vcodec_num = 2,
 	.max_load = 3110400,	/* 4096x2160@90 */
 	.hfi_version = HFI_VERSION_4XX,
 	.vpu_version = VPU_VERSION_AR50,
@@ -774,7 +772,6 @@ static const struct venus_resources sc7180_res = {
 	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
 	.opp_pmdomain = pd_names_cx,
-	.vcodec_num = 1,
 	.hfi_version = HFI_VERSION_4XX,
 	.vpu_version = VPU_VERSION_AR50,
 	.vmem_id = VIDC_RESOURCE_NONE,
@@ -831,7 +828,6 @@ static const struct venus_resources sm8250_res = {
 	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
 	.opp_pmdomain = pd_names_mx,
-	.vcodec_num = 1,
 	.max_load = 7833600,
 	.hfi_version = HFI_VERSION_6XX,
 	.vpu_version = VPU_VERSION_IRIS2,
@@ -890,7 +886,6 @@ static const struct venus_resources sc7280_res = {
 	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
 	.opp_pmdomain = pd_names_cx,
-	.vcodec_num = 1,
 	.hfi_version = HFI_VERSION_6XX,
 	.vpu_version = VPU_VERSION_IRIS2_1,
 	.num_vpp_pipes = 1,
diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 6a77de374454..376de1161114 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -74,7 +74,6 @@ struct venus_resources {
 	const char **vcodec_pmdomains;
 	unsigned int vcodec_pmdomains_num;
 	const char **opp_pmdomain;
-	unsigned int vcodec_num;
 	const char * const resets[VIDC_RESETS_NUM_MAX];
 	unsigned int resets_num;
 	enum hfi_version hfi_version;
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index 5b2a40a2f524..ba63e6427eb9 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -622,7 +622,7 @@ min_loaded_core(struct venus_inst *inst, u32 *min_coreid, u32 *min_load, bool lo
 			VIDC_CORE_ID_1 : VIDC_CORE_ID_2;
 	*min_load = min(core1_load, core2_load);
 
-	if (cores_max < VIDC_CORE_ID_2 || core->res->vcodec_num < 2) {
+	if (cores_max < VIDC_CORE_ID_2 || legacy_binding) {
 		*min_coreid = VIDC_CORE_ID_1;
 		*min_load = core1_load;
 	}

-- 
2.44.0


