Return-Path: <linux-kernel+bounces-60007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D3D84FE77
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89FDA1C224DC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11824D5A6;
	Fri,  9 Feb 2024 21:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HMfMa83P"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163DD3FB3F
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 21:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707513020; cv=none; b=lbwEP4e+1yaDSSRQGAFzuMVKQL/J3sHn1QaknSO7QNZlqItQB4PBq0dO10Ky8XMCzHYl80swbhaBwhE54ItITfgPkX9S/SkI0VWEEoV++Fs9V18uGwlat/BuA7Sildy58HiW4+t0F07fIZw4kUPlai3MA2auZ4L4XUFsZxKktRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707513020; c=relaxed/simple;
	bh=vLhLhf+CEVi6B2XJaAnvAcQ3XwKGsnZUrFlDvOw21nc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l2TS9Tv6BPXGv6NUnCih0aA2ToNaG3/pIFYYcv9MEJwcTyFM0Gp+DWlSvN5PTZFXS72/93+GoqOxjE7w1Q4Uq/P2Au1kIDf3UpeyKQPFrW3lfnGVLoXl4judV4wf6u/GJmJW6TcZy9lSg8ZzrxoW78ppht2Rz7T5mLi2mSxxBJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HMfMa83P; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a37721e42feso187696066b.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 13:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707513016; x=1708117816; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PhSad/Mk1NEzaN/RVlCN4R2NZvu025BgZXc2rgwW6iI=;
        b=HMfMa83PYqMx0BIGZvxtcPRa5ZcMdQrK4+51LE50p8GJeX+Xj7AkJpOlqGpw/O/eeX
         Wiq4K3cmE1x8jIVSdBaVKJGmohCCwm6v0LyQ2cuZUmurEw5wL0k9kLCWUH/FlhUIlL4a
         Oe0QJ1GC9DWYjhCaQqeVnFVuB5FVNMeMruElscBnitO6q0HKeiqe80p+wG1ire8PQO6F
         3apRw/XohPR4HwOIM7PZ9apxUEFQ7j6XBLFtuVnNLhXFsc5UuNi5WhlxoQjroQLCNWn4
         5ySsoI3q3u8KRGhEmexsYRIDwKfWGDP9JYJOh8yCaDRd4OrA5Y1BGYYpaw3PURn5odAA
         59bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707513016; x=1708117816;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhSad/Mk1NEzaN/RVlCN4R2NZvu025BgZXc2rgwW6iI=;
        b=tG7C+5yW0RApAWgNB4FZtHC3Z3r8bCPgoRqKnRYRAMb25h7/w9HjzlKqW7W3IyuDur
         otTSo/xORO3BzD17+NH57Fd10lwJou5YJHvJRRKzg72a4qJm2S62HpPXt4xgHoX0VQdJ
         qt8Jm0pb0UT3JmFin/oadvlDmZkxwHFp2dRtGjORmhK7vSn08igJmM2RUCzz+TMgg33t
         kLYBCrKWLnMxbu79HXOUnz+SO+4D855LOpaOy+rEqZSrx/hzx75ITRSxuA7j3L0/0xku
         NBtflC9diTjsjSldWz7itwNuNBRZPQQWJi6FgLCQaGBfY/Pp26MfaUpKYb2Hd2n3cAVi
         aEDA==
X-Gm-Message-State: AOJu0YzhymQOOi6qXfoRBTrc0LxKZw5HICqwsZuZj5CHguPJVt6fe8vV
	daXdbV8oGqYhc9NKnQ44249Wpn993fbWdCWcuka3hVQsCDsVOOoqGXyYqnDcD60=
X-Google-Smtp-Source: AGHT+IHaoS8E2Yl5Y2nX35dslDR7oR8kEXrrgQ46vjBSQOmcY4a0mCH6DnPtBaI5STRI55sWMXL+UQ==
X-Received: by 2002:a17:906:d979:b0:a38:e745:fb88 with SMTP id rp25-20020a170906d97900b00a38e745fb88mr142952ejb.57.1707513016407;
        Fri, 09 Feb 2024 13:10:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUNGBejFq5PDzl1+CvKgzrv2X7Us6V5508hFb6FLlOZsW5LQdlbQdebLY9R1CIA29+ENWvT09bsJOaA6W7AZY9WlQZUsUI1KEcQ8r/w2SrumlFFAsM7UYgLLJSD3NoCmm9e9WELz4FCNij85g8Cg6wCPl0/O26bZ0jGNZakACZ+DdVVMDlnMOkFOl1c5gF3Zv9yPmISvu2Y/tUdA5VnagLJiRIRD3qWDadkBr/fvOHcDpqWe/gIZHN9RlL6LjCuhYtzFKRmpt74Dy3Upu7504C6f++WlxsitfdAYEL6eDP8V2VMFVbOi7VhJOih0dvhTd1TrNHEIaW2jC82Htkzia4sn2zxJK2gR6RXdaKKJDfEMtSsKuVR+Dsba8XUZECnTwNmLANouP0ztzrz5TPFcTtD5DM7i1lzuocIkr3BH3aK9eHq2GKwrw1yTKRkEwVMV0j09mURrSxdNOEE3PdDGVzLKW196ZPO/oEyQmVMZFtEe/JKYB0kXWOUjKGqnM5J/KSKrg==
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id vo5-20020a170907a80500b00a3be3b27d0bsm1056517ejc.49.2024.02.09.13.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 13:10:15 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 09 Feb 2024 22:10:00 +0100
Subject: [PATCH v2 16/20] media: venus: pm_helpers: Simplify vcodec clock
 handling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-topic-mars-v2-16-3dac84b88c4b@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707512986; l=13452;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=vLhLhf+CEVi6B2XJaAnvAcQ3XwKGsnZUrFlDvOw21nc=;
 b=yhMc+HUWGyogB5zChvw1fSFjZ32bTQVH+w4auxc+uJf6IdWacMSVM3VvwjxoaKTVSEd7ZaVfJ
 giBWMyzn9ndDfdFOMGLfjjUnU86vMCSyjWD0yhXVsF/aRloJaE4DQT3
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Currently the infrastructure is set up for vast expandability, but
it's far too complex for what is just 0-2 clocks. Categorize the
clocks and simplify their getting.

One notable change is that vcodec clocks are switched to use
devm_clk_get_optional, which will let us commonize the code further
while leaving the burden of figuring out which SoCs need codec-specific
clocks and which don't to the bindings checker.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c       |  18 ----
 drivers/media/platform/qcom/venus/core.h       |   9 +-
 drivers/media/platform/qcom/venus/pm_helpers.c | 129 +++++++++++++------------
 3 files changed, 69 insertions(+), 87 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 70c3c9dc49c6..680674dd0d68 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -581,9 +581,6 @@ static const struct venus_resources msm8996_res = {
 	.reg_tbl_size = ARRAY_SIZE(msm8996_reg_preset),
 	.clks = {"core", "iface", "bus", "mbus" },
 	.clks_num = 4,
-	.vcodec0_clks = { "core" },
-	.vcodec1_clks = { "core" },
-	.vcodec_clks_num = 1,
 	.max_load = 2563200,
 	.hfi_version = HFI_VERSION_3XX,
 	.dma_mask = (GENMASK(31, 30) | GENMASK(28, 26) | GENMASK(24, 22)) - 1,
@@ -636,9 +633,6 @@ static const struct venus_resources sdm660_res = {
 	.bw_tbl_dec_size = ARRAY_SIZE(sdm660_bw_table_dec),
 	.clks = {"core", "iface", "bus", "bus_throttle" },
 	.clks_num = 4,
-	.vcodec0_clks = { "vcodec0_core" },
-	.vcodec1_clks = { "vcodec0_core" },
-	.vcodec_clks_num = 1,
 	.max_load = 1036800,
 	.hfi_version = HFI_VERSION_3XX,
 	.cp_size = 0x79000000,
@@ -680,9 +674,6 @@ static const struct venus_resources sdm845_res = {
 	.bw_tbl_dec_size = ARRAY_SIZE(sdm845_bw_table_dec),
 	.clks = {"core", "iface", "bus" },
 	.clks_num = 3,
-	.vcodec0_clks = { "core", "bus" },
-	.vcodec1_clks = { "core", "bus" },
-	.vcodec_clks_num = 2,
 	.max_load = 3110400,	/* 4096x2160@90 */
 	.hfi_version = HFI_VERSION_4XX,
 	.vpu_version = VPU_VERSION_AR50,
@@ -699,9 +690,6 @@ static const struct venus_resources sdm845_res_v2 = {
 	.bw_tbl_dec_size = ARRAY_SIZE(sdm845_bw_table_dec),
 	.clks = {"core", "iface", "bus" },
 	.clks_num = 3,
-	.vcodec0_clks = { "vcodec0_core", "vcodec0_bus" },
-	.vcodec1_clks = { "vcodec1_core", "vcodec1_bus" },
-	.vcodec_clks_num = 2,
 	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0", "vcodec1" },
 	.vcodec_pmdomains_num = 3,
 	.opp_pmdomain = pd_names_cx,
@@ -744,8 +732,6 @@ static const struct venus_resources sc7180_res = {
 	.bw_tbl_dec_size = ARRAY_SIZE(sc7180_bw_table_dec),
 	.clks = {"core", "iface", "bus" },
 	.clks_num = 3,
-	.vcodec0_clks = { "vcodec0_core", "vcodec0_bus" },
-	.vcodec_clks_num = 2,
 	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
 	.opp_pmdomain = pd_names_cx,
@@ -796,8 +782,6 @@ static const struct venus_resources sm8250_res = {
 	.clks_num = 2,
 	.resets = { "bus", "core" },
 	.resets_num = 2,
-	.vcodec0_clks = { "vcodec0_core" },
-	.vcodec_clks_num = 1,
 	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
 	.opp_pmdomain = pd_names_mx,
@@ -851,8 +835,6 @@ static const struct venus_resources sc7280_res = {
 	.ubwc_conf = &sc7280_ubwc_config,
 	.clks = {"core", "bus", "iface"},
 	.clks_num = 3,
-	.vcodec0_clks = {"vcodec_core", "vcodec_bus"},
-	.vcodec_clks_num = 2,
 	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
 	.opp_pmdomain = pd_names_cx,
diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 9dacf533c7ad..6ecaa3e38cac 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -24,9 +24,10 @@
 #define VDBGFW	"VenusFW  : "
 
 #define VIDC_CLKS_NUM_MAX		4
-#define VIDC_VCODEC_CLKS_NUM_MAX	2
 #define VIDC_RESETS_NUM_MAX		2
 
+#define MAX_NUM_VCODECS			2
+
 extern int venus_fw_debug;
 
 struct freq_tbl {
@@ -68,8 +69,6 @@ struct venus_resources {
 	const struct hfi_ubwc_config * const ubwc_conf;
 	const char * const clks[VIDC_CLKS_NUM_MAX];
 	const unsigned int clks_num;
-	const char * const vcodec0_clks[VIDC_VCODEC_CLKS_NUM_MAX];
-	const char * const vcodec1_clks[VIDC_VCODEC_CLKS_NUM_MAX];
 	const unsigned int vcodec_clks_num;
 	const char * const *vcodec_pmdomains;
 	const unsigned int vcodec_pmdomains_num;
@@ -176,8 +175,8 @@ struct venus_core {
 	void __iomem *aon_base;
 	int irq;
 	struct clk *clks[VIDC_CLKS_NUM_MAX];
-	struct clk *vcodec0_clks[VIDC_VCODEC_CLKS_NUM_MAX];
-	struct clk *vcodec1_clks[VIDC_VCODEC_CLKS_NUM_MAX];
+	struct clk *vcodec_core_clks[MAX_NUM_VCODECS];
+	struct clk *vcodec_bus_clks[MAX_NUM_VCODECS];
 	struct icc_path *video_path;
 	struct icc_path *cpucfg_path;
 	bool has_opp_table;
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index 32f9ccfa9d8a..a292c788ffba 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -110,67 +110,74 @@ static void core_clks_disable(struct venus_core *core)
 
 static int core_clks_set_rate(struct venus_core *core, unsigned long freq)
 {
-	int ret;
+	int i, ret;
 
 	ret = dev_pm_opp_set_rate(core->dev, freq);
 	if (ret)
 		return ret;
 
-	ret = clk_set_rate(core->vcodec0_clks[0], freq);
-	if (ret)
-		return ret;
-
-	ret = clk_set_rate(core->vcodec1_clks[0], freq);
-	if (ret)
-		return ret;
+	for (i = 0; i < MAX_NUM_VCODECS; i++) {
+		ret = clk_set_rate(core->vcodec_core_clks[i], freq);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
 
-static int vcodec_clks_get(struct venus_core *core, struct device *dev,
-			   struct clk **clks, const char * const *id)
+static int vcodec_clks_get(struct venus_core *core, struct device *dev, u8 id)
 {
-	const struct venus_resources *res = core->res;
-	unsigned int i;
+	char buf[13] = { 0 }; /* vcodecX_core\0 */
 
-	for (i = 0; i < res->vcodec_clks_num; i++) {
-		if (!id[i])
-			continue;
-		clks[i] = devm_clk_get(dev, id[i]);
-		if (IS_ERR(clks[i]))
-			return PTR_ERR(clks[i]);
+	/* Best we can do is 2 cores */
+	if (id > MAX_NUM_VCODECS - 1) {
+		dev_err(dev, "Got impossible vcodec id %u\n", id);
+		return -EINVAL;
+	};
+
+	snprintf(buf, sizeof(buf), "vcodec%u_core", id);
+
+	/* First try the non-legacy name */
+	core->vcodec_core_clks[id] = devm_clk_get_optional(dev, buf);
+	if (IS_ERR(core->vcodec_core_clks[id])) {
+		/* Try again, with the legacy name */
+		core->vcodec_core_clks[id] = devm_clk_get_optional(dev, "core");
+		if (IS_ERR(core->vcodec_core_clks[id]))
+			return PTR_ERR(core->vcodec_core_clks[id]);
+	}
+
+	memset(buf, 0, sizeof(buf));
+	snprintf(buf, sizeof(buf), "vcodec%u_bus", id);
+
+	core->vcodec_bus_clks[id] = devm_clk_get_optional(dev, buf);
+	if (IS_ERR(core->vcodec_bus_clks[id])) {
+		core->vcodec_bus_clks[id] = devm_clk_get_optional(dev, "bus");
+		if (IS_ERR(core->vcodec_bus_clks[id]))
+			return PTR_ERR(core->vcodec_bus_clks[id]);
 	}
 
 	return 0;
 }
 
-static int vcodec_clks_enable(struct venus_core *core, struct clk **clks)
+static int vcodec_clks_enable(struct venus_core *core, u8 id)
 {
-	const struct venus_resources *res = core->res;
-	unsigned int i;
 	int ret;
 
-	for (i = 0; i < res->vcodec_clks_num; i++) {
-		ret = clk_prepare_enable(clks[i]);
-		if (ret)
-			goto err;
-	}
+	ret = clk_prepare_enable(core->vcodec_core_clks[id]);
+	if (ret)
+		return ret;
 
-	return 0;
-err:
-	while (i--)
-		clk_disable_unprepare(clks[i]);
+	ret = clk_prepare_enable(core->vcodec_bus_clks[id]);
+	if (ret)
+		clk_disable_unprepare(core->vcodec_core_clks[id]);
 
 	return ret;
 }
 
-static void vcodec_clks_disable(struct venus_core *core, struct clk **clks)
+static void vcodec_clks_disable(struct venus_core *core, u8 id)
 {
-	const struct venus_resources *res = core->res;
-	unsigned int i = res->vcodec_clks_num;
-
-	while (i--)
-		clk_disable_unprepare(clks[i]);
+	clk_disable_unprepare(core->vcodec_bus_clks[id]);
+	clk_disable_unprepare(core->vcodec_core_clks[id]);
 }
 
 static u32 load_per_instance(struct venus_inst *inst)
@@ -343,8 +350,7 @@ static int vdec_get_v3(struct device *dev)
 {
 	struct venus_core *core = dev_get_drvdata(dev);
 
-	return vcodec_clks_get(core, dev, core->vcodec0_clks,
-			       core->res->vcodec0_clks);
+	return vcodec_clks_get(core, dev, 0);
 }
 
 static int vdec_power_v3(struct device *dev, int on)
@@ -355,9 +361,9 @@ static int vdec_power_v3(struct device *dev, int on)
 	vcodec_control_v3(core, VIDC_SESSION_TYPE_DEC, true);
 
 	if (on == POWER_ON)
-		ret = vcodec_clks_enable(core, core->vcodec0_clks);
+		ret = vcodec_clks_enable(core, 0);
 	else
-		vcodec_clks_disable(core, core->vcodec0_clks);
+		vcodec_clks_disable(core, 0);
 
 	vcodec_control_v3(core, VIDC_SESSION_TYPE_DEC, false);
 
@@ -368,8 +374,7 @@ static int venc_get_v3(struct device *dev)
 {
 	struct venus_core *core = dev_get_drvdata(dev);
 
-	return vcodec_clks_get(core, dev, core->vcodec1_clks,
-			       core->res->vcodec1_clks);
+	return vcodec_clks_get(core, dev, 1);
 }
 
 static int venc_power_v3(struct device *dev, int on)
@@ -380,9 +385,9 @@ static int venc_power_v3(struct device *dev, int on)
 	vcodec_control_v3(core, VIDC_SESSION_TYPE_ENC, true);
 
 	if (on == POWER_ON)
-		ret = vcodec_clks_enable(core, core->vcodec1_clks);
+		ret = vcodec_clks_enable(core, 1);
 	else
-		vcodec_clks_disable(core, core->vcodec1_clks);
+		vcodec_clks_disable(core, 1);
 
 	vcodec_control_v3(core, VIDC_SESSION_TYPE_ENC, false);
 
@@ -441,7 +446,7 @@ static int poweroff_coreid(struct venus_core *core, unsigned int coreid_mask)
 		if (ret)
 			return ret;
 
-		vcodec_clks_disable(core, core->vcodec0_clks);
+		vcodec_clks_disable(core, 0);
 
 		ret = vcodec_control_v4(core, VIDC_CORE_ID_1, false);
 		if (ret)
@@ -457,7 +462,7 @@ static int poweroff_coreid(struct venus_core *core, unsigned int coreid_mask)
 		if (ret)
 			return ret;
 
-		vcodec_clks_disable(core, core->vcodec1_clks);
+		vcodec_clks_disable(core, 1);
 
 		ret = vcodec_control_v4(core, VIDC_CORE_ID_2, false);
 		if (ret)
@@ -484,7 +489,7 @@ static int poweron_coreid(struct venus_core *core, unsigned int coreid_mask)
 		if (ret)
 			return ret;
 
-		ret = vcodec_clks_enable(core, core->vcodec0_clks);
+		ret = vcodec_clks_enable(core, 0);
 		if (ret)
 			return ret;
 
@@ -502,7 +507,7 @@ static int poweron_coreid(struct venus_core *core, unsigned int coreid_mask)
 		if (ret)
 			return ret;
 
-		ret = vcodec_clks_enable(core, core->vcodec1_clks);
+		ret = vcodec_clks_enable(core, 1);
 		if (ret)
 			return ret;
 
@@ -763,20 +768,18 @@ static int vdec_get_v4(struct device *dev)
 	if (!legacy_binding)
 		return 0;
 
-	return vcodec_clks_get(core, dev, core->vcodec0_clks,
-			       core->res->vcodec0_clks);
+	return vcodec_clks_get(core, dev, 0);
 }
 
 static void vdec_put_v4(struct device *dev)
 {
 	struct venus_core *core = dev_get_drvdata(dev);
-	unsigned int i;
 
 	if (!legacy_binding)
 		return;
 
-	for (i = 0; i < core->res->vcodec_clks_num; i++)
-		core->vcodec0_clks[i] = NULL;
+	core->vcodec_core_clks[0] = NULL;
+	core->vcodec_bus_clks[0] = NULL;
 }
 
 static int vdec_power_v4(struct device *dev, int on)
@@ -792,9 +795,9 @@ static int vdec_power_v4(struct device *dev, int on)
 		return ret;
 
 	if (on == POWER_ON)
-		ret = vcodec_clks_enable(core, core->vcodec0_clks);
+		ret = vcodec_clks_enable(core, 0);
 	else
-		vcodec_clks_disable(core, core->vcodec0_clks);
+		vcodec_clks_disable(core, 0);
 
 	vcodec_control_v4(core, VIDC_CORE_ID_1, false);
 
@@ -808,20 +811,18 @@ static int venc_get_v4(struct device *dev)
 	if (!legacy_binding)
 		return 0;
 
-	return vcodec_clks_get(core, dev, core->vcodec1_clks,
-			       core->res->vcodec1_clks);
+	return vcodec_clks_get(core, dev, 1);
 }
 
 static void venc_put_v4(struct device *dev)
 {
 	struct venus_core *core = dev_get_drvdata(dev);
-	unsigned int i;
 
 	if (!legacy_binding)
 		return;
 
-	for (i = 0; i < core->res->vcodec_clks_num; i++)
-		core->vcodec1_clks[i] = NULL;
+	core->vcodec_core_clks[1] = NULL;
+	core->vcodec_bus_clks[1] = NULL;
 }
 
 static int venc_power_v4(struct device *dev, int on)
@@ -837,9 +838,9 @@ static int venc_power_v4(struct device *dev, int on)
 		return ret;
 
 	if (on == POWER_ON)
-		ret = vcodec_clks_enable(core, core->vcodec1_clks);
+		ret = vcodec_clks_enable(core, 1);
 	else
-		vcodec_clks_disable(core, core->vcodec1_clks);
+		vcodec_clks_disable(core, 1);
 
 	vcodec_control_v4(core, VIDC_CORE_ID_2, false);
 
@@ -934,11 +935,11 @@ static int core_get_v4(struct venus_core *core)
 
 	dev_info(dev, "%s legacy binding\n", legacy_binding ? "" : "non");
 
-	ret = vcodec_clks_get(core, dev, core->vcodec0_clks, res->vcodec0_clks);
+	ret = vcodec_clks_get(core, dev, 0);
 	if (ret)
 		return ret;
 
-	ret = vcodec_clks_get(core, dev, core->vcodec1_clks, res->vcodec1_clks);
+	ret = vcodec_clks_get(core, dev, 1);
 	if (ret)
 		return ret;
 

-- 
2.43.0


