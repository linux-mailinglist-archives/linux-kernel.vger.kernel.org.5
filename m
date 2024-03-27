Return-Path: <linux-kernel+bounces-121801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0253088EDE4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 705641F3B6D7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8150154436;
	Wed, 27 Mar 2024 18:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SW8ayQp9"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC64153BD8
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 18:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711562960; cv=none; b=aCqyYl5gxgodJbPed0Ztsbm9MNCbR//JJHhNGUA1RwHKkKEcYiOlsh+qd37OaUeityWBCnh/Ne8sioDIN4bY8ovbO+9v31C2WiQpj9pN2V7pXQAf0z9JF0eSpUckDvclgty5r9LKjpgssqdd2QyUBZ5um9yU48QfFuxhqW+Psnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711562960; c=relaxed/simple;
	bh=afMiBrFoHhRzer2cqmqFzs4ZW0H+P1izDB/I0qvx+go=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GdNRQzqtFDfjCaCoxW1sUPhjWKNIep0Jto/QJDp0v8c57LxvvcMH+6K2obQP8LR6kdcAoDyzo3wXw/1ZiMKO1Tmwd/R6ADKgmn0DHpYX+IvCmN2VZBwi30QVhjKvlefSkC+46YVGAbYT//ZX7PJf9HuQnxECKN7UzL2/1K0B94g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SW8ayQp9; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-515b69e8f38so22369e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 11:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711562955; x=1712167755; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+IVHgSW/xaGi23QYFJtUQH6kBo9HwGpw1RMo77ssnFg=;
        b=SW8ayQp9tmrVYA29AH8aaduQqMwdWgGWMsouNailI6YeDRnnC8cPzjWpp/6dBtJfXX
         fWXZE0ihNoqkhGq49d5quiuNskHX9gWsgw6i+b6SpHOVONPpsezuzi82TE/9ZdtPMBVQ
         IBOoBF7GsjVFVcpQLArk4VgZXTkFt2LJ0aeoV20MjmqGvUlQaZygv3aIsPlpFkvOtnsu
         k2w9TRDKFQk+81NU7+7NHZ1mmA8lcSzxNurjl652ZKmb0zlg5SdmaBI8T3ho9iSh+KPW
         juKKNKhGlOhXvm+WICvnkTNHk20IvlHfs8ska2l/EbRDNPSvvBFaqBAQn5SQ6zhYRtAW
         iClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711562955; x=1712167755;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+IVHgSW/xaGi23QYFJtUQH6kBo9HwGpw1RMo77ssnFg=;
        b=qJSEXq6QR1KCprQpM5FyPBSPl1qnCHJgttkbfygJrO7jRfpV+/KHtNk1PmACkTWgh1
         w+SKYgiOauymXCMdAzC+TBuHADRK8u3KeCl7xzuJgm49pO0NvAh61w6v6nbAsm/b9uN1
         IvscTDs1z4lWDfvob/9qKTr2+XCofA2FShwzvnzLHqmFgbBUN9Yc/sdR1Ss9z0KSkI52
         Zh6FCkehFbKIKAg1WrDWpx5CGhdiS5K/x0nTM7kZdf3lzhlgwuqjcrwGXBq6LWNBS7QJ
         cbdRH0/LaIARYdOeowwXjC8Tgm1pSP11jlcvxX+P2EG/QhCXrpcHOX6UqGXqsrGwjQJT
         fjkw==
X-Forwarded-Encrypted: i=1; AJvYcCU3jIZuiF48+lzAAEfZDI/gdv5GiELIXh9LCrG2AhDPn40i9fPlMsvK3NAzHp5NlcJOKtIMHw8s1afA9tXdpKMT+svG30I3Nd36YnGw
X-Gm-Message-State: AOJu0YzTQG+DGFqFRLDVWaoK+RP5g65QeMwqDf9jY1WJvIEq0wDiky2d
	7g6H7PB7m4YEZkpGL262UeeTlz183V/5D3pO1DAuh7v0dP7ZwoCT6AzVs5FQuqk=
X-Google-Smtp-Source: AGHT+IGWhgiKUOdcrvmm8dwp1JWqillWx9nhvam2rmFbhmWYMBwh4DC45tz760zHnjGHGPWkIoZAgA==
X-Received: by 2002:ac2:5b0c:0:b0:513:c593:a634 with SMTP id v12-20020ac25b0c000000b00513c593a634mr171919lfn.6.1711562955383;
        Wed, 27 Mar 2024 11:09:15 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id z2-20020a1709060be200b00a45f2dc6795sm5702733ejg.137.2024.03.27.11.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 11:09:14 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 27 Mar 2024 19:08:53 +0100
Subject: [PATCH v3 15/19] media: venus: pm_helpers: Simplify vcodec clock
 handling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-topic-mars-v3-15-79f23b81c261@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711562924; l=13981;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=afMiBrFoHhRzer2cqmqFzs4ZW0H+P1izDB/I0qvx+go=;
 b=DL6uk51sRVqRvs/kCIzEnj6XcH/3HNCesxKFi0Bld1sSHdQ+HCYGYwjdglU2ECFgHYNmxbdtP
 5/flOoziTmsCEsi6PKUTHZesB/TupkfohJuFrO04dq+ogk6Qf/VBk8z
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
 drivers/media/platform/qcom/venus/core.h       |  13 ++-
 drivers/media/platform/qcom/venus/pm_helpers.c | 129 +++++++++++++------------
 3 files changed, 71 insertions(+), 89 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index e61aa863b7f7..1f4a86b1bd73 100644
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
index 19908f028441..b4c41dc0f8c7 100644
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
 	const struct hfi_ubwc_config *ubwc_conf;
 	const char * const clks[VIDC_CLKS_NUM_MAX];
 	unsigned int clks_num;
-	const char * const vcodec0_clks[VIDC_VCODEC_CLKS_NUM_MAX];
-	const char * const vcodec1_clks[VIDC_VCODEC_CLKS_NUM_MAX];
 	unsigned int vcodec_clks_num;
 	const char **vcodec_pmdomains;
 	unsigned int vcodec_pmdomains_num;
@@ -123,8 +122,8 @@ struct venus_format {
  * @aon_base:	AON base address
  * @irq:		Venus irq
  * @clks:	an array of struct clk pointers
- * @vcodec0_clks: an array of vcodec0 struct clk pointers
- * @vcodec1_clks: an array of vcodec1 struct clk pointers
+ * @vcodec_core_clks: an array of codec core clk pointers
+ * @vcodec_bus_clks: an array of codec bus clk pointers
  * @video_path: an interconnect handle to video to/from memory path
  * @cpucfg_path: an interconnect handle to cpu configuration path
  * @has_opp_table: does OPP table exist
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
index d717e150b34f..583153bbb74e 100644
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
2.44.0


