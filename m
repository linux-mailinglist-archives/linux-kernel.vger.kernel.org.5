Return-Path: <linux-kernel+bounces-15407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D6D822B99
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 650961C228F3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F2B18C24;
	Wed,  3 Jan 2024 10:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xjai7+k5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4355918C19
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 10:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d3f29fea66so41650805ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 02:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704278904; x=1704883704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pdPU059J9ZVWznV8an692mayob38PCXn1K2je3VxOtQ=;
        b=Xjai7+k5VtQKzf7LA/eVAKNTdK5PaEGp+RJS0s8tEczECFIeq4sHN1bRTCyrNRSvTH
         HzjWUV8v3oP/MIgelm1Yc/mnDLqCouyguWsANLDhcd7a04K5TelP14m+dNGRGpSIDkrl
         xFUCt8fnOKBPEPrRHHBln4CjX1EGi/a/8Lknyayu1bVwqXU0ayNQPwQX2jEWd9GiZFai
         8YpEmYqmSoUFBAGj6ENaI3qq5i0MTwFxn1FbGLFdRO/iEM7RfzDkvFEgEELBJkUarbwn
         sHJteICa4PT1bmW3Hhgj7Mx+Ql4bmSDrRjsRlOUD3+06+tPK9e09jEcHVGCCDh//yyE/
         el6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704278904; x=1704883704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pdPU059J9ZVWznV8an692mayob38PCXn1K2je3VxOtQ=;
        b=RN8pUPWc2rtZu3g0/whDTavjNTyY2FYEfJkdTGWHTOJ0zuobY0TCcmEFlyin9Zz8Ts
         ahFly6BzpOzwxl/aUjfI3AwDbgyV34y38NqmI/1ilBGBJokUNA4wLdNtwJZDLPN2KoaN
         EyUGlXRzjZtJjif+c8Z2QMtYh7lIK+TgAPIZPmie9Btmw0kgl1PqUMeu0yvl8jtjXFp6
         MsMJlBZRSWQ9jf1vURSag9W62iBdk8z9mOU/y5AmKFV6QbPNBvpmiWUqqNIa3jgXrqsC
         J4vifxB03QYNJfhE77CZbvTJQWPT1XVe7eN/RWWynHXToMJr3DlMDlLj5hVQbu6LrBG5
         7B9A==
X-Gm-Message-State: AOJu0YxJ0/wBnWArptWWrLETc4BEK36QJygxdrN2INXvg5HYA3hJuvh7
	g0GfUa9HtUfwHJ4iyS7HKz3QZWj7qsaZsA==
X-Google-Smtp-Source: AGHT+IGiwlRazKmwSv9SQEFS3/AG7SEW3FZuxDqnkmfBlfZ6Y+vxPON78qJPQ3mDacfO3RhGKwzv5g==
X-Received: by 2002:a17:902:da81:b0:1d4:c2ad:8ff8 with SMTP id j1-20020a170902da8100b001d4c2ad8ff8mr1891688plx.34.1704278904539;
        Wed, 03 Jan 2024 02:48:24 -0800 (PST)
Received: from localhost ([122.172.86.168])
        by smtp.gmail.com with ESMTPSA id z20-20020a170902ee1400b001d3a9676973sm23495578plb.111.2024.01.03.02.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 02:48:24 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dmitry Osipenko <digetx@gmail.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH] OPP: Remove the unused argument to config_clks_t
Date: Wed,  3 Jan 2024 16:18:18 +0530
Message-Id: <f24f32f1213b4b9e9ff2b4a36922f8d6e3abac51.1704278832.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The OPP core needs to take care of a special case, where the OPPs aren't
available for a device, but in order to keep the same unified interface
for the driver, the same OPP core API must take care of performing a
simple clk_set_rate() for the device.

This required the extra argument, but that is used only within the OPP
core and the drivers don't need to take care of that.

Simplify the external API and handle it differently within the OPP core.

This shouldn't result in any functional change.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
I will be taking this through the PM tree for the upcoming merge window.
Hopefully this won't create any issues for the ufs and devfreq driver as there
is no functional change for them.

 drivers/devfreq/tegra30-devfreq.c |  2 +-
 drivers/opp/core.c                | 37 +++++++++++++------------------
 drivers/ufs/core/ufshcd.c         |  3 +--
 include/linux/pm_opp.h            |  5 ++---
 include/ufs/ufshcd.h              |  3 +--
 5 files changed, 20 insertions(+), 30 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 4a4f0106ab9d..730c6618abc5 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -823,7 +823,7 @@ static int devm_tegra_devfreq_init_hw(struct device *dev,
 
 static int tegra_devfreq_config_clks_nop(struct device *dev,
 					 struct opp_table *opp_table,
-					 struct dev_pm_opp *opp, void *data,
+					 struct dev_pm_opp *opp,
 					 bool scaling_down)
 {
 	/* We want to skip clk configuration via dev_pm_opp_set_opp() */
diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 29f8160c3e38..ba5f692e2161 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -940,24 +940,11 @@ static int _set_opp_voltage(struct device *dev, struct regulator *reg,
 	return ret;
 }
 
-static int
-_opp_config_clk_single(struct device *dev, struct opp_table *opp_table,
-		       struct dev_pm_opp *opp, void *data, bool scaling_down)
+static int _opp_clk_set_rate(struct device *dev, struct opp_table *opp_table,
+			     unsigned long freq)
 {
-	unsigned long *target = data;
-	unsigned long freq;
 	int ret;
 
-	/* One of target and opp must be available */
-	if (target) {
-		freq = *target;
-	} else if (opp) {
-		freq = opp->rates[0];
-	} else {
-		WARN_ON(1);
-		return -EINVAL;
-	}
-
 	ret = clk_set_rate(opp_table->clk, freq);
 	if (ret) {
 		dev_err(dev, "%s: failed to set clock rate: %d\n", __func__,
@@ -969,12 +956,19 @@ _opp_config_clk_single(struct device *dev, struct opp_table *opp_table,
 	return ret;
 }
 
+static int
+_opp_config_clk_single(struct device *dev, struct opp_table *opp_table,
+		       struct dev_pm_opp *opp, bool scaling_down)
+{
+	return _opp_clk_set_rate(dev, opp_table, opp->rates[0]);
+}
+
 /*
  * Simple implementation for configuring multiple clocks. Configure clocks in
  * the order in which they are present in the array while scaling up.
  */
 int dev_pm_opp_config_clks_simple(struct device *dev,
-		struct opp_table *opp_table, struct dev_pm_opp *opp, void *data,
+		struct opp_table *opp_table, struct dev_pm_opp *opp,
 		bool scaling_down)
 {
 	int ret, i;
@@ -1183,7 +1177,7 @@ static int _disable_opp_table(struct device *dev, struct opp_table *opp_table)
 }
 
 static int _set_opp(struct device *dev, struct opp_table *opp_table,
-		    struct dev_pm_opp *opp, void *clk_data, bool forced)
+		    struct dev_pm_opp *opp, bool forced)
 {
 	struct dev_pm_opp *old_opp;
 	int scaling_down, ret;
@@ -1243,7 +1237,7 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 	}
 
 	if (opp_table->config_clks) {
-		ret = opp_table->config_clks(dev, opp_table, opp, clk_data, scaling_down);
+		ret = opp_table->config_clks(dev, opp_table, opp, scaling_down);
 		if (ret)
 			return ret;
 	}
@@ -1322,8 +1316,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		 * equivalent to a clk_set_rate()
 		 */
 		if (!_get_opp_count(opp_table)) {
-			ret = opp_table->config_clks(dev, opp_table, NULL,
-						     &target_freq, false);
+			ret = _opp_clk_set_rate(dev, opp_table, target_freq);
 			goto put_opp_table;
 		}
 
@@ -1355,7 +1348,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		forced = opp_table->rate_clk_single != target_freq;
 	}
 
-	ret = _set_opp(dev, opp_table, opp, &target_freq, forced);
+	ret = _set_opp(dev, opp_table, opp, forced);
 
 	if (target_freq)
 		dev_pm_opp_put(opp);
@@ -1387,7 +1380,7 @@ int dev_pm_opp_set_opp(struct device *dev, struct dev_pm_opp *opp)
 		return PTR_ERR(opp_table);
 	}
 
-	ret = _set_opp(dev, opp_table, opp, NULL, false);
+	ret = _set_opp(dev, opp_table, opp, false);
 	dev_pm_opp_put_opp_table(opp_table);
 
 	return ret;
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index bce0d2a9a7f3..51d6c8567189 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -1064,8 +1064,7 @@ static int ufshcd_set_clk_freq(struct ufs_hba *hba, bool scale_up)
 }
 
 int ufshcd_opp_config_clks(struct device *dev, struct opp_table *opp_table,
-			   struct dev_pm_opp *opp, void *data,
-			   bool scaling_down)
+			   struct dev_pm_opp *opp, bool scaling_down)
 {
 	struct ufs_hba *hba = dev_get_drvdata(dev);
 	struct list_head *head = &hba->clk_list_head;
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 76dcb7f37bcd..c99a66e88e78 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -50,7 +50,7 @@ typedef int (*config_regulators_t)(struct device *dev,
 			struct regulator **regulators, unsigned int count);
 
 typedef int (*config_clks_t)(struct device *dev, struct opp_table *opp_table,
-			struct dev_pm_opp *opp, void *data, bool scaling_down);
+			struct dev_pm_opp *opp, bool scaling_down);
 
 /**
  * struct dev_pm_opp_config - Device OPP configuration values
@@ -181,8 +181,7 @@ int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config);
 int devm_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config);
 void dev_pm_opp_clear_config(int token);
 int dev_pm_opp_config_clks_simple(struct device *dev,
-		struct opp_table *opp_table, struct dev_pm_opp *opp, void *data,
-		bool scaling_down);
+		struct opp_table *opp_table, struct dev_pm_opp *opp, bool scaling_down);
 
 struct dev_pm_opp *dev_pm_opp_xlate_required_opp(struct opp_table *src_table, struct opp_table *dst_table, struct dev_pm_opp *src_opp);
 int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 7f0b2c5599cd..156e47dd4d9c 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -1255,8 +1255,7 @@ void ufshcd_mcq_enable_esi(struct ufs_hba *hba);
 void ufshcd_mcq_config_esi(struct ufs_hba *hba, struct msi_msg *msg);
 
 int ufshcd_opp_config_clks(struct device *dev, struct opp_table *opp_table,
-			   struct dev_pm_opp *opp, void *data,
-			   bool scaling_down);
+			   struct dev_pm_opp *opp, bool scaling_down);
 /**
  * ufshcd_set_variant - set variant specific data to the hba
  * @hba: per adapter instance
-- 
2.31.1.272.g89b43f80a514


