Return-Path: <linux-kernel+bounces-18036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60596825791
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AA002852A6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E898A35F0B;
	Fri,  5 Jan 2024 16:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XAE5DJyC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E1F2E84C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 16:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e5a9bcec9so2191750e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 08:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704470491; x=1705075291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfaPY3yQfoH2pfubd1hE0qyxl2OsnhSkHMvbF5d+3SA=;
        b=XAE5DJyC9E+rrEowooFFOx7nmKW2PremJaCQKWX0YZTMThEkbcEmUFklJMJrSs23Kz
         pAlme/dL4ExxbkIE3Tu2ccjY6YbF6kIPT2M08D+H0v+AMu8m5NO1I09KqcppYWcKLJSr
         +litKAuEFX3ZOfHFZjJSVB2XiEKUR2YbJhI616L8XXRClWeeltKb5h1c9+6ptn/VWT5a
         eYeEgavlR7J6GmeAGe/C+KSkqMnMZEKSCfupHXbOrtUhmBBOu+HeQuT8x6gL066bnzmI
         jKnGhP0qRer7gTi0hW+bxbnWjfQelXcLh9BghvMLg48vEynzeqekUjIe43/QfCddgjHF
         3y9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704470491; x=1705075291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hfaPY3yQfoH2pfubd1hE0qyxl2OsnhSkHMvbF5d+3SA=;
        b=kxjWa079BgJPQ+MjekSSk8Uf7Ca9V7IRL6/G0F8XZdW+BNpmXCBYuybFYbkgU76oCp
         spLlWfWj+7MVjyCV5dQ43x3tim0BocqwGolqVbEf8y/Zy+ZTHbNN+8yqqXYbSriyNHQe
         pxTqaKy2srOo5KA9b2wtgz8e4vDKG6KlvlWETwyWF6cSLtSTma2Q4nVIMflfd885zAWB
         xN0pzBOIITneC2ft5ychuhfPda6s5lnpSQEfTIEDrGhliAQrbXGoPCJDR2RsBsSb6BrO
         7qoX2LAw2qqQkE4j9RgB8hSQhZejkAvzKObg+XOvzZabRxC0ItDsATuYlrJWEAoKPv18
         h1hw==
X-Gm-Message-State: AOJu0YxQ8NljRT37jo3AcuZ8AxaGHHXkA46OHD+TdJntjKLF+WYPx+lN
	Y/J3/FdM57h+uHrEJd4RZuqjjYPEyPyqLaYOLft2ALTCqA8=
X-Google-Smtp-Source: AGHT+IERdn5J2WMksCV2xwOZSB4UlNaSC9hjgX2okCC+u7HZvOM32yjjwGik6ASHsLufYsrr/E57Ww==
X-Received: by 2002:ac2:46e1:0:b0:50e:80d3:4fd4 with SMTP id q1-20020ac246e1000000b0050e80d34fd4mr1191950lfo.51.1704470490597;
        Fri, 05 Jan 2024 08:01:30 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id n5-20020a056512310500b0050e76978861sm262094lfb.277.2024.01.05.08.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 08:01:23 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Kevin Hilman <khilman@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Ben Horgan <Ben.Horgan@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-remoteproc@vger.kernel.org,
	linux-media@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Subject: [PATCH v2 5/5] media: venus: Convert to dev_pm_domain_attach|detach_list() for vcodec
Date: Fri,  5 Jan 2024 17:01:03 +0100
Message-Id: <20240105160103.183092-6-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240105160103.183092-1-ulf.hansson@linaro.org>
References: <20240105160103.183092-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's avoid some of the boilerplate code to manage the vcodec PM domains,
by converting into using dev_pm_domain_attach|detach_list().

Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
Cc: Vikash Garodia <quic_vgarodia@quicinc.com>
Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: <linux-media@vger.kernel.org>
Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Added tags Bryan's tags.

---
 drivers/media/platform/qcom/venus/core.c      | 12 +++--
 drivers/media/platform/qcom/venus/core.h      |  7 ++-
 .../media/platform/qcom/venus/pm_helpers.c    | 48 +++++++------------
 3 files changed, 26 insertions(+), 41 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 9cffe975581b..bd9b474280e4 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -16,6 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <media/videobuf2-v4l2.h>
 #include <media/v4l2-mem2mem.h>
@@ -114,7 +115,8 @@ static void venus_sys_error_handler(struct work_struct *work)
 	pm_runtime_put_sync(core->dev);
 
 	for (i = 0; i < max_attempts; i++) {
-		if (!core->pmdomains[0] || !pm_runtime_active(core->pmdomains[0]))
+		if (!core->pmdomains ||
+		    !pm_runtime_active(core->pmdomains->pd_devs[0]))
 			break;
 		usleep_range(1000, 1500);
 	}
@@ -705,7 +707,7 @@ static const struct venus_resources sdm845_res_v2 = {
 	.vcodec0_clks = { "vcodec0_core", "vcodec0_bus" },
 	.vcodec1_clks = { "vcodec1_core", "vcodec1_bus" },
 	.vcodec_clks_num = 2,
-	.vcodec_pmdomains = { "venus", "vcodec0", "vcodec1" },
+	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0", "vcodec1" },
 	.vcodec_pmdomains_num = 3,
 	.opp_pmdomain = (const char *[]) { "cx", NULL },
 	.vcodec_num = 2,
@@ -754,7 +756,7 @@ static const struct venus_resources sc7180_res = {
 	.clks_num = 3,
 	.vcodec0_clks = { "vcodec0_core", "vcodec0_bus" },
 	.vcodec_clks_num = 2,
-	.vcodec_pmdomains = { "venus", "vcodec0" },
+	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
 	.opp_pmdomain = (const char *[]) { "cx", NULL },
 	.vcodec_num = 1,
@@ -811,7 +813,7 @@ static const struct venus_resources sm8250_res = {
 	.resets_num = 2,
 	.vcodec0_clks = { "vcodec0_core" },
 	.vcodec_clks_num = 1,
-	.vcodec_pmdomains = { "venus", "vcodec0" },
+	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
 	.opp_pmdomain = (const char *[]) { "mx", NULL },
 	.vcodec_num = 1,
@@ -870,7 +872,7 @@ static const struct venus_resources sc7280_res = {
 	.clks_num = 3,
 	.vcodec0_clks = {"vcodec_core", "vcodec_bus"},
 	.vcodec_clks_num = 2,
-	.vcodec_pmdomains = { "venus", "vcodec0" },
+	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
 	.opp_pmdomain = (const char *[]) { "cx", NULL },
 	.vcodec_num = 1,
diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 4a633261ece4..7ef341bf21cc 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -25,7 +25,6 @@
 
 #define VIDC_CLKS_NUM_MAX		4
 #define VIDC_VCODEC_CLKS_NUM_MAX	2
-#define VIDC_PMDOMAINS_NUM_MAX		3
 #define VIDC_RESETS_NUM_MAX		2
 
 extern int venus_fw_debug;
@@ -72,7 +71,7 @@ struct venus_resources {
 	const char * const vcodec0_clks[VIDC_VCODEC_CLKS_NUM_MAX];
 	const char * const vcodec1_clks[VIDC_VCODEC_CLKS_NUM_MAX];
 	unsigned int vcodec_clks_num;
-	const char * const vcodec_pmdomains[VIDC_PMDOMAINS_NUM_MAX];
+	const char **vcodec_pmdomains;
 	unsigned int vcodec_pmdomains_num;
 	const char **opp_pmdomain;
 	unsigned int vcodec_num;
@@ -134,7 +133,7 @@ struct venus_format {
  * @video_path: an interconnect handle to video to/from memory path
  * @cpucfg_path: an interconnect handle to cpu configuration path
  * @has_opp_table: does OPP table exist
- * @pmdomains:	an array of pmdomains struct device pointers
+ * @pmdomains:	a pointer to a list of pmdomains
  * @opp_dl_venus: an device-link for device OPP
  * @opp_pmdomain: an OPP power-domain
  * @resets: an array of reset signals
@@ -187,7 +186,7 @@ struct venus_core {
 	struct icc_path *video_path;
 	struct icc_path *cpucfg_path;
 	bool has_opp_table;
-	struct device *pmdomains[VIDC_PMDOMAINS_NUM_MAX];
+	struct dev_pm_domain_list *pmdomains;
 	struct device_link *opp_dl_venus;
 	struct device *opp_pmdomain;
 	struct reset_control *resets[VIDC_RESETS_NUM_MAX];
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index a1b127caa90a..502822059498 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -455,7 +455,7 @@ static int poweroff_coreid(struct venus_core *core, unsigned int coreid_mask)
 		if (ret)
 			return ret;
 
-		ret = pm_runtime_put_sync(core->pmdomains[1]);
+		ret = pm_runtime_put_sync(core->pmdomains->pd_devs[1]);
 		if (ret < 0)
 			return ret;
 	}
@@ -471,7 +471,7 @@ static int poweroff_coreid(struct venus_core *core, unsigned int coreid_mask)
 		if (ret)
 			return ret;
 
-		ret = pm_runtime_put_sync(core->pmdomains[2]);
+		ret = pm_runtime_put_sync(core->pmdomains->pd_devs[2]);
 		if (ret < 0)
 			return ret;
 	}
@@ -484,7 +484,7 @@ static int poweron_coreid(struct venus_core *core, unsigned int coreid_mask)
 	int ret;
 
 	if (coreid_mask & VIDC_CORE_ID_1) {
-		ret = pm_runtime_get_sync(core->pmdomains[1]);
+		ret = pm_runtime_get_sync(core->pmdomains->pd_devs[1]);
 		if (ret < 0)
 			return ret;
 
@@ -502,7 +502,7 @@ static int poweron_coreid(struct venus_core *core, unsigned int coreid_mask)
 	}
 
 	if (coreid_mask & VIDC_CORE_ID_2) {
-		ret = pm_runtime_get_sync(core->pmdomains[2]);
+		ret = pm_runtime_get_sync(core->pmdomains->pd_devs[2]);
 		if (ret < 0)
 			return ret;
 
@@ -860,19 +860,18 @@ static int vcodec_domains_get(struct venus_core *core)
 	struct device **opp_virt_dev;
 	struct device *dev = core->dev;
 	const struct venus_resources *res = core->res;
-	struct device *pd;
-	unsigned int i;
+	struct dev_pm_domain_attach_data vcodec_data = {
+		.pd_names = res->vcodec_pmdomains,
+		.num_pd_names = res->vcodec_pmdomains_num,
+		.pd_flags = PD_FLAG_NO_DEV_LINK,
+	};
 
 	if (!res->vcodec_pmdomains_num)
 		goto skip_pmdomains;
 
-	for (i = 0; i < res->vcodec_pmdomains_num; i++) {
-		pd = dev_pm_domain_attach_by_name(dev,
-						  res->vcodec_pmdomains[i]);
-		if (IS_ERR_OR_NULL(pd))
-			return pd ? PTR_ERR(pd) : -ENODATA;
-		core->pmdomains[i] = pd;
-	}
+	ret = dev_pm_domain_attach_list(dev, &vcodec_data, &core->pmdomains);
+	if (ret < 0)
+		return ret;
 
 skip_pmdomains:
 	if (!core->res->opp_pmdomain)
@@ -896,30 +895,14 @@ static int vcodec_domains_get(struct venus_core *core)
 	return 0;
 
 opp_attach_err:
-	for (i = 0; i < res->vcodec_pmdomains_num; i++) {
-		if (IS_ERR_OR_NULL(core->pmdomains[i]))
-			continue;
-		dev_pm_domain_detach(core->pmdomains[i], true);
-	}
-
+	dev_pm_domain_detach_list(core->pmdomains);
 	return ret;
 }
 
 static void vcodec_domains_put(struct venus_core *core)
 {
-	const struct venus_resources *res = core->res;
-	unsigned int i;
+	dev_pm_domain_detach_list(core->pmdomains);
 
-	if (!res->vcodec_pmdomains_num)
-		goto skip_pmdomains;
-
-	for (i = 0; i < res->vcodec_pmdomains_num; i++) {
-		if (IS_ERR_OR_NULL(core->pmdomains[i]))
-			continue;
-		dev_pm_domain_detach(core->pmdomains[i], true);
-	}
-
-skip_pmdomains:
 	if (!core->has_opp_table)
 		return;
 
@@ -1035,7 +1018,8 @@ static void core_put_v4(struct venus_core *core)
 static int core_power_v4(struct venus_core *core, int on)
 {
 	struct device *dev = core->dev;
-	struct device *pmctrl = core->pmdomains[0];
+	struct device *pmctrl = core->pmdomains ?
+			core->pmdomains->pd_devs[0] : NULL;
 	int ret = 0;
 
 	if (on == POWER_ON) {
-- 
2.34.1


