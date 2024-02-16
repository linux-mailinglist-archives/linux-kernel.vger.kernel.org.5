Return-Path: <linux-kernel+bounces-68669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1DE857E14
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6729F1C2317D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F61612C520;
	Fri, 16 Feb 2024 13:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QtmKc6DS"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E0A12A17B
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 13:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708091562; cv=none; b=vAWx56BFRkr9jk//7NUHP9H8bEk+YO36QsbG+ZDrins0QQJD/bUbSYfac+Gmj95iK8BeVKYHMyOGArP7A7JVcE62ZTr7nxSYBW0ViGPznflv8aqg9L7F48EAmjG5DF16VszvInLPWnICxGoIZj7c/f4hqdIhxtA+MM+HHyWkpb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708091562; c=relaxed/simple;
	bh=U18PZqjdvhzFU+y+s3lRZJGCBUtUTBqRvhkQRJpwNeU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=j3UtVMzzBr2BdGdkFFnbR/pK34KEqXcBmJ0vVsyz0f53my3+vtpxok2KiOAfxK48zMgJ9p+NBH3lH6cHBLOKj4Td6ATc3oVqhciyjlJfIH452Kw/877sw5xsXOb0v08O01VoBTxk5xHg5Qyd8wg/xDvkbKppC0qzZmsdQOrL7Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QtmKc6DS; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3d484a58f6so262725466b.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 05:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708091559; x=1708696359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lBazITL+qaPVbPmEky37iu3PFdPc99DGZWQ9aWc4bq0=;
        b=QtmKc6DSi6Z7RfI0OulHP4RF7xvh1DUUW+WJXHOgXSWiLKZXa+XJkbb4y5Y7C4285B
         u9ZUmpy998J64DAnEIBUf2Dct1WvawZgimIspcwlFm1R0Or9VcD/rwOVDeA4uNnSmuUl
         SwaMI2pdmOAJY0FOOubf6NSPcM516bkRR8I/XtRtMAIZUFUUQKR6LTnF7S0V/ZwHwjw0
         pszdg+ozkj/0SZl0zLyXLKbB268abFLrB+Bumwei62dTjeuWeXutqCrOT3Lw32rGQOwU
         udR1Rg3m/Swzm9Tio5zArafZ5/fZnLaOffUPcjVK4W4R/pWSNiXAfqNJbxGRh52Guppd
         2tMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708091559; x=1708696359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lBazITL+qaPVbPmEky37iu3PFdPc99DGZWQ9aWc4bq0=;
        b=X/8uWROtZDnfV1iYBNRvT6BGU03k0n58vgAuI3cZDgXJeFo+R+v/+cQQlS37uzbPPu
         cxKmGK+9pD8kt3z0sqJsYYEuv1vyQMtrknokqwSwY6VHH88yY9trMkB5STuMBYAib/3H
         uwkqHF8xVWmblTRM7G+t/VBINsmkdAZH5d88FLuP8lbraozJDTODPovKYP1CJk3Trlf8
         0XtPciSDCsJ9uQ4x2iGH+EEBZcgOn6cKT/GUZtt+Jb+7nV9lTvtHuOypklnc3ksfpZzf
         iDpScKC9BMOA44qYs0Lpra2QqXEp9qY/uNd2SiLHpzfpQm1rq6RjEaUTUrv9RdI69c4y
         5/rw==
X-Forwarded-Encrypted: i=1; AJvYcCVJd3BUTmmzS4TyjQjS727E8wc6B/rxLOyLx+fpE/qmYGHY7WMPo33of3pUs+KyZLyz6wtcQo4XKn/xF2oD5wSpzSMbW3a4v4hy8sWY
X-Gm-Message-State: AOJu0Yzy9Cq5cSU+K7aYciEFGFFaN+SMlhPTCEPptiDwxqzWBPC4HNFe
	LW7heJnACmSj2SI/lQc4lzlG4U8PdsLs2+UtH5PaI/c4TeS9QgVL0v3yUVR1eYk=
X-Google-Smtp-Source: AGHT+IFohjUG2bOArE2umjuzP4rsM1O6C0LD/Y33lUNmFK3hmgI0Adq+5RzKrE1obHl/2imUjKpINA==
X-Received: by 2002:a17:906:7f96:b0:a3d:bb37:1a6a with SMTP id f22-20020a1709067f9600b00a3dbb371a6amr2217530ejr.45.1708091558768;
        Fri, 16 Feb 2024 05:52:38 -0800 (PST)
Received: from krzk-bin.. ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id l22-20020a170906079600b00a3d4b488970sm1569441ejc.45.2024.02.16.05.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 05:52:38 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Georgi Djakov <djakov@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	=?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH] interconnect: constify of_phandle_args in xlate
Date: Fri, 16 Feb 2024 14:52:36 +0100
Message-Id: <20240216135236.129878-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The xlate callbacks are supposed to translate of_phandle_args to proper
provider without modifying the of_phandle_args.  Make the argument
pointer to const for code safety and readability.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpio/gpiolib-of.c              |  2 +-
 drivers/interconnect/core.c            |  4 ++--
 drivers/interconnect/qcom/icc-common.c |  3 ++-
 drivers/interconnect/qcom/icc-common.h |  3 ++-
 drivers/interconnect/samsung/exynos.c  |  2 +-
 drivers/memory/tegra/mc.c              |  2 +-
 drivers/memory/tegra/tegra124-emc.c    |  2 +-
 drivers/memory/tegra/tegra124.c        |  2 +-
 drivers/memory/tegra/tegra186-emc.c    |  2 +-
 drivers/memory/tegra/tegra20-emc.c     |  2 +-
 drivers/memory/tegra/tegra20.c         |  2 +-
 drivers/memory/tegra/tegra30-emc.c     |  2 +-
 drivers/memory/tegra/tegra30.c         |  2 +-
 include/linux/interconnect-provider.h  | 11 ++++++-----
 include/soc/tegra/mc.h                 |  7 ++++---
 15 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 35d717fd393f..708b0d51f4b7 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -129,7 +129,7 @@ static int of_gpiochip_match_node_and_xlate(struct gpio_chip *chip,
 }
 
 static struct gpio_device *
-of_find_gpio_device_by_xlate(struct of_phandle_args *gpiospec)
+of_find_gpio_device_by_xlate(const struct of_phandle_args *gpiospec)
 {
 	return gpio_device_find(gpiospec, of_gpiochip_match_node_and_xlate);
 }
diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 50bac2d79d9b..5d1010cafed8 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -343,7 +343,7 @@ EXPORT_SYMBOL_GPL(icc_std_aggregate);
  * an array of icc nodes specified in the icc_onecell_data struct when
  * registering the provider.
  */
-struct icc_node *of_icc_xlate_onecell(struct of_phandle_args *spec,
+struct icc_node *of_icc_xlate_onecell(const struct of_phandle_args *spec,
 				      void *data)
 {
 	struct icc_onecell_data *icc_data = data;
@@ -368,7 +368,7 @@ EXPORT_SYMBOL_GPL(of_icc_xlate_onecell);
  * Returns a valid pointer to struct icc_node_data on success or ERR_PTR()
  * on failure.
  */
-struct icc_node_data *of_icc_get_from_provider(struct of_phandle_args *spec)
+struct icc_node_data *of_icc_get_from_provider(const struct of_phandle_args *spec)
 {
 	struct icc_node *node = ERR_PTR(-EPROBE_DEFER);
 	struct icc_node_data *data = NULL;
diff --git a/drivers/interconnect/qcom/icc-common.c b/drivers/interconnect/qcom/icc-common.c
index f27f4fdc4531..9b9ee113f172 100644
--- a/drivers/interconnect/qcom/icc-common.c
+++ b/drivers/interconnect/qcom/icc-common.c
@@ -9,7 +9,8 @@
 
 #include "icc-common.h"
 
-struct icc_node_data *qcom_icc_xlate_extended(struct of_phandle_args *spec, void *data)
+struct icc_node_data *qcom_icc_xlate_extended(const struct of_phandle_args *spec,
+					      void *data)
 {
 	struct icc_node_data *ndata;
 	struct icc_node *node;
diff --git a/drivers/interconnect/qcom/icc-common.h b/drivers/interconnect/qcom/icc-common.h
index 33bb2c38dff3..21c39b163948 100644
--- a/drivers/interconnect/qcom/icc-common.h
+++ b/drivers/interconnect/qcom/icc-common.h
@@ -8,6 +8,7 @@
 
 #include <linux/interconnect-provider.h>
 
-struct icc_node_data *qcom_icc_xlate_extended(struct of_phandle_args *spec, void *data);
+struct icc_node_data *qcom_icc_xlate_extended(const struct of_phandle_args *spec,
+					      void *data);
 
 #endif
diff --git a/drivers/interconnect/samsung/exynos.c b/drivers/interconnect/samsung/exynos.c
index 1ba14cb45d5a..c9e5361e17c5 100644
--- a/drivers/interconnect/samsung/exynos.c
+++ b/drivers/interconnect/samsung/exynos.c
@@ -82,7 +82,7 @@ static int exynos_generic_icc_set(struct icc_node *src, struct icc_node *dst)
 	return 0;
 }
 
-static struct icc_node *exynos_generic_icc_xlate(struct of_phandle_args *spec,
+static struct icc_node *exynos_generic_icc_xlate(const struct of_phandle_args *spec,
 						 void *data)
 {
 	struct exynos_icc_priv *priv = data;
diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index a083921a8968..224b488794e5 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -755,7 +755,7 @@ const char *const tegra_mc_error_names[8] = {
 	[6] = "SMMU translation error",
 };
 
-struct icc_node *tegra_mc_icc_xlate(struct of_phandle_args *spec, void *data)
+struct icc_node *tegra_mc_icc_xlate(const struct of_phandle_args *spec, void *data)
 {
 	struct tegra_mc *mc = icc_provider_to_tegra_mc(data);
 	struct icc_node *node;
diff --git a/drivers/memory/tegra/tegra124-emc.c b/drivers/memory/tegra/tegra124-emc.c
index 00ed2b6a0d1b..47c0c19e13fd 100644
--- a/drivers/memory/tegra/tegra124-emc.c
+++ b/drivers/memory/tegra/tegra124-emc.c
@@ -1285,7 +1285,7 @@ to_tegra_emc_provider(struct icc_provider *provider)
 }
 
 static struct icc_node_data *
-emc_of_icc_xlate_extended(struct of_phandle_args *spec, void *data)
+emc_of_icc_xlate_extended(const struct of_phandle_args *spec, void *data)
 {
 	struct icc_provider *provider = data;
 	struct icc_node_data *ndata;
diff --git a/drivers/memory/tegra/tegra124.c b/drivers/memory/tegra/tegra124.c
index 470b7dbab2c2..9d7393e19f12 100644
--- a/drivers/memory/tegra/tegra124.c
+++ b/drivers/memory/tegra/tegra124.c
@@ -1170,7 +1170,7 @@ static int tegra124_mc_icc_aggreate(struct icc_node *node, u32 tag, u32 avg_bw,
 }
 
 static struct icc_node_data *
-tegra124_mc_of_icc_xlate_extended(struct of_phandle_args *spec, void *data)
+tegra124_mc_of_icc_xlate_extended(const struct of_phandle_args *spec, void *data)
 {
 	struct tegra_mc *mc = icc_provider_to_tegra_mc(data);
 	const struct tegra_mc_client *client;
diff --git a/drivers/memory/tegra/tegra186-emc.c b/drivers/memory/tegra/tegra186-emc.c
index fcd4aea48bda..57d9ae12fcfe 100644
--- a/drivers/memory/tegra/tegra186-emc.c
+++ b/drivers/memory/tegra/tegra186-emc.c
@@ -236,7 +236,7 @@ static int tegra_emc_icc_set_bw(struct icc_node *src, struct icc_node *dst)
 }
 
 static struct icc_node *
-tegra_emc_of_icc_xlate(struct of_phandle_args *spec, void *data)
+tegra_emc_of_icc_xlate(const struct of_phandle_args *spec, void *data)
 {
 	struct icc_provider *provider = data;
 	struct icc_node *node;
diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index fd595c851a27..97cf59523b0b 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -950,7 +950,7 @@ to_tegra_emc_provider(struct icc_provider *provider)
 }
 
 static struct icc_node_data *
-emc_of_icc_xlate_extended(struct of_phandle_args *spec, void *data)
+emc_of_icc_xlate_extended(const struct of_phandle_args *spec, void *data)
 {
 	struct icc_provider *provider = data;
 	struct icc_node_data *ndata;
diff --git a/drivers/memory/tegra/tegra20.c b/drivers/memory/tegra/tegra20.c
index aa4b97d5e732..a3022e715dee 100644
--- a/drivers/memory/tegra/tegra20.c
+++ b/drivers/memory/tegra/tegra20.c
@@ -390,7 +390,7 @@ static int tegra20_mc_icc_aggreate(struct icc_node *node, u32 tag, u32 avg_bw,
 }
 
 static struct icc_node_data *
-tegra20_mc_of_icc_xlate_extended(struct of_phandle_args *spec, void *data)
+tegra20_mc_of_icc_xlate_extended(const struct of_phandle_args *spec, void *data)
 {
 	struct tegra_mc *mc = icc_provider_to_tegra_mc(data);
 	unsigned int i, idx = spec->args[0];
diff --git a/drivers/memory/tegra/tegra30-emc.c b/drivers/memory/tegra/tegra30-emc.c
index 9eae25c57ec6..d7b0a23c2d7d 100644
--- a/drivers/memory/tegra/tegra30-emc.c
+++ b/drivers/memory/tegra/tegra30-emc.c
@@ -1468,7 +1468,7 @@ to_tegra_emc_provider(struct icc_provider *provider)
 }
 
 static struct icc_node_data *
-emc_of_icc_xlate_extended(struct of_phandle_args *spec, void *data)
+emc_of_icc_xlate_extended(const struct of_phandle_args *spec, void *data)
 {
 	struct icc_provider *provider = data;
 	struct icc_node_data *ndata;
diff --git a/drivers/memory/tegra/tegra30.c b/drivers/memory/tegra/tegra30.c
index 06f8b35e0a14..d3e685c8431f 100644
--- a/drivers/memory/tegra/tegra30.c
+++ b/drivers/memory/tegra/tegra30.c
@@ -1332,7 +1332,7 @@ static int tegra30_mc_icc_aggreate(struct icc_node *node, u32 tag, u32 avg_bw,
 }
 
 static struct icc_node_data *
-tegra30_mc_of_icc_xlate_extended(struct of_phandle_args *spec, void *data)
+tegra30_mc_of_icc_xlate_extended(const struct of_phandle_args *spec, void *data)
 {
 	struct tegra_mc *mc = icc_provider_to_tegra_mc(data);
 	const struct tegra_mc_client *client;
diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
index 7ba183f221f1..f5aef8784692 100644
--- a/include/linux/interconnect-provider.h
+++ b/include/linux/interconnect-provider.h
@@ -36,7 +36,7 @@ struct icc_onecell_data {
 	struct icc_node *nodes[] __counted_by(num_nodes);
 };
 
-struct icc_node *of_icc_xlate_onecell(struct of_phandle_args *spec,
+struct icc_node *of_icc_xlate_onecell(const struct of_phandle_args *spec,
 				      void *data);
 
 /**
@@ -65,8 +65,9 @@ struct icc_provider {
 			 u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
 	void (*pre_aggregate)(struct icc_node *node);
 	int (*get_bw)(struct icc_node *node, u32 *avg, u32 *peak);
-	struct icc_node* (*xlate)(struct of_phandle_args *spec, void *data);
-	struct icc_node_data* (*xlate_extended)(struct of_phandle_args *spec, void *data);
+	struct icc_node* (*xlate)(const struct of_phandle_args *spec, void *data);
+	struct icc_node_data* (*xlate_extended)(const struct of_phandle_args *spec,
+						void *data);
 	struct device		*dev;
 	int			users;
 	bool			inter_set;
@@ -124,7 +125,7 @@ int icc_nodes_remove(struct icc_provider *provider);
 void icc_provider_init(struct icc_provider *provider);
 int icc_provider_register(struct icc_provider *provider);
 void icc_provider_deregister(struct icc_provider *provider);
-struct icc_node_data *of_icc_get_from_provider(struct of_phandle_args *spec);
+struct icc_node_data *of_icc_get_from_provider(const struct of_phandle_args *spec);
 void icc_sync_state(struct device *dev);
 
 #else
@@ -171,7 +172,7 @@ static inline int icc_provider_register(struct icc_provider *provider)
 
 static inline void icc_provider_deregister(struct icc_provider *provider) { }
 
-static inline struct icc_node_data *of_icc_get_from_provider(struct of_phandle_args *spec)
+static inline struct icc_node_data *of_icc_get_from_provider(const struct of_phandle_args *spec)
 {
 	return ERR_PTR(-ENOTSUPP);
 }
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index af1d73a7f0cd..6ee4c59db620 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -146,13 +146,14 @@ struct tegra_mc_icc_ops {
 	int (*set)(struct icc_node *src, struct icc_node *dst);
 	int (*aggregate)(struct icc_node *node, u32 tag, u32 avg_bw,
 			 u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
-	struct icc_node* (*xlate)(struct of_phandle_args *spec, void *data);
-	struct icc_node_data *(*xlate_extended)(struct of_phandle_args *spec,
+	struct icc_node* (*xlate)(const struct of_phandle_args *spec, void *data);
+	struct icc_node_data *(*xlate_extended)(const struct of_phandle_args *spec,
 						void *data);
 	int (*get_bw)(struct icc_node *node, u32 *avg, u32 *peak);
 };
 
-struct icc_node *tegra_mc_icc_xlate(struct of_phandle_args *spec, void *data);
+struct icc_node *tegra_mc_icc_xlate(const struct of_phandle_args *spec,
+				    void *data);
 extern const struct tegra_mc_icc_ops tegra_mc_icc_ops;
 
 struct tegra_mc_ops {
-- 
2.34.1


