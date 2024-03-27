Return-Path: <linux-kernel+bounces-121797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 847A888EDD2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B57EA1C32EF9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1306153586;
	Wed, 27 Mar 2024 18:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IQSeRvo1"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506C1153515
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 18:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711562950; cv=none; b=uGqks0mypYh+ZI3mlKMtoyG3hZYBo78B/Wfer1DFR/WCmJN7G48tdNFcmUz5xBQsxG3Q7oRsQ9OZ0UEf4hXRsxDrb9a5LJ4awLXzFLEK1pKFapXt40Z4u7XmNs2+0tqDTo0WenLyztouwJZxXmmgcqAY604UZdZHi+KT4exSeH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711562950; c=relaxed/simple;
	bh=EiXe27maCyYzrjrt5IwhfaloukG1N+cTVNcHKqRf8YA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CAkPG6YZNwvOjN0VmWh/HK7dwrPJxQa6cMGIO4D18lBSvkxwQuVaxWxo+guJLjyxqPEmQ95jMUm5HLvJPjv63gd25Ccmt9eR2MZAPRCMCCqDywU1Q0vw67hAISbbRuQb9AeCbGS/E7ScCjPxJiQigX7gPPzcXfQhkYOBz4b1d00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IQSeRvo1; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56845954ffeso164617a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 11:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711562947; x=1712167747; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xatJGVguCNf/WUAldulDt3r9Z4hc+wH++h2/GcCJG1M=;
        b=IQSeRvo1eBSzKzFYex3MseyWGcJs0O/1WZsFZyL95zbEBaelM1v7/BhkI1BOewY9My
         5U0OC+IOmTkc2nynCVhHoQk8KTEuKFn76za+CTTwjmLr4w2Sg/clbpEAYYQ7/uQ3qTbO
         iTZD7WfSkX1g+/KmC+TWNQ211YoL2+Q3bJASjmsouO/9mOvg7LmPuqwFRVEGnxY5+jJS
         xr9HFIkCqL5ZIMNp46sqx+B7ubl93IRang0QzVH0MwAGKt4YIyb3FbxIDHJpbfMYdzRs
         Spl3hdhSR3z8m0By9wB982cJwf0gZ+8cGj1ZOTUviBkez1uZR0Z4JGI8hPuwL1T1wtVo
         Foug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711562947; x=1712167747;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xatJGVguCNf/WUAldulDt3r9Z4hc+wH++h2/GcCJG1M=;
        b=DRVx3H8MfJyCJBugfT2EV4J6QO5btwEA/0mXnJCcbNBSPlVj+XdC8/pMzmEYB/HIps
         SYXyo4WAyAMKO+CBlVqbjwuW6/Az+qYPPENOR5k6vTI+QjxM256fNM6G1d8q/VBD2LrB
         tX25PItxG+fsuZNU62XDqvtyAW+kwaxY7tb605C2H1vmFCaPA5hlUA5eAbYj4zlGnp+E
         vDetBAJQbm8gT/J+5Q6Knkl9WwFbUn/lsrcR0yrJ0b+S2r/YlYVMA3IYx4qKYIElzbfY
         CZR+fkV7EcVVuTDQ0t/yZQscYP3ekiCJSOs+XY6fyFiRYBcIL3tzgCchZlegKNCpZ+Nk
         MDew==
X-Forwarded-Encrypted: i=1; AJvYcCVyxugQ575cR6EgzWA7/421+uYazoZTuDnmNQGdUiD6vHwEg6vOmFtiyBTPoxerVq2sxkaxk1pM7Wp9m5FwYIL9hrTv/hA1ZXkqu3Yq
X-Gm-Message-State: AOJu0YxctapmVHVK3WqLOazwTGjk9YLL7WBCI810jgaJ7k1ZDoDAHNXf
	+RQil9uzR7CcOd0RVa1NoMx+lj6t4T556K17h9PVIp3r1zAuRagdmaeYjzsicgc=
X-Google-Smtp-Source: AGHT+IFAyclNN4I78UIFoCD8VhQN0l5lMHm2AOnllf/HSvhKhjLhbnYt1UmK73zhkGkPB9pWxrnOOg==
X-Received: by 2002:a17:906:b03:b0:a47:5182:3b83 with SMTP id u3-20020a1709060b0300b00a4751823b83mr130341ejg.61.1711562946738;
        Wed, 27 Mar 2024 11:09:06 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id z2-20020a1709060be200b00a45f2dc6795sm5702733ejg.137.2024.03.27.11.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 11:09:06 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 27 Mar 2024 19:08:49 +0100
Subject: [PATCH v3 11/19] media: venus: core: Remove cp_start
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-topic-mars-v3-11-79f23b81c261@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711562924; l=3292;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=EiXe27maCyYzrjrt5IwhfaloukG1N+cTVNcHKqRf8YA=;
 b=mlD7n7YL3SQ+J38D0yoA6/DN8bT8LEhucyYAIAhEcUu1SKn0/Dh66xVzbhel9RerNwXf7vQox
 rtRJypTfSF5CfgVhLlrzMetiYkAsZvAESASyHRuo7M1YcGTavpdwPSQ
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

It's hardcoded to be zero. Always. Ever since msm-3.10. Or maybe
even before. Remove it!

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c     | 4 ----
 drivers/media/platform/qcom/venus/core.h     | 1 -
 drivers/media/platform/qcom/venus/firmware.c | 3 +--
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 5d41ecddcef6..b10d083b8b17 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -647,7 +647,6 @@ static const struct venus_resources sdm660_res = {
 	.vcodec_clks_num = 1,
 	.max_load = 1036800,
 	.hfi_version = HFI_VERSION_3XX,
-	.cp_start = 0,
 	.cp_size = 0x79000000,
 	.cp_nonpixel_start = 0x1000000,
 	.cp_nonpixel_size = 0x28000000,
@@ -716,7 +715,6 @@ static const struct venus_resources sdm845_res_v2 = {
 	.hfi_version = HFI_VERSION_4XX,
 	.vpu_version = VPU_VERSION_AR50,
 	.dma_mask = GENMASK(31, 29) - 1,
-	.cp_start = 0,
 	.cp_size = 0x70800000,
 	.cp_nonpixel_start = 0x1000000,
 	.cp_nonpixel_size = 0x24800000,
@@ -760,7 +758,6 @@ static const struct venus_resources sc7180_res = {
 	.hfi_version = HFI_VERSION_4XX,
 	.vpu_version = VPU_VERSION_AR50,
 	.dma_mask = GENMASK(31, 29) - 1,
-	.cp_start = 0,
 	.cp_size = 0x70800000,
 	.cp_nonpixel_start = 0x1000000,
 	.cp_nonpixel_size = 0x24800000,
@@ -869,7 +866,6 @@ static const struct venus_resources sc7280_res = {
 	.vpu_version = VPU_VERSION_IRIS2_1,
 	.num_vpp_pipes = 1,
 	.dma_mask = GENMASK(31, 29) - 1,
-	.cp_start = 0,
 	.cp_size = 0x25800000,
 	.cp_nonpixel_start = 0x1000000,
 	.cp_nonpixel_size = 0x24800000,
diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index e083ebb3ab4b..19908f028441 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -80,7 +80,6 @@ struct venus_resources {
 	enum vpu_version vpu_version;
 	u8 num_vpp_pipes;
 	u32 max_load;
-	u32 cp_start;
 	u32 cp_size;
 	u32 cp_nonpixel_start;
 	u32 cp_nonpixel_size;
diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
index fe7da2b30482..16e578780be7 100644
--- a/drivers/media/platform/qcom/venus/firmware.c
+++ b/drivers/media/platform/qcom/venus/firmware.c
@@ -245,7 +245,6 @@ int venus_boot(struct venus_core *core)
 	if (core->use_tz && res->cp_size) {
 		/*
 		 * Clues for porting using downstream data:
-		 * cp_start = 0
 		 * cp_size = venus_ns/virtual-addr-pool[0] - yes, address and not size!
 		 *   This works, as the non-secure context bank is placed
 		 *   contiguously right after the Content Protection region.
@@ -253,7 +252,7 @@ int venus_boot(struct venus_core *core)
 		 * cp_nonpixel_start = venus_sec_non_pixel/virtual-addr-pool[0]
 		 * cp_nonpixel_size = venus_sec_non_pixel/virtual-addr-pool[1]
 		 */
-		ret = qcom_scm_mem_protect_video_var(res->cp_start,
+		ret = qcom_scm_mem_protect_video_var(0,
 						     res->cp_size,
 						     res->cp_nonpixel_start,
 						     res->cp_nonpixel_size);

-- 
2.44.0


